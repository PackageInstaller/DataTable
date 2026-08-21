-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoModel.lua

module("logic.common.photo.PhotoModel", package.seeall)

local CAMERA_POS_Z = -2
local ROTATE_DELTA_TIME = 0.05
local ROTATE_DELTA_Y = 1
local M = class("PhotoModel")

function M.Get(go)
	return Astral.LuaComponentContainer.Add(go, M)
end

function M:ctor(container)
	self._go = container.gameObject
	self._transform = self._go.transform
	self._photo = Astral.PhotoBase.Add(self._go)
	self._modelGo = false
	self._modelLoadedHandler = Handler.New()
	self._resDict = {}
	self._raycastProxy = false
	self._clickHandler = false
	self._beginHandler = false
	self._dragHandler = false
	self._endDragHandler = false
	self._needAutoRotate = false
end

function M:getTargetContainer()
	if self._photo and self._photo.producer then
		return self._photo.producer.targetContainer
	end

	return nil
end

function M:getProducer()
	return self._photo and self._photo.producer or false
end

function M:getRTCamera()
	if self._photo and self._photo.producer then
		return self._photo.producer.rtCamera
	end

	return false
end

function M:setRTDepth(depth)
	local _depth = depth or 0

	Astral.PhotoProducerCache.Instance:SetRenderTextureDepth(_depth)
end

function M:enableTouch(clickHandler, beginHandler, dragHandler, endDragHandler)
	if not self._raycastProxy then
		self._clickHandler = clickHandler
		self._beginHandler = beginHandler
		self._dragHandler = dragHandler
		self._endDragHandler = endDragHandler
		self._raycastProxy = RaycastProxy.Get(self._go)

		self._raycastProxy:SetClickListener(self._onClikc, self)
		self._raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
		self._raycastProxy:SetDragListener(self._onDrag, self)
		self._raycastProxy:SetEndDragListener(self._onEndDrag, self)
	end
end

function M:updateRes(resPath, backupResPath, textureFormat, antiAliasing)
	goutil.setActive(self._go, true)

	self._backupResPath = backupResPath
	textureFormat = textureFormat or UnityEngine.RenderTextureFormat.ARGB32
	antiAliasing = antiAliasing or 1

	local width = RectTransformUtils.GetWidth(self._transform)
	local height = RectTransformUtils.GetHeight(self._transform)

	self._photo:TurnOn(width, height, textureFormat, antiAliasing)
	self:_clearResource()
	self._photo:SetCameraPosition(0, 0, CAMERA_POS_Z)
	getres(resPath, self._onLoaded, self)
end

function M:updateResWithSize(resPath, backupResPath, width, height, textureFormat, antiAliasing)
	goutil.setActive(self._go, true)

	self._backupResPath = backupResPath
	textureFormat = textureFormat or UnityEngine.RenderTextureFormat.ARGB32
	antiAliasing = antiAliasing or 1

	local rtw = RectTransformUtils.GetWidth(self._transform)
	local rth = RectTransformUtils.GetHeight(self._transform)

	width = width or rtw
	height = height or rth

	self._photo:TurnOn(width, height, textureFormat, antiAliasing)
	self:_clearResource()
	self._photo:SetCameraPosition(0, 0, CAMERA_POS_Z)
	getres(resPath, self._onLoaded, self)
end

function M:ShowTarget(inst, width, height, textureFormat, antiAliasing)
	goutil.setActive(self._go, true)

	self._backupResPath = backupResPath
	textureFormat = textureFormat or UnityEngine.RenderTextureFormat.ARGB32
	antiAliasing = antiAliasing or 1

	local rtw = RectTransformUtils.GetWidth(self._transform)
	local rth = RectTransformUtils.GetHeight(self._transform)

	width = width or rtw
	height = height or rth

	self._photo:TurnOn(width, height, textureFormat, antiAliasing)
	self:_clearResource()
	self._photo:SetCameraPosition(0, 0, CAMERA_POS_Z)

	self._modelGo = inst
	self._animationPlayer = AnimationPlayer.Get(self._modelGo)

	self._photo:ShowTarget(inst, true)
	self._modelLoadedHandler:call(inst, res)
end

function M:_onLoaded(res)
	if res.IsSuccess then
		res:Retain()
		table.insert(self._resDict, res)

		local inst = goutil.clone(res:GetMainAsset())

		self._modelGo = inst
		self._animationPlayer = AnimationPlayer.Get(self._modelGo)

		self._photo:ShowTarget(inst, true)
		self._modelLoadedHandler:call(inst, res)
	elseif self._backupResPath ~= nil then
		printError("加载失败尝试加载备份", self._backupResPath)
		self:updateRes(self._backupResPath)
	end
end

function M:setModelLoadCallback(callback, callbackObj)
	self._modelLoadedHandler:setListener(callback, callbackObj)
end

function M:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
end

function M:attachEffect(attachName, resPath, layer)
	getres(resPath, function(res)
		if res.IsSuccess then
			res:Retain()

			if not self._resDict then
				return
			end

			table.insert(self._resDict, res)

			if self._modelGo then
				local inst = goutil.clone(res:GetMainAsset())
				local parentGo = goutil.findChild(self._modelGo, attachName)

				if parentGo then
					goutil.addChildToParent(inst, parentGo)
				else
					parentGo = goutil.create(attachName, true)

					goutil.addChildToParent(parentGo, self._modelGo)
					goutil.addChildToParent(inst, parentGo)
				end

				Astral.GameObjectUtil.SetLayerRecursively(inst, layer or SceneLayer.UI3D_Value)
			end
		end
	end, nil)
