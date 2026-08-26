-- chunkname: @modules/logic/rouge2/common/model/Rouge2_InfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_InfoMO", package.seeall)

local Rouge2_InfoMO = pureTable("Rouge2_InfoMO")

function Rouge2_InfoMO:init(info)
	self.state = info.state
	self.difficulty = info.difficulty
	self.coin = info.coin
	self.endId = info.endId
	self.gameNum = info.gameNum

	self:updateLeaderInfo(info.leaderInfo)
	self:updateAttrGroupInfo(info.attrInfo)
	self:updateAlchemyInfo(info)
	Rouge2_BackpackModel.instance:updateBagInfo(info.bagInfo)
end

function Rouge2_InfoMO:isContinueLast()
	return self.state ~= Rouge2_Enum.State.Empty and self.state ~= Rouge2_Enum.State.isEnd
end

function Rouge2_InfoMO:isStart()
	return self.state == Rouge2_Enum.State.Start
end

function Rouge2_InfoMO:getLeaderInfo()
	return self._leaderInfo
end

function Rouge2_InfoMO:updateLeaderInfo(leaderInfo)
	self._leaderInfo = self._leaderInfo or Rouge2_LeaderInfoMO.New()

	self._leaderInfo:init(leaderInfo)
end

function Rouge2_InfoMO:updateAttrGroupInfo(attrGroupInfo)
	self._attrGroupInfo = self._attrGroupInfo or Rouge2_AttrGroupMO.New()

	self._attrGroupInfo:init(attrGroupInfo)
end

function Rouge2_InfoMO:updateAlchemyInfo(rougeInfo)
	if not rougeInfo:HasField("alchemyInfo") then
		self._alchemyInfo = nil

		return
	end

	self._alchemyInfo = self._alchemyInfo or Rouge2_GameCurAlchemyInfoMO.New()

	self._alchemyInfo:init(rougeInfo.alchemyInfo)
end

function Rouge2_InfoMO:updateAttrInfoList(updates)
	if self._attrGroupInfo then
		self._attrGroupInfo:updateAttrInfoList(updates)
	end
end

function Rouge2_InfoMO:getAttrGroupInfo()
	return self._attrGroupInfo
end

function Rouge2_InfoMO:getCurAlchemyInfo()
	return self._alchemyInfo
end

return Rouge2_InfoMO
