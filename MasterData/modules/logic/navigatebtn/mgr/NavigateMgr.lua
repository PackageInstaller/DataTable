-- chunkname: @modules/logic/navigatebtn/mgr/NavigateMgr.lua

module("modules.logic.navigatebtn.mgr.NavigateMgr", package.seeall)

local NavigateMgr = class("NavigateMgr")
local IgnoreEscViewNameDict = {
	[ViewName.ToastView] = true,
	[ViewName.StorySceneView] = true,
	[ViewName.FightDiceView] = true,
	[ViewName.BpVideoView] = true,
	[ViewName.PlayerChangeBgListView] = true,
	[ViewName.GMErrorView] = true,
	[ViewName.RougeMapTipView] = true,
	[ViewName.Rouge2_MapTipView] = true,
	[ViewName.SurvivalToastView] = true,
	[ViewName.PartyGameHelpView] = true,
	[ViewName.SodacheToastView] = true,
	[ViewName.SodacheCardToastView] = true
}
local IgnoreTopLayerViewDict = {
	[ViewName.RougeMapTipView] = true,
	[ViewName.Rouge2_MapTipView] = true,
	[ViewName.GMToolView2] = true
}

function NavigateMgr:init()
	self._eventSystemGO = gohelper.find("EventSystem")

	if self._eventSystemGO then
		self._eventSystem = self._eventSystemGO:GetComponent(typeof(UnityEngine.EventSystems.EventSystem))
	end

	self:setNavigationEnabled(false)

	self._escapeParamDict = {}
	self._escapeParamDictForNavigate = {}
	self._spaceParamDict = {}

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	TaskDispatcher.runRepeat(self._onFrame, self, 0.001)
end

function NavigateMgr:onEscapeBtnClick()
	self:_onEscapeBtnClick()
end

function NavigateMgr:_onFrame()
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		self:_onEscapeBtnClick()
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Space) then
		self:_onSpaceBtnClick()
	end
end

function NavigateMgr:_onOpenView(viewName)
	self:_modifyScroll(viewName)
end

function NavigateMgr:_onCloseView(viewName)
	self:removeEscape(viewName)
	self:removeEscape(viewName, true)
	self:removeSpace(viewName)
end

function NavigateMgr:addEscape(viewName, callback, callbackObj, isNavigate)
	if isNavigate then
		if not self._escapeParamDictForNavigate then
			local dict = self._escapeParamDict

			dict[viewName] = {
				callback = callback,
				callbackObj = callbackObj
			}
		end
	end
end

function NavigateMgr:removeEscape(viewName, isNavigate)
	if isNavigate then
		if not self._escapeParamDictForNavigate then
			local dict = self._escapeParamDict

			dict[viewName] = nil
		end
	end
end

function NavigateMgr:addSpace(viewName, callback, callbackObj)
	self._spaceParamDict[viewName] = {
		callback = callback,
		callbackObj = callbackObj
	}
end

function NavigateMgr:removeSpace(viewName)
	self._spaceParamDict[viewName] = nil
end

function NavigateMgr:_onEscapeBtnClick()
	if not self:isEventSystemActive() then
		return
	end

	if UIBlockMgr.instance:isBlock() then
		return
	end

	if GuideBlockMgr.instance:isBlock() then
		return
	end

	local uiRootGO = ViewMgr.instance:getUIRoot()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	openViewNameList = NavigateMgr.sortOpenViewNameList(openViewNameList)

	for i, openViewName in ipairs(openViewNameList) do
		local viewSetting = ViewMgr.instance:getSetting(openViewName)

		if viewSetting.layer == "TOP" and not IgnoreTopLayerViewDict[openViewName] then
			return
		end

		if viewSetting.layer == "GUIDE" then
			return
		end
	end

	for i = #openViewNameList, 1, -1 do
		local openViewName = openViewNameList[i]
		local viewSetting = ViewMgr.instance:getSetting(openViewName)
		local viewContainer = ViewMgr.instance:getContainer(openViewName)

		if openViewName == ViewName.MainView then
			if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
				SDKController.instance:openSDKExitView()
			end

			return
		elseif not IgnoreEscViewNameDict[openViewName] then
			local viewGO = viewContainer and viewContainer.viewGO
			local parentTr = viewGO and viewGO.transform.parent.parent

			if parentTr == uiRootGO.transform then
				self:_dispatchEscape(openViewName)

				return
			end
		end
	end
