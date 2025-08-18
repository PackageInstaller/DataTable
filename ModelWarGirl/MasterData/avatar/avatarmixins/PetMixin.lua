-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\PetMixin.lua

local ResPet = require("ClientData/ResPet")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local ResPetGem = require("ClientData/ResPetGem")
local Pet = require("Common/Object/Pet")
local PetAmulet = require("Common/Object/PetAmulet")
local PetGem = require("Common/Object/PetGem")
local ResPetMisc = require("ClientData/ResPetMisc")
local ResPetStar = require("ClientData/ResPetStar")
local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local ResCrystalMisc = require("ClientData/ResCrystalMisc")
local ResBagMisc = require("ClientData/ResBagMisc")
local ResPetRune = require("ClientData/ResPetRune")
local ResPetGashaponConfig = require("ClientData/ResPetGashaponConfig")
local ResPetGashaponDrawUp = require("ClientData/ResPetGashaponDrawUp")
local ResPetGashaponDrawLib = require("ClientData/ResPetGashaponDrawLib")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local ResContentAvalid = require("ClientData/ResContentAvalid")
local ResRandClient = require("ClientData/ResRandClient")
local ResPetGem = require("ClientData/ResPetGem")
local ResPetPossessAttr = require("ClientData/ResPetPossessAttr")
local ResPetGifted = require("ClientData/ResPetGifted")
local ResPetGemAttrLibrary = require("ClientData/ResPetGemAttrLibrary")
local ResPetGashaponItemNew = require("ClientData/ResPetGashaponItemNew")
local UserData = require("Helper/UserData")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local EventConst = require("EventConst")
local PetMixin = {}

function PetMixin:initBasePetMixin(baseData)
	self.petDic = {}
	self.petGemSwitchLevel = 0
	self.petGemWashLevel = 0

	for k, v in pairs(ResPetGem) do
		if v.rerandom_cost_item_id and v.rerandom_cost_item_num and (self.petGemSwitchLevel == 0 or v.level < self.petGemSwitchLevel) then
			self.petGemSwitchLevel = v.level
		end

		if v.gem_cleanup_item and v.cleanup_cost_item_num and (self.petGemWashLevel == 0 or v.level < self.petGemWashLevel) then
			self.petGemWashLevel = v.level
		end
	end
end

function PetMixin:initPetMixin(baseData, syncData)
	self.petList = {}
	self.petDic = {}
	self.petAmuletList = {}
	self.petAmuletDic = {}
	self.petGemList = {}
	self.petGemDic = {}
	self.petGemMainAttrCache = nil
	self.petGemSubAttrCache = nil

	if Const.OPEN_PET_SYSTEM then
		self:initPetDegreeData(syncData.other_bag.pet.pet_degree)
		self:initPetAmuletData(syncData.other_bag.pet.pet_amulet)
		self:initPetGemData(syncData.other_bag.pet.pet_gem)
		self:initPetData(syncData.other_bag.pet.pet)
		self:initPetRuneData(syncData.other_bag.pet.pet_common_rune, syncData.other_bag.pet.pet_exclusive_rune)

		self.petGemMainAttrCache = syncData.other_bag.pet.main_attr_cache
		self.petGemSubAttrCache = syncData.other_bag.pet.sub_attr_cache

		self:initAmuletAdditionalData()

		self.commonAmuletTipsFuncItem = UIControls.TipsConfig()

		self.commonAmuletTipsFuncItem:addConfig(self, Lang.get(1602), self.onTakeOffAmulet, nil, self.onAmuletTakeOffCheck, 1)
		self.commonAmuletTipsFuncItem:addConfig(self, Lang.get(1189), self.onReplaceAmulet, nil, self.onAmuletReplaceCheck, 2)
		self.commonAmuletTipsFuncItem:addConfig(self, Lang.get(1202), self.onUpStarAmulet, nil, self.onUpStarAmuletCheck, 3)

		if Const.PET_SECOND_SECTION_OPEN then
			self:initPetGemAdditionalData()

			self.commonGemTipsFuncItem = UIControls.TipsConfig()

			self.commonGemTipsFuncItem:addConfig(self, Lang.get(1602), self.onTakeOffGem, nil, self.onGemTakeOffCheck, 1)
			self.commonGemTipsFuncItem:addConfig(self, Lang.get(1189), self.onReplaceGem, nil, self.onGemReplaceCheck, 2)
			self.commonGemTipsFuncItem:addConfig(self, Lang.get(983), self.onLevelUpGem, nil, self.onLevelUpGemCheck, 3)
		end

		if ResBagMisc[Const.BAG_TYPE_ID[Const.BAG_TYPE_PET_GEM]] then
			self.bagSize[Const.BAG_TYPE_PET_GEM] = ResBagMisc[Const.BAG_TYPE_ID[Const.BAG_TYPE_PET_GEM]].bag_max_slot
		else
			self.bagSize[Const.BAG_TYPE_PET_GEM] = 200
		end

		self.petMazeData = syncData.other.pet_maze

		if Const.PET_POOL_OPEN then
			local haveNum = self:getItemNumById(ResPetGashaponDraw[1].cost_item)

			self:refreshPetDrawRedHint(0, haveNum)
		end

		self:initPossessData(syncData.other_bag.pet.possess)

		self.newGashaponItemSeenList = self:loadGashaponItemNewFlag()
	end
end

function PetMixin:postinitPetMixin(baseData, syncData)
	if Const.OPEN_PET_SYSTEM then
		self:checkPetCanLevelUpRedHint()
		self:checkCanStarUpInPetsRedHint()
		self:checkAllPetWearAmuletRedHint()
		self:checkAllAmuletStarUpRedHint()
		self:checkWearingAmuletStarUpRedHint()
		self:checkRecycleRedHint()

		if self:petGemSystemEnable() then
			self:checkAllPetWearGemRedHint()
			self:checkAllGemLvUpRedHint()
		end

		if self:petRuneSystemEnable() then
			self:checkPetRuneRedHint()
			self:registerPetRuneItemChanged()
		end

		self:registerItemChangedCallBack(ResPetMisc[1].degree_item_id, Slot(self.refreshUIAndRedHint, self))

		if Const.PET_POOL_OPEN then
			self:registerItemChangedCallBack(ResPetGashaponDraw[1].cost_item, Slot(self.refreshPetDrawRedHint, self))
		end

		self:registerAmuletTransItemChanged()
		self:registerPetTransItemChanged()
		self:initPetPossessRed()
	end
end

function PetMixin:petSystemEnable()
	return Const.OPEN_PET_SYSTEM and not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_PET_SYSYTEM)
end

function PetMixin:petGemSystemEnable()
	return Const.PET_SECOND_SECTION_OPEN and (not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_PET_GEM_SYSYTEM) or self:getPetGemCount() > 0)
end

function PetMixin:petRuneSystemEnable()
	return Const.PET_RUNE_OPEN and (not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_PET_RUNE_SYSYTEM) or self:checkGetExclusiveRuneItem())
end

function PetMixin:initAmuletAdditionalData()
	for _, pet in pairs(self.petDic) do
		if pet.amuletFight and self.petAmuletDic[pet.amuletFight] then
			self.petAmuletDic[pet.amuletFight].inWearing = pet.id
			self.petAmuletDic[pet.amuletFight].pos = 1
		end

		if pet.amuletHelpFight and self.petAmuletDic[pet.amuletHelpFight] then
			self.petAmuletDic[pet.amuletHelpFight].inWearing = pet.id
			self.petAmuletDic[pet.amuletHelpFight].pos = 2
		end
	end
end

function PetMixin:initPetGemAdditionalData()
	for _, pet in pairs(self.petDic) do
		for i, gem in pairs(pet.gem or {}) do
			if gem.gid and self.petGemDic[gem.gid] then
				self.petGemDic[gem.gid].inWearing = pet.id
			end
		end
	end
end

function PetMixin:initPetDegreeData(petDegreeData)
	self.petDegreeLevel = petDegreeData.level
end

function PetMixin:initPetData(petData)
	self:addNewPet(petData)
end

function PetMixin:initPetAmuletData(amuletData)
	self:addNewPetAmulet(amuletData)
end

function PetMixin:initPetGemData(gemData)
	self:addNewPetGem(gemData)
end

