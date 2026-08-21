local M = BaseClass('TaskCompletedCondition', BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    return TaskDataMgr:GetCompleteState(arg1)
end

return M
