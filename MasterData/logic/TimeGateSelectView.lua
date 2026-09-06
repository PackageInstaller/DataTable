-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/view/TimeGateSelectView.lua

module("logic.extensions.timegate.view.TimeGateSelectView", package.seeall)

local TimeGateSelectView = class("TimeGateSelectView", ViewComponent)
local SORT_TYPE_NOT_GET = 1
local SORT_TYPE_ONLINE_TIME = 2
local SORT_TYPE_PASS_NUM = 3

function TimeGateSelectView:ctor()
	TimeGateSelectView.super.ctor(self)

	self._currSearching = nil
	self._qualityFilter = 0
end

function TimeGateSelectView:buildUI()
	TimeGateSelectView.super.buildUI(self)

	self._petAttr = self:getGo("petInfo/attr"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtDesc = self:getTxt("petInfo/txtDesc")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._con = self:getGo("petInfo/con")
	self._petInfoGo = self:getGo("petInfo")
	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._txtType = self:getTxt("txtType")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regValueChanged(GameUtil.handler(self._onScrollValueChanged, self))

	self._tableviewWorldPos = self.scrollerGo.transform.position
	self._scrollRect = self.scrollerGo:GetComponent(ComponentType.ScrollRect)
	self._columnCount = Mathf.Max(1, self._scrollList._tableview.numRowsOrCols or 3)
	self._tabTableview = self:getGo("tabTableview")
	self._tabTablecell = self:getGo("tabTablecell")
	self._tabTableList = ScrollerList.create(self._tabTableview, self._tabTablecell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._txtTabName = self:getTxt("tableview/bg/txtName")
	self._subTabTableview = self:getGo("subTabTableview")
	self._subTabTablecell = self:getGo("subTabTablecell")
	self._subTabTableList = ScrollerList.create(self._subTabTableview, self._subTabTablecell, GameUtil.handler(self._updateSubTabCell, self), GameUtil.handler(self._clearSubTabCell, self))
	self._btnFilter = self:getGo("btnFilter")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnChallenge = self:getGo("btnChallenge")
	self._sortContent = self:getGo("sortContent")
	self._btnSort = self:getGo("btnSort")
	self._sortBtnCustomInput = UICustomInput.Get(self._sortContent)
	self._imgChangeSort = goutil.findChildComponent(self.mainGO, "btnSort/ImgSort", ComponentType.UIImageSpriteChange)
	self._textSort = self:getTxt("btnSort/Text")
	self._btnSortCellList = {}

	for i = 1, self._sortContent.transform.childCount do
		local item = {}

		item.sortType = i
		item.go = self:getGo("sortContent/cell_" .. i)
		item.imageChange = goutil.findChildComponent(item.go, "ImgSort", ComponentType.UIImageSpriteChange)
		self._btnSortCellList[i] = item
	end

	self._txtSelectTime = self:getTxt("selectTips/txtSelectTime")
end

function TimeGateSelectView:bindEvents()
	TimeGateSelectView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._InputC_Search_Clear:AddClickListener(self._onClearSearchClick, self)
	self._sortBtnCustomInput:AddListener(self._onCustomInputCallback, self)

	for k, v in pairs(self._btnSortCellList) do
		GameUtil.addClickHandler(v.go, function()
			self:_onClickSortCell(v.sortType)
		end, self)
	end
end

function TimeGateSelectView:unbindEvents()
	TimeGateSelectView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnSort)
	self._inputSearch:RemoveOnValueChanged()
	self._InputC_Search_Clear:RemoveClickListener()
	self._sortBtnCustomInput:RemoveListener()

	for k, v in pairs(self._btnSortCellList) do
		GameUtil.rmClickHandler(v.go)
	end
end

function TimeGateSelectView:onEnter()
	TimeGateSelectView.super.onEnter(self)

	self._typeIndex = checknumber(self:getFirstParam())
	self._curSelectRaceId = TimeGateModel.instance:getRaceIdByType(self._typeIndex)
	self._curTabId = 1
	self._sortType = SORT_TYPE_PASS_NUM
	self._sortReverse = false
	self._qualityFilter = self:_getDefaultSubTabId()
	self._curSubTabType = nil

	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
	self:_onClearSearchClick()
	self:_refreshView()
	self:_updatePetInfo(self._curSelectRaceId)
	GameUtil.SetActive(self._sortContent, false)
end

function TimeGateSelectView:onExit()
	TimeGateSelectView.super.onExit(self)
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
	self._scrollList:dispose()
	self._subTabTableList:dispose()
	self:_resetRoleModel()
	self:_onClearSearchClick()
end

function TimeGateSelectView:_refreshView()
	local tabCfg = TimeGateConfig.instance:getTabCfgs()

	self._tabTableList:reloadData(tabCfg)

	local subTabCfgs = TimeGateConfig.instance:getSubTabCfgs()

	self._subTabTableList:reloadData(subTabCfgs)

	local cfgs = TimeGateConfig.instance:getTypeCfgSortList(self._typeIndex)
	local typeGroups = {
		[TimeGateModel.SubTabTypeYuanqi] = {},
		[TimeGateModel.SubTabTypeShenyao] = {},
		[TimeGateModel.SubTabTypeLegend] = {}
	}

	for i, v in ipairs(cfgs) do
		if v[1].tabId == self._curTabId then
			local info = {}

			info.raceId = v[1].raceId
			info.isSelect = self._curSelectRaceId == v[1].raceId
			info.firstCfg = v[1]

			if self:_onFilter(info.raceId) == true then
				local raceType = self:_getRaceType(info.raceId)

				table.insert(typeGroups[raceType], info)
			end
		end
	end

	local sortFuncs = {
		function(a)
			return TimeGateModel.instance:isOpenByRaceId(a.raceId) and -1 or 1
		end,
		function(a)
			if self._sortType == SORT_TYPE_NOT_GET then
				if not self._sortReverse then
					return not PetskinController.instance:checkHasForeverSkinBySkinId(a.raceId) and -1 or 1
				else
					return PetskinController.instance:checkHasForeverSkinBySkinId(a.raceId) and -1 or 1
				end
			elseif self._sortType == SORT_TYPE_PASS_NUM then
				local passNum = TimeGateModel.instance:getParticipate(self._typeIndex, a.raceId)

				passNum = passNum or -1

				if not self._sortReverse then
					return -passNum
				else
					return passNum
				end
			elseif self._sortType == SORT_TYPE_ONLINE_TIME then
				local time = GameUtil.string2time(a.firstCfg.openTime)

				if not self._sortReverse then
					return -time
				else
					return time
				end
			else
				return 0
			end
		end,
		function(a)
			local time = GameUtil.string2time(a.firstCfg.openTime)

			return -time
		end,
		function(a)
			return a.raceId
		end
	}
	local sectionOrder = {
		TimeGateModel.SubTabTypeYuanqi,
		TimeGateModel.SubTabTypeShenyao,
		TimeGateModel.SubTabTypeLegend
	}
	local list = {}

	self._sectionStartIdx = {}

	for _, typeId in ipairs(sectionOrder) do
		local group = typeGroups[typeId]

		if #group > 0 then
			ArraySort.sortOn(group, sortFuncs)

			self._sectionStartIdx[typeId] = #list + 1

			for _, info in ipairs(group) do
				table.insert(list, info)
			end

			local remain = #group % self._columnCount

			if remain > 0 then
				for i = 1, self._columnCount - remain do
					table.insert(list, {
						isEmpty = true
					})
				end
			end
		end
	end

	local hasSelect = false

	for i, v in ipairs(list) do
		if v.isEmpty then
			-- block empty
		elseif v.raceId == self._curSelectRaceId then
			hasSelect = true
			v.isSelect = true
		else
			v.isSelect = false
		end
	end

	if not hasSelect then
		self._curSelectRaceId = 0

		for i, v in ipairs(list) do
			if not v.isEmpty then
				v.isSelect = true
				self._curSelectRaceId = v.raceId

				break
			end
		end
	end

	self._scrollList:reloadData(list)
	self:_updatePetInfo(self._curSelectRaceId)

	for k, v in pairs(self._btnSortCellList) do
		if v.sortType ~= self._sortType then
			v.imageChange:SetState(0)
		elseif self._sortReverse == true then
			v.imageChange:SetState(2)
		else
			v.imageChange:SetState(1)
		end
	end

	if self._sortReverse == true then
		self._imgChangeSort:SetState(2)
	else
		self._imgChangeSort:SetState(1)
	end

	self._textSort.text = self._sortType == SORT_TYPE_NOT_GET and lang("未获得") or self._sortType == SORT_TYPE_PASS_NUM and lang("挑战热度") or self._sortType == SORT_TYPE_ONLINE_TIME and lang("上线时间") or lang("默认顺序")

	if self._typeIndex == TimeGateModel.Normal then
		self._txtType.text = lang("时间之门-普通挑战")
	elseif self._typeIndex == TimeGateModel.High then
		self._txtType.text = lang("时间之门-高阶挑战")
	end

	local curTabCfg = TimeGateConfig.instance:getTabCfg(self._typeIndex, self._curTabId)

	if curTabCfg then
		self._txtTabName.text = curTabCfg.tabName
	end

	local leftTime = TimeGateModel.instance:getLeftTime(self._typeIndex)
	local typeCfg = TimeGateConfig.instance:getTypeCfg(self._typeIndex)
	local weeklyTimes = typeCfg.weeklyTimes
	local extraTimes = TimeGateModel.instance:getRegressExtraTimes(self._typeIndex)
	local timesLimit = TimeGateModel.instance:getTimesLimitWithRegress(self._typeIndex)

	self._txtTime.text = langPara("本周剩余：%d/%d", leftTime, timesLimit)
	self._txtSelectTime.text = langPara("每周5:00增加%s次（回归特权额外+%s次），最多存%s次", weeklyTimes, extraTimes, timesLimit)

	local showBtns = self._curSelectRaceId > 0 and TimeGateModel.instance:getLeftTime(self._typeIndex) > 0 and not TimeGateModel.instance:isOpenByRaceId(self._curSelectRaceId)

	GameUtil.SetActive(self._btnCancel, showBtns)
	GameUtil.SetActive(self._btnSure, showBtns)
	GameUtil.SetActive(self._btnChallenge, TimeGateModel.instance:isOpenByRaceId(self._curSelectRaceId))
end

function TimeGateSelectView:_updateCell(view, cell, data, tag)
	if data.isEmpty then
		GameUtil.SetActive(goutil.findChild(cell, "btn"), false)

		local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

		btn:RemoveClickListener()

		return
	end

	GameUtil.SetActive(goutil.findChild(cell, "btn"), true)

	local icon = goutil.findChild(cell, "btn/mask/icon")
	local txtName = goutil.findChildTextComponent(cell, "btn/name/txt")
	local txtDesc = goutil.findChildTextComponent(cell, "btn/txtDesc")
	local attrSpriteChange = goutil.findChild(cell, "btn/attrBg/attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local noGet = goutil.findChild(cell, "btn/noGet")
	local selectGo = goutil.findChild(cell, "btn/select")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local txtParticipateNum = goutil.findChildTextComponent(cell, "btn/participateNum/txt")
	local openGo = goutil.findChild(cell, "btn/open")
	local raceId = data.raceId
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId) % 10 - 1
	local rare = CharacterConfig.instance:getInitRare(raceId)
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(raceId)
	local styCfg = PetStrategyConfig.instance:getStrategyById(raceId)
	local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(raceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))
	local imgPath = GameUrl.getPetImgUrl(modelCo.cardName)

	txtName.text = infoPet.skinName

	if styCfg then
		txtDesc.text = styCfg.resume or "请配置精灵攻略表"
	end

	attrSpriteChange:SetState(race)
	GameUtil.SetActive(selectGo, data.isSelect)
	GameUtil.SetActive(noGet, not isGet)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, imgPath)
	GameUtil.SetActive(openGo, not TimeGateModel.instance:isOpenByRaceId(raceId) and TimeGateModel.instance:getLeftTime(self._typeIndex) <= 0)

	local participateNum = TimeGateModel.instance:getParticipate(self._typeIndex, raceId)

	txtParticipateNum.text = participateNum and langPara("挑战热度：%d", participateNum) or lang("数据统计中")

	btn:AddClickListener(function()
		self:_onClickSelect(raceId)
	end)
