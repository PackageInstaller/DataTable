-- chunkname: @modules/logic/turnback/view/TurnbackBeginnerView.lua

module("modules.logic.turnback.view.TurnbackBeginnerView", package.seeall)

local TurnbackBeginnerView = class("TurnbackBeginnerView", BaseView)

function TurnbackBeginnerView:onInitView()
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollcategoryitem = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_categoryitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._txttime = gohelper.findChildText(self.viewGO, "lefttitle/#txt_time")
	self._gomonthcard = gohelper.findChild(self.viewGO, "#go_monthcard")
	self._simagemonthcardicon = gohelper.findChildSingleImage(self.viewGO, "#go_monthcard/#simage_monthcard")
	self._btnmonthcard = gohelper.findChildButton(self.viewGO, "#go_monthcard/#btn_monthcard")
	self._txtmonthcard = gohelper.findChildText(self.viewGO, "#go_monthcard/#simage_monthcard/#txt_monthcard")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackBeginnerView:addEvents()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshBeginner, self.refreshView, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._onChargeBuySuccess, self)
	self._btnmonthcard:AddClickListener(self.onClickMonthCard, self)
end

function TurnbackBeginnerView:removeEvents()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshBeginner, self.refreshView, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._onChargeBuySuccess, self)
	self._btnmonthcard:RemoveClickListener()
end

local turnbackSubViewDict = {
	[TurnbackEnum.ActivityId.SignIn] = ViewName.TurnbackSignInView,
	[TurnbackEnum.ActivityId.TaskView] = ViewName.TurnbackTaskView,
	[TurnbackEnum.ActivityId.DungeonShowView] = ViewName.TurnbackDungeonShowView,
	[TurnbackEnum.ActivityId.RewardShowView] = ViewName.TurnbackRewardShowView,
	[TurnbackEnum.ActivityId.RecommendView] = ViewName.TurnbackRecommendView
}

function TurnbackBeginnerView:_editableInitView()
	return
end

function TurnbackBeginnerView:onClickMonthCard()
	if TurnbackModel.instance:getMonthCardShowState() == false then
		return
	end

	logNormal("onClickMonthCard")

	local turnBackMo = TurnbackModel.instance:getCurTurnbackMo()
	local config = turnBackMo.config
	local storePackageMo = StoreModel.instance:getGoodsMO(config.monthCardAddedId)

	StoreController.instance:openPackageStoreGoodsView(storePackageMo)
end

function TurnbackBeginnerView:onUpdateParam()
	return
end

function TurnbackBeginnerView:onOpen()
	self.turnbackId = self.viewParam.turnbackId

	self:refreshView()
end

function TurnbackBeginnerView:refreshView()
	self.allActivityTab = TurnbackConfig.instance:getAllTurnbackSubModules(self.turnbackId)

	if self.allActivityTab == nil or GameUtil.getTabLen(self.allActivityTab) == 0 then
		self:closeThis()
	end

	self.allActivityTab = TurnbackModel.instance:removeUnExitCategory(self.allActivityTab)
	self.subViewTab = {}

	for index, v in pairs(self.allActivityTab) do
		local o = {}

		o.id = v
		o.order = index
		o.config = TurnbackConfig.instance:getTurnbackSubModuleCo(v)

		table.insert(self.subViewTab, o)
	end

	TurnbackBeginnerCategoryListModel.instance:setOpenViewTime()
	TurnbackBeginnerCategoryListModel.instance:setCategoryList(self.subViewTab)
	self:openSubView()
	self:_refreshRemainTime()
	self:_refreshMonthCardState()
end

function TurnbackBeginnerView:openSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)
	end

	local actId = TurnbackModel.instance:getTargetCategoryId(self.turnbackId)

	self._viewName = turnbackSubViewDict[actId]

	if actId ~= 0 then
		TurnbackModel.instance:setTargetCategoryId(actId)
	end

	local viewParam = {
		parent = self._gosubview,
		actId = actId
	}

	ViewMgr.instance:openView(self._viewName, viewParam, true)

	self.viewParam = nil
end

function TurnbackBeginnerView:_refreshRemainTime()
	self._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function TurnbackBeginnerView:_onChargeBuySuccess()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.onGetTurnBackInfo, self)
end

function TurnbackBeginnerView:onGetTurnBackInfo()
	self:_refreshMonthCardState()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.onGetTurnBackInfo, self)
end

function TurnbackBeginnerView:_refreshMonthCardState()
	local showMonthCard = TurnbackModel.instance:getMonthCardShowState()

	gohelper.setActive(self._gomonthcard, showMonthCard)
end

function TurnbackBeginnerView:onClose()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end

	TurnbackModel.instance:setTargetCategoryId(0)
end

function TurnbackBeginnerView:onDestroyView()
	return
end

return TurnbackBeginnerView
