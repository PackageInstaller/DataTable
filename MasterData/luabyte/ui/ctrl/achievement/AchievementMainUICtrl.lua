local AchievementMainUICtrl = BaseClass("AchievementMainUICtrl", BaseUICtrl)
local M = AchievementMainUICtrl



function M:OnEnter()
    self._data = AchievementDataMgr:GetInstance():AchievementData()
    self._view.scrollView:SetDataList(self._data)
    self:SetProgress()
    self:_SetAllReceiveActive()
end


function M:SetProgress()
    local doneNum = AchievementDataMgr:GetInstance():DoneNum()
    local allNum = AchievementDataMgr:GetInstance():TaskNum()
    local progress = doneNum / allNum
    local progressText = string.format("%d/%d", doneNum, allNum)
    self._view.bar:SetFillAmount(progress)
    self._view.barText:SetText(progressText)
    progress = progress > 1 and 1 or progress
    self._view.barValue:SetText(tostring(math.floor(progress * 100)) .. "%")
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end


function M:Init()
    self._view.hideOff:onClick(Bind(self, self._OnClickHide))
    self._view.state_receiveAll:onClick(Bind(self, self._OnClickReceiveAll))
    self._view.scrollView:Init(require("UI.Ctrl.Achievement.AchievementItemCtrl"), require("UI.View.Achievement.AchievementItemView"))
    self._RefreshData = EventMgr:AddListener(UIMessageNames.NOTIFY_UPDATE_ACHIEVEMENT, Bind(self, self._OnRefreshDataCallBack))
end

function M:_OnRefreshDataCallBack()
    self:OnEnter()
end

function M:_SetAllReceiveActive()
    --是否有可领取奖励数据
    local hasTaskAward = AchievementDataMgr:GetInstance():RewardNum()>0
    if hasTaskAward then
        self._view.state_receiveAll:SetState(1)
    else
        self._view.state_receiveAll:SetState(2)
    end
end

function M:_OnClickHide()
    self._view.scrollView:SetDataList(self._data)
end

function M:_OnClickReceiveAll()
    local hasTaskAward = AchievementDataMgr:GetInstance():RewardNum()>0
    if  hasTaskAward then
        AchievementDataMgr:GetInstance():SendRequestAchievementRewardAll()
    end
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.NOTIFY_UPDATE_ACHIEVEMENT, self._RefreshData)
    self._RefreshData = nil;
    self._view.state_receiveAll:onClick(nil)
    M.super.OnDispose(self)
end


return AchievementMainUICtrl