local DailyGoalsScoreItemCtrl = BaseClass("DailyGoalsScoreItemCtrl")
local M = DailyGoalsScoreItemCtrl

function M:SubActivityId()
    return self._cfg.id
end

function M:State()
    return self._state
end

function M:Complete()
    return self._state == ActivityHelper.ESignState.COMPLETE_NOT_GAIN;
end

function M:Update(slider, cfg, activityId, isReward, maxCount)
    self._cfg = cfg
    self._isReward = isReward
    self._isBigReward = self._cfg.id == maxCount
    self._activityId = activityId

    self:_SetState(slider)
    self:_RefreshSlider(slider)
end

function M:_SetState(slider)
    self._state = ActivityHelper.ESignState.DOING;

    if self._isReward then
        self._state = ActivityHelper.ESignState.ALREADY_GAIN;
        return
    end

    if slider >= 1 then
        self._state = ActivityHelper.ESignState.COMPLETE_NOT_GAIN;
    end
end

function M:_RefreshSlider(slider)
    local cfg = ConfigHelper.GetCfg("itemGroup", self._cfg.reward)
    self._view.icon:SetItemIcon(cfg.items[1])
    self._view.labNum:SetText(tostring(cfg.cnts[1]))
    self._view.barValue:SetFillAmount(slider)
    self._view.value:SetText(tostring(self._cfg.score))
    self._view.state:SetState(self._state)
    self._view.effect:SetActive(self._state ~= ActivityHelper.ESignState.COMPLETE_NOT_GAIN and self._isBigReward)
end

function M:__init(view, index)
    self._view = view
    self._index = index

    self._view:SetActive(true)
    self._view.btn:onClick(Bind(self, self._OnClick))
end

function M:_OnClick()
    if self._state == ActivityHelper.ESignState.COMPLETE_NOT_GAIN then
        ActivityDataMgr:GetInstance():SendCommonReward(self._activityId, { self._cfg.id }, function(data)
            RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ThreeDayGoalLivenessChecker)
            GameHelper.ShowGetItems(data)
            EventMgr:Broadcast(UIMessageNames.ACTIVITY_COMMON_REWARD, data)
        end)
    else
        local itemGroup = ConfigHelper.GetCfg("itemGroup", self._cfg.reward)
        if #itemGroup.items > 1 then
            local isReceived = self._state == ActivityHelper.ESignState.ALREADY_GAIN
            local title = ConfigHelper.GetLocalString(293)
            local des = ConfigHelper.GetLocalString(709)
            GameHelper.ConfirmReward(self._cfg.reward, title, des, "", false, isReceived, nil)
        elseif #itemGroup.items == 1 then
            GameHelper.PopItem(itemGroup.items[1], itemGroup.cnts[1], self._view)
        end
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return DailyGoalsScoreItemCtrl
