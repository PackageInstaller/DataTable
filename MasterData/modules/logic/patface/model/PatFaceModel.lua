-- chunkname: @modules/logic/patface/model/PatFaceModel.lua

module("modules.logic.patface.model.PatFaceModel", package.seeall)

local PatFaceModel = class("PatFaceModel", BaseModel)
local SkipToggleStatus = {
	Disable = 0,
	Enable = 1
}

function PatFaceModel:onInit()
	self:clear()

	local isSkip = ((isDebugBuild or nil) and PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewSkipPatFace)) == SkipToggleStatus.Enable

	self:setIsSkipPatFace(isSkip)
end

function PatFaceModel:reInit()
	self:clear()
end

function PatFaceModel:getIsPatting()
	return not not self._isPattingFace
end

function PatFaceModel:getIsSkipPatFace()
	return not not self._isSkipPatFace
end

function PatFaceModel:setIsPatting(isPatting)
	if isPatting == self._isPattingFace then
		return
	end

	self._isPattingFace = isPatting
end

function PatFaceModel:setIsSkipPatFace(isSkipPatFace, isToast)
	local isSkip = not not isSkipPatFace

	self._isSkipPatFace = isSkip

	if isSkip then
		if not ToastEnum.SkipPatFace then
			local toastId = ToastEnum.CancelSkipPatFace

			PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewSkipPatFace, (isSkip or nil) and (SkipToggleStatus.Enable or SkipToggleStatus.Disable))

			if isToast then
				GameFacade.showToast(toastId)
			end
		end
	end
end

function PatFaceModel:clear()
	self:setIsPatting(false)
	PatFaceModel.super.clear(self)
end

PatFaceModel.instance = PatFaceModel.New()

return PatFaceModel
