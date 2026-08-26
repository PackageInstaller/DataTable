-- chunkname: @modules/logic/gm/controller/sequencework/SendUserInfoLogWork.lua

module("modules.logic.gm.controller.sequencework.SendUserInfoLogWork", package.seeall)

local SendUserInfoLogWork = class("SendUserInfoLogWork", BaseWork)

function SendUserInfoLogWork:onStart()
	ZProj.OpenSelectFileWindow.OpenExplorer(SendFightLogWork.logDirPath)
	SendWeWorkFileHelper.SendUserInfo(self.onSendUserInfoDone, self)
end

function SendUserInfoLogWork:onSendUserInfoDone(success, msg)
	if self.status ~= WorkStatus.Running then
		return
	end

	if success then
		GameFacade.showToast(ToastEnum.IconId, "send success")
	else
		GameFacade.showToast(ToastEnum.IconId, "send fail " .. tostring(msg))
	end

	self:onDone(true)
end

function SendUserInfoLogWork:clearWork()
	return
end

return SendUserInfoLogWork
