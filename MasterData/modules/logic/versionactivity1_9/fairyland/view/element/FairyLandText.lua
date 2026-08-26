-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandText.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandText", package.seeall)

local FairyLandText = class("FairyLandText", FairyLandElementBase)

function FairyLandText:onInitView()
	self.itemGO = gohelper.findChild(self._go, "item")
	self.wordComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.itemGO, FairyLandWordComp, {
		co = self._config.config,
		res1 = self._elements.wordRes1,
		res2 = self._elements.wordRes2
	})
end

function FairyLandText:onRefresh()
	return
end

function FairyLandText:updatePos()
	local startPosX = -100
	local startPosY = -120
	local spaceX = 244
	local spaceY = 73
	local pos = self:getPos()
	local x = startPosX + pos * spaceX
	local y = startPosY - pos * spaceY

	recthelper.setAnchor(self._transform, x, y)
end

function FairyLandText:onDestroyElement()
	return
end

return FairyLandText
