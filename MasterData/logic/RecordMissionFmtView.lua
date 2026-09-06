-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/RecordMissionFmtView.lua

module(..., package.seeall)

local RecordMissionFmtView = class("RecordMissionFmtView", MissionFmtView)

function RecordMissionFmtView:_refreshFromation()
	local data = self._viewPresentor._openParam[1]
	local enemyPlayer = data.enemyPlayer
	local zdlRadix = enemyPlayer.zdl
	local speed = enemyPlayer.speed
	local form = enemyPlayer.form
	local heroSkillId = form.extParams.heroSkillId
	local fid = form.extParams.formStrengthId
	local flv = form.extParams.formStrengthLv
	local teams, formations = self:getTeamAndFormation()

	self:_createExtParams(formations)
	self:initFormation(formations, teams, heroSkillId, fid, flv)
	self:_setFmtParams(heroSkillId, speed, zdlRadix)
end

function RecordMissionFmtView:getTeamAndFormation()
	local data = self._viewPresentor._openParam[1]
	local enemyPlayer = data.enemyPlayer
	local petInfos = enemyPlayer.petInfos
	local form = enemyPlayer.form
	local petZdlList = enemyPlayer.petZdlList
	local teams = {}
	local formations = {}

	for i = 1, 9 do
		local petInfo = petInfos[form.pos[i]]

		if petInfo then
			local petMo = FightingPowerPetMo.fromBasePetView(petInfo, nil, i)

			for i, _petZdl in ipairs(petZdlList or {}) do
				if _petZdl.petId == petInfo.petId then
					petMo._zdl = _petZdl.zdl

					break
				end
			end

			formations[i] = petMo

			table.insert(teams, petMo)
		end
	end

	return teams, formations
end

return RecordMissionFmtView
