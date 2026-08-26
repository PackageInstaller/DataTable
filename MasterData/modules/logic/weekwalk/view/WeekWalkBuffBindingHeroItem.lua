-- chunkname: @modules/logic/weekwalk/view/WeekWalkBuffBindingHeroItem.lua

module("modules.logic.weekwalk.view.WeekWalkBuffBindingHeroItem", package.seeall)

local WeekWalkBuffBindingHeroItem = class("WeekWalkBuffBindingHeroItem", HeroGroupEditItem)

function WeekWalkBuffBindingHeroItem:init(go)
	WeekWalkBuffBindingHeroItem.super.init(self, go)
	self:enableDeselect(false)
end

function WeekWalkBuffBindingHeroItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
end

function WeekWalkBuffBindingHeroItem:onDestroy()
	return
end

return WeekWalkBuffBindingHeroItem
