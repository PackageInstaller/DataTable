-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/model/OriginaruishiclgModel.lua

module("logic.extensions.originaruishiclg.view.OriginaruishiclgModel", package.seeall)

local OriginaruishiclgModel = class("OriginaruishiclgModel", BaseModel)

function OriginaruishiclgModel:ctor()
	return
end

function OriginaruishiclgModel:onInit()
	self:onReset()
end

function OriginaruishiclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = OriginaruishiclgFmtMo.New()
end

function OriginaruishiclgModel:setInfo(msg)
	self._msgInfos = self._msgInfos or {}
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].stageId = self._msgInfos[msg.activityId].stageId or {}
end

function OriginaruishiclgModel:getInfo(activityId)
	return self._msgInfos and self._msgInfos[activityId]
end

function OriginaruishiclgModel:getFmtMo()
	return self._fmtMo
end

function OriginaruishiclgModel:onChallengeResultRes(msg)
	if not msg.isWin then
		return
	end

	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	table.insert(info.stageId, msg.stageId)
end

function OriginaruishiclgModel:isStagePass(activityId, stageId)
	local info = self:getInfo(activityId)

	return table.indexof(info.stageId, stageId)
end

function OriginaruishiclgModel:isFloorPass(activityId, floorId)
	local info = self:getInfo(activityId)
	local stageCfgs = OriginaruishiclgConfig.instance:getFloorCfg(activityId, floorId)
	local isPass = true

	for i, v in ipairs(stageCfgs) do
		if not self:isStagePass(activityId, v.stageId) then
			isPass = false

			break
		end
	end

	return isPass
end

function OriginaruishiclgModel:getFloorPassNum(activityId, floorId)
	local stageCfgs = OriginaruishiclgConfig.instance:getFloorCfg(activityId, floorId)
	local totalNum = #stageCfgs
	local passNum = 0

	for i, v in ipairs(stageCfgs) do
		if self:isStagePass(activityId, v.stageId) then
			passNum = passNum + 1
		end
	end

	return passNum, totalNum
end

OriginaruishiclgModel.instance = OriginaruishiclgModel.New()

return OriginaruishiclgModel
