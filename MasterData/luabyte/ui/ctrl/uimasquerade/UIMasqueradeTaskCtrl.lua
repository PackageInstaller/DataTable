-- baoruichang
-- 2022/11/17 13:55:49
-- 预制体 Masquerade_TaskList
local UIMasqueradeTaskCtrl = BaseClass("UIMasqueradeTaskCtrl", BaseUICtrl)
local M = UIMasqueradeTaskCtrl
local tSort = table.sort

function M:Init()
    self.m_LineNum = 794
    self._view.btnBack:onClick(Bind(self, self.Close))
    self._view.baseTab:Init(0, Bind(self, self._OnClickTab))
    self.tabUIDanceTaskItemCtrl = {self._view.UIDanceTaskItemCtrl}
    self.tabUIDanceAchieveItemCtrl = {self._view.UIDanceAchieveItemCtrl}
    self._RefreshData = EventMgr:AddListener(UIMessageNames.NOTIFY_UPDATE_ACHIEVEMENT, Bind(self, self._OnRefreshDataCallBack))
    self._view.btnGetAll:onClick(Bind(self, self._BtnGetAll))
end

-- 进入UI，可传参数
function M:OnEnter(activityId, taskId)
    self._view.baseTab:TabSelect(0)
    self._view.baseTab:SetRedPointParma(0, 0, taskId)
    self._view.baseTab:SetRedPointParma(1, 0, activityId)
    self._view.baseTab:SetRedPointCheck(0)
    self._view.baseTab:SetRedPointCheck(1)
    self.activityId = activityId
end

function M:_OnClickTab(idx)
    self.idx = idx
    self.canGetTaskId = {}
    local tabIndex = 1
    if self.idx == 0 then -- 任务
        local taskData = self:GetContext():GetTaskData()
        self._view.tfTask:SetActive(true)
        self._view.tfAchieve:SetActive(false)
        tSort(taskData, self.SortData)
        for index, data in pairs(taskData) do
            local UIDanceTaskItemCtrl = self.tabUIDanceTaskItemCtrl[index]
            if not UIDanceTaskItemCtrl then
                UIDanceTaskItemCtrl = self._view.UIDanceTaskItemCtrl:Instantiate()
                self.tabUIDanceTaskItemCtrl[index] = UIDanceTaskItemCtrl
            end
            UIDanceTaskItemCtrl:UpdateItem(data)
            UIDanceTaskItemCtrl:SetOnClick(Bind(self, self._OnGoToClick), Bind(self, self._OnRewardClick))
            if data.state == 1 then
                self.canGetTaskId[tabIndex] = data.activityCopyTask.id
                tabIndex = tabIndex + 1
            end
        end
        self:_initBtnGetAllState(self.canGetTaskId)
    elseif self.idx == 1 then -- 成就
        self.canGetAcheveId = {}
        local acheveData = self:GetContext():GetAcheveData()
        self._view.tfTask:SetActive(false)
        self._view.tfAchieve:SetActive(true)
        local tasks = acheveData:Tasks()
        for index, task in pairs(tasks) do
            local UIDanceAchieveItemCtrl = self.tabUIDanceAchieveItemCtrl[index]
            if not UIDanceAchieveItemCtrl then
                UIDanceAchieveItemCtrl = self._view.UIDanceAchieveItemCtrl:Instantiate()
                self.tabUIDanceAchieveItemCtrl[index] = UIDanceAchieveItemCtrl
            end
            UIDanceAchieveItemCtrl:UpdateItem(task)
            UIDanceAchieveItemCtrl:ClickCallback(Bind(self, self._OnSelectItem))
            if task:State() == 1 then
                self.canGetAcheveId[tabIndex] = task:Id()
                tabIndex = tabIndex + 1
            end
        end
        self:_initBtnGetAllState({})
        self:_SetProgress(acheveData)
    end

end

function M:_initBtnGetAllState(ids)
    self._view.btnGetAll:SetActive(#ids > 0)
end

function M:_BtnGetAll()
    Logger.LogError("一键领取")
    if self.idx == 0 then -- 任务
        local activityId = self:GetContext():GetActivityId()
        ActivityDataMgr:GetInstance():SendCommonReward(activityId, self.canGetTaskId, Bind(self, self._OnRewardCallBack))
    else
    end
end

------------成就------------
function M:_OnSelectItem(id)
    AchievementDataMgr:GetInstance():SendRequestAchievementReward(self:GetContext():GetAchievementGroupId(), id)
end

function M:_SetProgress(data)
    local progress = math.floor(data:ProgressValue() * 100)
    local progress = progress > 100 and 100 or progress
    local progressText = string.format("%d/%d", data:Score(), data:AllScore())
    local valueText = string.format("<size=60>%d</size>", progress) .. "%"
    local cfg = data:Config()
    self._view.bar.size = data:ProgressValue()
    self._view.barValue:SetText(valueText)
    self._view.barText:SetText(progressText)
    self._view.icon:SetPic(cfg.icon[data:Level()])
end

function M:_OnRefreshDataCallBack()
    if self.idx == 1 then
        self:_OnClickTab(1)
    end
    IRedPointMgr:ForceCheck(RedPointConst.ActivityCopyAchievementRedPointChecker)
end
-------------成就------------

function M:_OnGoToClick(jumpId)
    local param1 = ConfigHelper.GetCfgPropByLua("jump", jumpId, "param1")
    local difficulty = ConfigHelper.GetCfgPropByLua("mission", param1, "difficulty")
    if difficulty == 2 then -- 困难关卡
        local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=self.activityId})
        self.activityCopy = activityCopys[1]
        local specialTime = self.activityCopy.specialTime
        local nowTime = TimeUtil:GetNowTimeStamp()
        if specialTime > nowTime then
            GameHelper.TipsById(6184)
            return
        end
    end
    JumpMgr:GetInstance():Execute(jumpId)
end

function M:_OnCreateAchieveItem(item)
    item:ClickCallback(Bind(self, self._OnSelectItem))
end

-- 领取任务成就
function M:_OnSelectItem(id)
    AchievementDataMgr:GetInstance():SendRequestAchievementReward(self:GetContext():GetAchievementGroupId(), id, Bind(self, self.RefTaskList))
end

--- id: activityCopyTaskId
function M:_OnRewardClick(id)
    local activityId = self:GetContext():GetActivityId()
    ActivityDataMgr:GetInstance():SendCommonReward(activityId, {id}, Bind(self, self._OnRewardCallBack))
end

function M:_OnRewardCallBack(awardData)
    GameHelper.ShowGetItems(awardData)
    self:GetContext():GetNewTaskData()
    IRedPointMgr:ForceCheck(RedPointConst.ActivityCopyTaskRedPointChecker)
end

function M:RefTaskList()
    self:_OnClickTab(self.idx or 0)
end

function M.SortData(data1, data2)
    if data1.sortIndex ~= data2.sortIndex then
        return data1.sortIndex > data2.sortIndex
    end
    return data1.activityCopyTask.id < data2.activityCopyTask.id
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.NOTIFY_UPDATE_ACHIEVEMENT, self._RefreshData)
    for _, value in ipairs(self.tabUIDanceTaskItemCtrl) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    for _, value in ipairs(self.tabUIDanceAchieveItemCtrl) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    M.super.OnDispose(self)
end

return UIMasqueradeTaskCtrl
