-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/fingergame/ChatRoomFingerGameResultView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.fingergame.ChatRoomFingerGameResultView", package.seeall)

local ChatRoomFingerGameResultView = class("ChatRoomFingerGameResultView", BaseView)

function ChatRoomFingerGameResultView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._godefeat = gohelper.findChild(self.viewGO, "#go_result/#go_defeat")
	self._simageFullBG0 = gohelper.findChildSingleImage(self.viewGO, "#go_result/#go_defeat/#simage_FullBG0")
	self._govictory = gohelper.findChild(self.viewGO, "#go_result/#go_victory")
	self._simageFullBG2 = gohelper.findChildSingleImage(self.viewGO, "#go_result/#go_victory/#simage_FullBG2")
	self._godraw = gohelper.findChild(self.viewGO, "#go_result/#go_draw")
	self._simageFullBG3 = gohelper.findChildSingleImage(self.viewGO, "#go_result/#go_draw/#simage_FullBG3")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/#txt_desc")
	self._goreward = gohelper.findChild(self.viewGO, "Right/#go_reward")
	self._gorewariItem = gohelper.findChild(self.viewGO, "Right/#go_reward/#go_rewariItem")
	self._txtrewardcount = gohelper.findChildText(self.viewGO, "Right/#go_reward/#go_rewariItem/iconitem/#txt_rewardcount")
	self._gorewardget = gohelper.findChild(self.viewGO, "Right/#go_reward/#go_rewariItem/#go_rewardget")
	self._btnfinished = gohelper.findChildButtonWithAudio(self.viewGO, "Right/LayoutGroup/#btn_finished")
	self._btnnew = gohelper.findChildButtonWithAudio(self.viewGO, "Right/LayoutGroup/#btn_new")
	self._txtgamecount = gohelper.findChildText(self.viewGO, "Right/LayoutGroup/#btn_new/#txt_gamecount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomFingerGameResultView:addEvents()
	self._btnfinished:AddClickListener(self._btnfinishedOnClick, self)
end

function ChatRoomFingerGameResultView:removeEvents()
	self._btnfinished:RemoveClickListener()
end

function ChatRoomFingerGameResultView:_btnfinishedOnClick()
	ChatRoomController.instance:exiteGame()
end

function ChatRoomFingerGameResultView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self._onEscapelick, self)
end

function ChatRoomFingerGameResultView:_onEscapelick()
	return
end

function ChatRoomFingerGameResultView:onOpen()
	self._resultType = ChatRoomFingerGameModel.instance:getResultType()

	gohelper.setActive(self._govictory, self._resultType == ChatRoomEnum.GameResultType.Victory)
	gohelper.setActive(self._godefeat, self._resultType == ChatRoomEnum.GameResultType.Defeat)
	gohelper.setActive(self._godraw, self._resultType == ChatRoomEnum.GameResultType.Draw)

	if self._resultType == ChatRoomEnum.GameResultType.Victory then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)

		self._txtdesc.text = luaLang("CruiseGame_3")
	elseif self._resultType == ChatRoomEnum.GameResultType.Defeat then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)

		self._txtdesc.text = luaLang("CruiseGame_4")
	elseif self._resultType == ChatRoomEnum.GameResultType.Draw then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)

		self._txtdesc.text = luaLang("CruiseGame_5")
	end

	local bonusCos = string.splitToNumber(Activity225Config.instance:getGamePoint(self._resultType), "#")

	self._txtrewardcount.text = bonusCos[3]
end

function ChatRoomFingerGameResultView:onClose()
	return
end

function ChatRoomFingerGameResultView:onDestroyView()
	return
end

return ChatRoomFingerGameResultView
