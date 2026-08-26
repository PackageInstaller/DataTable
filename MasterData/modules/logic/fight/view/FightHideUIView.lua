-- chunkname: @modules/logic/fight/view/FightHideUIView.lua

module("modules.logic.fight.view.FightHideUIView", package.seeall)

local FightHideUIView = class("FightHideUIView", BaseView)

function FightHideUIView:onInitView()
	self._btnsGo = gohelper.findChild(self.viewGO, "root/btns")
	self._imgRoundGo = gohelper.findChild(self.viewGO, "root/topLeftContent/imgRound")
end

function FightHideUIView:addEvents()
	return
end

function FightHideUIView:onOpen()
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._checkHideUI, self)
	self:_checkHideUI()
end

function FightHideUIView:_checkHideUI()
	gohelper.setActive(self._btnsGo, GMFightShowState.topRightPause)
	gohelper.setActive(self._imgRoundGo, GMFightShowState.topRightRound)
end

function FightHideUIView:onClose()
	self.removeEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._checkHideUI, self)
end

return FightHideUIView
