-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetSummaryView.lua

module("logic.extensions.recommendfmt.view.PetSummaryView", package.seeall)

local PetSummaryView = class("PetSummaryView", ViewComponent)

PetSummaryView.TabUnfoldWidth = 1016
PetSummaryView.TabFoldWidth = 575
PetSummaryView.UnfoldWidth = 1016
PetSummaryView.FoldWidth = 568
PetSummaryView.BigWidth = 184
PetSummaryView.BigHeight = 300
PetSummaryView.SmallWidth = 188
PetSummaryView.SmallHeight = 194
PetSummaryView.BigUnfoldCount = 5
PetSummaryView.SmallUnfoldCount = 5
PetSummaryView.FoldCount = 3
PetSummaryView.TitleHeight = 52

function PetSummaryView:ctor()
	PetSummaryView.super.ctor(self)
end

function PetSummaryView:buildUI()
	PetSummaryView.super.buildUI(self)

	self._btnUnfold = self:getBtn("btnUnfold")
	self._btnSimple = self:getBtn("btnSimple")
	self._unfoldIcon = self:getGo("btnUnfold/icon")
	self._changeUnfold = self._btnUnfold.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._changeSimplify = self._btnSimple.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._btnBook = self:getBtn("btnBook")
	self._btnGet = self:getBtn("btnGet")
	self._btnStrategy = self:getBtn("btnStrategy")
	self._btnStar = self:getBtn("btnStar")
	self._tabTableViewGo = self:getGo("tabTableview")

	local tabTablecellGo = self:getGo("tabTablecell")

	self._tabScrollList = ScrollerList.create(self._tabTableViewGo, tabTablecellGo, GameUtil.handler(self._tabUpdateCell, self), GameUtil.handler(self._tabClearCell, self))

	local tableviewGo = self:getGo("tableview")

	self._tableviewWorldPos = tableviewGo.transform.position
	self._tableviewRect = tableviewGo:GetComponent(goutil.Type_RectTransform)

	local cellGo = self:getGo("tablecell")

	self._scrollList = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._scrollList:regGetCellSize(GameUtil.handler(self._cellSize, self))
	self._scrollList:regValueChanged(GameUtil.handler(self._onScrollValueChanged, self))

	self._scrollRect = tableviewGo:GetComponent(ComponentType.ScrollRect)
	self._petInfo = self:getGo("petInfo")
	self._con = self:getGo("petInfo/mask/con")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtDesc = self:getTxt("petInfo/txtDesc")
	self._btnFilter = self:getGo("btnFilter")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
end

