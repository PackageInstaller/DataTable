-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/MaterialMgr.lua

module("logic.extensions.material.MaterialMgr", package.seeall)

local MaterialMgr = class("MaterialMgr")
local PREFAB_PATH_CONF = {}
local LOADER_LIST = {}
local All_CONF_TYPES = {}
local skillSortingKeys, psychicSkillSortingKeys, allSkillsSortingKeys

MaterialMgr.SkillName = {
	[GameEnum.SkillRaceType.Passive] = "passiveSkillId",
	[GameEnum.SkillRaceType.Normal] = "normalSkillId",
	[GameEnum.SkillRaceType.Ult] = "ultSkillId",
	[GameEnum.SkillRaceType.Hero] = "heroSkillId",
	[GameEnum.SkillRaceType.Summon] = "summonSkillId",
	[GameEnum.SkillRaceType.Combine] = "combinationSkillId",
	[GameEnum.SkillRaceType.Domain] = "domainSkillId",
	[GameEnum.SkillRaceType.Element] = "elementSkillId",
	[GameEnum.SkillRaceType.AwakenSkill] = "awakenSkillId",
	[GameEnum.SkillRaceType.ShenYaoSkill] = "shenyaoSkillId",
	[GameEnum.SkillRaceType.JuanYouSkill] = "carriedSkillId",
	[GameEnum.SkillRaceType.ShenShiSkill] = "oracleSkillId",
	[GameEnum.SkillRaceType.BenyuanSkill] = "sourceSkillId",
	[GameEnum.SkillRaceType.TianjueSkill] = "heavenAwakenSkillId",
	[GameEnum.SkillRaceType.SourceTraceSkill] = "yuanjiSkillId",
	[GameEnum.SkillRaceType.GenesisSkill] = "genesisSkillId",
	[GameEnum.SkillRaceType.BookSpiritSkill] = "bookSpiritSkillId",
	[GameEnum.SkillRaceType.SpiritInvocationSkill] = "spiritInvocationSkillId"
}
MaterialMgr.SkillNameSort = {
	[GameEnum.SkillRaceType.Passive] = 1,
	[GameEnum.SkillRaceType.Normal] = 2,
	[GameEnum.SkillRaceType.Ult] = 3,
	[GameEnum.SkillRaceType.Hero] = 4,
	[GameEnum.SkillRaceType.Summon] = 5,
	[GameEnum.SkillRaceType.Combine] = 6,
	[GameEnum.SkillRaceType.Domain] = 8,
	[GameEnum.SkillRaceType.Element] = 9,
	[GameEnum.SkillRaceType.AwakenSkill] = 13,
	[GameEnum.SkillRaceType.ShenYaoSkill] = 14,
	[GameEnum.SkillRaceType.JuanYouSkill] = 15,
	[GameEnum.SkillRaceType.ShenShiSkill] = 16,
	[GameEnum.SkillRaceType.BenyuanSkill] = 17,
	[GameEnum.SkillRaceType.TianjueSkill] = 18,
	[GameEnum.SkillRaceType.BookSpiritSkill] = 18.5,
	[GameEnum.SkillRaceType.SourceTraceSkill] = 19,
	[GameEnum.SkillRaceType.GenesisSkill] = 20,
	[GameEnum.SkillRaceType.SpiritInvocationSkill] = 21
}
MaterialMgr.PsychicSkillName = {
	[GameEnum.SkillRaceType.PsychicSkillNormal] = "psychicedNormalSkillId",
	[GameEnum.SkillRaceType.PsychicSkillUtl] = "psychicedUltSkillId",
	[GameEnum.SkillRaceType.PsychicSkill] = "psychicSkillId"
}
MaterialMgr.SkillLvlKey = {
	[GameEnum.SkillRaceType.Passive] = "passiveSkillLv",
	[GameEnum.SkillRaceType.Normal] = "normalSkillLv",
	[GameEnum.SkillRaceType.Ult] = "ultimateSkillLv",
	[GameEnum.SkillRaceType.Hero] = "",
	[GameEnum.SkillRaceType.Summon] = "",
	[GameEnum.SkillRaceType.Combine] = "",
	[GameEnum.SkillRaceType.Domain] = "",
	[GameEnum.SkillRaceType.PsychicSkill] = "",
	[GameEnum.SkillRaceType.PsychicSkillNormal] = "psychicedNormalSkillLv",
	[GameEnum.SkillRaceType.PsychicSkillUtl] = "psychicedUltimateSkillLv",
	[GameEnum.SkillRaceType.Element] = "",
	[GameEnum.SkillRaceType.ShenYaoSkill] = "",
	[GameEnum.SkillRaceType.JuanYouSkill] = ""
}
MaterialMgr.PROXY_POOL = {}
MaterialMgr.PROXY_TIMES = {}
MaterialMgr.delayRecycleTime = 111

function MaterialMgr:_initConf()
	self:_addConf(MatType.Skill, "ui/views/common/item_skillicon.prefab", SkillCell)
	self:_addConf(MatType.Rare, "ui/views/common/item_rare.prefab", RareCell)
	self:_addConf(MatType.PetSkin_Rare, "ui/views/common/item_pet_rare.prefab", PetRareCell)
	self:_addConf(MatType.Item_Fake, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.Rune_Suit, "ui/views/rune/runesuitcell.prefab", RuneSuitCell)
	self:_addConf(MatType.Item_Jump, "ui/views/common/item_jump.prefab", JumpCell)
	self:_addConf(MatType.Item_Jump_Right, "ui/views/common/item_jumpright.prefab", JumpRightCell)
	self:_addConf(MatType.Item_Badge, "ui/views/common/item_badge.prefab", BadgeIconCell)
	self:_addConf(MatType.Item, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.Item, "ui/views/common/item_cell.prefab", ItemCell, MatType.Item_Normal)
	self:_addConf(MatType.Item, "ui/views/common/item_cell.prefab", FruitCell, MatType.Item_Fruit)
	self:_addConf(MatType.Coin, "ui/views/common/item_cell.prefab", GoldCell)
	self:_addConf(MatType.Diamond, "ui/views/common/item_cell.prefab", GoldCell)
	self:_addConf(MatType.PayDiamond, "ui/views/common/item_cell.prefab", GoldCell)
	self:_addConf(MatType.GodGem, "ui/views/common/item_cell.prefab", GoldCell)
	self:_addConf(MatType.Cloth, "ui/views/common/item_dress.prefab", DressCell)
	self:_addConf(MatType.Pet, "ui/views/common/item_pet.prefab", PetCell)
	self:_addConf(MatType.BorrowPet, "ui/views/common/item_pet.prefab", BorrowCell)
	self:_addConf(MatType.PetPiece, "ui/views/common/item_petpiece.prefab", PetPieceCell)
	self:_addConf(MatType.Rune, "ui/views/common/item_rune.prefab", RuneCell)
	self:_addConf(MatType.HeadIcon, "ui/views/common/item_head.prefab", HeadCell)
	self:_addConf(MatType.HeadFrame, "ui/views/common/item_headframe.prefab", HeadFrameCell)
	self:_addConf(MatType.Bubble, "ui/views/common/item_chatbubble.prefab", ChatFrameCell)
	self:_addConf(MatType.PET_SKIN, "ui/views/common/item_petskin.prefab", PetSkinCell)
	self:_addConf(MatType.MOCK_EQUIPMENT, "ui/views/common/item_mock_equip.prefab", EquipMockCell)
	self:_addConf(MatType.MOCK_STARGOD, "ui/views/common/item_stargodplus.prefab", StarGodPlusMockCell)
	self:_addConf(MatType.MOCK_HOLY_STRIPE, "ui/views/common/item_holystripe.prefab", HolyStripeMockCell)
	self:_addConf(MatType.Equipment, "ui/views/common/item_equip.prefab", EquipCell)
	self:_addConf(MatType.Decoration, "ui/views/common/item_equip.prefab", EquipCell)
	self:_addConf(MatType.ZooEgg, "ui/views/common/item_cell.prefab", EggCell)
	self:_addConf(MatType.Strength, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.DROP_ITEM, "ui/views/common/item_cell.prefab", DropCell)
	self:_addConf(MatType.ACTIVITY_ITEM, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.Title, "ui/views/common/item_title.prefab", ItemTitle)
	self:_addConf(MatType.Throne, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.Hoshigami, "ui/views/common/hoshigamicell.prefab", HoshigamiCell)
	self:_addConf(MatType.StarGodPlus, "ui/views/common/item_stargodplus.prefab", StarGodPlusCell)
	self:_addConf(MatType.ACTIVITY_ENERGY, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.TimedItem, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.ExpirableItem, "ui/views/common/item_time_cell.prefab", ExpirableCell)
	self:_addConf(MatType.Emoji, "ui/views/common/item_emoji.prefab", EmojiCell)
	self:_addConf(MatType.EmojiPack, "ui/views/common/item_emoji.prefab", EmojiPackCell)
	self:_addConf(MatType.HIRE_PET, "ui/views/common/item_pet.prefab", HirePetCell)
	self:_addConf(MatType.HolyStripe, "ui/views/common/item_holystripe.prefab", HolyStripeCell)
	self:_addConf(MatType.PetTitle, "ui/views/common/item_pettitle.prefab", PetTitleCell)
	self:_addConf(MatType.OpeningEffect, "ui/views/common/item_openingeffect.prefab", OpeningEffectCell)
	self:_addConf(MatType.HomePageBg, "ui/views/common/item_homepagebg.prefab", HomePageBgCell)
	self:_addConf(MatType.NameFrame, "ui/views/common/item_nameframe.prefab", NameFrameCell)
	self:_addConf(MatType.PlayerMessageSkin, "ui/views/common/item_playermessageskin.prefab", PlayerMessageSkinCell)
	self:_addConf(MatType.CutePet, "ui/views/common/item_cutepet.prefab", CutePetCell)
	self:_addConf(MatType.BattleUserInterfaceSkin, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.BattleBackgroundSkin, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.ImpressionSticker, "ui/views/common/item_cell.prefab", ItemCell)
	self:_addConf(MatType.ImpressionPoster, "ui/views/common/item_cell.prefab", ItemCell)