function PetMixin:initPetRuneData(normalRune, exclusiveRune)
	self.normalRuneDic = {}

	for i, v in ipairs(normalRune or {}) do
		self.normalRuneDic[v.resid] = {
			id = v.resid
		}
	end

	self.exclusiveRuneDic = {}

	for i, v in ipairs(exclusiveRune or {}) do
		self.exclusiveRuneDic[v.resid] = {
			id = v.resid,
			hero_gid = v.hero_gid
		}

		self:addLowLevelNode(v.resid)
	end
end

function PetMixin:addLowLevelNode(resid)
	if resid and ResPetRune[resid] and ResPetRune[resid].pre_node then
		local preResId = ResPetRune[resid].pre_node[1]

		self.exclusiveRuneDic[preResId] = {
			id = preResId
		}

		self:addLowLevelNode(preResId)
	end
end

function PetMixin:isPetRuneValid(nodeId)
	local runeData

	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and v.node_id == nodeId then
			runeData = v

			break
		end
	end

	if runeData then
		local itemId = runeData.cost_item
		local vData = ResContentAvalid[itemId]

		if vData and vData.availd_Time then
			return ClientUtils.getServerTimeByTimeStr(vData.availd_Time) <= ClientUtils.getServerTime()
		else
			for _, pet in pairs(ResPet) do
				local randId = pet.starup_reward1

				if randId then
					local petItemID = ResRandClient[randId].show_ids[1]

					if petItemID and petItemID == itemId then
						local vData = ResContentAvalid[pet.id]

						if vData and vData.availd_Time then
							return ClientUtils.getServerTimeByTimeStr(vData.availd_Time) <= ClientUtils.getServerTime()
						end

						break
					end
				end
			end
		end
	end

	return true
end

function PetMixin:addNewPet(petData, getType)
	for _, svrData in ipairs(petData or {}) do
		if ResPet[svrData.resid] then
			local tempPet = Pet(svrData)

			self.petDic[tempPet.id] = tempPet

			if getType then
				self:checkPetPossessRed()
				self:checkPetPossessReplaceRed()
			end

			table.insert(self.petList, tempPet)
		end
	end
end

function PetMixin:addNewPetAmulet(amuletData, getType)
	for _, svrData in ipairs(amuletData or {}) do
		if not self:IsDefaultSkillAmulet(svrData.resid) and ResPetAmulet[svrData.resid] then
			local tempAmulet = PetAmulet(svrData)

			self.petAmuletDic[tempAmulet.id] = tempAmulet

			table.insert(self.petAmuletList, tempAmulet)
		elseif not self:IsDefaultSkillAmulet(svrData.resid) then
			-- block empty
		end
	end
end

function PetMixin:addNewPetGem(gemData, getType)
	for _, svrData in ipairs(gemData or {}) do
		if ResPetGem[svrData.resid] then
			local tempGem = PetGem(svrData)

			self.petGemDic[tempGem.gid] = tempGem

			local isHave = false

			for i, v in ipairs(self.petGemList) do
				if v.gid == tempGem.gid then
					isHave = true
					v = tempGem

					break
				end
			end

			if not isHave then
				table.insert(self.petGemList, tempGem)
			end
		end
	end
end

function PetMixin:IsDefaultSkillAmulet(resId)
	return resId == ResPetMisc[1].default_amulet_id
end

function PetMixin:getPetByResId(resId)
	for _, pet in pairs(self.petDic) do
		if pet.id == resId then
			return pet
		end
	end
end

function PetMixin:getPetCountByResId(resId)
	local count = 0

	for _, pet in pairs(self.petDic) do
		if pet.id == resId then
			count = count + 1
		end
	end

	return count
end

function PetMixin:getAllSortedPets()
	local petSortedList = {}

	for _, pet in pairs(self.petDic) do
		table.insert(petSortedList, pet)
	end

	table.sort(petSortedList, function(a, b)
		if a.index_priority and b.index_priority and a.index_priority ~= b.index_priority then
			return a.index_priority > b.index_priority
		elseif a.quality ~= b.quality then
			return a.quality > b.quality
		elseif a.star ~= b.star then
			return a.star > b.star
		else
			return a.id > b.id
		end
	end)

	return petSortedList
end

function PetMixin:getAllCanRecyclePetList()
	local recyclePetList = {}

	for i, pet in pairs(self.petDic) do
		if pet:isMaxStar() then
			local transItemNum = self:getItemNumById(pet.translateItemId)

			if transItemNum > 0 then
				local obj = BaseObject.GetObject(pet.translateItemId, transItemNum)

				table.insert(recyclePetList, obj)
			end
		end
	end

	return recyclePetList
end

function PetMixin:getAllCanRecycleAmuletList()
	local recycleAmuletList = {}

	for i, amulet in pairs(self.petAmuletDic) do
		if amulet:isMaxStar() then
			local transItemNum = self:getItemNumById(amulet.translateItemId)

			if transItemNum > 0 then
				local obj = BaseObject.GetObject(amulet.translateItemId, transItemNum)

				table.insert(recycleAmuletList, obj)
			end
		end
	end

	return recycleAmuletList
end

function PetMixin:getAllCanWearAmuletList(pos)
	local amuletList = {}

	for i, amulet in pairs(self.petAmuletDic) do
		if amulet.inWearing == nil then
			if pos and pos == 2 then
				if amulet:checkCanWearedInAssist() then
					table.insert(amuletList, amulet)
				end
			else
				table.insert(amuletList, amulet)
			end
		end
	end

	return amuletList
end

function PetMixin:getAllCanWearPetGemList()
	local gemList = {}

	for i, gem in pairs(self.petGemDic) do
		if gem.inWearing == nil then
			table.insert(gemList, gem)
		end
	end

	return gemList
end

function PetMixin:getAllPetGemList()
	local gemList = {}

	for i, gem in pairs(self.petGemDic) do
		table.insert(gemList, gem)
	end

	return gemList
end

function PetMixin:getAllCanLvUpPetGemList()
	local gemList = {}

	for i, gem in pairs(self.petGemDic) do
		if not gem:isMaxLevel() then
			table.insert(gemList, gem)
		end
	end

	return gemList
end

function PetMixin:getPetGemCount()
	local count = 0

	for k, v in pairs(self.petGemDic) do
		count = count + 1
	end

	return count
end

function PetMixin:getFastLvUpGemList()
	local gemListbyLevel = {}
	local fastGemGroup = {}

	for i, gem in pairs(self.petGemDic) do
		if gem.inWearing == nil and gem.level < Const.PET_GEM_FAST_LV_UP_MAX then
			if gemListbyLevel[gem.level] == nil then
				gemListbyLevel[gem.level] = {}
			end

			table.insert(gemListbyLevel[gem.level], gem)
		end
	end

	for i, gemList in pairs(gemListbyLevel) do
		if #gemList >= 3 then
			local gemGroup = {}

			for i = 1, #gemList do
				table.insert(gemGroup, gemList[i])

				if #gemGroup == 3 then
					table.insert(fastGemGroup, gemGroup)

					gemGroup = {}
				end
			end
		end
	end

	return fastGemGroup
end

function PetMixin:getPetGemMaxLevel()
	local maxLevel = 1

	for i, v in pairs(ResPetGem) do
		if maxLevel < v.level then
			maxLevel = v.level
		end
	end

	return maxLevel
end

function PetMixin:getLvUpGemListByLevel(level)
	local gemList = {}

	for i, gem in pairs(self.petGemDic) do
		if gem.inWearing == nil and gem.level == level then
			table.insert(gemList, gem)
		end
	end

	return gemList
end

function PetMixin:checkShowLvUpAdvanceBtn()
	for i, gem in pairs(self.petGemDic) do
		if gem.inWearing == nil and gem.level >= Const.PET_GEM_FAST_LV_UP_MAX and gem.level < self:getPetGemMaxLevel() then
			return true
		end
	end

	return false
end

function PetMixin:getAllSubAttrListByLevel(level)
	local subAttrList = {}
	local subAttrNum = 0

	for i, gem in pairs(ResPetGem) do
		if gem.level == level then
			subAttrNum = gem.vice_attr_num

			local libId = gem.vice_attr_library

			for i, attr in pairs(ResPetGemAttrLibrary) do
				if attr.library_id == libId then
					table.insert(subAttrList, attr)
				end
			end

			break
		end
	end

	return subAttrList, subAttrNum
end

function PetMixin:getExclusiveRuneList()
	local exclusiveRuneList = {}

	for i, rune in pairs(self.exclusiveRuneDic) do
		table.insert(exclusiveRuneList, rune)
	end

	return exclusiveRuneList
end

