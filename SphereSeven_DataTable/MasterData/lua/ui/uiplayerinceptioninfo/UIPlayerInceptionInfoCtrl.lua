

local UIPlayerInceptionInfoCtrl = BaseClass("UIPlayerInceptionInfoCtrl",UIBaseCtrl)
local this = UIPlayerInceptionInfoCtrl

function this.CloseBut()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIPlayerInceptionInfo);
end


function this.SendSetMainRequest(self,card) --设置主界面请求
    coroutine.start(function()
        local g2cSetAsMainUICard = coroutine.yieldstart(Game.Scene.Session.CoCall, nil,  Game.Scene.Session,
                OuterOpcode.Name2Code.ETModel_C2M_SetAsMainUICard, {CardId = card.Id});
        if g2cSetAsMainUICard.Error == ErrorCode.ERR_Success then
            Game.Scene.Player.MainUICardId = card.Id;
            ClientData:GetInstance():SetMainUiId(card.TemplateId)
            DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG);
            DataManager:GetInstance():Broadcast(DataMessageNames.ON_MAIN_UI_CARD_CHG);
            local info = {cardInfoChgType = CardInfoChgType.Home,
                          cardId = card.Id
            }
          
            DataManager:GetInstance():Broadcast(DataMessageNames.ON_CARD_INFO_CHG,info)
        end
    end)
end


function this.SendChooseCard(self,index,callback,errorCallback, selectedCallback)
    PublicRequest.SendRequest(
        PROTOCOL.SelectFirstCharacterReq,
        {number = index},
        function(response, errorCode)
            if errorCode ~= 0 and errorCode ~= nil then
                -- 失败
                if errorCode == 11402 then
                    local guide=Game.Scene:GetComponent("GuideComponent")
                    local SStep= table.first(guide.GuideList,function (v) return v.Id==2  end)
                    local cardId = tonumber(Z_Misc["INIT_CHARACTERS"].Value[index])
                    -- if cardId == 1001 then
                    --     ChannelManager:GetInstance():CommonCallback(GameEvent.ChooseCaoCao)
                    -- else
                    --     ChannelManager:GetInstance():CommonCallback(GameEvent.ChooseLiShiMin)
                    -- end
                    PublicRequest.SendRequest(
                        PROTOCOL.SetSupportUnitReq,
                        {
                            index = SupportUnitIndex,
                            character_id = cardId,
                            fight_soul_id = 0,
                        },
                        nil
                    )
                    if callback~=nil then callback() end
                    if selectedCallback ~= nil then
                        selectedCallback()-- 重复选择时的回调
                    end
                else
                    UIUtil.ToolTipFourth(LangUtil.GetSysLang(1001));
                    if errorCallback ~= nil  then
                        errorCallback()
                    end
                    --self:SendChooseCard(self,Id,callback)
                end
            else
                local cardId = tonumber(Z_Misc["INIT_CHARACTERS"].Value[index])
                local info = {}
                info.hideStage2 = true
                info.resultList = {
                    {
                        reward = {
                            type = RewardType.RewardTypeCharacter,
                            id = cardId,
                            count = 1
                        },
                        rewardResult = {
                            type = RewardType.RewardTypeCharacter,
                            id = cardId,
                            count = 1 
                        },
                        isNew = true
                    }
                }

                Game.Scene.Player.first_character_selected = index
                PublicRequest.SendRequest(
                    PROTOCOL.SetSupportUnitReq,
                    {
                        index = SupportUnitIndex,
                        character_id = cardId,
                        fight_soul_id = 0,
                    },
                    nil
                )

                PublicRequest.SendRequest(
                    PROTOCOL.SetShowGirlReq,
                    {
                        show_girl = {
                            character_id = cardId,
                            skin_id = cardId * 100 + 1,
                            pos_x = -2.9,
                            pos_y = 0,
                            scale = 1,
                        }
                    }
                )

                PublicRequest.SendRequest(
                PROTOCOL.ChangeHeadPortraitReq,{
                    id = cardId * 100 + 1
                },
                    function(response, error)
                        if error == 0 then
                            Game.Scene.Player.Avatar = response.id
                        end
                    end
                )


                PublicRequest.SendRequest(
                    PROTOCOL.SetSocietyShowGirlReq,
                    {
                        show_girl = {
                            character_id = cardId,
                            skin_id = cardId * 100 + 1,
                            pos_x = 0,
                            pos_y = 0,
                            scale = 1,
                        }
                    }
                )

                -- local infoC = {resultList = { {card = card} },newCardList = { card },newFightSoulList = { }}
                UIManager:GetInstance():OpenWindow(UIWindowNames.UISummonStage1,info)
                if callback~=nil then 
                    callback()
                end
            end
        end
    )
end



return this