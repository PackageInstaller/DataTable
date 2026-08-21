local TaskUICtrl = BaseClass("TaskUICtrl", BaseUICtrl)

local M = TaskUICtrl

function M:Init()
    -- self._view.rectGuideBook:onClick(Bind(self, self.OnGuideClick))
    -- self._view.rectDailyBook:onClick(Bind(self, self.OnDailyClick))
    -- self._view.rectWeeklyBook:onClick(Bind(self, self.OnWeeklyClick))
    -- self._view.rectChallengeBook:onClick(Bind(self, self.OnChallengeClick))

    -- self._view.recGuideLabel:onClick(Bind(self, self.OnGuideClick))
    -- self._view.rectDailyLabel:onClick(Bind(self, self.OnDailyClick))
    -- self._view.rectWeeklyLabel:onClick(Bind(self, self.OnWeeklyClick))
    -- self._view.rectChallengeLabel:onClick(Bind(self, self.OnChallengeClick))

    self._view.rectGuideTab:onClick(Bind(self, self.OnGuideTabClick))
    self._view.rectDailyTab:onClick(Bind(self, self.OnDailyTabClick))
    self._view.rectWeeklyTab:onClick(Bind(self, self.OnWeeklyTabClick))
    self._view.rectChallengeTab:onClick(Bind(self, self.OnChallengeTabClick))

    self._ctrlGuideTask = require("UI.Ctrl.Task.GuideTaskUICtrl").
        New(self._view.viewGuideTask)
    self._ctrlDailyTask = require("UI.Ctrl.Task.DailyTaskUICtrl").
        New(self._view.viewDailyTask)
    self._ctrlWeeklyTask = require("UI.Ctrl.Task.WeeklyTaskUICtrl").
        New(self._view.viewWeeklyTask)
    self._ctrlChallengeTask = require("UI.Ctrl.Task.ChallengeTaskUICtrl").
        New(self._view.viewChallengeTask)
end

function M:OnDispose()
    self._ctrlGuideTask:OnDispose()
    self._ctrlGuideTask = nil

    self._ctrlDailyTask:OnDispose()
    self._ctrlDailyTask = nil

    self._ctrlWeeklyTask:OnDispose()
    self._ctrlWeeklyTask = nil

    self._ctrlChallengeTask:OnDispose()
    self._ctrlChallengeTask = nil

    M.super.OnDispose(self)
end

function M:OnEnter(tabType)
    GameHelper.DoPlayerAction(PlayerAction.OpenTask)
    self._curType = tabType
    self._view.LabelGroup:SetState(tabType)
    if self._curType == TaskConst.TaskType.Guide then
        self._ctrlGuideTask:Open()
        self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Guide);
        --self._view.animTask:Play(TaskConst.AnimName.GuidePanel)
    elseif self._curType == TaskConst.TaskType.Daily then
        self._ctrlDailyTask:Open()
        self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Daily);
        --self._view.animTask:Play(TaskConst.AnimName.DailyPanel)
    elseif self._curType == TaskConst.TaskType.Weekly then
        self._ctrlWeeklyTask:Open()
        self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Weekly);
        --self._view.animTask:Play(TaskConst.AnimName.WeeklyPanel)
    elseif self._curType == TaskConst.TaskType.Challenge then
        self._ctrlChallengeTask:Open()
        self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Challenge);
        --self._view.animTask:Play(TaskConst.AnimName.ChallengePanel)
    end

    -- if tabType == TaskConst.TaskType.Guide then
    --     self:OnGuideClick()
    -- elseif tabType == TaskConst.TaskType.Daily then
    --     self:OnDailyClick()
    -- elseif tabType == TaskConst.TaskType.Weekly then
    --     self:OnWeeklyClick()
    -- elseif tabType == TaskConst.TaskType.Challenge then
    --     self:OnChallengeClick()
    -- end
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true 
end

-- function M:OnGuideClick()
--     if self._curType == TaskConst.TaskType.Menu then
--         self._curType = TaskConst.TaskType.Guide
--         self._view.animTask:SetTrigger(TaskConst.AnimName.GuideBook)
--         self._ctrlGuideTask:Open()
--     end
-- end

-- function M:OnDailyClick()
--     if self._curType == TaskConst.TaskType.Menu then
--         self._curType = TaskConst.TaskType.Daily
--         self._view.animTask:SetTrigger(TaskConst.AnimName.DailyBook)
--         self._ctrlDailyTask:Open()
--     end
-- end

-- function M:OnWeeklyClick()
--     if self._curType == TaskConst.TaskType.Menu then
--         self._curType = TaskConst.TaskType.Weekly
--         self._view.animTask:SetTrigger(TaskConst.AnimName.WeeklyBook)
--         self._ctrlWeeklyTask:Open()
--     end
-- end

-- function M:OnChallengeClick()
--     if self._curType == TaskConst.TaskType.Menu then
--         self._curType = TaskConst.TaskType.Challenge
--         self._view.animTask:SetTrigger(TaskConst.AnimName.ChallengeBook)
--         self._ctrlChallengeTask:Open()
--     end
-- end

