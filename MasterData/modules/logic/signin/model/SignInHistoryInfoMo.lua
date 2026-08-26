-- chunkname: @modules/logic/signin/model/SignInHistoryInfoMo.lua

module("modules.logic.signin.model.SignInHistoryInfoMo", package.seeall)

local SignInHistoryInfoMo = pureTable("SignInHistoryInfoMo")

function SignInHistoryInfoMo:ctor()
	self.month = 1
	self.hasSignInDays = {}
	self.hasMonthCardDays = {}
	self.birthdayHeroIds = {}
end

function SignInHistoryInfoMo:init(info)
	self.month = info.month
	self.hasSignInDays = self:_getListInfo(info.hasSignInDays)
	self.hasMonthCardDays = self:_getListInfo(info.hasMonthCardDays)
	self.birthdayHeroIds = self:_getListInfo(info.birthdayHeroIds)
end

function SignInHistoryInfoMo:_getListInfo(originList, cls)
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

return SignInHistoryInfoMo
