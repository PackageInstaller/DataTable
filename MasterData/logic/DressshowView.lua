-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressshowView.lua

module("logic.extensions.dress.view.DressshowView", package.seeall)

local DressshowView = class("DressshowView", ViewComponent)

function DressshowView:ctor()
	DressshowView.super.ctor(self)
end

local Sortway = {
	"默认排序",
	"获得时间",
	"期限递增",
	"期限递减"
}
local SortwayCute = {
	[1] = "默认排序"
}

function DressshowView:buildUI()
	DressshowView.super.buildUI(self)
	self:buildUIAboutFiters()
	self:buildUIAboutSortType()
	self:buildUIAboutClothType()

	self._goTableSingle = self:getGo("bg/singleScrollView")
	self._goCellSingle = self:getGo("bg/singleCellDress")
	self._tableviewSingle = ScrollerList.create(self._goTableSingle, self._goCellSingle, GameUtil.handler(self._updateSingleCell, self), GameUtil.handler(self._clearSingleCell, self))
	self._goTableSuit = self:getGo("bg/suitScrollView")
	self._goCellSuit = self:getGo("bg/suitCellDress")
	self._tableviewSuit = ScrollerList.create(self._goTableSuit, self._goCellSuit, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))
	self._cuteScrollView = self:getGo("bg/cuteScrollView")
	self._cuteCellDress = self:getGo("bg/cuteCellDress")
	self._tableviewCute = ScrollerList.create(self._cuteScrollView, self._cuteCellDress, GameUtil.handler(self._updateCuteCell, self), GameUtil.handler(self._clearSingleCell, self))
	self._txtOwnNum = self:getTxt("bg/own/txt")
	self._unLockCutePetInfo = self:getGo("unlockCutePet")
	self._unLockCutePetCon = self:getGo("unlockCutePet/txtCost/costIcon")
	self._txtUnLockCutePetCost = self:getTxt("unlockCutePet/txtCost")
	self._txtUnLockCutePetTip = self:getTxt("unlockCutePet/unlockTip/txt")
	self._btnUnLockCutePet = self:getGo("unlockCutePet/btnUnlock")
	self._unLockCutePetRedPoint = self:getGo("unlockCutePet/btnUnlock/redPoint")
	self._fitersGo = self:getGo("bg/fiters")
	self._preset = self:getGo("bg/preset")
	self._btnSure = self:getGo("bg/preset/btnSure")
	self._btnCancel = self:getGo("bg/preset/btnCancel")
	self._txtPresuppose = self:getTxt("bg/preset/txtPresuppose")
	self._tableviewPreset = self:getGo("bg/tableviewPreset")
	self._tablecellPreset = self:getGo("bg/tableviewPreset/tablecellPreset")
	self._scrollListPreset = ScrollerList.create(self._tableviewPreset, self._tablecellPreset, GameUtil.handler(self._updatePresetCell, self), GameUtil.handler(self._clearPresetCell, self))
	self._presetScrollView = self:getGo("bg/presetScrollView")
	self._presetCellDress = self:getGo("bg/presetCellDress")
	self._scrollListPresetDress = ScrollerList.create(self._presetScrollView, self._presetCellDress, GameUtil.handler(self._updatePresetDressCell, self), GameUtil.handler(self._clearPresetDressCell, self))
end

function DressshowView:buildUIAboutFiters()
	self._filters = {}

	for i = 1, 4 do
		local filter = {}

		filter.tog = self:getToggle("bg/fiters/tog" .. i)
		filter.id = i
		filter.mark = self:getGo("bg/fiters/tog" .. i .. "/Background/Checkmark/Image")
		self._filters[i] = filter
	end
end

function DressshowView:buildUIAboutSortType()
	self._changeSort = self:getGo("bg/btnChangeSort")
	self._btnSwitchSort = GameUtil.asBtn(self._changeSort)
	self._sortTypes = goutil.findChild(self._changeSort, "sortTypes")
	self._showSortTxt = goutil.findChildTextComponent(self._changeSort, "Text")

	local btn = goutil.findChild(self._sortTypes, "btn")

	self._sortWays = {}

	for k, v in pairs(Sortway) do
		local copyBtn = {}
		local go = goutil.clone(btn, "btn" .. k)

		copyBtn.go = go
		copyBtn.btn = GameUtil.asBtn(go)
		copyBtn.txt = goutil.findChildTextComponent(go, "Text")
		copyBtn.change = go:GetComponent("UIChangeGroup")
		copyBtn.txt.text = v

		goutil.addChildToParent(go, self._sortTypes)
		goutil.setActive(go, true)

		self._sortWays[k] = copyBtn
	end
end

function DressshowView:buildUIAboutClothType()
	local tabCfgs = DressConfig.instance:getAllTabCfgs()
	local maxTypes = 0

	for k, v in pairs(tabCfgs) do
		if checkint(k) > 0 then
			local num = table.nums(v)

			if maxTypes < num then
				maxTypes = num
			end
		end
	end

	self._changeType = self:getGo("bg/btnChangeType")
	self._btnSwitchType = GameUtil.asBtn(self._changeType)
	self._clothTypes = goutil.findChild(self._changeType, "sortTypes")
	self._showTypeTxt = goutil.findChildTextComponent(self._changeType, "Text")

	local btn = goutil.findChild(self._clothTypes, "btn")

	self._clothTabs = {}

	for i = 1, maxTypes do
		local copyBtn = {}
		local go = goutil.clone(btn, "btn" .. i)

		copyBtn.go = go
		copyBtn.change = go:GetComponent("UIChangeGroup")
		copyBtn.btn = GameUtil.asBtn(go)
		copyBtn.txt = goutil.findChildTextComponent(go, "Text")

		goutil.addChildToParent(go, self._clothTypes)
		goutil.setActive(go, false)

		copyBtn.cfg = nil

		table.insert(self._clothTabs, copyBtn)
	end