end

function MaterialMgr:ctor()
	local go = goutil.create(self.__cname)

	self._root = go.transform

	goutil.addComponentOnce(go, typeof("UnityEngine.CanvasGroup"))

	local view = SceneRoot2DMgr.instance:getSceneUIRoot()

	goutil.addChildToParent(go, view)

	local trans = go:GetComponent(goutil.Type_RectTransform)

	trans.anchorMin = Vector2.New(0.5, 0.5)
	trans.anchorMax = Vector2.New(0.5, 0.5)
	trans.pivot = Vector2.New(0, 1)

	goutil.setWidth(trans, 0)
	goutil.setHeight(trans, 0)
	self:_initConf()
end

function MaterialMgr:_addConf(matType, path, cellcls, subType)
	local key = self:_getKey(matType, subType)

	PREFAB_PATH_CONF[key] = {
		path = path,
		cellcls = cellcls
	}
	All_CONF_TYPES[matType] = true
end

function MaterialMgr:getHasCell(matType)
	if Framework.OSDef.isEditor and not All_CONF_TYPES[matType] then
		printError("忘记配置_addConf了！！")
	end

	return All_CONF_TYPES[matType]
end

function MaterialMgr:_getPath(matType, subType)
	local key = self:_getKey(matType, subType)
	local obj = PREFAB_PATH_CONF[key]

	if obj ~= nil then
		return obj.path
	else
		key = self:_getKey(matType, 0)
		obj = PREFAB_PATH_CONF[key]

		if PREFAB_PATH_CONF[key] ~= nil then
			return obj.path
		end
	end

	return nil
end

function MaterialMgr:_getCellCls(matType, subType)
	local key = self:_getKey(matType, subType)
	local obj = PREFAB_PATH_CONF[key]
	local cls

	if obj ~= nil then
		cls = obj.cellcls
	else
		key = self:_getKey(matType, 0)
		obj = PREFAB_PATH_CONF[key]

		if PREFAB_PATH_CONF[key] ~= nil then
			cls = obj.cellcls
		end
	end

	return cls
end

function MaterialMgr:_getKey(matType, subType)
	subType = subType or 0

	return matType .. "_" .. subType
end

function MaterialMgr.getSkillSortedKeys()
	if not skillSortingKeys then
		skillSortingKeys = {}

		for k, v in pairs(MaterialMgr.SkillName) do
			table.insert(skillSortingKeys, k)
		end

		table.sort(skillSortingKeys, function(x, y)
			return MaterialMgr.SkillNameSort[x] < MaterialMgr.SkillNameSort[y]
		end)
	end

	return skillSortingKeys
end

function MaterialMgr.getPsychicSkillSortedKeys()
	if not psychicSkillSortingKeys then
		psychicSkillSortingKeys = {}

		for k, v in pairs(MaterialMgr.PsychicSkillName) do
			table.insert(psychicSkillSortingKeys, k)
		end

		table.sort(psychicSkillSortingKeys, function(x, y)
			return x < y
		end)
	end

	return psychicSkillSortingKeys
end

function MaterialMgr.getAllSkillsSortedKeys()
	if not allSkillsSortingKeys then
		allSkillsSortingKeys = {}

		local skillSortingKeys = MaterialMgr.getSkillSortedKeys()

		for i = 1, #skillSortingKeys do
			table.insert(allSkillsSortingKeys, skillSortingKeys[i])
		end

		local psychicSkillSortingKeys = MaterialMgr.getPsychicSkillSortedKeys()

		for i = 1, #psychicSkillSortingKeys do
			table.insert(allSkillsSortingKeys, psychicSkillSortingKeys[i])
		end
	end

	return allSkillsSortingKeys
end

function MaterialMgr.getSkillKeyNameByType(type)
	local keyName = MaterialMgr.SkillName[type]

	if keyName then
		return keyName
	end

	return MaterialMgr.PsychicSkillName[type]
end

function MaterialMgr.getMoType(mo)
	if mo then
		if mo.getMatType == nil or type(mo.getMatType) ~= "function" then
			if Framework.OSDef.isEditor then
				error(">>>>>> 只在电脑上报错 麻烦 重写  mo 的   getMatType 方法 给我返回个类型")
			end
		else
			return mo:getMatType()
		end
	end
end

function MaterialMgr.getMatCount(cfgStr)
	cfgStr = MaterialMgr.changeIfDrop(cfgStr)

	local arr = string.split(cfgStr, ":")
	local matType = checknumber(arr[1])
	local id = checknumber(arr[2])

	return MaterialModel.instance:getMaterialsNumber(matType, id)
end

function MaterialMgr.getMatEnough(cfgStr)
	if string.nilorempty(cfgStr) then
		return true
	end

	cfgStr = MaterialMgr.changeIfDrop(cfgStr)

	local matType, id, matNum = MaterialMgr.getMatParams(cfgStr)

	if matNum then
		return matNum <= MaterialModel.instance:getMaterialsNumber(matType, id)
	end

	return false
