-- chunkname: @modules/logic/fightuiswitch/view/FightUISwitchSceneView.lua

module("modules.logic.fightuiswitch.view.FightUISwitchSceneView", package.seeall)

local FightUISwitchSceneView = class("FightUISwitchSceneView", BaseView)

function FightUISwitchSceneView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._gounFullScene = gohelper.findChild(self.viewGO, "root/#go_unFullScene")
	self._goFullScene = gohelper.findChild(self.viewGO, "root/#go_FullScene")
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_effect")
	self._goeffectItem = gohelper.findChild(self.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem")
	self._gonormal = gohelper.findChild(self.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal/#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem/#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightUISwitchSceneView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnroot:AddClickListener(self._btncloseOnClick, self)
end

function FightUISwitchSceneView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnroot:RemoveClickListener()
end

function FightUISwitchSceneView:_btnequipOnClick()
	return
end

function FightUISwitchSceneView:_btncloseOnClick()
	self:closeThis()
end

function FightUISwitchSceneView:_btnclickOnClick()
	return
end

function FightUISwitchSceneView:_editableInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._btnroot = SLFramework.UGUI.UIClickListener.Get(self._goroot.gameObject)
end

function FightUISwitchSceneView:onUpdateParam()
	return
end

function FightUISwitchSceneView:onClickModalMask()
	self:closeThis()
end

function FightUISwitchSceneView:onOpen()
	self._mo = self.viewParam.mo
	self._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goroot, FightUISwitchEffectComp)

	self._effectComp:refreshEffect(self._goFullScene, self._mo, self.viewName)
end

function FightUISwitchSceneView:onClose()
	self._effectComp:onClose()
end

function FightUISwitchSceneView:onDestroyView()
	self._effectComp:onDestroy()
end

return FightUISwitchSceneView
