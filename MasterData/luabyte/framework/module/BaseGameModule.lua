local BaseGameModule = BaseClass("BaseGameModule")
local M = BaseGameModule

function M:__init()
    self._loadComplete = nil
    self._sceneName = nil
    self._moduleCfg = nil
    self._view = nil
    self.moduleId = 0
    self.isActive = false
    self.cameraDirector = nil
    self.isReady = false
    self.hasError = false
end

function M:SetModuleConfig(cfg)
    self._moduleCfg = cfg
    self.moduleId = cfg.id
end

function M:GetCurSceneName()
    return ISceneManager:GetCurSceneName()
end

function M:OnEnter(...)
end

function M:OnEnterNew(moduleId)

end

function M:OnDispose()
end

--退出
function M:OnExit(...)
    if self.cameraDirector then
        self.cameraDirector:Dispose()
    end

    self.cameraDirector = nil
    if self._ctrl and self._ctrl.OnDispose then
        self._ctrl:OnDispose()
    end
    if self._view then
        self._view:OnDispose()
    end

    self._view = nil
end

--新的module进入成功之后，会调用
function M:OnDisActive()

end

--获得CameraDirector
function M:GetCameraDirector()
    return self.cameraDirector
end

--设置CameraDirector
function M:CreateDirector(content)
    if self._moduleCfg.director then
        self.cameraDirector = require(self._moduleCfg.director).New(content)
    end
end

function M:DisposeCameraDirector()
    if self.cameraDirector then
        self.cameraDirector:Dispose()
    end

    self.cameraDirector = nil
end

function M:ChangeModule(moduleId, ...)
    ModuleMgr:GetInstance():ChangeModule(moduleId, ...)
end

function M:LoadScene(sceneName, loadComplete, loadingUI, uiParam, onStartLoad)
    if loadingUI == nil then
        loadingUI = "LoadingUI"
    end

    -- GameHelper.SetAudioState("Music", "Loading")
    self._sceneName = sceneName
    self._loadComplete = loadComplete
    ISceneManager:LoadSceneByUI(sceneName, loadingUI, true, uiParam, Bind(self, self.LoadComplete), onStartLoad)
    -- self._csModule:LoadScene(sceneName, Bind(self, self.LoadComplete), loadingUI, uiParam, onStartLoad)
end

function M:LoadComplete(topGos)
    collectgarbage("collect")
    local sceneObjectTable = require("Scenes.SceneObjectsTable")
    local view, ctrl = self:GetViewAndCtrl(self._sceneName)
    self._view = view
    self._ctrl = ctrl
    if self._loadComplete then
        self._loadComplete(self._view, ctrl)
        return
    end
end

function M:GetViewAndCtrl(sceneName)
    local sceneObjectTable = require("Scenes.SceneObjectsTable")

    if sceneObjectTable[sceneName] then
        local content = sceneObjectTable[sceneName]
        local arr = string.split(content, ",")
        local objectPath = arr[1]
        --local luaPath = arr[2]
        --local viewCls = require(luaPath)
        local go = CS.UnityEngine.GameObject.Find(objectPath)
        if IsNull(go) then
            return nil, nil
        end
        local view, ctrl = ResourceManager:GetInstance():GetViewAndCtrl(go)
        return view, ctrl
    end
    return nil, nil
end

function M:Ready()
    self.isReady = true
    ModuleMgr:GetInstance():Ready()
end

function M:ShowUI(uiName, ...)
    UIContextMgr:GetInstance():Show(uiName, ...)
end

function M:CloseUI(uiName)
    UIContextMgr:GetInstance():Close(uiName)
end

return BaseGameModule
