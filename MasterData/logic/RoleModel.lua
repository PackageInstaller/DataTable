-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/model/RoleModel.lua

module("logic.extensions.role.model.RoleModel", package.seeall)

local RoleModel = class("RoleModel", BaseModel)

RoleModel.CardBelong = {}
RoleModel.CardBelong.My = 1
RoleModel.CardBelong.Other = 2

function RoleModel:ctor()
	RoleModel.super.ctor(self)
	NotifyDispatcher.extend(self)

	self.myRoleMo = MyRoleMo.New()
end

function RoleModel:onInit()
	self:onReset()
end

function RoleModel:setMyCardInfo(msg)
	self.myCardInfo = CardInfoMo.New(RoleModel.CardBelong.My)

	local info = msg.info

	self.myCardInfo:setData(info)

	self.myCardInfo.userName = self:getUserName()
	self.myCardInfo.userId = self:getUserId()
	self.curCardInfo = self.myCardInfo
	self.PreCreatePlayerInfo = nil

	local transformGenderInfo = msg.transformGenderInfo

	self:setTransformGenderInfo(transformGenderInfo)
end

function RoleModel:setCurOtherCardInfo(msg)
	self.curOtherCardMo = CardInfoMo.New(RoleModel.CardBelong.Other)

	local info = msg.info

	self.curOtherCardMo:setData(info)

	self.curOtherCardMo.userName = msg.userName
	self.curOtherCardMo.userId = msg.userId
	self.curCardInfo = self.curOtherCardMo
end

function RoleModel:getCardInfoMo(cardBelong)
	if cardBelong == RoleModel.CardBelong.My then
		return self.myCardInfo
	elseif cardBelong == RoleModel.CardBelong.Other then
		return self.curCardInfo
	end
end

function RoleModel:onReset()
	self.banType = 0
	self.banInfos = {}
	self._monthcardDisabledTime = {}
	self._nextTransFormTime = nil
	self.curCardInfo = nil
	self.myCardInfo = nil
	self._timesOfTransform = -1

	AvatarsMgrNew.instance:onReset()
end

function RoleModel:getClothes()
	local userVar = SceneMainPlayer.instance.userVar

	return userVar:getOriginVar(UserVarKey.CLOTHES) or {}
end

function RoleModel:setUserId(id)
	self.myRoleMo.userId = id
end

function RoleModel:getUserId()
	if self.myRoleMo then
		return self.myRoleMo.userId
	end

	if self.PreCreatePlayerInfo then
		return self.PreCreatePlayerInfo.userId
	end

	return 0
end

function RoleModel:setPlayerType(id)
	self.myRoleMo.playerType = id
end

function RoleModel:getPlayerType()
	return self.myRoleMo.playerType
end

function RoleModel:GetRole()
	return self.myRoleMo
end

function RoleModel:setUserName(name)
	self.myRoleMo.userName = name
end

function RoleModel:getUserName()
	return self.myRoleMo.userName
end

function RoleModel:setMaxPower(power)
	self.myRoleMo.everMaxZdl = power

	GlobalDispatcher:dispatch(GlobalNotify.PlayerStrengthChange, power)
end

function RoleModel:getMaxPower()
	if not self.myRoleMo then
		return 0
	end

	return self.myRoleMo.everMaxZdl
end

function RoleModel:getTotalDiamond()
	return self:getPresentDiamond() + self:getPayDiamond()
end

function RoleModel:getPresentDiamond()
	return MaterialModel.instance:getMaterialsNumber(MatType.Diamond, MatType.Diamond_Binding)
end

function RoleModel:getPayDiamond()
	return MaterialModel.instance:getMaterialsNumber(MatType.Diamond, MatType.Diamond_Normal)
end

function RoleModel:getCoin()
	return MaterialModel.instance:getMaterialsNumber(MatType.Coin, MatType.Coin_Gold)
end

function RoleModel:getActiveTime()
	return checknumber(self.myRoleMo.activeTime)
end

function RoleModel:getActiveTimeSec()
	return checknumber(self.myRoleMo.activeTimeSec)
end

function RoleModel:getAreaId()
	return checknumber(self.myRoleMo.areaId)
end

function RoleModel:getAreaName()
	return self.myRoleMo.areaName
end

function RoleModel:getZoneId()
	printInfo("test 当前岛Id", self.myRoleMo.zoneId)

	return checknumber(self.myRoleMo.zoneId)
end

function RoleModel:getAreaOpenTime()
	return checknumber(self.myRoleMo.areaOpenTime)
end

function RoleModel:getAreaOpenTimeSec()
	return checknumber(self.myRoleMo.areaOpenTimeSec)
end

function RoleModel:getLoginTime()
	return checknumber(self.myRoleMo.currentTimeMillis)
end

function RoleModel:getLoginOutTime()
	return checknumber(self.myRoleMo.lastLogoutTime)
end

function RoleModel:getMyLevel()
	local lv, exp = MofangModel.instance:getCurLvAndExp()

	return lv
end

function RoleModel:getGender()
	return self.myRoleMo.gender
end

function RoleModel:getHeadIconId()
	return self.myRoleMo.headIconId
end

function RoleModel:getHeadFrameId()
	return self.myRoleMo.headFrameId
end

function RoleModel:setHeadIconId(id)
	self.myRoleMo.headIconId = id
end

function RoleModel:setHeadFrameId(id)
	self.myRoleMo.headFrameId = id
end

