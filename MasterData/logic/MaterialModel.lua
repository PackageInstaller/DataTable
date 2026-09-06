-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/model/MaterialModel.lua

module("logic.extensions.material.model.MaterialModel", package.seeall)

local MaterialModel = class("MaterialModel", BaseModel)
local itemMoMap = {
	[MatType.Item] = ItemMo
}
local _cfg_ID_Names = {
	[MatType.Cloth] = "id",
	[MatType.Item] = "id",
	[MatType.Pet] = "raceId",
	[MatType.PokeBall] = "id",
	[MatType.Coin] = "id",
	[MatType.Diamond] = "id",
	[MatType.GodGem] = "id",
	[MatType.Strength] = "id",
	[MatType.Rune] = "defineId",
	[MatType.Equipment] = "id",
	[MatType.ACTIVITY_ITEM] = "id",
	[MatType.Throne] = "id",
	[MatType.Hoshigami] = "id",
	[MatType.StarGodPlus] = "id",
	[MatType.PET_SKIN] = "skinId",
	[MatType.HIRE_PET] = "defineId",
	[MatType.HeadIcon] = "id",
	[MatType.HeadFrame] = "id",
	[MatType.CutePet] = "raceId"
}

function MaterialModel:ctor()
	MaterialModel.super.ctor(self)
end

function MaterialModel:onInit()
	self:onReset()

	self._typeCfgs = {}
	self._cfgs = {}

	if enableDebug then
		GlobalDispatcher:addListener(GlobalNotify.AllExtensionsLoaded, self.initData, self)
	end
end

function MaterialModel:onReset()
	self._materials = {}
	self._changeSetMap = {}
	self.deletedMatList = {}
	self._temPool = {}
	self.mixSelectOnceList = {}
	self.mixSelectOnceMap = {}
end

function MaterialModel:initData()
	GlobalDispatcher:removeListener(GlobalNotify.AllExtensionsLoaded, self.initData, self)

	self._typeCfgs[MatType.Cloth] = DressConfig.instance:getAllConfig()
	self._typeCfgs[MatType.Item] = ItemConfig.instance:getCfgs()
	self._typeCfgs[MatType.Pet] = CharacterConfig.instance:getPetCfgs()
	self._typeCfgs[MatType.PokeBall] = BattleConfig.instance:getBattleItems()
	self._typeCfgs[MatType.Coin] = ItemConfig.instance:getScoreCfgs()
	self._typeCfgs[MatType.Diamond] = ItemConfig.instance:getDiamondCfgs()
	self._typeCfgs[MatType.GodGem] = ItemConfig.instance:getGodGemCfgs()
	self._typeCfgs[MatType.Rune] = RuneConfig.instance:getAllRunes()
	self._typeCfgs[MatType.Equipment] = EquipmentConfig.instance:getAllEquips()
	self._typeCfgs[MatType.ACTIVITY_ITEM] = ItemConfig.instance._activityCfg.dataList
	self._typeCfgs[MatType.Throne] = ThroneConfig.instance:getThroneCfgs()
	self._typeCfgs[MatType.Hoshigami] = HoshigamiConfig.instance:getHoshigamiCfgs()
	self._typeCfgs[MatType.PET_SKIN] = PetSkinConfig.instance.pet_skin_cfg.dataList
	self._typeCfgs[MatType.StarGodPlus] = StargodplusConfig.instance:getFillerCfgs()
	self._typeCfgs[MatType.HIRE_PET] = PetHireConfig.instance:getAllHirePetCfgs()
	self._typeCfgs[MatType.HeadIcon] = HeadItemConfig.instance:getAllHeadIconList()
	self._typeCfgs[MatType.HeadFrame] = HeadItemConfig.instance:getAllHeadFrameList()
	self._typeCfgs[MatType.CutePet] = CutePetConfig.instance:getCutePetList()

	for k, v in pairs(self._typeCfgs) do
		self._cfgs[k] = {}

		self:_loadCfgByType(k)
	end

	self._typeCfgs[MatType.Strength] = {}
	self._cfgs[MatType.Strength] = {
		{
			search_name = "体力 <color=#BDFFBD> 60:1 </color>",
			upName = "TL",
			id = 1,
			level = 0,
			name = lang("体力"),
			matType = MatType.Strength
		}
	}
end

