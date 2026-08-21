-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/iconloader/spriteatlas/SpriteAtlasUnit.lua

module("logic.common.iconloader.spriteatlas.SpriteAtlasUnit", package.seeall)

local SpriteAtlasUnit = class("SpriteAtlasUnit", AbstractGlobalReusable)

function SpriteAtlasUnit:ctor()
	self._refCount = 0
	self._resource = false
	self._spriteAtlas = false
end

function SpriteAtlasUnit:reuse()
	self._refCount = 0
	self._resource = false
	self._spriteAtlas = false
end

function SpriteAtlasUnit:setResource(resource)
	resource:Retain()

	self._resource = resource
	self._spriteAtlas = resource:GetAsset(nil, nil)
end

function SpriteAtlasUnit:setSpriteToImage(img, spriteName)
	if not self._spriteAtlas then
		if enableErrorLog then
			printError("SpriteAtlasUnit::spriteAtlas is nil", spriteName)
		end

		return
	end

	if not spriteName then
		if enableErrorLog then
			printError("spriteName is nil")
		end

		return
	end

	img.sprite = self._spriteAtlas:GetSprite(spriteName)
end

function SpriteAtlasUnit:reset()
	if self._resource then
		self._resource:Release()

		self._resource = false
		self._spriteAtlas = false
	end
end

function SpriteAtlasUnit:destroy()
	if self._resource then
		self._resource:Release()

		self._resource = nil
		self._spriteAtlas = nil
	end
end

function SpriteAtlasUnit:retain()
	self._refCount = self._refCount + 1
end

function SpriteAtlasUnit:release()
	self._refCount = self._refCount - 1
end

function SpriteAtlasUnit:getRefCount()
	return self._refCount
end

return SpriteAtlasUnit