function RoleModel:updateVipExp(exp)
	if self.myRoleMo then
		self.myRoleMo.vipExp = exp
	end
end

function RoleModel:getVipLvl()
	local exp = self.myRoleMo.vipExp

	return VipModel.instance:calculateVipLvByExp(exp) or 0
end

function RoleModel:getCurStrength()
	return self.myRoleMo.curStrength
end

function RoleModel:getRegressActId()
	return self.myRoleMo.regressActId
end

function RoleModel:onSetMo(msg)
	self.myRoleMo:init(msg)
	self:calMonthcardDisabledTime()
end

function RoleModel:onSetPreCreatePlayerInfo(info)
	self.PreCreatePlayerInfo = info
end

function RoleModel:setQilinReceived(received)
	self._received = received
end

function RoleModel:getQilinReceived()
	if self._received == nil then
		return true
	else
		return self._received
	end
end

function RoleModel:getRefreshTime()
	local nowTime = checknumber(self.myRoleMo.activeTime) / 1000
	local now = GameUtil.time2date(nowTime)

	nowTime = now.hour < 5 and nowTime + (5 - now.hour) * 3600 - now.min * 60 - now.sec or nowTime - (now.hour - 5) * 3600 - now.min * 60 - now.sec + 86400

	return nowTime
end

function RoleModel:handleUserBanInfoChange(msg)
	self.banInfos = {}

	for k, v in ipairs(msg) do
		print("bantype = " .. v.banType .. "time = " .. checknumber(v.endTime / 1000))

		self.banInfos[v.banType] = checknumber(v.endTime / 1000)
	end
end

function RoleModel:HasLeague()
	return false
end

function RoleModel:getMyConsumeMoney()
	return (self.myRoleMo or nil) and (self.myRoleMo.consumeMoney or 0)
end

function RoleModel:addMyConsumeMoney(money)
	money = checknumber(money)

	if self.myRoleMo and self.myRoleMo.consumeMoney then
		self.myRoleMo.consumeMoney = self.myRoleMo.consumeMoney + money
	end
end

function RoleModel:getMontchCardStates()
	return self.myRoleMo.cardStates
end

function RoleModel:isMonthCardActive(cardId)
	local active = false
	local info = self:getMontchCardStates()
	local disabledTime = self:getMonthcardDisabledTime(cardId)

	for i, v in ipairs(info) do
		if v.cardId == cardId and v.restDay > 0 and (disabledTime <= 0 or disabledTime > ServerTime.now()) then
			active = true

			break
		end
	end

	return active
end

function RoleModel:calMonthcardDisabledTime()
	local info = self:getMontchCardStates()
	local nowTime = ServerTime.now()

	for i, v in ipairs(info) do
		if v.restDay > 0 then
			local date = GameUtil.time2date(nowTime)
			local resetTime = os.time({
				hour = 5,
				min = 0,
				sec = 0,
				year = date.year,
				month = date.month,
				day = date.day
			})

			self._monthcardDisabledTime[v.cardId] = date.hour > 5 and resetTime + v.restDay * 86400 or resetTime + (v.restDay - 1) * 86400 + (resetTime - nowTime)
		end
	end
end

function RoleModel:getMonthcardDisabledTime(cardId)
	return self._monthcardDisabledTime[cardId] or 0
end

function RoleModel:setTransformGenderInfo(transformGenderInfo)
	self._nextTransFormTime = transformGenderInfo.nextTransformTime
	self._timesOfTransform = transformGenderInfo.hasUsedFreeTransfromTimes
end

function RoleModel:getNextTransformGenderTime()
	return self._nextTransFormTime / 1000
end

function RoleModel:getLeftTimesOfTransform()
	return VipModel.instance:getTimesOfChangeGender() - self._timesOfTransform
end

function RoleModel:getRegressInfo()
	return self.myRoleMo.regressInfo
end

function RoleModel:getGuideMode()
	return self.myRoleMo.guideMode
end

function RoleModel:setGuideMode(value)
	self.myRoleMo.guideMode = value
end

function RoleModel:getSettings()
	return self.myRoleMo.settings
end

function RoleModel:setSettings(settings)
	self.myRoleMo.settings = settings
end

function RoleModel:getSettingSwitch()
	return checknumber(self.myRoleMo.settings.settingSwitch)
end

function RoleModel:setSettingSwitch(settingSwitch)
	self.myRoleMo.settings.settingSwitch = settingSwitch
end

function RoleModel:getSettingSwitchIsOpen(bitPos)
	if self.myRoleMo.settings then
		local settingSwitch = self.myRoleMo.settings.settingSwitch

		if settingSwitch then
			return MmUtil.getBitSet(settingSwitch, bitPos) == 1
		end

		return false
	end
end

function RoleModel:getHeadInfo()
	return {
		headIconId = self:getHeadIconId(),
		headFrameId = self:getHeadFrameId(),
		vipLv = self:getVipLvl(),
		userName = self:getUserName(),
		userId = self:getUserId(),
		playerLv = self:getMyLevel()
	}
end

function RoleModel:copyHeadInfo(info)
	info = info or {}

	return {
		headIconId = checknumber(info.headIconId),
		headFrameId = checknumber(info.headFrameId),
		vipLv = checknumber(info.vipLv),
		userName = tostring(info.userName),
		userId = tostring(info.userId),
		playerLv = checknumber(info.playerLv)
	}
end

RoleModel.instance = RoleModel.New()

return RoleModel