end

function DressshowView:bindEvents()
	DressshowView.super.bindEvents(self)

	for k, v in pairs(self._filters) do
		v.tog:AddOnValueChanged(function()
			self:_onFilterValueChanged(v.tog.isOn, v.id)
		end, self)
	end

	for k, v in pairs(self._sortWays) do
		v.btn:AddClickListener(function()
			self:_onSwitchSortWay(k)
		end, self)
	end

	self._btnSwitchSort:AddClickListener(self._onClickSwitchSort, self)

	for i = 1, #self._clothTabs do
		self._clothTabs[i].btn:AddClickListener(function()
			self:_onSwitchClothType(i)
		end)
	end

	self._btnSwitchType:AddClickListener(self._onClickSwitchType, self)
	GameUtil.addClickHandler(self._btnUnLockCutePet, self._onClickUnlockCutePet, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function DressshowView:unbindEvents()
	DressshowView.super.unbindEvents(self)

	for k, v in pairs(self._filters) do
		v.tog:RemoveOnValueChanged()
	end

	for k, v in pairs(self._sortWays) do
		v.btn:RemoveClickListener()
	end

	self._btnSwitchSort:RemoveClickListener()

	for k, v in pairs(self._clothTabs) do
		v.btn:RemoveClickListener()
	end

	self._btnSwitchType:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnUnLockCutePet)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function DressshowView:destroyUI()
	DressshowView.super.destroyUI(self)
end

function DressshowView:onEnter()
	DressshowView.super.onEnter(self)

	self._avatar = self:getFirstParam()

	if self._avatar then
		local curCardInfo = RoleModel.instance.curCardInfo

		self.gender = curCardInfo.gender
		self.clothes = curCardInfo.clothes
		self.mountId = curCardInfo.mountId
		self.illusionCutePetRace = curCardInfo.illusionCutePetRace

		self:_updateAvatarMo(self.gender, self.clothes, self.mountId, self.illusionCutePetRace)
	end

	self._isEditingPreset = false

	self:_initView()
	GlobalDispatcher:addListener(GlobalNotify.UpdateDressInfo, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LoadEverGainedCutePetRaceResp, self._updateView, self)
	self.addGEvent(self, GlobalNotify.handlePM_UnLockIllusionCutePetRaceResp, self._updateView, self)
	self.addGEvent(self, GlobalNotify.GetClothesPresetRes, self._updateView, self)
	self.addGEvent(self, GlobalNotify.UpdateClothesPresetRes, self._updateView, self)

	if DressModel.instance:getIsInitData() then
		self:_updateView()
	else
		DressController.instance:sendGetNotoutInfoReq(self._updateView, self)
	end

	DressController.instance:sendGetOutInfoReq()
	GlobalDispatcher:addListener(GlobalNotify.UpdateDressInfoDaily, self._updateDressInfoDaily, self)
	RoleController.instance:addClockListener()
	CutePetController.instance:sendPM_LoadEverGainedCutePetRaceReq()
	DressController.instance:sendGetClothesPresetReq()
end

function DressshowView:onEnterFinished()
	DressshowView.super.onEnterFinished(self)
end

function DressshowView:onExit()
	DressshowView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateDressInfo, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateDressInfoDaily, self._updateDressInfoDaily, self)
	RoleController.instance:removeClockListener()

	self._avatar = nil

	self._tableviewSuit:dispose()
	self._tableviewSingle:dispose()
	self._scrollListPreset:dispose()
	self._scrollListPresetDress:dispose()

	local sendData = self:getCurClotherIds()
	local curCardInfo = RoleModel.instance.curCardInfo

	if self.illusionCutePetRace ~= curCardInfo.illusionCutePetRace then
		if not self.illusionCutePetRaceData or self.illusionCutePetRaceData.unLocked == true then
			CutePetController.instance:sendPM_SetMyCurIllusionCutePetRaceReq(self.illusionCutePetRace)

			if self.illusionCutePetRace then
				DressController.instance:sendSaveAvatarReq(self.clothes)
			else
				DressController.instance:sendSaveAvatarReq(sendData)
			end
		end
	elseif self.illusionCutePetRace then
		DressController.instance:sendSaveAvatarReq(self.clothes)
	else
		DressController.instance:sendSaveAvatarReq(sendData)
	end

	self.illusionCutePetRaceData = nil

	MaterialMgr.resetAll(self._unLockCutePetCon)
	self._scrollListPreset:dispose()

	if self._scrollPresetMap then
		for k, scroll in pairs(self._scrollPresetMap) do
			scroll:dispose()

			self._scrollPresetMap[k] = nil
		end
	end
end

function DressshowView:getCurClotherIds()
	local sendData = {}
	local dataList = DressModel.instance:getCurOwnDresses()

	for _, v in ipairs(dataList or {}) do
		local partId = v.dressCfg.partId

		if self._avatarmo:isExistDataByCfgId(partId) or checknumber(self.illusionCutePetRace) > 0 then
			table.insert(sendData, v.id)
		end
	end

	return sendData
end

function DressshowView:onExitFinished()
	DressshowView.super.onExitFinished(self)
