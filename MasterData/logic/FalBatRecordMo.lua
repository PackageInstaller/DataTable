-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalBatRecordMo.lua

module("logic.extensions.landlords.view.FalBatRecordMo", package.seeall)

local FalBatRecordMo = class("FalBatRecordMo")

function FalBatRecordMo:ctor()
	return
end

function FalBatRecordMo:init(recordMsg)
	self._recordMsg = recordMsg
	self._playerInfoList = {}

	for playerIdx, headInfo in ipairs(recordMsg.headInfo) do
		local info = {}

		info.userId = headInfo.userId
		info.playerIdx = playerIdx
		info.headInfo = headInfo
		info.identity = info.userId == recordMsg.landlordsPlayerId and GameEnum.FalIdentity.Landlord or GameEnum.FalIdentity.Farmer
		info.isWin = info.identity == GameEnum.FalIdentity.Landlord and recordMsg.landlordWin or not recordMsg.landlordWin
		info.goldValueA = info.identity == GameEnum.FalIdentity.Landlord and recordMsg.addScore or Mathf.Floor(recordMsg.addScore / 2)

		if not info.isWin then
			info.goldValueA = -info.goldValueA
		end

		local rate = FightAgainstLandlordsConfig.instance:getFalCommonValue("COIN_EXCHANGE_RATE")

		info.goldValueB = Mathf.Floor(Mathf.Max(info.goldValueA * rate, 0))
		self._playerInfoList[info.userId] = info
	end
end

function FalBatRecordMo:getThresholdId()
	return self._recordMsg.thresholdId
end

function FalBatRecordMo:getUesrIdList()
	local userIdList = {}

	for _, info in pairs(self:_getPlayerInfoList()) do
		userIdList[info.playerIdx] = info.userId
	end

	return userIdList
end

function FalBatRecordMo:_getPlayerInfoList()
	return self._playerInfoList
end

function FalBatRecordMo:_getPlayerInfo(userId)
	return self._playerInfoList[userId]
end

function FalBatRecordMo:getPlayerIdx(userId)
	local info = self:_getPlayerInfo(userId)

	return info.playerIdx
end

function FalBatRecordMo:getHeadInfo(userId)
	local info = self:_getPlayerInfo(userId)

	return info.headInfo
end

function FalBatRecordMo:getUserName(userId)
	local info = self:_getPlayerInfo(userId)

	return info.headInfo.userName
end

function FalBatRecordMo:getIdentity(userId)
	local info = self:_getPlayerInfo(userId)

	return info.identity
end

function FalBatRecordMo:isWin(userId)
	local info = self:_getPlayerInfo(userId)

	return info.isWin
end

function FalBatRecordMo:getGoldValueA(userId)
	local info = self:_getPlayerInfo(userId)

	return info.goldValueA
end

function FalBatRecordMo:getGoldValueB(userId)
	local info = self:_getPlayerInfo(userId)

	return info.goldValueB
end

return FalBatRecordMo
