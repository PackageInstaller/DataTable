-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/model/NaiLongEvolveModel.lua

module("logic.extensions.nailongevolve.model.NaiLongEvolveModel", package.seeall)

local NaiLongEvolveModel = class("NaiLongEvolveModel", BaseModel)

function NaiLongEvolveModel:onInit()
	self:onReset()
end

function NaiLongEvolveModel:onReset()
	self._customFmtMoPool = {}
	self._infos = {}
end

function NaiLongEvolveModel:getInfo(activityId)
	return self._infos[activityId]
end

function NaiLongEvolveModel:handlePM_MilkDragonClgGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._infos[msg.activityId].posType2Lvl = msg.posType2Lvl or {}

	local posType2LvlDic = {}

	for i, v in ipairs(msg.posType2Lvl) do
		posType2LvlDic[v.left] = v.right
	end

	self._infos[msg.activityId].posType2LvlDic = posType2LvlDic
end

function NaiLongEvolveModel:handlePM_MilkDragonClgSignInRes(msg)
	local info = self:getInfo(msg.activityId)

	info.signInDays = msg.signInDays
	info.curScore = msg.curScore
	info.todayHasSignIn = msg.todayHasSignIn
end

function NaiLongEvolveModel:handlePM_MilkDragonClgPosLvlUpRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.curScore = msg.curScore
	info.consumedScore = msg.consumedScore
	info.posType2LvlDic[msg.posType] = msg.lvl
end

function NaiLongEvolveModel:handlePM_MilkDragonClgResetPosLvlRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	info.curScore = msg.curScore
	info.consumedScore = msg.consumedScore
	info.posType2LvlDic = {}
end

function NaiLongEvolveModel:handlePM_NotifyMilkDragonFightEndRes(msg)
	if msg.win then
		local activityId = msg.activityId
		local info = self:getInfo(activityId)

		info.curScore = msg.curScore
		info.curPassStageId = msg.curPassStageId
	end
end

function NaiLongEvolveModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = NaiLongEvolveFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

NaiLongEvolveModel.instance = NaiLongEvolveModel.New()

return NaiLongEvolveModel
