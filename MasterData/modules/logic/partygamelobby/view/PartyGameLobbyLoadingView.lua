-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyLoadingView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyLoadingView", package.seeall)

local PartyGameLobbyLoadingView = class("PartyGameLobbyLoadingView", BaseView)

function PartyGameLobbyLoadingView:onInitView()
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "txt_wait")

	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.CanCloseLoading, self._onCanCloseLoading, self)
end

function PartyGameLobbyLoadingView:_onCanCloseLoading()
	TaskDispatcher.runDelay(self.closeThis, self, 0.5)
end

function PartyGameLobbyLoadingView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.play_ui_bulaochun_yy_load)

	local list = lua_partygame_loading.configList
	local count = #list

	self._txtdesc.text = list[math.random(1, count)].des

	local needHideDesc = ChatRoomModel.instance:getHideLoadingDescState()

	gohelper.setActive(self._txtdesc.gameObject, not needHideDesc)
end

function PartyGameLobbyLoadingView:onClose()
	return
end

return PartyGameLobbyLoadingView
