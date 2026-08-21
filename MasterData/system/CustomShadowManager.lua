-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\CustomShadowManager.lua

local EventConst = require("EventConst")
local ShadowMapHelper = Framework.Render.ShadowMap.ShadowMapHelper
local ShadowMapManager = Framework.Render.ShadowMap.ShadowMapManager
local UPDATE_INTERVAL = 0.2
local SHADOW_MAP_SIZE = 2048
local SHADOW_MAP_SIZE_HUAWEI = 2048
local SHADOW_STATE_ID = {
	PERFORM = 2,
	OFF = 0,
	MODEL_STAGE = 3,
	BATTLE = 1
}
local SWITCH_DICT = {
	[SHADOW_STATE_ID.OFF] = true,
	[SHADOW_STATE_ID.BATTLE] = true,
	[SHADOW_STATE_ID.PERFORM] = true,
	[SHADOW_STATE_ID.MODEL_STAGE] = true
}
local ShadowState = Class("ShadowState")

function ShadowState:ctor(stateID)
	self.stateID = stateID
	self.isOn = SWITCH_DICT[stateID]
	self._active = false
end

function ShadowState:enter(oldStateID, ...)
	local succ = true

	if not self.isOn then
		succ = false

		return succ
	end

	if oldStateID ~= self.stateID then
		self:_onActiveChanged(true)
	end

	self:_onEnterCommon(...)

	return succ
end

function ShadowState:_onActiveChanged(active)
	self._active = active
end

function ShadowState:_onEnterCommon(...)
	return
end

function ShadowState:_shouldExit(...)
	return true
end

function ShadowState:exit(newStateID, ...)
	local succ = true

	if self.stateID ~= newStateID then
		self:_onActiveChanged(false)
	elseif self:_shouldExit(...) then
		self:_onActiveChanged(false)
	else
		succ = false
	end

	return succ
end

local ShadowStateOff = Class("ShadowStateOff", ShadowState)

function ShadowStateOff:_onActiveChanged(active)
	ShadowStateOff.super._onActiveChanged(self, active)

	if active then
		ShadowMapManager.ClearLight()
	end
end

local ShadowStateBattle = Class("ShadowStateBattle", ShadowState)

function ShadowStateBattle:_onActiveChanged(active)
	ShadowStateBattle.super._onActiveChanged(self, active)
	ShadowMapHelper.RegisterDefaultLightAndCamera(active)
	ShadowMapManager.SetVisibleLayer("Battle", Const.LAYER_PLAYER, active)
	ShadowMapManager.SetVisibleLayer("Battle", Const.LAYER_NPC, active)
	ShadowMapManager.SetShadowFrustrumStatic(active)

	if not active then
		ShadowMapManager.RemoveStaticBounds("Battle")
	end
end

function ShadowStateBattle:_onEnterCommon(x, y, z, radius)
	ShadowMapHelper.RegisterDefaultLightAndCamera(true)
	ShadowMapManager.AddStaticBounds("Battle", x, y, z, radius)
	ShadowMapManager.RefreshShadow()
end

local ShadowStatePerform = Class("ShadowStatePerform", ShadowState)

function ShadowStatePerform:ctor(stateID)
	self._actors = {}
end

function ShadowStatePerform:_onActiveChanged(active)
	ShadowStatePerform.super._onActiveChanged(self, active)

	if not active then
		ShadowMapHelper.RegisterDefaultLightAndCamera(false)
	end

	ShadowMapManager.SetVisibleLayer("Perform", Const.LAYER_PLAYER, active)
	ShadowMapManager.SetVisibleLayer("Perform", Const.LAYER_NPC, active)

	if not active then
		self._actors = {}

		ShadowMapManager.RemoveAllGameObjects()
	end
end

function ShadowStatePerform:_onEnterCommon(actors)
	ShadowMapHelper.RegisterDefaultLightAndCamera(true)

	local toActive = {}
	local toDeactive = {}

	if self._actors == nil then
		self._actors = {}
	end

	if actors == nil then
		actors = {}
	end

	local oldActors = self._actors

	for actorID, actor in pairs(oldActors) do
		if not actors[actorID] then
			toDeactive[actorID] = actor
		end
	end

	toActive = actors

	for _, actor in pairs(toDeactive) do
		local go = actor.entityModel and actor.entityModel.modelGameObject

		if go then
			ShadowMapHelper.RegisterGameObject(go, false, false)
		end
	end

	for _, actor in pairs(toActive) do
		local go = actor.entityModel and actor.entityModel.modelGameObject

		if go then
			if self._timelineMode then
				ShadowMapHelper.RegisterGameObject(go, true, false, 1, 0.2, true, 4)
			else
				ShadowMapHelper.RegisterGameObject(go, true, false)
			end
		end
	end

	self._actors = actors
end

local ShadowStateModelStage = Class("ShadowStateModelStage", ShadowState)

function ShadowStateModelStage:ctor(stateID)
	self._curModelStage = nil
end

function ShadowStateModelStage:_onActiveChanged(active)
	ShadowStateModelStage.super._onActiveChanged(self, active)
	ShadowMapHelper.SetModelStageMode(active)

	if not active then
		local modelStage = self._curModelStage

		if modelStage and not tolua.isnull(modelStage) then
			ShadowMapHelper.RegisterModelStageCamera(modelStage, false)
		end

		ShadowMapManager.RemoveAllGameObjects()
		ShadowMapManager.ClearVisibleLayer()
	end
end

function ShadowStateModelStage:_onEnterCommon(modelStage)
	self._curModelStage = modelStage

	ShadowMapHelper.RegisterModelStageCamera(modelStage, true)
end

