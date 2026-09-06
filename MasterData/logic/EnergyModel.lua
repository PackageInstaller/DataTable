-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/energy/model/EnergyModel.lua

module("logic.extensions.strength.model.EnergyModel", package.seeall)

local EnergyModel = class("EnergyModel", BaseModel)

EnergyModel.ENERGYMODEL_UPDATEENERGYLIST = "EnergyModel_UpdateEnergyList"

function EnergyModel:ctor()
	EnergyModel.super.ctor(self)
end

function EnergyModel:onInit()
	self:onReset()
end

function EnergyModel:onReset()
	self._energyList = {}
end

function EnergyModel:getEnergyList()
	return self._energyList
end

function EnergyModel:getCurEnergy(id)
	for k, v in ipairs(self._energyList) do
		if v.id == id then
			return v.totalCount
		end
	end

	return 0
end

function EnergyModel:getCurEnergyLeftTime(id)
	for k, v in ipairs(self._energyList) do
		if v.id == id then
			return v.nextLeftTime
		end
	end

	return 0
end

function EnergyModel:setEnergyInfo(info)
	local exist = false

	for k, v in ipairs(self._energyList) do
		if v.id == info.id then
			v.id = checknumber(info.id)
			v.totalCount = checknumber(info.totalCount)
			v.nextLeftTime = checknumber(info.nextLeftTime)
			v.dailyCount = checknumber(info.dailyCount)
			v.dailyBuyTimes = checknumber(info.dailyBuyTimes)
			exist = true
		end
	end

	if not exist then
		local v = {}

		v.id = checknumber(info.id)
		v.totalCount = checknumber(info.totalCount)
		v.nextLeftTime = checknumber(info.nextLeftTime)
		v.dailyCount = checknumber(info.dailyCount)
		v.dailyBuyTimes = checknumber(info.dailyBuyTimes)

		table.insert(self._energyList, v)
	end

	GlobalDispatcher:dispatch(EnergyModel.ENERGYMODEL_UPDATEENERGYLIST)
end

function EnergyModel:setAllEnergyInfo(infos)
	self:clearEnergyList()

	for _, info in pairs(infos) do
		if info.id ~= nil then
			table.insert(self._energyList, info)
		end
	end

	GlobalDispatcher:dispatch(EnergyModel.ENERGYMODEL_UPDATEENERGYLIST)
end

function EnergyModel:setEnergyLeftTime(msg)
	for k, v in ipairs(self._energyList) do
		if v.id == msg.id then
			v.totalCount = msg.totalCount
			v.nextLeftTime = msg.nextLeftTime
		end
	end
end

function EnergyModel:clearEnergyList()
	table.clear(self._energyList)
end

EnergyModel.instance = EnergyModel.New()

return EnergyModel
