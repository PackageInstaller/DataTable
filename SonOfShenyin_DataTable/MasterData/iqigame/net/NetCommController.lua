-- chunkname: @IQIGame\\Net\\NetCommController.lua

NetCommController = {}
NetCommController.CommunicationCount = 0

function NetCommController.Sending(hideContent)
	if LoginModule.Reloading then
		return
	end

	NetCommController.CommunicationCount = NetCommController.CommunicationCount + 1

	if NetCommController.CommunicationCount == 1 then
		UIModule.Open(Constant.UIControllerName.CommunicationUI, Constant.UILayer.AboveAll, {
			isHideContent = hideContent
		})
	end
end

function NetCommController.Responded()
	if LoginModule.Reloading then
		return
	end

	NetCommController.CommunicationCount = NetCommController.CommunicationCount - 1

	if NetCommController.CommunicationCount < 0 then
		NetCommController.CommunicationCount = 0
	end

	if NetCommController.CommunicationCount == 0 then
		UIModule.Close(Constant.UIControllerName.CommunicationUI)
	end
end

function NetCommController.Clear()
	if LoginModule.Reloading then
		return
	end

	NetCommController.CommunicationCount = 0

	UIModule.Close(Constant.UIControllerName.CommunicationUI)
end
