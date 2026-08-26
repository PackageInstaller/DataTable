-- chunkname: @modules/logic/gm/model/GMBattleModel.lua

module("modules.logic.gm.model.GMBattleModel", package.seeall)

local GMBattleModel = class("GMBattleModel")

function GMBattleModel:setBattleParam(param)
	self._battleParam = param
end

function GMBattleModel:getBattleParam()
	return self._battleParam
end

function GMBattleModel:setGMFightRecordEnable()
	self.enableGMFightRecord = true
end

function GMBattleModel:setGMFightRecord(msg)
	self.fightRecordMsg = msg
end

GMBattleModel.instance = GMBattleModel.New()

return GMBattleModel
