-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationsetdefenseView.lua

module("logic.extensions.formation.view.FormationsetdefenseView", package.seeall)

local FormationsetdefenseView = class("FormationsetdefenseView", ViewComponent)

FormationsetdefenseView.BaseContentHeight = 55
FormationsetdefenseView.OneCellHeight = 137
FormationsetdefenseView.LeftRootXMin = -2000
FormationsetdefenseView.LeftRootXMax = -172
FormationsetdefenseView.LeftRootY = -21.1
FormationsetdefenseView.SmallRootXMin = 0
FormationsetdefenseView.SmallRootXMax = 399
FormationsetdefenseView.SmallRootY = -135.6
FormationsetdefenseView.TweenTime = 0.2
FormationsetdefenseView.TabType = {
	Pk3v3 = 2,
	KingArea = 6,
	Dianfengsai = 5,
	Paiweisai2 = 4,
	Jingjichang = 1,
	Paiweisai1 = 3
}
FormationsetdefenseView.TabConst = {
	{
		tabName = "竞技场",
		tabType = FormationsetdefenseView.TabType.Jingjichang
	},
	{
		tabName = "3v3",
		tabType = FormationsetdefenseView.TabType.Pk3v3
	},
	{
		tabName = "经典排位",
		tabType = FormationsetdefenseView.TabType.Paiweisai1
	},
	{
		tabName = "极限排位",
		tabType = FormationsetdefenseView.TabType.Paiweisai2
	},
	{
		tabName = "巅峰赛",
		tabType = FormationsetdefenseView.TabType.Dianfengsai
	},
	{
		tabName = "王者竞技",
		tabType = FormationsetdefenseView.TabType.KingArea
	}
}

function FormationsetdefenseView:ctor()
	FormationsetdefenseView.super.ctor(self)

	self._cacheV3 = Vector3.New(0, 0, 0)
end

function FormationsetdefenseView:unbindEvents()
	FormationsetdefenseView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function FormationsetdefenseView:bindEvents()
	FormationsetdefenseView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function FormationsetdefenseView:buildUI()
	FormationsetdefenseView.super.buildUI(self)

	self._contentTr = self:getGo("smallroot/content").transform
	self._viewportTr = self:getGo("smallroot/content/tableview/viewport").transform
	self._tablecellGo = self:getGo("smallroot/content/tablecell")
	self._tableviewGo = self:getGo("smallroot/content/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("btnClose")
	self._tabItems = {}
	self._subScrollLists = {}
	self._leftrootGo = self:getGo("leftroot")
	self._smallrootGo = self:getGo("smallroot")
	self._smallRootTween = self:getGo("smallroot"):GetComponent(UnityTweensType.TweenPosition)
	self._leftRootTween = self:getGo("leftroot"):GetComponent(UnityTweensType.TweenPosition)

	self._smallRootTween:Stop()
	self._leftRootTween:Stop()

	self._btnSure = self:getBtn("smallroot/content/btnSure")
	self._tabtablecellGo = self:getGo("smallroot/content/tabtablecell")
	self._tabstableviewGo = self:getGo("smallroot/content/tabstableview")
	self._tabscrollerList = ScrollerList.create(self._tabstableviewGo, self._tabtablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function FormationsetdefenseView:onExit()
	FormationsetdefenseView.super.onExit(self)
	self._scrollerList:dispose()
	self._tabscrollerList:dispose()
	GameUtil.clickEnabled(true, self)
	self._smallRootTween:Stop()
	self._leftRootTween:Stop()
	FormationSetDefenseController.instance:clear()
end

function FormationsetdefenseView:onEnter()
	FormationsetdefenseView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OneKeySetDefenseRefreshView, self._updateView, self)
	self.addGEvent(self, GlobalNotify.OneKeySetDefenseSwithTabType, self._onOneKeySetDefenseSwithTabType, self)

	local params = self:getOpenParam() or {}

	self._tabType = params[1] or FormationsetdefenseView.TabType.Jingjichang
	self._onlySmall = true

	self:_updateUI()
	self:_onPlayTransitionDone()
end

function FormationsetdefenseView:_onClickbtnClose()
	self:close()
end

function FormationsetdefenseView:_onClickbtnSure()
	if FormationSetDefenseModel.instance:checkModify(self._tabType) then
		if FormationSetDefenseController.instance:sendModifyFormation(self._tabType, nil, nil, ViewName.FormationsetdefenseView) then
			self:close()
		end
	else
		FloatWordMgr.instance:show("当前阵型无变化")
		self:close()
	end
end

function FormationsetdefenseView:_updateUI()
	self:_updateTabs()
	self:_switchTab(self._tabType)
end

function FormationsetdefenseView:_updateTabs()
	local list = {}

	for i, v in ipairs(FormationsetdefenseView.TabConst) do
		local isOpen = true

		if v.tabType == FormationsetdefenseView.TabType.Dianfengsai then
			local actId = PeakTournamentController.instance:getCurActivityId()

			if actId <= 0 then
				isOpen = false
			end
		end

		if isOpen then
			table.insert(list, v)
		end
	end

	self._tabscrollerList:reloadData(list)
end

function FormationsetdefenseView:_switchTab(tabType, force)
	if not force and FormationSetDefenseModel.instance:checkModify(self._tabType) then
		local text = "当前防守阵容已更改，是否进行保存?"

		TipsFacade.instance:openPopupWindow("提示", text, function()
			FormationSetDefenseController.instance:sendModifyFormation(self._tabType, tabType)
		end, function()
			FormationSetDefenseController.instance:revertFormation(self._tabType)
			self:_switchTab(tabType)
		end)

		return
	end

	self._tabType = tabType
	self._selectIndex = 1

	FormationSetDefenseModel.instance:setCurrIndex(self._tabType, self._selectIndex)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSelectModifyTab)
	self:_updateTabs()
	self:_updateView(true)
