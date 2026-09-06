-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/PetChallengeView.lua

module("logic.extensions.legend.view.PetChallengeView", package.seeall)

local PetChallengeView = class("PetChallengeView", ViewComponent)

function PetChallengeView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnALL = self:getBtn("filter/btnALL")
	self._btnSSR = self:getBtn("filter/btnSSR")
	self._btnSR = self:getBtn("filter/btnSR")
	self._btnExplain = self:getBtn("btnExplain")
	self._changeAll = goutil.findChildComponent(self.mainGO, "filter/btnALL", "UIChangeGroup")
	self._changeSSR = goutil.findChildComponent(self.mainGO, "filter/btnSSR", "UIChangeGroup")
	self._changeSR = goutil.findChildComponent(self.mainGO, "filter/btnSR", "UIChangeGroup")
	self._tableview = self:getGo("scrollList"):GetComponent("UITableview")
	self._tableCell = self:getGo("scrollList/item")

	self._tableCell:SetActive(false)

	self._scrollRectAdapter = Framework.ScrollRectAdapter.GetFrom(self.mainGO, "scrollList")
	self._scrollRectTrans = goutil.findChildRectTransformComponent(self.mainGO, "scrollList")
	self._contentRectTrans = goutil.findChildRectTransformComponent(self.mainGO, "scrollList/viewport/content")
	self._goldBarCon = self:getGo("goldBarCon")
	self._scrollWidth = self._scrollRectTrans.rect.width
	self._offsetX = self._tableview.cellOffset.x
	self._spacingX = self._tableview.cellSpacing.x
	self._itemWidth = 236
	self._itemHeight = 428
end

function PetChallengeView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnALL:AddClickListener(function()
		self:_onClickFilter(0)
	end)
	self._btnSSR:AddClickListener(function()
		self:_onClickFilter(GameEnum.PetRare.SSR)
	end)
	self._btnSR:AddClickListener(function()
		self:_onClickFilter(GameEnum.PetRare.SR)
	end)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
end

function PetChallengeView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnALL:RemoveClickListener()
	self._btnSSR:RemoveClickListener()
	self._btnSR:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
end

function PetChallengeView:onEnter()
	GlobalDispatcher:addListener(MopupModel.SweepSuccessed, self._setChallengeCount, self)

	local param = self:getFirstParam()

	self._isFirst = true
	self._targetChallengeId = nil

	if param and param.challengeId then
		printInfo("test PetChallengeView", param.challengeId)

		self._targetChallengeId = param.challengeId
	else
		printInfo("test PetChallengeView 沒有传入参数challengeId")
	end

	self:_initScrollList()
	self:_onClickFilter(0)
	self:_setGoldBar()
end

function PetChallengeView:onExit()
	GlobalDispatcher:removeListener(MopupModel.SweepSuccessed, self._setChallengeCount, self)
	self:_disposeScrollList()
end

function PetChallengeView:_onClickClose()
	self:close()
end

function PetChallengeView:_onClickExplain()
	local cfgKey = "legendviewtip"

	ViewMgr.instance:open(ViewName.RulesView, cfgKey)
end

function PetChallengeView:_onClickFilter(filterType)
	self:_updateFilterBtns(filterType)
	self:_updateCurViewDatas(filterType)
	self._tableview:ReloadData()
end

function PetChallengeView:_initScrollList()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish, self)

	self._curViewDatas = {}
end

function PetChallengeView:_updateFilterBtns(filterType)
	if filterType == GameEnum.PetRare.SSR then
		self._changeAll:SetState(0)
		self._changeSSR:SetState(1)
		self._changeSR:SetState(0)
	elseif filterType == GameEnum.PetRare.SR then
		self._changeAll:SetState(0)
		self._changeSSR:SetState(0)
		self._changeSR:SetState(1)
	else
		self._changeAll:SetState(1)
		self._changeSSR:SetState(0)
		self._changeSR:SetState(0)
	end
end

function PetChallengeView:_updateCurViewDatas(filterType)
	table.clear(self._curViewDatas)

	local legendCfgs = LegendConfig.instance:getLegendChallengeCfgs()

	for i, cfg in ipairs(legendCfgs) do
		local element = {}

		element.cfg = cfg

		local rare = self:_getRareByCfg(cfg.raceId)

		if self:_isMatchType(filterType, rare) then
			table.insert(self._curViewDatas, element)
		end
	end
end

function PetChallengeView:_isMatchType(filterType, rare)
	if filterType == 0 then
		return true
	end

	return filterType == rare
end

function PetChallengeView:_getRareByCfg(raceId)
	local petCo = CharacterConfig.instance:getPetCo(raceId)

	if not petCo then
		return 0
	end

	return petCo.rare
end

function PetChallengeView:_disposeScrollList()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function PetChallengeView:_numInView()
	return #self._curViewDatas
end

function PetChallengeView:_cellSize(view, idx)
	return self._itemWidth, self._itemHeight
end

function PetChallengeView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function PetChallengeView:_updateCell(view, cell, data)
	local component = PetChallengeItem.AddOnce(cell.gameObject)

	component:init(data)
end

function PetChallengeView:_clearTableview(cell)
	if cell then
		local component = PetChallengeItem.AddOnce(cell.gameObject)

		component:reset()
	end
end

function PetChallengeView:_onReloadFinish()
	self:_setInitPos()
end

function PetChallengeView:_setInitPos()
	if not self._isFirst then
		return
	end

	self._isFirst = false

	if self._targetChallengeId and self._targetChallengeId <= 0 then
		return
	end

	local index = self:_getCfgIndex(self._targetChallengeId)

	if index then
		local totalWidth = self._contentRectTrans.rect.width - self._scrollWidth

		totalWidth = totalWidth > self._scrollWidth and totalWidth or self._scrollWidth

		local curWidth = self._offsetX + (index - 1) * (self._itemWidth + self._spacingX)

		self._scrollRectAdapter.scrollRect.horizontalNormalizedPosition = curWidth / totalWidth
	else
		self._scrollRectAdapter.scrollRect.horizontalNormalizedPosition = 0
	end
end

function PetChallengeView:_getCfgIndex(challengeId)
	local index

	for i, v in ipairs(self._curViewDatas) do
		if challengeId == v.cfg.challengeId then
			index = i
		end
	end

	return index
end

function PetChallengeView:_setGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = GameEnum.GoldType.Tili
	})
	table.insert(btn_list, {
		showAdd = true,
		id = GameEnum.GoldType.SweepTicket
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function PetChallengeView:_setChallengeCount()
	self._tableview:ReloadData()
end

return PetChallengeView
