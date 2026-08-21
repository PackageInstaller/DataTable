local M = BaseClass("OpenTaskUI", BaseJumpCommand)
M.uiName = "TaskUI"

function M:Execute(args)
    if not TaskDataMgr:IsReady() then
        return false
    end 
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
