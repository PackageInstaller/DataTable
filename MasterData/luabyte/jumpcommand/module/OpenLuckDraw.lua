local M = BaseClass("OpenLuckDraw", BaseJumpCommand)
M.moduleId = ModuleConfig.Lottery.id

function M:Execute(args)
    self:ChangeModule(M.moduleId, table.unpack(args))
    return true
end

return M
