-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/model/MagicSchoolModel.lua

module("logic.extensions.magicschool.model.MagicSchoolModel", package.seeall)

local MagicSchoolModel = class("MagicSchoolModel", BaseModel)

function MagicSchoolModel:onInit()
	self:onReset()
end

function MagicSchoolModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._changeSetIdList = {}
end

function MagicSchoolModel:getInfo(activityId)
	return self._infos[activityId]
end

function MagicSchoolModel:pushChangeSetId(changeSetId)
	table.insert(self._changeSetIdList, changeSetId)
end

function MagicSchoolModel:popChangeSetId()
	local changeSetIdNum = #self._changeSetIdList

	if changeSetIdNum > 0 then
		return table.remove(self._changeSetIdList, #self._changeSetIdList)
	end
end

function MagicSchoolModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = MagicSchoolFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function MagicSchoolModel:handlePM_MagicSchoolGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.invitePrizeIds = msg.invitePrizeIds or {}
	info.levelPrizeIds = msg.levelPrizeIds or {}
end

function MagicSchoolModel:handlePM_MagicSchoolVisitRes(msg)
	local info = self._infos[msg.activityId]

	table.insert(info.invitePrizeIds, msg.prizeId)
end

function MagicSchoolModel:handlePM_MagicSchoolJoinCampRes(msg)
	local info = self._infos[msg.activityId]

	info.campId = msg.campId
end

function MagicSchoolModel:handlePM_MagicSchoolSelectBuffRes(msg)
	local info = self._infos[msg.activityId]

	info.curSelectBuffId = msg.buffId
end

function MagicSchoolModel:handlePM_MagicSchoolGainLevelPrizeRes(msg)
	local info = self._infos[msg.activityId]

	table.insert(info.levelPrizeIds, msg.level)
end

MagicSchoolModel.instance = MagicSchoolModel.New()

return MagicSchoolModel
