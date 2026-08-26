-- chunkname: @modules/logic/character/config/SkinConfig.lua

module("modules.logic.character.config.SkinConfig", package.seeall)

local SkinConfig = class("SkinConfig", BaseConfig)

function SkinConfig:ctor()
	self._skinConfig = nil
	self._skinStoreTagConfig = nil
end

function SkinConfig:reqConfigNames()
	return {
		"skin",
		"skin_special_act",
		"skin_ui_effect",
		"skin_ui_bloom",
		"skin_monster_scale",
		"skin_body_camera",
		"skin_monster_hide_buff_effect",
		"skin_store_tag",
		"skin_fullscreen_effect",
		"skin_effect_mainframe"
	}
end

function SkinConfig:onConfigLoaded(configName, configTable)
	if configName == "skin" then
		self._skinConfig = configTable

		self:_initSkinConfig()
	elseif configName == "skin_store_tag" then
		self._skinStoreTagConfig = configTable
	end
end

function SkinConfig:_initSkinConfig()
	if not self._characterSkinCoList then
		self._characterSkinCoList = {}
		self._live2dSkinDic = {}
		self._skinFolderNameMap = {}
		self._skinStoreGoodsDict = {}

		local configList = self._skinConfig.configList

		for _, config in ipairs(configList) do
			if not string.nilorempty(config.live2d) and not string.nilorempty(config.verticalDrawing) then
				self._live2dSkinDic[config.verticalDrawing] = config.live2d
			end

			if not string.nilorempty(config.folderName) then
				if not string.nilorempty(config.live2d) then
					self:_setFolderName(config.live2d, config.folderName)
				elseif not string.nilorempty(config.verticalDrawing) then
					self:_setFolderName(config.verticalDrawing, config.folderName)
				end
			end

			local skinCoList = self._characterSkinCoList[config.characterId]

			if not skinCoList then
				skinCoList = {}
				self._characterSkinCoList[config.characterId] = skinCoList
			end

			table.insert(skinCoList, config)

			if config.skinStoreId ~= 0 then
				self._skinStoreGoodsDict[config.skinStoreId] = config.id
			end
		end
	end
end

function SkinConfig:isSkinStoreGoods(goodsId)
	if self._skinStoreGoodsDict then
		return self._skinStoreGoodsDict[goodsId] ~= nil, self._skinStoreGoodsDict[goodsId]
	end
end

function SkinConfig:_setFolderName(resName, folderName)
	self:_checkFolderName(resName)

	self._skinFolderNameMap[resName] = folderName

	if not string.match(folderName, "v%d+a%d+_") and not string.match(folderName, "s0[1-9]_") then
		logError(string.format("SkinConfig folderName:%s 不符合版本格式", folderName))
	end
end

function SkinConfig:_checkFolderName(resName)
	if self._skinFolderNameMap[resName] then
		logError(string.format("SkinConfig repeat folderName:%s,resName:%s", self._skinFolderNameMap[resName], resName))
	end
end

function SkinConfig:getFolderName(resName)
	return self._skinFolderNameMap[resName] or resName
end

function SkinConfig:getLive2dSkin(name)
	return self._live2dSkinDic[name]
end

function SkinConfig:getSkinCo(id)
	return self._skinConfig.configDict[id]
end

function SkinConfig:getAllSkinCoList()
	return self._skinConfig.configList
end

function SkinConfig:getSkinOffset(offset, defaultOffset)
	if string.nilorempty(offset) then
		if defaultOffset then
			return defaultOffset, true
		end

		return {
			0,
			0,
			1
		}, true
	end

	return string.splitToNumber(offset, "#"), false
end

function SkinConfig:getAfterRelativeOffset(constId, baseOffset)
	local constVal = CommonConfig.instance:getConstStr(constId)
	local relativeOffset, isNil = self:getSkinOffset(constVal)

	if isNil then
		return baseOffset
	end

	baseOffset[1] = baseOffset[1] + relativeOffset[1]
	baseOffset[2] = baseOffset[2] + relativeOffset[2]
	baseOffset[3] = baseOffset[3] + relativeOffset[3]

	return baseOffset
end

function SkinConfig:getCharacterSkinCoList(characterId)
	return self._characterSkinCoList[characterId]
end

function SkinConfig:getSkinStoreTagConfig(tag)
	return self._skinStoreTagConfig.configDict[tag]
end

SkinConfig.instance = SkinConfig.New()

return SkinConfig