function MaterialModel:_loadCfgByType(matType)
	local cfg = self._typeCfgs[matType]

	for k, v in pairs(cfg) do
		local item = {}
		local id = v[_cfg_ID_Names[matType]]

		item.id = id
		item.value = v
		item.name = lang(v.name)

		local lvl = -1

		if matType == MatType.Pet or matType == MatType.Rune then
			lvl = 1
			item.level = 1
		elseif matType == MatType.Cloth then
			item.level = -1
		elseif matType == MatType.PET_SKIN then
			item.name = v.skinName
		elseif matType == MatType.HIRE_PET then
			item.name = v.creepsName
		else
			lvl = 0
			item.level = 0
		end

		item.matType = matType

		if item.name and item.id then
			if enableDebug then
				item.search_name = (lang(item.name) or "") .. " <color=#BDFFBD> " .. matType .. ":" .. id .. " </color>"
				item.upName = Framework.PinyinConverter.HZToPYSimple(item.name)
			end

			table.insert(self._cfgs[matType], item)
		end
	end
end

function MaterialModel:getMaterialsNameByStr(str)
	local arr = string.split(str, ":")

	return self:getMaterialsName(arr[1], arr[2])
end

function MaterialModel:getMaterialsName(matType, id)
	return MaterialMgr.getMaterialsName(matType, id)
end

function MaterialModel:addChangeSetItems(changeSetId, infos)
	if infos then
		self._changeSetMap[changeSetId] = self._changeSetMap[changeSetId] or {}

		for _, info in ipairs(infos) do
			if info.items then
				for _, item in ipairs(info.items) do
					if item.num > 0 then
						local mo

						for k, v in pairs(self._changeSetMap[changeSetId]) do
							if v:checkSameByTypeId(info.materialType, item.id) then
								mo = v

								break
							end
						end

						if mo ~= nil then
							mo:addCount(item.num)
						elseif info.materialType == MatType.Cloth then
							local dressCfg = MaterialMgr.getMatCfg(info.materialType, item.id)

							if dressCfg and (dressCfg.clothesGender == GameEnum.Gender.Neutral or dressCfg.clothesGender == RoleModel.instance:getGender()) then
								mo = self:createMo(info.materialType, item.id, item.num)

								table.insert(self._changeSetMap[changeSetId], mo)
							end
						else
							mo = self:createMo(info.materialType, item.id, item.num)

							table.insert(self._changeSetMap[changeSetId], mo)
						end
					end
				end
			end
		end
	end

	if changeSetId < 0 then
		self._changeSetMap[changeSetId] = nil
	end
end

function MaterialModel:popChnageSetList(changesetList, changeSetMap)
	if changeSetMap == nil then
		changeSetMap = self._changeSetMap
	end

	local items = {}
	local lockList = {}

	for k, changeSetId in pairs(changesetList) do
		changeSetId = checknumber(changeSetId)

		if lockList[changeSetId] == nil then
			lockList[changeSetId] = true

			local arr = changeSetMap[changeSetId]

			if arr ~= nil then
				for k, v in pairs(arr) do
					local mo

					for _, item in ipairs(items) do
						if v:checkSameByTypeId(item.type, item.id) then
							mo = v

							item:addCount(v.num)

							break
						end
					end

					if mo == nil then
						table.insert(items, v)
					end
				end
			end
		end
	end

	for k, changeSetId in pairs(changesetList) do
		changeSetId = checknumber(changeSetId)
		changeSetMap[changeSetId] = nil
	end

	return items
end

function MaterialModel:popChangeSetItems(changeSetId, changeSetMap)
	if changeSetMap == nil then
		changeSetMap = self._changeSetMap
	end

	if type(changeSetId) == "number" then
		changeSetMap[changeSetId] = nil

		return changeSetMap[changeSetId]
	end

	return nil
end

function MaterialModel:getMaterialMos(changeSetId)
	if self._changeSetMap then
		return self._changeSetMap[changeSetId] or {}
	end
end

function MaterialModel:isChangeSetIdValid(changeSetId)
	local arr = self._changeSetMap[changeSetId]

	return arr and #arr > 0
end

function MaterialModel:setMaterials(infos, isChange)
	if infos then
		for _, info in ipairs(infos) do
			if info.items then
				for _, item in ipairs(info.items) do
					self:AddMaterial(info.materialType, item.id, item.num)
				end
			end
		end
	end

	if not isChange then
		GlobalDispatcher:dispatch(GlobalNotify.OnMaterialInited)
	end
end

function MaterialModel:AddMaterial(matType, id, count)
	return self:UpdateMaterial(matType, id, count, true)