function ShadowStateModelStage:_shouldExit(modelStage)
	if self._curModelStage == modelStage then
		return true
	end
end

function ShadowStateModelStage:onModelStageLoaded(go)
	if self.isOn then
		ShadowMapHelper.CollectModelStageLight(go)
	end
end

function ShadowStateModelStage:onSceneLoaded()
	if self.isOn then
		local light = ShadowMapHelper.GetSceneLight()

		if light then
			ShadowMapHelper.AddModelStageLight(nil, light)
		end
	end
end

local CustomShadowManager = {}
local self = CustomShadowManager

self.SHADOW_STATE_ID = SHADOW_STATE_ID

function CustomShadowManager.init()
	self._stateDict = {}

	for name, id in pairs(SHADOW_STATE_ID) do
		self._stateDict[id] = self._createState(id)
	end

	self._curStateID = SHADOW_STATE_ID.OFF

	if ClientUtils.isHuawei() then
		ShadowMapManager.SetTextureSize(SHADOW_MAP_SIZE_HUAWEI)
	else
		ShadowMapManager.SetTextureSize(SHADOW_MAP_SIZE)
	end

	ShadowMapManager.SetUpdateInterval(UPDATE_INTERVAL)
	EventCenter.addEventListener(EventConst.SCENE_LOADED, self.onSceneLoaded)
end

function CustomShadowManager.setTimelineMode(active)
	local state = self.getState(SHADOW_STATE_ID.PERFORM)

	state._timelineMode = active
end

function CustomShadowManager._createState(id)
	if id == SHADOW_STATE_ID.BATTLE then
		return ShadowStateBattle(id)
	elseif id == SHADOW_STATE_ID.PERFORM then
		return ShadowStatePerform(id)
	elseif id == SHADOW_STATE_ID.MODEL_STAGE then
		return ShadowStateModelStage(id)
	else
		return ShadowStateOff(id)
	end
end

function CustomShadowManager.isInState(stateID)
	return self._curStateID == stateID
end

function CustomShadowManager.getCurState()
	return CustomShadowManager.getState(self._curStateID)
end

function CustomShadowManager.getState(stateID)
	return self._stateDict[stateID]
end

function CustomShadowManager.clearShadow()
	self._handlerRequest(SHADOW_STATE_ID.OFF, true)
end

function CustomShadowManager.setBattleShadowActive(active, x, y, z, radius)
	self._handlerRequest(SHADOW_STATE_ID.BATTLE, active, x, y, z, radius)
end

function CustomShadowManager.setPerformShadowActive(active, actorDict)
	self._handlerRequest(SHADOW_STATE_ID.PERFORM, active, actorDict)
end

function CustomShadowManager.setModelStageShadowActive(active, modelStage)
	self._handlerRequest(SHADOW_STATE_ID.MODEL_STAGE, active, modelStage)
end

function CustomShadowManager.registerPerformGameObject(go, active, radiusScale)
	active = active == true

	local name = go and go.name

	ShadowMapHelper.RegisterGameObject(go, active, true, 1, 0.2, true, radiusScale or 1.5)
end

function CustomShadowManager.registerModelStageGameObject(go, active, radiusScale)
	active = active == true

	local name = go and go.name

	if name == nil or string.find(name, "Hand_NoviceStory") then
		return
	end

	if not radiusScale then
		ShadowMapHelper.RegisterGameObject(go, active, true)
	else
		ShadowMapHelper.RegisterGameObject(go, active, true, 1, 0.2, true, radiusScale)
	end
end

function CustomShadowManager.onModelStageLoaded(go)
	local state = self.getState(SHADOW_STATE_ID.MODEL_STAGE)

	state:onModelStageLoaded(go)

	local state = self.getState(SHADOW_STATE_ID.MODEL_STAGE)

	state:onSceneLoaded()
end

function CustomShadowManager.onSceneLoaded()
	local state = self.getState(SHADOW_STATE_ID.MODEL_STAGE)

	state:onSceneLoaded()

	if self.isInState(SHADOW_STATE_ID.PERFORM) then
		ShadowMapHelper.RegisterDefaultLightAndCamera(true)
	end
end

function CustomShadowManager.manualRegisterModelStageLight(isRegister, go)
	if isRegister then
		local state = self.getState(SHADOW_STATE_ID.MODEL_STAGE)

		if state.isOn then
			ShadowMapHelper.CollectModelStageLight(go)
			ShadowMapHelper.RegisterLightForModelStage(go, true)
		end
	else
		ShadowMapHelper.RegisterLightForModelStage(go, false)
		ShadowMapHelper.ClearModelStageLight(go)
	end
end

function CustomShadowManager.forceRegisterCamera(modelStageObj)
	ShadowMapHelper.RegisterModelStageCamera(modelStageObj, true)
end

function CustomShadowManager._handlerRequest(stateID, active, ...)
	active = active == true

	local curStateID = self._curStateID
	local curState = self.getState(curStateID)

	if curStateID == stateID then
		if active then
			curState:enter(curStateID, ...)
		else
			if curState:exit(stateID, ...) then
				self._curStateID = SHADOW_STATE_ID.OFF
			end

			if curStateID == SHADOW_STATE_ID.MODEL_STAGE then
				EventCenter.sendEvent(EventConst.REFRESH_SHADOW)
			end
		end
	else
		local newState = self.getState(stateID)

		if active and curState:exit(stateID) then
			if newState:enter(curStateID, ...) then
				self._curStateID = stateID
			else
				local offState = self.getState(SHADOW_STATE_ID.OFF)

				self._curStateID = SHADOW_STATE_ID.OFF
			end
		end
	end
end

return CustomShadowManager
