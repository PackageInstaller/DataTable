-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Circle\\CircleCommonModel.lua

local Model = require("Entity/Model")
local EntityFactory = Framework.Entity.EntityFactory
local BoxCollider = typeof(UnityEngine.BoxCollider)
local DragUtils = Framework.Drag.DragUtils
local CircleCommonModel = Class("CircleCommonModel")

CircleCommonModel._id = 7777777

function CircleCommonModel:ctor(data, controlCenter)
	self.controlCenter = controlCenter
	CircleCommonModel._id = CircleCommonModel._id + 1
	self.eid = CircleCommonModel._id
	self.controller = EntityFactory.CreateEntity(self.eid, "circle", "circleState")
	self.transform = self.controller.transform
	self.data = data

	self:setParent()

	self.transform.position = self.data.pos

	if self.data.angle then
		self.transform.rotation = Quaternion.Euler(0, self.data.angle, 0)
	end

	self.type = data.type
	self._visible = true
	self.slotCallBack = Slot(self._loadedCallBack, self)

	self:createModel()
end

function CircleCommonModel:setParent(...)
	local parent = self.controlCenter.getRootTran()

	if parent then
		self.transform.parent = parent
	end
end

function CircleCommonModel:createModel(isHigh)
	local model

	self.model = Model(self.slotCallBack)

	self.model:setModelDataSimple(self.data.path, self.data.animator)

	model = self.model

	model:loadGameObject(false, false)
end

function CircleCommonModel:_loadedCallBack(...)
	local go = self.model.modelGameObject

	self.controller:InitModelAfterLoaded(go)
	self:showModel(self._visible)

	self.isModelLoaded = true

	if self.data.loadEndCB then
		self.data.loadEndCB()
	end

	if self.data.gridIndex and self.transform then
		DragUtils.AddCommonDragDataSimple(self.transform.gameObject, tostring(self.data.gridIndex))

		local col = self.transform.gameObject:AddComponent(BoxCollider)

		if col then
			col.center = Vector3(0, 0.7, 0)
		end
	end
end

function CircleCommonModel:getLogoTran(...)
	if self.controller then
		return self.controller:GetTopRootTransform()
	else
		return self.transform
	end
end

function CircleCommonModel:setPos(pos)
	if self.transform then
		self.transform.position = pos
	end
end

function CircleCommonModel:getTransform(name)
	if self.model then
		local tran

		if name ~= "" then
			tran = self.model.modelGameObject.transform:Find(name)
		else
			tran = self.model.modelGameObject.transform
		end

		return tran
	end
end

function CircleCommonModel:showModel(v)
	if self.model then
		self.model:setVisible(v)
	end

	self._visible = v

	if self.logo then
		local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

		if state and not state:isInHalfNear() then
			self.logo:setHide(true)
		else
			self.logo:setHide(not v)
		end
	end
end

function CircleCommonModel:getPos(...)
	if self.transform and not tolua.isnull(self.transform) then
		return self.transform.position
	end
end

function CircleCommonModel:playAnimation(animName, updateNow)
	self:showModel(true)

	if self.data.animator and self.model then
		self.model:playAnimation(animName, updateNow or false)
	end
end

function CircleCommonModel:playEffect(path, tranName)
	if self.effectId then
		EffectManager:releaseEffect(self.effectId)

		self.effectId = nil
	end

	if not self.effectId then
		local instId, controller = EffectManager:loadLogicEffect(path)

		controller:SetLayer("Effect")

		local tran

		if tranName then
			tran = self:getTransform(tranName)
		end

		controller:SetNormalEffect(tran, "", Vector3.zero, Vector3.zero, 0)

		self.effectId = instId
	end

	local controller = EffectManager:getController(self.effectId)

	if controller then
		controller:TurnOn()
	end
end

function CircleCommonModel:getVisible(...)
	return self._visible
end

function CircleCommonModel:returnLogo(...)
	if self.logo then
		self.controlCenter.returnLogo(self.logo)
	end

	self.logo = nil
end

function CircleCommonModel:refreshState(state)
	if not self.logo then
		self.logo = self.controlCenter.getLogo(Const.CIRCLE_LOGO_TYPE.PLAYER, self)
	end

	if not self._visible then
		self.logo:setHide(true)
	end

	self.logo:refreshState(state)
end

function CircleCommonModel:onMsgNotify(type, param)
	if not self.logo then
		self.logo = self.controlCenter.getLogo(Const.CIRCLE_LOGO_TYPE.PLAYER, self)
	end

	if not self._visible then
		self.logo:setHide(true)
	end

	self.logo:onMsgNotify(type, param)
end

function CircleCommonModel:_destroyLow(...)
	if self.model then
		self.model:destroy()

		self.model = nil
	end

	self.isModelLoaded = nil
end

function CircleCommonModel:_destroyHigh(...)
	if self.highModel then
		self.highModel:destroy()

		self.highModel = nil
	end

	self.isHighModelLoaded = nil
end

function CircleCommonModel:destroy(...)
	if self.effectId then
		EffectManager:releaseEffect(self.effectId)

		self.effectId = nil
	end

	self:_destroyHigh()
	self:_destroyLow()
	EntityFactory.ReleaseEntity(self.eid)

	if self.logo then
		self.controlCenter.returnLogo(self.logo)
	end

	self.logo = nil
	self.tweenCom = nil
	self.controller = nil
	self.transform = nil
end

return CircleCommonModel
