-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/LotteryHacktoolSelectView.lua

module("logic.extensions.hacktool.view.LotteryHacktoolSelectView", package.seeall)

local M = class("LotteryHacktoolSelectView", ViewComponent)

function M:buildUI()
	M.super.buildUI(self)

	self._btnReturn = self:getBtn("1&title_view_-878360263")
	self._btnHome = self:getBtn("1&title_view_1398742689")
end

function M:onEnter()
	local param = self:getOpenParam()

	self._curIndex = param[1]

	M.super.onEnter(self)
end

function M:_initHeroData()
	self._showHeroData = CharacterUtil.getAllCharacter()

	if self._heroListBinderView then
		self._heroListBinderView:onEnter()
	end
end

function M:_viewHeroDetailInfo(name, herodata)
	if herodata then
		RetrieveDispatcher:dispatchEvent(RetrieveEventType.onTestLotteryCharacterChange, self._curIndex, herodata:getId())
	end

	self:back()
end

return M
