-- 假面舞会跳转控制器
local M = BaseClass("OpenMasqueradeUI", BaseJumpCommand)

function M:Execute(args)
    local activityId
    if args[1] > 0 then
        activityId = args[1]
    else
        activityId = args[4]
    end

    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=activityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误：" .. activityId)
        return
    end
    local uiName = activityCopys[1].UIMain
    ActivityCopyDataMgr:GetInstance():SetActivity(activityId)
    self:ShowUI(uiName, activityId)
    return true
end

return M
