-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupListView.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupListView", package.seeall)

local Rouge2_HeroGroupListView = class("Rouge2_HeroGroupListView", HeroGroupListView)

function Rouge2_HeroGroupListView:_getHeroItemCls()
	return Rouge2_HeroGroupHeroItem
end

function Rouge2_HeroGroupListView:onOpen()
	Rouge2_HeroGroupListView.super.onOpen(self)
end

function Rouge2_HeroGroupListView:canDrag(param, isWrap)
	if not Rouge2_HeroGroupListView.super.canDrag(self, param, isWrap) then
		return false
	end

	return true
end

function Rouge2_HeroGroupListView:onDestroyView()
	Rouge2_HeroGroupListView.super.onDestroyView(self)
end

return Rouge2_HeroGroupListView
