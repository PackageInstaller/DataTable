-- chunkname: @modules/logic/survival/view/map/comp/SurvivalItemListAnimComp.lua

module("modules.logic.survival.view.map.comp.SurvivalItemListAnimComp", package.seeall)

local SurvivalItemListAnimComp = class("SurvivalItemListAnimComp", LuaCompBase)

function SurvivalItemListAnimComp:init(go)
	self.go = go
end

function SurvivalItemListAnimComp:playListOpenAnim(itemList, delay, animName)
	self.itemList = itemList
	self.delay = delay or 0.1
	self.animName = animName or UIAnimationName.Open
	self._index = 0

	if not self.itemList then
		return
	end

	for i, v in ipairs(self.itemList) do
		gohelper.setActive(v.go, false)
	end

	TaskDispatcher.cancelTask(self._playNext, self)
	TaskDispatcher.runRepeat(self._playNext, self, self.delay)
end

function SurvivalItemListAnimComp:_playNext()
	self._index = self._index + 1

	local item = self.itemList[self._index]

	if not item then
		TaskDispatcher.cancelTask(self._playNext, self)

		return
	end

	gohelper.setActive(item.go, true)
	item.anim:Play(self.animName, 0, 0)
end

function SurvivalItemListAnimComp:onDestroy()
	TaskDispatcher.cancelTask(self._playNext, self)
end

return SurvivalItemListAnimComp
