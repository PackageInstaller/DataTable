-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/model/HitbossModel.lua

module("logic.extensions.hitboss.view.HitbossModel", package.seeall)

local HitbossModel = class("HitbossModel", BaseModel)

function HitbossModel:ctor()
	return
end

function HitbossModel:onInit()
	self:onReset()
end

function HitbossModel:onReset()
	self._infoMsgMap = {}
	self._fmtMo = nil
	self._rankInfo = nil
end

function HitbossModel:getFmtMo()
	self._fmtMo = self._fmtMo or HitBossFmtMo.New()

	return self._fmtMo
end

function HitbossModel:setInfo(msg)
	self._infoMsgMap[msg.activityId] = msg
end

function HitbossModel:getInfo(activityId)
	return self._infoMsgMap[activityId]
end

function HitbossModel:setUseddailyclgtimes(activityId, times)
	local info = self:getInfo(activityId)

	if info then
		info.usedDailyClgTimes = times
	end
end

function HitbossModel:setCurrDamage(activityId, damage)
	local info = self:getInfo(activityId)

	if info then
		if damage > checknumber(info.usedDailyClgTimes) then
			info.usedDailyClgTimes = damage
		end

		if damage > checknumber(info.maxDamage) then
			info.maxDamage = damage
		end

		if damage > 0 then
			info.totalDamage = info.totalDamage + damage
		end
	end
end

function HitbossModel:onGainPrize(activityId, prizeId)
	local info = self:getInfo(activityId)

	if not info then
		return
	end

	info.gainPrizeIds:append(prizeId)
end

function HitbossModel:getMaxDamage(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	return checknumber(info.maxDamage)
end

function HitbossModel:getTotalDamage(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	return checknumber(info.totalDamage)
end

function HitbossModel:setRankInfo(msg)
	self._rankInfo = msg
end

function HitbossModel:getRankInfo()
	return self._rankInfo
end

HitbossModel.instance = HitbossModel.New()

return HitbossModel
