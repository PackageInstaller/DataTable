-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataSendHero.lua

local ResOpActivityHomeDispatchMisc = require("ClientData/ResOpActivityHomeDispatchMisc")
local ResOpActivityHomeDispatchBonus = require("ClientData/ResOpActivityHomeDispatchBonus")
local ResOpActivityHomeDispatchBuildingLevel = require("ClientData/ResOpActivityHomeDispatchBuildingLevel")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataSendHero = Class("ActivityDataSendHero", ActivityDataBase)

function ActivityDataSendHero:ctor()
	self.serverData = {}
	self.dispatchTimer = Timer.New(Slot(self.onDispatchOver, self), 5, 1)
end

function ActivityDataSendHero:updateClientData(actId)
	self.actId = actId
	self.miscData = ResOpActivityHomeDispatchMisc[actId] or {}
	self.heroStarBonusData = ResOpActivityHomeDispatchBonus[actId] or {}
	self.buildingLevelData = ResOpActivityHomeDispatchBuildingLevel[actId] or {}
	self.dispatchCostTime = self.miscData.dispatch_time
end

function ActivityDataSendHero:updateRoleData(roleData)
	local svrData = roleData.home_dispatch

	self.serverData.dispatchCount = svrData.dispatch_count
	self.serverData.dispatchFinish = svrData.dispatch_stat
	self.serverData.dispatchTick = svrData.dispatch_tick
	self.serverData.preRefreshTick = svrData.dispatch_change_tick

	local buidingData = {}

	for _, bInfo in ipairs(svrData.building) do
		buidingData[bInfo.id] = bInfo.level
	end

	self.serverData.buidingData = buidingData

	self:checkDispatchTimer()
end

function ActivityDataSendHero:onDispatchOver()
	self.actObject:checkNew()
end

function ActivityDataSendHero:checkDispatchTimer()
	self.dispatchTimer:Stop()

	if self.serverData.dispatchFinish == 1 and self.serverData.dispatchTick + self.dispatchCostTime > ClientUtils.getServerTime() then
		self.dispatchTimer.duration = self.serverData.dispatchTick + self.dispatchCostTime - ClientUtils.getServerTime()

		self.dispatchTimer:Restart()
	end
end

function ActivityDataSendHero:destroy()
	self.dispatchTimer:Stop()
end

function ActivityDataSendHero:checkDispatchNew()
	if self.serverData.dispatchFinish == 2 then
		return true
	elseif self.serverData.dispatchFinish == 1 and self.serverData.dispatchTick + self.dispatchCostTime <= ClientUtils.getServerTime() then
		return true
	end

	if self.actObject:inOpenState() and self.serverData.dispatchFinish == 0 and self.serverData.dispatchCount > 0 then
		return true
	end
end

function ActivityDataSendHero:checkBuildingNew()
	if self.actObject:inOpenState() then
		for buildId, _ in pairs(self.buildingLevelData) do
			if self:canBuildingLvUp(buildId) then
				return true
			end
		end
	end
end

function ActivityDataSendHero:checkNew()
	if self:checkDispatchNew() then
		return true
	end

	if self:checkBuildingNew() then
		return true
	end

	return false
end

function ActivityDataSendHero:onServerStateChange(opActState)
	self.actObject:checkNew()
end

function ActivityDataSendHero:getSendState()
	if self.serverData.dispatchFinish == 1 and self.serverData.dispatchTick + self.dispatchCostTime > ClientUtils.getServerTime() then
		return {
			1,
			self.serverData.dispatchTick + self.dispatchCostTime - ClientUtils.getServerTime(),
			self.serverData.dispatchCount
		}
	elseif self.serverData.dispatchFinish == 2 or self.serverData.dispatchFinish == 1 then
		return {
			0,
			self.serverData.dispatchCount
		}
	else
		return {
			2,
			self.serverData.dispatchCount
		}
	end
end

function ActivityDataSendHero:getBuildingLevel(buildId)
	if self.serverData.buidingData then
		return self.serverData.buidingData[buildId] or 0
	end

	return 0
end

function ActivityDataSendHero:canBuildingLvUp(buildId)
	local nowLevel = 0

	if self.serverData.buidingData[buildId] then
		nowLevel = self.serverData.buidingData[buildId] or 0
	end

	local buildingData = self.buildingLevelData[buildId]

	if buildingData[nowLevel] and buildingData[nowLevel + 1] then
		local needNum = buildingData[nowLevel].cost or 0
		local hasNum = ClientUtils.getMoney(self.miscData.build_item_id)

		return needNum <= hasNum
	end

	return false
end

return ActivityDataSendHero