end

function MaterialMgr.getMatParams(cfgStr)
	if not string.nilorempty(cfgStr) then
		local arr = string.split(cfgStr, ":")
		local matType = checknumber(arr[1])
		local id = checknumber(arr[2])
		local len = math.max(3, #arr)
		local matNum = checknumber(arr[len])

		return matType, id, matNum
	end
end

function MaterialMgr.getModelList(matType)
	matType = checknumber(matType)

	local list

	return matType == MatType.Pet and BagPetsController.instance:getBagPets() or matType == MatType.PET_SKIN and PetskinModel.instance:getSkinInfoList() or matType == MatType.Equipment and PetEquipModel.instance:GetAllInfoMoList(MatType.Equipment) or matType == MatType.Decoration and PetEquipModel.instance:GetAllInfoMoList(MatType.Decoration) or matType == MatType.Rune and RuneModel.instance:getAllItems() or matType == MatType.Throne and ThroneModel.instance:getAllThroneMoList() or matType == MatType.StarGodPlus and StargodplusModel.instance:getFillerMoList() or matType == MatType.HeadIcon and HeadItemModel.instance:getHeadIconList() or matType == MatType.HeadFrame and HeadItemModel.instance:getHeadFrameList() or matType == MatType.TimedItem and TimedItemModel.instance:getTimedItemList() or matType == MatType.ExpirableItem and TimedItemModel.instance:getExpireableItemList() or matType == MatType.HolyStripe and HolyStripeModel.instance:getExistHolyStripeMoList() or matType == MatType.HIRE_PET and PetHireModel.instance:getAllInfoList() or matType == MatType.BorrowPet and BorrowPetModel.instance:getBagPets() or matType == MatType.CutePet and CutePetModel.instance:getAllCutePetsList() or MaterialModel.instance:getMaterialsByType(matType)
end

function MaterialMgr.getModel(matType, gid)
	matType = checknumber(matType)
	gid = checknumber(gid)

	local data

	return (matType == MatType.Pet or matType == MatType.BorrowPet) and BagPetsController.instance:getPet(gid) or matType == MatType.Equipment and PetEquipModel.instance:GetEquipInfo(gid) or matType == MatType.MOCK_EQUIPMENT and MaterialModel.instance:createMo(matType, gid, 1) or matType == MatType.MOCK_STARGOD and MaterialModel.instance:createMo(matType, gid, 1) or matType == MatType.MOCK_HOLY_STRIPE and MaterialModel.instance:createMo(matType, gid, 1) or matType == MatType.Decoration and PetEquipModel.instance:GetDecorationInfoByOnlyId(gid) or matType == MatType.Rune and RuneModel.instance:getItemData(gid) or matType == MatType.Rune_Suit and RuneModel.instance:getSuitMo(gid) or matType == MatType.HeadIcon and HeadItemModel.instance:getHeadIconInfo(gid) or matType == MatType.HeadFrame and HeadItemModel.instance:getHeadFrameInfo(gid) or matType == MatType.Hoshigami and HoshigamiModel.instance:getHoshigamiMo(gid) or matType == MatType.StarGodPlus and StargodplusModel.instance:getStarGodMo(gid) or matType == MatType.PET_SKIN and PetskinModel.instance:getSkinMoById(gid) or matType == MatType.ZooEgg and ZooModel.instance:getEggById(gid) or matType == MatType.TimedItem and TimedItemModel.instance:getTimedItemInfo(gid) or matType == MatType.ExpirableItem and TimedItemModel.instance:getExpireableItemInfo(gid) or matType == MatType.HIRE_PET and PetHireModel.instance:getPetInfoByDefineId(gid) or matType == MatType.HolyStripe and HolyStripeModel.instance:getHolyStripeMo(gid) or matType == MatType.Throne and ThroneModel.instance:getThroneMoById(gid) or matType == MatType.PetTitle and PetTitleModel.instance:getPetTitleMo(gid) or matType == MatType.CutePet and CutePetModel.instance:getCutePeMo(gid) or MaterialModel.instance:getMaterialMo(matType, gid)
end

function MaterialMgr.changeIfDropByTypeAndId(matType, cfgId)
	if matType == MatType.DROP_ITEM then
		local cfg = MaterialConfig.instance:getCfgByDropId(cfgId)
		local str = cfg.rewardPreview
		local first = string.split(str, "#")

		if first and #first == 1 then
			local arr = string.split(first[1], ":")

			matType = arr[1]
			cfgId = arr[2]
		end
	end

	return checknumber(matType), checknumber(cfgId)
end

function MaterialMgr.changeClothStrGender(cfgStr)
	local arr = string.split(cfgStr, ":")
	local matType, matId = checknumber(arr[1]), checknumber(arr[2])

	if matType == MatType.Cloth then
		local cfg = MaterialMgr.getMatCfg(matType, matId)

		if not cfg then
			printError("读取不到配置", cfgStr)

			return cfgStr
		end

		if cfg.clothesGender ~= RoleModel.instance:getGender() and cfg.clothesGender ~= GameEnum.Gender.Neutral and cfg.idsAfterTransformGender and #cfg.idsAfterTransformGender > 0 then
			arr[2] = cfg.idsAfterTransformGender[1]

			return table.concat(arr, ":")
		end
	end

	return cfgStr
end

function MaterialMgr.changeIfDrop(cfgStr)
	if string.nilorempty(cfgStr) then
		return nil
	else
		local arr = string.split(cfgStr, ":")
		local matType = checknumber(arr[1])
		local strId = arr[2]
		local id = checknumber(strId)

		if matType == MatType.DROP_ITEM then
			local len = math.max(3, #arr)
			local num = checknumber(arr[len])
			local cfg = MaterialConfig.instance:getCfgByDropId(checknumber(id))

			if cfg then
				local res = {}
				local itemList = string.split(cfg.rewardPreview, "#")

				for i, v in ipairs(itemList) do
					local str = MaterialMgr.changeIfDrop(v)

					if not string.nilorempty(str) then
						local tmp = string.split(str, ":")
						local len = math.max(3, #tmp)
						local matNum = checknumber(tmp[len])

						tmp[len] = matNum * num
						str = table.concat(tmp, ":")

						table.insert(res, str)
					end
				end

				return table.concat(res, "#")
			else
				if enableDebug then
					error(">>> 配置错误了 不存在 掉落物配置 " .. cfgStr)
				else
					printWarn(">>> 配置错误了 不存在 掉落物配置 " .. cfgStr)
				end

				return ""
			end
		else
			if matType == MatType.ACTIVITY_ITEM then
				local actCfg = MaterialMgr.getMatCfg(matType, strId)

				if actCfg and ActivityDefineController.instance:isInActivityTimeById(actCfg.activityType, actCfg.activityId) then
					return cfgStr
				else
					return ""
				end
			elseif matType == MatType.Cloth then
				local dressCfg = MaterialMgr.getMatCfg(matType, strId)

				if dressCfg and (dressCfg.clothesGender == GameEnum.Gender.Neutral or dressCfg.clothesGender == RoleModel.instance:getGender()) then
					return cfgStr
				else
					return ""
				end
			end

			return cfgStr
		end
	end
end

function MaterialMgr.changeItemStr(cfgStr)
	local arr = MaterialMgr.changeItemStrArr(cfgStr)

	return table.concat(arr, "#")
end

function MaterialMgr.changeItemStrArr(cfgStr)
	if string.nilorempty(cfgStr) then
		return {}
	else
		local arr = string.split(cfgStr, "#")
		local tb = {}

		for k, v in ipairs(arr or {}) do
			local str = MaterialMgr.changeIfDrop(v)

			if not string.nilorempty(str) then
				table.insert(tb, str)
			end
		end

		return tb
	end
end

function MaterialMgr.filterClothsStr(cfgStr)
	local arr = MaterialMgr.filterClothsArr(cfgStr)

	return table.concat(arr, "#")
end

function MaterialMgr.filterClothsArr(cfgStr)
	if string.nilorempty(cfgStr) then
		return {}
	else
		local arr = string.split(cfgStr, "#")
		local tb = {}

		for k, str in ipairs(arr or {}) do
			local type, id, num = MaterialMgr.getMatParams(str)

			if type == MatType.Cloth then
				local cfg = MaterialMgr.getMatCfg(type, id)

				if cfg and (checknumber(cfg.clothesGender) == checknumber(RoleModel.instance:getGender()) or checknumber(cfg.clothesGender) == 2) then
					table.insert(tb, str)
				end
			else
				table.insert(tb, str)
			end
		end

		return tb
	end
end

function MaterialMgr.mergeMatStrList(matStrList)
	local matPool = {}

	local function getKey(array)
		local key = array[1] .. ""

		for i = 2, #array - 1 do
			key = key .. ":" .. array[i]
		end

		return key
	end

	local key = ""
	local index = 0

	for _, matStr in ipairs(matStrList) do
		local array = string.split(matStr, ":")

		if #array >= 3 then
			key = getKey(array)

			if matPool[key] == nil then
				index = index + 1
				matPool[key] = {
					index = index,
					mat = array
				}
			else
				matPool[key].mat[#array] = matPool[key].mat[#array] + array[#array]
			end
		else
			printError(string.format("不支持该matStr,查看是否漏配数量或存在其它问题( matStr = %s )", matStr))
		end
	end

	local list = {}

	for _, matInfo in pairs(matPool) do
		local matStr = matInfo.mat[1] .. ""

		for i = 2, #matInfo.mat do
			matStr = matStr .. ":" .. matInfo.mat[i]
		end

		list[matInfo.index] = matStr
	end

	return list
end

function MaterialMgr.filterMatStrList(matStrList, filterMatStr)
	local mList = {}
	local mfList = {}
	local length = 0
	local filterMat = string.split(filterMatStr, ":")

	for _, matStr in ipairs(matStrList) do
		local mat = string.split(matStr, ":")

		length = #mat >= 3 and #mat - 1 or #mat

		local isSame = true

		for i = 1, length do
			if string.nilorempty(filterMat[i]) then
				-- block empty
			elseif mat[i] ~= filterMat[i] then
				isSame = false

				break
			end
		end

		if isSame then
			table.insert(mfList, matStr)
		else
			table.insert(mList, matStr)
		end
	end

	return mList, mfList
end

function MaterialMgr.openGetSourceByStr(cfgStr, jumpCallBack)
	if string.nilorempty(cfgStr) then
		return
	else
		local arr = string.split(cfgStr, ":")

		MaterialMgr.openGetSource(arr[1], arr[2], jumpCallBack)
	end
end

function MaterialMgr.openGetSource(matType, id, jumpCallBack)
	matType = checknumber(matType)
	id = checknumber(id)

	local data = {
		type = matType,
		id = id
	}

	MaterialMgr.openGetSourceByData(data, jumpCallBack)
end

function MaterialMgr.openGetSourceByData(data, jumpCallBack)
	local cfg = MaterialMgr.getMatCfg(data.type, data.id)

	if cfg and not string.nilorempty(cfg.source) then
		if data.type == MatType.PetPiece or data.type == MatType.Pet then
			UIStateManager.instance:push(ViewName.PetSource, data.id, jumpCallBack)
		else
			UIStateManager.instance:push(ViewName.ItemSource, data, false, jumpCallBack)
		end
	else
		FloatWordMgr.instance:show(lang("暂无物品或精灵来源"))
	end
end

function MaterialMgr.setCellByGId(matType, gid, parent, urlOrGo, luaCls)
	local data = MaterialMgr.getModel(matType, gid)

	return MaterialMgr.setCellByData(matType, data, parent, urlOrGo, luaCls)
end

function MaterialMgr.setCellByMo(mo, parent, urlOrGo, luaCls)
	local matType = MaterialMgr.getMoType(mo)

	return MaterialMgr.setCellByData(matType, mo, parent, urlOrGo, luaCls)
end

function MaterialMgr.setCellByData(matType, data, parent, urlOrGo, luaCls)
	if data then
		local defineId = data:getDefineId()
		local proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls)

		proxy.binder:setData(data)

		return proxy
	else
		MaterialMgr.resetAll(parent)
		print(" 不存在的物品。理论上不应该调用 ")
	end

	return nil
end

function MaterialMgr.setCellListByCfg(cfgStr, parent, urlOrGo, luaCls, isOne)
	MaterialMgr.resetAll(parent)

	local arr = MaterialMgr.changeItemStrArr(cfgStr)
	local proxyArr = {}

	for i, v in ipairs(arr) do
		local p = MaterialMgr.setCellByCfg(v, parent, urlOrGo, luaCls, false)

		table.insert(proxyArr, p)
	end

	return proxyArr
end

function MaterialMgr.setCellByCfg(cfgStr, parent, urlOrGo, luaCls, isOne)
	local proxy

	if string.nilorempty(cfgStr) then
		return nil
	end

	local arr = string.split(cfgStr, ":")
	local matType = checknumber(arr[1])
	local defineId = checknumber(arr[2])

	matType, defineId = MaterialMgr.changeIfDropByTypeAndId(matType, defineId)

	if matType == MatType.Pet then
		local lvl = checknumber(arr[3])
		local num = checknumber(arr[4])

		proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls, isOne)

		if proxy then
			proxy.binder:setLvl(lvl)
		end
	elseif matType == MatType.Equipment or matType == MatType.MOCK_EQUIPMENT then
		if arr then
			if not #arr then
				local count = 0
				local num = checknumber(arr[count])
				local lv = 1
				local zs

				if count > 3 then
					lv = checknumber(arr[3])
				end

				if count > 4 then
					zs = checknumber(arr[4])
				end

				proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls, isOne)

				if proxy then
					proxy.binder:setLvl(lv)
					proxy.binder:setNum(num)

					if checknumber(zs) > 0 then
						proxy.binder:setExclIcon(zs)
					end
				end
			end
		end
	elseif matType == MatType.Rune then
		local lvl = checknumber(arr[3])
		local num = checknumber(arr[4])

		proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls, isOne)

		if proxy then
			proxy.binder:setLvl(lvl)
			proxy.binder:setNum(num)
		end
	elseif matType == MatType.CutePet then
		local lvl = checknumber(arr[3])
		local quality = checknumber(arr[4])
		local num = checknumber(arr[5])

		proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls, isOne)

		if proxy then
			proxy.binder:setLvl(lvl)
			proxy.binder:setQuality(quality)
			proxy.binder:setNum(num)
		end
	elseif matType == MatType.ExpirableItem then
		local day = checknumber(arr[3])
		local num = checknumber(arr[4])

		proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls, isOne)

		if proxy then
			proxy.binder:setDayLeft(day)
			proxy.binder:setNum(num)
		end
	elseif matType == MatType.StarGodPlus then
		local raceIdOrNum = checknumber(arr[3])
		local num = checknumber(arr[4])

		proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls, isOne)

		if num > 0 then
			if proxy then
				proxy.binder:setRaceHead(raceIdOrNum)
				proxy.binder:setNum(num)
			end
		elseif proxy then
			proxy.binder:setRaceHead(0)
			proxy.binder:setNum(raceIdOrNum)
		end
	else
		local num = checknumber(arr[3])

		proxy = MaterialMgr.setCell(matType, defineId, parent, urlOrGo, luaCls, isOne)

		if proxy then
			proxy.binder:setNum(num)
		end
	end

	return proxy
