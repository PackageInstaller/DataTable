local M = BaseClass("OpenShopUI", BaseJumpCommand)

function M:Execute(args)
    if not ShopDataMgr:IsReady() or not RechargeDataMgr:GetInstance():IsReady() then
        return false
    end 
    local moduleId = IModuleMgr:GetCurModuleId()
    if moduleId ~= ModuleConfig.MainSceneModule.id then 
        self:ChangeModule( ModuleConfig.MainSceneModule.id, "ShopUI", table.unpack(args))
    else
        self:ShowUI("ShopUI", table.unpack(args))
    end
    return true
end

return M