end

function DressshowView:_updateAvatarMo(gender, clothes, mountId, illusionCutePetRace)
	local skeId = DressModel.instance:getSkeIdByGender(gender)

	self._drfaultPartIds = AvatarConfig.instance:getAvatarDefaultDatasByCfg(skeId)
	self._avatarmo = DressModel.instance:getAvatarPlayerMo(skeId, clothes, mountId)

	if checknumber(illusionCutePetRace) > 0 then
		skeId = DressModel.instance:getSkeIdByPetRace(illusionCutePetRace)

		local temp = {}
		local bgId, spId

		if self._avatarmo then
			bgId = self._avatarmo:getDataByType(AvatarDataType.UIBG)
			spId = self._avatarmo:getDataByType(AvatarDataType.UISpine)
		end

		if bgId then
			table.insert(temp, bgId)
		end

		if spId then
			table.insert(temp, spId)
		end

		self._avatarmo = DressModel.instance:getAvatarPlayerMo(skeId, temp, 0)
	end
end

function DressshowView:_initView()
	local params = self:getOpenParam()
	local initIndex = 2

	if params[2] then
		initIndex = params[2]
	end

	self._filters[initIndex].tog.isOn = true

	self:_onFilterValueChanged(true, initIndex, true)
	self:_onSwitchSortWay(1, true)
end

function DressshowView:_onFilterValueChanged(isOn, id, isInit)
	if isOn and self._curFilterId ~= id then
		self._curFilterId = id

		self:_switchClothFilter(id, isInit)
		self:_switchSortFilter()

		for _, v in ipairs(self._filters) do
			goutil.setActive(v.mark, v.id == id)
		end
	end

	goutil.setActive(self._sortTypes, false)
	goutil.setActive(self._clothTypes, false)
end

function DressshowView:_switchClothFilter(id, isInit)
	self._curTabCfgs = DressConfig.instance:getAllTabCfgs()[id]

	for i = 1, #self._clothTabs do
		if i <= table.nums(self._curTabCfgs) then
			goutil.setActive(self._clothTabs[i].go, true)

			local cfg = self._curTabCfgs[i - 1]

			self._clothTabs[i].txt.text = cfg.tabShow
			self._clothTabs[i].cfg = cfg
		else
			goutil.setActive(self._clothTabs[i].go, false)
		end
	end

	goutil.setActive(self._clothTypes, false)
	self:_onSwitchClothType(1, isInit)
end

function DressshowView:_switchSortFilter()
	local list = Sortway

	if self._curFilterId == 3 then
		list = SortwayCute
	end

	for i = 1, #self._sortWays do
		if i <= #list then
			goutil.setActive(self._sortWays[i].go, true)

			self._sortWays[i].txt.text = list[i]
		else
			goutil.setActive(self._sortWays[i].go, false)
		end
	end

	goutil.setActive(self._sortTypes, false)
	self:_onSwitchSortWay(1, false)
end

function DressshowView:_onSwitchClothType(id, isInit)
	local cfg = self._curTabCfgs[id - 1]

	if self._curClothCfg ~= cfg then
		self._curClothCfg = cfg
		self._showTypeTxt.text = cfg.tabShow

		if not isInit then
			self:_updateView()
		end
	end

	goutil.setActive(self._clothTypes, false)
end

function DressshowView:_onClickSwitchType()
	local isActive = self._clothTypes.activeSelf

	goutil.setActive(self._clothTypes, not isActive)
	goutil.setActive(self._sortTypes, false)

	if not isActive then
		for i = 1, #self._clothTabs do
			local cfg = self._curTabCfgs[i - 1]

			self._clothTabs[i].change:SetState(cfg == self._curClothCfg and 1 or 0)
		end
	end
end

function DressshowView:_onSwitchSortWay(id, isInit)
	if self._curSortWay ~= id then
		self._curSortWay = id
		self._showSortTxt.text = self._sortWays[id].txt.text

		if not isInit then
			self:_updateView()
		end
	end

	goutil.setActive(self._sortTypes, false)
end

function DressshowView:_onClickSwitchSort()
	local isActive = self._sortTypes.activeSelf

	goutil.setActive(self._sortTypes, not isActive)
	goutil.setActive(self._clothTypes, false)

	if not isActive then
		for i = 1, #self._sortWays do
			self._sortWays[i].change:SetState(self._curSortWay == i and 1 or 0)
		end
	end
end

