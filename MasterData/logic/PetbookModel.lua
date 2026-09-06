-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/model/PetbookModel.lua

module("logic.extensions.handbook.model.PetbookModel", package.seeall)

local PetbookModel = class("PetbookModel", BaseModel)

PetbookModel.MAXPERPAGE = 6
PetbookModel.TAB_PET_RACEID = 1
PetbookModel.TAB_PET_SKINID = 2
PetbookModel.SortTypeIndex = {
	Down = 1,
	Up = 2,
	Default = 0
}

function PetbookModel:ctor()
	PetbookModel.super.ctor(self)
end

function PetbookModel:onInit()
	PetbookModel.super.onInit(self)

	self._childAsAdult = {}
	self._loginFirst = false

	self:onReset()
end

function PetbookModel:onReset()
	PetbookModel.super.onReset(self)

	self._selectedPetId = nil
	self._petIndex = nil
	self._page = nil
	self._pages = nil
	self._ownedNum = nil
	self._loginFirst = false
	self._totalNum = 0
	self._allPetCfgList = nil
	self._allPetSkinCfgList = nil
	self._quality = nil
	self._attr = nil
	self._rare = nil
	self._currSearching = nil
	self._skinIds = {}
	self._activeSkinIds = {}
	self._currSortType = PetbookController.SortType.Default
	self._sortTypeIndex = {}
end

function PetbookModel:setSelectedPet(skinId)
	if self._allPet == nil then
		self:getPetDatas()
	end

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local raceId = skinCfg.raceId
	local selectedPetId = 0

	selectedPetId = self._childAsAdult[raceId] and self._childAsAdult[raceId] or skinId

	local petIndex = 0

	for i = 1, #self._allPet do
		if self._allPet[i].skinId == selectedPetId then
			petIndex = i

			break
		end
	end

	if petIndex > 0 then
		self._petIndex = petIndex
	end

	self._selectedPetId = selectedPetId

	GlobalDispatcher:dispatch(GlobalNotify.HandBookPetSelect)

	return petIndex > 0
end

function PetbookModel:PetBookHave(raceId)
	if self._allPet == nil then
		self:getPetDatas()
	end

	if self._childAsAdult[raceId] then
		raceId = self._childAsAdult[raceId]
	end

	local index = false

	for i = 1, #self._allPet do
		if self._allPet[i].raceId == raceId then
			index = i

			break
		end
	end

	return index
end

function PetbookModel:getSelectedPetId()
	return self._selectedPetId
end

function PetbookModel:getSelectedPetRaceId()
	if self._selectedPetId then
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._selectedPetId)

		if skinCfg then
			return skinCfg.raceId
		end
	end

	return nil
end

function PetbookModel:getSelectedPetIndex()
	return self._petIndex or 1
end

function PetbookModel:getIndexPet(index)
	self._petIndex = index

	return self._allPet[index]
end

function PetbookModel:getPagePet(page, continue)
	if continue == nil then
		continue = 1
	end

	local pets = {}

	for i = (page - 1) * PetbookModel.MAXPERPAGE + 1, page * PetbookModel.MAXPERPAGE * continue do
		if self._allPet[i] then
			table.insert(pets, self._allPet[i])
		else
			break
		end
	end

	return pets
end

function PetbookModel:getPages()
	return self._pages
end

function PetbookModel:getPetNum()
	self:initAllPetData()

	if self._ownedNum then
		return self._ownedNum, self._totalNum
	else
		return 0, 1
	end
end

function PetbookModel:getPetListLen()
	return #self._allPet
end

function PetbookModel:getAllPet()
	return self._allPet
end

function PetbookModel:setPetbookTab(tab)
	self._curSelectTab = tab
end

function PetbookModel:getPetbookTab()
	return self._curSelectTab or PetbookModel.TAB_PET_RACEID
end

function PetbookModel:setSkinQuality(quality)
	self._quality = quality
end

function PetbookModel:setAttrAndRare(attr, rare)
	self._attr = attr
	self._rare = rare
end

