-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/notice/NoticeBoard.lua

module("logiccommon.common.notice.NoticeBoard", package.seeall)

local NoticeBoard = {}
local json = require("cjson")
local clazz = "com.baitian.notice.NoticeBoardWrap"

NoticeBoard.CurViewParam = nil

function NoticeBoard.requestNoticeInfoV5(gameId, langCode, channelId, packageVersion, version, zoneId, osType)
	local param = {}

	param.gameId = gameId
	param.langCode = langCode
	param.channelId = channelId
	param.packageVersion = packageVersion or -1
	param.version = version or "-1"
	param.zoneId = zoneId or "-1"
	param.serverId = serverId or "-1"
	param.osType = osType or "-1"

	NativeBridge.instance:invoke(clazz, "requestNoticeInfoV5", param)
end

function NoticeBoard.requestNoticeInfo(appCode, channelId, packageVersion, version, zoneId, osType)
	local param = {}

	param.appCode = tostring(appCode)
	param.channelId = tostring(channelId)
	param.packageVersion = packageVersion or -1
	param.version = tostring(version) or "-1"
	param.zoneId = tostring(zoneId) or "-1"
	param.osType = tostring(osType) or "-1"

	NativeBridge.instance:invoke(clazz, "requestNoticeInfo", param)
end

function NoticeBoard.registerOnRequestNoticeInfoListener(callFunc, callFuncSelf)
	NativeBridge.instance:registerListener("noticeInfo", function(result)
		printInfo("noticeInfo:" .. result.value)

		local content = json.decode(result.value)

		if callFuncSelf then
			callFunc(callFuncSelf, content, result.statusCode)
		else
			callFunc(content, result.statusCode)
		end
	end)
end

function NoticeBoard.openNoticeView(x, y, width, height, noticeBoardItemList)
	local param = {}

	param.x = x
	param.y = y
	param.width = width
	param.height = height
	param.noticeBoardItemList = json.encode(noticeBoardItemList)
	NoticeBoard.CurViewParam = param

	NativeBridge.instance:invoke(clazz, "openNoticeView", param)
end

function NoticeBoard.switchNotice(noticeBoardItemList)
	local param = {}

	param.noticeBoardItemList = json.encode(noticeBoardItemList)

	NativeBridge.instance:invoke(clazz, "switchNotice", param)
end

function NoticeBoard.closeNoticeView()
	NoticeBoard.CurViewParam = nil

	NativeBridge.instance:invoke(clazz, "closeNoticeView")
end

function NoticeBoard.registerBtGameLink(callFunc)
	NativeBridge.instance:registerListener("noticeLink", function(result)
		local content = result.url

		callFunc(content)
	end)
end

function NoticeBoard.setNoticeBackgroundColor(backgroundColor)
	local param = {}

	param.backgroundColor = backgroundColor

	NativeBridge.instance:invoke(clazz, "setNoticeBackgroundColor", param)
end

function NoticeBoard.setServerUrl(serverUrl)
	local param = {}

	param.serverUrl = serverUrl

	NativeBridge.instance:invoke(clazz, "setServerUrl", param)
end

function NoticeBoard.resetSize(x, y, width, height)
	local param = {}

	param.x = x
	param.y = y
	param.width = width
	param.height = height

	NativeBridge.instance:invoke(clazz, "resetSize", param)
end

function NoticeBoard.getCurViewParam()
	return NoticeBoard.CurViewParam
end

return NoticeBoard