end

function TimeGateSelectView:_clearCell(cell)
	local icon = goutil.findChild(cell, "btn/mask/icon")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	uGuiUtil.clearImage(icon)
	btn:RemoveClickListener()
end

function TimeGateSelectView:_onScrollValueChanged(tableView)
	if not self._sectionStartIdx then
		return
	end

	local count = tableView:GetVisibleCount()
	local targetIdx = 1
	local minDist = 999999

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			local wx, wy, wz = Framework.TransformUtil.GetPos(cell.transform, 0, 0, 0)
			local dist = Mathf.Abs(self._tableviewWorldPos.y - wy)

			if dist < minDist then
				minDist = dist
				targetIdx = cell.index + 1
			end
		end
	end

	local curSectionType

	for _, typeId in ipairs({
		TimeGateModel.SubTabTypeYuanqi,
		TimeGateModel.SubTabTypeShenyao,
		TimeGateModel.SubTabTypeLegend
	}) do
		local startIdx = self._sectionStartIdx[typeId]

		if startIdx and startIdx <= ((self._scrollRect.verticalNormalizedPosition <= 0.05 or nil) and #self._scrollList:getData()) then
			curSectionType = typeId
		end
	end

	if curSectionType and curSectionType ~= self._curSubTabType then
		self._curSubTabType = curSectionType

		self:_changeSubTabByType(curSectionType)
	end
end

function TimeGateSelectView:_changeSubTabByType(sectionType)
	local subTabCfgs = TimeGateConfig.instance:getSubTabCfgs()

	for i, cfg in ipairs(subTabCfgs) do
		if cfg.type == sectionType then
			self._qualityFilter = cfg.subTabId

			self._subTabTableList:reloadData(subTabCfgs)

			break
		end
	end
end

function TimeGateSelectView:_updateList(raceId)
	local curViewDatas = self._scrollList:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelect = v.raceId == raceId
	end

	self._scrollList:refresh()
end

function TimeGateSelectView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "btn/txt")
	local btn = goutil.findChild(go, "btn")
	local changeGroup = btn:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.tabName

	changeGroup:SetState(self._typeIndex == data.type and self._curTabId == data.tabId and 1 or 0)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickTab(data)
	end)
