-- chunkname: @modules/ugui/uispriteset/UISpriteSetUnit.lua

module("modules.ugui.uispriteset.UISpriteSetUnit", package.seeall)

local UISpriteSetUnit = class("UISpriteSetUnit")

function UISpriteSetUnit:init(assetPath)
	self._loader = nil
	self._spriteSetAsset = nil
	self._assetPath = assetPath
	self._refImageList = {}
	self._refCacheImages = {}
	self._loading = false
	self._loadDone = false
end

function UISpriteSetUnit:getSpriteSetAsset()
	return self._spriteSetAsset
end

function UISpriteSetUnit:_checkLoadAsset()
	if self._loader then
		return
	end

	self._loading = true

	local loader = MultiAbLoader.New()

	self._loader = loader

	loader:addPath(self._assetPath)
	loader:startLoad(function(multiAbLoader)
		local assetItem = loader:getAssetItem(self._assetPath)

		self._spriteSetAsset = assetItem:GetResource(self._assetPath)

		for image, v in pairs(self._refCacheImages) do
			local spriteName = v.spriteName
			local setNativeSize = v.setNativeSize
			local alpha = v.alpha

			if gohelper.isNil(image) == false then
				self:_setImgAlpha(image, alpha or 1)

				image.sprite = self._spriteSetAsset:GetSprite(spriteName)

				if setNativeSize then
					image:SetNativeSize()
				end

				table.insert(self._refImageList, image)
			end
		end

		self._refCacheImages = {}
		self._hasCache = false
		self._loading = false
		self._loadDone = true

		if self.callback then
			self.callback(self.callbackObj)
		end
	end)
end

function UISpriteSetUnit:setImageAlpha(image, alpha)
	local cacheImageProperties = self._refCacheImages[image]

	if cacheImageProperties then
		cacheImageProperties.alpha = alpha
	else
		self:_setImgAlpha(image, alpha)
	end
end

function UISpriteSetUnit:_setImgAlpha(image, alpha)
	local color = image.color

	color.a = alpha
	image.color = color
end

function UISpriteSetUnit:setSprite(image, spriteName, setNativeSize, alpha)
	if gohelper.isNil(image) then
		logError("set SpriteSet fail, image = null, spriteName = " .. (spriteName or "nil"))

		return
	end

	if string.nilorempty(spriteName) then
		logError("set SpriteSet fail, spriteName = null, image = " .. ((image or nil) and (image.name or "nil")))

		return
	end

	self:_checkLoadAsset()

	if not self._spriteSetAsset then
		if gohelper.isNil(image.sprite) then
			self:_setImgAlpha(image, 0)
		end

		self._refCacheImages[image] = {
			spriteName = spriteName,
			setNativeSize = setNativeSize,
			alpha = alpha
		}
		self._hasCache = true

		return
	end

	if spriteName then
		image.sprite = self._spriteSetAsset:GetSprite(spriteName)

		if setNativeSize then
			image:SetNativeSize()
		end
	end

	table.insert(self._refImageList, image)
end

function UISpriteSetUnit:loadAsset(callback, callbackObj)
	if self._loadDone then
		callback(callbackObj)

		return
	end

	self.callback = callback
	self.callbackObj = callbackObj

	if self._loading then
		return
	end

	self._loading = true

	local loader = MultiAbLoader.New()

	self._loader = loader

	loader:addPath(self._assetPath)
	loader:startLoad(function(multiAbLoader)
		local assetItem = loader:getAssetItem(self._assetPath)

		self._spriteSetAsset = assetItem:GetResource(self._assetPath)
		self._loading = false
		self._loadDone = true

		if self.callback then
			self.callback(self.callbackObj)
		end
	end)
end

function UISpriteSetUnit:getSprite(spriteName)
	if not self._loadDone then
		logError("sprite not load done, please use self:loadAsset() load.")

		return nil
	end

	return self._spriteSetAsset:GetSprite(spriteName)
end

function UISpriteSetUnit:tryDispose()
	if self._hasCache then
		return
	end

	for i = #self._refImageList, 1, -1 do
		local image = self._refImageList[i]

		if gohelper.isNil(image) then
			table.remove(self._refImageList, i)
		end
	end

	if self._loader and #self._refImageList == 0 then
		self._spriteSetAsset = nil

		self._loader:dispose()

		self._loader = nil
	end
end

return UISpriteSetUnit
