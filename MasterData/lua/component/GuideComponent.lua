---@type GuideComponent
local GuideComponent = BaseClass("GuideComponent", Component)
local base = Component
local this = GuideComponent

local TotalStep = { 15, 5, 52, 13, 9 ,5,3,2,3,3,9,8,11,18,2,3,4} -- 每个引导的完成步骤( 到了这一步 就不开启了)
function this.Awake(self)
    base.Awake(self)
    self.GuideComplete = 0
    self.GuideStep = 0
    self.GuideRun = false
    self.GuideAppointStep = { 17, 20, 21, 22, 23, 24 }
    self.GuideList = {}--id 1 新手昵称  id 1001--攻击教程 id 2--选择的初始角色ID
    --local reqData = {Type=0,Id=0}
    --self:ChooseDate(reqData)
    self.minStep = 0
    self.BattleSpeed = 0
end

function this:CoLoadData()
    ---@type protocol.GuideResp
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
        PROTOCOL.GuideReq, {})

    if info.guide_saves ~= nil then
        for key, value in pairs(info.guide_saves) do
            table.insert(self.GuideList, {
                    Id = value.stage_id,
                    Step = value.save_point
            })
            end
    end

    -- 这里只有history 但是跟arenaInfo存放在一起, 所以直接在下面创建一个arenaInfo对象了.
    -- self:CreateOrUpdateArenaInfo(info)
    return coroutine.yieldbreak(info)
end

function this.Init(self)
    --初始this.GuideComplete=Game.Scene.player.GuideComplete
end

local OpenGuideIds = {
    0, --- 引导战斗
    1, --- 抽卡
    4, --- 剧情主页
    5, --- 主线章节页
}

--开启引导    开启ID
function this.CheckStart(self, guideId, guideStep)
    if self.GuideRun then
        return
    end
    if not CS.Game.Instance.settings.guideEnabled then
        return
    end
    if not table.contains(OpenGuideIds, guideId)  then
        return
    end
    self.GuideComplete = guideId
    self.GuideStep = guideStep
    self.GuideRun = true
    UIManager:GetInstance():OpenWindow(UIWindowNames.UINoviceGuide)
    local windowH = UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
    if not IsNull(windowH) then
        local view = windowH.View
        view.eventImg:SetActive(false)
    end
end

--开启下一个引导
function this.NextStart(self, guideId, guideStep)
    if not self.GuideRun then
        return
    end
    self.GuideComplete = guideId
    self.GuideStep = guideStep
    self.GuideRun = true
    self.minStep = 0
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep)
end

--停止引导
function this.EndGuide(self)
    if not self.GuideRun then
        return
    end
   
    UIManager:GetInstance():CloseWindow(UIWindowNames.UINoviceGuide)
    self.GuideStep = 0
    self.GuideRun = false
    self.GuideComplete = self.GuideComplete + 1
    --并保存Game.Scene.player.GuideComplete=self.GuideComplete
    if self.GuideComplete == 3  then
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
        local view =window.View
        view:ToolTip()
        ChannelManager:GetInstance():CommonCallback(GameEvent.TutorialComplete)
    end
end
--引导下一步
function this.NextGuide(self, guideStep)
    if not self.GuideRun then
        return
    end
    if self.GuideStep ~= guideStep then
        return
    end
    self.GuideStep = self.GuideStep + 1
    self.minStep = 0
    --事件
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep)

end

--引导当前步骤的下一小步
function this.NextStepMin(self, guideStep, minStep, isFinger)
    if not self.GuideRun then
        return
    end
    if self.GuideStep ~= guideStep then
        return
    end
    self.GuideStep = guideStep
    self.minStep = minStep
    if isFinger ~= nil then
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG_MIN, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep, isFinger)
    else
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG_MIN, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep, 0)
    end


end

