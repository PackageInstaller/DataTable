-- chunkname: @modules/logic/investigate/view/InvestigateDungeonMapView.lua

module("modules.logic.investigate.view.InvestigateDungeonMapView", package.seeall)

local InvestigateDungeonMapView = class("InvestigateDungeonMapView", BaseView)

function InvestigateDungeonMapView:onInitView()
	self._btnunfull = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_rightbtns/#btn_investigate_unfull")
	self._btnfull = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_rightbtns/#btn_investigate_full")
	self._effect1 = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_investigate_unfull/vx_get")
	self._effect2 = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_investigate_full/vx_get")
	self._goredpoint = gohelper.findChild(self.viewGO, "#go_main/#go_rightbtns/#btn_investigate_full/#go_giftredpoint")

	RedDotController.instance:addRedDot(self._goredpoint, RedDotEnum.DotNode.InvestigateTask)
end

function InvestigateDungeonMapView:addEvents()
	self._btnunfull:AddClickListener(self._openInvestigateView, self)
	self._btnfull:AddClickListener(self._openInvestigateView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.ClueUpdate, self.checkBtnShow, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.ShowGetEffect, self.showEffect, self)
end

function InvestigateDungeonMapView:removeEvents()
	self._btnunfull:RemoveClickListener()
	self._btnfull:RemoveClickListener()
end

function InvestigateDungeonMapView:_onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:checkBtnShow()
	end
end

function InvestigateDungeonMapView:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:checkBtnShow()
	end
end

function InvestigateDungeonMapView:_openInvestigateView()
	InvestigateController.instance:openInvestigateView()
end

function InvestigateDungeonMapView:refreshView()
	self._isEpisodeListShow = true
	self.chapterId = self.viewParam.chapterId

	if self.chapterId == DungeonEnum.ChapterId.Main1_8 then
		if not InvestigateOpinionModel.instance:getIsInitOpinionInfo() then
			InvestigateRpc.instance:sendGetInvestigateRequest()
		end

		self:checkBtnShow()

		local allNewIds = InvestigateModel.instance:getAllNewIds()

		for _, id in pairs(allNewIds) do
			local co = lua_investigate_info.configDict[id]

			if co and co.entrance ~= 0 then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.InvestigateClueView, {
					isGet = true,
					id = id
				})
			end
		end

		InvestigateModel.instance:markAllNewIds()
	else
		gohelper.setActive(self._btnfull, false)
		gohelper.setActive(self._btnunfull, false)
	end

	gohelper.setActive(self._effect1, false)
	gohelper.setActive(self._effect2, false)
end

function InvestigateDungeonMapView:onOpen()
	self:refreshView()
end

function InvestigateDungeonMapView:onUpdateParam()
	self:refreshView()
end

function InvestigateDungeonMapView:showEffect()
	gohelper.setActive(self._effect1, true)
	gohelper.setActive(self._effect2, true)
	TaskDispatcher.runDelay(self._delayHideEffect, self, 1)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_qiutu_list_maintain)
end

function InvestigateDungeonMapView:_delayHideEffect()
	gohelper.setActive(self._effect1, false)
	gohelper.setActive(self._effect2, false)
end

function InvestigateDungeonMapView:setEpisodeListVisible(value)
	self._isEpisodeListShow = value

	self:checkBtnShow()
end

function InvestigateDungeonMapView:checkBtnShow()
	if self.chapterId ~= DungeonEnum.ChapterId.Main1_8 then
		return
	end

	local isViewOpen = ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
	local haveOne = InvestigateModel.instance:isHaveClue()

	gohelper.setActive(self._btnfull, haveOne and not isViewOpen and self._isEpisodeListShow)
end

function InvestigateDungeonMapView:onClose()
	TaskDispatcher.cancelTask(self._delayHideEffect, self)
end

return InvestigateDungeonMapView