end

function MaterialMgr.setCell(matType, cfgId, parent, urlOrGo, luaCls, isOne)
	matType = checknumber(matType)
	cfgId = checknumber(cfgId)

	if (matType == MatType.Rare or matType == MatType.PetSkin_Rare) and not goutil.isNil(parent) then
		local trans = parent.transform
		local scale, _, _ = Framework.TransformUtil.GetLocalScale(trans, 0, 0, 0)

		Framework.TransformUtil.SetLocalScale(trans, scale, scale, scale)
	end

	local skinId = -1

	if matType == MatType.Pet then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(cfgId)

		if cfg then
			skinId = cfgId
			cfgId = cfg.raceId
		end
	end

	matType, cfgId = MaterialMgr.changeIfDropByTypeAndId(matType, cfgId)

	if matType == MatType.Diamond_Consume then
		matType = MatType.Diamond
		cfgId = MatType.Diamond_Binding
	end

	local mo = GotoMgr.curItemMo

	if mo ~= nil and mo.type == matType and mo.id == cfgId then
		print(">>>&&&&&&&&&&&&&&&&&&&&&&&&&&& <color='#00ff00'>找到了物品</color>", mo.type .. ":" .. mo.id)
	end

	if isOne == nil then
		isOne = true
	end

	local mgr = MaterialMgr.instance

	if luaCls == nil then
		local mo = MaterialModel.instance:getTempMo(matType, cfgId)

		luaCls = mgr:_getCellCls(mo.type, mo.subType)
	end

	local proxy
	local isGameObject = true

	if urlOrGo == nil then
		if parent == nil then
			printError(">>>>>>>>>>>>  MaterialMgr.setCell  ERROR  no gameObject and no parent ")

			return nil
		end

		local mo = MaterialModel.instance:getTempMo(matType, cfgId)

		urlOrGo = mgr:_getPath(mo.type, mo.subType)
		isGameObject = false
	elseif type(urlOrGo) == "string" then
		isGameObject = false
	elseif urlOrGo then
		proxy = MaterialMgr.getProxy(urlOrGo)

		if proxy ~= nil and proxy.luaCls.__cname ~= luaCls.__cname then
			proxy:removeLua()

			proxy = nil
		end
	else
		isGameObject = false
	end

	if luaCls then
		proxy = MaterialMgr._changeCell(parent, urlOrGo, luaCls, isOne)

		if proxy then
			proxy:initCfg(matType, cfgId)

			if matType == MatType.Pet and skinId > 0 then
				proxy.binder:setSkin(skinId)
			end
		end
	end

	return proxy
