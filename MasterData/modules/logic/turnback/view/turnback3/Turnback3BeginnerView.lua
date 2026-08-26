-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BeginnerView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BeginnerView", package.seeall)

local Turnback3BeginnerView = class("Turnback3BeginnerView", BaseView)

function Turnback3BeginnerView:onInitView()
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollcategoryitem = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_categoryitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._txttime = gohelper.findChildText(self.viewGO, "lefttitle/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BeginnerView:addEvents()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshBeginner, self.refreshView, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
end

function Turnback3BeginnerView:removeEvents()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshBeginner, self.refreshView, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
end

function Turnback3BeginnerView:_editableInitView()
	self._turnbackSubViewDict = {
		[TurnbackEnum.ActivityId.Turnback3SignInView] = ViewName.Turnback3SignInView,
		[TurnbackEnum.ActivityId.Turnback3BPView] = ViewName.Turnback3BpView,
		[TurnbackEnum.ActivityId.Turnback3DoubleView] = ViewName.Turnback3DoubleView,
		[TurnbackEnum.ActivityId.Turnback3StoreView] = ViewName.Turnback3StoreView,
		[TurnbackEnum.ActivityId.Turnback3ProgressView] = ViewName.Turnback4ProgressView,
		[TurnbackEnum.ActivityId.Turnback3ReviewView] = ViewName.TurnbackReviewView
	}
end

function Turnback3BeginnerView:onUpdateParam()
	return
end

function Turnback3BeginnerView:onOpen()
	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	self:refreshView()

	if TurnbackModel.instance:haveOnceBonusReward() then
		ViewMgr.instance:openView(ViewName.Turnback3PanelView)
	end
end

function Turnback3BeginnerView:refreshView()
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
end

function Turnback3BeginnerView:openSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)
	end

	local actId = TurnbackModel.instance:getTargetCategoryId(self.turnbackId)

	self._viewName = self._turnbackSubViewDict[actId]

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

function Turnback3BeginnerView:_refreshRemainTime()
	self._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function Turnback3BeginnerView:onClose()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end

	TurnbackModel.instance:setTargetCategoryId(0)
end

function Turnback3BeginnerView:onDestroyView()
	return
end

return Turnback3BeginnerView