function PetMixin:getNormalRuneList()
	local normalRuneList = {}

	for i, rune in pairs(self.normalRuneDic) do
		table.insert(normalRuneList, rune)
	end

	return normalRuneList
end

function PetMixin:registerPetTransItemChanged()
	for _, pet in pairs(ResPet) do
		if pet.translate_item_id then
			self:registerItemChangedCallBack(pet.translate_item_id, Slot(self.refreshPetTransItemRedHint, self))
		end
	end
end

function PetMixin:registerPetRuneItemChanged()
	local registerItemIds = {}

	for _, v in pairs(ResPetRune) do
		if v.cost_item and not registerItemIds[v.cost_item] then
			self:registerItemChangedCallBack(v.cost_item, Slot(self.checkPetRuneRedHint, self))

			registerItemIds[v.cost_item] = true
		end
	end
end

function PetMixin:refreshPetTransItemRedHint()
	self:checkCanStarUpInPetsRedHint()

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshModel()
	end
end

function PetMixin:registerAmuletTransItemChanged()
	for _, amulet in pairs(ResPetAmulet) do
		if amulet.translate_item_id then
			self:registerItemChangedCallBack(amulet.translate_item_id, Slot(self.refreshAmuletTransItemRedHint, self))
		end
	end
end

function PetMixin:refreshAmuletTransItemRedHint()
	self:checkAllAmuletStarUpRedHint()
	self:checkWearingAmuletStarUpRedHint()
end

function PetMixin:refreshUIAndRedHint()
	self:checkPetCanLevelUpRedHint()

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshDegreeUI()
	end
end

function PetMixin:refreshPetDrawRedHint(oldValue, newValue)
	if oldValue and newValue and oldValue < newValue then
		RedDotManager.setKeyState(UIConst.RD_HINT_PET_DRAW, true)
	end

	local petPoolMainDlg = UIManager.tryGetUI("petPoolMainDlg")

	if petPoolMainDlg then
		petPoolMainDlg:refreshDrawUI()
	end
end

function PetMixin:checkCanStarUpInPetsRedHint()
	self.canStarUpPetsDic = {}
	self.canStarUpPetsList = {}

	for i, pet in pairs(self.petDic) do
		if not pet:isMaxStar() then
			local needNum = ResPetStar[pet.star + 1].cost_same_num
			local haveNum = self:getItemNumById(pet.translateItemId)

			if needNum <= haveNum then
				table.insert(self.canStarUpPetsList, pet.id)

				self.canStarUpPetsDic[pet.id] = true
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_STAR_UP, #self.canStarUpPetsList > 0)
end

function PetMixin:checkPetCanLevelUpRedHint()
	if Const.OPEN_PET_SYSTEM then
		if self.petDegreeLevel and self.petDegreeLevel < #ResPetDegreeLevel then
			local degreeItemId = ResPetMisc[1].degree_item_id
			local haveNum = self:getItemNumById(degreeItemId)
			local degreeLevel = self.petDegreeLevel > 0 and self.petDegreeLevel or 1
			local needNum = ResPetDegreeLevel[degreeLevel + 1].degree

			if needNum <= haveNum then
				local unlockCrystalLevel = ResPetDegreeLevel[self.petDegreeLevel + 1].unlock_crystal_level

				if self:isCrystalSecondPartNew() then
					local nowLevel = ResCrystalMisc[1].maxLevel + self.crystalNewLevel

					RedDotManager.setKeyState(UIConst.RD_HINT_PET_LEVEL_UP, unlockCrystalLevel <= nowLevel)
				else
					RedDotManager.setKeyState(UIConst.RD_HINT_PET_LEVEL_UP, unlockCrystalLevel <= self.crystalData.level)
				end
			else
				RedDotManager.setKeyState(UIConst.RD_HINT_PET_LEVEL_UP, false)
			end
		else
			RedDotManager.setKeyState(UIConst.RD_HINT_PET_LEVEL_UP, false)
		end
	end
end

function PetMixin:checkAllPetWearAmuletRedHint()
	self.canWearAmuletPetsDic = {}
	self.canWearAmuletPetsList = {}

	for i, pet in pairs(self.petDic) do
		if pet:checkCanWearAmulet() then
			self.canWearAmuletPetsDic[pet.id] = true

			table.insert(self.canWearAmuletPetsList, pet.id)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_WEAR_AMULET, #self.canWearAmuletPetsList > 0)
end

function PetMixin:checkAllAmuletStarUpRedHint()
	self.canStarUpAmuletsDic = {}
	self.canStarUpAmuletsList = {}

	for i, amulet in pairs(self.petAmuletDic) do
		if amulet:checkCanStarUp() then
			self.canStarUpAmuletsDic[amulet.id] = true

			table.insert(self.canStarUpAmuletsList, amulet.id)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_AMULET_STAR_UP, #self.canStarUpAmuletsList > 0)
end

function PetMixin:checkWearingAmuletStarUpRedHint()
	self.canStarUpWearingAmuletPetDic = {}
	self.canStarUpWearingAmuletPetList = {}

	for i, pet in pairs(self.petDic) do
		if pet:checkMainAmuletCanStarUp() or pet:checkAssistAmuletCanStarUp() then
			self.canStarUpWearingAmuletPetDic[pet.id] = true

			table.insert(self.canStarUpWearingAmuletPetList, pet.id)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_WEAR_AMULET_STAR_UP, #self.canStarUpWearingAmuletPetList > 0)
end

function PetMixin:checkRecycleRedHint()
	local recyclePetList = self:getAllCanRecyclePetList()
	local recycleAmuletList = self:getAllCanRecycleAmuletList()

	if #recyclePetList > 0 or #recycleAmuletList > 0 then
		RedDotManager.setKeyState(UIConst.RD_HINT_PET_AMULET_RECYCLE, true)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_PET_AMULET_RECYCLE, false)
	end
end

function PetMixin:checkAllGemLvUpRedHint()
	self.canLvUpGemsDic = {}
	self.canLvUpGemsList = {}

	for i, gem in pairs(self.petGemDic) do
		if gem:checkGemCanLevelUp() then
			self.canLvUpGemsDic[gem.gid] = true

			table.insert(self.canLvUpGemsList, gem.gid)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_GEM_UP, #self.canLvUpGemsList > 0)
end

function PetMixin:checkAllPetWearGemRedHint()
	self.canWearGemPetsDic = {}
	self.canWearGemPetsList = {}

	for i, pet in pairs(self.petDic) do
		if pet:checkCanWearGem() or pet:checkCanWearHigherLvGem() then
			self.canWearGemPetsDic[pet.id] = true

			table.insert(self.canWearGemPetsList, pet.id)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_WEAR_GEM, #self.canWearGemPetsList > 0)
end

function PetMixin:checkIsHasGemNotWearing()
	for i, v in pairs(self.petGemDic) do
		if v.inWearing == nil then
			return true
		end
	end

	return false
end

function PetMixin:checkGetExclusiveRuneItem()
	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and (v.cost_item and self:getItemNumById(v.cost_item) > 0 or self.exclusiveRuneDic[v.id] ~= nil) then
			return true
		end
	end

	return false
end

function PetMixin:checkPetRuneRedHint()
	RedDotManager.setKeyState(UIConst.RD_HINT_PET_RUNE, false)

	if self:checkNormalRuneRedHint() or self:checkExclusiveRuneRedHint() then
		RedDotManager.setKeyState(UIConst.RD_HINT_PET_RUNE, true)
	end
end

function PetMixin:checkNormalRuneRedHint()
	if not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_PET_RUNE_SYSYTEM) then
		for i, v in pairs(ResPetRune) do
			if v.node_type == Const.PET_RUNE_TYPE_NORMAL and self:checkNormalRuneNodeCanActive(v) then
				local costItemId = v.cost_item
				local costNum = v.cost_num
				local haveNum = self:getItemNumById(costItemId)

				if costNum <= haveNum then
					return true
				end
			end
		end
	end

	return false
end

function PetMixin:checkExclusiveRuneRedHint()
	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE then
			if self.exclusiveRuneDic[v.id] == nil then
				local costItemId = v.cost_item
				local costNum = v.cost_num
				local haveNum = self:getItemNumById(costItemId)

				if costNum <= haveNum then
					return true
				end
			elseif not self:checkExclusiveRuneBindHero(v.node_id) and not self["showExRune" .. v.node_id] then
				return true
			end
		end
	end

	return false
end

