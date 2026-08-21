--baoruichang
--2021/12/15 11:17:45

local UIVotingFir1Ctrl = BaseClass("UIVotingFir1Ctrl", BaseUICtrl)
local M = UIVotingFir1Ctrl
local VotingTimer = EnumConst.VotingTimer

function M:__init(view)
    self._view = view
    self:Init()
end

function M:Init()
    self.eventHero = EventMgr:AddListener(UIMessageNames.VOTING_TWESELECTHERO1, Bind(self, self.OnEventHero))
end

function M:UpdateData(heroDatas)
    self.heroDatas = heroDatas

    if heroDatas[1] ~= nil then
        self._view.tfItemL.gameObject:SetActive(true)
        self._view.ItemL:InitData(heroDatas[1])
    else
        self._view.tfItemL.gameObject:SetActive(false)
    end

    if heroDatas[2] ~= nil then
        self._view.tfItemR.gameObject:SetActive(true)
        self._view.ItemR:InitData(heroDatas[2])
    else
        self._view.tfItemR.gameObject:SetActive(false)
    end

    local timeData = VotingDataMgr:GetInstance():GetTimers(VotingTimer.Timer5)
    self.residueTimer = timeData.startTimer - TimeUtil.GetNowTimeStamp()
    self.residueTimer = self.residueTimer > 0 and self.residueTimer or 0
    self:RefTimer()
    if self.residueTimer > 0 then
        self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
        self._timer:Start()
    end
end

function M:TimerCallBack()
    self.residueTimer = self.residueTimer - 1

    if self.residueTimer <= 0 then
        self._timer:Stop()
        self._timer = nil
        EventMgr:Broadcast(UIMessageNames.VOTING_REFSTATE)
        return
    end
    self:RefTimer()
end

function M:RefTimer()
    local strTime = TimeUtil.SecToStringFormat(self.residueTimer, "%H:%M:%S")

    self._view.textTimer:SetText(strTime)
end

function M:OnEventHero(heroId)
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingHero, heroId, self.heroDatas, false)
end

function M:SetEnableFalse()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
end

return UIVotingFir1Ctrl