end

function MaterialMgr._changeCell(parent, urlOrGo, luaCls, isOne)
	if urlOrGo == nil or luaCls == nil then
		if enableDebug then
			error("MaterialMgr _changeCell  urlOrGo:" .. urlOrGo .. "luaCls:" .. luaCls)
		else
			printWarn("MaterialMgr _changeCell  urlOrGo:", urlOrGo, "luaCls:", luaCls)
		end
	end

	local proxy

	if type(urlOrGo) == "string" then
		local isExit = false

		if isOne == true then
			local arr = MaterialMgr.getAllProxy(parent)

			if arr then
				for i, p in ipairs(arr) do
					if p.luaCls.__cname == luaCls.__cname then
						isExit = true
						proxy = p

						break
					else
						MaterialMgr.resetPorxy(p)
					end
				end
			end
		end

		if isExit == false and proxy == nil and urlOrGo ~= nil then
			proxy = MaterialMgr._getProxyInPool(urlOrGo, luaCls)

			GameUtil.SetActive(proxy.view, true)
			proxy:addChildToParent(parent)
		end
	elseif proxy == nil and urlOrGo ~= nil then
		proxy = MaterialMgr._getProxyInPool(urlOrGo, luaCls)

		GameUtil.SetActive(proxy.view, true)
	end

	return proxy
end

