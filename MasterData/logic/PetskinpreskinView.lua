-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetskinpreskinView.lua

module("logic.extensions.petskinpreview.view.PetskinpreskinView", package.seeall)

local PetskinpreskinView = class("PetskinpreskinView", ViewComponent)

PetskinpreskinView.TitleHeight = 0
PetskinpreskinView.ProgressHeight = 0
PetskinpreskinView.SkinHeight = 300
PetskinpreskinView.SkinWidth = 203
PetskinpreskinView.SkinLineNum = 5
PetskinpreskinView.ShengpinSkinHeight = 333
PetskinpreskinView.ShengpinSkinWidth = 515.5
PetskinpreskinView.ShengpinSkinLineNum = 2
PetskinpreskinView.ShengPinQuality = 8
PetskinpreskinView.ShenHuaQuality = 10
PetskinpreskinView.QualityCount = 10
PetskinpreskinView.BaseHeight = PetskinpreskinView.TitleHeight + PetskinpreskinView.ProgressHeight
PetskinpreskinView.FilterType = {
	Get = 2,
	All = 1,
	NotGet = 3
}

function PetskinpreskinView:bindEvents()
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._BtnClear:AddClickListener(self._onClickBtnClear, self)
	self._btnFliterType:AddClickListener(self._onClickbtnSort, self)
	self._Cell3:AddClickListener(self._onClickCell3, self)
	self._Cell2:AddClickListener(self._onClickCell2, self)
	self._Cell1:AddClickListener(self._onClickCell1, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnFilter:AddClickListener(self._onClickbtnFilter, self)
end

function PetskinpreskinView:unbindEvents()
	self._inputSearch:RemoveOnValueChanged()
	self._BtnClear:RemoveClickListener()
	self._btnFliterType:RemoveClickListener()
	self._Cell3:RemoveClickListener()
	self._Cell2:RemoveClickListener()
	self._Cell1:RemoveClickListener()
	self._customInput:RemoveListener()
	self._btnFilter:RemoveClickListener()
end

function PetskinpreskinView:destroyUI()
	return
end

function PetskinpreskinView:buildUI()
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._scrollList:regGetCellSize(GameUtil.handler(self._cellSize, self))
	self._scrollList:regValueChanged(GameUtil.handler(self._onScrollValueChanged, self))

	self._scrollRect = self._tableviewGo:GetComponent(ComponentType.ScrollRect)
	self._tableviewWorldPos = self._tableviewGo.transform.position
	self._showQualitys = {}

	for i = 1, PetskinpreskinView.QualityCount do
		table.insert(self._showQualitys, i)
	end

	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
	self._BtnClear = self:getBtn("InputC_Search/BtnClear")
	self._btnFliterType = self:getBtn("btnFliterType")
	self._sortpanelGo = self:getGo("sortpanel")
	self._Cell3 = self:getBtn("sortpanel/content/Cell3")
	self._Cell2 = self:getBtn("sortpanel/content/Cell2")
	self._Cell1 = self:getBtn("sortpanel/content/Cell1")
	self._txtBtnFilterType = self:getTxt("btnFliterType/text")
	self._contentGo = self:getGo("sortpanel/content")
	self._customInput = UICustomInput.Get(self._contentGo)
	self._btnFilter = self:getBtn("btnFilter")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._slider = self:getSlider("progress/slider")
end

function PetskinpreskinView:onExit()
	self._scrollList:dispose()

	self._hadSkins = nil

	PetSkinlPreviewController.instance:endDrag()
end

function PetskinpreskinView:onEnter()
	self.addGEvent(self, PetskinpreView.NotifyClickSubTab, self._onNotifyClickSubTab, self)
	self.addGEvent(self, GlobalNotify.PetSkinDataInited, self._onPetSkinDataInited, self)

	self._skinList = self:_getInitSkinList()

	local params = self:getOpenParam()

	self._userId = checknumber(params[1])
	self._index = checknumber(params[2])
	self._bigCfg = PetskinpreviewConfig.instance:getBigTabCfgBySmallTabIndex(self._index)
	self._isOtherUser = self._userId > 0 and self._userId ~= checknumber(RoleModel.instance:getUserId())

	if self._userId ~= self._lastUserId then
		self._curSelectTabIndex = 1
		self._searchStr = ""
		self._filterType = PetskinpreskinView.FilterType.All
		self._needMoveOnFinish = true
		self._curShowQuality = -1

		self:_onClickBtnClear()
	end

	self._lastUserId = self._userId
	self._disableOnvalueChangeCheck = true

	if not self._curSelectTabIndex or self._curSelectTabIndex <= 0 then
		self._curSelectTabIndex = 1
	end

	self._searchStr = self._searchStr or ""
	self._filterType = self._filterType or PetskinpreskinView.FilterType.All

	goutil.setActive(self._sortpanelGo, false)
	self:_updateUI()

	if self._isOtherUser then
		PetskinController.instance:sendGetInfo(nil, self._userId)
	else
		PetskinController.instance:sendGetInfo()
	end
end

function PetskinpreskinView:_onPetSkinDataInited()
	PetSkinlPreviewController.instance:resetHadSkins()
	self:_updateUI()
end

function PetskinpreskinView:_updateUI()
	self._tabListForProgress = self:_createTabListForProgress()

	self:_getShowQuality()
	self:_reloadTabDatas()
	self:_setTxtBtnFilterType()
end

function PetskinpreskinView:_getInitSkinList()
	local list = {}
	local nowTime = ServerTime.now()
	local arr = PetbookModel.instance:getAllPetSkinList()

	for i, v in ipairs(arr) do
		local cfg = MaterialMgr.getMatCfg(MatType.Pet, v.raceId)
		local petDetail = HandbookConfig.instance:getPetDetailsCfgById(cfg.raceId)
		local isShow = PetbookModel.instance:_isShowByShowTime(v.skinId)

		if v.clientNotShow then
			local coId = checknumber(LoginModel.instance:getCoChannelId())

			for _, v2 in pairs(v.clientNotShow) do
				if coId == v2 then
					isShow = false

					break
				end
			end
		end

		if petDetail and petDetail.unproved == 0 and not string.nilorempty(cfg.bookIds) and PetbookModel.instance:_isPetOnline(cfg, nowTime) and isShow and v.isHide ~= 1 then
			table.insert(list, v)
		end
	end

	local finalList = {}

	for _, skinCfg in ipairs(list) do
		finalList[skinCfg.quality] = finalList[skinCfg.quality] or {}

		table.insert(finalList[skinCfg.quality], skinCfg)
	end

	return finalList
end

function PetskinpreskinView:_getShowQuality()
	if not self._curShowQuality or self._curShowQuality <= 0 then
		self._curShowQuality = -1

		for i = #self._showQualitys, 1, -1 do
			local skinQuality = self._showQualitys[i]

			if self._curShowQuality <= 0 then
				if #(self._skinList[skinQuality] or {}) > 0 then
					self._curShowQuality = i

					break
				end
			end
		end
	end

	return self._curShowQuality
end

function PetskinpreskinView:_reloadTabDatas()
	self._tabList = self:_createTabList()

	self._scrollList:reloadData(self._tabList)
end

function PetskinpreskinView:_createTabList()
	local q2i = self:_getSubTabQuality2IndexList()
	local tabList = {}

	for quality, skinCfgs in pairs(self._skinList) do
		local tabInfo = {}
		local skinProgress = 0

		for i, skinCfg in ipairs(skinCfgs) do
			if self:_isHadSkin(skinCfg.skinId) then
				skinProgress = skinProgress + 1
			end
		end

		tabInfo.name = ConstString.QualityToName[quality]
		tabInfo.quality = quality
		tabInfo.isShengpin = quality == PetskinpreskinView.ShengPinQuality or quality == PetskinpreskinView.ShenHuaQuality
		tabInfo.totalSkinCount = #skinCfgs
		tabInfo.skinProgress = skinProgress

		local filterSkinCfgs = self:_filterSkinCfgs(skinCfgs)

		tabInfo.skinCfgs = self:_sortSkinCfgs(filterSkinCfgs)

		if #tabInfo.skinCfgs > 0 and q2i[tabInfo.quality] then
			table.insert(tabList, tabInfo)
		end
	end

	table.sort(tabList, function(a, b)
		return q2i[a.quality] < q2i[b.quality]
	end)

	return tabList
end

function PetskinpreskinView:_getSubTabQuality2IndexList()
	if not self._subTabSortList then
		self._subTabSortList = {}

		local idx = 1

		for i, index in ipairs(self._bigCfg.childIndex) do
			local subCfg = PetskinpreviewConfig.instance:getSmallTabCfg(index)

			if subCfg.params then
				self._subTabSortList[subCfg.params.quality] = idx
				idx = idx + 1
			end
		end
	end

	return self._subTabSortList
end

function PetskinpreskinView:_createTabListForProgress()
	local tabList = {}

	for quality, skinCfgs in pairs(self._skinList) do
		local tabInfo = {}
		local skinProgress = 0

		for i, skinCfg in ipairs(skinCfgs) do
			if self:_isHadSkin(skinCfg.skinId) then
				skinProgress = skinProgress + 1
			end
		end

		tabInfo.quality = quality
		tabInfo.totalSkinCount = #skinCfgs
		tabInfo.skinProgress = skinProgress

		table.insert(tabList, tabInfo)
	end

	return tabList
end

function PetskinpreskinView:_filterSkinCfgs(skinCfgs)
	local list = {}

	for _, skinCfg in ipairs(skinCfgs) do
		local hasSkin = self:_isHadSkin(skinCfg.skinId)
		local isSearchMatch = string.nilorempty(self._searchStr) or string.find(skinCfg.skinName, self._searchStr)

		if isSearchMatch and (self._filterType == PetskinpreskinView.FilterType.All or self._filterType == PetskinpreskinView.FilterType.Get and hasSkin or self._filterType == PetskinpreskinView.FilterType.NotGet and not hasSkin) and self:_onFilter(skinCfg) then
			table.insert(list, skinCfg)
		end
	end

	return list
end

function PetskinpreskinView:_sortSkinCfgs(skinCfgs)
	local list = {}
	local notGetList = {}

	for i, v in ipairs(skinCfgs) do
		if self:_isHadSkin(v.skinId) then
			table.insert(list, v)
		else
			table.insert(notGetList, v)
		end
	end

	table.insertto(list, notGetList)

	return list
end

function PetskinpreskinView:_updateCell(view, cell, data, tag)
	local component = PetSkinPreviewCell.Get(cell.gameObject)

	component:init(data)
end

function PetskinpreskinView:_clearCell(cell)
	local component = PetSkinPreviewCell.Get(cell.gameObject)

	component:clear()
end

function PetskinpreskinView:_onReloadFinish()
	if self._needMoveOnFinish then
		self._needMoveOnFinish = false

		local moveIndex = -1

		for i, v in ipairs(self._tabList or {}) do
			if v.quality == self._curShowQuality then
				moveIndex = i

				break
			end
		end

		if moveIndex ~= -1 then
			self._scrollList:MoveCellToBegin(Mathf.Clamp(moveIndex - 1, 0, #self._tabList))
		end
	end

	self:_setProgress()
end

function PetskinpreskinView:_cellSize(view, index)
	local sizey = 500

	if self._tabList and self._tabList[index + 1] then
		local tabInfo = self._tabList[index + 1]

		if tabInfo.quality == PetskinpreskinView.ShengPinQuality and not PetSkinPreviewCell.ShowShengpingFullCell then
			return 1000, PetskinpreskinView.BaseHeight + PetskinpreskinView.ShengpinSkinHeight * 2
		end

		local totalCount = #tabInfo.skinCfgs

		if totalCount == 0 then
			sizey = 20
		elseif tabInfo.isShengpin then
			local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetskinpreskinView.ShengpinSkinLineNum) + 1

			sizey = PetskinpreskinView.ShengpinSkinHeight * lineNum
		else
			local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetskinpreskinView.SkinLineNum) + 1

			sizey = PetskinpreskinView.SkinHeight * lineNum
		end
	end

	if self._tabList and self._tabList[index + 1] and not self._tabList[index + 2] then
		sizey = sizey + PetskinpreskinView.ShengpinSkinHeight / 2
	end

	return 1000, PetskinpreskinView.BaseHeight + sizey
end

function PetskinpreskinView:_onScrollValueChanged(tableview)
	if self._disableOnvalueChangeCheck then
		if not PetSkinlPreviewController.instance:isDrag() then
			return
		else
			self._disableOnvalueChangeCheck = false
		end
	end

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

	if self._tabList[targetCellIndex] then
		self:_changeSelectTab(targetCellIndex)
	end
end

function PetskinpreskinView:_changeSelectTab(index)
	if self._curSelectTabIndex == index then
		return
	end

	self._curSelectTabIndex = index

	local tabInfo = self._tabList[index]

	if tabInfo then
		local params = {
			previewSkin = true,
			quality = tabInfo.quality
		}

		self._curShowQuality = tabInfo.quality

		self:_setProgress()
		GlobalDispatcher:dispatch(PetskinpreView.SelectSubTabWithParams, params, false)
	end
end

function PetskinpreskinView:_onNotifyClickSubTab(index)
	local cfg = PetskinpreviewConfig.instance:getSmallTabCfg(index)
	local hasMove = false

	for i, v in ipairs(self._tabList) do
		if v.quality == cfg.params.quality then
			if self._curShowQuality == v.quality then
				return
			end

			hasMove = true
			self._curSelectTabIndex = i
			self._curShowQuality = v.quality

			if not PetSkinlPreviewController.instance:isDrag() then
				self._disableOnvalueChangeCheck = true
			end

			self._scrollList:MoveCellToBegin(Mathf.Max(0, i - 1))

			break
		end
	end

	if not hasMove then
		self._curShowQuality = cfg.params.quality
	end

	self:_setProgress()
end

function PetskinpreskinView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if self._searchStr == text then
		return
	end

	self._searchStr = text

	PetSkinlPreviewController.instance:endDrag()

	self._needMoveOnFinish = true

	self:_reloadTabDatas()
end

function PetskinpreskinView:_onClickBtnClear()
	self._inputSearch:SetText("")
end

function PetskinpreskinView:_onClickbtnSort()
	goutil.setActive(self._sortpanelGo, true)
end

function PetskinpreskinView:_onClickCell3()
	self:_onCliclFilterType(PetskinpreskinView.FilterType.NotGet)
end

function PetskinpreskinView:_onClickCell2()
	self:_onCliclFilterType(PetskinpreskinView.FilterType.Get)
end

function PetskinpreskinView:_onClickCell1()
	self:_onCliclFilterType(PetskinpreskinView.FilterType.All)
end

function PetskinpreskinView:_onCliclFilterType(fType)
	goutil.setActive(self._sortpanelGo, false)

	self._filterType = fType

	self:_setTxtBtnFilterType()
	self:_reloadTabDatas()
end

function PetskinpreskinView:_setTxtBtnFilterType()
	local str = ""

	if self._filterType == PetskinpreskinView.FilterType.All then
		str = "全部"
	elseif self._filterType == PetskinpreskinView.FilterType.Get then
		str = "已拥有"
	elseif self._filterType == PetskinpreskinView.FilterType.NotGet then
		str = "未拥有"
	end

	self._txtBtnFilterType.text = str
end

function PetskinpreskinView:_isHadSkin(skinId)
	return PetSkinlPreviewController.instance:isHadSkin(skinId)
end

function PetskinpreskinView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._sortpanelGo, false)
	end
end

function PetskinpreskinView:_onClickbtnFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_SKIN_PREVIEW, pos, sizeDelta, GameUtil.handler(self._reloadTabDatas, self))
end

function PetskinpreskinView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PetskinpreskinView:_onFilter(skinCfg)
	local petCo = CharacterConfig.instance:getPetCo(skinCfg.raceId)

	return (PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_SKIN_PREVIEW, petCo, petCo.rare, skinCfg.skinId))
end

function PetskinpreskinView:_setProgress()
	if self._curShowQuality > 0 then
		for i, v in ipairs(self._tabListForProgress) do
			if v.quality == self._curShowQuality then
				self._txtProgress.text = string.format("<color=#2e395e><size=24>%s</size></color>/%s", v.skinProgress, v.totalSkinCount)

				self._slider:SetValue(v.skinProgress / v.totalSkinCount)

				break
			end
		end
	end
end

return PetskinpreskinView