function PetbookModel:getAttrAndRare()
	return self._attr, self._rare
end

function PetbookModel:setPage(page)
	self._page = page
end

function PetbookModel:getPage()
	return self._page
end

function PetbookModel:_isPetOnline(cfg, nowTime)
	if not string.nilorempty(cfg.manualOnlineTime) then
		nowTime = nowTime or ServerTime.now()

		local onlineTime = GameUtil.string2time(cfg.manualOnlineTime)

		return onlineTime <= nowTime
	end

	return true
end

function PetbookModel:getPetDatas(attr, rare)
	self:setAttrAndRare(attr, rare)

	self._allPet = self:getFilterPetList()

	for i = 1, #self._allPet do
		self._allPet[i].isHave = HandbookModel.instance:isHasPet(self._allPet[i].raceId) or self:getCanCompose(self._allPet[i])
	end

	self._pages = math.ceil(#self._allPet / PetbookModel.MAXPERPAGE)
end

function PetbookModel:initAllPetData()
	if self._allPetCfgList == nil then
		self._allPetCfgList = {}
		self._allPetSkinCfgList = {}

		local allPet = {}
		local cfgs = CharacterConfig.instance:getPetCfg()

		for _, cfg in ipairs(cfgs) do
			if cfg.raceIdsBeforeEvolve then
				self._childAsAdult[cfg.raceIdsBeforeEvolve] = cfg.raceId
			end

			table.insert(allPet, cfg)
		end

		table.sort(allPet, function(a, b)
			if a.evaluateLevel == b.evaluateLevel then
				return checknumber(a.bookIds) > checknumber(b.bookIds)
			else
				return checknumber(a.evaluateLevel) < checknumber(b.evaluateLevel)
			end
		end)

		self._totalNum = 0
		self._ownedNum = 0

		local skinGroupMap = {}

		for i, cfg in ipairs(allPet) do
			local raceId = cfg.raceId
			local skinList = PetSkinConfig.instance:getPetSkinListBySkinId(raceId)

			for j, v in ipairs(skinList) do
				if v.skinId == raceId then
					table.insert(self._allPetCfgList, v)

					if self:getIsHandBookPet(cfg) then
						self._totalNum = self._totalNum + 1

						if HandbookModel.instance:isHasPet(cfg.raceId) then
							self._ownedNum = self._ownedNum + 1
						end
					end
				elseif v.skinGroup == 0 then
					table.insert(self._allPetSkinCfgList, v)
				elseif v.skinGroup > 0 and not skinGroupMap[v.skinGroup] and v.skinGroup == v.skinId then
					skinGroupMap[v.skinGroup] = true

					table.insert(self._allPetSkinCfgList, v)
				end
			end
		end

		ArraySort.sortOn(self._allPetSkinCfgList, "bookIds", ArraySort.DESCENDING)
	end
end

function PetbookModel:getAllPetList()
	self:initAllPetData()

	return self._allPetCfgList or {}
end

function PetbookModel:getAllPetSkinList()
	self:initAllPetData()

	return self._allPetSkinCfgList or {}
end

function PetbookModel:getFilterPetList(sortType, index)
	sortType = sortType or PetbookController.SortType.Default
	self._allPet = {}

	local nowTime = ServerTime.now()
	local arr = self:getAllPetList()
	local owned = 0

	for i, v in ipairs(arr) do
		local cfg = MaterialMgr.getMatCfg(MatType.Pet, v.raceId)

		if cfg then
			local curRare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, cfg.raceId)
			local attrFlag = not self._attr or PetSkinConfig.instance:checkHasEleAttr(cfg.raceId, self._attr)
			local rareFlag = not self._rare or curRare == self._rare
			local petDetail = HandbookConfig.instance:getPetDetailsCfgById(cfg.raceId)
			local isShow = self:_isShowByShowTime(v.skinId)

			rareFlag = self._rare == 5 and petDetail and petDetail.unproved == 1 or rareFlag and (not petDetail or petDetail.unproved ~= 1)

			if attrFlag and rareFlag and self:_getIsFilter(cfg) and self:_isPetOnline(cfg, nowTime) and isShow then
				table.insert(self._allPet, v)

				if HandbookModel.instance:isHasPet(v.raceId) then
					owned = owned + 1
				end
			end
		end
	end

	if sortType == PetbookController.SortType.Awaken then
		local raceId_awakenLv = {}

		for i, v in ipairs(self._allPet) do
			raceId_awakenLv[v.raceId] = HandbookModel.instance:getAttributeLevel(v.raceId)
		end

		if index == PetbookModel.SortTypeIndex.Down then
			table.sort(self._allPet, function(a, b)
				return raceId_awakenLv[a.raceId] > raceId_awakenLv[b.raceId]
			end)
		elseif index == PetbookModel.SortTypeIndex.Up then
			table.sort(self._allPet, function(a, b)
				return raceId_awakenLv[a.raceId] < raceId_awakenLv[b.raceId]
			end)
		end
	end

	return self._allPet, owned
