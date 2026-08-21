local M = BaseClass('HeroFavorCondition', BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    local data = IHeroDataMgr:GetMyHeroDataById(arg1)
    if data then
        local rshd = data:GetRoleStudioHeroData()
        if not rshd then return false end
        return rshd:GetFavorLevel() >= arg2
    end
    return false
end

return M
