-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainSettingView.lua

module("logic.extensions.mainui.view.MainSettingView", package.seeall)

local kSystemOpenEnum = {
	[4] = GameEnum.SystemEnum.FightSetting
}
local M = class("MainSettingView", ViewComponent)

function M:buildUI()
	self._blurGo = self:getGo("2&common_blur_rt_-2028819737")
	self._btnClose = self:getBtn("9&title_view_-878360263")
	self._btnHome = self:getBtn("9&title_view_1398742689")
	self._goAccountPanel = self:getGo("main_setting_tips_1050172266")
	self._goSoundPanel = self:getGo("main_setting_tips_-395742732")
	self._goFramePanel = self:getGo("main_setting_tips_-906380910")
	self._goFightPanel = self:getGo("main_setting_tips_-634742652")
	self._selectGo = self:getGo("3&left_tab_content_-1382376651")
	self._goTabPanels = {
		self._goAccountPanel,
		self._goSoundPanel,
		self._goFramePanel,
		self._goFightPanel
	}
	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("3&left_tab_content_-399612422"), LeftTabComp)
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	for i = 1, 4 do
		self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(i))
	end
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._btnClose = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function M:onEnter()
	goutil.setWidth(self._blurGo.transform, ViewMgr.instance:getUIWidth())
	self._toggleTabControl:selectTab(1)
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), 1)
end

function M:onExit(reasonType)
	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._tabComp:onExit()
	self._tabComp:setCanvasInteractable(false)
	self._tabComp:playGuiAniTab(false, isNormalClose)
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		for k, v in pairs(self._goTabPanels) do
			goutil.setActive(v, tabIndex == k)
		end

		GlobalDispatcher:dispatchEvent(EventType.SETTING_TAB_CHANGE, tabIndex)
	end

	local duration = needReflash and 0.3 or 0

	self._tabComp:MoveSelectMark(tabIndex, duration)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickHome()
	self:close()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

return M
