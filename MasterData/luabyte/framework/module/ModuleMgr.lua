local ModuleMgr = BaseClass("ModuleMgr", Singleton)
local M = ModuleMgr

function M:SetModules()
    for k, v in pairs(ModuleConfig) do
        if v.isCS then 
            IModuleMgr:SetModuleType(v.id,v.path)
        else
            local m = require(v.path)
            if m then 
                m = m.New()
                m:SetModuleConfig(v)
                IModuleMgr:SetModule(v.id,m)
            end
        end
    end
end

function M:GetCurModuleId()
    return IModuleMgr:GetCurModuleId()
end

function M:ChangeModuleWithCallback( moduleId , callback , ...)
    local callObj = {}
    callObj.onComplete = callback
    self._onChangeCompleteHandler = callObj
    self:ChangeModule(moduleId,...)
end

function M:ChangeModule(moduleId, ...)
    IModuleMgr:ChangeModule(moduleId,...)
end

function M:OnModuleChangeComplete(moduleId,hasError)
    if self._onChangeCompleteHandler and self._onChangeCompleteHandler.onComplete then 
        self._onChangeCompleteHandler.onComplete(moduleId,hasError)
    end
    self._onChangeCompleteHandler = nil

    if moduleId == ModuleConfig.BattleModuleNew.id and hasError == false then
        JumpMgr:GetInstance():ResetJumpBack()
    end
end

function M:GetCurrentModule()
    return IModuleMgr:GetCurrentModule()
end

function M:Cleanup()
    
end

function M:Dispose()
    
end

function M:Ready()
    IModuleMgr:Ready()
end


return ModuleMgr
