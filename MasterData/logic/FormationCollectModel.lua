-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/model/FormationCollectModel.lua

module("logic.extensions.masterform.model.FormationCollectModel", package.seeall)

local FormationCollectModel = class("FormationCollectModel", BaseModel)

function FormationCollectModel:onInit()
	self:onReset()
end

function FormationCollectModel:onReset()
	self._gainedFmtIdMap = {}
end

function FormationCollectModel:handlePM_FormationCollectInfoRes(msg)
	self._gainedFmtIdMap = self._gainedFmtIdMap or {}

	table.clear(self._gainedFmtIdMap)

	for _, fmtId in ipairs(msg.gainedFmtIds or {}) do
		self._gainedFmtIdMap[checknumber(fmtId)] = true
	end
end

function FormationCollectModel:handlePM_FormationCollectGetPrizeRes(msg)
	self._gainedFmtIdMap = self._gainedFmtIdMap or {}
	self._gainedFmtIdMap[checknumber(msg.fmtId)] = true
end

function FormationCollectModel:isGainedFmtPrize(fmtId)
	self._gainedFmtIdMap = self._gainedFmtIdMap or {}

	return self._gainedFmtIdMap[checknumber(fmtId)] == true
end

FormationCollectModel.instance = FormationCollectModel.New()

return FormationCollectModel
