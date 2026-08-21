-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Image.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local LoaderFactory = Framework.Resource.LoaderFactory
local LoaderMode = Framework.Resource.LoaderMode
local UIConst = UIConst
local strClassName = "Image"
local Image = Class(strClassName, UIBaseControl)

function Image:ctor(parent, path)
	self.isGray = false
end

function Image:_getControlType()
	return UIConst.ControlTypeImage
end

function Image:setNativeSize()
	local obj = self:getComObj()

	if obj ~= nil then
		obj:SetNativeSize()
	end
end

function Image:setEnabled(isEnable)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.enabled = isEnable and true or false
	end
end

function Image:getEnabled()
	return self:getComObj().enabled
end

function Image:setImageWithTexture(texture)
	local obj = self:getComObj()

	if obj ~= nil then
		local sprite = UnityEngine.Sprite.Create(texture, UnityEngine.Rect(0, 0, texture.width, texture.height), Vector2.zero)

		obj.sprite = sprite
	end
end

function Image:setImage(filePath, spriteName)
	local obj = self:getComObj()

	if obj ~= nil then
		self.imgFilePath = filePath
		self.imgSpriteName = spriteName

		self:getController():SetImageSprite(obj, filePath, spriteName, false)
	end
end

function Image:getImagePath()
	return self.imgFilePath, self.imgSpriteName
end

function Image:copyImage(tgtImage)
	if tgtImage == nil then
		return
	end

	local obj = self:getComObj()
	local tgtObj = tgtImage and tgtImage:getComObj()

	if obj ~= nil and tgtObj ~= nil then
		obj.sprite = tgtObj.sprite
	end
end

function Image:getSpriteName()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.sprite and obj.sprite.name
	end
end

function Image:setImageGray(isGray)
	local obj = self:getComObj()

	if obj ~= nil then
		if self.isGray == isGray then
			return
		end

		self.isGray = isGray

		self:getController():SetImageGray(obj, isGray)
	end
end

function Image:setColorByRGBA(r, g, b, a)
	if a == nil then
		a = 255
	end

	local obj = self:getComObj()

	if obj ~= nil then
		obj.color = UnityEngine.Color(r / 255, g / 255, b / 255, a / 255)
	end
end

function Image:setColorAlpha(a)
	a = a or 255

	local obj = self:getComObj()

	if obj then
		local oldColor = obj.color

		obj.color = UnityEngine.Color(oldColor.r, oldColor.g, oldColor.b, a / 255)
	end
end

function Image:crossFade(startAlpha, targetAlpha, duration)
	local obj = self:getComObj()

	if obj then
		self:getController():FadeImage(obj, startAlpha, targetAlpha, duration)
	end
end

function Image:getRadialRate()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.fillAmount
	end

	return 0
end

function Image:setRadialRate(r)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.fillAmount = r
	end
end

function Image:runRadialRate(time, callback, targetRate, startRate)
	local obj = self:getComObj()

	if obj ~= nil then
		if targetRate == nil then
			targetRate = 1
		end

		if startRate == nil then
			startRate = self:getRadialRate()
		end

		self:getController():SetImageRadialRate(obj, startRate, targetRate, time, callback)
	end
end

function Image:resetRadialRate()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ResetImageRadialRate(obj)
	end
end

function Image:getSize()
	local size = self:getComObj().rectTransform.rect

	return {
		width = size.width,
		height = size.height
	}
end

function Image:setSize(width, height)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.rectTransform.sizeDelta = UnityEngine.Vector2(width, height)
	end
end

function Image:getCanvasScale()
	return self:getComObj().canvas.scaleFactor
end

function Image:setImageBlur(blurSize, blurOffset)
	local obj = self:getComObj()

	blurOffset = blurOffset or 1

	if obj ~= nil then
		self:getController():SetImageBlur(obj, blurSize, blurOffset)
	end
end

function Image:clearImageBlur()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():StopImageBlur(obj)
	end
end

function Image:changeMaterial(materialPath, callback)
	local loader = LoaderFactory.LoadFile(materialPath, LoaderMode.Async, Functor(self._changeMaterialCallback, self, materialPath, callback))
	local isComplete = loader.IsCompleted

	if isComplete and callback then
		self:_changeMaterialCallback(materialPath, callback, true, loader)
	end
end

function Image:_changeMaterialCallback(materialPath, callback, state, loader)
	local image = self:getComObj()

	if image then
		image.material = loader.AsyncResult
	end
end

function Image:setClickIgnoreAlpha(alpha)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.alphaHitTestMinimumThreshold = alpha
	end
end

return Image