function MaterialMgr._getProxyInPool(urlOrGo, luaCls)
	local proxy
	local key = luaCls.__cname

	if type(urlOrGo) == "string" and MaterialMgr.PROXY_POOL[key] ~= nil and #MaterialMgr.PROXY_POOL[key] > 0 then
		proxy = table.remove(MaterialMgr.PROXY_POOL[key], #MaterialMgr.PROXY_POOL[key])
	end

	MaterialMgr.PROXY_TIMES[key] = 0

	if proxy == nil then
		proxy = MaterialProxy.New(luaCls)

		proxy:loadView(urlOrGo)
	end

	return proxy
end

function MaterialMgr.getProxy(view)
	if view ~= nil then
		local obj = view.gameObject
		local flag = GameUtil.GetLua(obj, MaterialFlag)

		if flag ~= nil then
			return flag.proxy
		end
	end

	return nil
end

function MaterialMgr:lateUpdate()
	return
end

function MaterialMgr:loadPrefab(url, callBack)
	local loader = LOADER_LIST[url]

	if loader == nil then
		loader = MaterialViewLoader.New()
		LOADER_LIST[url] = loader
	end

	loader:loadAsset(url, callBack)

	return loader
end

function MaterialMgr.getAllProxy(parent)
	local arr

	if parent ~= nil then
		local trs = parent.transform

		if trs ~= nil and trs.childCount > 0 then
			local count = trs.childCount

			for i = count, 1, -1 do
				local child = trs:GetChild(i - 1)
				local proxy = MaterialMgr.getProxy(child)

				arr = arr or {}

				table.insert(arr, proxy)
			end
		end
	end

	return arr
end

function MaterialMgr.resetAll(parent)
	if parent ~= nil then
		local trs = parent.transform

		if trs ~= nil and trs.childCount > 0 then
			local count = trs.childCount

			for i = count, 1, -1 do
				local child = trs:GetChild(i - 1)

				MaterialMgr.tryReset(child)
			end
		end
	end
end

function MaterialMgr.tryReset(view)
	if view ~= nil then
		local go = view.gameObject
		local flag = GameUtil.GetLua(go, MaterialFlag)

		if flag ~= nil then
			MaterialMgr.resetPorxy(flag.proxy)
		end
	end
end

function MaterialMgr.resetPorxy(proxy)
	local go = proxy.view
	local mgr = MaterialMgr.instance

	go.transform:SetParent(mgr._root)
	go:SetActive(false)

	local trans = go:GetComponent(goutil.Type_RectTransform)

	trans.anchorMin = Vector2.New(0.5, 0.5)
	trans.anchorMax = Vector2.New(0.5, 0.5)
	trans.pivot = Vector2.New(0, 1)

	goutil.setWidth(trans, 0)
	goutil.setHeight(trans, 0)
	Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(go.transform, 0, 0, 0)

	local key = proxy.luaCls.__cname
	local isAddToPool = proxy.isAddToPool

	proxy:dispose()
	proxy.binder:SetGray(false)

	if isAddToPool then
		MaterialMgr._addToPool(key, proxy)
	end
end

function MaterialMgr._addToPool(key, proxy)
	MaterialMgr.PROXY_POOL[key] = MaterialMgr.PROXY_POOL[key] or {}

	table.insert(MaterialMgr.PROXY_POOL[key], proxy)

	MaterialMgr.PROXY_TIMES[key] = 0
end

function MaterialMgr.getProxyWithOutPool(url, luaCls, parent)
	local proxy
	local arr = MaterialMgr.getAllProxy(parent)

	if arr then
		for i, p in ipairs(arr) do
			if p.luaCls.__cname == luaCls.__cname then
				proxy = p

				break
			end
		end
	end

	if proxy == nil then
		proxy = MaterialProxy.New(luaCls)

		proxy:loadView(url)
		proxy:addChildToParent(parent)

		proxy.isAddToPool = false
	end

	return proxy
end

function MaterialMgr.createSerName(...)
	local parms = {
		...
	}

	return table.concat(parms, ":")
end

function MaterialMgr.getMaterialsNameByCfg(cfgStr)
	if string.nilorempty(cfgStr) then
		return ""
	end

	local type, id, num = MaterialMgr.getMatParams(cfgStr)

	return MaterialMgr.getMaterialsName(type, id)
end

function MaterialMgr.getMaterialsName(matType, cfgId)
	if matType == MatType.Diamond_Consume then
		matType = MatType.Diamond
		cfgId = MatType.Diamond_Binding
	end

	local cfg = MaterialMgr.getMatCfg(matType, cfgId)

	if cfg then
		if matType == MatType.Title then
			return cfg.titleName
		elseif matType == MatType.PetPiece then
			return cfg.name .. lang("碎片")
		elseif matType == MatType.PET_SKIN then
			return cfg.skinName
		elseif matType == MatType.ZooEgg then
			return cfg.eggName
		elseif matType == MatType.Bubble then
			return cfg.bubbleName
		elseif matType == MatType.HIRE_PET then
			return cfg.creepsName
		elseif matType == MatType.EmojiPack then
			return cfg.groupName
		else
			return cfg.name
		end
	end

	return ""
end

function MaterialMgr.combineStrs(...)
	local params = {
		...
	}
	local list = MaterialMgr.combineItemsToList(params)

	return table.concat(list, "#")
end

function MaterialMgr.combineStrsToLists(...)
	local params = {
		...
	}

	return (MaterialMgr.combineItemsToList(params))
end

function MaterialMgr.combineItemsToList(itemStingList)
	local pool = {}
	local keyList = {}

	for i, cfgStr in ipairs(itemStingList) do
		local list = MaterialMgr.changeItemStrArr(cfgStr)

		for j, itemCfg in ipairs(list) do
			local arr = string.split(itemCfg, ":")
			local matType = checknumber(arr[1])
			local cfgId = checknumber(arr[2])
			local arrLen = #arr
			local len = math.max(3, arrLen)
			local num = checknumber(arr[len])

			if arrLen >= 3 then
				table.remove(arr, arrLen)
			end

			local key = table.concat(arr, ":")

			if not pool[key] then
				table.insert(keyList, key)
			end

			pool[key] = pool[key] or {
				cfg = itemCfg
			}
			pool[key].num = checknumber(pool[key].num) + num
		end
	end

	local list = {}

	for i, key in ipairs(keyList) do
		local v = pool[key]
		local arr = string.split(v.cfg, ":")
		local len = math.max(3, #arr)

		arr[len] = v.num

		local tem = table.concat(arr, ":")

		table.insert(list, tem)
	end

	return list
end

function MaterialMgr.getMatCfgByStr(cfgStr)
	local arr = string.split(cfgStr, ":")
	local matType = arr[1]
	local cfgId = arr[2]

	return MaterialMgr.getMatCfg(matType, cfgId)
end

function MaterialMgr.getMatCfg(matType, pcfgId)
	matType = checknumber(matType)

	local cfgId = checknumber(pcfgId)

	if matType == MatType.Diamond_Consume then
		matType = MatType.Diamond
		cfgId = MatType.Diamond_Binding
	end

	local cfg, tempCfg

	if matType == MatType.Coin then
		cfg = ItemConfig.instance:getScoreById(cfgId)
	elseif matType == MatType.Strength then
		cfg = ItemConfig.instance:getStrengthById(cfgId)
	elseif matType == MatType.Cloth then
		cfg = DressConfig.instance:getDressCfgById(cfgId)
	elseif matType == MatType.Diamond then
		cfg = ItemConfig.instance:getDiamondById(cfgId)
	elseif matType == MatType.PayDiamond then
		cfg = ItemConfig.instance:getDiamondById(MatType.Diamond_Normal)
	elseif matType == MatType.GodGem then
		if cfgId > 100 then
			cfgId = MatType.GodGem_Binding
		end

		cfg = ItemConfig.instance:getGodGemById(cfgId)
	elseif matType == MatType.Item then
		cfg = ItemConfig.instance:getCfgById(cfgId)
	elseif matType == MatType.PokeBall then
		cfg = BattleConfig.instance:getBattleItem(cfgId)
	elseif matType == MatType.Pack then
		cfg = ItemConfig.instance:getCfgById(cfgId)
	elseif matType == MatType.Pet then
		cfg = CharacterConfig.instance:getPetCo(cfgId)
	elseif matType == MatType.PetPiece then
		cfg = CharacterConfig.instance:getPetCo(cfgId)
	elseif matType == MatType.PET_SKIN then
		cfg = PetSkinConfig.instance:getPetSkinCfg(cfgId)
	elseif matType == MatType.Rare then
		cfg = CharacterConfig.instance:getPetCo(PetSkinConfig.instance:getPetSkinCfg(cfgId).raceId)
	elseif matType == MatType.PetSkin_Rare then
		cfg = PetSkinConfig.instance:getPetSkinCfg(cfgId)
	elseif matType == MatType.Emoji then
		cfg = ChatConfig.instance:getEmojiCfg(cfgId)
	elseif matType == MatType.EmojiPack then
		cfg = ChatConfig.instance:getEmojiGroupCfg(cfgId)
	elseif matType == MatType.Skill then
		cfg = BattleConfig.instance:getSkillCo(cfgId)
	elseif matType == MatType.Item_Fake then
		cfg = ItemConfig.instance:getFakeCfgById(cfgId)
	elseif matType == MatType.Rune then
		cfg = RuneConfig.instance:getRuneCfg(cfgId)
	elseif matType == MatType.Rune_Suit then
		cfg = RuneConfig.instance:getSuitById(cfgId)
	elseif matType == MatType.Decoration then
		cfg = DecorationConfig.instance:GetDecorationCfgById(cfgId)
	elseif matType == MatType.Equipment then
		cfg = EquipmentConfig.instance:GetEquipDefineInfoById(cfgId)
	elseif matType == MatType.MOCK_EQUIPMENT then
		cfg = EquipmentConfig.instance:GetEquipDefineInfoById(cfgId)
	elseif matType == MatType.MOCK_STARGOD then
		cfg = StargodplusConfig.instance:getFillerCfg(cfgId)
	elseif matType == MatType.MOCK_HOLY_STRIPE then
		cfg = HolyStripeConfig.instance:getHolyStripeCfg(cfgId)
	elseif matType == MatType.ZooEgg then
		cfg = ZooConfig.instance:getAnimalById(cfgId)
	elseif matType == MatType.ACTIVITY_ITEM then
		cfg = ItemConfig.instance:getActItemCfgById(cfgId)
	elseif matType == MatType.Title then
		cfg = TitleConfig.instance:getCfgById(cfgId)
	elseif matType == MatType.DROP_ITEM then
		cfg = MaterialConfig.instance:getCfgByDropId(cfgId)
	elseif matType == MatType.Item_Jump then
		cfg = FuncOpenConfig.instance:getJumpCfgById(cfgId)
	elseif matType == MatType.Item_Jump_Right then
		cfg = FuncOpenConfig.instance:getJumpRightCfgById(cfgId)
	elseif matType == MatType.Item_Badge then
		cfg = BadgeConfig.instance:getDefineById(cfgId)
	elseif matType == MatType.HeadIcon then
		cfg = HeadItemConfig.instance:getHeadIconById(cfgId)
	elseif matType == MatType.HeadFrame then
		cfg = HeadItemConfig.instance:getHeadFrameById(cfgId)
	elseif matType == MatType.TimedItem then
		cfg = TimedItemConfig.instance:getTimedItemCfg(cfgId)
	elseif matType == MatType.ExpirableItem then
		cfg = TimedItemConfig.instance:getExpirableItemCfg(cfgId)
	elseif matType == MatType.Bubble then
		cfg = ChatConfig.instance:getChatBubbleCfgById(cfgId)
	elseif matType == MatType.Throne then
		cfg = ThroneConfig.instance:getThroneCfg(cfgId)
	elseif matType == MatType.Hoshigami then
		cfg = HoshigamiConfig.instance:getHoshigamiCfg(cfgId)
	elseif matType == MatType.StarGodPlus then
		cfg = StargodplusConfig.instance:getFillerCfg(cfgId)
	elseif matType == MatType.ACTIVITY_ENERGY then
		cfg = EnergyConfig.instance:getEnergyCfg(cfgId)
	elseif matType == MatType.HIRE_PET then
		cfg = PetHireConfig.instance:getHirePetCfgById(cfgId)
	elseif matType == MatType.HolyStripe then
		cfg = HolyStripeConfig.instance:getHolyStripeCfg(cfgId)
	elseif matType == MatType.PetTitle then
		cfg = PetTitleConfig.instance:getPetTitleConfig(cfgId)
	elseif matType == MatType.OpeningEffect then
		cfg = BattleStartAnimConfig.instance:getOpeningEffectCfg(cfgId)
	elseif matType == MatType.HomePageBg then
		cfg = BattleStartAnimConfig.instance:getHomePageBgCfg(cfgId)
	elseif matType == MatType.NameFrame then
		cfg = BattleStartAnimConfig.instance:getNameFrame(cfgId)
	elseif matType == MatType.PlayerMessageSkin then
		cfg = BattleStartAnimConfig.instance:getPlayerMessageSkinCfgById(cfgId)
	elseif matType == MatType.BattleUserInterfaceSkin then
		cfg = BattleStartAnimConfig.instance:getBattleUISkinCfg(cfgId)
	elseif matType == MatType.BattleBackgroundSkin then
		cfg = BattleStartAnimConfig.instance:getBattleBackgroundSkinCfg(cfgId)
	elseif matType == MatType.CutePet then
		cfg = CutePetConfig.instance:getCutePetById(cfgId)
	elseif matType == MatType.BorrowPet then
		cfg = BorrowPetConfig.instance:getBorrowPetItemCfg(cfgId)
	elseif matType == MatType.ImpressionSticker then
		cfg = ImpressionStickersConfig.instance:getSticker(cfgId)
	elseif matType == MatType.ImpressionPoster then
		cfg = ImpressionStickersConfig.instance:getPosterSticker(cfgId)
	elseif enableDebug then
		printError(">>> MaterialMgr.getMatCfg 缺少可以 读取的 的配置文件  " .. matType .. ":" .. tostring(pcfgId))
	else
		printWarn(">>> MaterialMgr.getMatCfg 缺少可以 读取的 的配置文件  " .. matType .. ":" .. tostring(pcfgId))
	end

	if cfg == nil then
		printError(">>> MaterialMgr.getMatCfg 缺少可以 读取的 的配置文件  " .. matType .. ":" .. tostring(pcfgId))
	end

	return cfg
end

function MaterialMgr.getSkillTypeName(skillId, skinId)
	local skillCo = BattleConfig.instance:getSkillCo(skillId, skinId)

	if skillCo then
		local type = GameEnum.SkillNameToType[skillCo.type]

		if type == GameEnum.SkillRaceType.Normal then
			type = GameEnum.SkillNameToTypeExt[skillCo.powerType]
		end

		return ConstString.SkillType[type]
	end

	return ""
end

function MaterialMgr.setSkillByFaceId(skillId, faceId, parent)
	local proxy = MaterialMgr.setCell(MatType.Skill, skillId, parent)

	if proxy then
		proxy.binder:setPetFaceId(faceId)
	end

	return proxy
end

function MaterialMgr.updateItemByStr(iconGo, itemStr, numTxt, iconSuffix)
	itemStr = string.gsub(itemStr, "=", ":")
	itemStr = MaterialMgr.changeIfDrop(itemStr)

	local info = string.split(itemStr, ":")
	local matType = checknumber(info[1])
	local cfgId = checknumber(info[2])

	if numTxt then
		local len = math.max(3, #info)
		local matNum = checknumber(info[len])

		numTxt.text = "" .. matNum
	end

	local cfg = MaterialMgr._getIconChangeCfg(matType, cfgId)

	if cfg then
		local icon = cfg.icon

		if iconSuffix then
			icon = icon .. iconSuffix
		end

		MaterialMgr._setIcon(iconGo, matType, cfgId, icon)
	else
		printError(" >>> MaterialMgr.setIcon 缺少可以 读取的 的配置文件  " .. matType .. ":" .. cfgId .. "[" .. itemStr .. "]")
	end
end

function MaterialMgr.setIcon(iconGo, matType, cfgId, handler, handlerObj)
	local cfg = MaterialMgr._getIconChangeCfg(matType, cfgId)

	if cfg then
		local icon = cfg.icon

		MaterialMgr._setIcon(iconGo, matType, cfgId, icon, handler, handlerObj)
	end
end

function MaterialMgr._getIconChangeCfg(matType, cfgId)
	if matType == MatType.Diamond_Consume then
		matType = MatType.Diamond
		cfgId = MatType.Diamond_Binding
	end

	local cfg

	matType, cfgId = MaterialMgr.changeIfDropByTypeAndId(matType, cfgId)

	if matType == MatType.Pet or matType == MatType.PetPiece or matType == MatType.PET_SKIN then
		cfg = CharacterConfig.instance:getModelCo(checknumber(cfgId))

		if cfg then
			cfg.icon = cfg.headName
		end
	elseif matType == MatType.ZooEgg then
		cfg = MaterialMgr.getMatCfg(matType, cfgId)

		if cfg then
			cfg.icon = cfg.eggIcon
		end
	elseif matType == MatType.HIRE_PET or matType == MatType.BorrowPet then
		cfg = MaterialMgr.getMatCfg(matType, cfgId)

		if cfg then
			local skinId = checknumber(cfg.raceId)

			cfg = CharacterConfig.instance:getModelCo((checknumber(cfg.faceId) > 0 or nil) and checknumber(cfg.faceId))

			if cfg then
				cfg.icon = cfg.headName
			end
		end
	else
		cfg = MaterialMgr.getMatCfg(matType, cfgId)
	end

	if cfg == nil then
		if enableDebug then
			printError(" >>> MaterialMgr.setIcon 缺少可以 读取的 的配置文件  " .. matType .. ":" .. cfgId)
		else
			printWarn(" >>> MaterialMgr.setIcon 缺少可以 读取的 的配置文件  " .. matType .. ":" .. cfgId)
		end
	end

	return cfg
end

function MaterialMgr._setIcon(iconGo, matType, cfgId, iconName, handler, handlerObj)
	if matType == MatType.Pet or matType == MatType.PetPiece or matType == MatType.PET_SKIN then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(iconName), handler, handlerObj)
	elseif matType == MatType.HIRE_PET or matType == MatType.BorrowPet then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(iconName), handler, handlerObj)
	elseif matType == MatType.HeadIcon then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("headicon", iconName), handler, handlerObj)
	elseif matType == MatType.HeadFrame then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("headframe", iconName), handler, handlerObj)
	elseif matType == MatType.Item_Jump then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getJumpIconUrl(iconName), handler, handlerObj)
	elseif matType == MatType.Item_Jump_Right then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("jumpright", iconName), handler, handlerObj)
	elseif matType == MatType.CutePet then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCutePetIconUrl(iconName), handler, handlerObj)
	elseif matType == MatType.Cloth then
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getDressIconUrl(iconName), handler, handlerObj)
	elseif matType == MatType.EmojiPack then
		local groupCfg = ChatConfig.instance:getEmojiGroupCfg(cfgId)

		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl(groupCfg.groupPrefix, groupCfg.icon), handler, handlerObj)
	elseif matType == MatType.Emoji then
		local emojiCfg = ChatConfig.instance:getEmojiCfg(cfgId)
		local groupCfg = ChatConfig.instance:getEmojiGroupCfg(emojiCfg.groupId)

		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getEmojiUrl(groupCfg.groupPrefix, emojiCfg.icon), handler, handlerObj)
	elseif matType == MatType.Skill then
		local data = MaterialMgr.getMatCfg(matType, cfgId)

		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(data and data.skillImg), handler, handlerObj)
	elseif matType == MatType.BattleUserInterfaceSkin or matType == MatType.BattleBackgroundSkin then
		local matCfg = MaterialMgr.getMatCfg(matType, cfgId)

		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon2), handler, handlerObj)
	elseif matType == MatType.OpeningEffect or matType == MatType.HomePageBg or matType == MatType.NameFrame or matType == MatType.PlayerMessageSkin or matType == MatType.BattleUserInterfaceSkin or matType == MatType.BattleBackgroundSkin then
		local matCfg = MaterialMgr.getMatCfg(matType, cfgId)

		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon2), handler, handlerObj)
	else
		uGuiUtil.setSpriteToImage(iconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(iconName), handler, handlerObj)
	end
