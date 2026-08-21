-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/selecttips/RogueSelectTitleBar.lua

module("logic.extensions.roguelike.view.explore.selecttips.RogueSelectTitleBar", package.seeall)

local kSelectType = {
	SelectProp = 2,
	SelectCard = 3,
	SelectRole = 1
}
local M = class("RogueSelectTitleBar")

function M:ctor(parent)
	self.parent = parent
end

function M:buildUI()
	self._goLine = self.parent:getGo("props_select_view_copy_1178297314")
	self._goLine1 = self.parent:getGo("props_select_view_copy_-2104212520")
	self._goLine2 = self.parent:getGo("props_select_view_copy_-202723929")
	self._tgSelectProp = self.parent:getUIComponent("props_select_view_copy_603931566", UIComponentType.SpaceXToggle)
	self._tgSelectRole = self.parent:getUIComponent("props_select_view_copy_462132293", UIComponentType.SpaceXToggle)
	self._tgSelectCard = self.parent:getUIComponent("props_select_view_copy_1332806196", UIComponentType.SpaceXToggle)
	self._allToggles = {
		[kSelectType.SelectRole] = self._tgSelectRole,
		[kSelectType.SelectProp] = self._tgSelectProp,
		[kSelectType.SelectCard] = self._tgSelectCard
	}
	self._goToggles = {
		[kSelectType.SelectRole] = self._tgSelectRole.gameObject,
		[kSelectType.SelectProp] = self._tgSelectProp.gameObject,
		[kSelectType.SelectCard] = self._tgSelectCard.gameObject
	}
end

function M:setTitleActive(selectTypes)
	for k, v in pairs(self._goToggles) do
		goutil.setActive(v, false)
	end

	local isShowCard = false

	for k, v in pairs(selectTypes) do
		goutil.setActive(self._goToggles[v], true)

		if k == kSelectType.SelectCard then
			isShowCard = true
		end
	end

	goutil.setActive(self._goLine2, isShowCard and #selectTypes > 1)
	goutil.setActive(self._goLine1, #selectTypes > 1)
end

function M:setToggleStatus(curSelectType)
	for k, v in pairs(self._allToggles) do
		v.IsOn = k == curSelectType
	end
end

return M
