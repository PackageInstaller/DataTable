-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\RawImage.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local LoaderFactory = Framework.Resource.LoaderFactory
local LoaderMode = Framework.Resource.LoaderMode
local UIConst = UIConst
local strClassName = "RawImage"
local RawImage = Class(strClassName, UIBaseControl)

function RawImage:ctor(parent, path)
	return
end

function RawImage:_getControlType()
	return UIConst.ControlTypeRawImage
end

function RawImage:setEnabled(isEnable)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.enabled = isEnable and true or false
	end
end

function RawImage:getEnabled()
	return self:getComObj().enabled
end

function RawImage:getSize()
	local size = self:getComObj().rectTransform.rect

	return {
		width = size.width,
		height = size.height
	}
end

function RawImage:setSize(width, height)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.rectTransform.sizeDelta = UnityEngine.Vector2(width, height)
	end
end

function RawImage:setImage(filePath)
	local obj = self:getComObj()

	if obj ~= nil then
		if filePath == nil or filePath == "" then
			obj.texture = nil
		else
			self:getController():SetRawImageTexture(obj, filePath, false)
		end
	end
end

function RawImage:setTexture(texture)
	local obj = self:getComObj()

	if obj and texture then
		obj.texture = texture
	end
end

function RawImage:getTexture()
	local obj = self:getComObj()

	if obj then
		return obj.texture
	end

	return nil
end

function RawImage:setUVRect(x, y, w, h)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SetRawImageUVScaleOffset(obj, x, y, w, h)
	end
end

function RawImage:setImageBlur(blurSize, blurOffset)
	local obj = self:getComObj()

	blurOffset = blurOffset or 1

	if obj ~= nil then
		self:getController():SetImageBlur(obj, blurSize, blurOffset)
	end
end

function RawImage:clearImageBlur()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():StopImageBlur(obj)
	end
end

function RawImage:captureImage(...)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():CaptureImage(obj)
	end
end

function RawImage:clearCaptureImage(...)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearCaptureImage(obj)
	end
end

function RawImage:setColorByRGBA(r, g, b, a)
	if a == nil then
		a = 255
	end

	local obj = self:getComObj()

	if obj ~= nil then
		obj.color = UnityEngine.Color(r / 255, g / 255, b / 255, a / 255)
	end
end

function RawImage:changeMaterial(materialPath, callback)
	local loader = LoaderFactory.LoadFile(materialPath, LoaderMode.Async, Functor(self._changeMaterialCallback, self, materialPath, callback))
	local isComplete = loader.IsCompleted

	if isComplete and callback then
		self:_changeMaterialCallback(materialPath, callback, true, loader)
	end
end

function RawImage:_changeMaterialCallback(materialPath, callback, state, loader)
	local image = self:getComObj()

	if image then
		image.material = loader.AsyncResult
	end
end

function RawImage:crossFade(startAlpha, targetAlpha, duration)
	local obj = self:getComObj()

	if obj then
		self:getController():FadeImage(obj, startAlpha, targetAlpha, duration)
	end
end

return RawImage
