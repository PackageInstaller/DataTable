-- 打开月签到
local M = BaseClass("OpenMonthSignUI", BaseJumpCommand)
local EActivityId = EnumConst.EActivityId

function M:Execute()
    if IGuideMgr.IsGuiding then
        CommandMgr:GetInstance():FinishExcute()
        return
    end
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module.moduleId ~= ModuleConfig.MainSceneModule.id then
        self:_OnClosePopup()
        return
    end
    local openConditionMonthSign = ConfigHelper.GetCfgPropByLua("functionOpen", 21, "openCondition")
    local isUnlockMonthSign = JumpMgr:GetInstance():CheckLockByOpenConditionIds(openConditionMonthSign)
    if not isUnlockMonthSign then
        self:_OnClosePopup()
        return
    end
    UIContextMgr:GetInstance():Show(UIDefine.UIActivity, EActivityId.MonthSign, Bind(self, self._OnClosePopup))
end

function M:_OnClosePopup()
    CommandMgr:GetInstance():FinishExcute()
end

return M
