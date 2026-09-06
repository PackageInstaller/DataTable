-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/PackTexture.lua

module("logiccommon.common.avatar.PackTexture", package.seeall)

local PackTexture = class("PackTexture")
local textureWidth = 0
local textureHeight = 0
local Texture2DType = typeof(UnityEngine.Texture2D)
local UnityTexture2D = UnityEngine.Texture2D

function PackTexture:ctor()
	self.refCount = 0
end

function PackTexture:reset()
	if self.refCount > 0 then
		error("尝试销毁合并的贴图：key=" .. self.key .. "  refCount=" .. self.refCount)

		return
	end

	self.refCount = 0
	self.packTextures = nil

	if self.atlas then
		goutil.destroy(self.atlas)
	end

	self.textureMap = nil
	self.atlas = nil
	self.packingResult = nil
	self.texturesIndex = nil
end

function PackTexture:retain()
	self.refCount = self.refCount + 1
end

function PackTexture:release()
	self.refCount = self.refCount - 1
end

function PackTexture:destroy()
	self:reset()
end

function PackTexture:tryDestroy()
	if self.refCount == 0 then
		self:destroy()

		return true
	end
end

function PackTexture:_setupConfig(textures)
	self.packTextures = {}
	self.textureMap = {}
	self.texturesIndex = {}
	textureWidth = 0
	textureHeight = 0

	local index = 1

	for i = 1, #textures do
		local tex = textures[i]

		if not self.textureMap[tex.name] then
			table.insert(self.packTextures, tex)

			self.texturesIndex[tex.name] = index
			self.textureMap[tex.name] = tex
			index = index + 1
			textureWidth = textureWidth + tex.width
			textureHeight = textureHeight + tex.height
		end
	end

	textureWidth = self:_getPowOf2(textureWidth)
	textureHeight = self:_getPowOf2(textureHeight)
end

function PackTexture:pack(textures)
	self:_setupConfig(textures)

	local arr = System.Array.CreateInstance(Texture2DType, #self.packTextures)

	for i = 0, #self.packTextures - 1 do
		arr[i] = self.packTextures[i + 1]
	end

	self.atlas = UnityTexture2D.New(textureWidth, textureHeight)
	self.packingResult = self.atlas:PackTextures(arr, 0)
end

function PackTexture:_getPowOf2(num)
	local po2 = 1

	while po2 < num do
		po2 = po2 * 2
	end

	return po2
end

return PackTexture
