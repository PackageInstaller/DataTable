-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/model/ShenyaolongzunshengzhuModel.lua

module("logic.extensions.shenyaolongzunshengzhu.model.ShenyaolongzunshengzhuModel", package.seeall)

local ShenyaolongzunshengzhuModel = class("ShenyaolongzunshengzhuModel", BaseModel)

function ShenyaolongzunshengzhuModel:onInit()
	self:onReset()
end

function ShenyaolongzunshengzhuModel:onReset()
	self._msgMap = {}
	self._lastStageId = 0
	self.godRankInfos = nil
	self.godMyRank = -1
	self.dayRankInfos = nil
	self.dayMyRank = -1
end

function ShenyaolongzunshengzhuModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg)
end

function ShenyaolongzunshengzhuModel:onGetGodRank(msg)
	self.godRankInfos = msg.rankInfos
	self.godMyRank = msg.myRank
end

function ShenyaolongzunshengzhuModel:onGetDayRank(msg)
	self.dayRankInfos = msg.rankInfos
	self.dayMyRank = msg.myRank
end

function ShenyaolongzunshengzhuModel:updateStageInfo(activityId, info)
	local tb = self._msgMap[activityId]

	if tb then
		if not tb.stageInfo then
			local isFind = false

			for i, v in ipairs(tb.stageInfo) do
				if v.stageId == info.stageId then
					isFind = true
					tb.stageInfo[i] = info

					break
				end
			end

			if isFind == false then
				table.insert(tb.stageInfo, info)
			end

			tb.stageInfo = tb.stageInfo
		end
	end
end

function ShenyaolongzunshengzhuModel:getStageInfo(activityId, stageId)
	local tb = self._msgMap[activityId]

	if tb then
		for i, v in ipairs(tb.stageInfo or {}) do
			if v.stageId == stageId then
				return v
			end
		end
	end

	return nil
end

function ShenyaolongzunshengzhuModel:getTotalTagTypeCount(activityId, tag)
	local tb = self._msgMap[activityId]

	if tb then
		local num = 0

		for i, v in ipairs(tb.stageInfo or {}) do
			for j, info in ipairs(v.tagInfo or {}) do
				if info.id == tag then
					num = num + info.num
				end
			end
		end

		return num
	end

	return 0
end

function ShenyaolongzunshengzhuModel:setLastStageId(id)
	self._lastStageId = id
end

function ShenyaolongzunshengzhuModel:getLastStageId()
	return self._lastStageId
end

ShenyaolongzunshengzhuModel.instance = ShenyaolongzunshengzhuModel.New()

return ShenyaolongzunshengzhuModel
