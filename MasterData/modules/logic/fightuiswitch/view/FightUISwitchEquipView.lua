-- chunkname: @modules/logic/fightuiswitch/view/FightUISwitchEquipView.lua

module("modules.logic.fightuiswitch.view.FightUISwitchEquipView", package.seeall)

local FightUISwitchEquipView = class("FightUISwitchEquipView", BaseView)

function FightUISwitchEquipView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._goScene = gohelper.findChild(self.viewGO, "root/#go_Scene")
	self._gobottom = gohelper.findChild(self.viewGO, "root/#go_bottom")
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "root/#go_bottom/#scroll_effect")
	self._goeffectItem = gohelper.findChild(self.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem")
	self._gonormal = gohelper.findChild(self.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal/#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem/#go_select")
	self._goSceneName = gohelper.findChild(self.viewGO, "root/#go_bottom/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName/#txt_Time")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "root/#go_bottom/#txt_SceneDescr")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/#btn_equip")
	self._gouse = gohelper.findChild(self.viewGO, "root/#go_bottom/#go_use")
	self._gocardTitle = gohelper.findChild(self.viewGO, "root/Title/simage_cardTitle")
	self._gonumTitle = gohelper.findChild(self.viewGO, "root/Title/simage_numTitle")
	self._gouiTitle = gohelper.findChild(self.viewGO, "root/Title/simage_uiTitle")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightUISwitchEquipView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function FightUISwitchEquipView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function FightUISwitchEquipView:_btnclickOnClick()
	return
end

function FightUISwitchEquipView:_btnequipOnClick()
	FightUISwitchModel.instance:useStyleId(self._mo.classify, self._mo.id)
	self:_refreshBtn()
end

function FightUISwitchEquipView:_btncloseOnClick()
	self:closeThis()
end

function FightUISwitchEquipView:_editableInitView()
	return
end

function FightUISwitchEquipView:onUpdateParam()
	self:_refreshView()
end

function FightUISwitchEquipView:onClickModalMask()
	self:closeThis()
end

function FightUISwitchEquipView:onOpen()
	self:_refreshView()
end

function FightUISwitchEquipView:_refreshView()
	self._mo = self.viewParam.mo

	if self._effectComp then
		self._effectComp:init(self._gobottom)
	else
		self._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobottom, FightUISwitchEffectComp)
	end

	self:refreshStyle()
end

function FightUISwitchEquipView:refreshStyle()
	if not self._mo then
		return
	end

	self._effectComp:refreshEffect(self._goScene, self._mo, self.viewName)

	local co = self._mo:getItemConfig()

	if co then
		self._txtSceneName.text = co.name
		self._txtSceneDescr.text = co.desc

		gohelper.setActive(self._gonumTitle, co.subType == ItemEnum.SubType.FightFloatType)
		gohelper.setActive(self._gocardTitle, co.subType == ItemEnum.SubType.FightCard)
		gohelper.setActive(self._gouiTitle, co.subType == ItemEnum.SubType.MainUISkin)
	end

	self._txtTime.text = self._mo:getObtainTime() or ""

	self:_refreshBtn()
end

function FightUISwitchEquipView:_refreshBtn()
	local isEquip = self._mo:isUse()
	local isUnlock = self._mo:isUnlock()

	gohelper.setActive(self._btnequip.gameObject, isUnlock and not isEquip)
	gohelper.setActive(self._gouse.gameObject, isUnlock and isEquip)
end

function FightUISwitchEquipView:onClose()
	self._effectComp:onClose()
end

function FightUISwitchEquipView:onDestroyView()
	self._effectComp:onDestroy()
end

return FightUISwitchEquipView
