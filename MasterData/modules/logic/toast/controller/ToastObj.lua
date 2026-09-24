-- chunkname: @modules/logic/toast/controller/ToastObj.lua

module("modules.logic.toast.controller.ToastObj", package.seeall)

local ToastObj = pureTable("ToastObj")

function ToastObj:init(co, extra, sicon)
	self.co = co
	self.extra = extra
	self.sicon = sicon

	self:initCommon()
end

function ToastObj:initWithString(str)
	self.co = {
		icon = 11,
		tips = str
	}

	self:initCommon()
end

function ToastObj:initCommon()
	self.type = ToastItem.ToastType.Normal
	self.time = ServerTime.now()

	if self.co.id then
		self.showTime = ToastParamEnum.LifeTime[self.co.id] or 4
	end
end

function ToastObj:setType(type)
	self.type = type
end

function ToastObj:isExpire()
	return ServerTime.now() - self.time >= self.showTime
end

function ToastObj:resetTime()
	self.time = ServerTime.now()
end

return ToastObj
