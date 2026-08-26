-- chunkname: @modules/logic/versionactivity1_3/armpipe/model/Activity124RewardListModel.lua

module("modules.logic.versionactivity1_3.armpipe.model.Activity124RewardListModel", package.seeall)

local Activity124RewardListModel = class("Activity124RewardListModel", ListScrollModel)

function Activity124RewardListModel:init(actId)
	local dataList = {}
	local episodeCfgList = Activity124Config.instance:getEpisodeList(actId)

	for _, episodeCfg in ipairs(episodeCfgList) do
		local mo = Activity124RewardMO.New()

		mo:init(episodeCfg)
		table.insert(dataList, mo)
	end

	table.sort(dataList, Activity124RewardListModel.sortMO)
	self:setList(dataList)
end

function Activity124RewardListModel.sortMO(objA, objB)
	local isHasReardA = objA:isHasReard()
	local isHasReardB = objB:isHasReard()

	if isHasReardA ~= isHasReardB then
		return isHasReardA
	end

	local receivedA = objA:isReceived()
	local receivedB = objB:isReceived()

	if receivedA ~= receivedB then
		return receivedB
	end

	if objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

Activity124RewardListModel.instance = Activity124RewardListModel.New()

return Activity124RewardListModel
