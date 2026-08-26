-- chunkname: @modules/logic/signin/model/SignInHeroBirthdayInfoMo.lua

module("modules.logic.signin.model.SignInHeroBirthdayInfoMo", package.seeall)

local SignInHeroBirthdayInfoMo = pureTable("SignInHeroBirthdayInfoMo")

function SignInHeroBirthdayInfoMo:ctor()
	self.heroId = 0
	self.birthdayCount = 0
end

function SignInHeroBirthdayInfoMo:init(info)
	self.heroId = info.heroId
	self.birthdayCount = info.birthdayCount
end

function SignInHeroBirthdayInfoMo:reset(info)
	self.heroId = info.heroId
	self.birthdayCount = info.birthdayCount
end

function SignInHeroBirthdayInfoMo:addBirthdayCount()
	self.birthdayCount = self.birthdayCount + 1
end

return SignInHeroBirthdayInfoMo
