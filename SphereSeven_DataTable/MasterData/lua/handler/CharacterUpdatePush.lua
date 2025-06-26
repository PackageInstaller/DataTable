local CharacterUpdatePush = BaseClass("CharacterUpdatePush",IMHandler)

-- 断线重连触发事件
CharacterUpdatePush.__init = function(self)

end

CharacterUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        local player =  Game.Scene:GetComponent("PlayerComponent").Player
        player.MainWife = pbMsg.character_pack.main_wife

        for _, cardInfo in ipairs(pbMsg.character_pack.characters) do
            local cardComponent = Game.Scene.Player:GetComponent("CardComponent")
            local card = Game.Registry:NewObject("Card", cardInfo)
            if card.TemplateId ~= 0 then
                card:InitCardComponent()
                cardComponent:Add(card,nil,true)
            end
            DataManager:GetInstance() :Broadcast(DataMessageNames.ON_CHARACTER_UPDATE_PUSH, card)
            local info = {cardInfoChgType = CardInfoChgType.Equip,
                          cardId = card.Id
            }
            DataManager:GetInstance():Broadcast(DataMessageNames.ON_CARD_INFO_CHG,info)
        end

        for _, skinID in ipairs(pbMsg.character_pack.skins) do
            local cardComponent = Game.Scene.Player:GetComponent("CardComponent")
            if cardComponent.UnLockSkinList[skinID] == nil then
                cardComponent:AddSkin(skinID)
            end

            local info = {
                cardInfoChgType = CardInfoChgType.Skin,
                cardId = skinID
            }

            DataManager:GetInstance():Broadcast(DataMessageNames.ON_CARD_INFO_CHG,info)
        end


    end)
end

return CharacterUpdatePush