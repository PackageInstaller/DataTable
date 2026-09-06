-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/controller/HitbossController.lua

module("logic.extensions.hitboss.controller.HitbossController", package.seeall)

local HitbossController = class("HitbossController", BaseController)

function HitbossController:ctor()
	return
end

function HitbossController:onInit()
	self:onReset()
end

function HitbossController:onReset()
	self._enterActivityId = 0
end

function HitbossController:enterMission(activityId, bossId)
	self._enterActivityId = activityId

	local mo = HitbossModel.instance:getFmtMo()

	mo:initParams(activityId, bossId)
	CustomFmtController.instance:showMissionView(mo)
end

function HitbossController:handlePM_Notify_HitbossFightRes(msg)
	local damge = checknumber(msg.damge)
	local useddailyclgtimes = msg.usedDailyClgTimes

	if damge ~= -1 and damge > 0 then
		local params = {
			title = "伤 害",
			content = "对敌方造成伤害" .. damge
		}

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SimplyDesc, params)
		HitbossModel.instance:setCurrDamage(self._enterActivityId, damge)
	end

	if useddailyclgtimes ~= -1 and useddailyclgtimes > 0 then
		HitbossModel.instance:setUseddailyclgtimes(self._enterActivityId, useddailyclgtimes)
	end
end

function HitbossController:isGainPrize(activityId, prizeId)
	local info = HitbossModel.instance:getInfo(activityId)

	if not info then
		return false
	end

	if table.indexof(info.gainPrizeIds, prizeId) then
		return true
	end
end

function HitbossController:isCanGainPrize(activityId, prizeId)
	if self:isGainPrize(activityId, prizeId) then
		return false
	end

	local cfg = HitbossConfig.instance:getPrizeCfg(activityId, prizeId)
	local progress = checknumber(cfg.progress)
	local maxDamage = HitbossModel.instance:getTotalDamage(activityId)

	return progress <= maxDamage
end

function HitbossController:sendPM_HitBossGainPrizeReq(activityId, prizeId)
	self._gainActivityId = activityId
	self._gainPrizeId = prizeId

	HitBossAgent.instance:sendPM_HitBossGainPrizeReq(activityId, prizeId)
end

function HitbossController:handlePM_HitBossGainPrizeRes()
	HitbossModel.instance:onGainPrize(self._gainActivityId, self._gainPrizeId)
end

function HitbossController:getDamageStr(damage)
	damage = checknumber(damage)

	local damageStr = damage

	if damage >= 10000 then
		local num = damage / 10000

		damageStr = num % 1 == 0 and string.format("%sW", num) or string.format("%.2fW", num)
	end

	return damageStr
end

function HitbossController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function HitbossController:getActivityType()
	return GameEnum.ActivityType.HitBoss
end

function HitbossController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function HitbossController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function HitbossController:getSkinId(activityId)
	return HitbossConfig.instance:getCommonValue(activityId, "skinId", true)
end

function HitbossController:getTotalDay(activityId)
	local activityType = self:getActivityType()
	local startTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local nowTime = ServerTime.now()
	local day = math.ceil((nowTime - startTime) / 86400)
	local cfgs = HitbossConfig.instance:getDailyBuffCfgs(activityId)
	local days = #cfgs

	day = day % days

	if day == 0 then
		day = days
	end

	return day
end

HitbossController.instance = HitbossController.New()

return HitbossController
