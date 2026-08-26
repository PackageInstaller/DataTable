-- chunkname: @modules/logic/gm/view/GM_VersionActivity_DungeonMapView.lua

module("modules.logic.gm.view.GM_VersionActivity_DungeonMapView", package.seeall)

local GM_VersionActivity_DungeonMapView = class("GM_VersionActivity_DungeonMapView", BaseView)
local kYellow = "#FFFF00"

local function _defaultBtnGmFunc()
	ViewMgr.instance:openView(ViewName.GM_VersionActivity_DungeonMapView)
end

function GM_VersionActivity_DungeonMapView.register(major, minor)
	local dungeonMapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView(major, minor)
	local dungeonMapEpisodeItem = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeItem(major, minor)
	local dungeonMapLevelView = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelView(major, minor)

	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapView_register(dungeonMapView)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XMapEpisodeItem_register(dungeonMapEpisodeItem)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapLevelView_register(dungeonMapLevelView, major, minor)
end

function GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self, _defaultBtnGmFunc)
		GM_VersionActivity_DungeonMapViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_VersionActivity_DungeonMapViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function GM_VersionActivity_DungeonMapView.VersionActivityX_XMapEpisodeItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "refreshUI")

	function T.refreshUI(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "refreshUI", ...)

		if not GM_VersionActivity_DungeonMapView.s_ShowAllTabId then
			return
		end

		SelfObj._txtsectionname.text = tostring(SelfObj._config.id) .. "\n" .. SelfObj._config.name
	end
end

function GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapLevelView_register(T, major, minor)
	major = major or 1
	minor = minor or 0

	local function _isLowerVer(expectMajor, expectMinor)
		if expectMajor > major then
			return true
		end

		if major == expectMajor then
			return expectMinor >= minor
		end

		return false
	end

	GMMinusModel.instance:saveOriginalFunc(T, "refreshStartBtn")

	function T.refreshStartBtn(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "refreshStartBtn", ...)

		if not GM_VersionActivity_DungeonMapView.s_ShowAllTabId then
			return
		end

		local config = SelfObj.showEpisodeCo
		local showDesc = gohelper.getRichColorText(config.id, kYellow)

		showDesc = DungeonModel.instance:hasPassLevel(config.id) and config.afterStory > 0 and not StoryModel.instance:isStoryFinished(config.afterStory) and showDesc .. luaLang("p_dungeonlevelview_continuestory") or showDesc .. luaLang("p_dungeonlevelview_startfight")
		SelfObj._txtnorstarttext.text = showDesc

		if _isLowerVer(1, 2) then
			SelfObj._txtnorstarttext2.text = showDesc
		end
	end
end

function GM_VersionActivity_DungeonMapView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_VersionActivity_DungeonMapView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_VersionActivity_DungeonMapView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_VersionActivity_DungeonMapView:onOpen()
	self:_refreshItem1()
end

function GM_VersionActivity_DungeonMapView:onDestroyView()
	return
end

GM_VersionActivity_DungeonMapView.s_ShowAllTabId = false

function GM_VersionActivity_DungeonMapView:_refreshItem1()
	self._item1Toggle.isOn = GM_VersionActivity_DungeonMapView.s_ShowAllTabId
end

function GM_VersionActivity_DungeonMapView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_VersionActivity_DungeonMapView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.VersionActivity_DungeonMapView_ShowAllTabIdUpdate, isOn)
end

return GM_VersionActivity_DungeonMapView
