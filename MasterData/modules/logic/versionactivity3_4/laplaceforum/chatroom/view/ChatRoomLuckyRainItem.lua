-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomLuckyRainItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomLuckyRainItem", package.seeall)

local ChatRoomLuckyRainItem = class("ChatRoomLuckyRainItem", LuaCompBase)

function ChatRoomLuckyRainItem:init(go)
	self.go = go

	gohelper.setActive(self.go, true)

	self._goselect = gohelper.findChild(self.go, "go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "click")
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))

	TaskDispatcher.runDelay(self._onItemFinished, self, 3)

	self._moveTweenId = ZProj.TweenHelper.DOAnchorPosY(self.go.transform, -650, 3, nil, nil, nil, EaseType.InOutQuad)

	self:_addEvents()
end

function ChatRoomLuckyRainItem:_addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ChatRoomLuckyRainItem:_removeEvents()
	self._btnclick:RemoveClickListener()
end

function ChatRoomLuckyRainItem:setSelectCallback(callback, callbackObj, index)
	self._index = index
	self._selectCallback = callback
	self._selectCallbackObj = callbackObj
end

function ChatRoomLuckyRainItem:setFinishCallback(callback, callbackObj, index)
	self._index = index
	self._finishCallback = callback
	self._finishCallbackObj = callbackObj
end

function ChatRoomLuckyRainItem:_btnclickOnClick()
	if self._selectCallback then
		self._selectCallback(self._selectCallbackObj, self._index)

		self._selectCallback = nil
		self._selectCallbackObj = nil
	end
end

function ChatRoomLuckyRainItem:setPosX(x)
	local _, posY, _ = transformhelper.getLocalPos(self.go.transform)

	transformhelper.setLocalPosXY(self.go.transform, x, posY)
end

function ChatRoomLuckyRainItem:playSelect()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	self._anim:Play("select", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.play_ui_bulaochun_yy_hbdian)
	TaskDispatcher.cancelTask(self._onItemFinished, self)
	TaskDispatcher.runDelay(self._onItemFinished, self, 0.75)
end

function ChatRoomLuckyRainItem:_onItemFinished()
	gohelper.setActive(self.go, false)

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj, self._index)

		self._finishCallback = nil
		self._finishCallbackObj = nil
	end
end

function ChatRoomLuckyRainItem:destroy()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	TaskDispatcher.cancelTask(self._onItemFinished, self)

	if self.go then
		gohelper.destroy(self.go)
	end

	self:_removeEvents()
end

return ChatRoomLuckyRainItem
