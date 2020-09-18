function CreateTreasureBox(boxId, coords, contents)
    local self = {}
    
    self.boxId = boxId
    self.coords = coords
    self.contents = contents
    self.isLooted = false

    self.lootBox = function(playerId)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        for item, amount in pairs(self.contents) do
            if item == 'black_money' or item == 'money' or item == 'bank' then
                xPlayer.addAccountMoney(item, amount)
            else
                xPlayer.addInventoryItem(item, amount)
            end
        end
        deleteTreasureBox(self.boxId)
    end
    
    return self
end
