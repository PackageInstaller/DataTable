-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/controller/ShareController.lua

module("logic.extensions.share.controller.ShareController", package.seeall)

local ShareController = class("ShareController", BaseController)

function ShareController:ctor()
	return
end

function ShareController:onInit()
	ShareController.super.onInit(self)
end

function ShareController:onReset()
	ShareController.super.onReset(self)

	self._nextSendTime = nil

	removetimer(self._sendInviteMsg, self)
	self:_endHelp()
end

function ShareController:checkOnlyShowQZone(btnList)
	local btplatformId = BootstrapUtil.getPlatformId()

	if btplatformId == 8 then
		local versionName = BootstrapUtil.getGameVersionName()
		local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

		if versionCode == 208 and versionName == "8.0.188" then
			for i = 1, 4 do
				goutil.setActive(btnList[i].gameObject, false)
			end
		end
	end
end

function ShareController:share(id, objects, texture2d, behaviorId, handler, handlerObj)
	id = checknumber(id)

	local btplatformId = BootstrapUtil.getPlatformId()

	if Framework.OSDef.isEditor or SDKManager.isOfficial() or GameUtil.isOpenHarmony() or PermissionUtil.checkPermission("WRITE_EXTERNAL_STORAGE") then
		UIStateManager.instance:open(ViewName.ShareImageView, id, objects, texture2d, behaviorId, handler, handlerObj)
	else
		if handler and type(handler) == "function" then
			handler(handlerObj)
		end

		PermissionUtil.registerPermissionListener(function(result)
			PermissionUtil.unregisterPermissionListener()
		end)
		PermissionUtil.requestPermission("WRITE_EXTERNAL_STORAGE", "分享功能需要授予存储权限，请您前往 [设置-权限管理-奥奇传说] 中开启，感谢。")
	end
end

function ShareController.SaveShareTexture(tex2D)
	local idx = GameUtil.getUserData("ShareController")

	idx = (checknumber(idx) + 1) % 5

	GameUtil.saveUserData("ShareController", idx)

	local path = string.format("%s/shareTexture_%s_%s.png", UnityEngine.Application.persistentDataPath, ServerTime.now(), idx)

	if tex2D then
		Framework.TextureUtil.SaveTextureToPath(tex2D, path)
	end

	return path
end

function ShareController.isOpenShare()
	return true
end

function ShareController.activeByTimes(id, obj)
	id = checknumber(id)

	local cfg = ShareConfig.instance:getShareById(id) or {}

	ShareLinkAgent.instance:sendPM_GetShareLinkDataReq(id, function(msg)
		goutil.setActive(obj, msg.gainTimes < cfg.limitTimes)
	end)

	return cfg.prize
end

function ShareController:tryOpenFriendView(dataT)
	local sendTime = self._nextSendTime

	if not sendTime or sendTime < ServerTime.now() then
		self:_startHelp(dataT)
		ViewMgr.instance:open(ViewName.FriendSelect, 0, 0, lang("请选择好友发送"))
	else
		FloatWordMgr.instance:show("发送频率太快，请稍后")
	end
end

function ShareController:_startHelp(dataT)
	self._temp_dataT = dataT

	GlobalDispatcher:addListener(GlobalNotify.FriendSelectedClose, self._endHelp, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
end

function ShareController:_endHelp()
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelectedClose, self._endHelp, self)
end

function ShareController:_onSelectFriend(ids)
	if self._temp_dataT and #ids > 0 then
		self:_friendSelected(ids)
	end

	self:_endHelp()
end

function ShareController:_friendSelected(buddyIds)
	self._buddyIds = buddyIds

	local tpId = self._temp_dataT.tpId

	self._msgType = GameEnum.ChatType.System

	local cfg = ChatConfig.instance:getSystemMsgT(tpId)
	local dataT = self._temp_dataT

	self._content = GameUtil.jsonToString(dataT)

	local buddyCount = #self._buddyIds

	self.msgId = 0

	if buddyCount > 0 then
		local gap = 1.2

		self._nextSendTime = ServerTime.now() + (buddyCount - 1) * gap + 1

		settimer(gap, self._sendInviteMsg, self, true)
		self:_sendInviteMsg()
	end
end

function ShareController:_sendInviteMsg()
	local receiveId = table.remove(self._buddyIds)

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Private, self._msgType, self._content, receiveId, nil, nil)

	if #self._buddyIds == 0 then
		FloatWordMgr.instance:show("已成功发送邀请")
		removetimer(self._sendInviteMsg, self)

		self._temp_dataT = nil
	end
end

ShareController.instance = ShareController.New()

return ShareController