function DressshowView:_updateView()
	goutil.setActive(self._goTableSuit, false)
	goutil.setActive(self._goTableSingle, false)
	goutil.setActive(self._cuteScrollView, false)
	GameUtil.SetActive(self._presetScrollView, self._isEditingPreset)
	GameUtil.SetActive(self._tableviewPreset, false)
	GameUtil.SetActive(self._preset, self._isEditingPreset)
	GameUtil.SetActive(self._fitersGo, not self._isEditingPreset)

	if checknumber(self.illusionCutePetRace) > 0 and self.illusionCutePetRaceData and not self.illusionCutePetRaceData.unLocked then
		GlobalDispatcher:dispatch(GlobalNotify.MyCardSetBtnMount, false)
		GameUtil.SetActive(self._unLockCutePetInfo, true)

		local unlockCfg = CutePetConfig.instance:getCutePetById(self.illusionCutePetRace)
		local matType, matId, matNum = MaterialMgr.getMatParams(unlockCfg.cost4UnlockIllusion)
		local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		MaterialMgr.setIcon(self._unLockCutePetCon, matType, matId)

		self._txtUnLockCutePetCost.text = langPara("%d/%d", hasNum, matNum)
		self._txtUnLockCutePetTip.text = langPara("任意一只%s最高星级达到%d解锁幻化", unlockCfg.name, unlockCfg.minStar4UnlockIllusion)

		GameUtil.SetActive(self._unLockCutePetRedPoint, self.illusionCutePetRaceData.everMaxStar >= unlockCfg.minStar4UnlockIllusion and matNum < hasNum)
	else
		GlobalDispatcher:dispatch(GlobalNotify.MyCardSetBtnMount, true)
		GameUtil.SetActive(self._unLockCutePetInfo, false)
	end

	if self._curFilterId == 3 then
		goutil.setActive(self._cuteScrollView, true)

		local dataList = CutePetModel.instance:getCuteSuit()

		self._txtOwnNum.text = #dataList

		self._tableviewCute:reloadData(dataList)
	elseif self._curFilterId == 2 then
		goutil.setActive(self._goTableSingle, true)

		local dataList = self:_createSingleDataList()

		if dataList == nil or #dataList == 0 then
			self._tableviewSingle:regGetDataLen(function()
				return 0
			end)

			self._txtOwnNum.text = 0
		else
			self._txtOwnNum.text = #dataList

			self._tableviewSingle:regGetDataLen(function()
				return #dataList
			end)
		end

		self._singleCell = {}

		self._tableviewSingle:reloadData(dataList)
	elseif self._curFilterId == 1 then
		goutil.setActive(self._goTableSuit, true)

		local dataList = self:_createSuitDataList()

		if dataList == nil or #dataList == 0 then
			self._tableviewSuit:regGetDataLen(function()
				return 0
			end)

			self._txtOwnNum.text = 0
		else
			self._tableviewSuit:regGetDataLen(function()
				return #dataList
			end)

			self._txtOwnNum.text = #dataList
		end

		self._tableviewSuit:reloadData(dataList)
	elseif self._curFilterId == 4 then
		GameUtil.SetActive(self._tableviewPreset, not self._isEditingPreset)

		local dataList = self:_createPresetDataList()
		local limitPresetCountStr = DressConfig.instance:getCommonCfgValue("CLOTHES_PRESET_COUNT")
		local limitPresetCount = checknumber(limitPresetCountStr)
		local presetList = {}

		for i = 1, limitPresetCount do
			table.insert(presetList, i)
		end

		self._scrollListPreset:reloadData(presetList)

		if dataList == nil or #dataList == 0 then
			self._scrollListPresetDress:regGetDataLen(function()
				return 0
			end)

			self._txtOwnNum.text = 0
		else
			self._scrollListPresetDress:regGetDataLen(function()
				return #dataList
			end)

			self._txtOwnNum.text = #dataList
		end

		self._scrollListPresetDress:reloadData(dataList)
	end
end

function DressshowView:_createSingleDataList()
	local type = self._curClothCfg.leftTab
	local dataList = DressModel.instance:getCurOwnDresses()

	self._singleDressMap = {}

	for i, v in ipairs(dataList) do
		self._singleDressMap[v.id] = v
	end

	local dataList = DressConfig.instance:getAllConfig().dataList or {}
	local showDataList = {}
	local roleGender = RoleModel.instance:getGender()

	for _, v in ipairs(dataList) do
		if v.clothesGender == roleGender or v.clothesGender == GameEnum.Gender.Neutral then
			if type == 0 then
				if self._singleDressMap[v.id] or not string.nilorempty(v.source) or not string.nilorempty(v.jumpTo) then
					table.insert(showDataList, v)
				end
			elseif type == v.belogTab and (self._singleDressMap[v.id] or not string.nilorempty(v.source) or not string.nilorempty(v.jumpTo)) then
				table.insert(showDataList, v)
			end
		end
	end

	if self._curSortWay == 1 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._singleDressMap[a.id]

				if mo then
					return mo.sortId
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
	elseif self._curSortWay == 2 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._singleDressMap[a.id]

				if mo then
					return mo.dateGet
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
	elseif self._curSortWay == 3 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._singleDressMap[a.id]

				if mo then
					if mo.dayActive then
						return 1
					else
						return 0
					end
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
	elseif self._curSortWay == 4 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._singleDressMap[a.id]

				if mo then
					if mo.dayActive then
						return 1
					else
						return 0
					end
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
	end

	return showDataList
end

function DressshowView:_createSuitDataList()
	local dataList = DressModel.instance:getCurOwnSuits()
	local showDataList = {}

	for _, v in ipairs(dataList) do
		table.insert(showDataList, v)
	end

	if self._curSortWay == 1 then
		table.sort(showDataList, function(a, b)
			return a.sortId < b.sortId
		end)
	elseif self._curSortWay == 2 then
		table.sort(showDataList, function(a, b)
			return a.dateGet < b.dateGet
		end)
	elseif self._curSortWay == 3 then
		table.sort(showDataList, function(a, b)
			if not a.dayActive then
				return false
			end

			return a.dayActive > b.dayActive
		end)

		local resortData = {}

		for k, v in ipairs(showDataList) do
			table.insert(resortData, 1, v)
		end

		showDataList = resortData
	elseif self._curSortWay == 4 then
		table.sort(showDataList, function(a, b)
			if not a.dayActive then
				return false
			end

			return a.dayActive > b.dayActive
		end)
	end

	return showDataList
end

