-- chunkname: @modules/logic/scene/udimo/entitycomp/UdimoSpineComp.lua

module("modules.logic.scene.udimo.entitycomp.UdimoSpineComp", package.seeall)

local UdimoSpineComp = class("UdimoSpineComp", UnitSpine)

function UdimoSpineComp:init(go)
	UdimoSpineComp.super.init(self, go)

	self._willDestroy = false

	self:loadSpine()
end

function UdimoSpineComp:loadSpine()
	local udimoId = self.unitSpawn:getId()
	local res = UdimoConfig.instance:getUdimoSpineRes(udimoId)
	local spinePath = ResUrl.getUdimoPrefab(res)

	self.setResPath(self, spinePath, self._onSpineLoaded, self, true)
end

function UdimoSpineComp:_onSpineLoaded()
	if self._willDestroy then
		return
	end

	if not gohelper.isNil(self._spineGo) and not gohelper.isNil(self._spineTr) then
		self._spineMeshRenderer = self._spineTr:GetComponent(typeof(UnityEngine.MeshRenderer))

		if self._curOrderLayer then
			self._spineMeshRenderer.sortingOrder = self._curOrderLayer
		else
			self:refreshOrderLayer()
		end

		local udimoId = self.unitSpawn:getId()
		local box = gohelper.onceAddComponent(self._spineGo, typeof(UnityEngine.BoxCollider2D))
		local strSize = UdimoConfig.instance:getUdimoColliderSize(udimoId)

		if not string.nilorempty(strSize) then
			local sizeArr = string.splitToNumber(strSize, "#")

			box.size = Vector2(sizeArr[1], sizeArr[2])
		end

		local strOffset = UdimoConfig.instance:getUdimoColliderOffset(udimoId)

		if not string.nilorempty(strOffset) then
			local offsetArr = string.splitToNumber(strOffset, "#")

			box.offset = Vector2(offsetArr[1], offsetArr[2])
		end

		box.enabled = true

		local scale = UdimoConfig.instance:getUdimoSceneSpineScale(udimoId)

		transformhelper.setLocalScale(self._spineTr, scale, scale, 1)
	end

	self:addEventListeners()

	local scene = UdimoController.instance:getUdimoScene()

	if scene then
		scene.level:addGameObjectToColorCtrl(self._gameObj, true)

		local udimoId = self.unitSpawn:getId()
		local outlineRes = UdimoConfig.instance:getUdimoOutlineRes(udimoId)

		if not string.nilorempty(outlineRes) then
			self.outLineEffResPath = ResUrl.getEffect(outlineRes)

			if GameResMgr.IsFromEditorDir then
				self.outLineEffResAbPath = nil
			else
				self.outLineEffResAbPath = FightHelper.getEffectAbPath(self.outLineEffResPath)
			end

			local var_3_0 = {}

			var_3_0[1] = self.outLineEffResAbPath or self.outLineEffResPath

			scene.loader:makeSureLoaded(var_3_0, self._onLoadOutlineEff, self)
		end
	end
end

function UdimoSpineComp:_onLoadOutlineEff()
	local scene = UdimoController.instance:getUdimoScene()

	if not scene or self._willDestroy or gohelper.isNil(self._spineGo) then
		return
	end

	local assetRes = scene.loader:getResource(self.outLineEffResPath, self.outLineEffResAbPath)
	local goOutline = gohelper.clone(assetRes, self._spineGo)

	self._effectOrderContainer = gohelper.onceAddComponent(goOutline, typeof(ZProj.EffectOrderContainer))

	if self._curOrderLayer then
		self._effectOrderContainer:SetBaseOrder(self._curOrderLayer)
	else
		self:refreshOrderLayer()
	end
end

function UdimoSpineComp:addEventListeners()
	UdimoController.instance:registerCallback(UdimoEvent.PlayUdimoAnimation, self._onPlayAnimation, self)
end

function UdimoSpineComp:removeEventListeners()
	UdimoController.instance:unregisterCallback(UdimoEvent.PlayUdimoAnimation, self._onPlayAnimation, self)
end

function UdimoSpineComp:_onPlayAnimation(targetUdimoId, animaData, cb, cbObj, cbParam)
	local udimoId = self.unitSpawn:getId()

	if not targetUdimoId or udimoId ~= targetUdimoId then
		return
	end

	if self._willDestroy or gohelper.isNil(self._spineGo) or not animaData then
		return
	end

	self._animEndCb = cb
	self._animEndCbObj = cbObj
	self._animEndCbParam = cbParam

	self.removeAnimEventCallback(self, self._onAnimEvent, self)
	self.addAnimEventCallback(self, self._onAnimEvent, self)

	local animName = animaData.name
	local isLoop = animaData.isLoop
	local reStart = animaData.reStart

	self:playAnim(animName, isLoop, reStart)
end

function UdimoSpineComp:_onAnimEvent(actionName, eventName, eventArgs)
	if self._willDestroy then
		return
	end

	if eventName == SpineAnimEvent.ActionComplete then
		self.removeAnimEventCallback(self, self._onAnimEvent, self)

		if self._animEndCb then
			if self._animEndCbObj then
				self._animEndCb(self._animEndCbObj, self._animEndCbParam)
			else
				self._animEndCb(self._animEndCbParam)
			end
		end

		self._animEndCb = nil
		self._animEndCbObj = nil
		self._animEndCbParam = nil
	end
end

function UdimoSpineComp:refreshOrderLayer(targetState)
	if self._willDestroy or not self.unitSpawn then
		return
	end

	local orderLayer
	local udimoId = self.unitSpawn:getId()

	if not targetState then
		::label_9_0::

		local state = self.unitSpawn:getState()

		if state == UdimoEnum.UdimoState.WaitInteract or state == UdimoEnum.UdimoState.Interact then
			local useBg = UdimoItemModel.instance:getUseBg()
			local interactId = UdimoModel.instance:getUdimoInteractId(udimoId)

			orderLayer = UdimoConfig.instance:getInteractOrderLayer(useBg, interactId)
		else
			orderLayer = state == UdimoEnum.UdimoState.PickedUp and UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.UdimoPickedUpOrderLayer, true) or UdimoConfig.instance:getUdimoOrderLayer(udimoId)
		end

		self:_changeOrderLayer(orderLayer)
	end
end

function UdimoSpineComp:_changeOrderLayer(orderLayer)
	if self._willDestroy or not orderLayer or orderLayer == self._curOrderLayer then
		return
	end

	if self._spineMeshRenderer then
		self._spineMeshRenderer.sortingOrder = orderLayer
	end

	if self._effectOrderContainer then
		self._effectOrderContainer:SetBaseOrder(orderLayer)
	end

	self._curOrderLayer = orderLayer
end

function UdimoSpineComp:beforeDestroy()
	self._willDestroy = true
	self._animEndCb = nil
	self._animEndCbObj = nil
	self._curOrderLayer = nil

	self:removeEventListeners()
	self:removeAllAnimEventCallback()
end

return UdimoSpineComp