end

function FormationsetdefenseView:_updateView(needSendMsgIfNotData)
	local positionsList = FormationSetDefenseModel.instance:getDefenseFmtPositions(self._tabType)

	if not positionsList then
		if needSendMsgIfNotData then
			FormationSetDefenseController.instance:sendGetData(self._tabType)
		end

		return
	end

	self._scrollerList:reloadData(positionsList)
	self:_modifyViewport(#positionsList)
end

function FormationsetdefenseView:_modifyViewport(len)
	local contentHeight = FormationsetdefenseView.BaseContentHeight + FormationsetdefenseView.OneCellHeight * len

	GameUtil.setHeight(self._contentTr, contentHeight)

	local viewportHeight = FormationsetdefenseView.OneCellHeight * len

	GameUtil.setHeight(self._viewportTr, viewportHeight)
end

function FormationsetdefenseView:_updateCell(view, cell, data, tag)
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local btnSet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSet")
	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")
	local goSelect = goutil.findChild(cell.gameObject, "bg/select")
	local scrollList = self._subScrollLists[cell]

	if not scrollList then
		scrollList = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateSubCell, self), GameUtil.handler(self._clearSubCell, self))
		self._subScrollLists[cell] = scrollList
	end

	local positionList = {}
	local positions = data.formationMo:GetPositions()

	for i = 1, 9 do
		local petId = checknumber(positions[i])

		if petId > 0 then
			table.insert(positionList, {
				pos = i,
				petId = petId
			})
		end
	end

	for i = #positionList + 1, 6 do
		table.insert(positionList, {
			pos = -1,
			petId = 0
		})
	end

	txtTitle.text = string.format("当前守阵-%s", data.index)

	goutil.setActive(btnSet.gameObject, data.index == 1)
	goutil.setActive(goSelect, self._selectIndex == data.index)
	scrollList:reloadData(positionList)
	btnSet:AddClickListener(self._onChangeViewMode, self)
	btnSelect:AddClickListener(GameUtil.handler(self._onClickCell, self, data))
end

function FormationsetdefenseView:_clearCell(cell)
	if self._subScrollLists[cell] then
		self._subScrollLists[cell]:dispose()
	end
end

function FormationsetdefenseView:_updateSubCell(view, cell, data, tag)
	local goEmpty = goutil.findChild(cell, "empty")

	MaterialMgr.resetAll(cell.gameObject)

	local petMo = BagModel.instance:getPet(data.petId)

	goutil.setActive(goEmpty, not petMo)

	if petMo then
		MaterialMgr.setCellByMo(petMo, cell.gameObject)
	end
