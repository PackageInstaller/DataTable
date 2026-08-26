-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/component/buff/TravelGoBuffComp.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.component.buff.TravelGoBuffComp", package.seeall)

local TravelGoBuffComp = class("TravelGoBuffComp", TravelGoBase)

function TravelGoBuffComp:ctor()
	TravelGoBuffComp.super.ctor(self)

	self.uid = 0
	self.buffList = {}
end

function TravelGoBuffComp:onEnable()
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
end

function TravelGoBuffComp:onBattleEventFinish()
	for i, v in ipairs(self.buffList) do
		v:dispose()
	end

	tabletool.clear(self.buffList)
end

function TravelGoBuffComp:addBuff(cfgId, skillId)
	self.uid = self.uid + 1

	local buff = TravelGoBuffInfo.New(self.parent, self.uid, cfgId, skillId)

	buff:awake(true)
	table.insert(self.buffList, buff)
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnBuffChange, self.parent)

	return buff
end

function TravelGoBuffComp:removeBuff(uid)
	local buff

	for i, v in ipairs(self.buffList) do
		if v.uid == uid then
			buff = v

			table.remove(self.buffList, i)

			break
		end
	end

	if buff then
		buff:dispose()
	end

	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnBuffChange, self.parent)
end

return TravelGoBuffComp
