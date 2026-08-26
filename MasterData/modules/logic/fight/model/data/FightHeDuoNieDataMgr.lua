-- chunkname: @modules/logic/fight/model/data/FightHeDuoNieDataMgr.lua

module("modules.logic.fight.model.data.FightHeDuoNieDataMgr", package.seeall)

local FightHeDuoNieDataMgr = class("FightHeDuoNieDataMgr")

function FightHeDuoNieDataMgr:init()
	self.playedIndexDict = {}
	self.playedUnlockAudio = false
end

function FightHeDuoNieDataMgr:clearData()
	tabletool.clear(self.playedIndexDict)

	self.playedUnlockAudio = false
end

function FightHeDuoNieDataMgr:playedPointAnim(index)
	if not index then
		return
	end

	self.playedIndexDict[index] = true
end

function FightHeDuoNieDataMgr:checkPlayedPointAnim(index)
	if not index then
		return
	end

	return self.playedIndexDict[index]
end

function FightHeDuoNieDataMgr:tryPlayUnlockAudio()
	if self.playedUnlockAudio then
		return
	end

	self.playedUnlockAudio = true

	AudioMgr.instance:trigger(390026)
end

return FightHeDuoNieDataMgr