end

function MaterialMgr.clearIcon(iconGo)
	if iconGo then
		local go = iconGo.gameObject

		if go then
			uGuiUtil.clearImage(go)
		end
	end
end

MaterialMgr.ICON_TYPE_ICON = 1
MaterialMgr.ICON_TYPE_MATID = 2
MaterialMgr.ICON_TYPE_CFGID = 3

function MaterialMgr.getContentMatCfg(matType, id, size, ofy, iconType)
	return MaterialMgr.getContentMatStr(matType .. ":" .. id, size, ofy, iconType)
end

function MaterialMgr.getContentMatStr(itemStr, size, ofy, iconType)
	size = size or 110
	ofy = ofy or 0

	local type, id = MaterialMgr.getMatParams(itemStr)

	if type == MatType.Diamond_Consume then
		itemStr = MatType.Diamond .. ":" .. MatType.Diamond_Binding
	end

	local width = 1

	if iconType == true or iconType == MaterialMgr.ICON_TYPE_ICON then
		itemStr = itemStr .. "|icon"
	elseif iconType == MaterialMgr.ICON_TYPE_MATID then
		itemStr = itemStr .. "|matId"
	elseif iconType == MaterialMgr.ICON_TYPE_CFGID then
		itemStr = itemStr .. ""
	end

	return string.format("<quad name=%s size=%s width=%s offsetY=%s/>", itemStr, size, width, ofy)
