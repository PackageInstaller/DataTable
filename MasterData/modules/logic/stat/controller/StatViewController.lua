-- chunkname: @modules/logic/stat/controller/StatViewController.lua

module("modules.logic.stat.controller.StatViewController", package.seeall)

local StatViewController = class("StatViewController")

function StatViewController:init()
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self.onTouchScreenDown, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self.onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenTabView, self.onBeforeOpenTabView, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnChangeChapterList, self.onChangeChapterType, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, self.onExploreChapterClick, self)
	SummonController.instance:registerCallback(SummonEvent.onSummonTabSet, self.onSwitchPool, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenViewTime, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewTime, self)
	CharacterController.instance:registerCallback(CharacterEvent.OnSwitchSkin, self.onSwitchSkin, self)

	self.viewHandleDict = {
		[ViewName.SummonADView] = self.handleSummonTabView,
		[ViewName.StoreView] = self.handleStoreTabView,
		[ViewName.DungeonView] = self.handleDungeonView,
		[ViewName.DungeonMapView] = self.handleDungeonMapView,
		[ViewName.V1a4_BossRushLevelDetail] = self.handleV1a4_BossRushLevelDetail,
		[ViewName.OptionalChargeView] = self.handleOptionalChargeView,
		[ViewName.VersionActivity2_0EnterView] = self.handleVersionActivityEnterView,
		[ViewName.V3a2_BossRush_LevelDetailView] = self.handleBossRushLevelDetailView,
		[ViewName.V3a9_BossRush_LevelDetailView] = self.handleBossRushLevelDetailView
	}
	self._viewOpenTimeDict = {}
end

function StatViewController:onChangeChapterType(type)
	self:_handleDungeonView(type)
end

function StatViewController:onSwitchPool()
	local viewName = ViewName.SummonADView
	local poolCo = SummonMainModel.instance:getCurPool()
	local var_3_1 = string.format("%s-%s", (not StatViewNameEnum.ChineseViewName[viewName] or nil) and viewName, poolCo.nameCn)

	self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:onTouchScreenDown()
	if UIBlockMgr.instance:isBlock() then
		return
	end

	local viewName = self:getLastOpenView()

	if viewName then
		self.startView = viewName
	end
end

function StatViewController:getLastOpenView()
	self.materialName = nil

	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #viewNameList, 1, -1 do
		local viewName = viewNameList[i]

		if not self:isIgnoreView(viewName) then
			if self:isTipView(viewName) then
				self.materialName = self:getMaterialName()
			else
				return viewName
			end
		end
	end
end

function StatViewController:_onOpenViewTime(viewName)
	if StatViewNameEnum.NeedViewOpenTimeDict[viewName] then
		self._viewOpenTimeDict[viewName] = Time.time
	end
end

function StatViewController:_onCloseViewTime(viewName)
	if StatViewNameEnum.NeedViewOpenTimeDict[viewName] and self._viewOpenTimeDict[viewName] then
		local openTime = self._viewOpenTimeDict[viewName]

		self._viewOpenTimeDict[viewName] = nil

		self:trackExit(StatViewNameEnum.ChineseViewName[viewName] or viewName, Time.time - openTime)
	end
end

function StatViewController:onOpenView(viewName, viewParam)
	if not StatViewNameEnum.NeedTrackViewDict[viewName] then
		return
	end

	if tabletool.indexOf(StatViewNameEnum.NeedListenTabSwitchList, viewName) then
		return
	end

	local handle = self.viewHandleDict[viewName]

	handle = handle or self.defaultViewHandle

	handle(self, viewName, viewParam)
end

function StatViewController:onBeforeOpenTabView(paramTab)
	local viewName = paramTab.viewName
	local tabGroupView = paramTab.tabGroupView
	local tabView = paramTab.tabView

	if tabGroupView:getTabContainerId() ~= StatViewNameEnum.TabViewContainerID[viewName] then
		return
	end

	local handle = self.viewHandleDict[viewName]

	handle = handle or self.defaultTabViewHandle

	handle(self, viewName, tabView)
end

function StatViewController:defaultViewHandle(viewName, viewParam)
	self:track(StatViewNameEnum.ChineseViewName[viewName] or viewName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:defaultTabViewHandle(viewName, tabView)
	if not StatViewNameEnum.TabViewName[tabView.__cname] then
		local tabViewCnName = StatViewNameEnum.TabViewName[tabView.class]

		tabViewCnName = tabViewCnName or self:_findTabViewChildCnName(tabView)

		local var_11_1 = string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName] or viewName, tabViewCnName or tabView.__cname)

		self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
	end
end

