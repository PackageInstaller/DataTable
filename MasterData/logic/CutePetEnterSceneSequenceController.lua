-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/controller/CutePetEnterSceneSequenceController.lua

module("logic.extensions.cutepet.controller.CutePetEnterSceneSequenceController", package.seeall)

local CutePetEnterSceneSequenceController = class("CutePetEnterSceneSequenceController", BaseController)

CutePetEnterSceneSequenceController.Phase_None = 0
CutePetEnterSceneSequenceController.Phase_LoadMapConfigs = 1
CutePetEnterSceneSequenceController.Phase_LoadServerData = 2
CutePetEnterSceneSequenceController.Phase_ApplyEnterScene = 3

function CutePetEnterSceneSequenceController:ctor()
	self:onReset()
end

function CutePetEnterSceneSequenceController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.handlePM_OpenGardenLoadInfoResp, self._onAfterGetInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_EnterGameLoadInfoResp, self._onAfterGetInfo, self)
end

function CutePetEnterSceneSequenceController:onReset()
	self._phase = CutePetEnterSceneSequenceController.Phase_None
	self._context = {}
end

function CutePetEnterSceneSequenceController:_openCutePetByNotify()
	self:enterScene()
end

function CutePetEnterSceneSequenceController:enterScene()
	if self._phase == CutePetEnterSceneSequenceController.Phase_None then
		self._phase = CutePetEnterSceneSequenceController.Phase_LoadMapConfigs

		local scene = SceneMgr.instance:getCurScene()

		if scene and scene:getSceneType() ~= SceneType.CutePet then
			self:_doNext()
		end
	end
end

function CutePetEnterSceneSequenceController:completeEnterScene()
	GlobalDispatcher:dispatch(GlobalNotify.CutePetEnterSceneDone)
end

function CutePetEnterSceneSequenceController:_doNext()
	if self._phase == CutePetEnterSceneSequenceController.Phase_None then
		return
	end

	self._phase = self._phase + 1

	if self._phase == CutePetEnterSceneSequenceController.Phase_LoadMapConfigs then
		self:_loadMapConfigs()
	elseif self._phase == CutePetEnterSceneSequenceController.Phase_LoadServerData then
		self:_loadServerData()
	elseif self._phase == CutePetEnterSceneSequenceController.Phase_ApplyEnterScene then
		self:_applyEnterScene()
	end
end

function CutePetEnterSceneSequenceController:_loadMapConfigs()
	self:_doNext()
end

function CutePetEnterSceneSequenceController:_loadServerData()
	CutePetGardenAgent.instance:sendPM_OpenGardenLoadInfoReq()
end

function CutePetEnterSceneSequenceController:_applyEnterScene()
	SceneStatusMgr.instance:saveStatus()
	UIJumper.instance:saveCurStack()
	SceneMgr.instance:enter(SceneType.CutePet, 100, 0, 0)
end

function CutePetEnterSceneSequenceController:_onAfterGetInfo(status)
	if status == 0 then
		if CutePetModel.instance:getIsInit() == false then
			FloatWordMgr.instance:show(lang("等待数据中,稍后会自动进入"))

			return
		end

		if self._phase == CutePetEnterSceneSequenceController.Phase_LoadServerData then
			self:_doNext()
		end
	else
		self:onReset()
	end
end

CutePetEnterSceneSequenceController.instance = CutePetEnterSceneSequenceController.New()

return CutePetEnterSceneSequenceController
