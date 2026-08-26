-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupFightView.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupFightView", package.seeall)

local Rouge2_HeroGroupFightView = class("Rouge2_HeroGroupFightView", HeroGroupFightView)

function Rouge2_HeroGroupFightView:onInitView()
	Rouge2_HeroGroupFightView.super.onInitView(self)
	Rouge2_MapModel.instance:setManualCloseHeroGroupView(false)
end

function Rouge2_HeroGroupFightView:addEvents()
	Rouge2_HeroGroupFightView.super.addEvents(self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnPopGuideView, self._onPopGuideView, self)
end

function Rouge2_HeroGroupFightView:_onPopGuideView(techniqueId)
	Rouge2_Controller.instance:openTechniqueView(tonumber(techniqueId))
end

function Rouge2_HeroGroupFightView:_refreshCloth()
	gohelper.setActive(self._btncloth.gameObject, false)
end

function Rouge2_HeroGroupFightView:openHeroGroupEditView()
	ViewMgr.instance:openView(ViewName.Rouge2_HeroGroupEditView, self._param)
end

function Rouge2_HeroGroupFightView:_refreshPowerShow()
	Rouge2_HeroGroupFightView.super._refreshPowerShow(self)
	gohelper.setActive(self._gopowercontent, false)
end

function Rouge2_HeroGroupFightView:_setTrialNumTips()
	gohelper.setActive(self._goTrialTips, false)
end

return Rouge2_HeroGroupFightView
