-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeeladdressbookView.lua

module("logic.extensions.goodfeel.view.GoodfeeladdressbookView", package.seeall)

local GoodfeeladdressbookView = class("GoodfeeladdressbookView", TableViewComponent)

GoodfeeladdressbookView.OnlyShowLowLevetPet = "OnlyShowLowLevetPet"
GoodfeeladdressbookView.SortType = {
	Lv = 1,
	Rare = 2
}

function GoodfeeladdressbookView:ctor()
	GoodfeeladdressbookView.super.ctor(self)

	self._lowLevel = 20
end

function GoodfeeladdressbookView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function GoodfeeladdressbookView:buildUI()
	GoodfeeladdressbookView.super.buildUI(self)

	self._petNumText = goutil.findChildTextComponent(self.mainGO, "petNumText")
	self._leftTimeText = goutil.findChildTextComponent(self.mainGO, "leftTimeText")
	self._btnSort = self:getBtn("btnSort")
	self._btnFilter = self:getBtn("btnFilter")
	self._sortRoot = self:getGo("sortRoot")
	self._sortByRareBtn = self:getBtn("sortRoot/Cell1")
	self._sortByLvBtn = self:getBtn("sortRoot/Cell2")
	self._sortByRareChange = self:getGo("sortRoot/Cell1/ImgSort"):GetComponent(ComponentType.UIImageSpriteChange)
	self._sortByLvChange = self:getGo("sortRoot/Cell2/ImgSort"):GetComponent(ComponentType.UIImageSpriteChange)
	self._sortArrow = self:getGo("btnSort/arrow")
	self._customInput = UICustomInput.Get(self._sortRoot)
	self._btnOnlyShowAttrPet = self:getBtn("btnOnlyShowAttrPet")
	self._goSelectGo = self:getGo("btnOnlyShowAttrPet/goSelect")
	self._btnOnlyShowLowLevelPet = self:getBtn("btnOnlyShowLowLevelPet")
	self._goSelectOnlyShowLowLevel = self:getGo("btnOnlyShowLowLevelPet/goSelect")
	self._btnOnekey = self:getBtn("btnOnekey")
end

