-- chunkname: @IQIGame\\Net\\NetCommController.lua

NetCommController = {}
NetCommController.CommunicationCount = 0

function NetCommController.Sending()
	NetCommController.CommunicationCount = NetCommController.CommunicationCount + 1

	if NetCommController.CommunicationCount == 1 then
		UIModule.Open(Constant.UIControllerName.CommunicationUI, Constant.UILayer.AboveAll)
	end
end

function NetCommController.Responded()
	NetCommController.CommunicationCount = NetCommController.CommunicationCount - 1

	if NetCommController.CommunicationCount < 0 then
		NetCommController.CommunicationCount = 0
	end

	if NetCommController.CommunicationCount == 0 then
		UIModule.Close(Constant.UIControllerName.CommunicationUI)
	end
end

function NetCommController.Clear()
	NetCommController.CommunicationCount = 0

	UIModule.Close(Constant.UIControllerName.CommunicationUI)
end
