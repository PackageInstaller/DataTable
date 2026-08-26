-- chunkname: @modules/logic/fight/model/data/Fight3_5BaiFuZhangWheelDataMgr.lua

module("modules.logic.fight.model.data.Fight3_5BaiFuZhangWheelDataMgr", package.seeall)

local Fight3_5BaiFuZhangWheelDataMgr = FightDataClass("Fight3_5BaiFuZhangWheelDataMgr", FightDataMgrBase)

function Fight3_5BaiFuZhangWheelDataMgr:onConstructor()
	self.wheelData = nil
	self.selectedIndex = {}
	self.index = 1
end

return Fight3_5BaiFuZhangWheelDataMgr
