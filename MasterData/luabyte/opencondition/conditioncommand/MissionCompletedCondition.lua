local M = BaseClass('MissionCompletedCondition', BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    return MissionDataMgr:GetInstance():IsMissionPassById(arg1)
end

return M
