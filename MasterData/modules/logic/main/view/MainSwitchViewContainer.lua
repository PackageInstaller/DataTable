-- chunkname: @modules/logic/main/view/MainSwitchViewContainer.lua

module("modules.logic.main.view.MainSwitchViewContainer", package.seeall)

local MainSwitchViewContainer = class("MainSwitchViewContainer", BaseViewContainer)

function MainSwitchViewContainer:buildViews()
	local views = {}

	table.insert(views, MainSwitchView.New())
	table.insert(views, TabViewGroupFit.New(1, "#go_container"))
	table.insert(views, TabViewGroup.New(2, "#go_btns"))

	return views
end

function MainSwitchViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 2 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end

	if tabContainerId == 1 then
		local t = {}

		self:_addCharacterSwitch(t)
		self:_addSceneClassify(t)
		self:_addFightUISwitch(t)

		return t
	end

	if tabContainerId == 3 then
		local t = {}

		self:_addSceneSwitch(t)
		self:_addUISwitch(t)
		self:_addClickUISwitch(t)
		self:_addSummonUISwitch(t)

		return t
	end

	if tabContainerId == 4 then
		local t = {}

		self:_addMainUI(t)

		return t
	end
end

function MainSwitchViewContainer:getMainHeroView()
	return self._mainUIHeroView
end

function MainSwitchViewContainer:switchMainUI(id)
	self._mainUISwitchView:refreshMainUI(id)
end

function MainSwitchViewContainer:_addCharacterSwitch(t)
	local views = {}

	self._characterSwitchView = CharacterSwitchView.New()

	table.insert(views, self._characterSwitchView)

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/mask/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.tabRes[1][1][2]
	scrollParam.cellClass = CharacterSwitchItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 208
	scrollParam.cellSpaceH = 5
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 5
	scrollParam.endSpace = 0
	self._characterScrollView = LuaListScrollView.New(CharacterSwitchListModel.instance, scrollParam)

	table.insert(views, self._characterScrollView)

	t[MainEnum.SwitchType.Character] = MultiView.New(views)
end

function MainSwitchViewContainer:getCharacterScrollView()
	return self._characterScrollView
end

function MainSwitchViewContainer:_addSceneClassify(t)
	local views = {}

	self._classifyView = MainSwitchClassifyView.New()

	table.insert(views, self._classifyView)
	table.insert(views, TabViewGroupFit.New(3, "root"))

	local scrollClassifyParam = ListScrollParam.New()

	scrollClassifyParam.scrollGOPath = "left/#go_left"
	scrollClassifyParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollClassifyParam.prefabUrl = self._viewSetting.otherRes[3]
	scrollClassifyParam.cellClass = MainSwitchClassifyInfoItem
	scrollClassifyParam.scrollDir = ScrollEnum.ScrollDirV
	scrollClassifyParam.cellWidth = 400
	scrollClassifyParam.cellHeight = 160
	scrollClassifyParam.cellSpaceV = -28

	table.insert(views, LuaListScrollView.New(MainSwitchClassifyListModel.instance, scrollClassifyParam))

	t[MainEnum.SwitchType.Scene] = MultiView.New(views)
end

function MainSwitchViewContainer:_addMainSceneSwitchList(views)
	local scrollSceneParam = MixScrollParam.New()

	scrollSceneParam.scrollGOPath = "right/mask/#scroll_card"
	scrollSceneParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollSceneParam.prefabUrl = self._viewSetting.tabRes[1][2][2]
	scrollSceneParam.cellClass = MainSceneSwitchItem
	scrollSceneParam.scrollDir = ScrollEnum.ScrollDirV
	scrollSceneParam.lineCount = 1

	table.insert(views, LuaMixScrollView.New(MainSceneSwitchListModel.instance, scrollSceneParam))
end

function MainSwitchViewContainer:_addSceneSwitch(t)
	local views = {}

	self._displayView = MainSceneSwitchDisplayView.New()

	table.insert(views, self._displayView)
	table.insert(views, MainSceneSwitchNewView.New())
	self:_addMainSceneSwitchList(views)

	t[MainSwitchClassifyEnum.Classify.Scene] = MultiView.New(views)
end

function MainSwitchViewContainer:_addMainUISwitchList(views)
	local scrollUIParam = MixScrollParam.New()

	scrollUIParam.scrollGOPath = "right/mask/#scroll_card"
	scrollUIParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollUIParam.prefabUrl = self._viewSetting.tabRes[1][2][2]
	scrollUIParam.cellClass = MainUISwitchItem
	scrollUIParam.scrollDir = ScrollEnum.ScrollDirV
	scrollUIParam.lineCount = 1

	table.insert(views, LuaMixScrollView.New(MainUISwitchListModel.instance, scrollUIParam))
end

function MainSwitchViewContainer:_addUISwitch(t)
	local views = {}

	table.insert(views, MainUISwitchView.New())
	table.insert(views, TabViewGroupFit.New(4, "middle/#go_mainUI"))
	self:_addMainUISwitchList(views)

	t[MainSwitchClassifyEnum.Classify.UI] = MultiView.New(views)
end