end

function M:clearAttachEffect(attachName)
	if self._modelGo then
		local parentGo = goutil.findChild(self._modelGo, attachName)

		if parentGo ~= nil then
			goutil.clearChildren(parentGo)
		end
	end
end

function M:_onRayCastHit()
	if self._clickHandler then
		self._clickHandler:call()
	end
end

function M:_onBeginDrag(posX, posY, pointerId)
	if self._beginHandler then
		self._beginHandler:call(posX, posY, pointerId)
	end

	self:tryStopAutoRotate()
end

function M:_onDrag(posX, posY, pointerId)
	if self._dragHandler then
		self._dragHandler:call(posX, posY, pointerId)
	end
end

function M:_onEndDrag(posX, posY, pointerId)
	if self._endDragHandler then
		self._endDragHandler:call(posX, posY, pointerId)
	end

	self:tryStartAutoRotate()
end

function M:setNeedAutoRotate(isNeed, startNow)
	self._needAutoRotate = isNeed

	if isNeed then
		self:tryStartAutoRotate(startNow)
	else
		self:tryStopAutoRotate()
	end
end

function M:tryStartAutoRotate(startNow)
	if self._needAutoRotate then
		if startNow then
			self:_startAutoRotate()
		else
			settimer(2, self._startAutoRotate, self, false)
		end
	end
end

function M:tryStopAutoRotate()
	removetimer(self._startAutoRotate, self)
	removetimer(self._doAutoRotation, self)
end

function M:_startAutoRotate()
	removetimer(self._startAutoRotate, self)
	settimer(ROTATE_DELTA_TIME, self._doAutoRotation, self, true)
end

function M:_doAutoRotation()
	local _, rotaY, _ = self:getTargetRotation()

	rotaY = rotaY - ROTATE_DELTA_Y

	self:setTargetRotationY(rotaY)
end

function M:setAttachPosition(attachName, x, y, z)
	if self._modelGo then
		local parentGo = goutil.findChild(self._modelGo, attachName)

		if parentGo then
			Astral.TransformUtil.SetLocalPos(parentGo.transform, x, y, z)
		end
	end
end

function M:setAttachRotation(attachName, x, y, z)
	if self._modelGo then
		local parentGo = goutil.findChild(self._modelGo, attachName)

		if parentGo then
			Astral.TransformUtil.SetLocalRotation(parentGo.transform, x, y, z)
		end
	end
end

function M:setRotation(x, y, z)
	self._photo:SetCameraRotation(x, y, z)
end

function M:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function M:getCameraPosition()
	return self._photo:GetCameraPosition(0, 0, 0)
end

function M:setCameraPostProcessing(renderPostProcessing, volumeLayer)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayer)
end

function M:setCameraTextureFormat(textureFormat)
	PhotoBaseExtension.SetCameraTextureFormat(self._photo, textureFormat)
end

function M:setCameraCullingLayer(cullingLayer)
	PhotoBaseExtension.SetCameraCullingLayer(self._photo, cullingLayer)
end

function M:setCameraFov(filedOfView)
	PhotoBaseExtension.SetCameraFOV(self._photo, filedOfView)
end

function M:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function M:setCameraOrthographic(size)
	PhotoBaseExtension.SetCameraOrthographic(self._photo, size)
end

function M:getTransform()
	if self._modelGo then
		return self._modelGo.transform
	end
end

function M:getTargetRotation()
	if not self._modelGo then
		return 0, 0, 0
	end

	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(self._modelGo.transform, 0, 0, 0)

	return rotaX, rotaY, rotaZ
end

function M:setTargetRotationY(rotationY)
	if not self._modelGo then
		return
	end

	local rotaX, _, rotaZ = self:getTargetRotation()

	Astral.TransformUtil.SetLocalRotation(self._modelGo.transform, rotaX, rotationY, rotaZ)
end

function M:setTargetRotationZ(rotationZ)
	if not self._modelGo then
		return
	end

	local rotaX, rotaY, _ = self:getTargetRotation()

	Astral.TransformUtil.SetLocalRotation(self._modelGo.transform, rotaX, rotaY, rotationZ)
end

function M:playAni(aniName, isLoop, isForceRestart)
	if self._animationPlayer then
		self._animationPlayer:PlayAnimation(aniName, isLoop, isForceRestart)
	end
end

function M:_clearResource()
	if self._photo and not goutil.isNil(self._photo.producer) then
		self._photo:RemoveAllTargets()
	end

	for k, v in ipairs(self._resDict) do
		v:Release()
	end

	table.clear(self._resDict)
end

function M:clear()
	self:_clearResource()
	self._photo:TurnOff()
	goutil.setActive(self._go, false)
	self:tryStopAutoRotate()
end

function M:OnDestroy()
	self:clear()

	self._photo = nil
	self._go = nil
	self._transform = nil
	self._modelLoadedHandler = nil
	self._resDict = nil

	if self._raycastProxy then
		self._raycastProxy:RemoveClickListener()
		self._raycastProxy:RemoveBeginDragListener()
		self._raycastProxy:RemoveDragListener()

		self._raycastProxy = nil
	end

	self._clickHandler = nil
	self._dragHandler = nil
	self._beginHandler = nil
	self._endDragHandler = nil
	self._needAutoRotate = nil
end

return M
