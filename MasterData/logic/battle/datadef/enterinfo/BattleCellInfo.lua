-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/enterinfo/BattleCellInfo.lua

module("logic.battle.datadef.enterinfo.BattleCellInfo", package.seeall)

local BattleCellInfo = class("BattleCellInfo", AbstractGlobalReusable)

function BattleCellInfo:ctor(unionIndex)
	self.unionIndex = 0
	self.additionalTerrainInfo = false

	self:reuse(unionIndex)
end

function BattleCellInfo:reuse(unionIndex)
	self.unionIndex = unionIndex
end

function BattleCellInfo:reset()
	self:removeAdditionalTerrainInfo()
end

function BattleCellInfo:destroy()
	self:reset()
end

function BattleCellInfo:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function BattleCellInfo:setFromAdditionalTerrainNO(additionalTerrainNO)
	self:removeAdditionalTerrainInfo()

	self.additionalTerrainInfo = BattleCellInfo.AdditionalTerrainInfo:createInstance(additionalTerrainNO.code, additionalTerrainNO.round, additionalTerrainNO.triggered)
end

function BattleCellInfo:removeAdditionalTerrainInfo()
	if self.additionalTerrainInfo then
		self.additionalTerrainInfo:returnSelf()

		self.additionalTerrainInfo = false
	end
end

function BattleCellInfo:hasAdditionalTerrain()
	return self.additionalTerrainInfo and true or false
end

function BattleCellInfo:toString()
	return self.unionIndex
end

BattleCellInfo.AdditionalTerrainInfo = class("BattleCellInfo_AdditionalTerrainInfo", AbstractGlobalReusable)

function BattleCellInfo.AdditionalTerrainInfo:ctor(code, round, triggered)
	self.code = 0
	self.round = 0
	self.triggered = 0

	self:reuse(code, round, triggered)
end

function BattleCellInfo.AdditionalTerrainInfo:reuse(code, round, triggered)
	self.code = code
	self.round = round
	self.triggered = triggered
end

function BattleCellInfo.AdditionalTerrainInfo:reset()
	self.code = 0
	self.round = 0
	self.triggered = 0
end

function BattleCellInfo.AdditionalTerrainInfo:toString()
	return self.code
end

return BattleCellInfo
