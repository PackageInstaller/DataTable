-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/controller/MainUIPopupMsgController.lua

module("logic.extensions.mainui.controller.MainUIPopupMsgController", package.seeall)

local MainUIPopupMsgController = class("MainUIPopupMsgController", BaseController)
local DefaultCD = 30
local DefaultParams = {
	bTimeOutReject = true,
	cellName = "defaultPopupMsgCell",
	class = MainuiDefaultPopMsgCell
}

function MainUIPopupMsgController:onInit()
	self._cacheQueue = TimeCheckCacheQueue.New()
end

function MainUIPopupMsgController:onReset()
	self._cacheQueue:reset()
end

function MainUIPopupMsgController:getQueue()
	return self._cacheQueue:getQueue()
end

function MainUIPopupMsgController:regPopMsg(params)
	if params then
		local dest = {}

		table.merge(dest, DefaultParams)
		table.merge(dest, params)

		params = dest

		if dest.showInitCD == nil and params.cd == nil then
			params.cd = DefaultCD + ServerTime.now()
		end

		if params.cd or params.showInitCD then
			if params.cd ~= nil then
				params.cd = checknumber(params.cd)

				if params.cd <= 0 then
					params.bTimeOutReject = false
				end
			end

			if params.showInitCD ~= nil then
				params.showInitCD = checknumber(params.showInitCD)

				if params.showInitCD <= 0 then
					params.bTimeOutReject = false
				end
			end
		else
			params.bTimeOutReject = false
		end

		local result, data = self._cacheQueue:pushBack(params, params.cd, true)

		if data then
			self:_tryShowView(data)
		end

		return result
	end
end

function MainUIPopupMsgController:removePopMsg(index)
	if index ~= nil then
		local result, data = self._cacheQueue:remove(index)

		if data then
			GlobalDispatcher:dispatch(GlobalNotify.PopupMsgReqDelView, data)
		end

		return result
	end
end

function MainUIPopupMsgController:_tryShowView(data)
	if self:_isCanShow() then
		self:_playViewShow(data)
	end
end

function MainUIPopupMsgController:_isCanShow()
	return true
end

function MainUIPopupMsgController:_playViewShow(params)
	self._curViewParams = params

	GlobalDispatcher:dispatch(GlobalNotify.PopupMsgReqAddView, params)
end

MainUIPopupMsgController.instance = MainUIPopupMsgController.New()

return MainUIPopupMsgController
