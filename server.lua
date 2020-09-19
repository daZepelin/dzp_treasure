ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Boxes = {}

RegisterCommand('addbox', function(source, args)
    if IsPlayerAceAllowed(source, "acommands") then
        local items = {}
        local coords = {["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0}
        for i = 1, #args, 2 do
            if tonumber(args[i+1]) ~= nil then
                items[ args[i]] = tonumber(args[i+1])
            else
                items[ args[i]] = args[i+1]
            end
        end
        if source ~= -1 then
            local player = source
            local ped = GetPlayerPed(player)
            local playerCoords = GetEntityCoords(ped)
            coords["x"] = roundCoords(playerCoords.x)
            coords["y"] = roundCoords(playerCoords.y)
            coords["z"] = roundCoords(playerCoords.z)
        end
        addTreasureBox(coords, items)
        Citizen.Wait(2000)
        TriggerClientEvent('dzp_treasures:setBoxes', -1, Boxes)
    else
        print('permissions not allowed')
    end
end, false)

-- RegisterCommand('setboxes', function()
--     TriggerClientEvent('dzp_treasures:setBoxes', -1, Boxes)
-- end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM treasure_boxes', {}, 
    function(data)
        if data ~= '' then
            for i = 1, #data do
                local box = CreateTreasureBox(data[i].id, json.decode(data[i].coords), json.decode(data[i].contents))
                Boxes[data[i].id] = box
            end
        end
    end)
end)

AddEventHandler('onResourceStart', function(resource)
    Wait(2000)
    if GetCurrentResourceName() == resource then
        TriggerClientEvent('dzp_treasures:setBoxes', -1, Boxes)
    end
end)

RegisterNetEvent('dzp_treasure:getBoxes')
AddEventHandler('dzp_treasure:getBoxes', function()
    TriggerClientEvent('dzp_treasures:setBoxes', source, Boxes)  
end)

RegisterNetEvent('dzp_treasure:lootTreasureBox')
AddEventHandler('dzp_treasure:lootTreasureBox', function(boxId, plate)
    local _source = source
    local box = Boxes[boxId]
    box.lootBox(_source, plate)
    TriggerClientEvent('dzp_treasures:setBoxes', -1, Boxes)
end)

function addTreasureBox(coords, contents)
    MySQL.Async.insert('INSERT INTO treasure_boxes (coords, contents) VALUES (@coords, @contents)', {
        ['coords'] = json.encode(coords),
        ['contents'] = json.encode(contents)
    }, function(insertId)
        local box = CreateTreasureBox(insertId, coords, contents)
        Boxes[insertId] = box
    end)
end

function deleteTreasureBox(boxId)
    MySQL.Async.execute('DELETE FROM treasure_boxes WHERE id = @id', {
        ['id'] = boxId
    })
    Boxes[boxId] = nil
end

function roundCoords(coords)
    local mult = 10^(5 or 0)
    return math.floor(coords * mult + 0.5) / mult
end
