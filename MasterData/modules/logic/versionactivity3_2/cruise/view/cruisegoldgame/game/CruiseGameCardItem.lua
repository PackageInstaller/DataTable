-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGameCardItem.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGameCardItem", package.seeall)

local CruiseGameCardItem = class("CruiseGameCardItem", LuaCompBase)

function CruiseGameCardItem:init(viewGO)
	self.viewGO = viewGO
	self.State_PreSelect = gohelper.findChild(self.viewGO, "State_PreSelect")
	self.State_UnFlipped = gohelper.findChild(self.viewGO, "State_UnFlipped")
	self.State_Normal = gohelper.findChild(self.viewGO, "State_Normal")
	self.cardlight = gohelper.findChild(self.viewGO, "cardlight")
	self.card_Back = gohelper.findChild(self.State_UnFlipped, "#card_Back")
	self.card_Rock = gohelper.findChild(self.State_Normal, "#card_Rock")
	self.card_Scissors = gohelper.findChild(self.State_Normal, "#card_Scissors")
	self.card_Paper = gohelper.findChild(self.State_Normal, "#card_Paper")
	self.go_take = gohelper.findChild(self.State_Normal, "#go_take")
	self.highLightNormal = gohelper.findChild(self.State_Normal, "#go_highlightframe")
	self.txt_hint = gohelper.findChildTextMesh(self.State_PreSelect, "#card_pre/#txt_hint")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btnClick", AudioEnum3_2.play_ui_shengyan_box_songjin_click)
end

function CruiseGameCardItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function CruiseGameCardItem:removeEventListeners()
	return
end

function CruiseGameCardItem:onItemShow(data)
	self.data = data
	self.index = data.index
	self.cardType = data.cardType

	gohelper.setActive(self.card_Rock, self.cardType == Activity218Enum.CardType.Rock)
	gohelper.setActive(self.card_Scissors, self.cardType == Activity218Enum.CardType.Scissors)
	gohelper.setActive(self.card_Paper, self.cardType == Activity218Enum.CardType.Paper)

	self.txt_hint.text = GameUtil.getSubPlaceholderLuaLang(luaLang("CruiseGame_2"), {
		GameUtil.getNum2Chinese(self.index)
	})

	gohelper.setActive(self.go_take, false)
	gohelper.setActive(self.highLightNormal, false)
end

function CruiseGameCardItem:onSelectChange(value)
	self.isSelect = value

	if self.isPlayDiscard then
		gohelper.setActive(self.go_take, value)
		gohelper.setActive(self.cardlight, value)
		gohelper.setActive(self.highLightNormal, value)
		self:refreshCardLight()
	end
end

function CruiseGameCardItem:setPlayDiscardActive(value)
	self.isPlayDiscard = value

	self:refreshCardLight()
end

function CruiseGameCardItem:refreshCardLight()
	gohelper.setActive(self.cardlight, self.isPlayDiscard and not self.isSelect)
end

function CruiseGameCardItem:onClick()
	if self.data.onClickFunc then
		self.data.onClickFunc(self.data.context, self)
	end

	if self._lastClickTime and Time.time - self._lastClickTime < 0.5 then
		self:onClickDouble()
	end

	self._lastClickTime = Time.time
end

function CruiseGameCardItem:onClickDouble()
	if self.data.onClickDoubleFunc then
		self.data.onClickDoubleFunc(self.data.context, self)
	end
end

return CruiseGameCardItem