function MainSwitchViewContainer:_addMainUI(t)
	local views = {}

	self._mainUIHeroView = SwitchMainHeroView.New()

	table.insert(views, SwitchMainUIShowView.New())
	table.insert(views, SwitchMainActivityEnterView.New())
	table.insert(views, SwitchMainActExtraDisplay.New())
	table.insert(views, self._mainUIHeroView)
	table.insert(views, SwitchMainUIEagleAnimView.New())
	table.insert(views, MainBirdAnimView.New())
	table.insert(views, SwitchMainUIView.New())

	t[1] = MultiView.New(views)
	self._mainUIViews = views

	return t[1]
end

function MainSwitchViewContainer:_addClickUISwitch(t)
	local views = {}
	local scrollUIParam = MixScrollParam.New()

	scrollUIParam.scrollGOPath = "right/mask/#scroll_card"
	scrollUIParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollUIParam.prefabUrl = self._viewSetting.tabRes[1][2][2]
	scrollUIParam.cellClass = ClickUISwitchItem
	scrollUIParam.scrollDir = ScrollEnum.ScrollDirV
	scrollUIParam.lineCount = 1

	table.insert(views, LuaMixScrollView.New(ClickUISwitchListModel.instance, scrollUIParam))
	table.insert(views, ClickUISwitchView.New())

	t[MainSwitchClassifyEnum.Classify.Click] = MultiView.New(views)
end

function MainSwitchViewContainer:_addSummonUISwitch(t)
	local views = {}
	local scrollUIParam = MixScrollParam.New()

	scrollUIParam.scrollGOPath = "right/mask/#scroll_card"
	scrollUIParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollUIParam.prefabUrl = self._viewSetting.tabRes[1][2][2]
	scrollUIParam.cellClass = SummonUISwitchItem
	scrollUIParam.scrollDir = ScrollEnum.ScrollDirV
	scrollUIParam.lineCount = 1

	table.insert(views, LuaMixScrollView.New(SummonUISwitchListModel.instance, scrollUIParam))
	table.insert(views, SummonUISwitchView.New())

	self._summonSwitchDisplayView = SummonUISkinSwitchDisplayView.New()

	table.insert(views, self._summonSwitchDisplayView)

	t[MainSwitchClassifyEnum.Classify.Summon] = MultiView.New(views)
end

function MainSwitchViewContainer:_addFightUISwitch(t)
	local views = {}

	table.insert(views, FightUISwitchView.New())

	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "root/#go_right/#scroll_style"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.tabRes[1][3][2]
	scrollParam.cellClass = FightUISwitchItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1

	table.insert(views, LuaMixScrollView.New(FightUISwitchListModel.instance, scrollParam))

	t[MainEnum.SwitchType.FightUI] = MultiView.New(views)
end

function MainSwitchViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)

	if self._displayView and self._displayView:isShowView() then
		if tabId == MainEnum.SwitchType.Scene then
			self._displayView:showTab()
		else
			self._displayView:hideTab()
		end
	end

	if self._summonSwitchDisplayView and self._summonSwitchDisplayView:isShowView() then
		if tabId == MainEnum.SwitchType.Scene then
			self._summonSwitchDisplayView:showTab()
		else
			self._summonSwitchDisplayView:hideTab()
		end
	end
end

function MainSwitchViewContainer:switchClassifyTab(tabId)
	self._classifyTabId = tabId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 3, tabId)
end

function MainSwitchViewContainer:getClassify()
	return self._classifyTabId or MainSwitchClassifyEnum.Classify.Scene
end

function MainSwitchViewContainer:playCloseAnim(tabId)
	local isPlayAnim = false

	if self._lastTabId then
		if self._views[2] then
			local lastTabView = self._views[2]._tabViews[self._lastTabId]

			if lastTabView and lastTabView.viewGO then
				local animPlayer = SLFramework.AnimatorPlayer.Get(lastTabView.viewGO)

				if animPlayer then
					local function cb()
						self:switchTab(tabId)
					end

					animPlayer:Play("close", cb, self)

					isPlayAnim = true
				end
			end
		end
	end

	if self._views[2] then
		local tabView = self._views[2]._tabViews[tabId]

		if tabView and tabView.viewGO then
			local anim = tabView.viewGO:GetComponent(typeof(UnityEngine.Animator))

			if anim then
				anim.enabled = true

				anim:Play("open", 0, 0)
			end
		end

		self._lastTabId = tabId

		if not isPlayAnim then
			self:switchTab(tabId)
		end
	end
end

function MainSwitchViewContainer:overrideCloseFunc()
	local isPlayAnim = false

	if self._lastTabId then
		if self._views[2] then
			do
				local lastTabView = self._views[2]._tabViews[self._lastTabId]

				if lastTabView and lastTabView.viewGO then
					local animPlayer = SLFramework.AnimatorPlayer.Get(lastTabView.viewGO)

					if animPlayer then
						animPlayer:Play("close", self.closeThis, self)

						isPlayAnim = true
					end
				end
			end

			if not isPlayAnim then
				self:closeThis()
			end
		end
	end
end

return MainSwitchViewContainer
