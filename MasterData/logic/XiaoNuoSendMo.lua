-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/model/XiaoNuoSendMo.lua

module("logic.extensions.xiaonuoassistant.model.XiaoNuoSendMo", package.seeall)

local XiaoNuoSendMo = class("XiaoNuoSendMo")

function XiaoNuoSendMo:ctor()
	self.funcEnum = 0
	self.callbackList = {}
	self.emptyShowText = XiaoNuoTextEnum.Default
	self.isFinishExcute = false
	self.resultItemList = {}
	self.callbackStageList = {}
	self._excuteCount = 0
	self._isNeedExcuteDuration = false
	self._excuteDuration = 0
end

function XiaoNuoSendMo:setEmptyShowText(text)
	self.emptyShowText = text
end

function XiaoNuoSendMo:setExcuteInterval(isNeed, sec)
	self.isNeedExcuteDuration = isNeed
	self._excuteDuration = sec or 0
end

function XiaoNuoSendMo:isNeedInterval()
	return self.isNeedExcuteDuration and not self:isFirstCount()
end

function XiaoNuoSendMo:getExcuteInterval()
	return self._excuteDuration
end

function XiaoNuoSendMo:addExcuteCount()
	self._excuteCount = self._excuteCount + 1

	printInfo("test XiaoNuoSendMo:addExcuteCount", self._excuteCount)
end

function XiaoNuoSendMo:isFirstCount()
	return self._excuteCount == 0
end

function XiaoNuoSendMo:isLastCount()
	local count = #self.callbackList

	return self._excuteCount == count
end

return XiaoNuoSendMo
