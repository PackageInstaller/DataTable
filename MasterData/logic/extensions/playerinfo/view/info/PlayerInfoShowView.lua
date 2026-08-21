-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerInfoShowView.lua

module("logic.extensions.playerinfo.view.info.PlayerInfoShowView", package.seeall)

local M = class("PlayerInfoMainView", ViewComponent)

M.SubViewType = {
	Exhibition = 5,
	Player = 1,
	Course = 4,
	Monument = 3,
	Achievement = 2
}

local kViewUrls = {
	ResName.Player_head_show_panel,
	ResName.Player_visiting_card_panel,
	ResName.Player_figure_panel
}
local kViewClass = {
	PlayerHeadShowView,
	PlayerVisitingCardView,
	PlayerFigureView
}

function M:ctor()
	self._viewPager = false
	self._toggleTabControl = false
end

function M:buildUI()
	local adapter = DynamicPagerAdapter.New()

	for index, _ in ipairs(kViewUrls) do
		adapter:registerView(kViewUrls[index], kViewClass[index])
	end

	local panelGo = goutil.findChild(self.mainGO, "panel")

	self._viewPager = ViewPager.New(panelGo)

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self._onPageChanged, self)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("0&right_tab_content_-242000516", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("0&right_tab_content_-1578871314", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("0&right_tab_content_1651451756", UIComponentType.SpaceXToggle))

	self._btnReturn = self:getBtn("1&title_view_-878360263")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	local params = self:getFirstParam() or {}
	local index = params.index or self._curPageIndex or 1

	self._toggleTabControl:selectTab(index)

	local view = self._viewPager:getAdapter():getView(index)

	if view and view.playDynamicPageTimeLineAni then
		view:playDynamicPageTimeLineAni("open")
	end
end

function M:onExit()
	return
end

function M:destroyUI()
	self._viewPager:clear()
	self._viewPager:destroy()

	self._viewPager = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:_onClickReturn()
	self:close()
end

function M:_onPageChanged(index)
	self._curPageIndex = index

	local params = self:getFirstParam()

	if params then
		params.index = index
	end

	if index == 1 then
		-- block empty
	elseif index == 2 then
		-- block empty
	end
end

return M
