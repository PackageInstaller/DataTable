-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/model/YearCardSignInModel.lua

module("logic.extensions.yearcardsignin.model.YearCardSignInModel", package.seeall)

local YearCardSignInModel = class("YearCardSignInModel", BaseModel)

function YearCardSignInModel:onInit()
	self:onReset()
end

function YearCardSignInModel:onReset()
	self.signInDays = 0
	self.gainPrizeState = {}
	self.infos = {}
	self.expirationTimes = 0
end

function YearCardSignInModel:onGetInfo(msg, actId)
	self:onReset()

	self.signInDays = msg.signInDays
	self.gainPrizeState = msg.gainPrizeState or {}
	self.infos = {}

	local giftCfgs = YearCardSignInConfig.instance:getGiftCfgs(actId)

	for _, v in pairs(giftCfgs) do
		local info = {}

		info.cfg = v
		info.hasBuyTime = 0
		self.infos[v.id] = info
	end

	for _, v in ipairs(msg.infos) do
		self.infos[v.id].hasBuyTime = v.times
	end

	self.expirationTimes = (msg.expirationTimes or 0) / 1000
end

function YearCardSignInModel:onSignIn(msg)
	return
end

function YearCardSignInModel:isHasSignIn(day)
	return table.keyof(self.gainPrizeState, day)
end

function YearCardSignInModel:signIn(day)
	table.insert(self.gainPrizeState, day)
end

function YearCardSignInModel:onSignInOneKey(msg)
	self.gainPrizeState = {}

	for i = 1, self.signInDays do
		table.insert(self.gainPrizeState, i)
	end
end

function YearCardSignInModel:onBuyGift(msg)
	self.infos[msg.info.id].hasBuyTime = msg.info.times
	self.signInDays = msg.curSignInDays
end

function YearCardSignInModel:getGiftInfo(id)
	return self.infos[id]
end

function YearCardSignInModel:isAbleToOneKey()
	local actId = checkint(YearCardModel.instance:getCurAnnuityId())

	if actId == 0 then
		return false
	end

	return #self.gainPrizeState < math.min(self.signInDays, table.nums(YearCardSignInConfig.instance:getPrizeCfgs(actId or {})))
end

YearCardSignInModel.instance = YearCardSignInModel.New()

return YearCardSignInModel
