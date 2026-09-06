-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/model/PassportActivityInfo.lua

module("logic.extensions.passport.model.PassportActivityInfo", package.seeall)

local PassportActivityInfo = class("PassportActivityInfo")

function PassportActivityInfo:ctor()
	self:onReset()
end

function PassportActivityInfo:onReset()
	self.actId = -1
	self.funcId = -1
	self.progress = -1
	self.progressAbletToBuy = -1
	self.endTime = -1
	self.unlockIndex = -1
	self.sldValue = 0
	self.progressTxt = ""
	self.hasPay = false
	self.hasPayAdd = false
	self.isShowRedPoint = false
	self.normalPrizeState = nil
	self.superPrizeState = nil
	self.funcCfg = nil
	self.actCfg = nil
	self.prizeCfgs = nil
end

return PassportActivityInfo
