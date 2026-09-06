-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/PkRoomChatView.lua

module("logic.extensions.traincampqiecuo.view.PkRoomChatView", package.seeall)

local PkRoomChatView = class("PkRoomChatView", MainChatView)

function PkRoomChatView:onEnter()
	self._firstEnter = true

	PkRoomChatView.super.onEnter(self)
end

function PkRoomChatView:_refreshList()
	if self._showActions then
		local curActionDatas = RoleActionsConfig.instance:getRoleActions()

		self._curActionDatas = {}

		table.merge(self._curActionDatas, curActionDatas)
		table.sort(self._curActionDatas, function(x, y)
			local xUnlock = self:_isActionUnlock(x)
			local yUnlock = self:_isActionUnlock(y)

			if xUnlock and not yUnlock then
				return true
			end

			if yUnlock and not xUnlock then
				return false
			end

			return false
		end)
		self._tableview:ReloadData()

		return
	end

	self._curViewDatas = self:_getMainUIShowMsg()

	if #self._curViewDatas <= 0 then
		self:_addFakeMsg()

		return
	end

	self._tableview:ReloadData()
end

function PkRoomChatView:_getMainUIShowMsg()
	local list = NewChatModel.instance:GetMainUIShowMsg()
	local newList = {}

	for i, v in ipairs(list) do
		if v:getChannel() == GameEnum.ChatChannel.Team then
			table.insert(newList, v)
		end
	end

	return newList
end

function PkRoomChatView:_addFakeMsg()
	if not self._firstEnter then
		return
	end

	self._firstEnter = false

	local t = {}

	for i = 1, 1 do
		local msg = {}

		msg.msgId = -9999999 + i
		msg.senderId = 0
		msg.headInfo = {}
		msg.headInfo.userName = ""
		msg.msgType = 999
		msg.channelType = GameEnum.ChatChannel.Team
		msg.content = "欢迎来到奥奇世界，请开始愉快聊天吧！"
		msg.sendTime = ServerTime.now() * 1000

		table.insert(t, msg)
	end

	NewChatModel.instance:OnNotifyNewMsg(t)
	self:_refreshList()
end

return PkRoomChatView
