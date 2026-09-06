-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/model/AvatarModel.lua

module("logiccommon.common.avatar.new.AvatarModel", package.seeall)

local AvatarModel = class("AvatarModel")

function AvatarModel:ctor(skeletonId, isSetDefault)
	self.skeleton = nil

	self:getOwnCoverDataNames()
	self:reset()

	if skeletonId then
		self:setSkeletonByCfgId(skeletonId, isSetDefault)
	end
end

function AvatarModel:getAvatarType()
	return AvatarCreateType.Base
end

function AvatarModel:reset()
	for k, v in pairs(self:getOwnCoverDataNames()) do
		self[v] = {}
	end

	for k, v in pairs(self:getOwnOtherUIDataNames()) do
		self[v] = nil
	end
end

function AvatarModel:resetUIState()
	for k, v in pairs(self:getOwnCoverDataNames()) do
		self[v] = {}
	end

	for k, v in pairs(self:getOwnOtherDataNames()) do
		self[v] = nil
	end
end

function AvatarModel:getOwnPartTypeNames()
	return AvatarPartTypeName
end

function AvatarModel:getOwnPendanttTypeNames()
	return AvatarPendantTypeName
end

function AvatarModel:getOwnCoverDataNames()
	if not self.ownCoverDataNames then
		local tem = {}

		for k, v in pairs(self:getOwnPartTypeNames()) do
			table.insert(tem, v)
		end

		for k, v in pairs(self:getOwnPendanttTypeNames()) do
			table.insert(tem, v)
		end

		self.ownCoverDataNames = tem
	end

	return self.ownCoverDataNames
end

function AvatarModel:getOwnNakeParts()
	return {}
end

function AvatarModel:getOwnOtherUIDataNames()
	return {
		AvatarDataTypeName[AvatarDataType.UIBG],
		AvatarDataTypeName[AvatarDataType.UISpine]
	}
end

function AvatarModel:getOwnOtherDataNames()
	return AvatarDataTypeName
end

function AvatarModel:isAllSame(mo)
	if mo then
		return self.skeleton == mo.skeleton and self:isAllCoverDataSame(mo) and self:isAllOtherDataSame(mo)
	end

	return false
end

function AvatarModel:isAllCoverDataSame(mo)
	for k, v in pairs(self:getOwnCoverDataNames()) do
		if not mo[v] or mo[v].value ~= self[v].value then
			return false
		end
	end

	return true
end

function AvatarModel:isAllOtherDataSame(mo)
	for k, v in pairs(self:getOwnOtherDataNames()) do
		if mo[v] ~= self[v] then
			return false
		end
	end

	return true
end

function AvatarModel:copyDataByMo(mo)
	if not mo then
		return
	end

	self:reset()

	self.skeleton = mo.skeleton

	for k, v in pairs(self:getOwnCoverDataNames()) do
		self[v].value = mo[v].value
		self[v].cover = mo[v].cover
	end

	for k, v in pairs(self:getOwnOtherDataNames()) do
		self[v] = mo[v]
	end

	self.defaultDatas = mo.defaultDatas
end

function AvatarModel:setSkeletonByCfgId(Id, isSetDefault)
	self.skeleton = Id

	if isSetDefault then
		self:setDefaultDatas(AvatarConfig.instance:getAvatarDefaultDatasByCfg(self.skeleton))
	end
end

function AvatarModel:setDefaultDatas(defaultDatas)
	self.defaultDatas = defaultDatas or {}
end

function AvatarModel:setDataByCfgId(id)
	if not self.skeleton then
		printError("avatar model should set skeleton first")

		return
	end

	local dataCfg = AvatarConfig.instance:getPartCfgById(id)
	local type = dataCfg and dataCfg.partType

	if type then
		local typeName = AvatarDataTypeName[type]

		if typeName and table.keyof(self:getOwnOtherDataNames(), typeName) then
			self[typeName] = id

			return
		end

		local belong = dataCfg and dataCfg.belongTo

		if belong and not table.keyof(belong, self.skeleton) then
			print(string.format("换装Id：%s对不上骨架Id：%s", id, self.skeleton))
		end

		typeName = AvatarPendantTypeName[type] or AvatarPartTypeName[type]

		if typeName and table.keyof(self:getOwnCoverDataNames(), typeName) then
			self:setCoverData(type, id, dataCfg.cover)
		end
	else
		printError("Exit Avatar Part Cfg Error", id)
	end
end