--引导当前步骤的下一小步
function this.JumpStepMin(self, guideStep, minStep, isFinger)
    if not self.GuideRun then
        return
    end
    self.GuideStep = guideStep
    self.minStep = minStep
    if isFinger ~= nil then
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG_MIN, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep, isFinger)
    else
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG_MIN, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep, 0)
    end


end

--引导下一步
function this.JumpGuide(self, guideStep)
    if not self.GuideRun then
        return
    end
    --if self.GuideStep ~=guideStep then return end
    self.GuideStep = guideStep
    --事件
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep)

end

--引导特定步骤
--- 从其他地方调用, 比如战斗中 触发到某个特定角色的操作, 就可以调用特定步骤的引导
function this.AppointGuide(self, guideStep)
    if not self.GuideRun then
        return
    end
    if table.indexof(self.GuideAppointStep, guideStep) then
        self.GuideStep = guideStep
        --事件
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep)
        table.removeget(self.GuideAppointStep, function(v)
            return v == guideStep
        end)

    end
end

function this.ChooseDate(self, reqData)
    ---@param response protocol.GuideSaveResp
    PublicRequest.SendRequest(
        PROTOCOL.GuideSaveReq,
        {
            stage_id = reqData.Id,
            save_point = reqData.Type
        },
        function(response)
            local isNew = true
            for key, value in pairs(self.GuideList) do
                if value.Id == response.stage_id then
                    self.GuideList[key].Step = response.save_point
                    isNew = false
                    break
                end
            end
            if isNew then
                table.insert(
                    self.GuideList,
                    {
                        Id = response.stage_id,
                        Step = response.save_point
                    }
                )
            end
        end
    )
end


--引导当前步骤
function this.CurGuide(self, guideStep)
    if not self.GuideRun then
        return
    end
    if self.GuideStep ~= guideStep then
        return
    end
    self.GuideStep = guideStep
    --事件
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep)

end




--触发点击事件
function this.ClickGuide(self)
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_Click, self.GuideComplete, self.GuideStep, self.GuideRun, self.minStep)
end
--获取当前引导信息
function this.GetCurrentData(self)
    return self.GuideComplete, self.GuideStep, self.GuideRun
end

function this.SkipLogic(self)
    if self.GuideComplete == 0 then
        Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.BattleEnd)
        return
    end
    UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide, true).View.mask_bc.gameObject:SetActive(false)
    local noviceGuideSkip = table.first(Z_NoviceGuideSkip,function(a) return a.GuideCompleteId == self.GuideComplete and  self.GuideStep >= a.Skip[1] and self.GuideStep < a.Skip[2]  end)
    local closeW = noviceGuideSkip.CloseUI
    for i = 1, #closeW do
        UIManager:GetInstance():CloseWindow(closeW[i])
    end
    Game.Scene:GetComponent("GuideComponent"):NextStart(self.GuideComplete+1,0)
end

function this.SkipAll(self)
    local step = table.first(self.GuideList,function (a) return a.Id == (self.GuideComplete+1)*1000 +1 end)
    if step == nil  then
        step = {Id = (self.GuideComplete+1)*1000 +1 ,Step = 0 }
    end
    if self.GuideComplete == 0 then
        ChannelManager:GetInstance():CommonCallback(GameEvent.BattleSkip)
    elseif self.GuideComplete == 1 then
        ChannelManager:GetInstance():CommonCallback(GameEvent.GachaSkip)
    elseif self.GuideComplete == 2 then
        ChannelManager:GetInstance():CommonCallback(GameEvent.CharacterSkip)
    elseif self.GuideComplete == 3 then
        ChannelManager:GetInstance():CommonCallback(GameEvent.TeamSkip)
    elseif self.GuideComplete == 4 then
        ChannelManager:GetInstance():CommonCallback(GameEvent.AtkSkip)
        --ChannelManager:GetInstance():CommonCallback(GameEvent.TutorialComplete)
    end
    if self.GuideComplete >= 2 then
        local reqData1 = {Type = TotalStep[self.GuideComplete+1]-step.Step,Id=(self.GuideComplete+1)*1000 +1}
        self:ChooseDate(reqData1)
        self:EndGuide()
        return
    end
   
    
    local noviceGuideSkip = table.first(Z_NoviceGuideSkip,function(a) return a.GuideCompleteId == self.GuideComplete and  self.GuideStep >= a.Skip[1] and self.GuideStep < a.Skip[2]  end)
    
    if self.GuideComplete==1  then
        self:SkipSendSummon()
        return
    end
    if noviceGuideSkip then
        --self:OnClickOpenView(noviceGuideSkip.SkipCode)
        if noviceGuideSkip.IsEndGuide == 1 then
            local reqData1 = {Type = TotalStep[self.GuideComplete+1]-step.Step,Id=(self.GuideComplete+1)*1000 +1}
            self:ChooseDate(reqData1)
            self:EndGuide()
        else
            local reqData1 = {Type = TotalStep[self.GuideComplete+1]-step.Step,Id=(self.GuideComplete+1)*1000 +1}
            self:ChooseDate(reqData1)
            self:SkipLogic()
        end
    end
    
    
