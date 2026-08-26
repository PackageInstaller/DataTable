-- chunkname: @modules/logic/partygame/view/common/CommonPartyGameResultHp.lua

module("modules.logic.partygame.view.common.CommonPartyGameResultHp", package.seeall)

local CommonPartyGameResultHp = class("CommonPartyGameResultHp", LuaCompBase)

function CommonPartyGameResultHp:init(go)
	self._go = go
	self._goselfbg = gohelper.findChild(self._go, "#go_selfbg")
	self._goteambg = gohelper.findChild(self._go, "#go_teambg")
	self._gohpmask = gohelper.findChild(self._go, "#go_hpmask")
	self._txttips = gohelper.findChildText(self._go, "#txt_tips")
	self._txtadd = gohelper.findChildText(self._go, "#txt_add")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonPartyGameResultHp:_editableInitView()
	self._maxwidth = recthelper.getWidth(self._goteambg.transform)
end

function CommonPartyGameResultHp:refreshHp(rank, hp)
	self._mainPlayerMo = PartyGameModel.instance:getMainPlayerMo()

	local curHp = self._mainPlayerMo.hp
	local maxHp = curHp + hp
	local progress = curHp / maxHp

	recthelper.setWidth(self._gohpmask.transform, self._maxwidth * progress)

	self._txttips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("partygame_result_hp"), rank, hp)
	self._txtadd.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("partygame_result_hp_1"), curHp, hp)
end

function CommonPartyGameResultHp:onDestroy()
	return
end

return CommonPartyGameResultHp