function PetMixin:getMaxLevelExclusiveRune(runeData)
	local maxLevel = 1
	local maxLevelRune

	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and v.node_id == runeData.node_id and maxLevel < v.level then
			maxLevel = v.level
			maxLevelRune = v
		end
	end

	return maxLevelRune
end

function PetMixin:checkNormalRuneNodeCanActive(runeData)
	if runeData then
		local maxActiveNum = math.floor(self.petDegreeLevel / Const.PET_RUNE_DEGREE_LIMIT_NUM)
		local count = 0

		for _, v in pairs(self.normalRuneDic) do
			count = count + 1
		end

		if maxActiveNum <= count then
			return false
		end

		for i, nodeId in ipairs(runeData.pre_node or {}) do
			if not self.normalRuneDic[nodeId] then
				return false
			end
		end

		if runeData.unlock_level and count < runeData.unlock_level then
			return false
		end
	end

	return true
end

function PetMixin:checkExclusiveRuneCanActiveByNodeId(nodeId)
	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and v.node_id == nodeId and self.exclusiveRuneDic[v.id] == nil then
			local costItemId = v.cost_item
			local costNum = v.cost_num
			local haveNum = self:getItemNumById(costItemId)

			if costNum <= haveNum then
				return true
			end
		end
	end

	return false
end

function PetMixin:checkExclusiveRuneBindHero(nodeId)
	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and v.node_id == nodeId and self.exclusiveRuneDic[v.id] and self.exclusiveRuneDic[v.id].hero_gid and self.heroDic[self.exclusiveRuneDic[v.id].hero_gid] then
			return true
		end
	end

	return false
end

function PetMixin:checkHeroBindByOtherRune(heroGid, runeId)
	local num = 0

	for i, v in pairs(self.exclusiveRuneDic) do
		if v.hero_gid and self.heroDic[v.hero_gid] and self.heroDic[heroGid] and v.id ~= runeId and ResPetRune[v.id].node_id ~= ResPetRune[runeId].node_id then
			local hero1 = self.heroDic[v.hero_gid]
			local hero2 = self.heroDic[heroGid]

			if hero1.id == hero2.id then
				num = num + 1
			end
		end
	end

	return num >= 2
end

