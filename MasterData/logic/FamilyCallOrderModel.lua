-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/model/FamilyCallOrderModel.lua

module("logic.extensions.newfamily.model.FamilyCallOrderModel", package.seeall)

local FamilyCallOrderModel = class("FamilyCallOrderModel", BaseModel)

function FamilyCallOrderModel:ctor()
	self._familSummonCommandInfos = nil
	self._familySummonCommandGainPrize = nil
	self._familySummonCommandViewFamilyRank = nil
	self._familySummonCommandViewMemberRank = nil
end

function FamilyCallOrderModel:onInit()
	FamilyCallOrderModel.super.onInit(self)
	self:onReset()
end

function FamilyCallOrderModel:onReset()
	self._familSummonCommandInfos = nil
	self._familySummonCommandGainPrize = nil
	self._familySummonCommandViewFamilyRank = nil
	self._familySummonCommandViewMemberRank = nil
end

function FamilyCallOrderModel:getFamilSummonCommandGetInfo()
	if self._familSummonCommandInfos ~= nil then
		return self._familSummonCommandInfos
	end

	return {}
end

function FamilyCallOrderModel:getFamilGainedProgressPrizeIds()
	if self._familSummonCommandInfos ~= nil then
		return self._familSummonCommandInfos.gainedProgressPrizeIds
	end
end

function FamilyCallOrderModel:setFamilSummonCommandGetInfo(msg)
	self._familSummonCommandInfos = {}

	if msg ~= nil then
		self._familSummonCommandInfos = msg
	end
end

function FamilyCallOrderModel:setFamilySummonCommandGainPrizeRes(msg)
	self._familySummonCommandGainPrize = {}

	if msg ~= nil then
		self._familySummonCommandGainPrize = msg
	end
end

function FamilyCallOrderModel:getFamilySummonCommandGainPrizeRes()
	if self._familySummonCommandGainPrize ~= nil then
		return self._familySummonCommandGainPrize
	end

	return {}
end

function FamilyCallOrderModel:getFamilySummonCommandViewFamilyRank()
	if self._familySummonCommandViewFamilyRank ~= nil then
		return self._familySummonCommandViewFamilyRank
	end

	return {}
end

function FamilyCallOrderModel:getFamilySummonCommandViewFamilyRankInfos()
	if self._familySummonCommandViewFamilyRank ~= nil then
		return self._familySummonCommandViewFamilyRank.familyRankInfos
	end

	return {}
end

function FamilyCallOrderModel:setFamilySummonCommandViewFamilyRank(msg)
	self._familySummonCommandViewFamilyRank = {}

	if msg ~= nil then
		self._familySummonCommandViewFamilyRank = msg
	end
end

function FamilyCallOrderModel:getFamilySummonCommandViewMemberRank()
	if self._familySummonCommandViewMemberRank ~= nil then
		return self._familySummonCommandViewMemberRank
	end

	return {}
end

function FamilyCallOrderModel:getFamilySummonCommandViewMemberRankInfos()
	if self._familySummonCommandViewMemberRank ~= nil then
		return self._familySummonCommandViewMemberRank.memberRankInfos
	end

	return {}
end

function FamilyCallOrderModel:setFamilySummonCommandViewMemberRank(msg)
	if msg ~= nil then
		self._familySummonCommandViewMemberRank = msg
	end
end

function FamilyCallOrderModel:clearAllInfo()
	self._familSummonCommandInfos = nil
	self._familySummonCommandGainPrize = nil
	self._familySummonCommandViewFamilyRank = nil
	self._familySummonCommandViewMemberRank = nil
end

FamilyCallOrderModel.instance = FamilyCallOrderModel.New()

return FamilyCallOrderModel
