-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcEasterEggView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcEasterEggView", package.seeall)

local ChatRoomNpcEasterEggView = class("ChatRoomNpcEasterEggView", BaseView)

function ChatRoomNpcEasterEggView:onInitView()
	self._txteasteregg = gohelper.findChildText(self.viewGO, "#txt_easteregg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomNpcEasterEggView:addEvents()
	return
end

function ChatRoomNpcEasterEggView:removeEvents()
	return
end

function ChatRoomNpcEasterEggView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ChatRoomNpcEasterEggView:onOpen()
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	Activity225Rpc.instance:sendAct225BonusSceneRequest(self._actId)

	self._eggCo = Activity225Config.instance:getNpcCosByType(self.viewParam)
	self._txteasteregg.text = self._eggCo.eggTxt

	if not self._eggCo.keepTime then
		TaskDispatcher.runDelay(self._startClose, self, 0.5 + self._eggCo.keepTime)
	end
end

function ChatRoomNpcEasterEggView:_startClose()
	self._viewAnim:Play("out", 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, 0.33)
end

function ChatRoomNpcEasterEggView:onClose()
	TaskDispatcher.cancelTask(self._startClose, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function ChatRoomNpcEasterEggView:onDestroyView()
	return
end

return ChatRoomNpcEasterEggView
