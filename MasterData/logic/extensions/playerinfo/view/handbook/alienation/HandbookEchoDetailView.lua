-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HandbookEchoDetailView.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HandbookEchoDetailView", package.seeall)

local M = class("HandbookEchoDetailView", ViewComponent)

M.SubViewType = {
	Effect = 2,
	Detail = 1
}
M.SubViewTabName = {
	lang("tip_handbook_echo_tab_1"),
	(lang("tip_handbook_echo_tab_2"))
}

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnReturn = self:getBtn("title_view_-878360263")

	local registry = self._viewPresentor._viewElementsRegistry

	self._viewPager = ViewPager.New(self.mainGO)

	self._viewPager:setAdapter(StaticPagerAdapter.New(registry))
	self._viewPager:setViewPresentor(self._viewPresentor)

	local pagerAdapter = self._viewPager:getAdapter()

	self._subPage = {}
	self._subPage[self.SubViewType.Detail] = HanbookEchoProfileFragmentView.New(self:getGo("handbook_alienation_carry_view_-1233731667"), self._viewPresentor)
	self._subPage[self.SubViewType.Effect] = HandbookEchoEffectFragmentView.New(self:getGo("handbook_alienation_carry_view_2102447252"), self._viewPresentor)

	for index, _ in ipairs(self.SubViewTabName) do
		pagerAdapter:addFragmentView(self._subPage[index])
	end

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)

	local rightPanelRoot = self:getRectTransform("right_tab_content_-205429629")
	local layoutGroup = rightPanelRoot:GetComponent(UIComponentType.VerticalLayoutGroup)

	layoutGroup.enabled = true

	for index, tabName in ipairs(self.SubViewTabName) do
		local goChild = rightPanelRoot:GetChild(index - 1)

		self._toggleTabControl:addToggleTab(goChild:GetComponent(UIComponentType.SpaceXToggle))

		local txtTab = goutil.findChildTextComponent(goChild, "normal/Text1")

		txtTab.text = tabName
		txtTab = goutil.findChildTextComponent(goChild, "select/Text1")
		txtTab.text = tabName
	end

	self._showCardView = Astral.LuaComponentContainer.Add(self:getGo("8&echo_show_card_-997813653"), HandbookEchoShowCardCell)
end

function M:destroyUI()
	self._btnReturn = nil
	self._subPage = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._showCardView = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)

	local params = self:getFirstParam() or {}
	local index = params.index or M.SubViewType.Detail
	local pageView = self:_getPageView(self.SubViewType.Detail)
	local isLock = params.isLock

	pageView:setEchoItemData(params.echoItemId)

	pageView = self:_getPageView(self.SubViewType.Effect)

	pageView:setEchoItemData(params.echoItemId)
	self._showCardView:onEnter()
	self._showCardView:refreshView(params.echoItemId)

	local tab = self._toggleTabControl:getTab(1)

	goutil.setActive(tab.gameObject, not isLock)
	self._toggleTabControl:selectTab(index)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	self._viewPager:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
	self._showCardView:onExit()
end

function M:_onClickReturn()
	self:close()
end

function M:_getPageView(subViewType)
	return self._subPage[subViewType]
end

return M
