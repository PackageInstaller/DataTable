-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapView.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapView", package.seeall)

local VersionActivityDungeonMapView = class("VersionActivityDungeonMapView", BaseView)

function VersionActivityDungeonMapView:onInitView()
	self._topLeftGo = gohelper.findChild(self.viewGO, "top_left")
	self._topRightGo = gohelper.findChild(self.viewGO, "#go_topright")
	self._topLeftElementGo = gohelper.findChild(self.viewGO, "top_left_element")
	self._goversionactivity = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity")
	self._gomain = gohelper.findChild(self.viewGO, "#go_main")
	self._gores = gohelper.findChild(self.viewGO, "#go_res")
	self._btnequipstore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_equipstore")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitystore")
	self._btnactivitytask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitytask")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._scrollcontent = gohelper.findChild(self.viewGO, "#scroll_content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityDungeonMapView:addEvents()
	self._btnactivitystore:AddClickListener(self.btnActivityStoreOnClick, self)
	self._btnactivitytask:AddClickListener(self.btnActivityTaskOnClick, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
end

function VersionActivityDungeonMapView:removeEvents()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
end

function VersionActivityDungeonMapView:btnActivityStoreOnClick()
	VersionActivityController.instance:openLeiMiTeBeiStoreView(VersionActivityEnum.ActivityId.Act113)
end

function VersionActivityDungeonMapView:btnActivityTaskOnClick()
	VersionActivityController.instance:openLeiMiTeBeiTaskView()
end

function VersionActivityDungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapLevelView)
end

function VersionActivityDungeonMapView:_editableInitView()
	gohelper.setActive(self._goversionactivity, true)
	gohelper.setActive(self._btnactivitystore.gameObject, false)
	gohelper.setActive(self._btnactivitytask.gameObject, false)
	gohelper.setActive(self._gomain, false)
	gohelper.setActive(self._gores, false)
	gohelper.setActive(self._btnequipstore.gameObject, false)

	self.modeAnimator = self._goversionactivity:GetComponent(typeof(UnityEngine.Animator))
	self.txtTaskGet = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitytask/#txt_get")
	self.goTaskRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")

	RedDotController.instance:addRedDot(self.goTaskRedDot, RedDotEnum.DotNode.LeiMiTeBeiTask)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTaskUI, self)
	gohelper.removeUIClickAudio(self._btncloseview.gameObject)

	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
end

function VersionActivityDungeonMapView:onUpdateParam()
	self:refreshUI()
end

function VersionActivityDungeonMapView:_onEscBtnClick()
	self:closeThis()
end

function VersionActivityDungeonMapView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self:refreshUI()
	NavigateMgr.instance:addEscape(ViewName.VersionActivityDungeonMapView, self._onEscBtnClick, self)

	if ViewMgr.instance:isOpen(ViewName.VersionActivityDungeonMapLevelView) then
		self:_onOpenView(ViewName.VersionActivityDungeonMapLevelView)
	end
end

function VersionActivityDungeonMapView:refreshUI()
	self:refreshTaskUI()
	self:refreshActivityCurrency()
end

function VersionActivityDungeonMapView:refreshTaskUI()
	self.txtTaskGet.text = string.format("%s/%s", self:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivityEnum.ActivityId.Act113))
end

function VersionActivityDungeonMapView:refreshActivityCurrency()
	local currencyId = ReactivityModel.instance:getActivityCurrencyId(VersionActivityEnum.ActivityId.Act113)
	local currencyMO = CurrencyModel.instance:getCurrency(currencyId)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivityDungeonMapView:getFinishTaskCount()
	local finishTaskCount = 0
	local taskMo

	for _, taskCo in ipairs(VersionActivityConfig.instance:getAct113TaskList(VersionActivityEnum.ActivityId.Act113)) do
		taskMo = TaskModel.instance:getTaskById(taskCo.id)

		if taskMo and taskMo.finishCount >= taskCo.maxFinishCount then
			finishTaskCount = finishTaskCount + 1
		end
	end

	return finishTaskCount
end

function VersionActivityDungeonMapView:_setEpisodeListVisible(value)
	gohelper.setActive(self._topLeftGo, value)

	if value then
		self.modeAnimator:Play(UIAnimationName.Open, 0, 0)
	else
		self.modeAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function VersionActivityDungeonMapView:_onOpenView(viewName)
	if viewName == ViewName.VersionActivityDungeonMapLevelView then
		self.modeAnimator:Play(UIAnimationName.Close, 0, 0)
		gohelper.setActive(self._btncloseview, true)

		self._rectmask2D.padding = Vector4(0, 0, 600, 0)
	end
end

function VersionActivityDungeonMapView:_onCloseView(viewName)
	if viewName == ViewName.VersionActivityDungeonMapLevelView then
		self.modeAnimator:Play(UIAnimationName.Open, 0, 0)
		gohelper.setActive(self._btncloseview, false)

		self._rectmask2D.padding = Vector4(0, 0, 0, 0)
	end
end

function VersionActivityDungeonMapView:onClose()
	return
end

function VersionActivityDungeonMapView:onDestroyView()
	return
end

return VersionActivityDungeonMapView
