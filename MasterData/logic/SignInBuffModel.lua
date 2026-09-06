-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signinbuff/model/SignInBuffModel.lua

module("logic.extensions.signinbuff.model.SignInBuffModel", package.seeall)

local SignInBuffModel = class("SignInBuffModel", BaseModel)

function SignInBuffModel:onInit()
	self:onReset()
end

function SignInBuffModel:onReset()
	self._baseInfoMap = {}
end

function SignInBuffModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function SignInBuffModel:handleBatchSignInBuffInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	if pb then
		for i, v in ipairs(pb.infos or {}) do
			self._baseInfoMap[v.activityId] = v
		end
	end
end

function SignInBuffModel:onUpgradeSignInBuff(msg)
	local info = self:getBaseInfo(msg.activityId)

	if info then
		info.signInDays = msg.signInDays
		info.hasSignInToday = true
	end
end

function SignInBuffModel:getBaseInfo(activityId)
	if not self._baseInfoMap[activityId] then
		-- block empty
	end

	return self._baseInfoMap[activityId]
end

function SignInBuffModel:getHasSignInToday(activityId)
	local info = self:getBaseInfo(activityId)

	if info then
		return info.hasSignInToday
	end

	return false
end

function SignInBuffModel:getCurBuffLvCfg(activityId)
	local info = self:getBaseInfo(activityId)

	if info then
		local cfg = SignInBuffConfig.instance:getBuffCfgByDay(activityId, info.signInDays)

		return (cfg or nil) and (cfg.buffLevel or 0)
	end

	return 0
end

SignInBuffModel.instance = SignInBuffModel.New()

return SignInBuffModel