function PetMixin:checkPetPoolCanReset()
	local limitLibId = ResPetGashaponDraw[1].limit_lib

	for i, v in pairs(ResPetGashaponDrawLib[limitLibId] or {}) do
		local isHave = false

		for _, record in pairs(self.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
			if record.gashapon_id and v.gashapon_id == record.gashapon_id then
				isHave = true

				if v.limit and record.drawed_num < v.limit then
					return false
				end
			end
		end

		if not isHave then
			return false
		end
	end

	for actId, v in pairs(ResPetGashaponDrawUp) do
		local actObj = self:getActivityObj(actId)

		if actObj and actObj:isValid() then
			for _, v in pairs(ResPetGashaponDrawLib[actObj.actData.replaceLibId] or {}) do
				local isHave = false

				for _, record in pairs(actObj.actData.drawData.drawRecord or {}) do
					if record.gashapon_id and v.gashapon_id == record.gashapon_id then
						isHave = true

						if v.limit and record.drawed_num < v.limit then
							return false
						end
					end
				end

				if not isHave then
					return false
				end
			end
		end
	end

	return true
end

function PetMixin:autoAddGem()
	local petGemLvUpDlg = UIManager.tryGetUI("petGemLvUpDlg")

	if petGemLvUpDlg then
		petGemLvUpDlg:autoAddGem()
	end
end

function PetMixin:onAmuletTakeOffCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function PetMixin:onTakeOffAmulet(grid)
	local posStr = Const.PET_AMULET_POS_TYPE[grid.object.pos]
	local petId = grid.object.inWearing

	RPC.petAmuletSet(Const.PET_AMULET_TYPE_OFF, posStr, petId, grid.object.id)
end

function PetMixin:onAmuletReplaceCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function PetMixin:onReplaceAmulet(grid)
	UIManager.getUI("petAmuletWearDlg", true):setData(grid.object)
end

function PetMixin:onUpStarAmuletCheck(grid)
	local obj = grid.object

	if obj:isMaxStar() then
		return false
	else
		return true
	end
end

function PetMixin:onUpStarAmulet(grid)
	local obj = grid.object

	if obj:isMaxStar() then
		MsgManager.notice(Lang.get(73040))

		return
	end

	UIManager.getUI("petAmuletStarUpDlg", true):setData(grid.object)
end

function PetMixin:onGemTakeOffCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function PetMixin:onTakeOffGem(grid)
	local petId = grid.object.inWearing

	RPC.petGemInset(Const.PET_GEM_TYPE_OFF, petId, 0, grid.object.gid)
end

function PetMixin:onGemReplaceCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function PetMixin:onReplaceGem(grid)
	UIManager.getUI("petGemWearDlg", true):setData(grid.object)
end

function PetMixin:onLevelUpGemCheck(grid)
	local obj = grid.object

	if not obj:isMaxLevel() and obj:checkGemCanLevelUp() then
		return true
	end

	return false
end

function PetMixin:onLevelUpGem(grid)
	local obj = grid.object

	if obj:isMaxLevel() then
		MsgManager.notice(Lang.get(76078))

		return
	end

	UIManager.getUI("petGemLvUpDlg", true):setData(grid.object)
end

function PetMixin:onPetItemGetNotify(type, pet, pet_amulet, pet_gem, change_list, reason)
	if type == Const.PET_ITEM_TYPE_PET then
		if pet and #pet > 0 then
			self:addNewPet(pet, true)
		end

		if reason ~= Const.PET_ITEM_REASOM_NONE then
			if change_list and #change_list > 0 then
				if change_list[1].dst_num > 1 or change_list[1].dst_num == 1 and pet and #pet > 0 then
					local items = {}

					for i, v in ipairs(pet or {}) do
						local item = {
							num = 1,
							id = v.resid
						}

						table.insert(items, item)
					end

					for i, v in ipairs(change_list) do
						local item = {
							id = v.src_id,
							num = v.src_num,
							transId = v.dst_id,
							transNum = v.dst_num
						}

						table.insert(items, item)
					end

					self:onGetBonusNotice("petShowAwardDlg", "onShow", {
						items
					})
				else
					local items = {}

					for i, v in ipairs(change_list) do
						local item = {
							id = v.src_id,
							num = v.src_num,
							transId = v.dst_id,
							transNum = v.dst_num
						}

						table.insert(items, item)
					end

					UIManager.getUI("getNewPetDlg", true):setData(self.petDic[change_list[1].src_id], items)
				end
			elseif pet and #pet == 1 then
				UIManager.getUI("getNewPetDlg", true):setData(self.petDic[pet[1].resid])
			elseif pet and #pet > 1 then
				local items = {}

				for i, v in ipairs(pet or {}) do
					local item = {
						num = 1,
						id = v.resid
					}

					table.insert(items, item)
				end

				self:onGetBonusNotice("petShowAwardDlg", "onShow", {
					items
				})
			end
		end
	elseif type == Const.PET_ITEM_TYPE_AMULET then
		local items = {}

		if pet_amulet and #pet_amulet > 0 then
			self:addNewPetAmulet(pet_amulet, true)

			for i, v in ipairs(pet_amulet or {}) do
				local item = {
					num = 1,
					id = v.resid
				}

				table.insert(items, item)
			end
		end

		for i, v in ipairs(change_list) do
			local item = {
				id = v.src_id,
				num = v.src_num,
				transId = v.dst_id,
				transNum = v.dst_num
			}

			table.insert(items, item)
		end

		if reason ~= Const.PET_ITEM_REASOM_NONE then
			self:onGetBonusNotice("petShowAwardDlg", "onShow", {
				items
			})
		end
	elseif type == Const.PET_ITEM_TYPE_GEM then
		local items = {}

		if pet_gem and #pet_gem > 0 then
			self:addNewPetGem(pet_gem, true)

			for i, v in ipairs(pet_gem or {}) do
				local item = {
					num = 1,
					id = v.resid,
					mainAttr = v.main_attr
				}

				table.insert(items, item)
			end
		end

		if reason ~= Const.PET_ITEM_REASOM_NONE then
			self:onGetBonusNotice("petShowAwardDlg", "onShow", {
				items
			})
		end
	end

	self:checkCanStarUpInPetsRedHint()
	self:checkAllPetWearAmuletRedHint()
	self:checkAllAmuletStarUpRedHint()
	self:checkWearingAmuletStarUpRedHint()
	self:checkRecycleRedHint()

	if self:petGemSystemEnable() then
		self:checkAllPetWearGemRedHint()
		self:checkAllGemLvUpRedHint()
	end

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshModel()
	end
end

function PetMixin:onPetItemUpdateNotify(type, pet, pet_amulet, pet_gem)
	self:checkAllAmuletStarUpRedHint()
end

function PetMixin:onPetDegreeLevelUpResp(oldLevel, level)
	self.petDegreeLevel = level

	self:checkPetCanLevelUpRedHint()
	self:checkPetRuneRedHint()

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshDegreeUI()
	end

	local petLevelUpDlg = UIManager.getUI("petLevelUpDlg")

	petLevelUpDlg:setData(oldLevel, level)

	local petShowAwardDlg = UIManager.tryGetUI("petShowAwardDlg")
	local getNewPetDlg = UIManager.tryGetUI("getNewPetDlg")

	if not petShowAwardDlg and not getNewPetDlg then
		petLevelUpDlg:setVisible(true)
	end
end

function PetMixin:onPetStarUpResp(id, star, gift_data)
	local pet = CurAvatar:getPetByResId(id)

	pet.star = star

	pet:updateGiftData(gift_data)
	self:checkCanStarUpInPetsRedHint()
	self:checkRecycleRedHint()
	UIManager.getUI("petStarUpDlg", true):setData(id, star)

	local petInfoTips = UIManager.tryGetUI("petInfoTips")

	if petInfoTips then
		petInfoTips:refreshUI()
	end

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshModel(id)
	end

	local bagPetWearDlg = UIManager.tryGetUI("bagPetWearDlg")

	if bagPetWearDlg then
		bagPetWearDlg:onPetChange(id)
	end

	self:refreshPetWearRed()

	local idx = utils.getIndexByValue(self.petPossessIntelligenceRedIgnorePetIdList, pet.id)

	if idx > 0 then
		table.remove(self.petPossessIntelligenceRedIgnorePetIdList, idx)
	end

	local idx = utils.getIndexByValue(self.petPossessGiftRedIgnorePetIdList, pet.id)

	if idx > 0 then
		table.remove(self.petPossessGiftRedIgnorePetIdList, idx)
	end
end

function PetMixin:onPetAmuletSetResp(type, posStr, pet_id, on_amulet_id, off_amulet_id)
	if type == Const.PET_AMULET_TYPE_OFF then
		self:takeOffAmulet(pet_id, off_amulet_id)
	elseif type == Const.PET_AMULET_TYPE_WEAR then
		if off_amulet_id then
			self:takeOffAmulet(pet_id, off_amulet_id)
		end

		self:wearAmulet(pet_id, on_amulet_id, posStr)
	end

	self:checkAllPetWearAmuletRedHint()
	self:checkWearingAmuletStarUpRedHint()

	local petAmuletWearDlg = UIManager.tryGetUI("petAmuletWearDlg")

	if petAmuletWearDlg then
		petAmuletWearDlg:setVisible(false)
	end

	local petInfoTips = UIManager.tryGetUI("petInfoTips")

	if petInfoTips then
		petInfoTips:refreshUI()
	end

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshModel()
	end

	local petAmuletMainDlg = UIManager.tryGetUI("petAmuletMainDlg")

	if petAmuletMainDlg then
		petAmuletMainDlg:refreshData()
	end

	local bagPetWearDlg = UIManager.tryGetUI("bagPetWearDlg")

	if bagPetWearDlg then
		bagPetWearDlg:onPetChange(pet_id)
	end

	self:refreshPetWearRed()

	local ui = ClientUtils.getNowDragDlg()

	if ui and ui.refreshPetPart then
		ui:refreshPetPart()
	end
end

function PetMixin:onPetAmuletStarUpResp(id, star)
	if self.petAmuletDic[id] then
		self.petAmuletDic[id].star = star
	end

	self:checkAllAmuletStarUpRedHint()
	self:checkWearingAmuletStarUpRedHint()
	self:checkRecycleRedHint()

	local petAmuletStarUpDlg = UIManager.tryGetUI("petAmuletStarUpDlg")

	if petAmuletStarUpDlg then
		petAmuletStarUpDlg:playStarUpEfx(self.petAmuletDic[id])
	end

	local petAmuletMainDlg = UIManager.tryGetUI("petAmuletMainDlg")

	if petAmuletMainDlg then
		petAmuletMainDlg:refreshData()
	end

	local petInfoTips = UIManager.tryGetUI("petInfoTips")

	if petInfoTips then
		petInfoTips:refreshInfoUI()
	end

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshModel()
	end

	local bagPetWearDlg = UIManager.tryGetUI("bagPetWearDlg")

	if bagPetWearDlg then
		bagPetWearDlg:onPetChange(self.petAmuletDic[id].inWearing)
	end

	self:refreshPetWearRed()
end

function PetMixin:wearAmulet(pet_id, on_amulet_id, posStr)
	local pos = self:getPetAmuletWearPosNum(posStr)

	if self.petAmuletDic[on_amulet_id] then
		self.petAmuletDic[on_amulet_id].inWearing = pet_id
		self.petAmuletDic[on_amulet_id].pos = pos
	end

	if self.petDic[pet_id] then
		if pos == 1 then
			self.petDic[pet_id].amuletFight = on_amulet_id
		elseif pos == 2 then
			self.petDic[pet_id].amuletHelpFight = on_amulet_id
		end
	end
end

function PetMixin:takeOffAmulet(pet_id, off_amulet_id)
	if self.petAmuletDic[off_amulet_id] then
		self.petAmuletDic[off_amulet_id].inWearing = nil
		self.petAmuletDic[off_amulet_id].pos = nil
	end

	if self.petDic[pet_id] then
		if self.petDic[pet_id].amuletFight == off_amulet_id then
			self.petDic[pet_id].amuletFight = 0
		elseif self.petDic[pet_id].amuletHelpFight == off_amulet_id then
			self.petDic[pet_id].amuletHelpFight = 0
		end
	end
end

function PetMixin:getPetAmuletWearPosNum(posStr)
	for i, str in pairs(Const.PET_AMULET_POS_TYPE) do
		if str == posStr then
			return i
		end
	end

	return 1
end

function PetMixin:onPetGemInsetResp(type, pet_gid, on_gem_gid, off_gem_gid)
	local pet_id = tonumber(pet_gid)

	if type == Const.PET_GEM_TYPE_OFF then
		self:offPetGem(pet_id, off_gem_gid)
	elseif type == Const.PET_GEM_TYPE_WEAR then
		self:wearPetGem(pet_id, on_gem_gid, off_gem_gid)
	end

	self:checkAllPetWearGemRedHint()
	self:checkAllGemLvUpRedHint()

	local petGemWearDlg = UIManager.tryGetUI("petGemWearDlg")

	if petGemWearDlg then
		petGemWearDlg:setVisible(false)
	end

	local refreshDlg = {
		"petGemLvUpDlg",
		"petGemListDlg",
		"petInfoTips"
	}

	for i, uiName in pairs(refreshDlg) do
		local ui = UIManager.tryGetUI(uiName)

		if ui then
			ui:refreshUI()
		end
	end

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshModel()
	end

	local bagPetWearDlg = UIManager.tryGetUI("bagPetWearDlg")

	if bagPetWearDlg then
		bagPetWearDlg:onPetChange(pet_id)
	end

	self:refreshPetWearRed()
end

function PetMixin:wearPetGem(pet_id, on_gem_gid, off_gem_gid)
	if self.petGemDic[on_gem_gid] then
		self.petGemDic[on_gem_gid].inWearing = pet_id
	end

	if self.petDic[pet_id] then
		local isHave = false

		for i, v in ipairs(self.petDic[pet_id].gem or {}) do
			if v.gid == on_gem_gid then
				isHave = true

				break
			end
		end

		if not isHave then
			if off_gem_gid and self.petGemDic[off_gem_gid] then
				self.petGemDic[off_gem_gid].inWearing = nil

				for i, v in ipairs(self.petDic[pet_id].gem or {}) do
					if v.gid == off_gem_gid then
						self.petDic[pet_id].gem[i] = {
							gid = on_gem_gid
						}

						break
					end
				end
			else
				table.insert(self.petDic[pet_id].gem, {
					gid = on_gem_gid
				})
			end
		end
	end
end

function PetMixin:offPetGem(pet_id, off_gem_gid)
	if self.petGemDic[off_gem_gid] then
		self.petGemDic[off_gem_gid].inWearing = nil
	end

	if self.petDic[pet_id] and self.petDic[pet_id].gem then
		for i, v in ipairs(self.petDic[pet_id].gem or {}) do
			if v.gid == off_gem_gid then
				table.remove(self.petDic[pet_id].gem, i)

				break
			end
		end
	end
end

function PetMixin:offAllPetEquip(pet)
	if not pet then
		return
	end

	if self.petAmuletDic[pet.amuletFight] then
		self.petAmuletDic[pet.amuletFight].inWearing = nil
		self.petAmuletDic[pet.amuletFight].pos = nil
		pet.amuletFight = 0
	end

	if self.petAmuletDic[pet.amuletHelpFight] then
		self.petAmuletDic[pet.amuletHelpFight].inWearing = nil
		self.petAmuletDic[pet.amuletHelpFight].pos = nil
		pet.amuletHelpFight = 0
	end

	for i = #pet.gem, 1, -1 do
		local gemGid = pet.gem[i].gid

		if self.petGemDic[gemGid] then
			self.petGemDic[gemGid].inWearing = nil
		end

		table.remove(pet.gem, i)
	end
end

function PetMixin:onPetGemLevelUpResp(add, del_gem_gid)
	for i, gid in ipairs(del_gem_gid or {}) do
		self.petGemDic[gid] = nil
	end

	self:addNewPetGem(add)
	self:initPetGemAdditionalData()
	self:checkAllGemLvUpRedHint()
	self:checkAllPetWearGemRedHint()

	if #add == 1 then
		local ui = UIManager.tryGetUI("petGemLvUpDlg")

		if ui then
			ui:playLvUpAni(self.petGemDic[add[1].gid])
		end
	else
		local items = {}

		for i, v in ipairs(add) do
			local item = {
				num = 1,
				id = v.resid,
				mainAttr = v.main_attr
			}

			table.insert(items, item)
		end

		self:onGetBonusNotice("petShowAwardDlg", "onShow", {
			items
		})

		local petGemLvUpDlg = UIManager.tryGetUI("petGemLvUpDlg")

		if petGemLvUpDlg then
			petGemLvUpDlg:refreshUI()
		end
	end

	local petGemLvUpFastDlg = UIManager.tryGetUI("petGemLvUpFastDlg")

	if petGemLvUpFastDlg then
		petGemLvUpFastDlg:setVisible(false)
	end

	local refreshDlg = {
		"petGemListDlg",
		"petInfoTips",
		"petGemLvUpAdDlg"
	}

	for i, uiName in pairs(refreshDlg) do
		local ui = UIManager.tryGetUI(uiName)

		if ui then
			ui:refreshUI()
		end
	end

	local petMainDlg = UIManager.tryGetUI("petMainDlg")

	if petMainDlg then
		petMainDlg:refreshModel()
	end

	local bagPetWearDlg = UIManager.tryGetUI("bagPetWearDlg")

	if bagPetWearDlg then
		bagPetWearDlg:refreshShow()
	end

	self:refreshPetWearRed()
end

function PetMixin:refreshPetWearRed()
	EventCenter.sendEvent(EventConst.REFRESH_BATTLE_PET_WEAR_RED)
end

function PetMixin:onPetOffWearsResp(petIdList)
	for _, pet in pairs(CurAvatar.petList) do
		if self.petAmuletDic[pet.amuletFight] then
			self.petAmuletDic[pet.amuletFight].inWearing = nil
			self.petAmuletDic[pet.amuletFight].pos = nil
		end

		if self.petAmuletDic[pet.amuletHelpFight] then
			self.petAmuletDic[pet.amuletHelpFight].inWearing = nil
			self.petAmuletDic[pet.amuletHelpFight].pos = nil
		end

		pet.amuletFight = 0
		pet.amuletHelpFight = 0
	end

	for _, pet in pairs(CurAvatar.petList) do
		for i = #pet.gem, 1, -1 do
			local gemGid = pet.gem[i].gid

			if self.petGemDic[gemGid] then
				self.petGemDic[gemGid].inWearing = nil
			end

			table.remove(pet.gem, i)
		end
	end

	local bagPetWearDlg = UIManager.tryGetUI("bagPetWearDlg")

	if bagPetWearDlg then
		bagPetWearDlg:onPetOffWearsResp()
	end

	self:refreshPetWearRed()
end

function PetMixin:onPetRuneUpResp(resid, hero_on)
	if ResPetRune[resid].node_type == Const.PET_RUNE_TYPE_EXCLUSIVE then
		for _, v in pairs(self.exclusiveRuneDic) do
			if v.hero_gid and self.heroDic[v.hero_gid] and ResPetRune[v.id].node_id == ResPetRune[resid].node_id then
				v.hero_gid = "0"
			end
		end

		self.exclusiveRuneDic[resid] = {
			id = resid,
			hero_gid = hero_on
		}
		self["showExRune" .. ResPetRune[resid].node_id] = true
	else
		self.normalRuneDic[resid] = {
			id = resid
		}
	end

	self:checkPetRuneRedHint()

	local petRuneMainDlg = UIManager.tryGetUI("petRuneMainDlg")

	if petRuneMainDlg then
		petRuneMainDlg:refreshUI(resid)
	end
end

function PetMixin:onPetRuneHeroBindResp(resid, hero_on, hero_off)
	for _, v in pairs(self.exclusiveRuneDic) do
		if v.hero_gid and self.heroDic[v.hero_gid] and ResPetRune[v.id].node_id == ResPetRune[resid].node_id then
			v.hero_gid = "0"
		end
	end

	if self.exclusiveRuneDic[resid] then
		self.exclusiveRuneDic[resid].hero_gid = hero_on
	end

	local petRuneMainDlg = UIManager.tryGetUI("petRuneMainDlg")

	if petRuneMainDlg then
		petRuneMainDlg:refreshUI()
	end
end

function PetMixin:onPetDrawSelectResp(gashapon_id, select_item_id)
	local isHave = false

	for i, v in pairs(self.roleDrawData[Const.DrawTypePet].drawSelect or {}) do
		if v.gashapon_id == gashapon_id then
			v.select_item_id = select_item_id
			isHave = true
		end
	end

	if not isHave then
		table.insert(self.roleDrawData[Const.DrawTypePet].drawSelect, {
			gashapon_id = gashapon_id,
			select_item_id = select_item_id
		})
	end

	local petPoolSpeChooseDlg = UIManager.tryGetUI("petPoolSpeChooseDlg")

	if petPoolSpeChooseDlg then
		petPoolSpeChooseDlg:setVisible(false)
	end

	local petPoolMainDlg = UIManager.tryGetUI("petPoolMainDlg")

	if petPoolMainDlg then
		petPoolMainDlg:refreshBallUI()
	end
end

function PetMixin:onPetDrawRestResp()
	for i, record in pairs(self.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
		record.draw_num = 0
	end

	local petPoolMainDlg = UIManager.tryGetUI("petPoolMainDlg")

	if petPoolMainDlg then
		petPoolMainDlg:onPetDrawRestResp()
	end
end

function PetMixin:onPetMazeRoleDataNotify(data)
	self.petMazeData = data

	local petMazeObj = self:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)

	if petMazeObj then
		petMazeObj.actData:initPlayerPetMazeData()
		petMazeObj:checkNew()
	end
end

function PetMixin:onPetRecycleResp()
	self:checkRecycleRedHint()

	local petRecycleDlg = UIManager.tryGetUI("petRecycleDlg")

	if petRecycleDlg then
		petRecycleDlg:refreshData()
	end
end

function PetMixin:checkPetGemSwitchEnterOpen()
	if not Const.PET_GEM_CHANGE_OPEN then
		return false
	end

	for _, gem in pairs(self.petGemDic) do
		if self:checkPetGemCanSwitch(gem) then
			return true
		end
	end

	return false
end

function PetMixin:checkPetGemWashEnterOpen()
	if not Const.PET_GEM_CHANGE_OPEN then
		return false
	end

	for _, gem in pairs(self.petGemDic) do
		if self:checkPetGemCanWash(gem) then
			return true
		end
	end

	return false
end

function PetMixin:checkPetGemCanSwitch(gem)
	if not Const.PET_GEM_CHANGE_OPEN then
		return false
	end

	return gem ~= nil and gem.level >= self.petGemSwitchLevel
end

function PetMixin:checkPetGemCanWash(gem)
	if not Const.PET_GEM_CHANGE_OPEN then
		return false
	end

	return gem ~= nil and gem.level >= self.petGemWashLevel
end

function PetMixin:onPetGemRerandAttributeResp(type, gid, attrs)
	if type == Const.PET_GEM_RERAND_ATTR_TYPE_MAIN then
		local ui = UIManager.getUI("petGemSwitchDlg")

		if ui then
			ui:onPetGemRerandAttributeResp(gid, attrs)
		end
	elseif type == Const.PET_GEM_RERAND_ATTR_TYPE_SUB then
		local ui = UIManager.getUI("petGemWashDlg")

		if ui then
			ui:onPetGemRerandAttributeResp(gid, attrs)
		end
	end
end

function PetMixin:onPetGemSaveAttributeResp(type, gid, attrs)
	local gem = self.petGemDic[gid]

	if not gem then
		return
	end

	if type == Const.PET_GEM_RERAND_ATTR_TYPE_MAIN then
		self.petGemMainAttrCache = nil

		local t = {}

		if attrs and #attrs > 0 then
			table.insert(t, {
				attr_id = attrs[1]
			})
		end

		gem.mainAttr = t
	elseif type == Const.PET_GEM_RERAND_ATTR_TYPE_SUB then
		self.petGemSubAttrCache = nil

		local t = {}

		if attrs and #attrs > 0 then
			for i = 1, #attrs do
				table.insert(t, {
					attr_id = attrs[i]
				})
			end
		end

		gem.subAttr = t
	end

	EventCenter.sendEvent(EventConst.PET_GEM_CHANGE, gid, type)
end

function PetMixin:initPossessData(data)
	self.petPossessDataDic = {}

	if data and data.possess_data then
		for _, data in pairs(data.possess_data) do
			local t = {}

			t.petList = {}

			if data.item then
				for _, tmp in ipairs(data.item) do
					table.insert(t.petList, tmp.resid)
				end
			end

			self.petPossessDataDic[data.career_id] = t
		end
	end
end

function PetMixin:initPetPossessRed()
	self.petPossessIntelligenceRedIgnorePetIdList = {}
	self.petPossessGiftRedIgnorePetIdList = {}
	self.petPossessReplaceRedIgnorePetIdList = {}
end

function PetMixin:checkPetPossessRed()
	local maxPossessNum = self:getTotalMaxPetPossessNum()
	local possessNum = self:getTotalPetPossessNum()
	local checkFreePet = false

	for _, tmpPet in ipairs(self.petList) do
		if not self:getPetPossessInfoByPetId(tmpPet.id) and tmpPet:checkCanPossess() then
			checkFreePet = true
		end
	end

	local checkRed = self:checkPetPossessEnterOpen() and checkFreePet and possessNum < maxPossessNum

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS, checkRed)

	return checkRed
