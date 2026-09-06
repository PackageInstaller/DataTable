-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/model/DivineMiMengLiClgModel.lua

module("logic.extensions.divinemimengliclg.model.DivineMiMengLiClgModel", package.seeall)

local DivineMiMengLiClgModel = class("DivineMiMengLiClgModel", BaseModel)

function DivineMiMengLiClgModel:onInit()
	self:onReset()
end

function DivineMiMengLiClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._customFmtMos = {}
end

function DivineMiMengLiClgModel:getDivineMmlClgMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DivineMmlClgMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DivineMiMengLiClgModel:getDivineMiMengLiClgFmtMo(activityId, stageType)
	if self._customFmtMos[stageType] == nil then
		if stageType == DivineMmlClgEnum.StageType_One then
			self._customFmtMos[stageType] = DivineMiMengLiClgOneFmtMo.New()
		elseif stageType == DivineMmlClgEnum.StageType_Two then
			self._customFmtMos[stageType] = DivineMiMengLiClgTwoFmtMo.New()
		elseif stageType == DivineMmlClgEnum.StageType_Three then
			self._customFmtMos[stageType] = DivineMiMengLiClgThreeFmtMo.New()
		end
	end

	return self._customFmtMos[stageType]
end

DivineMiMengLiClgModel.instance = DivineMiMengLiClgModel.New()

return DivineMiMengLiClgModel
