-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortMissionFmtView.lua

module("logic.extensions.escort.view.EscortMissionFmtView", package.seeall)

local EscortMissionFmtView = class("EscortMissionFmtView", MissionFmtView)

function EscortMissionFmtView:SetAllOtherPetMo(data)
	self.allPetInfos = {}

	local petInfo

	for i, info in ipairs(data or {}) do
		if info and info.petId then
			petInfo = BagPetMo.New()

			petInfo:initBaseView(info)
			table.insert(self.allPetInfos, petInfo)
		end
	end
end

function EscortMissionFmtView:GetOtherPetMo(petId)
	if petId == nil or petId <= 0 then
		return
	end

	if self.allPetInfos == nil or #self.allPetInfos == 0 then
		return
	end

	for i = 1, #self.allPetInfos do
		if self.allPetInfos[i] and self.allPetInfos[i].petId == petId then
			return self.allPetInfos[i]
		end
	end
end

function EscortMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function EscortMissionFmtView:getTeamAndFormation()
	local formations = {}
	local teams = {}
	local enemyInfo = EscortModel.instance:GetBattlePlayer()

	if enemyInfo == nil then
		return teams, formations
	end

	local userId = tonumber(enemyInfo.userId)

	if userId <= 0 then
		local cfgs = EscortConfig.instance:GetRobotFormatInfo(math.abs(userId))

		for i, v in pairs(cfgs) do
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(v, cfgs)
			table.insert(teams, petMo)

			formations[v.posId] = petMo
		end
	else
		if enemyInfo.msg == nil or enemyInfo.msg.playerView == nil then
			return teams, formations
		end

		local playerData = enemyInfo.msg.playerView

		if playerData.petSimpleView == nil or playerData.curForm == nil or playerData.curForm.pos == nil then
			return teams, formations
		end

		self:SetAllOtherPetMo(playerData.petSimpleView)

		local posList = playerData.curForm.pos

		for i, petId in pairs(posList) do
			if petId and checknumber(petId) > 0 then
				local pet = self:GetOtherPetMo(petId)
				local fPetMo = pet:toFightingPowerPetMo(self.allPetInfos)

				table.insert(teams, fPetMo)

				formations[i] = fPetMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function EscortMissionFmtView:_createExtParams(formations)
	local extParams
	local enemyInfo = EscortModel.instance:GetBattlePlayer()

	self:setExtParams((enemyInfo and enemyInfo.msg and enemyInfo.msg.playerView and enemyInfo.msg.playerView.curForm and enemyInfo.msg.playerView.curForm.extParams or nil) and enemyInfo.msg.playerView.curForm.extParams)
end

function EscortMissionFmtView:_setStartOrderTxt()
	local fmtView = self._viewPresentor:getViewByName("FormationLeftView")

	if fmtView then
		return
	end

	local resultList = {}
	local enemyPoses = MissionModel.instance:getEnemyPetPoses() or {}
	local count = #enemyPoses

	for i = 1, count do
		table.insert(resultList, {
			pos = enemyPoses[i],
			text = string.format("%d手", i)
		})
	end

	self:_updateStartOrder(resultList)
end

function EscortMissionFmtView:destroyUI()
	EscortMissionFmtView.super.destroyUI(self)

	self.allPetInfos = nil
end

return EscortMissionFmtView
