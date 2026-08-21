-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/iconloader/spriteatlas/SpriteAtlasMgr.lua

module("logic.common.iconloader.spriteatlas.SpriteAtlasMgr", package.seeall)

local SpriteAtlasMgr = class("SpriteAtlasMgr")

function SpriteAtlasMgr:ctor()
	self._spriteAtlasUnitTable = {}
end

function SpriteAtlasMgr:bindSpriteAtlas(iconType)
	local spriteAtlasUnit = self._spriteAtlasUnitTable[iconType]

	if spriteAtlasUnit then
		spriteAtlasUnit:retain()

		return
	end

	local iconSetting = IconType.getSetting(iconType)

	if not iconSetting then
		if enableErrorLog then
			printError("SpriteAtlasMgr::connot find icon setting!", iconType)
		end

		return
	end

	local resource = rescache:GetResource(iconSetting.url, nil, nil)

	if not resource.IsSuccess then
		if enableErrorLog then
			printError("SpriteAtlasMgr::please preload SpriteAtlas first!", iconType)
		end

		return
	end

	spriteAtlasUnit = SpriteAtlasUnit:createInstance()

	spriteAtlasUnit:setResource(resource)
	spriteAtlasUnit:retain()

	self._spriteAtlasUnitTable[iconType] = spriteAtlasUnit
end

function SpriteAtlasMgr:unbindSpriteAtlas(iconType)
	local spriteAtlasUnit = self._spriteAtlasUnitTable[iconType]

	if not spriteAtlasUnit then
		if enableWarnLog then
			printWarn("SpriteAtlasMgr::unbind SpriteAtlas fail!", iconType)
		end

		return
	end

	spriteAtlasUnit:release()

	local refCount = spriteAtlasUnit:getRefCount()

	if refCount > 0 then
		return
	end

	spriteAtlasUnit:returnSelf()

	self._spriteAtlasUnitTable[iconType] = nil
end

function SpriteAtlasMgr:getSpriteAtlasUrl(iconType)
	local iconSetting = IconType.getSetting(iconType)

	if not iconSetting then
		if enableErrorLog then
			printError("SpriteAtlasMgr::connot find icon setting!", iconType)
		end

		return
	end

	return iconSetting.url
end

function SpriteAtlasMgr:setSpriteToImage(img, iconType, spriteName)
	local spriteAtlasUnit = self._spriteAtlasUnitTable[iconType]

	if not spriteAtlasUnit then
		if enableErrorLog then
			printError("SpriteAtlasMgr::cannot find SpriteAtlasUnit", iconType)
		end

		return
	end

	spriteAtlasUnit:setSpriteToImage(img, spriteName)
end

function SpriteAtlasMgr:dump()
	if isInEditorMode then
		local sb = StringBuffer.New()

		for iconType, spriteAtlasUnit in pairs(self._spriteAtlasUnitTable) do
			sb:append(iconType)
			sb:append("-")
			sb:append(spriteAtlasUnit:getRefCount())
			sb:append("#")
		end

		if enableLog then
			printInfo("SpriteAtlasMgr::", sb:toString())
		end
	end
end

SpriteAtlasMgr.instance = SpriteAtlasMgr.New()

return SpriteAtlasMgr