--TabChange
function M:OnGuideTabClick()
    if self._curType ~= TaskConst.TaskType.Guide then
        local jumpCfg = ConfigHelper.GetCfgByLua("jump", 81)
        if jumpCfg then
            local unOpenId = GameHelper.GetFirstLockReason(jumpCfg.unlockIds)
            if unOpenId>0 then
                local conditionCfg = ConfigHelper.GetCfgByLua("openCondition", unOpenId)
                if conditionCfg then
                    GameHelper.TipsById(conditionCfg.tips)
                    return
                end
            end
        end
        GameHelper.Jump(81)
        return;
        -- self._curType = TaskConst.TaskType.Guide
        -- self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Guide);
        -- self._ctrlGuideTask:Open()
        -- self._view.LabelGroup:SetState(1)
    end
end

function M:OnDailyTabClick()
    if self._curType ~= TaskConst.TaskType.Daily then
        local jumpCfg = ConfigHelper.GetCfgByLua("jump", 82)
        if jumpCfg then
            local unOpenId = GameHelper.GetFirstLockReason(jumpCfg.unlockIds)
            if unOpenId>0 then
                local conditionCfg = ConfigHelper.GetCfgByLua("openCondition", unOpenId)
                if conditionCfg then
                    GameHelper.TipsById(conditionCfg.tips)
                    return
                end
            end
        end       
        GameHelper.Jump(82)
        return;
        -- self._curType = TaskConst.TaskType.Daily
        -- self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Daily);
        -- self._ctrlDailyTask:Open()
        -- self._view.LabelGroup:SetState(2)
    end
end

function M:OnWeeklyTabClick()
    if self._curType ~= TaskConst.TaskType.Weekly then
        local jumpCfg = ConfigHelper.GetCfgByLua("jump", 83)
        if jumpCfg then
            local unOpenId = GameHelper.GetFirstLockReason(jumpCfg.unlockIds)
            if unOpenId>0 then
                local conditionCfg = ConfigHelper.GetCfgByLua("openCondition", unOpenId)
                if conditionCfg then
                    GameHelper.TipsById(conditionCfg.tips)
                    return
                end
            end
        end
        GameHelper.Jump(83)
        return;
        -- self._curType = TaskConst.TaskType.Weekly
        -- self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Weekly);
        -- self._ctrlWeeklyTask:Open()
        -- self._view.LabelGroup:SetState(3)
    end
end

function M:OnChallengeTabClick()
    if self._curType ~= TaskConst.TaskType.Challenge then
        local jumpCfg = ConfigHelper.GetCfgByLua("jump", 84)
        if jumpCfg then
            local unOpenId = GameHelper.GetFirstLockReason(jumpCfg.unlockIds)
            if unOpenId>0 then
                local conditionCfg = ConfigHelper.GetCfgByLua("openCondition", unOpenId)
                if conditionCfg then
                    GameHelper.TipsById(conditionCfg.tips)
                    return
                end
            end
        end
        GameHelper.Jump(84)
        return;
        -- self._curType = TaskConst.TaskType.Challenge
        -- self._view.animTask:SetInteger("TaskType", TaskConst.TaskType.Challenge);
        -- self._ctrlChallengeTask:Open()
        -- self._view.LabelGroup:SetState(4)
    end
end


function M:OnBack()
    return true
    -- if self._curType == TaskConst.TaskType.Menu then
    --     if  self._view.animTask:IsCurrentState(TaskConst.AnimName.Menu) then
    --         return true 
    --     end
    --     return false 
    -- else
    --     local result = self:_ExitTaskPanel()
    --     if result then
    --         self._curType = TaskConst.TaskType.Menu
    --         self._view.animTask:SetTrigger(TaskConst.AnimName.Menu)
    --         return false 
    --     end
    --     return true 
    -- end
end

function M:_ExitTaskPanel()
    if self._curType == TaskConst.TaskType.Guide then
        if self._view.animTask:IsCurrentState(TaskConst.AnimName.GuideBook, TaskConst.AnimName.GuidePanel) then
            self._view.animTask:SetTrigger(TaskConst.AnimName.GuideOut)
            return true
        end
    elseif self._curType == TaskConst.TaskType.Daily then
        if self._view.animTask:IsCurrentState(TaskConst.AnimName.DailyBook, TaskConst.AnimName.DailyPanel) then
            self._view.animTask:SetTrigger(TaskConst.AnimName.DailyOut)
            return true
        end
    elseif self._curType == TaskConst.TaskType.Weekly then
        if self._view.animTask:IsCurrentState(TaskConst.AnimName.WeeklyBook, TaskConst.AnimName.WeeklyPanel) then
            self._view.animTask:SetTrigger(TaskConst.AnimName.WeeklyOut)
            return true
        end
    elseif self._curType == TaskConst.TaskType.Challenge then
        if self._view.animTask:IsCurrentState(TaskConst.AnimName.ChallengeBook, TaskConst.AnimName.ChallengePanel) then
            self._view.animTask:SetTrigger(TaskConst.AnimName.ChallengeOut)
            return true
        end
    end
    return false
end

return TaskUICtrl