end

function PetMixin:checkPetPossessReplaceRed()
	if RedDotManager.getKeyState(UIConst.RD_HINT_PET_POSSESS) then
		RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_REPLACE, false)

		return false
	end

	local possessNum = self:getTotalPetPossessNum()
	local petNum = #CurAvatar.petList

	if petNum == possessNum then
		RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_REPLACE, false)

		return false
	end

	local checkRed = false

	for careerId, data in pairs(self.petPossessDataDic) do
		if #data.petList > 0 then
			for _, id in pairs(data.petList) do
				local pet = CurAvatar:getPetByResId(id)

				if self:checkPetPossessReplaceRedByPet(careerId, pet) then
					checkRed = true

					break
				end
			end
		end

		if checkRed then
			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_REPLACE, checkRed)

	return checkRed
end

function PetMixin:checkPetPossessReplaceRedByPet(careerId, pet)
	if not careerId or not pet then
		return false
	end

	if RedDotManager.getKeyState(UIConst.RD_HINT_PET_POSSESS) then
		return false
	end

	local possessNum = self:getTotalPetPossessNum()
	local petNum = #CurAvatar.petList

	if petNum == possessNum then
		return false
	end

	if utils.getIndexByValue(self.petPossessReplaceRedIgnorePetIdList, pet.id) > 0 then
		return false
	end

	for _, tmpPet in ipairs(self.petList) do
		if self:checkPetPossessReplaceRedByReplacePet(careerId, pet, tmpPet) then
			return true
		end
	end

	return false
