-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/scene/stage/ProfilerSceneStage.lua

module("logic.extensions.hacktool.scene.stage.ProfilerSceneStage", package.seeall)

local ProfilerSceneStage = class("ProfilerSceneStage", SceneStageBase)
local kEmptySceneName = "sx-profile_ta_run"
local kEmptyScenePath = "sx-profile/scene_run/sx-profile_ta_run"

function ProfilerSceneStage:onInit()
	self._resLoader = MultiResLoader.New()
	self._mainSceneName = false
end

function ProfilerSceneStage:load(sceneId)
	self._mainSceneName = kEmptySceneName

	local resLoader = self._resLoader

	resLoader:addResPath(GameUrl.getSceneUrl(kEmptyScenePath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)
end

function ProfilerSceneStage:getSceneName()
	return self._mainSceneName
end

function ProfilerSceneStage:_onAllResourceLoaded()
	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	SceneUtil.removeArtTestSceneGameObject(self._mainSceneName)
	self:_onAllLoaded()
	ViewMgr.instance:closeAllViews(WindowType.WindowCloseReasonType.QuickCloseType)
end

function ProfilerSceneStage:unload()
	self._resLoader:clear()
end

return ProfilerSceneStage