function PetSummaryView:bindEvents()
	PetSummaryView.super.bindEvents(self)
	self._btnStrategy:AddClickListener(self._onClickStrategy, self)
	self._btnBook:AddClickListener(self._onClickBook, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnUnfold:AddClickListener(self._onClickUnfold, self)
	self._btnSimple:AddClickListener(self._onClickSimple, self)
	self._btnStar:AddClickListener(self._onClickStar, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._InputC_Search_Clear:AddClickListener(self._onClearSearchClick, self)
end

function PetSummaryView:unbindEvents()
	PetSummaryView.super.unbindEvents(self)
	self._btnStrategy:RemoveClickListener()
	self._btnBook:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._btnUnfold:RemoveClickListener()
	self._btnSimple:RemoveClickListener()
	self._btnStar:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnFilter)
	self._inputSearch:RemoveOnValueChanged()
	self._InputC_Search_Clear:RemoveClickListener()
end

function PetSummaryView:onEnter()
	PetSummaryView.super.onEnter(self)
	RecommendFmtController.instance:registerLocalNotify(RecommendFmtController.PetSummaryClickPet, self._onClickPet, self)

	local params = self:getOpenParam() or {}

	self._tabIndex = params[1] or 1
	self._isUnfold = false
	self._isSimplify = false
	self._curSelectTabIndex = 1
	self._curShowPetCfg = nil
	self._starPetIds = GameUtil.getUserData(PetNoticeConfig.LocalUserDataKey) or {}

	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
	self:_clearPetInfo()
	self:_refreshUnfoldState()
	self:_refreshSimplifyState()
	self:_refreshView()
end

function PetSummaryView:onExit()
	PetSummaryView.super.onExit(self)
	GameUtil.saveUserData(PetNoticeConfig.LocalUserDataKey, self._starPetIds)
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
	RecommendFmtController.instance:unregisterLocalNotify(RecommendFmtController.PetSummaryClickPet, self._onClickPet, self)
	self._tabScrollList:dispose()
	self._scrollList:dispose()
	self:_clearPetInfo()
end

function PetSummaryView:_onClickStrategy()
	FuncOpenController.instance:openFuncByViewName(ViewName.StrongerTabMainView)
end

function PetSummaryView:_onClickStar()
	local petInfo = self._petList[self._curSelectTabIndex]

	if petInfo and self._curShowPetCfg then
		local smallTabList = petInfo.smallTabList

		if smallTabList then
			for j, v in ipairs(smallTabList) do
				if v.skinId == self._curShowPetCfg.skinId then
					local isHad = checknumber(table.indexof(self._starPetIds, v.skinId)) > 0

					v.isStar = (v.isStar + 1) % 2

					if v.isStar == 1 and not isHad then
						table.insert(self._starPetIds, v.skinId)

						break
					end

					table.removebyvalue(self._starPetIds, v.skinId, true)

					break
				end
			end
		end

		GameUtil.saveUserData(PetNoticeConfig.LocalUserDataKey, self._starPetIds)
		table.sort(smallTabList, function(a, b)
			if a.isStar ~= b.isStar then
				return a.isStar > b.isStar
			end

			return a.sort < b.sort
		end)
		self._scrollList:reloadData(self._petList)
	else
		Debug.logError("=====>\t 未查找到skinId，收藏失败")
	end
end

function PetSummaryView:_onClickBook()
	if self._curShowPetCfg then
		local infoPet = PetSkinConfig.instance:getPetSkinCfg(self._curShowPetCfg.skinId)

		if infoPet then
			PetbookController.instance:openPetinfoView(infoPet.raceId)
		end
	else
		FloatWordMgr.instance:show("无图鉴")
	end
end

function PetSummaryView:_onClickGet()
	if self._curShowPetCfg then
		local data = self._curShowPetCfg
		local isOpen = true

		if data.startTime and data.endTime then
			isOpen = GameUtil.getTimePeriodType(data.startTime, data.endTime, false) == GameUtil.inTimePeriod
		elseif data.startTime and not data.endTime then
			local startTimeStamp = data.startTime and GameUtil.string2time(data.startTime) or 0

			isOpen = startTimeStamp <= ServerTime.now()
		end

		if not isOpen then
			FloatWordMgr.instance:show("暂未开放")

			return
		end

		if checknumber(data.reportBehavior) > 0 then
			SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))
		end

		if data.jumpType == 1 then
			if data.type == 1 then
				local raceId = PetSkinConfig.instance:getPetSkinCfg(data.skinId).raceId

				MaterialMgr.openGetSource(MatType.Pet, raceId)
			elseif data.type == 2 then
				MaterialMgr.openGetSource(MatType.PET_SKIN, data.skinId)
			end
		else
			GotoMgr.gotoByString(data.funcId)
		end
	else
		FloatWordMgr.instance:show("无来源")
	end
end

function PetSummaryView:_onClickUnfold()
	self._isUnfold = not self._isUnfold

	self:_refreshUnfoldState()
	self:_refreshView()
end

function PetSummaryView:_onClickSimple()
	self._isSimplify = not self._isSimplify

	self:_refreshSimplifyState()
	self:_refreshView()
end

function PetSummaryView:_refreshUnfoldState()
	self._changeUnfold:SetState(self._isUnfold and 1 or 0)
	GameUtil.setLocalScale(self._unfoldIcon, self._isUnfold and 1 or -1, 1, 1)
end

function PetSummaryView:_refreshSimplifyState()
	self._changeSimplify:SetState(self._isSimplify and 1 or 0)
end

function PetSummaryView:_refreshView()
	self:_refreshTabTableview()
	self:_refreshPetTableview()
	self:_refreshPetInfo()
