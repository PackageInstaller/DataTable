-- chunkname: @modules/logic/herogroup/view/CommonTrialHeroDetailView.lua

module("modules.logic.herogroup.view.CommonTrialHeroDetailView", package.seeall)

local CommonTrialHeroDetailView = class("CommonTrialHeroDetailView", SummonHeroDetailView)

function CommonTrialHeroDetailView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	CommonTrialHeroDetailView.super.onInitView(self)
end

function CommonTrialHeroDetailView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	CommonTrialHeroDetailView.super.addEvents(self)
end

function CommonTrialHeroDetailView:removeEvents()
	self._btnClose:RemoveClickListener()
	CommonTrialHeroDetailView.super.removeEvents(self)
end

function CommonTrialHeroDetailView:onOpen()
	CommonTrialHeroDetailView.super.onOpen(self)
	gohelper.setActive(self._btnClose, false)
	gohelper.setActive(gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute"), false)
	gohelper.setActive(gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/exskill"), false)
end

return CommonTrialHeroDetailView
