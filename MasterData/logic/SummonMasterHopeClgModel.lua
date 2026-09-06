-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/model/SummonMasterHopeClgModel.lua

module("logic.extensions.summonmasterhopeclg.model.SummonMasterHopeClgModel", package.seeall)

local SummonMasterHopeClgModel = class("SummonMasterHopeClgModel", BaseModel)

function SummonMasterHopeClgModel:ctor()
	return
end

function SummonMasterHopeClgModel:onInit()
	self:onReset()
end

function SummonMasterHopeClgModel:onReset()
	self._ModelPool = {}
	self._customFmtMoPool = {}
end

function SummonMasterHopeClgModel:GetModel(activityId)
	if self._ModelPool[activityId] == nil then
		local cur = {}

		cur.curFightTagInfos = {}
		cur.stageInfos = {}
		cur.hasGainPrize = false
		self._ModelPool[activityId] = cur
	end

	return self._ModelPool[activityId]
end

function SummonMasterHopeClgModel:getCustomFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = SummonMasterHopeClgCustomFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function SummonMasterHopeClgModel:handlePM_SummonMasterHopeClgGetInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.hasGainPrize = msg.hasGainPrize or false
	curModel.stageInfos = msg.stageInfo or {}
	self._ModelPool[msg.activityId] = curModel
end

function SummonMasterHopeClgModel:handlePM_SummonMasterHopeClgNotifyFightResultRes(msg)
	local curModel = self:GetModel(msg.activityId)

	if msg.win then
		curModel.curFightTagInfos = msg.curFightTagInfo
		curModel.stageInfos[msg.stageId] = msg.stageInfo
	else
		curModel.curFightTagInfos = nil
	end
end

function SummonMasterHopeClgModel:getTagsNum(activityId, stageId)
	local curModel = self:GetModel(activityId)
	local stageInfo = self:getStageInfo(activityId, stageId)
	local tagsNumArr = {
		0,
		0,
		0
	}

	if stageInfo then
		local tagsInfo = stageInfo.tagInfo

		if tagsInfo then
			for i, v in ipairs(tagsInfo) do
				tagsNumArr[v.left] = v.right
			end
		end
	end

	return tagsNumArr
end

function SummonMasterHopeClgModel:getAllTagsNum(activityId)
	local curModel = self:GetModel(activityId)
	local tagsNumArr = {
		0,
		0,
		0
	}

	if curModel.stageInfos and #curModel.stageInfos > 0 then
		for i, stageInfo in pairs(curModel.stageInfos) do
			local arr = self:getTagsNum(activityId, stageInfo.stageId)

			tagsNumArr[1] = tagsNumArr[1] + arr[1]
			tagsNumArr[2] = tagsNumArr[2] + arr[2]
			tagsNumArr[3] = tagsNumArr[3] + arr[3]
		end
	end

	return tagsNumArr
end

function SummonMasterHopeClgModel:isPass(activityId, stageId)
	local curModel = self:GetModel(activityId)

	if #curModel.stageInfos > 0 then
		for i, v in pairs(curModel.stageInfos) do
			if stageId == v.stageId then
				return v.passed
			end
		end
	end

	return false
end

function SummonMasterHopeClgModel:allStageIsPass(activityId)
	local stageNums = SummonMasterHopeClgConfig.instance:getStageNum(activityId)

	for i = 1, stageNums do
		if not self:isPass(activityId, i) then
			return false
		end
	end

	return true
end

function SummonMasterHopeClgModel:getCurScore(activityId)
	local allTagsNum = self:getAllTagsNum(activityId)

	return allTagsNum[1] * allTagsNum[2] * allTagsNum[3]
end

function SummonMasterHopeClgModel:getStageInfo(activityId, stageId)
	local curModel = self:GetModel(activityId)

	if #curModel.stageInfos > 0 then
		for i, v in pairs(curModel.stageInfos) do
			if stageId == v.stageId then
				return curModel.stageInfos[i]
			end
		end
	end

	return nil
end

SummonMasterHopeClgModel.instance = SummonMasterHopeClgModel.New()

return SummonMasterHopeClgModel