function DressshowView:_createPresetDataList()
	local type = self._curClothCfg.leftTab
	local dataList = DressModel.instance:getCurOwnDresses()

	self._presetMap = {}
	self._scrollPresetMap = {}

	for i, v in ipairs(dataList) do
		self._presetMap[v.id] = v
	end

	local dataList = DressConfig.instance:getAllConfig().dataList or {}
	local showDataList = {}
	local roleGender = RoleModel.instance:getGender()

	for _, v in ipairs(dataList) do
		if v.clothesGender == roleGender or v.clothesGender == GameEnum.Gender.Neutral then
			if type == 0 then
				if self._presetMap[v.id] or not string.nilorempty(v.source) or not string.nilorempty(v.jumpTo) then
					table.insert(showDataList, v)
				end
			elseif type == v.belogTab and (self._presetMap[v.id] or not string.nilorempty(v.source) or not string.nilorempty(v.jumpTo)) then
				table.insert(showDataList, v)
			end
		end
	end

	if self._curSortWay == 1 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._presetMap[a.id]

				if mo then
					return mo.sortId
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
	elseif self._curSortWay == 2 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._presetMap[a.id]

				if mo then
					return mo.dateGet
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
	elseif self._curSortWay == 3 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._presetMap[a.id]

				if mo then
					if mo.dayActive then
						return 1
					else
						return 0
					end
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
	elseif self._curSortWay == 4 then
		ArraySort.sortOn(showDataList, {
			function(a)
				local mo = self._presetMap[a.id]

				if mo then
					if mo.dayActive then
						return 1
					else
						return 0
					end
				else
					return math.huge
				end
			end,
			"id"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
	end

	return showDataList
end

function DressshowView:_clearSingleCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)

	local btnSelect = goutil.findChild(cell, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function DressshowView:_clearSuitCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)

	local btnSelect = goutil.findChild(cell, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function DressshowView:_updateSingleCell(view, cell, dressCfg)
	local data = self._singleDressMap[dressCfg.id]

	self:_clearSingleCell(cell)

	local icon = goutil.findChild(cell, "icon")
	local btnSelect = goutil.findChildButtonComponent(cell, "btnSelect")
	local time = goutil.findChild(cell, "time")
	local txtTime = goutil.findChildTextComponent(time, "txt")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local markOnDress = goutil.findChild(cell, "markOnDress")
	local markSelect = goutil.findChild(cell, "markSelect")
	local top = goutil.findChild(cell, "top")
	local btn = goutil.findChild(cell, "top/btn")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getDressIconUrl(dressCfg.icon))
	goutil.setActive(markSelect, false)
	goutil.setActive(markOnDress, false)
	goutil.setActive(time, false)
	goutil.setActive(top, false)
	GameUtil.rmClickHandler(btn)

	if data then
		GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSingleCell, self, data))
		goutil.setActive(time, data.dayActive)

		if data.dayActive then
			txtTime.text = data.dayActive .. lang("天")
		end

		txtName.text = lang(data.dressCfg.name)

		local isOnDress = self._avatarmo:isExistDataByCfgId(data.dressCfg.partId)

		goutil.setActive(markSelect, isOnDress)
		goutil.setActive(markOnDress, isOnDress)
	else
		txtName.text = lang(dressCfg.name)

		goutil.setActive(top, true)
		GameUtil.addClickHandler(btn, GameUtil.handler(self._ongGotoGetSingle, self, dressCfg))
	end
end

function DressshowView:_updateCuteCell(view, cell, data)
	self:_clearSingleCell(cell)

	local icon = goutil.findChild(cell, "icon")
	local btnSelect = goutil.findChildButtonComponent(cell, "btnSelect")
	local time = goutil.findChild(cell, "time")
	local txtTime = goutil.findChildTextComponent(time, "txt")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local markOnDress = goutil.findChild(cell, "markOnDress")
	local markSelect = goutil.findChild(cell, "markSelect")
	local unlock = goutil.findChild(cell, "unLock")
	local redPoint = goutil.findChild(cell, "redpoint")

	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickCuteCell, self, data))
	goutil.setActive(time, false)
	GameUtil.SetActive(unlock, not data.unLocked)

	local cfg = MaterialMgr.getMatCfg(MatType.CutePet, data.raceId)

	MaterialMgr.setIcon(icon, MatType.CutePet, data.raceId)

	txtName.text = cfg.name

	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost4UnlockIllusion)

	GameUtil.SetActive(redPoint, (data.everMaxStar >= cfg.minStar4UnlockIllusion and MaterialModel.instance:IsEnough(matType, matId, matNum) == true or nil) and true and not data.unLocked)

	local isOnDress = self.illusionCutePetRace == data.raceId

	goutil.setActive(markSelect, isOnDress)

	local var_51_1

	if isOnDress then
		::label_51_0::

		var_51_1 = data.unLocked and data.unLocked == true
	end

	goutil.setActive(markOnDress, var_51_1)
end

function DressshowView:_updateSuitCell(view, cell, data)
	if data then
		self:_clearSuitCell(cell)

		local icon = goutil.findChild(cell, "icon")

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getDressIconUrl(data.suitCfg.icon, true))

		local btnSelect = goutil.findChildButtonComponent(cell, "btnSelect")

		GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSuitCell, self, data))

		local time = goutil.findChild(cell, "time")
		local txtTime = goutil.findChildTextComponent(time, "txt")

		goutil.setActive(time, data.dayActive)

		if data.dayActive then
			txtTime.text = data.dayActive .. lang("天")
		end

		local txtName = goutil.findChildTextComponent(cell, "txtName")

		txtName.text = lang(data.suitCfg.name)

		local markSelect = goutil.findChild(cell, "markSelect")
		local markOnDress = goutil.findChild(cell, "markOnDress")
		local isOnDress = self._avatarmo:isDressSuit(data.inClude)

		goutil.setActive(markSelect, isOnDress)
		goutil.setActive(markOnDress, isOnDress)
	end
