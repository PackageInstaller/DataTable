-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/TabPTEliBaseMainView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.TabPTEliBaseMainView", package.seeall)

local TabPTEliBaseMainView = class("TabPTEliBaseMainView", TabFrameWorkMainView)

function TabPTEliBaseMainView:buildUI()
	TabPTEliBaseMainView.super.buildUI(self)

	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._testCol = goutil.findChild(self.mainGO, "testCol")
	self._txtCurRound = goutil.findChildTextComponent(self.mainGO, "testCol/txtCurRound/txt")
	self._txtCurPeriod = goutil.findChildTextComponent(self.mainGO, "testCol/txtCurPeriod/txt")
	self._txtCurTime = goutil.findChildTextComponent(self.mainGO, "testCol/txtCurTime/txt")
	self._txtPeriodEndTime = goutil.findChildTextComponent(self.mainGO, "testCol/txtPeriodEndTime/txt")
	self._txtRemainTime = goutil.findChildTextComponent(self.mainGO, "testCol/txtRemainTime/txt")
end

function TabPTEliBaseMainView:bindEvents()
	TabPTEliBaseMainView.super.bindEvents(self)
end

function TabPTEliBaseMainView:unbindEvents()
	TabPTEliBaseMainView.super.unbindEvents(self)
end

function TabPTEliBaseMainView:onEnter()
	self._ptActivityId = PeakTournamentController.instance:getCurActivityId()

	if self._ptActivityId == 0 then
		FloatWordMgr.instance:show("巅峰赛未开启")
		self:close()

		return
	end

	self._eliRoundCfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(self._ptActivityId)
	self._eliminatorMgr = PeakTournamentController.instance:eliminatorMgrOnEnter(self._ptActivityId)

	GlobalDispatcher:addListener(GlobalNotify.EliminatorMgrNotifyChangeNewEliRound, self._onUpdate, self)

	local goldBarList = PeakTournamentController.instance:getGoldBarList(self._ptActivityId)

	if #goldBarList > 0 then
		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, goldBarList)
	end

	self._curHeadTabIndex = 0
	self._isInitView = false

	TabPTEliBaseMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PeakJumpToTabVote, self._onJumpToVote, self)
end

function TabPTEliBaseMainView:onExit()
	TabPTEliBaseMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EliminatorMgrNotifyChangeNewEliRound, self._onUpdate, self)
	PeakTournamentController.instance:eliminatorMgrOnExit()

	self._eliminatorMgr = nil
end

function TabPTEliBaseMainView:destroyUI()
	TabPTEliBaseMainView.super.destroyUI(self)
	PeakTournamentController.instance:eliminatorMgrOnDestory()
end

function TabPTEliBaseMainView:_onJumpToVote()
	local tab = 2

	self:_clickHeadTabCell(tab)
	self:moveToVerticalCenter(tab, 0)
end

function TabPTEliBaseMainView:_getFrameId()
	return PeakTournamentConfig.instance:getEliminatorBaseFrameId()
end

function TabPTEliBaseMainView:_onTicking()
	return
end

function TabPTEliBaseMainView:_onClickBtnTip()
	local ruleKey = PeakTournamentConfig.instance:getPtCommonValue("PT_ELIMINATOR_RULE")

	if not string.nilorempty(ruleKey) then
		TipsFacade.instance:openRulesView(ruleKey)
	end

	self:moveToVerticalCenter(self._curHeadTabIndex, self._curSecTabIndex)
end

function TabPTEliBaseMainView:_isUnlockByExCondAsHeadTab(headTabId)
	return self:_isUnlockHeadTabByEliRoundOpen(headTabId)
end

function TabPTEliBaseMainView:_getHeadTabLockTipsByExCond(tabIndex)
	local info = self:_getHeadTabViewInfo(tabIndex)

	if not self:_isUnlockHeadTabByEliRoundOpen(info.data.headTabId) then
		return "赛程未开启"
	else
		return ""
	end
end

function TabPTEliBaseMainView:_onUpdateUIEx()
	TabPTEliBaseMainView.super._onUpdateUIEx(self)

	if self._isInitView == false then
		settimer(0.1, function(...)
			self:moveToVerticalCenter(self._curHeadTabIndex, self._curSecTabIndex)
		end, self, false)

		self._isInitView = true
	end
end

function TabPTEliBaseMainView:_isUnlockHeadTabByEliRoundOpen(headTabId)
	local isUnlock = false
	local eliRoundIdList = self:_getEliRoundIdListInTab(headTabId)

	if #eliRoundIdList == 0 then
		isUnlock = true
	else
		local newestEliRoundId = self._eliminatorMgr:getNewestEliRoundId()

		for _, eliRoundId in ipairs(eliRoundIdList) do
			if eliRoundId <= newestEliRoundId then
				isUnlock = true
			end
		end
	end

	return isUnlock
end

function TabPTEliBaseMainView:_getEliRoundIdListInTab(headTabId)
	local eliRoundIdList = {}
	local tabData = TabFrameWorkConfig.instance:getFwTabData(self._frameId, headTabId)

	if not string.nilorempty(tabData.exTabParams) then
		local arr = string.split(tabData.exTabParams, "#")

		for _, eliRoundId in ipairs(arr) do
			table.insert(eliRoundIdList, checknumber(eliRoundId))
		end
	end

	return eliRoundIdList
end

function TabPTEliBaseMainView:_updateCurTabIndex()
	local curInfo = self:_getHeadTabViewInfo(self._curHeadTabIndex)
	local newestHeadTab = 3
	local newestEliRoundId = self._eliminatorMgr:getNewestEliRoundId()

	for headTabIndex, info in ipairs(self._headTabViewInfoList) do
		if info.isUnlock == true then
			local roundIdList = self:_getEliRoundIdListInTab(info.data.headTabId)
			local isInIt = table.indexof(roundIdList, newestEliRoundId) ~= false

			newestHeadTab = headTabIndex

			if isInIt and (curInfo == nil or not curInfo.isUnlock) then
				self._curHeadTabIndex = headTabIndex
				self._curSecTabIndex = 0

				break
			end
		end
	end

	curInfo = self:_getHeadTabViewInfo(self._curHeadTabIndex)

	if curInfo == nil or not curInfo.isUnlock then
		for headTabIndex, info in ipairs(self._headTabViewInfoList) do
			if info.isUnlock == true then
				self._curHeadTabIndex = headTabIndex
				self._curSecTabIndex = 0

				break
			end
		end
	end
end

return TabPTEliBaseMainView