end

function MaterialModel:UpdateMaterial(matType, id, count, isAdd)
	self._materials = self._materials or {}
	self._materials[matType] = self._materials[matType] or {}

	local mo = self._materials[matType][id]

	if mo == nil then
		mo = self:createMo(matType, id, 0)
		self._materials[matType][id] = mo
	end

	if isAdd then
		mo:SetCount(count + mo:GetCount())
	else
		mo:SetCount(count)
	end

	if (matType == MatType.Pet or matType == MatType.BorrowPet) and mo:GetCount() > 0 then
		mo:SetCount(1)
	end

	if mo:GetCount() <= 0 and (mo.type ~= MatType.Coin or mo.id ~= MatType.Coin_Gold) and not mo.type == MatType.Item_Fake then
		self._materials[matType][id] = nil
		self.deletedMatList[matType] = self.deletedMatList[matType] or {}
		self.deletedMatList[matType][id] = true
	else
		self.deletedMatList[matType] = self.deletedMatList[matType] or {}
		self.deletedMatList[matType][id] = nil
	end

	MaterialController.instance:addUpdateMo(mo)

	return mo
end

function MaterialModel:createMo(matType, id, num)
	matType = checknumber(matType)
	id = checknumber(id)

	local mo

	num = num or 0

	local moCls = itemMoMap[matType]

	mo = moCls ~= nil and moCls.New() or MaterialMo.New()

	mo:initData(matType, id, num)

	return mo
end

function MaterialModel:createMoByData(strOrData)
	if type(strOrData) == "string" then
		strOrData = string.gsub(strOrData, "=", ":")

		local arr = string.split(strOrData, ":")
		local type = checknumber(arr[1])
		local id = checknumber(arr[2])
		local len = math.max(3, #arr)
		local num = checknumber(arr[len])

		return self:createMo(type, id, num)
	else
		return self:createMo(strOrData.type, strOrData.id, strOrData.num)
	end
end

function MaterialModel:getMaterialMo(type, id)
	self._materials = self._materials or {}
	self._materials[type] = self._materials[type] or {}

	return self._materials[type][id]
end

function MaterialModel:getTempMo(type, id)
	type = checknumber(type)
	id = checknumber(id)

	local mo = self:getMaterialMo(type, id)

	if mo == nil then
		self._temPool = self._temPool or {}
		mo = self._temPool[type]

		if self._temPool[type] == nil then
			mo = self:createMo(type, id, 0)
			self._temPool[type] = mo
		else
			mo:initData(type, id, 0)
		end
	end

	return mo
end

function MaterialModel:getMaterialsNumber(matType, id)
	matType = checknumber(matType)
	id = checknumber(id)

	if matType == MatType.Pet then
		return BagModel.instance:getRaceIdCount(id)
	elseif matType == MatType.Coin and id == MatType.Coin_Family_Money then
		return FamilyModel.instance:getMoney()
	elseif matType == MatType.PET_SKIN then
		local cfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, id)

		if cfg then
			::label_20_0::

			local status = PetskinController.instance:checkHasSkinStatus(cfg)

			if status == PetskinController.SKIN_STATUS_ORIGINAL or status == PetskinController.SKIN_STATUS_HAD then
				return 1
			else
				return 0
			end
		end
	elseif matType == MatType.Strength then
		local info = SupplyModel.instance:getTiliCommonInfo()

		return info ~= nil and checknumber(info.tiliNowCount) or 0
	elseif matType == MatType.ACTIVITY_ENERGY then
		return EnergyModel.instance:getCurEnergy(id)
	elseif matType == MatType.Diamond_Consume then
		local total = 0
		local mat1 = self:getMaterialMo(MatType.Diamond, MatType.Diamond_Normal)

		if mat1 then
			total = total + mat1:GetCount()
		end

		local mat2 = self:getMaterialMo(MatType.Diamond, MatType.Diamond_Binding)

		if mat2 then
			total = total + mat2:GetCount()
		end

		return total
	elseif matType == MatType.GodGem then
		local total = 0
		local mat1 = self:getMaterialMo(MatType.GodGem, MatType.GodGem_Normal)

		if mat1 then
			total = total + mat1:GetCount()
		end

		local mat2 = self:getMaterialMo(MatType.GodGem, MatType.GodGem_Binding)

		if mat2 then
			total = total + mat2:GetCount()
		end

		return total
	elseif matType == MatType.Throne then
		return ThroneModel.instance:getThroneBagNum(id)
	elseif matType == MatType.Equipment then
		local arr = PetEquipModel.instance:GetEquipInfos(id)

		if arr then
			return #arr
		end

		return 0
	elseif matType == MatType.StarGodPlus then
		local moList = StargodplusModel.instance:getFillerMoList()
		local num = 0

		if moList then
			for k, mo in pairs(moList) do
				if mo:getDefineId() == id then
					num = num + 1
				end
			end
		end

		return num
	elseif matType == MatType.HeadIcon or matType == MatType.HeadFrame then
		local moList = MaterialMgr.getModelList(matType)
		local num = 0

		if moList then
			for k, mo in pairs(moList) do
				if mo:getDefineId() == id then
					num = num + 1
				end
			end
		end

		return num
	elseif matType == MatType.TimedItem then
		return TimedItemModel.instance:getTimedItemNum(id)
	elseif matType == MatType.HolyStripe then
		return HolyStripeModel.instance:getHolyStripeNum(id)
	elseif matType == MatType.ExpirableItem then
		return TimedItemModel.instance:getExpireableItemNumByDefineId(id)
	elseif matType == MatType.CutePet then
		return CutePetModel.instance:getCutePetItemNumByDefineId(id)
	elseif matType == MatType.Cloth then
		if DressModel.instance:getIsOwnDressById(id) then
			return 1
		else
			return 0
		end
	elseif matType == MatType.EmojiPack then
		local isUnlocked = NewChatModel.instance:isEmoticonGroupUnlocked(id)

		return isUnlocked and 1 or 0
	elseif matType == MatType.OpeningEffect or matType == MatType.HomePageBg or matType == MatType.NameFrame or matType == MatType.PlayerMessageSkin or matType == MatType.BattleUserInterfaceSkin or matType == MatType.BattleBackgroundSkin then
		local isWith = BattleStartAnimModel.instance:isWith(matType, id)

		return isWith and 1 or 0
	else
		local mat = self:getMaterialMo(matType, id)

		return mat == nil and 0 or mat:GetCount()
	end
