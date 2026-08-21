-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\TalkScenery.lua

local LoadUtils = require("Entity/LoadUtils")
local AvgConfig = require("DesignerScript/AvgConfig")
local AVGInfo = require("UI/AVG/AVGInfo")
local ResTalkSceneryNpc = require("ClientData/ResTalkSceneryNpc")
local Model = require("Entity/Model")
local ModelTool = require("Entity/ModelTool")
local CustomShadowManager = require("System/CustomShadowManager")
local Vector3 = Vector3
local Quaternion = Quaternion
local SPECIAL_ACTION_CHANGEMATERIAL = "1"
local SPECIAL_ACTION_RECOVERMATERIAL = "2"
local EntityScenery = Class("EntityScenery")

function EntityScenery:ctor(scene, data)
	self.scene = scene
	self.data = data
	self.modelLoaded = false

	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.Default
	modelData.model_id = data.model_id
	modelData.animator = data.animator
	self.model = Model(Slot(self.onModelLoaded, self))

	self.model:setModelData(modelData)
	self.model:loadGameObject()
end

function EntityScenery:destroy()
	self.model:destroy()
end

EntityScenery.TEMP_SHADOW_SCALE = {}

function EntityScenery:onModelLoaded()
	if self.data.add_base and self.data.add_base ~= 0 then
		ModelTool.addBaseModel(self.model._modelInsId, self.data.model_id, 1, Const.HERO_BASE_TYPE.Battle)
	end

	if self.data.layer then
		self.model:setModelLayer(self.data.layer)
	else
		self.model:setModelLayer(Const.LAYER_AVG_OUTSIDE)
	end

	if not self.scale then
		self.scale = self.data.scale
	end

	self.modelGo = self.model.modelGameObject
	self.modelTrans = self.modelGo.transform

	if self.setAfterLoaded then
		if self.hide then
			self:doHide(self.hide)
		else
			self:doAction(self.pos, self.rotate, self.action, self.specialAction, self.mountNpcId, self.scale)
		end

		self.setAfterLoaded = nil
	end

	if self.childNpcId then
		self.scene.mountNpc(self.data.id, self.childNpcId, self.childLocalPos, self.childLocalScale)
	end

	if EntityScenery.TEMP_SHADOW_SCALE[self.data.id] then
		CustomShadowManager.registerModelStageGameObject(self.modelGo, true, EntityScenery.TEMP_SHADOW_SCALE[self.data.id])
	else
		CustomShadowManager.registerModelStageGameObject(self.modelGo, true)
	end

	if self.parentToSet then
		self:setParent(self.parentToSet, self.parentToSetPosStay or false)

		self.parentToSetPosStay = nil
		self.parentToSet = nil
	end

	self.modelLoaded = true
end

function EntityScenery:doHide(isHide)
	self.hide = isHide

	if self.modelGo then
		self.modelGo:SetActive(not isHide)
	end
end

function EntityScenery:setParent(parent, posStay)
	if self.modelTrans ~= nil then
		self.modelTrans:SetParent(parent, posStay or false)
	else
		self.parentToSet = parent
		self.parentToSetPosStay = posStay
	end
end

function EntityScenery:doAction(pos, rotate, action, specialAction, mountNpcId, scale)
	self.mountNpcId = mountNpcId
	self.pos = pos
	self.rotate = rotate
	self.action = action
	self.specialAction = specialAction

	if scale then
		self.scale = scale
	end

	if self.hide then
		self:doHide(false)
	end

	if self.modelTrans == nil then
		self.setAfterLoaded = true

		return
	end

	if not self.scene.mountNpc(mountNpcId, self.data.id, self.pos, self.scale) then
		if self.pos then
			self.modelTrans.position = Vector3(self.pos[1], self.pos[2], self.pos[3])
		end

		if self.rotate then
			if #self.rotate == 1 then
				self.modelTrans.rotation = Quaternion.Euler(0, self.rotate[1] or 0, 0)
			else
				self.modelTrans.rotation = Quaternion.Euler(self.rotate[1], self.rotate[2], self.rotate[3])
			end
		end

		if self.scale then
			self.modelTrans.localScale = Vector3(self.scale, self.scale, self.scale)
		end
	end

	if action then
		self.model:playAnimation(action)
	end

	if specialAction then
		specialAction = utils.splitString(specialAction, ",")

		self:doSpecialAction(specialAction)
	end
end

function EntityScenery:doSpecialAction(paramList)
	if not paramList or #paramList < 1 then
		return
	end

	local actionType = paramList[1]

	if actionType == SPECIAL_ACTION_CHANGEMATERIAL then
		if not self.materialChanged then
			self.model:changeMaterial(paramList[2], paramList[3])

			self.materialChanged = true
		end
	elseif actionType == SPECIAL_ACTION_RECOVERMATERIAL and self.materialChanged then
		self.model:recoverMaterial()

		self.materialChanged = nil
	end
end

function EntityScenery:playAnimation(animName)
	if self.model and self.model:isLoaded() then
		self.model:playAnimation(animName)
	end
end

function EntityScenery:mountTimelineAnchor(timelineGo, index)
	local mountAnchor = AvgConfig.TIMELINE_ANCHOR[index]
	local anchorTrans = timelineGo.transform:Find(mountAnchor)

	self:setParent(anchorTrans, true)
