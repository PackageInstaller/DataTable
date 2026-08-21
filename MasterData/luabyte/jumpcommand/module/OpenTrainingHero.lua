local M = BaseClass("OpenTrainingHero", BaseJumpCommand)
M.moduleId = ModuleConfig.RoleDevelopModule.id

function M:Execute(args)
    local heroId = 0
    if args and args[4] then 
        heroId = args[4]
    end
    if args and ( args[2] == 7 or args[2] == 8 ) then
        -- 跳转到时装
        local idx = args[2]
        if heroId == nil or heroId == 0 then 
            heroId = IPlayerData.pictureId
        end
        local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
        if heroData then
            -- 拥有的英雄正常跳转，没有的跳转到默认英雄
            self:ChangeModule(M.moduleId, heroId, idx)
        else
            self:ChangeModule(M.moduleId, heroId , idx)
        end
        --local module = ModuleMgr:GetInstance():GetCurrentModule()
        --时装界面需要隐藏基因
        -- if module.SetGeneSpin then
        --     module:SetGeneSpin(false)
        -- end
    else
        self:ChangeModule(M.moduleId, table.unpack(args))
    end
    
    return true
end

return M
