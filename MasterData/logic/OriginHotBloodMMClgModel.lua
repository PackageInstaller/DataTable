-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/model/OriginHotBloodMMClgModel.lua

module("logic.extensions.originhotbloodmmclg.model.OriginHotBloodMMClgModel", package.seeall)

local OriginHotBloodMMClgModel = class("OriginHotBloodMMClgModel", BaseModel)

function OriginHotBloodMMClgModel:onInit()
	self:onReset()
end

function OriginHotBloodMMClgModel:onReset()
	self.infos = {}
	self._fmtMo = nil
end

function OriginHotBloodMMClgModel:setInfo(msg)
	self.infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function OriginHotBloodMMClgModel:getPassStage(activityId)
	local info = self.infos[activityId]

	return (info or nil) and (info.stageInfos or 0)
end

function OriginHotBloodMMClgModel:setStageInfo(msg)
	print("OriginHotBloodMMClgModel:setStageInfo")

	local data = GameUtil.pbToTable(msg)

	if data.win then
		local info = self.infos[data.activityId]

		if not info then
			self.infos[data.activityId] = {}
			info = self.infos[data.activityId]
		end

		info.stageInfos = data.stageId
	end
end

function OriginHotBloodMMClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginHotBloodMMClgFmtMo.New()

	return self._fmtMo
end

OriginHotBloodMMClgModel.instance = OriginHotBloodMMClgModel.New()

return OriginHotBloodMMClgModel