function AvatarModel:setCoverData(type, id, cover)
	local curValue, typeName, curCover = self:getDataByType(type)

	if curCover ~= id then
		self:removeDataByType(type)

		if cover then
			for k, v in ipairs(cover) do
				self:removeDataByType(v)
			end
		end

		self[typeName].cover = id
		self[typeName].value = id

		if cover then
			for k, v in ipairs(cover) do
				typeName = AvatarPartTypeName[v] or AvatarPendantTypeName[v]
				self[typeName].cover = id
			end
		end
	end
end

function AvatarModel:getDefaultDatas()
	return self.defaultDatas or {}
end

function AvatarModel:getDataByType(type)
	local var_20_0 = AvatarPartTypeName[type]

	if not AvatarPartTypeName[type] then
		var_20_0 = AvatarPendantTypeName[type]

		if not AvatarPendantTypeName[type] then
			local typeName = AvatarDataTypeName[type]

			if table.keyof(self:getOwnCoverDataNames(), typeName) then
				return self[typeName].value, typeName, self[typeName].cover, true
			end

			if table.keyof(self:getOwnOtherDataNames(), typeName) then
				return self[typeName], typeName
			end
		end
	end
end

function AvatarModel:removeDataByType(type)
	local curValue, typeName, curCover, isCover = self:getDataByType(type)

	if isCover then
		for k, v in pairs(self:getOwnCoverDataNames()) do
			if self[v].cover == curCover then
				self[v].value = nil
				self[v].cover = nil
			end
		end
	else
		self[typeName] = nil
	end
end

function AvatarModel:removeDataByCfgId(Id)
	if self:isExistDataByCfgId(Id) then
		local partCfg = AvatarConfig.instance:getPartCfgById(Id)
		local type = partCfg and partCfg.partType

		self:removeDataByType(type)
	end
end

function AvatarModel:isExistDataByCfgId(Id)
	if not Id then
		return false
	end

	local partCfg = AvatarConfig.instance:getPartCfgById(Id)
	local type = partCfg and partCfg.partType

	if not type then
		print("avatar part Cfg Exist Error " .. Id)

		return
	end

	local curvalue, typeName = self:getDataByType(type)

	return curvalue == Id
end

function AvatarModel:toCombineKey()
	self._keys = self._keys or {}

	table.clear(self._keys)

	for k, v in pairs(self:getOwnPartTypeNames()) do
		if not self[v].value then
			table.insert(self._keys, v)
			table.insert(self._keys, self[v].value)
		end
	end

	return table.concat(self._keys)
end

function AvatarModel:getCurCoverDataValue()
	local curValues = {}

	for k, v in pairs(self:getOwnCoverDataNames()) do
		local id = self[v].value

		if id and id > 0 then
			table.insert(curValues, id)
		end
	end

	return curValues
end

function AvatarModel:setDefaultState()
	for k, v in ipairs(self:getDefaultDatas()) do
		local cfg = AvatarConfig.instance:getPartCfgById(v)
		local type = cfg and cfg.partType
		local curId, typeName, curCover = self:getDataByType(type)

		if not curCover then
			if v == 999902 and not self:isExistDataByCfgId(100902) then
				v = 100901
			end

			if v == 100902 and self:isExistDataByCfgId(100901) then
				self:removeDataByType(AvatarPartType.Top)
			end

			self:setDataByCfgId(v)
		end
	end
end

function AvatarModel:getAssetsList(avatarUseType)
	local assets = {}

	if self.skeleton then
		local skecfg = AvatarConfig.instance:getSkeletonCfgById(self.skeleton)
		local skePath = GameUrl.getAvatarSkeleton(skecfg.asset, avatarUseType)

		table.insert(assets, skePath)
	end

	for k, v in pairs(self:getOwnCoverDataNames()) do
		local id = self[v].value

		if id and id > 0 then
			local partCfg = AvatarConfig.instance:getPartCfgById(id)

			if partCfg and partCfg.partType ~= AvatarDataType.UIBG then
				local resPath = GameUrl.getAvatarPart(partCfg.asset, v, avatarUseType, partCfg.isResSame)

				table.insert(assets, resPath)
			end
		end
	end

	for k, v in pairs(self:getOwnOtherUIDataNames()) do
		local id = self[v]

		if id and id > 0 then
			local partCfg = AvatarConfig.instance:getPartCfgById(id)

			if partCfg and partCfg.partType ~= AvatarDataType.UIBG then
				local resPath = GameUrl.getAvatarPart(partCfg.asset, v, avatarUseType, partCfg.isResSame)

				table.insert(assets, resPath)
			end
		end
	end

	return assets
end

return AvatarModel
