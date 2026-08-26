-- chunkname: @modules/logic/versionactivity3_1/enter/view/VersionActivity3_1EnterViewTabItem1.lua

module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterViewTabItem1", package.seeall)

local VersionActivity3_1EnterViewTabItem1 = class("VersionActivity3_1EnterViewTabItem1", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity3_1EnterViewTabItem1:init(go)
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

function VersionActivity3_1EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_1EnterViewTabItem1:addEventListeners()
	VersionActivity3_1EnterViewTabItem1.super.addEventListeners(self)
	self.clickCollider:AddClickListener(self.onClickCollider, self)
end

function VersionActivity3_1EnterViewTabItem1:removeEventListeners()
	VersionActivity3_1EnterViewTabItem1.super.removeEventListeners(self)
	self.clickCollider:RemoveClickListener()
end

function VersionActivity3_1EnterViewTabItem1:onClickCollider()
	if self:isRaycastScrollTab() then
		return
	end

	self:onClick()
end

function VersionActivity3_1EnterViewTabItem1:isRaycastScrollTab()
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

return VersionActivity3_1EnterViewTabItem1