end

function MaterialMgr.findGraphicText(container, path)
	local txt = goutil.findChildComponent(container, path, "UIGraphicTextNew")

	if goutil.isNil(txt) then
		return nil
	end

	txt:SetLuaCallBack(function(go, des, size)
		MaterialMgr.resetAll(go)

		local img = go:GetComponent(goutil.Type_UIImage)

		if img ~= nil then
			img.enabled = false
		end

		GameUtil.setLocalScale(go, 1, 1, 1)

		local isIcon = false
		local isMatId = false
		local arr = string.split(des, "|")

		des = arr[1]

		if #arr > 1 then
			isIcon = arr[2] == "icon"
			isMatId = arr[2] == "matId"
		end

		if isIcon then
			if img ~= nil then
				img.enabled = true
			end

			local matType, cfgId = MaterialMgr.getMatParams(des)

			MaterialMgr.setIcon(go, matType, cfgId)
		elseif isMatId then
			local aa = checknumber(size.x) / 110

			GameUtil.setLocalScale(go, aa, aa, 1)

			local temp = string.splitToNumber(des, ":")
			local proxy = MaterialMgr.setCellByGId(temp[1], temp[2], go)
			local len = math.max(3, #temp)

			if proxy and temp[len] ~= nil then
				proxy.binder:setNum(checknumber(temp[len]))
			end
		else
			local aa = checknumber(size.x) / 110

			GameUtil.setLocalScale(go, aa, aa, 1)
			MaterialMgr.setCellByCfg(des, go)
		end
	end, nil)

	return txt
end

function MaterialMgr.getGoodsColor(matType, cfgId)
	local color
	local mcfg = MaterialMgr.getMatCfg(matType, cfgId)

	if mcfg then
		if matType == MatType.Rune then
			if not mcfg.quality then
				color = GameUtil.GetGoodsColor(mcfg.quality - 1)
			end
		else
			color = matType == MatType.Equipment and GameUtil.GetGoodsColor(mcfg.qualityBase or 0) or matType == MatType.MOCK_EQUIPMENT and GameUtil.GetGoodsColor(mcfg.qualityBase or 0) or matType == MatType.Pet and GameUtil.GetGoodsColor(mcfg.rare) or GameUtil.GetGoodsColor(mcfg.quality or 0)
		end
	end

	return color
end

function MaterialMgr.getGoodsQuality(matType, cfgId)
	local mcfg = MaterialMgr.getMatCfg(matType, cfgId)

	return (mcfg or nil) and (matType == MatType.Rune and mcfg.quality - 1 or matType == MatType.Equipment and mcfg.qualityBase or matType == MatType.MOCK_EQUIPMENT and mcfg.qualityBase or mcfg.quality) or 0
end

MaterialMgr.SkinPrizeCheckTypes = {
	[MatType.PET_SKIN] = true,
	[MatType.HeadIcon] = false,
	[MatType.HeadFrame] = false
}

function MaterialMgr.isWithInSkinPrize(matType, matId)
	if matType == nil or matId == nil then
		return false
	end

	local result = false
	local queue = {}
	local root = {
		matType = matType,
		matId = matId
	}

	table.insert(queue, root)

	while #queue > 0 do
		local node = table.remove(queue, #queue)
		local matData = MaterialMgr.getMatCfg(node.matType, node.matId)

		if matData and not string.nilorempty(matData.rewardPreview) then
			local viewRewards = MaterialMgr.changeItemStrArr(matData.rewardPreview) or {}

			for _, v in ipairs(viewRewards) do
				local mType, mId, mNum = MaterialMgr.getMatParams(v)

				table.insert(queue, {
					matType = mType,
					matId = mId
				})
			end
		elseif MaterialMgr.SkinPrizeCheckTypes[node.matType] then
			result = true

			local num = MaterialModel.instance:getMaterialsNumber(node.matType, node.matId)

			if num <= 0 then
				result = false

				break
			end
		end
	end

	return result
end

MaterialMgr.instance = MaterialMgr.New()

return MaterialMgr