end

function PetSummaryView:_refreshTabTableview()
	GameUtil.setWidth(self._tabTableViewGo, (self._isUnfold or nil) and (PetSummaryView.TabUnfoldWidth or PetSummaryView.TabFoldWidth))

	local tabList = {}
	local cfgBigTab = PetNoticeConfig.instance:getBigTabCfg(self._tabIndex)

	if cfgBigTab and cfgBigTab.childIndex and #cfgBigTab.childIndex then
		for i, id in ipairs(cfgBigTab.childIndex) do
			local cfgSmallTab = PetNoticeConfig.instance:getSmallTabCfg(id)
			local smallTabList = PetNoticeConfig.instance:getPetNoticCfgs(cfgSmallTab.config_name)

			if #smallTabList > 0 then
				local tabInfo = {}

				tabInfo.index = #tabList + 1
				tabInfo.name = cfgSmallTab.name
				tabInfo.cfgSmallTab = cfgSmallTab
				tabInfo.isSelect = self._curSelectTabIndex == tabInfo.index

				table.insert(tabList, tabInfo)
			end
		end
	end

	self._tabScrollList:reloadData(tabList)
end

function PetSummaryView:_refreshPetTableview()
	goutil.setWidth(self._tableviewRect, (self._isUnfold or nil) and (PetSummaryView.UnfoldWidth or PetSummaryView.FoldWidth))

	local petList = {}
	local cfgBigTab = PetNoticeConfig.instance:getBigTabCfg(self._tabIndex)

	if cfgBigTab and cfgBigTab.childIndex and #cfgBigTab.childIndex then
		for i, id in ipairs(cfgBigTab.childIndex) do
			local cfgSmallTab = PetNoticeConfig.instance:getSmallTabCfg(id)
			local smallTabList = PetNoticeConfig.instance:getPetNoticCfgs(cfgSmallTab.config_name)
			local petTable = {}

			for i, v in ipairs(smallTabList) do
				if self:_onFilter(v.skinId) == true then
					table.insert(petTable, v)
				end
			end

			if #petTable > 0 then
				local petInfo = {}

				petInfo.index = #petList + 1
				petInfo.name = cfgSmallTab.name
				petInfo.smallTabList = petTable
				petInfo.cfgSmallTab = cfgSmallTab
				petInfo.isUnfold = self._isUnfold
				petInfo.isSimplify = self._isSimplify

				table.insert(petList, petInfo)

				self._curShowPetCfg = self._curShowPetCfg or petTable[1]
			end
		end
	end

	self._petList = petList

	self._scrollList:reloadData(petList)
end

function PetSummaryView:_tabUpdateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "btn/txt")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local changeGroup = btn.gameObject:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.name

	changeGroup:SetState(data.isSelect and 1 or 0)
	btn:AddClickListener(function()
		self:_onClickTab(data.index, data.cfgSmallTab)
	end)
end

function PetSummaryView:_tabClearCell(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btn:RemoveClickListener()
end

function PetSummaryView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PetSummaryCell)

	component:init(data)
end

function PetSummaryView:_clearCell(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PetSummaryCell)

	component:clear()
end

function PetSummaryView:_cellSize(view, index)
	if self._petList and self._petList[index + 1] then
		local petInfo = self._petList[index + 1]
		local totalCount = #petInfo.smallTabList

		if petInfo.isUnfold then
			if petInfo.isSimplify then
				local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.SmallUnfoldCount) + 1

				return PetSummaryView.SmallWidth, PetSummaryView.TitleHeight + PetSummaryView.SmallHeight * lineNum
			else
				local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.BigUnfoldCount) + 1

				return PetSummaryView.BigWidth, PetSummaryView.TitleHeight + PetSummaryView.BigHeight * lineNum
			end
		elseif petInfo.isSimplify then
			local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.FoldCount) + 1

			return PetSummaryView.SmallWidth, PetSummaryView.TitleHeight + PetSummaryView.SmallHeight * lineNum
		else
			local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.FoldCount) + 1

			return PetSummaryView.BigWidth, PetSummaryView.TitleHeight + PetSummaryView.BigHeight * lineNum
		end
	end
