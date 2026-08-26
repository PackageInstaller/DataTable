-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewBeginnerView.lua

module("modules.logic.turnback.view.new.view.TurnbackNewBeginnerView", package.seeall)

local TurnbackNewBeginnerView = class("TurnbackNewBeginnerView", BaseView)

function TurnbackNewBeginnerView:onInitView()
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollcategoryitem = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_categoryitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._txttime = gohelper.findChildText(self.viewGO, "lefttitle/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewBeginnerView:addEvents()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshBeginner, self.refreshView, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
end

function TurnbackNewBeginnerView:removeEvents()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshBeginner, self.refreshView, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
end

local turnbackSubViewDict = {
	[TurnbackEnum.ActivityId.NewSignIn] = ViewName.TurnbackNewSignInView,
	[TurnbackEnum.ActivityId.NewTaskView] = ViewName.TurnbackNewTaskView,
	[TurnbackEnum.ActivityId.NewBenfitView] = ViewName.TurnbackNewBenfitView,
	[TurnbackEnum.ActivityId.NewProgressView] = ViewName.TurnbackNewProgressView,
	[TurnbackEnum.ActivityId.ReviewView] = ViewName.TurnbackReviewView
}

function TurnbackNewBeginnerView:_editableInitView()
	return
end

function TurnbackNewBeginnerView:onUpdateParam()
	return
end

function TurnbackNewBeginnerView:onOpen()
	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	self:refreshView()
end

function TurnbackNewBeginnerView:refreshView()
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

function TurnbackNewBeginnerView:openSubView()
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

function TurnbackNewBeginnerView:_refreshRemainTime()
	self._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function TurnbackNewBeginnerView:onClose()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end

	TurnbackModel.instance:setTargetCategoryId(0)
end

function TurnbackNewBeginnerView:onDestroyView()
	return
end

return TurnbackNewBeginnerView