end

function DressshowView:_ongGotoGetSingle(data)
	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)
	else
		MaterialMgr.openGetSource(MatType.Cloth, data.id)
	end
end

function DressshowView:_onClickSingleCell(data)
	if data.dateOut ~= -1 and ServerTime.now() * 1000 > data.dateOut then
		self:_updateDressInfoDaily()
		FloatWordMgr.instance:show(lang("该服装已过期"))

		return
	end

	local partId = data.dressCfg.partId
	local partType = AvatarConfig.instance:getPartCfgById(partId).partType
	local isOnDress = self._avatarmo:isExistDataByCfgId(partId)

	if (partType == AvatarDataType.UIBG or partType == AvatarDataType.UISpine) and self.illusionCutePetRace > 0 then
		if isOnDress then
			for i, v in ipairs(self.clothes or {}) do
				if v == partId then
					table.remove(self.clothes, i)

					break
				end
			end

			self._avatarmo:removeDataByType(partType)
		else
			table.insert(self.clothes, partId)
			self._avatarmo:setDataByCfgId(partId)
		end

		self._avatar:updateByMo(self._avatarmo)
		self:_updateView()
	else
		self.illusionCutePetRace = 0

		local curCardInfo = RoleModel.instance.curCardInfo
		local gender = curCardInfo.gender
		local skeId = DressModel.instance:getSkeIdByGender(gender)
		local change = false

		if skeId ~= self._avatarmo.skeleton then
			self._avatarmo.skeleton = skeId

			self._avatarmo:setSkeletonByCfgId(skeId, true)
			self._avatarmo:dressSuit(self.clothes)

			change = true
		end

		if isOnDress then
			if table.indexof(self._drfaultPartIds, partId) and not change then
				FloatWordMgr.instance:show(lang("默认装扮，无法卸下"))
			else
				self._avatarmo:removeDataByType(partType)
			end
		else
			self._avatarmo:setDataByCfgId(partId)
		end

		self._avatarmo:setDefaultState()
		self._avatar:updateByMo(self._avatarmo)

		self.clothes = self:getCurClotherIds()

		self:_updateView()
	end
end

function DressshowView:_onClickCuteCell(data)
	if data.raceId == self.illusionCutePetRace then
		self.illusionCutePetRace = 0
		self.illusionCutePetRaceData = nil
	else
		self.illusionCutePetRace = data.raceId
		self.illusionCutePetRaceData = data
	end

	self:_updateAvatarMo(self.gender, self.clothes, self.mountId, self.illusionCutePetRace)
	self._avatar:updateByMo(self._avatarmo)
	self:_updateView()
end

function DressshowView:_onClickSuitCell(data)
	self.illusionCutePetRace = 0

	local bgId = self._avatarmo:getDataByType(AvatarDataType.UIBG)
	local spId = self._avatarmo:getDataByType(AvatarDataType.UISpine)
	local curCardInfo = RoleModel.instance.curCardInfo
	local gender = curCardInfo.gender
	local skeId = DressModel.instance:getSkeIdByGender(gender)

	if skeId ~= self._avatarmo.skeleton then
		self._avatarmo.skeleton = skeId
	end

	local isOnDress = self._avatarmo:isDressSuit(data.inClude)
	local curMount = self._avatarmo.mount

	if isOnDress then
		if data.id == 1 or data.id == 2 then
			FloatWordMgr.instance:show(lang("默认套装，无法卸下"))

			return
		end

		self._avatarmo:unDressSuit(data.inClude)
	else
		self._avatarmo:resetUIState()
		self._avatarmo:dressSuit(data.inClude)
	end

	self._avatarmo:setDefaultState()

	self._avatarmo.mount = curMount

	if bgId then
		self._avatarmo:dressCloth(bgId)
	end

	if spId then
		self._avatarmo:dressCloth(spId)
	end

	self.clothes = self:getCurClotherIds()

	self:_updateAvatarMo(self.gender, self.clothes, self.mountId, self.illusionCutePetRace)
	self._avatar:updateByMo(self._avatarmo)
	self:_updateView()
end

function DressshowView:_onClickUnlockCutePet()
	if self.illusionCutePetRaceData and not self.illusionCutePetRaceData.unLocked then
		local unlockCfg = CutePetConfig.instance:getCutePetById(self.illusionCutePetRace)
		local matType, matId, matNum = MaterialMgr.getMatParams(unlockCfg.cost4UnlockIllusion)

		if self.illusionCutePetRaceData.everMaxStar < unlockCfg.minStar4UnlockIllusion then
			FloatWordMgr.instance:show(lang("所需星级不足"))
		elseif MaterialModel.instance:IsEnough(matType, matId, matNum) == false then
			MaterialMgr.openGetSourceByStr(unlockCfg.cost4UnlockIllusion)
		else
			CutePetController.instance:sendPM_UnLockIllusionCutePetRaceReq(self.illusionCutePetRace)
		end
	end
end

function DressshowView:_updateDressInfoDaily()
	self:_updateAvatarMo(self.gender, self.clothes, self.mountId, self.illusionCutePetRace)
	DressController.instance:sendGetNotoutInfoReq(self._updateView, self)
	DressController.instance:sendGetOutInfoReq()
