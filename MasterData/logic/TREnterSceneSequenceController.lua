-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/controller/TREnterSceneSequenceController.lua

module("logic.extensions.treasureraider.controller.TREnterSceneSequenceController", package.seeall)

local TREnterSceneSequenceController = class("TREnterSceneSequenceController", BaseController)

TREnterSceneSequenceController.Phase_None = 0
TREnterSceneSequenceController.Phase_LoadMapConfigs = 1
TREnterSceneSequenceController.Phase_LoadServerData = 2
TREnterSceneSequenceController.Phase_ApplyEnterScene = 3

function TREnterSceneSequenceController:ctor()
	self:onReset()
end

function TREnterSceneSequenceController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("opentreasureraider", self._openTreasureRaiderByNotify, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderAfterGetInfo, self._onAfterGetInfo, self)
end

function TREnterSceneSequenceController:onReset()
	self._phase = TREnterSceneSequenceController.Phase_None
	self._context = {}
end

function TREnterSceneSequenceController:_openTreasureRaiderByNotify()
	self:enterScene()
end

function TREnterSceneSequenceController:enterScene(sceneMo)
	sceneMo = sceneMo or TreasureRaiderModel.instance:getCurSceneMo()

	if self._phase == TREnterSceneSequenceController.Phase_None then
		self._context.sceneMo = sceneMo
		self._phase = TREnterSceneSequenceController.Phase_LoadMapConfigs

		local scene = SceneMgr.instance:getCurScene()

		if scene then
			if scene:getSceneType() ~= SceneType.TreasureRaider then
				self:_doNext()
			else
				GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderReloadScene)
			end
		end
	end
end

function TREnterSceneSequenceController:completeEnterScene()
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderEnterSceneDone)
end

function TREnterSceneSequenceController:_doNext()
	if self._phase == TREnterSceneSequenceController.Phase_None then
		return
	end

	self._phase = self._phase + 1

	if self._phase == TREnterSceneSequenceController.Phase_LoadMapConfigs then
		self:_loadMapConfigs()
	elseif self._phase == TREnterSceneSequenceController.Phase_LoadServerData then
		self:_loadServerData()
	elseif self._phase == TREnterSceneSequenceController.Phase_ApplyEnterScene then
		self:_applyEnterScene()
	end
end

function TREnterSceneSequenceController:_loadMapConfigs()
	TreasureRaiderSceneModel.instance:initAll()
	self:_doNext()
end

function TREnterSceneSequenceController:_loadServerData()
	local activityId = TreasureRaiderConfig.instance:getActivityId()

	RichManAgent.instance:sendPM_RichManGetInfoReq(activityId)
end

function TREnterSceneSequenceController:_applyEnterScene()
	TilingSceneMgr.instance:enterTreasureRaiderScene()
end

function TREnterSceneSequenceController:_onAfterGetInfo(status)
	if status == 0 then
		if self._phase == TREnterSceneSequenceController.Phase_LoadServerData then
			self:_doNext()
		end
	else
		self:onReset()
	end
end

TREnterSceneSequenceController.instance = TREnterSceneSequenceController.New()

return TREnterSceneSequenceController
