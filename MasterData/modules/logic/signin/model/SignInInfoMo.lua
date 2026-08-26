-- chunkname: @modules/logic/signin/model/SignInInfoMo.lua

module("modules.logic.signin.model.SignInInfoMo", package.seeall)

local SignInInfoMo = pureTable("SignInInfoMo")

function SignInInfoMo:ctor()
	self.hasSignInDays = {}
	self.addupSignInDay = 0
	self.hasGetAddupBonus = {}
	self.openFunctionTime = 0
	self.hasMonthCardDays = {}
	self.monthCardHistory = {}
	self.birthdayHeroIds = {}
	self.rewardMark = 0
end

function SignInInfoMo:init(info)
	self.hasSignInDays = self:_getListInfo(info.hasSignInDays)
	self.addupSignInDay = info.addupSignInDay
	self.hasGetAddupBonus = self:_getListInfo(info.hasGetAddupBonus)
	self.openFunctionTime = info.openFunctionTime
	self.hasMonthCardDays = self:_getListInfo(info.hasMonthCardDays)
	self.monthCardHistory = self:_getListInfo(info.monthCardHistory, SignInMonthCardHistoryMo)
	self.birthdayHeroIds = self:_getListInfo(info.birthdayHeroIds)
	self.supplementMonthCardDays = info.supplementMonthCardDays

	self:setRewardMark(info.rewardMark)
end

function SignInInfoMo:_getListInfo(originList, cls)
	local list = {}

	if originList then
		if not #originList then
			local count = 0

			for i = 1, count do
				local mo = originList[i]

				if cls then
					mo = cls.New()

					mo:init(originList[i])
				end

				table.insert(list, mo)
			end

			return list
		end
	end
end

function SignInInfoMo:addSignInfo(info)
	table.insert(self.hasSignInDays, info.day)

	for _, v in ipairs(info.birthdayHeroIds) do
		table.insert(self.birthdayHeroIds, v)
	end
end

function SignInInfoMo:getSignDays()
	return self.hasSignInDays
end

function SignInInfoMo:clearSignInDays()
	self.hasSignInDays = {}
end

function SignInInfoMo:addSignTotalIds(id)
	table.insert(self.hasGetAddupBonus, id)
end

function SignInInfoMo:addBirthdayHero(heroId)
	table.insert(self.birthdayHeroIds, heroId)
end

function SignInInfoMo:setRewardMark(rewardMark)
	self.rewardMark = rewardMark
end

function SignInInfoMo:isClaimedAccumulateReward(id)
	local bits = Bitwise["<<"](1, id)

	return Bitwise.has(self.rewardMark, bits)
end

function SignInInfoMo:isClaimableAccumulateReward(id)
	local playinfo = PlayerModel.instance:getPlayinfo()

	if not playinfo.totalLoginDays then
		local totalLoginDays = 0

		if id then
			local CO = SignInConfig.instance:getSignInLifeTimeBonusCO(id)
			local logindaysid = CO.logindaysid

			return logindaysid <= totalLoginDays and not self:isClaimedAccumulateReward(id)
		else
			for _, CO in ipairs(lua_sign_in_lifetime_bonus.configList) do
				local logindaysid = CO.logindaysid
				local stageid = CO.stageid

				if logindaysid <= totalLoginDays and not self:isClaimedAccumulateReward(stageid) then
					return true
				end
			end

			return false
		end
	end
end

function SignInInfoMo:getSupplementMonthCardDays()
	return self.supplementMonthCardDays or 0
end

function SignInInfoMo:setSupplementMonthCardDays(day)
	self.supplementMonthCardDays = day
end

return SignInInfoMo
