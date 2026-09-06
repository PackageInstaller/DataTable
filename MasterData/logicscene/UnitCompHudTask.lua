-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudTask.lua

module("logicscene.scene.unit.component.hud.UnitCompHudTask", package.seeall)

local UnitCompHudTask = class("UnitCompHudTask", UnitComponentBase)
local TaskesHUDCache

function UnitCompHudTask:ctor(unit)
	UnitCompHudTask.super.ctor(self, unit)

	if not TaskesHUDCache then
		TaskesHUDCache = UnityEngine.GameObject.New("TaskesHUDCache")

		SceneHudMgr.instance:setHudCacheParent(SceneHudMgr.HUD_TASK_COMPELETE, TaskesHUDCache)
		SceneHudMgr.instance:setHudCacheParent(SceneHudMgr.HUD_TASK_ACCEPTED, TaskesHUDCache)
	end

	local unitGo = unit.go

	self._taskHud = goutil.create("taskHud", false)

	goutil.addChildToParent(self._taskHud, unitGo)

	self._hudObjCompelete = nil
	self._hudObjAccepted = nil
	self._isAccepted = nil
	self._isCompeleted = nil
	self._depth = nil
end

function UnitCompHudTask:onInit()
	self._unit.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
end

function UnitCompHudTask:setOffset(ofsX, ofsY, ofsZ)
	if ofsZ == 0 then
		ofsZ = -0.001
	end

	Framework.TransformUtil.SetLocalPos(self._taskHud.transform, ofsX, ofsY, ofsZ)
end

function UnitCompHudTask:setDepth(depth)
	self._depth = depth
end

function UnitCompHudTask:setAccepted(isAccepted)
	self._isAccepted = isAccepted

	if self._unit and not self._unit.isDestroyed and not self._unit:isClipping() and not self._isCompeleted and self._isAccepted then
		if not self._hudObjAccepted then
			local hudObj = SceneHudMgr.instance:getHud(SceneHudMgr.HUD_TASK_ACCEPTED, self._onHudLoaded, self)

			if self._hudObjAccepted then
				return
			end

			self._hudObjAccepted = hudObj
		end

		if self._hudObjAccepted then
			self._hudObjAccepted.transform:SetParent(self._taskHud.transform)
			Framework.TransformUtil.SetLocalPos(self._hudObjAccepted.transform, 0, 0, self._depth or 0)
			self._hudObjAccepted:SetActive(true)

			local boxCollider = self._hudObjAccepted.transform:GetChild(0).gameObject

			boxCollider.name = "NPC_" .. self._unit.npcId

			self:_updateDepthZ()
			self:setActive(self._unit:isVisible())
		end
	else
		self:_recycleAcceptedHud()
	end
end

function UnitCompHudTask:setCompeleted(isCompeleted)
	self._isCompeleted = isCompeleted

	if self._unit and not self._unit.isDestroyed and not self._unit:isClipping() and self._isCompeleted then
		if not self._hudObjCompelete then
			local hudObj = SceneHudMgr.instance:getHud(SceneHudMgr.HUD_TASK_COMPELETE, self._onHudLoaded, self)

			if self._hudObjCompelete then
				return
			end

			self._hudObjCompelete = hudObj
		end

		if self._hudObjCompelete then
			self._hudObjCompelete.transform:SetParent(self._taskHud.transform)
			Framework.TransformUtil.SetLocalPos(self._hudObjCompelete.transform, 0, 0, self._depth or 0)
			self._hudObjCompelete:SetActive(true)

			local boxCollider = self._hudObjCompelete.transform:GetChild(0).gameObject

			boxCollider.name = "NPC_" .. self._unit.npcId

			self:_updateDepthZ()
			self:setActive(self._unit:isVisible())
		end
	else
		self:_recycleCompeletedHud()
	end
end

function UnitCompHudTask:onUnitVisible(go)
	self:setAccepted(self._isAccepted)
	self:setCompeleted(self._isCompeleted)
end

function UnitCompHudTask:onUnitInVisible(go)
	self:_recycleAcceptedHud()
	self:_recycleCompeletedHud()
end

function UnitCompHudTask:onDestroy()
	self:setAccepted(nil)
	self:setCompeleted(nil)
	self._unit.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	self._taskHud = nil
end

function UnitCompHudTask:setActive(visible)
	if self._hudObjCompelete then
		self._hudObjCompelete:SetActive(visible)
	end

	if self._hudObjAccepted then
		self._hudObjAccepted:SetActive(visible)
	end
end

function UnitCompHudTask:_recycleCompeletedHud()
	if self._hudObjCompelete then
		SceneHudMgr.instance:recycle(SceneHudMgr.HUD_TASK_COMPELETE, self._hudObjCompelete)

		self._hudObjCompelete = nil
	end
end

function UnitCompHudTask:_recycleAcceptedHud()
	if self._hudObjAccepted then
		SceneHudMgr.instance:recycle(SceneHudMgr.HUD_TASK_ACCEPTED, self._hudObjAccepted)

		self._hudObjAccepted = nil
	end
end

function UnitCompHudTask:_onHudLoaded(hudType, go)
	if hudType == SceneHudMgr.HUD_TASK_ACCEPTED then
		self._hudObjAccepted = go

		self:setAccepted(self._isAccepted)
	else
		self._hudObjCompelete = go

		self:setCompeleted(self._isCompeleted)
	end
end

function UnitCompHudTask:_onUnitPosChanged(x, y, z, isTeleport)
	self:_updateDepthZ()
end

function UnitCompHudTask:_updateDepthZ()
	local scene = SceneMgr.instance:getCurScene()

	if scene.stage.wholeScene then
		local _, _, posZ = scene.stage.wholeScene:GetNpcUnitPosition(self._unit.npcId, nil, nil, nil)

		if self._hudObjCompelete then
			local x, y, z = Framework.TransformUtil.GetPos(self._hudObjCompelete.transform, nil, nil, nil)

			Framework.TransformUtil.SetPos(self._hudObjCompelete.transform, x, y, posZ)
		end

		if self._hudObjAccepted then
			local x, y, z = Framework.TransformUtil.GetPos(self._hudObjAccepted.transform, nil, nil, nil)

			Framework.TransformUtil.SetPos(self._hudObjAccepted.transform, x, y, posZ)
		end

		self._depth = posZ
	end
end

return UnitCompHudTask
