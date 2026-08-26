-- chunkname: @modules/logic/fight/view/indicator/FightIndicatorBaseView.lua

module("modules.logic.fight.view.indicator.FightIndicatorBaseView", package.seeall)

local FightIndicatorBaseView = class("FightIndicatorBaseView", UserDataDispose)

function FightIndicatorBaseView:initView(indicatorMgrView, indicatorId, totalIndicatorNum)
	self:__onInit()

	self._indicatorMgrView = indicatorMgrView
	self.indicatorId = indicatorId
	self.totalIndicatorNum = totalIndicatorNum or 0
	self.viewGO = self._indicatorMgrView.viewGO
	self.goIndicatorRoot = gohelper.findChild(self.viewGO, "root/indicator_container")
end

function FightIndicatorBaseView:startLoadPrefab()
	return
end

function FightIndicatorBaseView:onIndicatorChange()
	return
end

function FightIndicatorBaseView:onDestroy()
	self:__onDispose()
end

return FightIndicatorBaseView