end

function NavigateMgr:isMainViewInTop()
	local uiRootGO = ViewMgr.instance:getUIRoot()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	openViewNameList = NavigateMgr.sortOpenViewNameList(openViewNameList)

	for i, openViewName in ipairs(openViewNameList) do
		local viewSetting = ViewMgr.instance:getSetting(openViewName)

		if viewSetting.layer == "TOP" and openViewName ~= ViewName.GMToolView2 then
			return false
		end

		if viewSetting.layer == "GUIDE" then
			return false
		end
	end

	for i = #openViewNameList, 1, -1 do
		local openViewName = openViewNameList[i]
		local viewSetting = ViewMgr.instance:getSetting(openViewName)
		local viewContainer = ViewMgr.instance:getContainer(openViewName)

		if openViewName == ViewName.MainView then
			if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
				return true
			end
		elseif not IgnoreEscViewNameDict[openViewName] then
			local viewGO = viewContainer and viewContainer.viewGO
			local parentTr = viewGO and viewGO.transform.parent.parent

			if parentTr == uiRootGO.transform then
				return false
			end
		end
	end

	return false
end

function NavigateMgr:_dispatchEscape(viewName)
	local escapeParam = self._escapeParamDict[viewName]

	if escapeParam and escapeParam.callback then
		escapeParam.callback(escapeParam.callbackObj)

		return
	end

	local escapeParamForNavigate = self._escapeParamDictForNavigate[viewName]

	if escapeParamForNavigate and escapeParamForNavigate.callback then
		escapeParamForNavigate.callback(escapeParamForNavigate.callbackObj)

		return
	end

	local viewSetting = ViewMgr.instance:getSetting(viewName)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		return
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end

	if viewSetting.viewType == ViewType.Modal then
		viewContainer:onClickModalMaskInternal()
	elseif viewSetting.layer == "POPUP_TOP" then
		if not self._dontCloseViewNameDict then
			self._dontCloseViewNameDict = {}
			self._dontCloseViewNameDict[ViewName.FightLoadingView] = true
			self._dontCloseViewNameDict[ViewName.WeekWalkSelectTarotView] = true
			self._dontCloseViewNameDict[ViewName.FightFailTipsView] = true

			local seasonChoiceView = SeasonViewHelper.getViewName(nil, Activity104Enum.ViewName.EquipSelfChoiceView)

			self._dontCloseViewNameDict[seasonChoiceView] = true
			self._dontCloseViewNameDict[ViewName.ExploreInteractView] = true
			self._dontCloseViewNameDict[ViewName.ExploreGuideDialogueView] = true
			self._dontCloseViewNameDict[ViewName.VersionActivity1_6EnterVideoView] = true
			self._dontCloseViewNameDict[ViewName.FullScreenVideoView] = true
			self._dontCloseViewNameDict[ViewName.ToughBattleLoadingView] = true
			self._dontCloseViewNameDict[ViewName.RougeResultView] = true
			self._dontCloseViewNameDict[ViewName.CruiseGameResultView] = true

			for _, viewName in pairs(V1a6_CachotEventController.instance:getNoCloseViews()) do
				self._dontCloseViewNameDict[viewName] = true
			end

			Season123Controller.instance:addDontNavigateBtn(self._dontCloseViewNameDict)
		end

		if not self._dontCloseViewNameDict[viewName] then
			ViewMgr.instance:closeView(viewName, false, true)
		end
	end