end

function this.Dispose(self)
    base.Dispose(self)
end

function this.AutoGuide(self)
    if not self.GuideRun then
        return
    end
    self:NextGuide(self.GuideStep)

end

function this.OnClickOpenView(self, OpenCode)
    if not string.IsNullOrEmpty(OpenCode) then
        loadfunc(OpenCode)
    end
end

function this.OpenWindowCradIntens(self, name, step)
    local SStep = table.first(self.GuideList, function(v)
        return v.Id == 2
    end)
    local card = nil
    if SStep ~= nil then
        local card_list = Game.Scene.Player:GetComponent("CardComponent").Cards
        card = table.first(card_list, function(v)
            return v.TemplateId == SStep.Step
        end)
    else
        local card_list = Game.Scene.Player:GetComponent("CardComponent").Cards
        card = table.first(card_list, function(v)
            return v.TemplateId == 1003
        end)
    end
    print('赋值后'..card.Id)
    self.timeUpdate1 = function(self)
        if card ~= nil then
            self.timer1:Stop()
            local openData = {}
            openData.cur_panel_id = 1;
            openData.cur_card = card
            openData.parent = UIWindowNames.UICardList
            UIManager:GetInstance():CloseWindow(UIWindowNames.UICardList)
            UIManager:GetInstance():OpenWindow(UIWindowNames.UICardIntens, openData)
            self.timeUpdate = function(self)
                local window = UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
                print(not IsNull( window.View.transform))
                print( window.View.cur_card ~= nil)
                if window ~= nil and window.View ~= nil and not IsNull( window.View.transform) and  window.View.cur_card ~= nil then
                    print('window.View.cur_card:'..window.View.cur_card.Id)
                    UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens).View:OpenPanelByName(name)
                    self:CheckStart(2, step)
                    self.timer:Stop()
                end
            end
            self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate, self)
            -- 启动定时器
            self.timer:Start()
        end
    end
    self.timer1 = TimerManager:GetInstance():GetTimer(1, self.timeUpdate1, self)
    -- 启动定时器
    self.timer1:Start()

end

function this.OpenWindowTeam(self, step)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew)
    self.timeUpdate = function(self)
        local window = UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
        if window ~= nil and window.View ~= nil and not IsNull(window.View.transform) then
            self:CheckStart(3, step)
            self.timer:Stop()

        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate, self)
    -- 启动定时器
    self.timer:Start()
end

function this.OpenWindowBattleMode(self, step)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattleMode)
    self.timeUpdate = function(self)
        local window = UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
        if window ~= nil and window.View ~= nil and not IsNull( window.View.transform) then
            self:CheckStart(4, step)
            self.timer:Stop()
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate, self)
    -- 启动定时器
    self.timer:Start()
end

