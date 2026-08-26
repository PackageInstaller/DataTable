-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGameCardSelectItem.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGameCardSelectItem", package.seeall)

local CruiseGameCardSelectItem = class("CruiseGameCardSelectItem", SimpleListItem)

function CruiseGameCardSelectItem:onInit()
	self.State_Normal = gohelper.findChild(self.viewGO, "anim/State_Normal")
	self.card_Rock = gohelper.findChild(self.State_Normal, "#card_Rock")
	self.card_Scissors = gohelper.findChild(self.State_Normal, "#card_Scissors")
	self.card_Paper = gohelper.findChild(self.State_Normal, "#card_Paper")
	self.go_play = gohelper.findChild(self.State_Normal, "#go_play")
	self.cardlight = gohelper.findChild(self.viewGO, "anim/cardlight")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "anim/btnClick", AudioEnum3_2.play_ui_shengyan_box_songjin_click)
	self.itemAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function CruiseGameCardSelectItem:onAddListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function CruiseGameCardSelectItem:onRemoveListeners()
	return
end

function CruiseGameCardSelectItem:onItemShow(data)
	self.data = data
	self.cardType = data.cardType

	gohelper.setActive(self.card_Rock, self.cardType == Activity218Enum.CardType.Rock)
	gohelper.setActive(self.card_Scissors, self.cardType == Activity218Enum.CardType.Scissors)
	gohelper.setActive(self.card_Paper, self.cardType == Activity218Enum.CardType.Paper)
end

function CruiseGameCardSelectItem:onSelectChange(value)
	if self.isPlayCard then
		gohelper.setActive(self.go_play, value)

		if value then
			self.itemAnim:Play("select")
		else
			self.itemAnim:Play("in", 0, 1)
		end

		self:refreshCardLight()
	end
end

function CruiseGameCardSelectItem:setPlayCardActive(value)
	self.isPlayCard = value

	self:refreshCardLight()
end

function CruiseGameCardSelectItem:refreshCardLight()
	gohelper.setActive(self.cardlight, self.isPlayCard and not self.isSelectItem)
end

function CruiseGameCardSelectItem:playOutAnim()
	self.itemAnim:Play("out")
end

function CruiseGameCardSelectItem:onClick()
	if self.data.onClickFunc then
		self.data.onClickFunc(self.data.context, self)
	end

	if self._lastClickTime and Time.time - self._lastClickTime < 0.5 then
		self:onClickDouble()
	end

	self._lastClickTime = Time.time
end

function CruiseGameCardSelectItem:onClickDouble()
	if self.data.onClickDoubleFunc then
		self.data.onClickDoubleFunc(self.data.context, self)
	end
end

return CruiseGameCardSelectItem
