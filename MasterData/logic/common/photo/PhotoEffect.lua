-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoEffect.lua

module("logic.common.photo.PhotoEffect", package.seeall)

local PhotoEffect = class("PhotoEffect")

function PhotoEffect.Get(go)
	return Astral.LuaComponentContainer.Add(go, PhotoEffect)
end

function PhotoEffect:ctor(container)
	self._go = container.gameObject
	self._transform = self._go.transform
	self._multiLoader = MultiResLoader.New()
	self._photo = Astral.PhotoBase.Add(self._go)
	self._goInstList = {}
	self._effectLoadedHandler = Handler.New()
	self._rtFormat = UnityEngine.RenderTextureFormat.ARGB32
end

function PhotoEffect:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function PhotoEffect:setCameraRotation(x, y, z)
	self._photo:SetCameraRotation(x, y, z)
end

function PhotoEffect:setCameraPerspective(fieldOfView)
	PhotoBaseExtension.SetCameraPerspective(self._photo, fieldOfView)
end

function PhotoEffect:setCameraOrthographic(orthographicSize)
	PhotoBaseExtension.SetCameraOrthographic(self._photo, orthographicSize)
end

function PhotoEffect:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
end

function PhotoEffect:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function PhotoEffect:setMaterial(material)
	PhotoBaseExtension.SetMaterial(self._photo, material)
end

function PhotoEffect:setBgColor(colorStr)
	PhotoBaseExtension.SetCameraBgColor(self._photo, colorStr)
end

function PhotoEffect:setEffectLoadedCallback(callback, callbackObj)
	self._effectLoadedHandler:setListener(callback, callbackObj)
end

function PhotoEffect:setRtFormat(rtFormat)
	self._rtFormat = rtFormat
end

function PhotoEffect:showEffects(...)
	local urls = {
		...
	}

	if not urls then
		return
	end

	goutil.setActive(self._go, true)

	local width = RectTransformUtils.GetWidth(self._transform)
	local height = RectTransformUtils.GetHeight(self._transform)

	self._photo:TurnOn(width, height, self._rtFormat)
	PhotoBaseExtension.ResetCamera(self._photo)
	self:_clearResource()

	local len = #urls

	for i = 1, len do
		self._multiLoader:addResPath(urls[i], true)
	end

	self._multiLoader:load(false, self._onOneLoaded, self)
end

function PhotoEffect:showEffect(url, width, height)
	goutil.setActive(self._go, true)
	self._photo:TurnOn(width, height, self._rtFormat)
	PhotoBaseExtension.ResetCamera(self._photo)
	self:_clearResource()
	self._multiLoader:addResPath(url, true)
	self._multiLoader:load(false, self._onOneLoaded, self)
end

function PhotoEffect:showEffectWithObj(targetGameObj, width, height)
	goutil.setActive(self._go, true)

	width = width or RectTransformUtils.GetWidth(self._transform)
	height = height or RectTransformUtils.GetHeight(self._transform)

	self._photo:TurnOn(width, height, self._rtFormat)
	PhotoBaseExtension.ResetCamera(self._photo)
	self._photo:ShowTarget(targetGameObj, true)
end

function PhotoEffect:_onOneLoaded(res)
	if res.IsSuccess then
		local inst = goutil.clone(res:GetAsset(nil, nil))

		self._photo:ShowTarget(inst, true)
		table.insert(self._goInstList, inst)
		self._effectLoadedHandler:call(inst, res)
	end
end

function PhotoEffect:getPhoto()
	return self._photo
end

function PhotoEffect:_clearResource()
	for k, go in pairs(self._goInstList) do
		goutil.destroy(go)

		self._goInstList[k] = nil
	end

	self._multiLoader:clear()
end

function PhotoEffect:clear()
	self._photo:TurnOff()
	self:_clearResource()
	goutil.setActive(self._go, false)
end

function PhotoEffect:OnDestroy()
	self:clear()

	self._multiLoader = nil
	self._photo = nil
	self._targetGoes = nil
	self._go = nil
	self._transform = nil
	self._rtFormat = nil
end

return PhotoEffect
