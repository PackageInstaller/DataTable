-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/soldierSkillMo/SoliderSkillMOBase.lua

module("modules.logic.versionactivity2_2.eliminate.model.soldierSkillMo.SoliderSkillMOBase", package.seeall)

local SoliderSkillMOBase = class("SoliderSkillMOBase")

function SoliderSkillMOBase:init(soliderId, soliderUid, strongholdId)
	self._soldierId = soliderId
	self._uid = soliderUid
	self._strongholdId = strongholdId
	self._selectSoliderIds = {}

	self:initSkill()
end

function SoliderSkillMOBase:initSkill()
	local teamType, count, limitStrongHold = EliminateTeamChessModel.instance:getSoliderIdEffectParam(self._soldierId)

	if teamType ~= nil then
		self._needSelectSoliderCount = count
		self._needSelectSoliderType = teamType

		if limitStrongHold then
			local isHave = EliminateTeamChessModel.instance:haveSoliderByTeamTypeAndStrongholdId(self._needSelectSoliderType, self._strongholdId or nil)

			if isHave then
				self._needSelectSoliderCount = self._needSelectSoliderCount or 0
			end
		end
	else
		self._needSelectSoliderCount = 0
	end
end

function SoliderSkillMOBase:setSelectSoliderId(uid)
	if self:canRelease() then
		return true
	end

	local uidNum = tonumber(uid)

	if uidNum == EliminateTeamChessEnum.tempPieceUid then
		return false
	end

	local playerType = EliminateTeamChessEnum.TeamChessTeamType.player
	local enemyType = EliminateTeamChessEnum.TeamChessTeamType.enemy

	if uidNum > 0 and self._needSelectSoliderType == playerType or uidNum < 0 and self._needSelectSoliderType == enemyType then
		table.insert(self._selectSoliderIds, uid)

		return true
	end

	return false
end

function SoliderSkillMOBase:getNeedSelectSoliderType()
	return self._needSelectSoliderType
end

function SoliderSkillMOBase:canRelease()
	if self._needSelectSoliderCount then
		return #self._selectSoliderIds >= self._needSelectSoliderCount
	end

	return true
end

function SoliderSkillMOBase:_getReleaseExParam()
	if self._selectSoliderIds and #self._selectSoliderIds > 0 then
		return self._selectSoliderIds[1]
	end

	return ""
end

function SoliderSkillMOBase:needClearTemp()
	return self._needSelectSoliderCount > 0
end

function SoliderSkillMOBase:releaseSkill(cb, cbTarget)
	if self:canRelease() then
		local exParam = self:_getReleaseExParam()

		EliminateTeamChessController.instance:sendWarChessPiecePlaceRequest(self._soldierId, self._uid, self._strongholdId, exParam, cb, cbTarget)
	end

	return self:canRelease()
end

return SoliderSkillMOBase
