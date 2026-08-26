-- chunkname: @modules/logic/balanceumbrella/view/BalanceUmbrellaDungeonMapView.lua

module("modules.logic.balanceumbrella.view.BalanceUmbrellaDungeonMapView", package.seeall)

local BalanceUmbrellaDungeonMapView = class("BalanceUmbrellaDungeonMapView", BaseView)

function BalanceUmbrellaDungeonMapView:onInitView()
	self._btnunfull = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_unfull")
	self._btnfull = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_full")
	self._effect1 = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_unfull/vx_get")
	self._effect2 = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_full/vx_get")
end

function BalanceUmbrellaDungeonMapView:addEvents()
	self._btnunfull:AddClickListener(self._openBalanceUmbrellaView, self)
	self._btnfull:AddClickListener(self._openBalanceUmbrellaView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self.addEventCb(self, BalanceUmbrellaController.instance, BalanceUmbrellaEvent.ClueUpdate, self.checkBtnShow, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, BalanceUmbrellaController.instance, BalanceUmbrellaEvent.ShowGetEffect, self.showEffect, self)
end

function BalanceUmbrellaDungeonMapView:removeEvents()
	self._btnunfull:RemoveClickListener()
	self._btnfull:RemoveClickListener()
end

function BalanceUmbrellaDungeonMapView:_onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:checkBtnShow()
	end
end

function BalanceUmbrellaDungeonMapView:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:checkBtnShow()
	end
end

function BalanceUmbrellaDungeonMapView:_openBalanceUmbrellaView()
	ViewMgr.instance:openView(ViewName.BalanceUmbrellaView)
end

function BalanceUmbrellaDungeonMapView:refreshView()
	self._isEpisodeListShow = true
	self.chapterId = self.viewParam.chapterId

	if self.chapterId == DungeonEnum.ChapterId.Main1_7 then
		self:checkBtnShow()

		local allNewIds = BalanceUmbrellaModel.instance:getAllNewIds()

		for _, id in pairs(allNewIds) do
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BalanceUmbrellaClueView, {
				isGet = true,
				id = id
			})
		end

		BalanceUmbrellaModel.instance:markAllNewIds()
	else
		gohelper.setActive(self._btnfull, false)
		gohelper.setActive(self._btnunfull, false)
	end

	gohelper.setActive(self._effect1, false)
	gohelper.setActive(self._effect2, false)
end

function BalanceUmbrellaDungeonMapView:onOpen()
	self:refreshView()
end

function BalanceUmbrellaDungeonMapView:onUpdateParam()
	self:refreshView()
end

function BalanceUmbrellaDungeonMapView:showEffect()
	gohelper.setActive(self._effect1, true)
	gohelper.setActive(self._effect2, true)
	TaskDispatcher.runDelay(self._delayHideEffect, self, 1)
end

function BalanceUmbrellaDungeonMapView:_delayHideEffect()
	gohelper.setActive(self._effect1, false)
	gohelper.setActive(self._effect2, false)
end

function BalanceUmbrellaDungeonMapView:setEpisodeListVisible(value)
	self._isEpisodeListShow = value

	self:checkBtnShow()
end

function BalanceUmbrellaDungeonMapView:checkBtnShow()
	if self.chapterId ~= DungeonEnum.ChapterId.Main1_7 then
		return
	end

	local isViewOpen = ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
	local isFull = BalanceUmbrellaModel.instance:isGetAllClue()
	local haveOne = BalanceUmbrellaModel.instance:isHaveClue()

	gohelper.setActive(self._btnfull, isFull and not isViewOpen and self._isEpisodeListShow)
	gohelper.setActive(self._btnunfull, haveOne and not isFull and not isViewOpen and self._isEpisodeListShow)
end

function BalanceUmbrellaDungeonMapView:onClose()
	TaskDispatcher.cancelTask(self._delayHideEffect, self)
end

return BalanceUmbrellaDungeonMapView