end

function PetbookModel:getRaceIdListWithPTEliBan()
	local raceIdList = {}
	local petCfg = CharacterConfig.instance:getPetCfg()
	local nowTime = ServerTime.now()

	if petCfg then
		for _, data in ipairs(petCfg) do
			local raceId = data.raceId

			if data.rare >= 4 and checknumber(data.bookIds) > 0 and self:_isPetOnline(data, nowTime) then
				table.insert(raceIdList, raceId)
			end
		end
	end

	return raceIdList
end

function PetbookModel:getFilterSkinList()
	self._allPet = {}

	local nowTime = ServerTime.now()
	local arr = self:getAllPetSkinList()
	local owned = 0

	for i, v in ipairs(arr) do
		local cfg = MaterialMgr.getMatCfg(MatType.Pet, v.raceId)

		if cfg then
			local curRare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, cfg.raceId)
			local attrFlag = not self._attr or PetSkinConfig.instance:checkHasEleAttr(cfg.raceId, self._attr)
			local isShow = self:_isShowByShowTime(v.skinId)

			if v.clientNotShow then
				local coId = checknumber(LoginModel.instance:getCoChannelId())

				for _, v2 in pairs(v.clientNotShow) do
					if coId == v2 then
						isShow = false

						break
					end
				end
			end

			local rareFlag = not self._quality or v.quality == self._quality

			if attrFlag and rareFlag and self:_getIsSkinFilter(cfg, v.skinId) and self:_isPetOnline(cfg, nowTime) and isShow then
				table.insert(self._allPet, v)

				if MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, v.skinId) > 0 then
					owned = owned + 1
				end
			end
		end
	end

	return self._allPet, owned
end

function PetbookModel:getCanCompose(cfg)
	local curPieceNum = MaterialFacade.instance:getMatNumber(MatType.PetPiece, cfg.raceId)
	local needPieceNum = checknumber(cfg.needPieceNum)

	return needPieceNum <= curPieceNum
end

function PetbookModel:_getIsFilter(cfg)
	return not string.nilorempty(cfg.bookIds) and PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PET_FILES, cfg) and self:_searchByStr(cfg)
end

function PetbookModel:getIsHandBookPet(cfg)
	local petDetail = HandbookConfig.instance:getPetDetailsCfgById(cfg.raceId)

	if petDetail and self:_isPetOnline(cfg) then
		return checknumber(cfg.bookIds) > 0 and petDetail.unproved ~= 1
	else
		return false
	end
end

function PetbookModel:setLoginFirst(flag)
	self._loginFirst = flag
end

function PetbookModel:getLoginFirst()
	return self._loginFirst
end

function PetbookModel:setEnterTab(tab)
	self._enterTab = tab
end

function PetbookModel:getEnterTab()
	return self._enterTab
end

function PetbookModel:getSearching()
	return self._currSearching
end

function PetbookModel:setSearching(str)
	self._currSearching = str
end

