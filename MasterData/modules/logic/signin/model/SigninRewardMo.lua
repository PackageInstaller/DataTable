-- chunkname: @modules/logic/signin/model/SigninRewardMo.lua

module("modules.logic.signin.model.SigninRewardMo", package.seeall)

local SigninRewardMo = pureTable("SigninRewardMo")

function SigninRewardMo:ctor()
	self.materilType = nil
	self.materilId = nil
	self.quantity = nil
	self.uid = nil
	self.isGold = nil
end

function SigninRewardMo:init(info)
	self.materilType = info.materilType
	self.materilId = info.materilId
	self.quantity = info.quantity
	self.uid = info.uid
end

function SigninRewardMo:initValue(type, id, quantity, uid, isGold)
	self.materilType = type
	self.materilId = id
	self.quantity = quantity
	self.uid = uid
	self.isGold = isGold
end

return SigninRewardMo
