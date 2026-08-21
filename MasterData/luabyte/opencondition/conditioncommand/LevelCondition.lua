local M = BaseClass("OpenLottery", BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    return arg1 <= IPlayerData.level
end

return M
