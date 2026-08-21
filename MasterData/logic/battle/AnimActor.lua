-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\battle\\AnimActor.lua

local ResModelActionConfig = require("ClientData/ResModelActionConfig")
local ModelTool = require("Entity/ModelTool")
local Entity = require("Entity/Entity")
local Model = require("Entity/Model")
local strClassName = "AnimActor"
local AnimActor = Class(strClassName, Entity)

function AnimActor:ctor(entitiId, name, modelId, animator, modelType)
	self.commonModelId = modelId
	self.animator = ModelTool.getControllerPath("Hero", animator)
	self.modelType = modelType

	self:createModel()
end

function AnimActor:_getActorModelInfo()
	local modelData = {}

	modelData.model_type = self.modelType or Const.MODEL_TYPE.Default
	modelData.model_id = self.commonModelId
	modelData.animator = self.animator

	return modelData
end

function AnimActor:createModel()
	if not self.modelLoadedCallback then
		self.modelLoadedCallback = Slot(self.OnModelLoadedEnd, self)
	end

	if self.entityModel ~= nil then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	if self.entityModel == nil then
		local modelData = self:_getActorModelInfo()

		if modelData then
			modelData.use_lod = Const.MODEL_LOD_LV1
			self.entityModel = Model(self.modelLoadedCallback, self.id)

			self.entityModel:setModelData(modelData)
			self.entityModel:loadGameObject(nil, false)
		end
	end

	return self.entityModel
end

function AnimActor:OnModelLoadedEnd()
	AnimActor.super.OnModelLoadedEnd(self)

	self.loaded = true
	self.modelObject = self.entityModel.modelGameObject
	self.animator = self.entityModel:getAnimator()

	self.entityModel:showModel(false)

	if self.isMirror then
		self:setModelMirror(self.isMirror)
	end

	if self.actionData then
		self:playActionData(true)
	end

	if self.aliveTime then
		self:startAliveTimer()
	end
end

function AnimActor:initPosition(pos, lookOffset)
	self:teleport(pos.x, pos.y, pos.z)

	if lookOffset then
		self.gameObject.transform:LookAt(pos + lookOffset)
	end
end

function AnimActor:setAliveTime(aliveTime)
	self.aliveTime = aliveTime

	if self.loaded then
		self:startAliveTimer()
	end
end

function AnimActor:startAliveTimer()
	if not self.aliveTimer then
		self.aliveTimer = Timer.New(Slot(self.destroy, self), 10, 1)
	end

	self.aliveTimer:Stop()

	self.aliveTimer.duration = self.aliveTime

	self.aliveTimer:Start()
end

function AnimActor:setModelMirror(isMirror)
	self.isMirror = isMirror

	if self.entityModel then
		self.entityModel:mirrorModel(isMirror)
	end
end

function AnimActor:playActionById(actionId)
	self.actionData = ResModelActionConfig[actionId]

	if not self.loaded then
		return
	end

	self:playActionData()
end

function AnimActor:playActionData(fromInit)
	if self.coPlayAction then
		coroutine.stop(self.coPlayAction)

		self.coPlayAction = nil
	end

	if self.actionData then
		self.coPlayAction = coroutine.start(self.coPlayActionData, self, fromInit)
	end
end

function AnimActor:coPlayActionData(fromInit)
	if fromInit then
		coroutine.wait(0)
	end

	self.entityModel:showModel(true)
	self:playAnimator(self.actionData.anim_name)

	local curFrame = 0

	for index = 1, #self.actionData.anim_event_list, 2 do
		local needFrame = tonumber(self.actionData.anim_event_list[index])
		local cueId = tonumber(self.actionData.anim_event_list[index + 1])

		if needFrame and cueId then
			if needFrame <= curFrame then
				CueManager.playCue(self, cueId)
			else
				coroutine.wait((needFrame - curFrame) / 30)

				curFrame = needFrame

				CueManager.playCue(self, cueId)
			end
		end
	end
end

function AnimActor:destroy()
	if self.coPlayAction then
		coroutine.stop(self.coPlayAction)
	end

	self.coPlayAction = nil

	CueManager.clearCue(self.id, self)

	if self.aliveTimer then
		self.aliveTimer:Stop()
	end

	AnimActor.super.destroy(self)

	self.modelObject = nil
end

local ENTITY_ID = BattleConst.ANIM_ACTOR_START_ID

function AnimActor.GetAnimActor(...)
	local entitiId = ENTITY_ID

	ENTITY_ID = ENTITY_ID + 1

	return AnimActor(entitiId, "AnimActor", ...)
end

return AnimActor
