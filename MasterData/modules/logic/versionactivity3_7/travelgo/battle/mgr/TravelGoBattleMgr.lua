-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/mgr/TravelGoBattleMgr.lua

module("modules.logic.versionactivity3_7.travelgo.battle.mgr.TravelGoBattleMgr", package.seeall)

local TravelGoBattleMgr = class("TravelGoBattleMgr", TravelGoBase)

function TravelGoBattleMgr:ctor()
	TravelGoBattleMgr.super.ctor(self)

	self.graphic = TravelGoBattleGraphic.New()
end

function TravelGoBattleMgr:onEnable()
	self.travelGoEntityMgr = TravelGoController.instance.travelGoEntityMgr

	self.travelGoEntityMgr:createPlayerEntity()
end

function TravelGoBattleMgr:onDisable()
	if self.graphic then
		self.graphic:disable()
	end

	if self.resLoader then
		self.resLoader:dispose()

		self.resLoader = nil
	end
end

function TravelGoBattleMgr:startBattle()
	logNormal("小瑞安依 战斗开始")

	local enemyEntity = self.travelGoEntityMgr.enemyEntityList[1]

	self.graphic:setBattleData(self.travelGoEntityMgr.playerEntity, enemyEntity)
	self.graphic:enable()
end

function TravelGoBattleMgr:endBattle()
	logNormal("小瑞安依 战斗结束")
	self.graphic:disable()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnBattleEventFinish)
end

function TravelGoBattleMgr:loadRes()
	if self.resLoader then
		return
	end

	self.resLoader = MultiAbLoader.New()

	local dic = lua_activity220_effect.configDict

	for i, cfg in pairs(dic) do
		if not string.nilorempty(cfg.effect) then
			self.resLoader:addPath(cfg.effect)
		end
	end

	return self.resLoader
end

function TravelGoBattleMgr:getRes(path)
	local assetItem = self.resLoader:getAssetItem(path)

	return assetItem:GetResource(path)
end

return TravelGoBattleMgr
