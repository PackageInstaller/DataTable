-- chunkname: @modules/logic/room/controller/RoomInformController.lua

module("modules.logic.room.controller.RoomInformController", package.seeall)

local RoomInformController = class("RoomInformController", BaseController)

function RoomInformController:onInit()
	return
end

function RoomInformController:reInit()
	return
end

function RoomInformController:onInitFinish()
	return
end

RoomInformController.SCREEN_CAPTURE_BLOCK_KEY = "RoomInformController.SCREEN_CAPTURE_BLOCK_KEY"

function RoomInformController:openShareTipView(playerMO, shareCode)
	if self._viewOpenParams then
		return
	end

	UIBlockMgr.instance:startBlock(RoomInformController.SCREEN_CAPTURE_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(false)

	self._viewOpenParams = {
		playerMO = playerMO,
		shareCode = shareCode
	}

	local scene = GameSceneMgr.instance:getCurScene()

	if scene and scene.camera and scene.camera:getCameraState() ~= RoomEnum.CameraState.OverlookAll then
		scene.camera:switchCameraState(RoomEnum.CameraState.OverlookAll, {
			zoom = 1
		}, nil, self._screenCapture, self)
	else
		self:_screenCapture()
	end
end

function RoomInformController:_screenCapture()
	ZProj.ScreenCaptureUtil.Instance:ReadScreenPixelsAsTexture(nil, self._onOpenInformView, self)
end

function RoomInformController:_onOpenInformView(texture2d)
	UIBlockMgr.instance:endBlock(RoomInformController.SCREEN_CAPTURE_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)

	local param = self._viewOpenParams

	self._viewOpenParams = nil
	param.texture2d = texture2d

	local reportTypes = {}
	local titleStr = CommonConfig.instance:getConstStr(ConstEnum.RoomInformTypeTitles)

	if not string.nilorempty(titleStr) then
		local reportNames = string.split(titleStr, "#") or {}

		for i, name in ipairs(reportNames) do
			table.insert(reportTypes, {
				id = i,
				desc = name
			})
		end
	end

	RoomReportTypeListModel.instance:initType(reportTypes)
	ViewMgr.instance:openView(ViewName.RoomInformPlayerView, param)
end

RoomInformController.SEND_REPORT_ROOM_BLOCK_KEY = "RoomInformController.SEND_REPORT_ROOM_BLOCK_KEY"

function RoomInformController:sendReportRoom(reportedUserId, reportType, content, shareCode)
	UIBlockMgr.instance:startBlock(RoomInformController.SEND_REPORT_ROOM_BLOCK_KEY)
	RoomRpc.instance:sendReportRoomRequest(reportedUserId, reportType, content, shareCode, self._onReportRoomReply, self)
end

function RoomInformController:_onReportRoomReply(cmd, resultCode, msg)
	UIBlockMgr.instance:endBlock(RoomInformController.SEND_REPORT_ROOM_BLOCK_KEY)

	if resultCode == 0 then
		RoomController.instance:dispatchEvent(RoomEvent.InformSuccessReply, msg.token)
	end
end

function RoomInformController:uploadImage(texture, token)
	local bytes = UnityEngine.ImageConversion.EncodeToJPG(texture, 25)
	local httpLoginUrl = self:getHttpLoginUrl()
	local url = string.format("%s/%s", httpLoginUrl, "roomreportpicture")
	local headJson
	local wwwFrom = UnityEngine.WWWForm.New()

	wwwFrom:AddField("token", token)
	wwwFrom:AddBinaryData("fileData", bytes)
	SLFramework.SLWebRequest.Instance:PostWWWForm(url, wwwFrom, headJson, self._onUploadImageResponse, self)
	logNormal(url)
end

function RoomInformController:_onUploadImageResponse(isSuccess, msg)
	if not isSuccess or string.nilorempty(msg) then
		logNormal(string.format("上传图片失败"))
	else
		logNormal(msg)
	end
end

function RoomInformController:getHttpLoginUrl()
	local httpLoginUrl
	local httpLoginUrlInfo = UrlConfig.getConfig().login

	if type(httpLoginUrlInfo) == "table" then
		local channelId = tostring(SDKMgr.instance:getChannelId()) or "100"

		httpLoginUrl = httpLoginUrlInfo[channelId]

		if not httpLoginUrlInfo[channelId] then
			for cid, url in pairs(httpLoginUrlInfo) do
				httpLoginUrl = url

				logError(string.format("httpLoginUrl not exist, channelId=%s\nuse %s:%s", channelId, cid, url or "nil"))

				break
			end
		end
	else
		httpLoginUrl = httpLoginUrlInfo
	end

	return httpLoginUrl
end

function RoomInformController:_saveImage(bytes)
	local directory = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot")
	local now = System.DateTime.Now
	local fileName = string.format("room_screenshot_%s%s%s_%s%s%s%s.jpg", now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second, now.Millisecond)
	local path = System.IO.Path.Combine(directory, fileName)

	SLFramework.FileHelper.WriteAllBytesToPath(path, bytes)

	return path
end

RoomInformController.instance = RoomInformController.New()

return RoomInformController
