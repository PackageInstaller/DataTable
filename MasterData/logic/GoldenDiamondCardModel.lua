-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/model/GoldenDiamondCardModel.lua

module("logic.extensions.goldendiamondcard.model.GoldenDiamondCardModel", package.seeall)

local GoldenDiamondCardModel = class("GoldenDiamondCardModel", BaseModel)

GoldenDiamondCardModel.PrivilegeType = {
	MainCopySweepDouble = 4,
	WorldBossFreeTime = 6,
	ExpMapSweepLevel = 8,
	FreeSummon = 1,
	ResCopySweepDouble = 3,
	MoneyCat = 2
}

function GoldenDiamondCardModel:onInit()
	self:onReset()
end

function GoldenDiamondCardModel:onReset()
	self.isUser = false
	self.noticeState = false
	self.ableToRenew = true
	self.endTime = -1
	self.prizeNum = -1
	self.timedBuyState = {}
	self.privilegeInfo = {}
end

function GoldenDiamondCardModel:updateTimeState()
	if self.endTime == -1 then
		self.noticeState = false
		self.ableToRenew = true
		self.isUser = false
	else
		do
			local nowtime = ServerTime.now()
			local endTime = self.endTime / 1000
			local ableToRenewTime = endTime - 86400 * checkint(GoldenDiamondCardConfig.instance:getCommonValue("REST_CAN_BUY_DAY"))
			local noticeStartTime = endTime - 86400 * checkint(GoldenDiamondCardConfig.instance:getCommonValue("RENEW_NOTICE_START_TIME"))
			local noticeEndTime = noticeStartTime + 86400 * checkint(GoldenDiamondCardConfig.instance:getCommonValue("RENEW_NOTICE_DAY"))

			self.isUser = nowtime < endTime
			self.ableToRenew = ableToRenewTime < nowtime
			self.noticeState = noticeStartTime < nowtime and nowtime < noticeEndTime
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_GOLDENDIAMONDCARD, self.isUser and self.prizeNum > 0)
end

function GoldenDiamondCardModel:getNoticeState()
	return self.noticeState
end

function GoldenDiamondCardModel:getIsShowRenewView()
	local useId = RoleModel.instance:getUserId()
	local isHasShowToday = GameUtil.getUserDayData((useId or "") .. "Goldendiamondrenew") == nil

	return self.noticeState and isHasShowToday
end

function GoldenDiamondCardModel:getGiftBuyState(giftId)
	return self.timedBuyState and self.timedBuyState[giftId + 1]
end

function GoldenDiamondCardModel:setTryBuyGiftId(giftId)
	self._tryGiftId = giftId
end

function GoldenDiamondCardModel:onGetInfo(msg)
	self.endTime = checkint(msg.cardInfo.cardEndTime)
	self.prizeNum = checkint(msg.cardInfo.dailyPrizeNum)
	self.timedBuyState = msg.timedBuyState

	self:updateTimeState()

	self.privilegeInfo = {}

	for i, v in ipairs(msg.privilegeInfo) do
		local info = {}

		info.privilegeType = checkint(v.privilegeType)
		info.usedTimes = checkint(v.usedTimes)
		self.privilegeInfo[info.privilegeType] = info
	end
end

function GoldenDiamondCardModel:onGainDailyPrize(msg)
	self.prizeNum = 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_GOLDENDIAMONDCARD, self.isUser and self.prizeNum > 0)
end

function GoldenDiamondCardModel:onPaySuc(msg)
	self.endTime = checkint(msg.cardEndTime)
	self.prizeNum = checkint(msg.dailyPrizeNum)

	self:updateTimeState()

	if self._tryGiftId then
		self.timedBuyState[self._tryGiftId + 1] = true
		self._tryGiftId = nil
	end
end

function GoldenDiamondCardModel:onPrivilegeInfoChange(msg)
	self.privilegeInfo = self.privilegeInfo or {}

	for i, v in ipairs(msg.changeInfo) do
		local info = {}

		info.privilegeType = checkint(v.privilegeType)
		info.usedTimes = checkint(v.usedTimes)
		self.privilegeInfo[info.privilegeType] = info
	end
end

function GoldenDiamondCardModel:getLeftTimeOfPrivilege(type)
	local defaultValue = GoldenDiamondCardConfig.instance:getPrivilegeDefaultValue(type)

	if self.privilegeInfo and self.privilegeInfo[type] then
		if not self.privilegeInfo[type].usedTimes then
			local usetime = 0

			return defaultValue - usetime, defaultValue
		end
	end
end

GoldenDiamondCardModel.instance = GoldenDiamondCardModel.New()

return GoldenDiamondCardModel
