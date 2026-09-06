-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/model/DoloresModel.lua

module("logic.extensions.doloresclg.model.DoloresModel", package.seeall)

local DoloresModel = class("DoloresModel", BaseModel)

function DoloresModel:onInit()
	self:onReset()
end

function DoloresModel:onReset()
	self._msgPool = {}
end

function DoloresModel:onGetInfo(msg)
	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function DoloresModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function DoloresModel:onResetInfo(msg)
	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info then
		if not info.curStageInfos then
			for i, v in ipairs(info.curStageInfos) do
				if v.stageId == msg.stageId then
					table.remove(info.curStageInfos, i)

					break
				end
			end

			info.curStageInfos = info.curStageInfos
		end
	end
end

function DoloresModel:onGetFighMsg(msg)
	local activityId = msg.activityId
	local win = msg.win
	local lockAttrTypes = msg.lockAttrTypes
	local passPhase = msg.passPhase

	if win then
		local info = self._msgPool[activityId]

		if info then
			if passPhase then
				info.passedPhaseId = checknumber(info.passedPhaseId) + 1
				info.curStageInfos = {}
			elseif not info.curStageInfos then
				local curStageInfos = {}
				local found = false

				for i, v in ipairs(curStageInfos) do
					if v.stageId == msg.stageId then
						v.lockAttrTypes = lockAttrTypes or {}
						found = true

						break
					end
				end

				if not found then
					local tem = {}

					tem.stageId = msg.stageId
					tem.lockAttrTypes = lockAttrTypes or {}

					table.insert(curStageInfos, tem)
				end

				info.curStageInfos = curStageInfos
			end
		end
	end
end

DoloresModel.instance = DoloresModel.New()

return DoloresModel