end

function MaterialModel:getMaterialsByType(matType)
	matType = checknumber(matType)

	if self._materials[matType] == nil then
		return {}
	end

	local materials = self._materials[matType]

	return TableUtil.Where(materials, function(mat)
		return mat:GetCount() > 0
	end, pairs)
end

function MaterialModel:splitMaterials(items)
	local list = {}

	for k, v in pairs(items) do
		local len = v:GetCount()

		for i = 1, len do
			local mo = v:clone()

			mo:SetCount(1)
			table.insert(list, mo)
		end
	end

	return list
end

function MaterialModel:getMaterialsByTypeAndSub(subType, matType)
	matType = matType or MatType.Item

	local ret = self:getMaterialsByType(matType)

	return TableUtil.Where(ret, function(mat)
		return mat:GetSubType() == subType
	end, pairs)
end

function MaterialModel:getMaterialsByTypeExceptSub(subType, matType)
	matType = matType or MatType.Item

	local ret = self:getMaterialsByType(matType)

	return TableUtil.Where(ret, function(mat)
		return mat:GetSubType() ~= subType
	end, pairs)
end

function MaterialModel:IsEnough(matType, id, needCount, ownedNum)
	local count = 0

	if not ownedNum then
		if matType == MatType.Diamond then
			for _, mat in ipairs(self:getMaterialsByType(matType)) do
				count = count + mat:GetCount()
			end
		else
			count = self:getMaterialsNumber(matType, id)
		end
	else
		count = ownedNum
	end

	return needCount <= count
end

function MaterialModel:updateMixSelectOnceList(msg)
	self.mixSelectOnceMap = {}
	self.mixSelectOnceList = {}

	local v = GameUtil.pbToTable(msg)

	table.insert(self.mixSelectOnceList, v)

	local key = v.materialType .. "_" .. v.materialId

	self.mixSelectOnceMap[key] = v.selectContent

	GlobalDispatcher:dispatch(GlobalNotify.OnMixOnceInfo)
end

function MaterialModel:checkHasMixSelectContent(type, id, content)
	local key = type .. "_" .. id
	local arr = self.mixSelectOnceMap[key]

	if arr then
		for i, v in ipairs(arr) do
			if content == v then
				return true
			end
		end
	end

	return false
end

MaterialModel.instance = MaterialModel.New()

return MaterialModel
