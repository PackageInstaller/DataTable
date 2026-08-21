local UIVotingSelCtrl = BaseClass("UIVotingSelCtrl", BaseUICtrl)
local M = UIVotingSelCtrl
local UIVotingSelItemCtrl = require("UI.Ctrl.UIVotingSel.UIVotingSelItemCtrl")
local UIVotingSelItemView = require("UI.View.UIVotingSel.UIVotingSelItemView")
local mathRandom = math.random
local VotingTimer = EnumConst.VotingTimer
local sfmt = string.format

-- 海选界面
-- View: UIVotingSelView
function M:Init()
    self.ScrollView = self._view.ScrollView
    self.ScrollView:Init(UIVotingSelItemCtrl, UIVotingSelItemView)
    self._view.btnRandom:SetOnClick(self, self.OnBtnClick)
    self.eventHero = EventMgr:AddListener(UIMessageNames.VOTING_CLICKHERO, Bind(self, self.OnEventHero))

    self.State = {Random=1, Orderly=2}
end

-- 进入UI，可传参数
function M:OnEnter()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end

    local heroDatas = self:GetContext():GetAllSelectGetHeroData()
    self.heroData = {}

    for i = 1, #heroDatas do
        self.heroData[i] = heroDatas[i]
    end

    self.typeState = self.State.Random
    self:RandomHeroData()
    self:UpdateHeroData()
    self._view.textBtn:SetText(684)
    local timeData = VotingDataMgr:GetInstance():GetTimers(VotingTimer.Timer1)
    local strTimer = self:GetTimer(timeData.startTimer, timeData.endTimer)
    self._view.textTime:SetText(strTimer)

    self.residueRefTimer = self:GetContext():GetNextRefTimer() - TimeUtil.GetNowTimeStamp()
    self:RefTimer()

    self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
    self._timer:Start()
end

function M:OnRefHeroData()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end

    local heroDatas = self:GetContext():GetAllSelectGetHeroData()
    self.heroData = {}

    for i = 1, #heroDatas do
        self.heroData[i] = heroDatas[i]
    end

    if self.typeState == self.State.Random then
        self:RandomHeroData()
    end

    self:UpdateHeroData()

    local timeData = VotingDataMgr:GetInstance():GetTimers(VotingTimer.Timer1)
    local strTimer = self:GetTimer(timeData.startTimer, timeData.endTimer)
    self._view.textTime:SetText(strTimer)

    self.residueRefTimer = self:GetContext():GetNextRefTimer() - TimeUtil.GetNowTimeStamp()
    self:RefTimer()

    self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
    self._timer:Start()
end

function M:GetTimer(startTimer, endTimer)
    local strStart = TimeUtil.GetTimeFormat(startTimer, "%m.%d %H:%M")
    local strEnd = TimeUtil.GetTimeFormat(endTimer, "%m.%d %H:%M")
    return sfmt("%s~%s", strStart, strEnd)
end

function M:UpdateHeroData()
    self.ScrollView:SetDataList(self.heroData)
end

function M:TimerCallBack()
    if self.residueRefTimer > 0 then
        self.residueRefTimer = self.residueRefTimer - 1
        self:RefTimer()
    else
        Logger.Log("请求刷新:" .. tostring(self.residueRefTimer))
        self._timer:Stop()
        self._timer = nil
        if VotingDataMgr:GetInstance():GetNowState() == VotingTimer.Timer1 then
            self:GetContext():HeroRankReq()
        else
            self:Close()
        end
    end
end

function M:RefTimer()
    local Time = TimeUtil.GetTimeByStamp(self.residueRefTimer)
    local timerStr = sfmt(ConfigHelper.GetLocalString(699), Time.minute, Time.second)
    self._view.textRefTime:SetText(timerStr)
end

local function SortTicket(heroData1, heroData2)
    if heroData1.Ticket ~= heroData2.Ticket then
        return heroData1.Ticket > heroData2.Ticket
    end
    if heroData1.rare ~= heroData2.rare then
        return heroData1.rare > heroData2.rare
    end
    return heroData1.heroId < heroData2.heroId
end


function M:RandomHeroData()
    local length = #self.heroData

    for i = 1, length do
        local randomIndex = mathRandom(i, length)
        local randomData = self.heroData[i]
        self.heroData[i] = self.heroData[randomIndex]
        self.heroData[randomIndex] = randomData
    end
end

function M:OnBtnClick()
    if self.typeState == self.State.Random then
        self.typeState = self.State.Orderly
        table.sort(self.heroData, SortTicket)
        self:UpdateHeroData()
        self._view.textBtn:SetText(683)
    else
        self.typeState = self.State.Random
        self:RandomHeroData()
        self:UpdateHeroData()
        self._view.textBtn:SetText(684)
    end
end

function M:OnEventHero(heroId)
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingHero, heroId, self:GetContext():GetAllSelectGetHeroData(), true)
end

-- 关闭时回调，无参
function M:OnClose()
    EventMgr:RemoveListener(UIMessageNames.VOTING_CLICKHERO, self.eventHero)
    self.State = nil

    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
end

return UIVotingSelCtrl
