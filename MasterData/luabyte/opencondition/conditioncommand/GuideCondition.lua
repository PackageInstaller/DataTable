local M = BaseClass("GuideCondition", BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    return IPlayerData.guideData:IsGuideDone(arg1)
end

return M