end

function PetMixin:checkPetPossessReplaceRedByReplacePet(careerId, pet, replacePet)
	if not careerId or not pet or not replacePet or pet == replacePet then
		return false
	end

	if RedDotManager.getKeyState(UIConst.RD_HINT_PET_POSSESS) then
		return false
	end

	local possessNum = self:getTotalPetPossessNum()
	local petNum = #CurAvatar.petList

	if petNum == possessNum then
		return false
	end

	if utils.getIndexByValue(self.petPossessReplaceRedIgnorePetIdList, pet.id) > 0 then
		return false
	end

	if not replacePet:checkCanPossess() then
		return false
	end

	local selectCareerId = self:getPetPossessInfoByPetId(replacePet.id)

	if selectCareerId then
		return false
	end

	local propDic = PropHelper.getPetPossessAttr({
		pet
	}, careerId)
	local checkRed = false

	if replacePet.quality > pet.quality then
		local freePetPropDic = PropHelper.getPetPossessAttr({
			replacePet
		}, careerId)
		local checkSmall = false
		local checkBig = false

		for name, prop in pairs(freePetPropDic) do
			if prop < propDic[name] then
				checkSmall = true
			elseif prop > propDic[name] then
				checkBig = true
			end
		end

		if checkBig and not checkSmall then
			checkRed = true
		end
	end

	return checkRed
end

function PetMixin:onClosePetPossessInfoDlg(careerId, pet)
	if self:checkPetPossessReplaceRedByPet(careerId, pet) then
		table.insert(self.petPossessReplaceRedIgnorePetIdList, pet.id)

		local ui = UIManager.getUI("petPossessMainDlg")

		if ui then
			ui:refreshShow()
		end
	end
end

function PetMixin:checkPetPossessIntelligenceRed(pet)
	if utils.getIndexByValue(self.petPossessIntelligenceRedIgnorePetIdList, pet.id) > 0 then
		return false
	end

	local miscConfig = ResPetMisc[1]
	local normalCostId = miscConfig.nor_develop_cost_item
	local normalCostNum = miscConfig.nor_develop_cost_num
	local haveNormalCostNum = CurAvatar:getItemNumById(normalCostId)
	local checkNormalWashEnough = normalCostNum <= haveNormalCostNum

	if not checkNormalWashEnough then
		return false
	end

	local possessAttrConfig = ResPetPossessAttr[pet.quality]

	for index, config in ipairs(possessAttrConfig) do
		local intelligence = pet.intelligenceList[index] or 0
		local intelligenceLimit = config.intelligence_limit[pet.star]

		if intelligenceLimit <= intelligence then
			return false
		end
	end

	return true
end

function PetMixin:onOpenPetPossessIntelligenceDlg(pet)
	table.insert(self.petPossessIntelligenceRedIgnorePetIdList, pet.id)
	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_INTELLIGENCE, false)
end

function PetMixin:checkPetPossessGiftRed(pet)
	if utils.getIndexByValue(self.petPossessGiftRedIgnorePetIdList, pet.id) > 0 then
		return false
	end

	local giftLimit = ResPetStar[pet.star].gifted_limit
	local giftList = pet.giftList
	local miscConfig = ResPetMisc[1]
	local itemNum1 = CurAvatar:getItemNumById(miscConfig.purple_gift_id)
	local itemNum2 = CurAvatar:getItemNumById(miscConfig.orange_gift_id)
	local itemNum3 = CurAvatar:getItemNumById(miscConfig.red_gift_id)

	if giftLimit > #giftList then
		local check = itemNum1 > 0 or itemNum2 > 0 or itemNum3 > 0

		return check
	else
		for _, giftId in ipairs(giftList) do
			local skillLevel = ResPetGifted[giftId] and ResPetGifted[giftId].skill_level or 0

			if skillLevel < 2 then
				if itemNum2 > 0 or itemNum3 > 0 then
					return true
				end
			elseif skillLevel < 3 and itemNum3 > 0 then
				return true
			end
		end
	end

	return false
end

function PetMixin:onOpenPetPossessGiftDlg(pet)
	table.insert(self.petPossessGiftRedIgnorePetIdList, pet.id)
	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_GIFT, false)
