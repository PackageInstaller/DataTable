-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/model/CatchPropsModel.lua

module("logic.extensions.catchprops.model.CatchPropsModel", package.seeall)

local CatchPropsModel = class("CatchPropsModel", BaseModel)

function CatchPropsModel:onInit()
	self:onReset()
end

function CatchPropsModel:onReset()
	self._activityId = 0
	self._unlockFragments = nil
	self._playGameTimes = 0
	self._buyGameTimes = 0
	self._isDataReady = false
	self._gamePropsNum = 0
	self._gamingTime = 0
end

function CatchPropsModel:setActivityId(activityId)
	if activityId == self._activityId then
		return
	end

	self._activityId = activityId

	if activityId == 0 then
		self._unlockFragments = nil
		self._isDataReady = false

		return
	end

	self._isDataReady = false

	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	self._unlockFragments = CatchPropsImageMO.New(activityCo.unlockProps)
end

function CatchPropsModel:getActivityId()
	return self._activityId
end

function CatchPropsModel:setActivityInfo(msg)
	if msg then
		local unlockstatus = msg.unlockStatus

		self._buyGameTimes = msg.buyTimes
		self._playGameTimes = msg.usedTimes

		for i = 1, #unlockstatus do
			self._unlockFragments:setFragmentUnLock(i, unlockstatus[i])
			self._unlockFragments:setFragmentNewUnLock(i, unlockstatus[i])
		end

		self._isDataReady = true
	else
		self._buyGameTimes = 0
		self._playGameTimes = 0
		self._isDataReady = false

		if self._unlockFragments then
			self._unlockFragments:resetUnlockStatus()
		end
	end
end

function CatchPropsModel:isActivityDataReady()
	return self._isDataReady
end

function CatchPropsModel:resetDailyActivity()
	self._buyGameTimes = 0
	self._playGameTimes = 0
end

function CatchPropsModel:onUnlockFragment(zoneId)
	if not self._unlockFragments then
		return
	end

	self._unlockFragments:setFragmentUnLock(zoneId, true)
	self._unlockFragments:setFragmentNewUnLock(zoneId, true)
end

function CatchPropsModel:onMoYanPreheatBuyTimes(buyTimes)
	self._buyGameTimes = buyTimes
end

function CatchPropsModel:onMoYanPreheatEndGame()
	self._playGameTimes = self._playGameTimes + 1
end

function CatchPropsModel:getUnlockFragments()
	if not self._unlockFragments then
		return
	end

	return self._unlockFragments:getAllFragments()
end

function CatchPropsModel:getPlayGameTimes()
	return self._playGameTimes
end

function CatchPropsModel:getBuyGameTimes()
	return self._buyGameTimes
end

function CatchPropsModel:getPropType()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.props
end

function CatchPropsModel:getBgImage()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return "ui/bigbg/catchprops/" .. activityCo.bgImg .. ".png"
end

function CatchPropsModel:getUnlockImage()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return "ui/bigbg/catchprops/" .. activityCo.unlockImage .. ".png"
end

function CatchPropsModel:getThrowerImage()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.thrower .. ".prefab"
end

function CatchPropsModel:getCatcherImage()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.catcher .. ".prefab"
end

function CatchPropsModel:getEffPath()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.effPath .. ".prefab"
end

function CatchPropsModel:getStartGameEffPath()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.startGameEffPath .. ".prefab"
end

function CatchPropsModel:getUnlockZoneEffPath()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.unlockEffPath .. ".prefab"
end

function CatchPropsModel:getCollisionEffPath()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.collisionEffPath .. ".prefab"
end

function CatchPropsModel:getNormalPropAsset()
	local list = {}
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)
	local normalProps = string.split(activityCo.normalProp, "#")

	for k, v in pairs(normalProps) do
		local path = "ui/views/catchprops/" .. v .. ".prefab"

		table.insert(list, path)
	end

	return list
end

function CatchPropsModel:getSpecialPropAsset()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return "ui/views/catchprops/" .. activityCo.specialProp .. ".prefab"
end

function CatchPropsModel:getOtherSpecialPropAssetByType(propType)
	if propType == CatchPropsPropType.AddTime then
		local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

		return "ui/views/catchprops/" .. activityCo.specialProp .. ".prefab"
	elseif propType == CatchPropsPropType.ChoosePetRedBag then
		local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

		return "ui/views/catchprops/" .. activityCo.addSpecialProp .. ".prefab"
	end
end

function CatchPropsModel:getOtherSpecialPropAsset()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return "ui/views/catchprops/" .. activityCo.addSpecialProp .. ".prefab"
end

function CatchPropsModel:getRemainPlayTimes()
	local playGameTimes = self._playGameTimes
	local maxPlayTimes = CatchPropsConfig.instance:getDailyGameTimes() + self._buyGameTimes

	return maxPlayTimes - playGameTimes
end

function CatchPropsModel:getPrize()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)
	local prizeCo = CatchPropsConfig.instance:getPrizeCo(activityCo.prizePlan, math.huge)

	if prizeCo then
		return prizeCo.prize
	end
end

function CatchPropsModel:getAllPrizes()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return CatchPropsConfig.instance:getAllPrizeCos(activityCo.prizePlan)
end

function CatchPropsModel:getGameBgImage()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return "ui/bigbg/catchprops/" .. activityCo.gameBgImg .. ".png"
end

function CatchPropsModel:getGameWaitingStartTips()
	local activityCo = CatchPropsConfig.instance:getActivityCo(self._activityId)

	return activityCo.gameStartTips
end

function CatchPropsModel:onGetGameScore()
	return self._gamePropsNum
end

function CatchPropsModel:onGetGameProps(num)
	self._gamePropsNum = self._gamePropsNum + num
end

function CatchPropsModel:setGamePropsNum(num)
	self._gamePropsNum = num
end

function CatchPropsModel:getGamePropsNum()
	return self._gamePropsNum
end

function CatchPropsModel:onGetGamingTime(time)
	self._gamingTime = self._gamingTime + time
end

function CatchPropsModel:setGamingTime(time)
	self._gamingTime = time
end

function CatchPropsModel:getGamingTime()
	return self._gamingTime
end

CatchPropsModel.instance = CatchPropsModel.New()

return CatchPropsModel
