-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/model/PhantomSpaceModel.lua

module("logic.extensions.phantomspace.model.PhantomSpaceModel", package.seeall)

local PhantomSpaceModel = class("PhantomSpaceModel", BaseModel)

function PhantomSpaceModel:onInit()
	self:onReset()
end

function PhantomSpaceModel:onReset()
	self._msgPool = {}
	self._rankInfoPool = {}
	self._enemyOtherPlayerViewPb = {}
	self._endlessInfoPool = {}
	self._pageFmtInfoPool = {}
	self._stageFormPool = {}
end

function PhantomSpaceModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg)
	local stageKey = pb.stageKey
	local list = PhantomSpaceConfig.instance:getStageListCfgById(stageKey.activityId, 0) or {}

	if stageKey.mode == 0 and stageKey.stageId >= #list then
		stageKey.mode = 1
		stageKey.stageId = 0
	end

	if stageKey.mode == 1 and stageKey.stageId >= #list then
		stageKey.stageId = 0
		stageKey.buffLv = stageKey.buffLv + 1
	end

	self._msgPool[stageKey.activityId] = pb
	self._enemyOtherPlayerViewPb[stageKey.activityId] = msg.phantomMonster
end

function PhantomSpaceModel:onResetInfo(msg)
	local pb = GameUtil.pbToTable(msg)
	local stageKey = pb.stageKey
	local info = self._msgPool[stageKey.activityId]

	if info then
		stageKey.stageId = stageKey.stageId - 1
		info.stageKey = stageKey
		info.phantomMonster = nil
		self._enemyOtherPlayerViewPb[stageKey.activityId] = nil
	end
end

function PhantomSpaceModel:onGetRankInfo(msg)
	self._rankInfoPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function PhantomSpaceModel:getRankInfo(activityId)
	return self._rankInfoPool[activityId]
end

function PhantomSpaceModel:onGetFighMsg(msg)
	local pb = GameUtil.pbToTable(msg)
	local stageKey = pb.stageKey
	local info = self._msgPool[stageKey.activityId]

	if info then
		if pb.phantomMonster then
			stageKey.stageId = stageKey.stageId - 1
		end

		info.stageKey = stageKey
		info.phantomMonster = pb.phantomMonster
		self._enemyOtherPlayerViewPb[stageKey.activityId] = msg.phantomMonster
	end
end

function PhantomSpaceModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function PhantomSpaceModel:getPhantomMonsterPb(activityId)
	return self._enemyOtherPlayerViewPb[activityId]
end

function PhantomSpaceModel:getEndlessInfo(activityId)
	return self._endlessInfoPool[activityId]
end

function PhantomSpaceModel:getEndlessInfoBystageId(activityId, stageId)
	local stageFormMap = self._stageFormPool[activityId]

	return stageFormMap[stageId]
end

function PhantomSpaceModel:handlePM_PhantomSpaceGetEndlessInfoRes(msg)
	self._endlessInfoPool[msg.activityId] = GameUtil.pbToTable(msg)
	self._stageFormPool[msg.activityId] = self._stageFormPool[msg.activityId] or {}

	local endlessInfo = self._endlessInfoPool[msg.activityId]
	local stageFormMap = self._stageFormPool[msg.activityId]

	endlessInfo.forms = endlessInfo.forms or {}

	for _, form in ipairs(endlessInfo.forms) do
		form.formPetFaceIdMap = form.formPetFaceIdMap or {}

		local formPetFaceIdMap = form.formPetFaceIdMap

		if form.formPetFaceIds then
			for i, pair in ipairs(form.formPetFaceIds) do
				formPetFaceIdMap[pair.left] = pair.right
			end
		end

		stageFormMap[form.stageId] = form
	end
end

function PhantomSpaceModel:handlePM_PhantomSpaceResetEndlessRes(msg)
	local info = self:getEndlessInfo(msg.activityId)
	local stageFormMap = self._stageFormPool[msg.activityId]

	if checknumber(msg.stageId) > 0 then
		local stageId = checknumber(msg.stageId)

		stageFormMap[stageId] = nil
		info.endlessCurStageId = info.endlessCurStageId - 1
	else
		for i = 1, info.endlessCurStageId do
			stageFormMap[i] = nil
		end

		info.endlessCurStageId = 0
	end
end

function PhantomSpaceModel:handlePM_Notify_PhantomSpaceEndlessChallengeResult(msg)
	local info = self:getEndlessInfo(msg.activityId)
	local stageFormMap = self._stageFormPool[msg.activityId]

	if msg.win then
		local pb = GameUtil.pbToTable(msg)
		local stageId = checknumber(pb.stageId)
		local form = pb.form

		form.formPetFaceIdMap = form.formPetFaceIdMap or {}

		local formPetFaceIdMap = form.formPetFaceIdMap

		if form.formPetFaceIds then
			for i, pair in ipairs(form.formPetFaceIds) do
				formPetFaceIdMap[pair.left] = pair.right
			end
		end

		info.endlessCurStageId = info.endlessCurStageId + 1
		stageFormMap[stageId] = form

		table.insert(info.forms, form)
	end
end

PhantomSpaceModel.instance = PhantomSpaceModel.New()

return PhantomSpaceModel
