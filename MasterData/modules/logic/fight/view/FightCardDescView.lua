-- chunkname: @modules/logic/fight/view/FightCardDescView.lua

module("modules.logic.fight.view.FightCardDescView", package.seeall)

local FightCardDescView = class("FightCardDescView", BaseView)

function FightCardDescView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocardlist = gohelper.findChild(self.viewGO, "#go_cardlist")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardDescView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function FightCardDescView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function FightCardDescView:_btncloseOnClick()
	self:closeThis()
end

function FightCardDescView:_editableInitView()
	return
end

function FightCardDescView:onUpdateParam()
	return
end

function FightCardDescView:onOpen()
	for i, v in ipairs(lua_card_description.configList) do
		self:_addCardItem(v, i == #lua_card_description.configList)
	end
end

function FightCardDescView:_addCardItem(cardDescConfig, isSuperCard)
	local path = self.viewContainer:getSetting().otherRes[1]
	local item = self:getResInst(path, self._gocardlist)
	local cardDescItem = MonoHelper.addNoUpdateLuaComOnceToGo(item, FightCardDescItem)

	cardDescItem:onUpdateMO(cardDescConfig, isSuperCard)
end

function FightCardDescView:onClose()
	return
end

function FightCardDescView:onDestroyView()
	return
end

return FightCardDescView