end

function PetSummaryView:_onScrollValueChanged(tableview)
	local count = tableview:GetVisibleCount()
	local targetCellIndex = 1
	local distance = 9999999

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local worldx, worldy, worldz = Framework.TransformUtil.GetPos(cell.transform, 0, 0, 0)
			local tempDistance = Mathf.Abs(self._tableviewWorldPos.y - worldy)

			if tempDistance < distance then
				distance = tempDistance
				targetCellIndex = cell.index + 1
			end
		end
	end

	if self._scrollRect.verticalNormalizedPosition <= 0.05 then
		local index = #self._scrollList:getData()

		self:_changeSelectTab(index)
	else
		self:_changeSelectTab(targetCellIndex)
	end
end

function PetSummaryView:_changeSelectTab(index)
	self._curSelectTabIndex = index

	local curViewDatas = self._tabScrollList:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelect = self._curSelectTabIndex == v.index
	end

	self._tabScrollList:refresh()
	self._tabScrollList:MoveCellInView(index - 1)
end

function PetSummaryView:_onReloadFinish()
	self._scrollList:MoveCellToBegin(Mathf.Max(0, self._curSelectTabIndex - 1))
end

function PetSummaryView:_onClickTab(index, cfgSmallTab)
	self._curSelectTabIndex = index

	self:_refreshTabTableview()
	self._scrollList:MoveCellToBegin(Mathf.Max(0, index - 1))
end

function PetSummaryView:_showPetInfo(cfg)
	self._curShowPetCfg = cfg

	if cfg then
		self:_showRoleModel(cfg.skinId)

		local cfgSkin = PetSkinConfig.instance:getPetSkinCfg(cfg.skinId)

		if cfgSkin then
			local isSkin = cfg.type == 2
			local styCfg = PetStrategyConfig.instance:getStrategyById(cfgSkin.raceId)

			self._txtName.text = cfg.type == 1 and not string.nilorempty(cfg.petDisplayName) and cfg.petDisplayName or cfgSkin.skinName

			local var_29_0

			if isSkin then
				var_29_0 = cfg.getDescription

				if not cfg.getDescription then
					if styCfg then
						var_29_0 = styCfg.resume or "请配置精灵攻略表"
					end
				end
			end

			self._txtDesc.text = var_29_0
		end

		local isOpen = GameUtil.getTimePeriodType(cfg.startTime, cfg.endTime, false) ~= GameUtil.beforeTimePeriod

		goutil.setActive(self._btnBook.gameObject, isOpen)
		goutil.setActive(self._btnStar.gameObject, isOpen)
	else
		self:_clearPetInfo()
	end
end

function PetSummaryView:_clearPetInfo()
	goutil.setActive(self._btnBook.gameObject, false)
	goutil.setActive(self._btnGet.gameObject, false)
	goutil.setActive(self._btnStar.gameObject, false)

	self._txtName.text = "无"
	self._txtDesc.text = "无"

	self:_resetRoleModel()
end

function PetSummaryView:_showRoleModel(skinId)
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

function PetSummaryView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function PetSummaryView:_onClickPet(cfg)
	self:_showPetInfo(cfg)
end

function PetSummaryView:_refreshPetInfo()
	goutil.setActive(self._petInfo, not self._isUnfold)
	goutil.setActive(self._btnStrategy.gameObject, not self._isUnfold)
	goutil.setActive(self._btnBook.gameObject, not self._isUnfold and self._curShowPetCfg)
	goutil.setActive(self._btnGet.gameObject, not self._isUnfold and self._curShowPetCfg)
	goutil.setActive(self._btnStar.gameObject, not self._isUnfold and self._curShowPetCfg)

	if not self._isUnfold then
		self:_showPetInfo(self._curShowPetCfg)
	end
end

function PetSummaryView:_onFilter(faceId)
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

function PetSummaryView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_refreshView()
	end
end

function PetSummaryView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function PetSummaryView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PET_FILES, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function PetSummaryView:_updateFilterData(starList, jobList, rareList)
	self:_refreshView()
end

return PetSummaryView
