-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/model/ForceSlideModel.lua

module("logic.extensions.forceslide.model.ForceSlideModel", package.seeall)

local ForceSlideModel = class("ForceSlideModel", BaseModel)

ForceSlideModel.DataType = {
	SavePet = 4,
	RepairStrength = 5,
	DefeatPet = 6,
	Repair = 1,
	GainLongYan = 3,
	Destory = 2
}

function ForceSlideModel:ctor()
	return
end

function ForceSlideModel:onInit()
	self._tabMap, self._sumMap = nil
end

function ForceSlideModel:onReset()
	return
end

function ForceSlideModel:handleGetInfo(msg)
	self._tabMap = {}
	self._sumMap = {}

	local tabList, sumList = msg.tabList, msg.sumList

	for i = 1, 6 do
		local tab = tabList[i]

		if tab then
			self._tabMap[checknumber(tab.id)] = checknumber(tab.progress)
		end

		local sum = sumList[i]

		if sum then
			self._sumMap[checknumber(sum.id)] = checknumber(sum.sum)
		end
	end
end

function ForceSlideModel:test()
	local msg = {
		tabList = {
			{
				id = 1,
				progress = 11
			},
			{
				id = 2,
				progress = 12
			},
			{
				id = 3,
				progress = 13
			},
			{
				id = 4,
				progress = 14
			},
			{
				id = 5,
				progress = 15
			},
			{
				id = 6,
				progress = 16
			}
		},
		sumList = {
			{
				id = 1,
				sum = 111
			},
			{
				id = 2,
				sum = 152
			}
		}
	}

	self:handleGetInfo(msg)
end

function ForceSlideModel:getActivityId()
	if self._activityId == nil then
		self._activityId = ForceSlideConfig.instance:getActId()
	end

	return self._activityId
end

function ForceSlideModel:getRepairValue()
	return self:_getSumValue(ForceSlideModel.DataType.Repair)
end

function ForceSlideModel:getDestoryValue()
	return self:_getSumValue(ForceSlideModel.DataType.Destory)
end

function ForceSlideModel:getTabValue(index)
	return self:_getTabValue(index)
end

function ForceSlideModel:_getSumValue(index)
	if not self._sumMap then
		return 0
	end

	return checknumber(self._sumMap[index])
end

function ForceSlideModel:_getTabValue(index)
	if not self._tabMap then
		return 0
	end

	return checknumber(self._tabMap[index])
end

ForceSlideModel.instance = ForceSlideModel.New()

return ForceSlideModel
