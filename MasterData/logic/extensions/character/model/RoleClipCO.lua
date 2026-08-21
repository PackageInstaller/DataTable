-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/model/RoleClipCO.lua

module("logic.extensions.character.model.RoleClipCO", package.seeall)

local M = class("RoleClipCO")

function M:ctor(cfg)
	self._cfg = cfg
	self._dictImageClipInfo = {}

	for _, info in ipairs(self._cfg.clipImageInfos) do
		self._dictImageClipInfo[info.keyName] = info
	end

	self._dictSpineClipInfo = {}

	for _, info in ipairs(self._cfg.clipSpineInfos) do
		self._dictSpineClipInfo[info.keyName] = info
	end

	self._dictModelClipInfo = {}

	for _, info in ipairs(self._cfg.clipModelInfos) do
		self._dictModelClipInfo[info.keyName] = info
	end

	self._dictDoubleModelClipInfo = {}

	for _, info in ipairs(self._cfg.clip2ModelInfos) do
		self._dictDoubleModelClipInfo[info.keyName] = info
	end
end

function M:getModelCode()
	return self._cfg.modelCode
end

function M:getWholeImgSize()
	return self._cfg.wholeIconWidth, self._cfg.wholeIconHeight
end

function M:getImageClipInfo(key)
	return self._dictImageClipInfo[key]
end

function M:getImageClipInfoArr(key)
	local info = self:getImageClipInfo(key)

	return {
		info.posX,
		info.posY,
		info.scaleX,
		info.scaleY
	}
end

function M:getSpineClipInfo(key)
	return self._dictSpineClipInfo[key]
end

function M:getSpineClipInfoArr(key)
	local info = self:getSpineClipInfo(key)

	return {
		info.posX,
		info.posY,
		info.scaleX,
		info.scaleY
	}
end

function M:getModelClipInfo(key)
	return self._dictModelClipInfo[key]
end

function M:getModelClipInfoArr(key)
	local info = self:getModelClipInfo(key)

	return {
		info.posX,
		info.posY,
		info.posZ,
		info.rotaX,
		info.rotaY,
		info.rotaZ,
		info.scaleX
	}
end

function M:getDoubleModelClipInfo(key)
	return self._dictDoubleModelClipInfo[key]
end

function M:getDoubleModelClipInfoArr(key)
	local info = self:getDoubleModelClipInfo(key)

	return {
		info.posX,
		info.posY,
		info.posZ,
		info.rotaX,
		info.rotaY,
		info.rotaZ,
		info.scaleX
	}
end

return M
