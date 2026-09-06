-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/ImageSpriteAnimComponent.lua

module("logiccommon.common.components.ImageSpriteAnimComponent", package.seeall)

local ImageSpriteAnimComponent = class("ImageSpriteAnimComponent")

function ImageSpriteAnimComponent:ctor(go)
	self._spriteAnim = goutil.addComponentOnce(go, ComponentType.UISpriteAnimEx)
	self._resLoad = nil
	self._finishCalls = {}
	self._go = go
	self.isAllLoaded = false
end

function ImageSpriteAnimComponent:loadImageAnim(imagePathList)
	if self._resLoad ~= nil and self.isAllLoaded == true then
		self:_onImageLoad()
	elseif self._resLoad == nil then
		self._resLoad = MultiResLoader.New()
		self._finishCalls = {}

		local urlList = {}

		for i = 1, #imagePathList do
			table.insert(urlList, imagePathList[i])
		end

		self.isAllLoaded = false

		self._resLoad:setResPaths(urlList)
		table.insert(self._finishCalls, function()
			self:_onImageLoad()
		end)
		self._resLoad:load(self._onResLoaded, nil, self)
	else
		table.insert(self._finishCalls, function()
			self:_onImageLoad()
		end)
	end
end

function ImageSpriteAnimComponent:_onImageLoad()
	local image = self._spriteAnim:GetComponent("Image")

	if image then
		Game.ImageUtil.SetImageAlpha(image, 1)
	end

	local resources = self._resLoad:getResources()
	local urlList = self._resLoad._resPaths
	local len = #urlList

	if len > 0 then
		for i = 1, len do
			local path = urlList[i]
			local res = resources[path]
			local texture = res:GetMainAsset()

			self._spriteAnim:AddSprite(texture)

			if i == 1 then
				image.sprite = self._spriteAnim.spriteList[0]
			end
		end

		self._spriteAnim:Play()
	end
end

function ImageSpriteAnimComponent:loadAtlasRes(path)
	if self._resLoad ~= nil and self.isAllLoaded == true then
		self:_onAtlasLoad()
	elseif self._resLoad == nil then
		self._resLoad = MultiResLoader.New()
		self._finishCalls = {}

		local urlList = {}

		table.insert(urlList, path)

		self.isAllLoaded = false

		self._resLoad:setResPaths(urlList)
		table.insert(self._finishCalls, function()
			self:_onAtlasLoad()
		end)
		self._resLoad:load(self._onResLoaded, nil, self)
	else
		table.insert(self._finishCalls, function()
			self:_onAtlasLoad()
		end)
	end
end

function ImageSpriteAnimComponent:_onAtlasLoad()
	local image = self._spriteAnim:GetComponent("Image")

	if image then
		Game.ImageUtil.SetImageAlpha(image, 1)
	end

	local resources = self._resLoad:getResources()
	local urlList = self._resLoad._resPaths
	local len = #urlList

	if len > 0 then
		local path = urlList[1]
		local gameObject = resources[path]:GetMainAsset()
		local spriteAtlas = gameObject:GetComponent(ComponentType.UIImageSpriteAtlas)

		for i = 0, spriteAtlas.sprites.Count - 1 do
			local sprite = spriteAtlas.sprites[i]

			self._spriteAnim.spriteList:Add(sprite)

			if i == 1 then
				image.sprite = sprite
			end
		end

		GameUtil.SetActive(self._go, true)
		self._spriteAnim:Play()
	end
end

function ImageSpriteAnimComponent:dispose()
	self._spriteAnim:Reset()
	self._resLoad:clear()
	GameUtil.unloadMultiResLoaderResource(self._resLoad)

	self._resLoad = nil
	self._finishCalls = {}
	self.isAllLoaded = false
end

function ImageSpriteAnimComponent:setFps(fps)
	if self._spriteAnim then
		self._spriteAnim.fps = fps
	end
end

function ImageSpriteAnimComponent:_onResLoaded()
	self.isAllLoaded = true

	for i = 1, #self._finishCalls do
		self._finishCalls[i]()
	end

	self._finishCalls = nil
end

return ImageSpriteAnimComponent