end

function TimeGateSelectView:_clearTabCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function TimeGateSelectView:_onClickSelect(raceId)
	self._curSelectRaceId = raceId

	self:_updateList(raceId)
	self:_updatePetInfo(raceId)

	if TimeGateModel.instance:getLeftTime(self._typeIndex) > 0 and not TimeGateModel.instance:isOpenByRaceId(self._curSelectRaceId) then
		GameUtil.SetActive(self._btnCancel, true)
		GameUtil.SetActive(self._btnSure, true)
	else
		GameUtil.SetActive(self._btnCancel, false)
		GameUtil.SetActive(self._btnSure, false)
	end

	GameUtil.SetActive(self._btnChallenge, TimeGateModel.instance:isOpenByRaceId(self._curSelectRaceId))
end

function TimeGateSelectView:_onClickTab(tabData)
	self:_switchTab(tabData)
end

function TimeGateSelectView:_switchTab(tabData)
	self._typeIndex = tabData.type
	self._curTabId = tabData.tabId

	self:_onClearSearchClick()

	self._sortType = SORT_TYPE_PASS_NUM
	self._sortReverse = false
	self._qualityFilter = self:_getDefaultSubTabId()
	self._curSubTabType = nil

	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)

	self._curSelectRaceId = TimeGateModel.instance:getRaceIdByType(self._typeIndex)

	self:_refreshView()
	self:_updatePetInfo(self._curSelectRaceId)