end

function EntityScenery:unmountTimelineAnchor()
	local TalkScenery = require("UI/TalkScenery")
	local tempLoadRootTrans = TalkScenery.getTempLoadRootTrans()

	self:setParent(tempLoadRootTrans, true)
end

local TalkScenery = {}
local self = TalkScenery

function TalkScenery.ctor()
	self._curID = nil
	self._npcs = {}
end

function TalkScenery.showScenery(id)
	if self._npcs == nil then
		self.ctor()
	end

	if self._curID == id then
		return
	end

	if id == nil then
		return
	end

	local data = AVGInfo:getScenery(id)

	self.sceneryData = data

	if data == nil or data.action == nil then
		self.clear()

		return
	end

	self._curID = id

	if data.clear_all_npc == 1 then
		for npcID, npc in pairs(self._npcs) do
			if npc then
				npc:doHide()
			end
		end
	end

	for i, actionInfo in ipairs(data.action) do
		self._doAction(actionInfo)
	end

	if data.timeline_clear then
		self.clearTimeline()
	end

	if data.timeline_path then
		for npcID, npc in pairs(self._npcs) do
			if npc then
				npc:unmountTimelineAnchor()
			end
		end

		self.timelinePath = data.timeline_path
		self.timelineLoadedID = LoadUtils.loadPrefabAsync(data.timeline_path, Slot(self._timelineLoadedCB, self))
		self.timelineLoading = true
	end
end

function TalkScenery.clearTimeline()
	if self.timelineLoading then
		self.destroyTimelineAfterLoad = true
	end

	if self.timelineGo then
		UnityEngine.Object.Destroy(self.timelineGo)
	end
end

function TalkScenery:_timelineLoadedCB(go)
	if not go then
		return
	end

	self.timelineGo = go

	self.timelineGo:SetActive(false)
	self.timelineGo.transform:SetParent(self.getTempLoadRootTrans())

	if self.sceneryData.timeline_config then
		for index, npcID in ipairs(self.sceneryData.timeline_config) do
			local npc = self.getNpc(npcID, true)

			if npc then
				npc:mountTimelineAnchor(go, index)
			end
		end
	end

	coroutine.start(self.timelineSettingCo, self)
end

function TalkScenery.timelineSettingCo()
	while not TalkScenery.allModelLoaded() do
		coroutine.wait(0.1)
	end

	if self.timelineGo then
		if self.destroyTimelineAfterLoad then
			UnityEngine.Object.Destroy(self.timelineGo)

			self.destroyTimelineAfterLoad = false
		else
			self.timelineGo:SetActive(true)
		end
	end

	self.timelineLoading = false
end

function TalkScenery.getTempLoadRootTrans()
	if not self.tempLoadRoot then
		self.tempLoadRoot = UnityEngine.GameObject.Find("TempLoadRoot")
	end

	if self.tempLoadRoot then
		self.tempLoadRootTrans = self.tempLoadRoot.transform
	end

	return self.tempLoadRootTrans
end

function TalkScenery._doAction(actionInfo)
	local npcID = actionInfo.npc_id
	local npc = self.getNpc(npcID, actionInfo.show)

	if npc then
		if actionInfo.hide then
			npc:doHide(true)
		else
			npc:doAction(actionInfo.pos, actionInfo.rotation, actionInfo.action, actionInfo.special_action, actionInfo.show, actionInfo.scale)
		end
	end
end

function TalkScenery.getNpc(npcID, needCreate)
	local npc = self._npcs[npcID]

	if npc == nil and needCreate then
		local data = ResTalkSceneryNpc[npcID]

		if data then
			npc = EntityScenery(self, data)
			self._npcs[npcID] = npc
		end
	end

	return npc
end

function TalkScenery.clear()
	if self._npcs == nil then
		return
	end

	for npcId, npc in pairs(self._npcs) do
		npc:destroy()
	end

	self._npcs = {}
	self._curID = nil

	self.clearTimeline()
end

function TalkScenery.mountNpc(parentNpcId, childNpcId, childLocalPos, childLocalScale)
	local parent = self._npcs[parentNpcId]
	local child = self._npcs[childNpcId]

	if not parent or not child then
		return false
	end

	if not parent.modelTrans then
		parent.childNpcId = childNpcId
		parent.childLocalPos = childLocalPos
		parent.childLocalScale = childLocalScale

		return false
	end

	if not child.modelTrans then
		return false
	end

	child.modelTrans.localScale = Vector3(childLocalScale, childLocalScale, childLocalScale)
	childLocalPos = childLocalPos or {
		0,
		0,
		0
	}
	child.modelTrans.parent = parent.modelTrans:Find("Bone_Base")
	child.modelTrans.localPosition = Vector3(childLocalPos[1], childLocalPos[2], childLocalPos[3])
	child.modelTrans.localRotation = Quaternion.Euler(0, 0, 0)

	return true
end

function TalkScenery.allModelLoaded()
	for _, entity in pairs(self._npcs) do
		if not entity.modelLoaded then
			return false
		end
	end

	return true
end

return TalkScenery
