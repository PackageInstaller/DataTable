-- chunkname: @modules/logic/fight/view/FightCardIntroduceView.lua

module("modules.logic.fight.view.FightCardIntroduceView", package.seeall)

local FightCardIntroduceView = class("FightCardIntroduceView", BaseView)

function FightCardIntroduceView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardIntroduceView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function FightCardIntroduceView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function FightCardIntroduceView:_btncloseOnClick()
	self:closeThis()
end

function FightCardIntroduceView:_editableInitView()
	return
end

function FightCardIntroduceView:onUpdateParam()
	return
end

function FightCardIntroduceView:onOpen()
	return
end

function FightCardIntroduceView:onClose()
	return
end

function FightCardIntroduceView:onDestroyView()
	return
end

return FightCardIntroduceView
