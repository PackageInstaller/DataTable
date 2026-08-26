-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/fingergame/ChatRoomFingerGameCardItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.fingergame.ChatRoomFingerGameCardItem", package.seeall)

local ChatRoomFingerGameCardItem = class("ChatRoomFingerGameCardItem", LuaCompBase)

function ChatRoomFingerGameCardItem:init(go)
	self.go = go
	self._canvas = self.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gopreselect = gohelper.findChild(self.go, "State_PreSelect")
	self._txthint = gohelper.findChildText(self.go, "State_PreSelect/#card_pre/#txt_hint")
	self._gounflip = gohelper.findChild(self.go, "State_UnFlipped")
	self._goback = gohelper.findChild(self.go, "State_UnFlipped/#card_Back")
	self._gonormal = gohelper.findChild(self.go, "State_Normal")
	self._gorock = gohelper.findChild(self.go, "State_Normal/#card_Rock")
	self._goscissors = gohelper.findChild(self.go, "State_Normal/#card_Scissors")
	self._gopaper = gohelper.findChild(self.go, "State_Normal/#card_Paper")
	self._gotake = gohelper.findChild(self.go, "State_Normal/#go_take")
	self._gohighlight = gohelper.findChild(self.go, "State_Normal/#go_highlightframe")
	self._golight = gohelper.findChild(self.go, "golight")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "btnClick", AudioEnum3_2.play_ui_shengyan_box_songjin_click)
	self._canvas.alpha = 0
end

function ChatRoomFingerGameCardItem:addEventListeners()
	self.addClickCb(self, self._btnclick, self.onClick, self)
end

function ChatRoomFingerGameCardItem:removeEventListeners()
	return
end

function ChatRoomFingerGameCardItem:onItemShow(data)
	self._mo = data
	self._index = data.index
	self._cardType = data.cardType

	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._gorock, self._cardType == ChatRoomEnum.CardType.Rock)
	gohelper.setActive(self._goscissors, self._cardType == ChatRoomEnum.CardType.Scissors)
	gohelper.setActive(self._gopaper, self._cardType == ChatRoomEnum.CardType.Paper)

	self._txthint.text = GameUtil.getSubPlaceholderLuaLang(luaLang("CruiseGame_2"), {
		GameUtil.getNum2Chinese(self._index)
	})

	gohelper.setActive(self._gotake, false)
	gohelper.setActive(self._gohighlight, false)
end

function ChatRoomFingerGameCardItem:getIndex()
	return self._index
end

function ChatRoomFingerGameCardItem:getCardType()
	return self._cardType
end

function ChatRoomFingerGameCardItem:onSelectChange(value)
	self._isSelected = value

	if self._isPlayDiscard then
		gohelper.setActive(self._gotake, value)
		gohelper.setActive(self._golight, value)
		gohelper.setActive(self._gohighlight, value)
		self:refreshCardLight()
	end
end

function ChatRoomFingerGameCardItem:setPlayDiscardActive(value)
	self._isPlayDiscard = value

	self:refreshCardLight()
end

function ChatRoomFingerGameCardItem:refreshCardLight()
	gohelper.setActive(self._golight, self._isPlayDiscard and not self._isSelected)
end

function ChatRoomFingerGameCardItem:onClick()
	if self._mo.onClickFunc then
		self._mo.onClickFunc(self._mo.context, self)
	end

	if self._lastClickTime and Time.time - self._lastClickTime < 0.5 then
		self:onClickDouble()
	end

	self._lastClickTime = Time.time
end

function ChatRoomFingerGameCardItem:onClickDouble()
	if self._mo.onClickDoubleFunc then
		self._mo.onClickDoubleFunc(self._mo.context, self)
	end
end

return ChatRoomFingerGameCardItem