end

function PetMixin:checkPetPossessEnterOpen()
	return Const.OPEN_PET_POSSESS and CurAvatar:getTotalMaxPetPossessNum() > 0 and #CurAvatar.petList > 0
end

function PetMixin:getPetPossessDataByCareerId(careerId)
	if self.petPossessDataDic then
		return self.petPossessDataDic[careerId]
	end

	return nil
end

function PetMixin:getTotalPetPossessNum()
	local num = 0

	if self.petPossessDataDic then
		for _, data in pairs(self.petPossessDataDic) do
			num = num + #data.petList
		end
	end

	return num
end

function PetMixin:getPetPossessNum(careerId)
	local data = self:getPetPossessDataByCareerId(careerId)

	return data and #data.petList or 0
end

function PetMixin:getMostPetPossessNum()
	local num = 0

	for i = 1, Const.CAREER_TYPE.ALL - 1 do
		local petPossessNum = CurAvatar:getPetPossessNum(i)

		if num < petPossessNum then
			num = petPossessNum
		end
	end

	return num
end

function PetMixin:getPetPossessInfoByPetId(_petId)
	if _petId and self.petPossessDataDic then
		for careerId, data in pairs(self.petPossessDataDic) do
			for _, id in pairs(data.petList) do
				if id == _petId then
					return careerId
				end
			end
		end
	end

	return nil
end

function PetMixin:getTotalMaxPetPossessNum()
	local level = self.petDegreeLevel

	return ResPetDegreeLevel[level] and ResPetDegreeLevel[level].possess_num or 0
end

function PetMixin:getSingleCareerMaxPetPossessNum()
	local totalNum = self:getTotalMaxPetPossessNum()

	if totalNum <= 0 then
		return 0
	end

	local maxPossessNum = math.ceil(totalNum / (Const.CAREER_TYPE.ALL - 1))
	local minPossessNum = -1

	for i = 1, Const.CAREER_TYPE.ALL - 1 do
		local petPossessNum = CurAvatar:getPetPossessNum(i)

		if minPossessNum == -1 or petPossessNum < minPossessNum then
			minPossessNum = petPossessNum
		end
	end

	return math.min(maxPossessNum, minPossessNum + 1)
end

function PetMixin:checkPetIntelligenceLimit(pet, checkTip)
	local petPossessAttrConfig = ResPetPossessAttr[pet.quality]
	local checkCurStarLimit = true
	local checkMaxStarLimit = true

	for idx, config in pairs(petPossessAttrConfig) do
		local curValue = pet.intelligenceList[idx] or 0
		local curStarLimit = config.intelligence_limit[pet.star]
		local maxStarLimit = config.intelligence_limit[#config.intelligence_limit]

		if curValue < curStarLimit then
			checkCurStarLimit = false
			checkMaxStarLimit = false
		elseif curValue < maxStarLimit then
			checkMaxStarLimit = false
		end

		if not checkCurStarLimit and not checkMaxStarLimit then
			break
		end
	end

	if checkTip then
		if checkMaxStarLimit then
			MsgManager.clientNotice(758)
		elseif checkCurStarLimit then
			MsgManager.clientNotice(757)
		end
	end

	return checkCurStarLimit or checkMaxStarLimit
end

function PetMixin:onPetPossessResp(resid, op_type, careerData, possess_tick)
	local t = {}

	t.petList = {}

	if careerData and careerData.item then
		for _, tmp in ipairs(careerData.item) do
			table.insert(t.petList, tmp.resid)
		end
	end

	self.petPossessDataDic[careerData.career_id] = t

	if op_type == Const.PET_POSSESS_TYPE.On and possess_tick then
		local pet = self:getPetByResId(resid)

		pet:updatePossessData(possess_tick)
	end

	self:checkPetPossessRed()
	self:checkPetPossessReplaceRed()
	EventCenter.sendEvent(EventConst.PET_POSSESS_DATA_CHANGE, careerData.career_id, op_type, resid)
end

function PetMixin:onPetPossessReplaceResp(op_type, src_id, dst_id, src_tick, dst_tick, career_data_list)
	local career_id = 0

	for _, careerData in pairs(career_data_list.possess_data) do
		local t = {}

		t.petList = {}

		if careerData.item then
			for _, tmp in ipairs(careerData.item) do
				table.insert(t.petList, tmp.resid)

				if tmp.resid == dst_id then
					career_id = careerData.career_id
				end
			end
		end

		self.petPossessDataDic[careerData.career_id] = t
	end

	if src_tick then
		local pet = self:getPetByResId(src_id)

		pet:updatePossessData(src_tick)
	end

	if dst_tick then
		local pet = self:getPetByResId(dst_id)

		pet:updatePossessData(dst_tick)
	end

	self:checkPetPossessRed()
	self:checkPetPossessReplaceRed()
	EventCenter.sendEvent(EventConst.PET_POSSESS_DATA_CHANGE, career_id, op_type, src_id)
end

function PetMixin:onPetDevelopIntelligenceResp(pet_id, intelligence_data, develop_type)
	local pet = CurAvatar:getPetByResId(pet_id)

	pet:updateIntelligenceData(intelligence_data)

	local ui = UIManager.getUI("petPossessIntelligenceDlg")

	if ui then
		ui:onPetDevelopIntelligenceResp(pet_id, develop_type)
	end
end

function PetMixin:onPetChooseIntelligenceResp(pet_id, intelligence_data, op_type)
	local pet = CurAvatar:getPetByResId(pet_id)

	pet:updateIntelligenceData(intelligence_data)
	EventCenter.sendEvent(EventConst.PET_INTELLIGENCE_CHANGE, pet_id, op_type)
end

function PetMixin:onPetDevelopGiftResp(pet_id, gift_data, item_id)
	local pet = CurAvatar:getPetByResId(pet_id)

	pet:updateGiftData(gift_data)

	local ui = UIManager.getUI("petPossessGiftDlg")

	if ui then
		ui:onPetDevelopGiftResp(pet_id, item_id)
	end
end

function PetMixin:onPetChooseGiftResp(pet_id, op_type, gift_data)
	local pet = CurAvatar:getPetByResId(pet_id)

	pet:updateGiftData(gift_data)
	EventCenter.sendEvent(EventConst.PET_GIFT_CHANGE, pet_id, op_type)
end

function PetMixin:loadGashaponItemNewFlag()
	local recordStr = UserData.loadCommonData("GashaponItemNew" .. self.uid)
	local seenList = ClientUtils.string2Table(recordStr) or {}

	if #seenList > 0 then
		for i = #seenList, 1, -1 do
			local itemId = seenList[i]

			if not ResPetGashaponItemNew[itemId] then
				table.remove(seenList, i)
			end
		end
	end

	return seenList
end

function PetMixin:saveNewGashaponItemFlag(seenList)
	UserData.saveCommonData("GashaponItemNew" .. self.uid, ClientUtils.table2String(seenList))
end

function PetMixin:seenNewGashaponItem(itemIdList)
	local isAdd = false

	for i, itemId in ipairs(itemIdList) do
		if ResPetGashaponItemNew[itemId] and not utils.tableIsContainsElement(self.newGashaponItemSeenList, itemId) then
			isAdd = true

			table.insert(self.newGashaponItemSeenList, itemId)
		end
	end

	if isAdd then
		self:saveNewGashaponItemFlag(self.newGashaponItemSeenList)
	end
end

function PetMixin:checkGashaponItemNew()
	local newItemDict = {}

	for _, data in pairs(ResPetGashaponConfig) do
		if data.quality == Const.PET_DRAW_QUALITY_SPECIAL_CHOOSE then
			for _, itemId in pairs(data.items or {}) do
				if ResPetGashaponItemNew[itemId] and self:gashaponItemTimeValid(itemId) then
					newItemDict[itemId] = true
				end
			end

			break
		end
	end

	for _, seenId in pairs(self.newGashaponItemSeenList) do
		newItemDict[seenId] = nil
	end

	return next(newItemDict) ~= nil, newItemDict
end

function PetMixin:gashaponItemTimeValid(itemId)
	local itemTimeValidId

	if ResPetGashaponItemNew[itemId] and ResPetGashaponItemNew[itemId].valid_time_id then
		itemTimeValidId = ResPetGashaponItemNew[itemId].valid_time_id
	end

	if itemTimeValidId and not ClientUtils.isTimeConfigPassed(itemTimeValidId) then
		return false
	end

	return true
end

return PetMixin
