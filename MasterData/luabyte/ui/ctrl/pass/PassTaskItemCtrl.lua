local M = BaseClass("PassTaskItemCtrl")
local TaskState = PassConst.TaskState

function M:__init(view)
    self._view = view
    self.m_data = nil -- passTask
    self._view.itemPfb:EnablePopItem(true)
    self._view.rectReceive:onClick(Bind(self, self.OnClickGet))
    self._view.rectGoto:onClick(Bind(self, self.OnClickJump))
end

function M:OnDispose()
    self.m_data = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

--passTask
function M:UpdateItem(data)
    if data == nil then return end
    self.m_data = data

    local progNum = data.progress
    local limit = data.limitValue1
    self._view.txtDes:SetText(data.des)
    local fmtStr = "%s/<color=#5282FF>%s</color>"
    self._view.imgProgress:SetFillAmount(progNum / limit)
    local pointId = PassDataMgr:GetInstance():GetPassPointId()
    self._view.txtRatio:SetText(string.format(fmtStr, progNum, limit))
    self._view.itemPfb:SetInfo(pointId, ItemNumberType.TOTLE, data.num)

    self:_SetPassTaskCompleteState(data.state)
end

function M:_SetPassTaskCompleteState(state)
    local isReceived = state == TaskState.TaskComplete
    self._view.rectComplete:SetActive(isReceived)
    self._view.alphaTask:SetAlpha(isReceived and 0.5 or 1)
    self._view.rectGoto:SetActive(state == TaskState.Doing)
    self._view.rectReceive:SetActive(state == TaskState.MissionComplete)
end

function M:OnClickGet(go)
    if not self.m_data or (self.m_data.state ~= TaskState.MissionComplete) then return end
    local activityId = PassDataMgr:GetInstance():GetTaskActivityId()
    if activityId > 0 then
        ActivityDataMgr:GetInstance():SendCommonReward(activityId, { self.m_data.id }, Bind(self, self._OnRewardCallBack)
            , { 1 })
    else
        Logger.LogError("passTask activityId is " .. activityId)
    end
end

function M:_OnRewardCallBack(awardData)
    IRedPointMgr:ForceCheck(RedPointConst.PassCardTaskRedPointChecker)
    GameHelper.ShowGetItems(awardData)
end

function M:OnClickJump(go)
    JumpMgr:GetInstance():Execute(self.m_data.linkto)
end

return M
