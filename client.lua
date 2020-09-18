local Boxes = {}
local boxObjects = {}

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('dzp_treasure:getBoxes')
end)

RegisterNetEvent('dzp_treasures:setBoxes')
AddEventHandler('dzp_treasures:setBoxes', function(boxes)
    for i = 1, #boxObjects do
        NetworkFadeOutEntity(boxObjects[i], false, false)
        DeleteObject(boxObjects[i])
    end
    Citizen.Wait(100)
    Boxes = {}
    boxObjects = {}
    while ESX == nil do
        Citizen.Wait(100)
    end
    Boxes = boxes
    for boxId, box in pairs(Boxes) do
        boxCoords = vector3(box.coords.x, box.coords.y, box.coords.z-1)
        ESX.Game.SpawnObject(90805875, boxCoords, function(box)
            table.insert(boxObjects, 1, box)
            FreezeEntityPosition(box, true)
            SetEntityAsMissionEntity(object, true, false)
            SetEntityCollision(box, true, true)
        end)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(200)
    while true do
        local ped = GetPlayerPed(-1)
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(ped)
        for boxId, box in pairs(Boxes) do
            local boxCoords = vector3(box.coords.x, box.coords.y, box.coords.z)
            local dist = #(playerCoords - boxCoords)
            if dist < 100.0 then
                if dist < 2.5 then
                    ESX.ShowHelpNotification('You found a treasure. ~INPUT_CONTEXT~ loot it!')
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent('dzp_treasure:lootTreasureBox', boxId)
                        local box = GetClosestObjectOfType(boxCoords, 1.5, 90805875, false, false, false)
                        NetworkFadeOutEntity(box, false, false)
                        DeleteObject(box)
                    end
                end
            end
        end
    end
end)