function this.OpenWindowSummonMode(self, step)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UISummon)
    self.timeUpdate = function(self)
        local window = UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
        if window ~= nil and window.View ~= nil and not IsNull( window.View.transform) then
            --if step >= 10 then
            --    window.View:OnClickFreeButton()
            --end
            self:CheckStart(1, step)
            self.timer:Stop()
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate, self)
    -- 启动定时器
    self.timer:Start()
end

function this.SwitchBattleScene(self)
    local guideCards = require("Misc.GuideCards")

    self.canRemoveIds = {}
    for _,v in ipairs(guideCards.cards) do
        local card = Game.Registry:NewObject("Card",v)
        if  card.TemplateId ~= 0 then
            card:InitCardComponent()
            Game.Scene.Player:GetComponent("CardComponent"):Add(card, nil, true)
            table.insert(
                self.canRemoveIds,
                card.Id
            )
        end
    end


    local data = {}
    data.LevelType = LevelType.LevelTypeGuide
    data.CurLevelId = 1001
    UIPublic.LaunchAtk(data)
    -- local CardId = table.first(self.GuideList, function(v)
    --     return v.Id == 2
    -- end)
    -- if CardId == nil then
    --     CardId = { Step = 1001, id = 2 }
    -- end
    -- local CardInfoList = {
    --     { CardId = 1, TemplateId = 1026, Level = 100, LevelLimit = 100, Stage = 3, Star = 5, Exp = 0, CloseDegree = 0, SkinId = 2, Lock = 0, Hand1Equip = 0,
    --       Hand2Equip = 0, BodyEquip = 0, HeadEquip = 0, FootEquip = 0, AdornEquip = 0, FightSoul1 = 0, FightSoul2 = 0, FightSoul3 = 0, Support = 0, JadePearlLevel = 0, PlayedNum = 0 },
    --     { CardId = 2, TemplateId = 1027, Level = 100, LevelLimit = 100, Stage = 3, Star = 5, Exp = 0, CloseDegree = 0, SkinId = 2, Lock = 0, Hand1Equip = 0,
    --       Hand2Equip = 0, BodyEquip = 0, HeadEquip = 0, FootEquip = 0, AdornEquip = 0, FightSoul1 = 0, FightSoul2 = 0, FightSoul3 = 0, Support = 0, JadePearlLevel = 0, PlayedNum = 0 },
    --     { CardId = 3, TemplateId = 1003, Level = 100, LevelLimit = 100, Stage = 3, Star = 5, Exp = 0, CloseDegree = 0, SkinId = 2, Lock = 0, Hand1Equip = 0,
    --       Hand2Equip = 0, BodyEquip = 0, HeadEquip = 0, FootEquip = 0, AdornEquip = 0, FightSoul1 = 0, FightSoul2 = 0, FightSoul3 = 0, Support = 0, JadePearlLevel = 0, PlayedNum = 0 },
    --     { CardId = 4, TemplateId = CardId.Step, Level = 100, LevelLimit = 100, Stage = 3, Star = 5, Exp = 0, CloseDegree = 0, SkinId = 0, Lock = 0, Hand1Equip = 0,
    --       Hand2Equip = 0, BodyEquip = 0, HeadEquip = 0, FootEquip = 0, AdornEquip = 0, FightSoul1 = 0, FightSoul2 = 0, FightSoul3 = 0, Support = 0, JadePearlLevel = 0, PlayedNum = 0 },
    --     { CardId = 5, TemplateId = 1028, Level = 100, LevelLimit = 100, Stage = 3, Star = 5, Exp = 0, CloseDegree = 0, SkinId = 101, Lock = 0, Hand1Equip = 0,
    --       Hand2Equip = 0, BodyEquip = 0, HeadEquip = 0, FootEquip = 0, AdornEquip = 0, FightSoul1 = 0, FightSoul2 = 0, FightSoul3 = 0, Support = 0, JadePearlLevel = 0, PlayedNum = 0 }
    -- }

    -- local Team = {
    --     TeamId = 1,
    --     TeamNo = 100,
    --     EnhanceType = 4, --强化阵型，红心/黑桃....
    --     TeamDetailList = { { CardId = 1, MatrixPos = 11 }, { CardId = 4, MatrixPos = 13 }, { CardId = 2, MatrixPos = 17 }, { CardId = 3, MatrixPos = 15 }, { CardId = 5, MatrixPos = 19 } }
    -- }
    -- Game.Scene.Player:GetComponent("TeamComponent"):Add(Team)
    -- --设置我方数据
    -- for _, v in ipairs(CardInfoList) do
    --     local card = Game.Registry:NewObject("Card", v)
    --     if card.TemplateId ~= 0 then
    --         card:InitCardComponent()
    --         Game.Scene.Player:GetComponent("CardComponent"):Add(card, nil, true)
    --     end
    -- end

    -- --设置敌人数据
    -- local date = { LevelType = LevelType.LevelTypeGuide, CurLevelId = 1001, CurLevelDifficulty = 1 }
    -- Game.Scene:GetComponent("AgainstComponent"):SetCurLevel(date)
    -- Game.Scene.SceneComponent:SwitchScene(SceneConfig.BattleScene)
    -- self.GuideAppointStep = { 17, 20, 21, 22, 23, 24 }
    -- ChannelManager:GetInstance():CommonCallback(GameEvent.BattleTutorial)
    --local uiGuide = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
    --uiGuide.View.mask_bc.transform.parent.gameObject:SetActive(false)
