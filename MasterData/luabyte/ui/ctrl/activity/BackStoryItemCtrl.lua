local M = BaseClass("BackStoryItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    local ctrl = require("UI.Ctrl.Task.TaskAwardItemCtrl")
    local view = require("UI.View.Task.TaskAwardItemView")
    self._view.list_task_award:Init(ctrl, view)
    self._view.rt_task_click:onClick(Bind(self, self.OnTaskClick))
    self._view.btn_enter:onClick(Bind(self, self.OnClickStory))
    self._view.rt_task_lock:onClick(Bind(self, self.OnClickMask))
    self._view.rt_lock:onClick(Bind(self, self.OnClickMask))
    self._view.btn_enter:SetState(1)
end

function M:UpdateItem(data)
    if not data then return end

    self.m_data = data
    local task = data.Task -- activitySevenDay_七日目标任务表
    local story = data.BackStory
    local roleAct = data.RoleAct
    local value = roleAct.Value0 > task.limitValue1 and task.limitValue1 or roleAct.Value0
    self.view.txt_task_desc:SetText(task.des)
    self.view.txt_task_prop:SetText(value .. "/" .. task.limitValue1)
    self._view.img_task_prog:SetFillAmount(value / task.limitValue1)
    self._view.rt_task_to:SetActive(roleAct.State == TaskConst.TaskState.Doing)
    self._view.rt_task_rece:SetActive(roleAct.State == TaskConst.TaskState.MissionComplete)
    self._view.rt_task_comp:SetActive(roleAct.State == TaskConst.TaskState.TaskComplete)
    self._view.rt_task_lock:SetActive(self.m_data.CurDay < self.m_data.OrderId)

    self._view.rt_lock:SetActive(roleAct.State ~= TaskConst.TaskState.TaskComplete)
    self._view.btn_enter:SetActive(roleAct.State == TaskConst.TaskState.TaskComplete)
    self._view.txt_name:SetText(story.storyTitle)
    self._view.txt_desc:SetText(ConfigHelper.GetLocalStringByPlayerName(story.storyDesc))
    self:_RefreshAwardItems(task)
end

function M:Dispose()
    self._view.list_task_award:Dispose()
    self._view.list_task_award = nil
    M.super.Dispose(self)
end

function M:_RefreshAwardItems(data)
    local list = {}
    local itemCfg = ConfigHelper.GetCfgByLua("itemGroup", data.reward)
    if itemCfg == nil then
        Logger.LogError(string.format("[策划同学请查表]itemGroup is null and awardId is %s", data.reward))
        return
    end
    for i = 1, #itemCfg.items do
        local Id = itemCfg.items[i]
        local Num = itemCfg.cnts[i]
        table.insert(list, { Id = Id, Num = Num })
    end
    self._view.list_task_award:SetDataList(list)
end

function M:OnTaskClick()
    if self.m_data.CurDay >= self.m_data.OrderId then
        if self.m_data.RoleAct.State == TaskConst.TaskState.Doing then
            GameHelper.Jump(self.m_data.Task.linkto)
        elseif self.m_data.RoleAct.State == TaskConst.TaskState.MissionComplete then
            local roleAct = self.m_data.RoleAct
            ActivityDataMgr:GetInstance():SendCommonReward(roleAct.ActivityId, { roleAct.SubActivityId },
                Bind(self, self.OnCommonRewardCallBack), { 1 })
        end
    else
        GameHelper.Tips(string.format("第%d天开启!", self.m_data.OrderId))
    end
end

function M:OnCommonRewardCallBack(rewardData)
    GameHelper.ShowGetItems(rewardData)
end

function M:OnClickStory()
    StoryDataMgr:GetInstance():TriggerStoryByGroup(self.m_data.BackStory.groupId)
end

function M:OnClickMask()
    GameHelper.Tips(string.format("第%d天开启!", self.m_data.OrderId))
    -- if self.m_lockId > 0 then
    --     local cfg = ConfigHelper.GetCfgByLua("openCondition", self.m_lockId)
    --     if cfg then
    --         GameHelper.TipsById(cfg.tips)
    --     else
    --         Logger.LogError("openCondition is nil, 请检查配表, id = " .. self.m_lockId)
    --     end
    -- end
end

return M