end

function TimeGateSelectView:_onClickSure()
	local typeCfg = TimeGateConfig.instance:getTypeCfg(self._typeIndex)

	if TimeGateModel.instance:isOpenByRaceId(self._curSelectRaceId) then
		if TimeGateModel.instance:getRaceIdByType(self._typeIndex) == self._curSelectRaceId then
			self:close()
		else
			TimeGateModel.instance:changeSelectGate(self._typeIndex, self._curSelectRaceId)
			self:close()
			GlobalDispatcher:dispatch(GlobalNotify.TimeGateSelectOpenRes)
		end
	elseif TimeGateModel.instance:getLeftTime(self._typeIndex) > 0 then
		local content = "确认后即扣除1次次数，且所选精灵在本周不可修改（周五 05:00重置）"
		local subTabCfg = self:_getSubTabCfgById(self._qualityFilter)

		if self._typeIndex == TimeGateModel.High and subTabCfg then
			local tipText = TimeGateController.instance:tryGetPowerTipText(subTabCfg.type)

			if tipText then
				content = tipText .. "\n" .. content
			end
		end

		TipsFacade.instance:openPopupWindowWithX(lang("提示"), content, function()
			TimeGateAgent.instance:sendPM_TimeGateSelectOpenReq(self._typeIndex, self._curSelectRaceId)
			printInfo("test TimeGateSelectView:_onClickSure", self._typeIndex, self._curSelectRaceId)
			self:close()
		end)
	else
		FloatWordMgr.instance:show(lang("本周次数已用完"))
	end
end

function TimeGateSelectView:_onClickCancel()
	self:_onClearSearchClick()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
	self:close()
end

function TimeGateSelectView:_onClickInfo()
	if checknumber(self._curSelectRaceId) > 0 then
		PetbookController.instance:openPetinfoView(self._curSelectRaceId)
	end
end

