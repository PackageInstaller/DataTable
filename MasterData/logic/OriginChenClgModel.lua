-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/model/OriginChenClgModel.lua

module("logic.extensions.originchenclg.model.OriginChenClgModel", package.seeall)

local OriginChenClgModel = class("OriginChenClgModel", BaseModel)

function OriginChenClgModel:onInit()
	self:onReset()
end

function OriginChenClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._extFmtMo = nil
	self._norFmtMo = nil
end

function OriginChenClgModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = OriginChenClgSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function OriginChenClgModel:getInfo(activityId)
	local mo = self:getSubMo(activityId)

	if mo then
		return mo:getInfo(activityId)
	end

	return nil
end

function OriginChenClgModel:getExtStageInfo(activityId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.extremeStageInfos) do
		if v.stageId == stageId then
			return v
		end
	end
end

function OriginChenClgModel:getExtFmtMo()
	self._extFmtMo = self._extFmtMo or OriginChenClgFmtMoExt.New()

	return self._extFmtMo
end

function OriginChenClgModel:getNorFmtMo()
	self._norFmtMo = self._norFmtMo or OriginChenClgFmtMoNor.New()

	return self._norFmtMo
end

function OriginChenClgModel:onConfirmExtreme(activityId, stageInfo)
	local mo = self:getSubMo(activityId)

	mo:onConfirmExtreme(activityId, stageInfo)
end

OriginChenClgModel.instance = OriginChenClgModel.New()

return OriginChenClgModel