end

function FormationsetdefenseView:_clearSubCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FormationsetdefenseView:_onChangeViewMode()
	self._onlySmall = not self._onlySmall

	self:_playTransition(self._onlySmall)
end

function FormationsetdefenseView:_playTransition(nextOnlyShowSmall)
	GameUtil.clickEnabled(false, self)

	if nextOnlyShowSmall then
		self._cacheV3.x = FormationsetdefenseView.LeftRootXMax
		self._cacheV3.y = FormationsetdefenseView.LeftRootY
		self._cacheV3.z = 0
		self._leftRootTween.from = self._cacheV3
		self._cacheV3.x = FormationsetdefenseView.LeftRootXMin
		self._cacheV3.y = FormationsetdefenseView.LeftRootY
		self._cacheV3.z = 0
		self._leftRootTween.to = self._cacheV3
		self._cacheV3.x = FormationsetdefenseView.SmallRootXMax
		self._cacheV3.y = FormationsetdefenseView.SmallRootY
		self._cacheV3.z = 0
		self._smallRootTween.from = self._cacheV3
		self._cacheV3.x = FormationsetdefenseView.SmallRootXMin
		self._cacheV3.y = FormationsetdefenseView.SmallRootY
		self._cacheV3.z = 0
		self._smallRootTween.to = self._cacheV3
	else
		self._cacheV3.x = FormationsetdefenseView.LeftRootXMin
		self._cacheV3.y = FormationsetdefenseView.LeftRootY
		self._cacheV3.z = 0
		self._leftRootTween.from = self._cacheV3
		self._cacheV3.x = FormationsetdefenseView.LeftRootXMax
		self._cacheV3.y = FormationsetdefenseView.LeftRootY
		self._cacheV3.z = 0
		self._leftRootTween.to = self._cacheV3
		self._cacheV3.x = FormationsetdefenseView.SmallRootXMin
		self._cacheV3.y = FormationsetdefenseView.SmallRootY
		self._cacheV3.z = 0
		self._smallRootTween.from = self._cacheV3
		self._cacheV3.x = FormationsetdefenseView.SmallRootXMax
		self._cacheV3.y = FormationsetdefenseView.SmallRootY
		self._cacheV3.z = 0
		self._smallRootTween.to = self._cacheV3
	end

	self._smallRootTween:AddListener(self._onPlayTransitionDone, self)

	self._leftRootTween.time = FormationsetdefenseView.TweenTime
	self._smallRootTween.time = FormationsetdefenseView.TweenTime

	self._leftRootTween:Begin()
	self._smallRootTween:Begin()
end

function FormationsetdefenseView:_onPlayTransitionDone()
	self._leftRootTween:Stop()
	self._smallRootTween:Stop()

	if self._onlySmall then
		Framework.TransformUtil.SetLocalPos(self._leftrootGo.transform, FormationsetdefenseView.LeftRootXMin, FormationsetdefenseView.LeftRootY, 0)
		Framework.TransformUtil.SetLocalPos(self._smallrootGo.transform, FormationsetdefenseView.SmallRootXMin, FormationsetdefenseView.SmallRootY, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._leftrootGo.transform, FormationsetdefenseView.LeftRootXMax, FormationsetdefenseView.LeftRootY, 0)
		Framework.TransformUtil.SetLocalPos(self._smallrootGo.transform, FormationsetdefenseView.SmallRootXMax, FormationsetdefenseView.SmallRootY, 0)
	end

	GameUtil.clickEnabled(true, self)
end

function FormationsetdefenseView:_onClickCell(data)
	self._selectIndex = data.index

	self._scrollerList:refresh()
	FormationSetDefenseModel.instance:setCurrIndex(self._tabType, data.index)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSelectModifyTab)
end

function FormationsetdefenseView:_updateTabCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local change = cell:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.tabName

	change:SetState(self._tabType == data.tabType and 0 or 1)
	btn:AddClickListener(function()
		self:_switchTab(data.tabType)
	end)
end

function FormationsetdefenseView:_clearTabCell(cell)
	return
end

function FormationsetdefenseView:_onOneKeySetDefenseSwithTabType(tabType)
	self:_switchTab(tabType, true)
end

return FormationsetdefenseView
