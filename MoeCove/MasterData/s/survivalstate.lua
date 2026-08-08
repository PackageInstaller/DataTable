
require "FSM"
require "GameFlowState"
local SurvivalLog = require "SurvivalLog"

---@class SurvivalState : FSMState
local SurvivalState = FSMState:new("SurvivalState", GameFlowState.SurvivalState)

function SurvivalState:update()
    if SurvivalManager.instance() then
        SurvivalManager.instance():Update()
    end
end

function SurvivalState:enter()
    SurvivalLog.Enter()
    UIMgr:switchUIDataGroup(UIGroup.Survival)
    local survivalRootPath = Config.PrefabPath.SurvivalRoot
    local mapScenePath = string.format(Config.ScenePath.BattleMapScene, "map1002", "map1002")
    ResMgr:LoadSceneAsyncLua(mapScenePath, false, function(sceneName)
        LuaLogger.ds("SurvivalMapScene load over", mapScenePath)
        ResMgr:LoadGameObjectAsync(survivalRootPath, function(obj)
            LuaLogger.ds("SurvivalRoot load over", survivalRootPath)
            self.survivalRoot = obj
            LoadingMgr:UpdateProgress(1)
            UIMgr:popUI(
                "SurvivalMainPanel", 
                {},
                nil,
                nil,
                nil,
                function()
                    SurvivalManager.instance():Init()
                    SurvivalManager.instance():ChangeState(GE.SurvivalStateEnum.Prepare)
                    LoadingMgr:SetLoadingOver(nil, nil, "SurvivalState")
                end
            )
        end)
    end)
end

function SurvivalState:GetSurvivalRoot()
    return self.survivalRoot
end

function SurvivalState:exit()
    LuaLogger.ds("SurvivalState:exit")
    if SurvivalManager.instance() then
        SurvivalManager.instance():Clear()
    end
    SurvivalLog.Restore()
    if UICommonUtils.Checkobj(self.survivalRoot) then
        DUtil.Destroy(self.survivalRoot)
    end
    self.survivalRoot = nil
    UIMgr:clearAllUI()
    PoolMgr:Clear()
    -- AssetManager.Instance:UnloadUnusedAssets()
    collectgarbage("collect")
    -- ResMgr:UnloadUnusedBundles(true)
end

return SurvivalState