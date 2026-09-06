-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/model/DreamPainterModel.lua

module("logic.extensions.dreampainter.model.DreamPainterModel", package.seeall)

local DreamPainterModel = class("DreamPainterModel", BaseModel)

function DreamPainterModel:ctor()
	DreamPainterModel.super.ctor(self)
end

function DreamPainterModel:onInit()
	self:onReset()
end

function DreamPainterModel:onReset()
	self._dreamInfo_map = {}
end

function DreamPainterModel:handleGetInfo(msg)
	local activityId = msg.activityId

	self._dreamInfo_map[activityId] = GameUtil.pbToTable(msg)
end

function DreamPainterModel:getInfo(activityId)
	return self._dreamInfo_map[activityId]
end

function DreamPainterModel:handlePainterVote(msg)
	local activityId = msg.activityId
	local phaseId = msg.phaseId
	local workId = msg.workId
	local info = self._dreamInfo_map[activityId]

	if info then
		info.curPhaseTimes = math.max(0, info.curPhaseTimes - 1)

		for k, p in pairs(info.phase) do
			if p.phaseId == phaseId then
				for i, v in ipairs(p.works) do
					if v.workId == workId then
						v.value = v.value + 1
					end
				end
			end
		end
	end
end

DreamPainterModel.instance = DreamPainterModel.New()

return DreamPainterModel