end

function DressshowView:_updatePresetCell(view, cell, data)
	local btnEdit = goutil.findChild(cell, "btnEdit")
	local empty = goutil.findChild(cell, "empty")
	local select = goutil.findChild(cell, "select")
	local tableviewPresetClth = goutil.findChild(cell, "tableviewPresetCloth")
	local tablecellPresetCloth = goutil.findChild(cell, "tableviewPresetCloth/tablecellPresetCloth")
	local txtTitle = goutil.findChildTextComponent(cell, "title/txtTitle")
	local scrollList = self._scrollPresetMap[cell]
	local presetMap = DressModel.instance:getPresetMap()
	local info = presetMap[data]
	local isEmpty = not (info and not TableUtil.isTableEmpty(info.clothesIds))

	txtTitle.text = string.format(lang("预设%s"), data)

	if scrollList == nil and not isEmpty then
		scrollList = ScrollerList.create(tableviewPresetClth, tablecellPresetCloth, GameUtil.handler(self._updatePresetCellCloth, self), GameUtil.handler(self._clearPresetCellCloth, self))
		self._scrollPresetMap[cell] = scrollList
	end

	if not isEmpty then
		local clothesIds = checktable(info.clothesIds)

		scrollList:reloadData(clothesIds)
	end

	GameUtil.SetActive(tableviewPresetClth, not isEmpty)
	GameUtil.SetActive(empty, isEmpty)
	GameUtil.SetActive(select, checknumber(self._selectPresetId) == data)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickPresetCell, self, data), self)
	GameUtil.addClickHandler(btnEdit, function()
		self._isEditingPreset = true
		self._selectPresetId = data
		self._preClothes = TableUtil.deepcopy(self.clothes)
		self._curClothes = TableUtil.deepcopy(self.clothes)
		self._preIllusionCutePetRace = self.illusionCutePetRace

		GameUtil.SetActive(self._presetScrollView, self._isEditingPreset)
		GameUtil.SetActive(self._tableviewPreset, false)
		GameUtil.SetActive(self._preset, self._isEditingPreset)
		GameUtil.SetActive(self._fitersGo, not self._isEditingPreset)
	end)
end

function DressshowView:_clearPresetCell(cell)
	local scrollList = self._scrollPresetMap[cell]

	if scrollList then
		scrollList:dispose()
	end

	self._scrollPresetMap[cell] = nil
end

function DressshowView:_onClickPresetCell(data)
	local presetMap = DressModel.instance:getPresetMap()
	local info = presetMap[data]

	if info == nil then
		FloatWordMgr.instance:show(lang("请先设置预设"))

		return
	end

	self._selectPresetId = data

	local boyDefaultSuitCfg = DressConfig.instance:getSuitCfgById(DressModel.defaultMaleSkelId)
	local girlDefaultSuitCfg = DressConfig.instance:getSuitCfgById(DressModel.defaultFemaleSkelId)
	local girlIncludeClothIds = girlDefaultSuitCfg.include
	local boyIncludeClothIds = boyDefaultSuitCfg.include
	local infoClothesIds = info and GameUtil.pbToTable(info.clothesIds) or {}
	local curClothedIds = TableUtil.deepcopy(infoClothesIds)
	local genderIsRight = true
	local skeId = DressModel.instance:getSkeIdByGender(self.gender)
	local drfaultPartIds = AvatarConfig.instance:getAvatarDefaultDatasByCfg(skeId)
	local removeIdxList = {}
	local addIdsList = {}

	for i, id in ipairs(infoClothesIds) do
		local clothCfg = DressConfig.instance:getDressCfgById(id)
		local clothesGender = clothCfg.clothesGender
		local isDefault = table.indexof(girlIncludeClothIds, id) or table.indexof(boyIncludeClothIds, id)

		if isDefault then
			if clothesGender ~= self.gender then
				local idsAfterTransformGender = clothCfg.idsAfterTransformGender

				table.insert(removeIdxList, i)
				table.insertto(addIdsList, idsAfterTransformGender)
			end
		elseif clothesGender ~= 2 and clothesGender ~= self.gender then
			genderIsRight = false
		end
	end

	for i = #removeIdxList, 1, -1 do
		local idx = removeIdxList[i]

		table.remove(curClothedIds, idx)
	end

	table.insertto(curClothedIds, addIdsList)

	if not genderIsRight then
		FloatWordMgr.instance:show(lang("此预设方案内有【不符合当前性别】的时装,请选择其他预设方案或进行性转后再使用"))

		return
	end

	self:_updateAvatarMo(self.gender, curClothedIds, self.mountId, self.illusionCutePetRace)

	self.clothes = curClothedIds

	self._avatar:updateByMo(self._avatarmo)

	local limitPresetCountStr = DressConfig.instance:getCommonCfgValue("CLOTHES_PRESET_COUNT")
	local limitPresetCount = checknumber(limitPresetCountStr)
	local presetList = {}

	for i = 1, limitPresetCount do
		table.insert(presetList, i)
	end

	self._scrollListPreset:reloadData(presetList)
end

