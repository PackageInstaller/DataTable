-- chunkname: @modules/logic/versionactivity3_1/enter/view/VersionActivity3_1EnterViewTabItem2.lua

module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterViewTabItem2", package.seeall)

local VersionActivity3_1EnterViewTabItem2 = class("VersionActivity3_1EnterViewTabItem2", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity3_1EnterViewTabItem2:init(go)
	if gohelper.isNil(go) then
		return
	end

	self.go = go
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.clickCollider = ZProj.BoxColliderClickListener.Get(go)

	self.clickCollider:SetIgnoreUI(true)

	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self:_editableInitView()
	gohelper.setActive(self.go, true)
end

function VersionActivity3_1EnterViewTabItem2:_editableInitView()
	VersionActivity3_1EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity3_1EnterViewTabItem2:addEventListeners()
	VersionActivity3_1EnterViewTabItem2.super.addEventListeners(self)
	self.clickCollider:AddClickListener(self.onClickCollider, self)
end

function VersionActivity3_1EnterViewTabItem2:removeEventListeners()
	VersionActivity3_1EnterViewTabItem2.super.removeEventListeners(self)
	self.clickCollider:RemoveClickListener()
end

function VersionActivity3_1EnterViewTabItem2:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_1EnterViewTabItem2:afterSetData()
	VersionActivity3_1EnterViewTabItem2.super.afterSetData(self)

	if self.activityCo then
		self.txtName.text = self.activityCo.name or ""
	end

	if self.activityCo then
		self.txtNameEn.text = self.activityCo.nameEn or ""
	end
end

function VersionActivity3_1EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity3_1EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)
	self.txtNameEn.color = GameUtil.parseColor(tabSetting.enColor)
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
	self.txtName.alpha = tabSetting.cnAlpha or 1
	self.txtNameEn.alpha = tabSetting.enAlpha or 1
end

function VersionActivity3_1EnterViewTabItem2:onClickCollider()
	if self:isRaycastScrollTab() then
		return
	end

	self:onClick()
end

function VersionActivity3_1EnterViewTabItem2:isRaycastScrollTab()
	if not self._pointerEventData then
		self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	self._pointerEventData.position = UnityEngine.Input.mousePosition

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current

		if raycastResult.gameObject.name == "#scroll_tab" then
			return true
		end
	end
end

return VersionActivity3_1EnterViewTabItem2
