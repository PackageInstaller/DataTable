-- chunkname: @modules/logic/fight/model/data/FightLocalDataMgr.lua

module("modules.logic.fight.model.data.FightLocalDataMgr", package.seeall)

local FightLocalDataMgr = class("FightLocalDataMgr", FightDataMgr)

FightLocalDataMgr.isLocalDataMgr = true
FightLocalDataMgr.instance = FightLocalDataMgr.New()

FightLocalDataMgr.instance:initDataMgr()

return FightLocalDataMgr
