-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/model/ElfKingPathModel.lua

module("logic.extensions.elfkingpath.model.ElfKingPathModel", package.seeall)

local ElfKingPathModel = class("ElfKingPathModel", BaseModel)

function ElfKingPathModel:onInit()
	self:onReset()
end

function ElfKingPathModel:onReset()
	self._curInfo = nil
end

function ElfKingPathModel:handlePM_ElfKingPathInfoRes(msg)
	self._curInfo = msg
end

function ElfKingPathModel:getCurInfo()
	return self._curInfo
end

function ElfKingPathModel:handleNotifyChallenge(msg)
	local isWin = msg.isWin

	if not isWin then
		return
	end

	if not self._curInfo then
		return
	end

	local stageId = msg.stageId
	local sonStageId = msg.sonStageId

	if not self._curInfo.stageInfos then
		for i, v in ipairs(self._curInfo.stageInfos) do
			if v.stageId == stageId then
				if sonStageId > v.maxPassSonStageId then
					v.maxPassSonStageId = sonStageId
				end

				return
			end
		end
	end
end

function ElfKingPathModel:isStagePassed(stageId)
	if not self._curInfo then
		return false
	end

	if not self._curInfo.stageInfos then
		local stageInfos = {}

		for i, v in ipairs(stageInfos) do
			if v.stageId == stageId then
				local sonStageCfgs = ElfKingPathConfig.instance:getSonStageCfgsByStageId(stageId)

				if v.maxPassSonStageId >= #sonStageCfgs then
					return true
				end
			end
		end

		return false
	end
end

ElfKingPathModel.instance = ElfKingPathModel.New()

return ElfKingPathModel
