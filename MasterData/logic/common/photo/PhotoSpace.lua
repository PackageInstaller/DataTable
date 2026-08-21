-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoSpace.lua

module("logic.common.photo.PhotoSpace", package.seeall)

local M = class("PhotoSpace")

function M.Get(go)
	return Astral.LuaComponentContainer.Add(go, M)
end

function M:ctor(container)
	self._go = container.gameObject
	self._transform = self._go.transform
	self._photo = Astral.PhotoBase.Add(self._go)
	self._resLoadedHandler = Handler.New()
	self._allReslLoadedHandler = Handler.New()
	self._multiLoader = MultiResLoader.New()
	self._resDict = {}
	self._raycastProxy = false
	self._clickHandler = false
	self._beginHandler = false
	self._dragHandler = false
	self._endDragHandler = false
end

function M:_clearResource()
	if self._photo and not goutil.isNil(self._photo.producer) then
		self._photo:RemoveAllTargets()
	end

	for _, res in pairs(self._resDict) do
		res:Release()
	end

	table.clear(self._resDict)
	self._multiLoader:clear()
end

function M:_onResLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res

		self._resLoadedHandler:call(res)
	end
end

function M:_onAllLoaded()
	self._allReslLoadedHandler:call()
end

function M:setModelLoadCallback(callback, allLoadedCallback, callbackObj)
	self._resLoadedHandler:setListener(callback, callbackObj)
	self._allReslLoadedHandler:setListener(allLoadedCallback, callbackObj)
end

function M:addResList(resList)
	self:_clearResource()
	self._multiLoader:setResPaths(resList)
	self._multiLoader:load(self._onAllLoaded, self._onResLoaded, self)
end

function M:show(textureFormat, antiAliasing, width, height)
	goutil.setActive(self._go, true)

	textureFormat = textureFormat or UnityEngine.RenderTextureFormat.ARGB32
	antiAliasing = antiAliasing or 1

	local width = width or RectTransformUtils.GetWidth(self._transform)
	local height = height or RectTransformUtils.GetHeight(self._transform)

	self._photo:TurnOn(width, height, textureFormat, antiAliasing)
end

function M:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function M:getProducer()
	return self._photo and self._photo.producer or false
end

function M:getResource(resPath)
	return self._resDict[resPath]
end

function M:showTarget(go, active)
	self._photo:ShowTarget(go, active)
end

function M:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
end

function M:setCameraPosition(position)
	self._photo:SetCameraPosition(position.x, position.y, position.z)
end

function M:setCameraRotation(rotation)
	self._photo:SetCameraRotation(rotation.x, rotation.y, rotation.z)
end

function M:setCameraFov(filedOfView)
	PhotoBaseExtension.SetCameraFOV(self._photo, filedOfView)
end

function M:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
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

function M:_onRayCastHit()
	if self._clickHandler then
		self._clickHandler:call()
	end
end

function M:_onBeginDrag(posX, posY, pointerId)
	if self._beginHandler then
		self._beginHandler:call(posX, posY, pointerId)
	end
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
end

function M:_clearInteractHandler()
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
end

function M:clear()
	if self._photo and not goutil.isNil(self._photo.producer) then
		self:setCameraFov(30)
		self:setCameraPosition(Vector3.zero)
		self:setCameraRotation(Vector3.zero)
	end

	self:_clearResource()
	self._photo:TurnOff()
	goutil.setActive(self._go, false)
	self:_clearInteractHandler()
end

function M:OnDestroy()
	self._photo = nil
	self._go = nil
	self._transform = nil
	self._resDict = nil

	self:_clearInteractHandler()
end

return M
