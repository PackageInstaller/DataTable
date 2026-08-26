-- chunkname: @modules/logic/common/model/CommonInputMO.lua

module("modules.logic.common.model.CommonInputMO", package.seeall)

local CommonInputMO = class("CommonInputMO")

function CommonInputMO:ctor(title, defaultInput, callback, callbackObj)
	self.title = title or ""
	self.defaultInput = defaultInput or ""
	self.characterLimit = 50
	self.cancelBtnName = luaLang("cancel")
	self.sureBtnName = luaLang("sure")
	self.cancelCallback = nil
	self.sureCallback = callback
	self.callbackObj = callbackObj
end

return CommonInputMO
