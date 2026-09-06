-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/model/PTBatResultInfoMo.lua

module("logic.extensions.peaktournament.model.PTBatResultInfoMo", package.seeall)

local PTBatResultInfoMo = class("PTBatResultInfoMo")

function PTBatResultInfoMo:ctor()
	return
end

function PTBatResultInfoMo:init(resultInfo)
	self._resultInfo = resultInfo or {}
	self._recordFormPool = {}

	if self._resultInfo then
		for _, v in ipairs(self._resultInfo.recordForm) do
			self._recordFormPool[v.formId] = v
		end
	end
end

function PTBatResultInfoMo:getRoundId()
	return self._resultInfo.roundId or 0
end

function PTBatResultInfoMo:isWin(isMe)
	if not self._resultInfo.win then
		local isWin = false

		if not isMe then
			isWin = not self._resultInfo.win
		end

		return self._resultInfo.win
	end
end

function PTBatResultInfoMo:getUserInfo(isMe)
	local userInfo

	return isMe and self._resultInfo.myInfo or self._resultInfo.opInfo or {}
end

function PTBatResultInfoMo:getHeadInfo(isMe)
	return self:getUserInfo(isMe).headInfo
end

function PTBatResultInfoMo:getUserId(isMe)
	local headInfo = self:getUserInfo(isMe).headInfo

	return (headInfo or nil) and (headInfo.userId or 0)
end

function PTBatResultInfoMo:getUserName(isMe)
	local headInfo = self:getUserInfo(isMe).headInfo

	return (headInfo or nil) and (headInfo.userName or "？？？")
end

function PTBatResultInfoMo:getEverMaxZdl(isMe)
	return self:getUserInfo(isMe).everMaxZdl or 0
end

function PTBatResultInfoMo:getGuessNums(isMe)
	return self:getUserInfo(isMe).guessNums or 0
end

function PTBatResultInfoMo:getRankScore(isMe)
	return self:getUserInfo(isMe).rankScore or 0
end

function PTBatResultInfoMo:getClothes(isMe)
	return self:getUserInfo(isMe).clothes
end

function PTBatResultInfoMo:getGender(isMe)
	return self:getUserInfo(isMe).gender
end

function PTBatResultInfoMo:getAreaId(isMe)
	return self:getUserInfo(isMe).areaId or -1
end

function PTBatResultInfoMo:getUserNameAddAreaId(isMe)
	local userName = self:getUserName(isMe)
	local areaId = self:getAreaId(isMe)

	return PeakTournamentController.instance:getFormatUserName(userName, areaId)
end

function PTBatResultInfoMo:getRecordForm(formId)
	return self._recordFormPool[formId]
end

function PTBatResultInfoMo:getFormCount()
	return #self._resultInfo.recordForm
end

function PTBatResultInfoMo:getBattleIdList()
	local battleIdList = {}

	for formId = 1, 3 do
		local battleId = self:getBattleId(formId)

		if checknumber(battleId) > 0 then
			table.insert(battleIdList, battleId)
		end
	end

	return battleIdList
end

function PTBatResultInfoMo:getBattleId(formId)
	return (self._recordFormPool[formId] or nil) and self._recordFormPool[formId].battleId
end

function PTBatResultInfoMo:getTeamId(formId)
	return (self._recordFormPool[formId] or nil) and self._recordFormPool[formId].teamId
end

function PTBatResultInfoMo:isA(formId, isMe)
	local isA = false
	local recordForm = self:getRecordForm(formId)

	if recordForm then
		local teamId = recordForm.teamId

		if teamId == -1 then
			isA = isMe
		elseif teamId == 0 then
			isA = isMe == true
		elseif teamId == 1 then
			isA = isMe == false
		end
	end

	return isA
end

function PTBatResultInfoMo:getPetInfoList(formId, isMe)
	local petInfoList
	local recordForm = self:getRecordForm(formId)

	return (recordForm or nil) and (self:isA(formId, isMe) and recordForm.playerAPets or recordForm.playerBPets)
end

function PTBatResultInfoMo:getPlayerZdl(formId, isMe)
	local playerZdl
	local recordForm = self:getRecordForm(formId)

	return (recordForm or nil) and (self:isA(formId, isMe) and recordForm.playerAZdl or recordForm.playerBZdl)
end

function PTBatResultInfoMo:isWinInForm(formId, isMe)
	local isWin
	local recordForm = self:getRecordForm(formId)

	return (recordForm or nil) and (self:isA(formId, isMe) and recordForm.isPlayerAWin or not recordForm.isPlayerAWin)
end

return PTBatResultInfoMo
