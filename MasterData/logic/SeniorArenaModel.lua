-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/model/SeniorArenaModel.lua

module("logic.extensions.seniorarena.model.SeniorArenaModel", package.seeall)

local SeniorArenaModel = class("SeniorArenaModel", BaseModel)

function SeniorArenaModel:ctor()
	return
end

function SeniorArenaModel:onInit()
	self:onReset()
end

function SeniorArenaModel:onReset()
	self._zoneId = -1
	self._opponentFormMos = {}
end

function SeniorArenaModel:setGainBit(value)
	self._gainBit = value
end

function SeniorArenaModel:getBitGained(bit)
	if self._gainBit then
		return GameUtil.isBitOpenByDigit(self._gainBit, bit)
	else
		return false
	end
end

function SeniorArenaModel:setBitGained(bit, isOpen)
	if self._gainBit then
		self._gainBit = GameUtil.setBitByDigit(self._gainBit, bit, isOpen)
	else
		return false
	end
end

function SeniorArenaModel:setMaxTopGroupId(value)
	self._maxTopGroupId = value
end

function SeniorArenaModel:getMaxTopGroupId()
	return checknumber(self._maxTopGroupId)
end

function SeniorArenaModel:setArenaInfo(value)
	self._info = value

	if self._info then
		self._hangUpPrize = self._info.hangUpPrize
	end
end

function SeniorArenaModel:getArenaInfo()
	return self._info
end

function SeniorArenaModel:getSeasonId()
	if self._info then
		return self._info.seasonId or 0
	else
		return 0
	end
end

function SeniorArenaModel:getMyRank()
	if self._info then
		return self._info.rank
	end

	return -1
end

function SeniorArenaModel:setMyRank(value)
	if self._info then
		self._info.rank = value
	end
end

function SeniorArenaModel:getMyScore()
	if self._info then
		return self._info.score
	end

	return 0
end

function SeniorArenaModel:setMyScore(value)
	if self._info then
		self._info.score = value
	end
end

function SeniorArenaModel:getChangeSetId()
	if self._info then
		return checknumber(self._info.changeSetId)
	else
		return 0
	end
end

function SeniorArenaModel:getCurZoneId()
	if self._info then
		return checknumber(self._info.zoneId)
	else
		return self._zoneId
	end
end

function SeniorArenaModel:setCurZoneId(value)
	self._zoneId = value
end

function SeniorArenaModel:getAddPerSec()
	local hangUpTime = SeniorArenaConfig.instance:getCommonValue("HANG_UP_TIME", true)

	if hangUpTime > 0 then
		return self:getAddPerTime() / hangUpTime
	else
		return 0
	end
end

function SeniorArenaModel:getAddPerTime()
	local myRank = self:getMyRank()
	local rankCfg = SeniorArenaConfig.instance:getRankCfgByRank(myRank)

	if rankCfg then
		return rankCfg.hangUpPrize
	else
		return 0
	end
end

function SeniorArenaModel:getNextManualRefreshTime()
	if self._info then
		return checknumber(self._info.refreshCdSec / 1000)
	else
		return -1
	end
end

function SeniorArenaModel:setNextManualRefreshTime(value)
	if self._info then
		self._info.refreshCdSec = value
	end
end

function SeniorArenaModel:getNextRefreshTime()
	return self._nextRefreshTime or -1
end

function SeniorArenaModel:getHangUpInfo()
	return self._hangUpPrize
end

function SeniorArenaModel:setHangUpInfo(value)
	self._hangUpPrize = value
end

function SeniorArenaModel:getLastProduceTime()
	if self._hangUpPrize then
		return checknumber(self._hangUpPrize.balanceTime / 1000)
	end

	return 0
end

function SeniorArenaModel:getAccumulateValue()
	if self._hangUpPrize then
		return checknumber(self._hangUpPrize.accumulateValue)
	end

	return 0
end

function SeniorArenaModel:getNextReceiveTime()
	if self._hangUpPrize then
		return checknumber(self._hangUpPrize.gainPrizeCd / 1000)
	end

	return 0
end

function SeniorArenaModel:getBuyTicketTime()
	if self._info then
		return self._info.challengeBuyTime
	end

	return 0
end

function SeniorArenaModel:setBuyTicketTime(value)
	if self._info then
		self._info.challengeBuyTime = value
	end
end

function SeniorArenaModel:setMyDefendForms(forms, isSetForm)
	self._myDefendForms = self:_getPlayerFormMos(forms, isSetForm)
end

function SeniorArenaModel:getMyDefendFormMos()
	return self._myDefendForms
end

function SeniorArenaModel:getMyDefendFormMoByIdx(idx)
	if self._myDefendForms then
		return self._myDefendForms[idx]
	end
end

function SeniorArenaModel:isExistDefendForm()
	if not self._myDefendForms then
		return false
	end

	for k, v in pairs(self._myDefendForms) do
		if v:getPetNum() <= 0 then
			return false
		end
	end

	return true
end

function SeniorArenaModel:setMyAttackForms(forms, isSetForm)
	self._myAttackForms = self:_getPlayerFormMos(forms, isSetForm)
end

function SeniorArenaModel:getMyAttackFormMos()
	return self._myAttackForms
end

function SeniorArenaModel:getMyAttackFormMoByIdx(idx)
	if self._myAttackForms then
		return self._myAttackForms[idx]
	end
end

function SeniorArenaModel:_getPlayerFormMos(forms, isSetForm)
	local t = {}
	local playerFormMo

	if forms then
		for _, v in ipairs(forms) do
			playerFormMo = PlayerFormMo.New()

			if isSetForm == true then
				playerFormMo:initWithSetForm(v)
			else
				playerFormMo:initWithForm(v)
			end

			t[v.formId] = playerFormMo
		end
	end

	return t
end

function SeniorArenaModel:setAllTargets(value, dontClear)
	self._allTargets = value
	self._opponentFormMos = {}
	self._nextRefreshTime = ServerTime.now() + 60 * SeniorArenaConfig.instance:getCommonValue("CHALLENGE_TARGET_TIME", true)
end

function SeniorArenaModel:getAllTargets()
	return self._allTargets
end

function SeniorArenaModel:getUserIdByIndex(index)
	local infoList = {}

	for _, v in ipairs(self._allTargets) do
		local info = {}

		info.userId = v.headInfo.userId
		info.rank = v.rank

		table.insert(infoList, info)
	end

	table.sort(infoList, function(a, b)
		return a.rank < b.rank
	end)

	if infoList[index] then
		return infoList[index].userId
	else
		return 0
	end
end

function SeniorArenaModel:getTargetByUserId(id)
	if self._allTargets then
		for _, v in ipairs(self._allTargets) do
			if id == v.headInfo.userId then
				return v
			end
		end
	end
end

function SeniorArenaModel:getOppenentDefendForms(userId)
	if self._opponentFormMos then
		return self._opponentFormMos[userId]
	end
end

function SeniorArenaModel:setOppenentDefendForms(userId, forms)
	if self._opponentFormMos then
		self._opponentFormMos[userId] = self:_getPlayerFormMos(forms, false)
	end
end

SeniorArenaModel.instance = SeniorArenaModel.New()

return SeniorArenaModel
