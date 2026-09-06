-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/config/MaterialConfig.lua

module("logic.extensions.material.config.MaterialConfig", package.seeall)

local MaterialConfig = class("MaterialConfig", BaseConfig)

function MaterialConfig:onInit()
	MaterialConfig.super.onInit(self)

	self._matUseCfg = nil
end

function MaterialConfig:getNames()
	return {
		"materialuse",
		"drop_bonus",
		"xieyi_item_popup"
	}
end

function MaterialConfig:handleConfig(name, content)
	if name == "materialuse" then
		self._matUseCfg = content
	elseif name == "drop_bonus" then
		self.dropContent = content
	elseif name == "xieyi_item_popup" then
		self._xieyi_item_popup = content
	end
end

function MaterialConfig:getIsPopupByExtId(extId)
	if extId and self._xieyi_item_popup and self._xieyi_item_popup[extId] then
		return checknumber(self._xieyi_item_popup[extId].isPopup) ~= 1
	end

	return true
end

function MaterialConfig:getCfgByDropId(id)
	return self.dropContent[id]
end

function MaterialConfig:getCfgByMatAndId(matType, id)
	if self._matUseCfg[matType] then
		return self._matUseCfg[matType][id]
	end
end

function MaterialConfig:getMergeCfgByMatAndId(matType, id)
	matType = checknumber(matType)
	id = checknumber(id)

	local sourceNum = -1
	local productMatType = 4
	local productId = 1
	local pruductNum = 1
	local cfg = self:getCfgByMatAndId(matType, id)

	if cfg then
		local infos = string.split(cfg.content, ",")

		sourceNum = checknumber(infos[1])

		local productInfos = string.split(infos[2], ":")

		productMatType = checknumber(productInfos[1])
		productId = checknumber(productInfos[2])
		pruductNum = checknumber(productInfos[3])
	end

	return sourceNum, productMatType, productId, pruductNum
end

MaterialConfig.instance = MaterialConfig.New()

return MaterialConfig
