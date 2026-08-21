local M = BaseClass('GiftCondition', BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(arg1)
    if not IsNull(rshd) then return rshd:CheckGift(arg2) end
    return false
end

return M
