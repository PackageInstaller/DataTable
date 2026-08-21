local M = BaseClass("CreateAcoountSecondCondition", BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args);
    return TimeUtil.IsInCreatRoleOpenTime(arg1)
end

return M