end

function this.removeCards(self)
    if self.canRemoveIds == nil then
        return
    end
    for index, id in ipairs(self.canRemoveIds) do
        if Game.Scene.Player:GetComponent("CardComponent"):Get(id) ~= nil then
            Game.Scene.Player:GetComponent("CardComponent"):Remove(id)
        end
    end
    self.canRemoveIds = nil
    -- 战斗结束 直接保存最后一步
    local data = {}
    data.Id = BattleGuideId
    data.Type = BattleGuideEndStep
    
    self:ChooseDate(data)
end

--帝王风暴攻击特效后指引
function this.GroupAtkStop(self)
    if not self.GuideRun then
        return
    end
    if self.GuideComplete == 11 and self.GuideStep == 4 then
        local window = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
        window.View:setMaskAll(true)
        window.View:setTxtAll("11_4")
    end
end

function this.GuideReward(self)
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_GuideReward, {})
    if info.Error == ErrorCode.ERR_Success then
        self:AutoGuide()
        local SStep= table.first(self.GuideList,function (v) return v.Id==3001  end)
        local type = 0
        if SStep~=nil then
            type= 1 - SStep["Step"]
        else
            type = 1
        end
        local reqData1 = {Type = type,Id=3001}
        self:ChooseDate(reqData1)
        
        local g2CItemInfo = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                PROTOCOL.ItemBagReq, {})
        local player = Game.Scene.Player
        local itemComponent = player:GetComponent("ItemComponent")
        for _, v in ipairs(g2CItemInfo.items) do
            local item = UIPublic.GetItem(v.ItemId);
            if item == nil then
                itemComponent:Add(Game.Registry:NewObject("Item", {
                    uid = v.uid,
                    cid = v.cid,
                    count = v.count
                }))
            else
                item.Amount = v.count;
            end

        end
        player.GoldCoin = player.GoldCoin + Z_GuideReward[10030].RewardNum;

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG);
    else
        if info.Error == 301015 and info.Message == "no more" then
            self:AutoGuide()
            local player = Game.Scene.Player
            local SStep= table.first(self.GuideList,function (v) return v.Id==3001  end)
            local type = 0
            if SStep~=nil then
                type= 1 - SStep["Step"]
            else
                type = 1
            end
            local reqData1 = {Type = type,Id=3001}
            self:ChooseDate(reqData1)
            player.GoldCoin = player.GoldCoin + Z_GuideReward[10030].RewardNum;

            DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG);
        else
            self:JumpGuide(0)
            UIUtil.ToolTipFourth(LangUtil.GetServerError(info.Error))
        end
        
    end
