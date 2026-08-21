local DormDailyGoalsDayRewardCtrl = BaseClass("DormDailyGoalsDayRewardCtrl")
local M = DormDailyGoalsDayRewardCtrl



function M:Refresh(cfg, complete, data)
    self.m_data = cfg
    self.m_subData = data
    self:_DefaultSubData()
    self:_SetState()
end

function M:_DefaultSubData()
    if self.m_subData then
        return
    end

    self.m_subData = {}
    self.m_subData.State = 0
    self.m_subData.Value0 = 0
    self.m_subData.ActivityId = self.m_data.activityId
    self.m_subData.SubActivityId = self.m_data.id
end

function M:_SetState()
    self.uiState = 1
    self.m_state = ActivityHelper.ESignState.DOING;

    if self.m_subData.State == 0 then
        self._view.Text:SetText(5670)
    end

    if self.m_subData.State == 1 then
        self.m_state = ActivityHelper.ESignState.COMPLETE_NOT_GAIN;
        self.uiState = 2
    end

    if self.m_subData.State == 2 then
        self.m_state = ActivityHelper.ESignState.ALREADY_GAIN;
        self.uiState = 2
    end

    self._view.state:SetState(self.uiState)
end

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._OnClickItem))
    self.updateState = EventMgr:AddListener(UIMessageNames.ACTIVITY_OPEN_DORM, Bind(self, self._SetState))
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryActivityUI")
end

function M:_OnClickItem()
    if self.m_state == ActivityHelper.ESignState.COMPLETE_NOT_GAIN then
        ActivityDataMgr:GetInstance():SendCommonReward(self.m_subData.ActivityId, { self.m_subData.SubActivityId },
            function(data)
                if self.m_data.day == 1 then
                    DormDataMgr:EnterDormitoryStudio(self.context.heroId)
                end
                EventMgr:Broadcast(UIMessageNames.ACTIVITY_COMMON_REWARD, data)
            end)
    end

    if self.m_state == ActivityHelper.ESignState.ALREADY_GAIN then
        if self.m_data.day == 1 then
            DormDataMgr:EnterDormitoryStudio(self.context.heroId)
        end
    end
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ACTIVITY_OPEN_DORM, self.updateState)
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return DormDailyGoalsDayRewardCtrl
