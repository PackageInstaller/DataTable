-- chunkname: @modules/logic/fight/view/magiccircle/FightMagicCircleNormal.lua

module("modules.logic.fight.view.magiccircle.FightMagicCircleNormal", package.seeall)

local FightMagicCircleNormal = class("FightMagicCircleNormal", FightMagicCircleBaseItem)

function FightMagicCircleNormal:initView()
	self._text = gohelper.findChildText(self.go, "#txt_task")
	self._red = gohelper.findChild(self.go, "#txt_task/red")
	self._blue = gohelper.findChild(self.go, "#txt_task/blue")
	self._red_round_num = gohelper.findChildText(self.go, "#txt_task/red/#txt_num")
	self._blue_round_num = gohelper.findChildText(self.go, "#txt_task/blue/#txt_num")
	self._redUpdate = gohelper.findChild(self.go, "update_red")
	self._blueUpdate = gohelper.findChild(self.go, "update_blue")
	self._textTr = self._text.transform
	self._click = gohelper.getClickWithDefaultAudio(self.go)

	self._click:AddClickListener(self.onClickSelf, self)
end

function FightMagicCircleNormal:onClickSelf()
	local textPreferredHeight = self._text.preferredHeight
	local position = self._textTr.position

	FightController.instance:dispatchEvent(FightEvent.OnClickMagicCircleText, textPreferredHeight, position)
end

function FightMagicCircleNormal:onCreateMagic(magicMo, magicConfig)
	FightMagicCircleNormal.super.onCreateMagic(self, magicMo, magicConfig)
	self:playAnim("open")
end

function FightMagicCircleNormal:refreshUI(magicMo, magicConfig)
	self._text.text = magicConfig.name

	local side = FightHelper.getMagicSide(magicMo.createUid)

	gohelper.setActive(self._red, side == FightEnum.EntitySide.EnemySide)
	gohelper.setActive(self._blue, side == FightEnum.EntitySide.MySide)

	local color = side == FightEnum.EntitySide.MySide and "#547ca6" or "#9f4f4f"

	SLFramework.UGUI.GuiHelper.SetColor(self._text, color)

	local round = magicMo.round == -1 and "∞" or magicMo.round

	self._red_round_num.text = round
	self._blue_round_num.text = round

	if side == FightEnum.EntitySide.MySide then
		gohelper.setActive(self._blueUpdate, false)
		gohelper.setActive(self._blueUpdate, true)
	else
		gohelper.setActive(self._redUpdate, false)
		gohelper.setActive(self._redUpdate, true)
	end
end

function FightMagicCircleNormal:destroy()
	if self._click then
		self._click:RemoveClickListener()
	end

	FightMagicCircleNormal.super.destroy(self)
end

return FightMagicCircleNormal