function DressshowView:_updatePresetDressCell(view, cell, presetDressCfg)
	local data = self._presetMap[presetDressCfg.id]

	self:_clearSingleCell(cell)

	local icon = goutil.findChild(cell, "icon")
	local btnSelect = goutil.findChildButtonComponent(cell, "btnSelect")
	local time = goutil.findChild(cell, "time")
	local txtTime = goutil.findChildTextComponent(time, "txt")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local markOnDress = goutil.findChild(cell, "markOnDress")
	local markSelect = goutil.findChild(cell, "markSelect")
	local top = goutil.findChild(cell, "top")
	local btn = goutil.findChild(cell, "top/btn")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getDressIconUrl(presetDressCfg.icon))
	goutil.setActive(markSelect, false)
	goutil.setActive(markOnDress, false)
	goutil.setActive(time, false)
	goutil.setActive(top, false)
	GameUtil.rmClickHandler(btn)

	if data then
		GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickPresetDressCell, self, data))
		goutil.setActive(time, data.dayActive)

		if data.dayActive then
			txtTime.text = data.dayActive .. lang("天")
		end

		txtName.text = lang(data.dressCfg.name)

		local isOnDress = self._avatarmo:isExistDataByCfgId(data.dressCfg.partId)

		goutil.setActive(markSelect, isOnDress)
		goutil.setActive(markOnDress, isOnDress)
	else
		txtName.text = lang(presetDressCfg.name)

		goutil.setActive(top, true)
		GameUtil.addClickHandler(btn, GameUtil.handler(self._ongGotoGetSingle, self, presetDressCfg))
	end
end

function DressshowView:_clearPresetDressCell(cell)
	return
end

function DressshowView:_onClickPresetDressCell(data)
	if data.dateOut ~= -1 and ServerTime.now() * 1000 > data.dateOut then
		self:_updateDressInfoDaily()
		FloatWordMgr.instance:show(lang("该服装已过期"))

		return
	end

	local partId = data.dressCfg.partId
	local partType = AvatarConfig.instance:getPartCfgById(partId).partType
	local isOnDress = self._avatarmo:isExistDataByCfgId(partId)

	if (partType == AvatarDataType.UIBG or partType == AvatarDataType.UISpine) and self.illusionCutePetRace > 0 then
		if isOnDress then
			for i, v in ipairs(self._curClothes or {}) do
				if v == partId then
					table.remove(self._curClothes, i)

					break
				end
			end

			self._avatarmo:removeDataByType(partType)
		else
			table.insert(self._curClothes, partId)
			self._avatarmo:setDataByCfgId(partId)
		end

		self._avatar:updateByMo(self._avatarmo)

		local dataList = self:_createPresetDataList()

		self._scrollListPresetDress:reloadData(dataList)
	else
		local curCardInfo = RoleModel.instance.curCardInfo
		local gender = curCardInfo.gender
		local skeId = DressModel.instance:getSkeIdByGender(gender)
		local change = false

		if skeId ~= self._avatarmo.skeleton then
			self._avatarmo.skeleton = skeId

			self._avatarmo:setSkeletonByCfgId(skeId, true)
			self._avatarmo:dressSuit(self._curClothes)

			change = true
		end

		if isOnDress then
			if table.indexof(self._drfaultPartIds, partId) and not change then
				FloatWordMgr.instance:show(lang("默认装扮，无法卸下"))
			else
				self._avatarmo:removeDataByType(partType)
			end
		else
			self._avatarmo:setDataByCfgId(partId)
		end

		self._avatarmo:setDefaultState()
		self._avatar:updateByMo(self._avatarmo)

		self._curClothes = self:getCurClotherIds()

		local dataList = self:_createPresetDataList()

		self._scrollListPresetDress:reloadData(dataList)
	end
end

function DressshowView:_updatePresetCellCloth(view, cell, data)
	local cloth = goutil.findChild(cell, "cloth")
	local dressCfg = DressConfig.instance:getDressCfgById(data)

	uGuiUtil.setSpriteToImage(cloth, uGuiUtil.SpriteType.BigBg, GameUrl.getDressIconUrl(dressCfg.icon))
end

function DressshowView:_clearPresetCellCloth(cell)
	local cloth = goutil.findChild(cell, "cloth")

	uGuiUtil.clearImage(cloth)
end

function DressshowView:_onClickBtnSure()
	self.clothes = TableUtil.deepcopy(self._preClothes)
	self.illusionCutePetRace = self._preIllusionCutePetRace

	self:_updateAvatarMo(self.gender, self.clothes, self.mountId, self.illusionCutePetRace)
	self._avatar:updateByMo(self._avatarmo)
	GameUtil.SetActive(self._preset, false)

	if checknumber(self._selectPresetId) > 0 then
		local clothesPreset = DressModel.instance:getUserClothesPresetNO(self._selectPresetId, self.gender, self._curClothes)

		DressController.instance:sendUpdateClothesPresetReq(clothesPreset)

		self._curClothes = nil
	end

	self._isEditingPreset = false

	self:_updateView()
end

function DressshowView:_onClickBtnCancel()
	self.clothes = TableUtil.deepcopy(self._preClothes)
	self.illusionCutePetRace = self._preIllusionCutePetRace

	self:_updateAvatarMo(self.gender, self.clothes, self.mountId, self.illusionCutePetRace)
	self._avatar:updateByMo(self._avatarmo)

	local dataList = self:_createPresetDataList()

	self._curClothes = nil
	self._isEditingPreset = false

	self._scrollListPresetDress:reloadData(dataList)
	GameUtil.SetActive(self._fitersGo, true)
	GameUtil.SetActive(self._preset, false)
	GameUtil.SetActive(self._tableviewPreset, true)
	GameUtil.SetActive(self._presetScrollView, false)
end

return DressshowView
