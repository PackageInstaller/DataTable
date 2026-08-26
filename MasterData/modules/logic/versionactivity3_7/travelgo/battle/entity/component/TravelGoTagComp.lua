-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/component/TravelGoTagComp.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.component.TravelGoTagComp", package.seeall)

local TravelGoTagComp = class("TravelGoTagComp", TravelGoBase)

function TravelGoTagComp:ctor()
	TravelGoTagComp.super.ctor(self)
	self:resetTag()
end

function TravelGoTagComp:onEnable()
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
end

function TravelGoTagComp:onBattleEventFinish()
	self:resetTag()
end

function TravelGoTagComp:resetTag()
	self.isCombo = nil
	self.isCounter = nil
	self.comboCount = 0
	self.round = 0
end

return TravelGoTagComp
