-- chunkname: @modules/logic/fight/view/FightCardMixIntroduceView.lua

module("modules.logic.fight.view.FightCardMixIntroduceView", package.seeall)

local FightCardMixIntroduceView = class("FightCardMixIntroduceView", BaseView)

function FightCardMixIntroduceView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocardcontent1 = gohelper.findChild(self.viewGO, "#go_cardcontent1")
	self._gocardcontent2 = gohelper.findChild(self.viewGO, "#go_cardcontent2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardMixIntroduceView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function FightCardMixIntroduceView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function FightCardMixIntroduceView:_btncloseOnClick()
	self:closeThis()
end

function FightCardMixIntroduceView:_editableInitView()
	gohelper.setActive(self._gocardcontent1, false)
	gohelper.setActive(self._gocardcontent2, false)
end

function FightCardMixIntroduceView:onUpdateParam()
	return
end

function FightCardMixIntroduceView:onOpen()
	local index = self.viewParam.viewParam
	local go = self["_gocardcontent" .. tostring(index)]

	if go then
		gohelper.setActive(go, true)
	end
end

function FightCardMixIntroduceView:onClose()
	return
end

function FightCardMixIntroduceView:onDestroyView()
	return
end

return FightCardMixIntroduceView