end

function this.GetWorldToScreenRect(self,canvas,targetTf)
    local screenPoint = canvas.worldCamera:WorldToScreenPoint(targetTf.position)
    local rc=targetTf:GetComponent(typeof(RectTransform))
    local size=rc.sizeDelta
    screenPoint=CSUtil.GetCanvasPosition(canvas, screenPoint)
    return screenPoint.x ,screenPoint.y ,size.x,size.y
end

function this.SkipSendSummon(self)
    local c2g_summon = {};
    c2g_summon.TypeId = 1234567
    c2g_summon.IsContinuity = 1
    local newCardList = {}
    local newFightSoulList = {}
    local player = Game.Scene.Player
    
    local need_free = 200
    local step = table.first(self.GuideList,function (a) return a.Id == (self.GuideComplete+1)*1000 +1 end)
    if step == nil  then
        step = {Id = (self.GuideComplete+1)*1000 +1 ,Step = 0 }
    end
    coroutine.start(function()
        local g2c_summon = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                OuterOpcode.Name2Code.ETModel_C2M_Summon, c2g_summon);
        if g2c_summon.Error == ErrorCode.ERR_Success or (g2c_summon.Error == 360005 and (g2c_summon.Message == "Quota Error"  ) and table.count(g2c_summon.SummonRetList)>0 ) then
            player.FreeStarStone = player.FreeStarStone - need_free;
            local recruitComponent = Game.Scene.Player:GetComponent("RecruitComponent")
            if not recruitComponent.SummonDetails[1234567] then
                recruitComponent.SummonDetails[1234567] = {Key = 1234567, Single = 0, Continuity = 0}
            end
            local resultList = {}
            for k,v in table.pairsByKeys(g2c_summon.SummonRetList) do
                if v.SummonResTypeInfo == "Card" then
                    local card = Game.Registry:NewObject("Card",v.CardBean)
                    -- if table.first(cardTypeList,function(a) return a== card.TemplateId  end) == nil then
                    --     table.insert(newCardList,card)
                    -- end
                    player:GetComponent("CardComponent"):Add(card);
                    card:InitCardComponent()
                    table.insert(resultList,{card = card})
                else
                end
            end

            DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG);
            
            player.IsAllowFreeCallCard = 0
           
            if g2c_summon.ItemBean then
                UIPublic.AddItem(g2c_summon.ItemBean)
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_ITEM_INFO_CHG)
            end
            --local info = {resultList = resultList,newCardList = newCardList,newFightSoulList = newFightSoulList,
            --              item = g2c_summon.ItemBean}
            --UIManager:GetInstance():OpenWindow(UIWindowNames.UISummonStage1, info)

            local cardIds = {}
            for k,v in pairs(newCardList) do
                table.insert(cardIds,v.TemplateId)
            end

            local fightSoulIds = {}
            for k,v in pairs(newFightSoulList) do
                table.insert(fightSoulIds ,v.TemplateId)
            end

            local reqData1 = {Type = TotalStep[self.GuideComplete+1]-step.Step,Id=(self.GuideComplete+1)*1000 +1}
            self:ChooseDate(reqData1)
            self:SkipLogic()
        else
            local guide =  Game.Scene:GetComponent("GuideComponent")
            if g2c_summon.Error == 360005 and (g2c_summon.Message == "Quota Error"  )and guide.GuideRun then
                local reqData1 = {Type = TotalStep[self.GuideComplete+1]-step.Step,Id=(self.GuideComplete+1)*1000 +1}
                self:ChooseDate(reqData1)
                self:SkipLogic()
            else
                UIUtil.ToolTipFourth(LangUtil.GetServerError(g2c_summon.Error));
            end
        end

    end)
end

GuideComponent.TotalStep = TotalStep
return this