end

function NavigateMgr:_onSpaceBtnClick()
	if not self:isEventSystemActive() then
		return
	end

	if UIBlockMgr.instance:isBlock() then
		return
	end

	if GuideBlockMgr.instance:isBlock() then
		return
	end

	local uiRootGO = ViewMgr.instance:getUIRoot()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	openViewNameList = NavigateMgr.sortOpenViewNameList(openViewNameList)

	for i, openViewName in ipairs(openViewNameList) do
		local viewSetting = ViewMgr.instance:getSetting(openViewName)

		if viewSetting.layer == "TOP" and openViewName ~= ViewName.GMToolView2 then
			return
		end

		if viewSetting.layer == "GUIDE" then
			self:_dispatchSpace(openViewName)

			return
		end
	end

	for i = #openViewNameList, 1, -1 do
		local openViewName = openViewNameList[i]
		local viewSetting = ViewMgr.instance:getSetting(openViewName)
		local viewContainer = ViewMgr.instance:getContainer(openViewName)

		if openViewName ~= ViewName.ToastView and openViewName ~= ViewName.StorySceneView then
			local viewGO = viewContainer and viewContainer.viewGO
			local parentTr = viewGO and viewGO.transform.parent.parent

			if parentTr == uiRootGO.transform then
				self:_dispatchSpace(openViewName)

				return
			end
		end
	end
end

function NavigateMgr:_dispatchSpace(viewName)
	local spaceParam = self._spaceParamDict[viewName]

	if spaceParam and spaceParam.callback then
		spaceParam.callback(spaceParam.callbackObj)
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end
end

function NavigateMgr:setNavigationEnabled(isEnabled)
	if self._eventSystem then
		self._eventSystem.sendNavigationEvents = isEnabled
	end
end

function NavigateMgr:isEventSystemActive()
	return self._eventSystemGO and self._eventSystemGO.activeInHierarchy
end

function NavigateMgr:_modifyScroll(viewName)
	local viewContainer = ViewMgr.instance:getContainer(viewName)
	local viewGO = viewContainer and viewContainer.viewGO

	if not viewGO then
		return
	end

	local scrollList = viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.ScrollRect), true)

	if scrollList then
		local iter = scrollList:GetEnumerator()

		while iter:MoveNext() do
			local scroll = iter.Current

			scroll.scrollSensitivity = 50
		end
	end
end

local LayerOrder = {
	GUIDE = 4,
	POPUP = 2,
	HUD = 1,
	TOP = 6,
	MESSAGE = 5,
	POPUP_TOP = 3
}

function NavigateMgr.sortOpenViewNameList(openViewNameList)
	local openViewNameTableList = {}

	for i, openViewName in ipairs(openViewNameList) do
		local openViewNameTable = {}

		openViewNameTable.openViewName = openViewName
		openViewNameTable.originOrder = i

		local viewSetting = ViewMgr.instance:getSetting(openViewName)

		openViewNameTable.layerOrder = LayerOrder.POPUP_TOP

		if viewSetting and LayerOrder[viewSetting.layer] then
			openViewNameTable.layerOrder = LayerOrder[viewSetting.layer]
		end

		table.insert(openViewNameTableList, openViewNameTable)
	end

	table.sort(openViewNameTableList, function(x, y)
		if x.layerOrder ~= y.layerOrder then
			return x.layerOrder < y.layerOrder
		end

		return x.originOrder < y.originOrder
	end)

	local newOpenViewNameList = {}

	for i, openViewNameTable in ipairs(openViewNameTableList) do
		table.insert(newOpenViewNameList, openViewNameTable.openViewName)
	end

	return newOpenViewNameList
end

NavigateMgr.instance = NavigateMgr.New()

LuaEventSystem.addEventMechanism(NavigateMgr.instance)

return NavigateMgr