function GoodfeeladdressbookView:bindEvents()
	GoodfeeladdressbookView.super.bindEvents(self)
	self._btnFilter:AddClickListener(self._onClickOpenFilterView, self)
	self._btnSort:AddClickListener(self._onClickOpenSortView, self)
	self._sortByLvBtn:AddClickListener(self._onClickSortByLv, self)
	self._sortByRareBtn:AddClickListener(self._onClickSortByRare, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnOnlyShowAttrPet:AddClickListener(self._onClickbtnOnlyShowAttrPet, self)
	self._btnOnlyShowLowLevelPet:AddClickListener(self._onClickbtnOnlyShowLowLevelPet, self)
	self._btnOnekey:AddClickListener(self._onClickbtnOnekey, self)
end

function GoodfeeladdressbookView:unbindEvents()
	GoodfeeladdressbookView.super.unbindEvents(self)
	self._btnFilter:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._sortByLvBtn:RemoveClickListener()
	self._sortByRareBtn:RemoveClickListener()
	self._customInput:RemoveListener()
	self._btnOnlyShowAttrPet:RemoveClickListener()
	self._btnOnlyShowLowLevelPet:RemoveClickListener()
	self._btnOnekey:RemoveClickListener()
end

function GoodfeeladdressbookView:destroyUI()
	GoodfeeladdressbookView.super.destroyUI(self)
end

function GoodfeeladdressbookView:onEnter()
	GoodfeeladdressbookView.super.onEnter(self)
	self.addGEvent(self, GoodFeelController.PM_GFGetRaceBookInfoRes, self._updateView, self)
	self.addGEvent(self, GoodFeelingAgent.GFOneKeyGainPrizeRes, self._updateView, self)
	GoodFeelingAgent.instance:sendPM_GFGetRaceBookInfoReq()

	self._onlyShowHasAttrPet = GameUtil.getUserData("OnlyShowAttrPet")
	self._onlyShowLowLevelPet = GameUtil.getUserData(GoodfeeladdressbookView.OnlyShowLowLevetPet)
	self._sortLvUp = false
	self._sortRareUp = false
	self._sortType = GoodfeeladdressbookView.SortType.Lv
	self._sortOpUp = self._sortLvUp

	self:_updateView()
	self:_switchSort(true)
	self:_updateBtnOnlyAttrPetState()
	self:_updateBtnOnlyShowLowLevetPetState()
end

function GoodfeeladdressbookView:onEnterFinished()
	GoodfeeladdressbookView.super.onEnterFinished(self)
end

function GoodfeeladdressbookView:onExit()
	GoodfeeladdressbookView.super.onExit(self)
end

function GoodfeeladdressbookView:onExitFinished()
	GoodfeeladdressbookView.super.onExitFinished(self)
end

function GoodfeeladdressbookView:_getPosAndSizeDelta(go)
	local sizeDelta = {
		go.transform.sizeDelta.x,
		go.transform.sizeDelta.y
	}
	local pos = go.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, sizeDelta
end

function GoodfeeladdressbookView:_onClickOpenSortView()
	self:_switchSort()
end

function GoodfeeladdressbookView:_onClickOpenFilterView()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	local function callback()
		self:_refreshFilterPetList()
	end

	PetFilterMgr.instance:openFilterViewByType(self._viewPresentor, PetFilterMgr.TYPE_GOODFEEL, pos, sizeDelta, callback)
end

function GoodfeeladdressbookView:_refreshFilterPetList()
	self._curViewDatas = {}

	if self._currAllPetDatas then
		for i, v in ipairs(self._currAllPetDatas) do
			if self:_onFilter(v) then
				self._curViewDatas[#self._curViewDatas + 1] = v
			end
		end
	end

	self:reloadData()
end

function GoodfeeladdressbookView:_onFilter(info)
	local petCo = CharacterConfig.instance:getPetCo(info.raceId)
	local ismatch = PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_GOODFEEL, petCo, petCo.rare)

	if ismatch and self._onlyShowHasAttrPet then
		local detailCfg = HandbookConfig.instance:getPetDetailsCfgById(info.raceId)
		local cfgs = GoodFeelConfig.instance:getLvPropCfgs(detailCfg.propertyPlan)

		ismatch = cfgs and table.nums(cfgs) > 0
	end

	if ismatch and self._onlyShowLowLevelPet then
		local lv = GoodFeelModel.instance:getPetGoodFeelLv(info.raceId, info.goodFeelingExp)

		ismatch = lv < self._lowLevel
	end

	return ismatch
end

function GoodfeeladdressbookView:_updateCell(view, cell, data)
	local item = GameUtil.AddLuaOnce(cell.gameObject, GoodfeeladdressbookItem)

	item:onEnter(data)
end

function GoodfeeladdressbookView:_clearTableview(cell)
	return
end

function GoodfeeladdressbookView:_updateView()
	self:_switchRankType(self._sortType, self._sortOpUp)

	self._petNumText.text = "通讯名单：" .. GoodFeelModel.instance:getPetCount()
	self._leftTimeText.text = "今日可互动次数：" .. GoodFeelModel.instance:getTodayInteractLeftCount()
end

function GoodfeeladdressbookView:_switchRankType(type, sortOpUp)
	self._sortType = type
	self._sortOpUp = sortOpUp

	local oriList = GoodFeelModel.instance:getInfoLists()
	local rareList = {}

	for i, v in ipairs(oriList) do
		local cfg = CharacterConfig.instance:getPetCo(v.raceId)

		rareList[v.raceId] = cfg.rare
	end

	local compare = sortOpUp and -1 or 1

	if type == GoodfeeladdressbookView.SortType.Lv then
		table.sort(oriList, function(a, b)
			if a.goodFeelingExp == b.goodFeelingExp then
				if rareList[a.raceId] == rareList[b.raceId] then
					return a.raceId * compare > b.raceId * compare
				else
					return rareList[a.raceId] * compare > rareList[b.raceId] * compare
				end
			else
				return a.goodFeelingExp * compare > b.goodFeelingExp * compare
			end
		end)
	elseif type == GoodfeeladdressbookView.SortType.Rare then
		table.sort(oriList, function(a, b)
			if rareList[a.raceId] == rareList[b.raceId] then
				if a.goodFeelingExp == b.goodFeelingExp then
					return a.raceId * compare > b.raceId * compare
				else
					return a.goodFeelingExp * compare > b.goodFeelingExp * compare
				end
			else
				return rareList[a.raceId] * compare > rareList[b.raceId] * compare
			end
		end)
	end

	self._lastType = type

	self:_changeSortBtnState()

	self._raceIdList = {}

	for i, v in ipairs(oriList) do
		table.insert(self._raceIdList, v.raceId)
	end

	self._currAllPetDatas = oriList

	self:_refreshFilterPetList()
	GoodFeelModel.instance:setPetShowViewCurrRaceIdList(self._raceIdList)
end

function GoodfeeladdressbookView:_switchSort(forceClose)
	self._sortIsOpen = not self._sortIsOpen

	if forceClose then
		self._sortIsOpen = false
	end

	goutil.setActive(self._sortRoot, self._sortIsOpen)
	GameUtil.setLocalScale(self._sortArrow, 1, self._sortIsOpen and -1 or 1, 1)
	self:_changeSortBtnState()
end

function GoodfeeladdressbookView:_changeSortBtnState()
	local value1 = self._sortType == GoodfeeladdressbookView.SortType.Lv and 1 or 0

	if value1 == 1 and self._sortOpUp then
		value1 = 2
	end

	local value2 = self._sortType == GoodfeeladdressbookView.SortType.Rare and 1 or 0

	if value2 == 1 and self._sortOpUp then
		value2 = 2
	end

	self._sortByLvChange:SetState(value1)
	self._sortByRareChange:SetState(value2)
end

function GoodfeeladdressbookView:_onClickSortByLv()
	self._sortLvUp = not self._sortLvUp

	self:_switchRankType(GoodfeeladdressbookView.SortType.Lv, self._sortLvUp)
end

function GoodfeeladdressbookView:_onClickSortByRare()
	self._sortRareUp = not self._sortRareUp

	self:_switchRankType(GoodfeeladdressbookView.SortType.Rare, self._sortRareUp)
end

function GoodfeeladdressbookView:_onCustomInputCallback(hover)
	if not hover then
		self:_switchSort(true)
	end
end

function GoodfeeladdressbookView:_onClickbtnOnlyShowAttrPet()
	self._onlyShowHasAttrPet = not self._onlyShowHasAttrPet

	GameUtil.saveUserData("OnlyShowAttrPet", self._onlyShowHasAttrPet)
	self:_updateBtnOnlyAttrPetState()
	self:_updateView()
end

function GoodfeeladdressbookView:_updateBtnOnlyAttrPetState()
	goutil.setActive(self._goSelectGo, self._onlyShowHasAttrPet)
end

function GoodfeeladdressbookView:_onClickbtnOnlyShowLowLevelPet()
	self._onlyShowLowLevelPet = not self._onlyShowLowLevelPet

	GameUtil.saveUserData(GoodfeeladdressbookView.OnlyShowLowLevetPet, self._onlyShowLowLevelPet)
	self:_updateBtnOnlyShowLowLevetPetState()
	self:_updateView()
end

function GoodfeeladdressbookView:_updateBtnOnlyShowLowLevetPetState()
	goutil.setActive(self._goSelectOnlyShowLowLevel, self._onlyShowLowLevelPet)
end

function GoodfeeladdressbookView:_onClickbtnOnekey()
	local list = GoodFeelModel.instance:getInfoLists() or {}
	local dot = false

	for i, v in ipairs(list) do
		dot = GoodFeelModel.instance:checkCanGainLvReward(v.raceId)

		if dot then
			break
		end
	end

	if dot then
		GoodFeelingAgent.instance:sendPM_GFOneKeyGainPrizeReq()
	else
		FloatWordMgr.instance:show("暂无可领取奖励")
	end
end

return GoodfeeladdressbookView