function PetbookModel:_searchByStr(cfg)
	local petCo = CharacterConfig.instance:getPetCo(cfg.raceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return true
end

function PetbookModel:_getIsSkinFilter(cfg, skinId)
	return not string.nilorempty(cfg.bookIds) and PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PET_FILES, cfg) and (self:_searchByStr(cfg) or self:_searchSkinByStr(skinId))
end

function PetbookModel:_searchSkinByStr(skinId)
	local petCo = MaterialMgr.getMatCfg(MatType.PET_SKIN, skinId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.skinName, str)

		if not count then
			return false
		end
	end

	return true
end

function PetbookModel:setActiveSkinIds(activeSkinIds)
	self._activeSkinIds = activeSkinIds
end

function PetbookModel:setSkinIds(skinIds)
	self._skinIds = skinIds
end

function PetbookModel:getActiveSkinIds()
	return self._activeSkinIds
end

function PetbookModel:getSkinIds()
	return self._skinIds
end

function PetbookModel:skinIsActiveAndState(skinId)
	local isActive = not table.indexof(self._activeSkinIds, skinId)
	local state = table.indexof(self._skinIds, skinId)

	return isActive, state
end

function PetbookModel:getSkinRedPoint()
	return #self._skinIds > #self._activeSkinIds
end

function PetbookModel:getUnActiveSkinIds()
	local list = {}
	local needCheckSkinIdList = {}
	local idMap = {}

	for _, v in ipairs(self._activeSkinIds) do
		idMap[v] = v
	end

	for _, v in ipairs(self._skinIds) do
		if idMap[v] == nil then
			table.insert(needCheckSkinIdList, v)
		end
	end

	local isHas = false

	for _, v in ipairs(needCheckSkinIdList) do
		isHas = false

		local skinData = PetSkinConfig.instance:getPetSkinCfg(v)

		if skinData then
			local skinIdListOfSkinGroup = PetSkinConfig.instance:getPetSkinListBySkinGroup(skinData.skinGroup)
			local skinIdListOfBody = {}
			local cfg = PetSkinConfig.instance:getPetSkinBodyMap(v) or {}

			for bodyType, list in pairs(cfg) do
				for raceId, data in pairs(list) do
					if data.bodyTypeGroupId == skinData.bodyTypeGroupId then
						table.insert(skinIdListOfBody, data.skinId)
					end
				end
			end

			local skinIdMap = {}

			skinIdMap[v] = v

			for _, skinId in ipairs(skinIdListOfSkinGroup) do
				skinIdMap[skinId] = skinId
			end

			for _, skinId in ipairs(skinIdListOfBody) do
				skinIdMap[skinId] = skinId
			end

			local skinIdList = TableUtil.toList(skinIdMap)

			for _, skinId in ipairs(skinIdList) do
				if table.indexof(self._activeSkinIds, skinId) then
					isHas = true

					break
				end
			end

			if not isHas then
				table.insert(list, v)
			end
		elseif enableDebug then
			printError(string.format("皮肤id:%d不存在,请检查配置或重启( config from export_皮肤定义 in j精灵皮肤.xlsx )", v))
		end
	end

	return list
end

function PetbookModel:_isShowByShowTime(skinId)
	local showTimeStr = PetSkinConfig.instance:getSkinShowTime(skinId)

	if not string.nilorempty(showTimeStr) then
		local showTime = GameUtil.string2time(showTimeStr)

		return showTime <= ServerTime.now()
	end

	return true
end

function PetbookModel:setCurrSortType(sortType)
	self._currSortType = sortType
end

function PetbookModel:getCurrSortType()
	return self._currSortType
end

function PetbookModel:getSortTypeIndex(sortType)
	self._sortTypeIndex[sortType] = self._sortTypeIndex[sortType] or PetbookModel.SortTypeIndex.Default

	return self._sortTypeIndex[sortType]
end

function PetbookModel:addSortTypeIndex(sortType, index)
	index = index + 1
	index = index % 3
	self._sortTypeIndex[sortType] = index
end

PetbookModel.instance = PetbookModel.New()

return PetbookModel