function TimeGateSelectView:_updatePetInfo(raceId)
	raceId = checknumber(raceId)

	GameUtil.SetActive(self._petInfoGo, raceId > 0)

	if raceId <= 0 then
		return
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId) % 10 - 1
	local rare = CharacterConfig.instance:getInitRare(raceId)
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(raceId)
	local styCfg = PetStrategyConfig.instance:getStrategyById(raceId)
	local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(raceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))
	local imgPath = GameUrl.getPetImgUrl(modelCo.cardName)

	self._petAttr:SetState(race)

	self._txtName.text = infoPet.skinName

	if styCfg then
		self._txtDesc.text = styCfg.resume or "请配置精灵攻略表"
	end

	self:_showRoleModel(raceId)
	GameUtil.SetActive(self._btnInfo, checknumber(raceId) > 0)
end

function TimeGateSelectView:_showRoleModel(skinId)
	local curFaceId = skinId
	local offset = CharactorFacade.instance:getFormationModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, false, x, y)
end

function TimeGateSelectView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function TimeGateSelectView:_onFilter(faceId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(faceId)
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, skinCfg.raceId)
	local isHit = false

	isHit = PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PET_FILES, cfg)

	local skinName = PetSkinConfig.instance:getPetSkinName(faceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(skinName, str)

		if not count then
			return false
		end
	end

	return isHit
end

function TimeGateSelectView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_refreshView()
	end
end

function TimeGateSelectView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function TimeGateSelectView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PET_FILES, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function TimeGateSelectView:_updateFilterData(starList, jobList, rareList)
	self:_refreshView()
end

function TimeGateSelectView:_onClickChallenge()
	if TimeGateModel.instance:getRaceIdByType(self._typeIndex) == self._curSelectRaceId then
		self:close()
	else
		TimeGateModel.instance:changeSelectGate(self._typeIndex, self._curSelectRaceId)
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.TimeGateSelectOpenRes)
	end

	local raceId = TimeGateModel.instance:getRaceIdByType(self._typeIndex)
	local cfgs = TimeGateConfig.instance:getTypePetCfgList(self._typeIndex, raceId)

	if cfgs and #cfgs > 0 then
		local paramStr = cfgs[1].param

		if string.nilorempty(paramStr) then
			UIStateManager.instance:push(cfgs[1].viewName)
		else
			local params = string.split(paramStr, "#")

			UIStateManager.instance:push(cfgs[1].viewName, unpack(params))
		end
	end
end

function TimeGateSelectView:_onClickSort()
	GameUtil.SetActive(self._sortContent, true)
end

function TimeGateSelectView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._sortContent, false)
	end
end

function TimeGateSelectView:_onClickSortCell(sortType)
	self._sortReverse = self._sortType == sortType and not self._sortReverse or false
	self._sortType = sortType

	self:_refreshView()
end

function TimeGateSelectView:_updateSubTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "btn/txt")
	local btn = goutil.findChild(go, "btn")
	local changeGroup = btn:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.subTabName

	changeGroup:SetState(self._qualityFilter == data.subTabId and 1 or 0)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickSubTab(data)
	end)
end

function TimeGateSelectView:_clearSubTabCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function TimeGateSelectView:_onClickSubTab(subTabData)
	self:_switchSubTab(subTabData)
end

function TimeGateSelectView:_getRaceType(raceId)
	if PetSkinConfig.instance:checkHasJob(raceId, GameEnum.CareerType.SourceTrace) then
		return TimeGateModel.SubTabTypeYuanqi
	elseif PetSkinConfig.instance:checkHasJob(raceId, GameEnum.CareerType.ShenYao) then
		return TimeGateModel.SubTabTypeShenyao
	else
		return TimeGateModel.SubTabTypeLegend
	end
end

function TimeGateSelectView:_switchSubTab(subTabData)
	self._qualityFilter = subTabData.subTabId
	self._curSubTabType = subTabData.type
	self._curSelectRaceId = 0

	local subTabCfgs = TimeGateConfig.instance:getSubTabCfgs()

	self._subTabTableList:reloadData(subTabCfgs)

	local startIdx = self._sectionStartIdx[subTabData.type]

	if startIdx then
		self._scrollList:MoveCellToBegin(startIdx - 1)
	end
end

function TimeGateSelectView:_getSubTabCfgById(subTabId)
	local subTabCfgs = TimeGateConfig.instance:getSubTabCfgs()

	for i, cfg in ipairs(subTabCfgs) do
		if cfg.subTabId == subTabId then
			return cfg
		end
	end

	return nil
end

function TimeGateSelectView:_getDefaultSubTabCfg()
	local subTabCfgs = TimeGateConfig.instance:getSubTabCfgs()

	return (subTabCfgs or nil) and (subTabCfgs[1] or nil)
end

function TimeGateSelectView:_getDefaultSubTabId()
	local cfg = self:_getDefaultSubTabCfg()

	return (cfg or nil) and (cfg.subTabId or 0)
end

return TimeGateSelectView
