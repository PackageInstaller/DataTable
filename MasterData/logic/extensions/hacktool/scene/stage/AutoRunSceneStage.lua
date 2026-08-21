-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/scene/stage/AutoRunSceneStage.lua

module("logic.extensions.hacktool.scene.stage.AutoRunSceneStage", package.seeall)

local AutoRunSceneStage = class("AutoRunSceneStage", SceneStageBase)
local kEmptySceneName = "sx-profile_auto_play_run"
local kEmptyScenePath = "sx-profile/scene_run/sx-profile_auto_play_run"

function AutoRunSceneStage:onInit()
	self._resLoader = MultiResLoader.New()
	self._mainSceneName = false
end

function AutoRunSceneStage:load(sceneId)
	self._mainSceneName = kEmptySceneName

	local resLoader = self._resLoader

	resLoader:addResPath(GameUrl.getSceneUrl(kEmptyScenePath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
end

function AutoRunSceneStage:getSceneName()
	return self._mainSceneName
end

function AutoRunSceneStage:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	SceneUtil.removeArtTestSceneGameObject(self._mainSceneName)
	self:_onAllLoaded()
	ViewMgr.instance:closeAllViews(WindowType.WindowCloseReasonType.QuickCloseType)
end

function AutoRunSceneStage:unload()
	self._resLoader:clear()
end

return AutoRunSceneStage
