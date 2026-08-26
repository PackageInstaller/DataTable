-- chunkname: @modules/logic/rouge/view/RougeOpenGuideView.lua

module("modules.logic.rouge.view.RougeOpenGuideView", package.seeall)

local RougeOpenGuideView = class("RougeOpenGuideView", BaseView)

function RougeOpenGuideView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_look")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate1")
	self._simagedecorate3 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeOpenGuideView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function RougeOpenGuideView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function RougeOpenGuideView:_btnlookOnClick()
	TaskDispatcher.cancelTask(self._delayClick, self)
	TaskDispatcher.runDelay(self._delayClick, self, 0.015)
end

function RougeOpenGuideView:_delayClick()
	if ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.GuideTransitionBlackView)
	else
		ViewMgr.instance:closeAllPopupViews()
	end

	JumpController.instance:jumpTo("5#1")
end

function RougeOpenGuideView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	self._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	self._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function RougeOpenGuideView:onUpdateParam()
	return
end

function RougeOpenGuideView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)

	local openEpisodeId = lua_open.configDict[OpenEnum.UnlockFunc.EquipDungeon].episodeId
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(openEpisodeId)
	local bonusCfg = lua_bonus.configDict[episodeCfg.firstBonus]
	local params = string.splitToNumber(bonusCfg.fixBonus, "#")

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function RougeOpenGuideView:_onOpenViewFinish(viewName)
	return
end

function RougeOpenGuideView:_onCloseViewFinish(viewName)
	if viewName == ViewName.RougeOpenGuideView then
		ViewMgr.instance:closeView(ViewName.GuideTransitionBlackView)
	end
end

function RougeOpenGuideView:onOpenFinish()
	return
end

function RougeOpenGuideView:onClose()
	TaskDispatcher.cancelTask(self._delayClick, self)
end

function RougeOpenGuideView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate3:UnLoadImage()
end

return RougeOpenGuideView
