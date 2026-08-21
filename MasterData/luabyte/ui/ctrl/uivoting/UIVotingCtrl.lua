local UIVotingCtrl = BaseClass("UIVotingCtrl", BaseUICtrl)
local M = UIVotingCtrl
local sfmt = string.format
local VotingTimer = EnumConst.VotingTimer
local StageState = EnumConst.StageState
local ITEMNUM = 3

-- VotingUI 票选界面
function M:Init()
    self._view.btnReward:SetOnClick(self, self.OnBtnRewardClick)
    self._view.btnGetMore:SetOnClick(self, self.OnBtnGetMoreClick)
    self._view.btnFirst:SetOnClick(self, self.OnBtnFirstClick)
    self.VotingState = {
        All = 1, -- 海选
        Eight = 2, -- 八强
        First = 3 -- 冠军
    }

    self.eventClickItem = EventMgr:AddListener(UIMessageNames.VOTING_CLICKITEM, Bind(self, self.OnEventItem))
    self.eventRefState = EventMgr:AddListener(UIMessageNames.VOTING_REFSTATE,Bind(self,self.OnEnter))

end

function M:OnEnter()
    self.nowState = VotingDataMgr:GetInstance():GetNowState()
    if self.nowState == VotingTimer.Timer1 or self.nowState == VotingTimer.Timer3 or self.nowState == VotingTimer.Timer5 or self.nowState == VotingTimer.Timer6 then
        self._view.tfMain.gameObject:SetActive(true)
        self._view.tfVotingEight1UI.gameObject:SetActive(false)
        self._view.tfUIVotingFir1.gameObject:SetActive(false)
    elseif self.nowState == VotingTimer.Timer2 then
        self._view.tfMain.gameObject:SetActive(false)
        self._view.tfVotingEight1UI.gameObject:SetActive(true)
        self._view.UIVotingEight1Ctrl:UpdateData(self:GetContext():GetHeroDatas())
        self._view.tfUIVotingFir1.gameObject:SetActive(false)
    elseif self.nowState == VotingTimer.Timer4 then
        self._view.tfMain.gameObject:SetActive(false)
        self._view.tfVotingEight1UI.gameObject:SetActive(false)
        self._view.tfUIVotingFir1.gameObject:SetActive(true)
        self._view.UIVotingFir1Ctrl:UpdateData(self:GetContext():GetHeroDatas())
    end
    self:InitItem()
end

function M:OnVisible()
    self:InitItem()
    local lastNowState = self.nowState
    self.nowState = VotingDataMgr:GetInstance():GetNowState()
    if lastNowState == self.nowState then
        return
    end
    -- 如果离开的时机和当前时机不同，需要重新请求服务器数据
    self:GetContext():HeroRankReq()
end

function M:InitItem()
    local tabItemData = {}
    local timeData = VotingDataMgr:GetInstance():GetTimers()
    do
        local time = timeData[VotingTimer.Timer1]
        tabItemData[1] = self:GetData(self.VotingState.All, time.startTimer, time.endTimer)
    end
    do
        local time = timeData[VotingTimer.Timer3]
        tabItemData[2] = self:GetData(self.VotingState.Eight, time.startTimer, time.endTimer)
    end
    do
        local time1 = timeData[VotingTimer.Timer5]
        local time2 = timeData[VotingTimer.Timer6]
        tabItemData[3] = self:GetData(self.VotingState.First, time1.startTimer, time2.endTimer)
    end

    -- UIVotingItemCtrl
    self.tabUIVotingItemCtrl = {}

    for i = 1, ITEMNUM do
        self.tabUIVotingItemCtrl[i] = self._view["Item" .. i]
        self.tabUIVotingItemCtrl[i]:InitData(tabItemData[i])
    end
end

function M:GetData(index, startTimer, endTimer)
    local data = {}
    data.id = index
    data.timer = self:GetTimer(startTimer, endTimer)
    local nowTimer = TimeUtil.GetNowTimeStamp()

    if nowTimer < startTimer then
        data.state = StageState.NotOpen
    elseif nowTimer > endTimer then
        data.state = StageState.Over
    else
        data.state = StageState.Doing
    end
    return data
end

function M:GetTimer(startTimer, endTimer)
    local strStart = TimeUtil.GetTimeFormat(startTimer, "%m.%d %H:%M")
    local strEnd = TimeUtil.GetTimeFormat(endTimer, "%m.%d %H:%M")
    return sfmt("%s~%s", strStart, strEnd)
end

function M:OnBtnRewardClick()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingShop)
end

function M:OnBtnGetMoreClick()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingGetMore)
end

-- 上期冠军
function M:OnBtnFirstClick()
end

function M:OnEventItem(id)
    if id == self.VotingState.All then
        -- 海选
        UIContextMgr:GetInstance():Show(UIDefine.UIVotingSel)
    elseif id == self.VotingState.Eight then
        -- 八强
        UIContextMgr:GetInstance():Show(UIDefine.UIVotingEight2)
    else -- 冠军投票阶段
        if VotingDataMgr:GetInstance():GetNowState() == VotingTimer.Timer5 then
            UIContextMgr:GetInstance():Show(UIDefine.UIVotingFir2)
        end

        -- 冠军展示阶段
        if VotingDataMgr:GetInstance():GetNowState() == VotingTimer.Timer6 then
            Logger.Log("冠军展示阶段")
            -- self:Close()
            local VotingHeroScene = require "UI.Ctrl.UIVotingFirst.VotingHeroScene"
            VotingHeroScene:GetInstance():OnDispose()
            VotingHeroScene:GetInstance():LoadScene( -- "Scene/FreeChoose/VotingHeroRoom",
            "Scene/VoteSceneObject/VoteScene", function()
                -- UIContextMgr:GetInstance():Show("FreeChooseHero2",self.heroId)
                Logger.Log("加载完成")
                UIContextMgr:GetInstance():Show(UIDefine.UIVotingFirst)
            end)
        end
    end
end

function M:OnDispose()
    self._view.UIVotingEight1Ctrl:SetEnableFalse()
    self._view.UIVotingFir1Ctrl:SetEnableFalse()
    EventMgr:RemoveListener(UIMessageNames.VOTING_CLICKITEM, self.eventClickItem)
    EventMgr:RemoveListener(UIMessageNames.VOTING_REFSTATE,self.eventRefState)
    self._view.btnReward:RemoveOnClick()
    self._view.btnGetMore:RemoveOnClick()
    self._view.btnFirst:RemoveOnClick()
    M.super.OnDispose(self)
end

return UIVotingCtrl