function StatViewController:_findTabViewChildCnName(tabView)
	if tabView and tabView._views and #tabView._views > 0 then
		for _, view in ipairs(tabView._views) do
			if StatViewNameEnum.TabViewName[view.__cname] then
				return StatViewNameEnum.TabViewName[view.__cname]
			end
		end
	end

	return nil
end

function StatViewController:handleBossRushLevelDetailView(viewName, tabView)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		return
	end

	if viewContainer.viewParam then
		local stageCO = viewContainer.viewParam.stageCO

		if stageCO then
			local chineseName = string.format("%s-%s", (not StatViewNameEnum.ChineseViewName[viewName] or nil) and viewName, stageCO.name or "")

			self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
		end
	end
end

function StatViewController:handleVersionActivityEnterView(viewName, tabView)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		logError("not open " .. tostring(viewName))

		return
	end

	local activityId = viewContainer.activityId
	local activityCo = ActivityConfig.instance:getActivityCo(activityId)

	if activityCo then
		local chineseName = string.format("%s-%s", (not StatViewNameEnum.ChineseViewName[viewName] or nil) and viewName, activityCo.name or tabView.__cname)

		self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
	end
end

function StatViewController:handleStoreTabView(viewName, tabView)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		logError("not open store view ?")

		return
	end

	local tabId = viewContainer:getSelectFirstTabId()

	if string.nilorempty(tabId) then
		return
	end

	local storeConfig = StoreConfig.instance:getTabConfig(tabId)

	self:track(storeConfig.name, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleSummonTabView(viewName, tabView)
	local poolCo = SummonMainModel.instance:getCurPool()
	local var_16_1 = string.format("%s-%s", (not StatViewNameEnum.ChineseViewName[viewName] or nil) and viewName, poolCo.nameCn)

	self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleDungeonView(viewName)
	self:_handleDungeonView(DungeonModel.instance.curChapterType)
end

function StatViewController:_handleDungeonView(type)
	local preName = StatViewNameEnum.ChineseViewName[ViewName.DungeonView] .. "-"

	if DungeonModel.instance:chapterListIsNormalType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Story, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsRoleStory(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.RoleStory, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsResType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Res, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsBreakType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Break, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsWeekWalkType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.WeekWalkName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsPermanent(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Permanent, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end
end

function StatViewController:onExploreChapterClick(index)
	local chapterCoList = DungeonConfig.instance:getExploreChapterList()
	local chapterCo = chapterCoList[index]

	self:track(string.format("%s-%s-%s", StatViewNameEnum.ChineseViewName[ViewName.DungeonView], StatViewNameEnum.DungeonViewName.ExploreName, chapterCo.name), (not StatViewNameEnum.ChineseViewName[self.startView] or nil) and self.startView, self.materialName)
end

function StatViewController:handleDungeonMapView(viewName, viewParam)
	local chapterId = viewParam.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	self:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName], chapterCo.name), (not StatViewNameEnum.ChineseViewName[self.startView] or nil) and self.startView, self.materialName)
end

function StatViewController:handleV1a4_BossRushLevelDetail(viewName, viewParam)
	self:track(name, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleOptionalChargeView(viewName, viewParam)
	self:track(name, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:onSwitchSkin(skinCo, viewName)
	self:track((StatViewNameEnum.ChineseViewName[viewName] or viewName) .. "-" .. ((skinCo or nil) and (skinCo.name or "")), StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:isIgnoreView(viewName)
	return tabletool.indexOf(StatViewNameEnum.IgnoreViewList, viewName) ~= nil
end

function StatViewController:isTipView(viewName)
	return viewName == StatViewNameEnum.MaterialTipView
end

function StatViewController:getMaterialName()
	local viewContainer = ViewMgr.instance:getContainer(StatViewNameEnum.MaterialTipView)
	local viewParam = viewContainer.viewParam
	local config = ItemConfig.instance:getItemConfig(viewParam.type, viewParam.id)

	return config.name
end

function StatViewController:trackExit(viewName, useTime)
	StatController.instance:track(StatEnum.EventName.ExitView, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.UseTime] = tonumber(useTime)
	})
end

function StatViewController:track(viewName, startView, materialName)
	StatController.instance:track(StatEnum.EventName.EnterView, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.StartViewName] = startView,
		[StatEnum.EventProperties.MaterialViewName] = materialName or ""
	})
end

function StatViewController:trackViewName(chineseViewNameStr)
	self:track(chineseViewNameStr or "", (not StatViewNameEnum.ChineseViewName[self.startView] or nil) and self.startView, self.materialName)
end

StatViewController.instance = StatViewController.New()

return StatViewController
