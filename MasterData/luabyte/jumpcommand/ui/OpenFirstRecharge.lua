local M = BaseClass("OpenFirstRecharge", BaseJumpCommand)
M.uiName = "FirstRecharge"
M.isJumpBack = false
function M:Execute(args)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
