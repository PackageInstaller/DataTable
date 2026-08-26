-- chunkname: @modules/logic/fight/view/FightCareerIntroduceView.lua

module("modules.logic.fight.view.FightCareerIntroduceView", package.seeall)

local FightCareerIntroduceView = class("FightCareerIntroduceView", BaseView)

function FightCareerIntroduceView:onInitView()
	self._goblackbg = gohelper.findChild(self.viewGO, "#go_blackbg")
	self._btnitem1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_item1")
	self._btnitem2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_item2")
	self._btnitem3 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_item3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCareerIntroduceView:addEvents()
	self._btnitem1:AddClickListener(self._btnitem1OnClick, self)
	self._btnitem2:AddClickListener(self._btnitem2OnClick, self)
	self._btnitem3:AddClickListener(self._btnitem3OnClick, self)
	gohelper.getClickWithAudio(self._goblackbg):AddClickListener(self.closeThis, self)
end

function FightCareerIntroduceView:removeEvents()
	self._btnitem1:RemoveClickListener()
	self._btnitem2:RemoveClickListener()
	self._btnitem3:RemoveClickListener()
	gohelper.getClickWithAudio(self._goblackbg):RemoveClickListener()
end

function FightCareerIntroduceView:_btnitem1OnClick()
	self:_onItemClick()
end

function FightCareerIntroduceView:_btnitem2OnClick()
	self:_onItemClick()
end

function FightCareerIntroduceView:_btnitem3OnClick()
	self:_onItemClick()
end

function FightCareerIntroduceView:_onItemClick()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView, {
		isGuide = true
	})
end

function FightCareerIntroduceView:_editableInitView()
	return
end

function FightCareerIntroduceView:onUpdateParam()
	return
end

function FightCareerIntroduceView:onOpen()
	return
end

function FightCareerIntroduceView:onClose()
	return
end

function FightCareerIntroduceView:onDestroyView()
	return
end

return FightCareerIntroduceView
