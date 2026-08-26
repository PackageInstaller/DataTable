-- chunkname: @modules/logic/survival/view/SurvivalHeroGroupEquipView.lua

module("modules.logic.survival.view.SurvivalHeroGroupEquipView", package.seeall)

local SurvivalHeroGroupEquipView = class("SurvivalHeroGroupEquipView", BaseView)

function SurvivalHeroGroupEquipView:onInitView()
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_HeroEffect/#btn_equip")
end

function SurvivalHeroGroupEquipView:addEvents()
	self._btnequip:AddClickListener(self._onOpenEquipView, self)
end

function SurvivalHeroGroupEquipView:removeEvents()
	self._btnequip:RemoveClickListener()
end

function SurvivalHeroGroupEquipView:onOpen()
	MonoHelper.addNoUpdateLuaComOnceToGo(self._btnequip.gameObject, SurvivalEquipBtnComp)
end

function SurvivalHeroGroupEquipView:_onOpenEquipView()
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

return SurvivalHeroGroupEquipView
