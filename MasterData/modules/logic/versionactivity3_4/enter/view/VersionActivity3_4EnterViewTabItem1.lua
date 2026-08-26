-- chunkname: @modules/logic/versionactivity3_4/enter/view/VersionActivity3_4EnterViewTabItem1.lua

module("modules.logic.versionactivity3_4.enter.view.VersionActivity3_4EnterViewTabItem1", package.seeall)

local VersionActivity3_4EnterViewTabItem1 = class("VersionActivity3_4EnterViewTabItem1", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity3_4EnterViewTabItem1:init(go)
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

function VersionActivity3_4EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_4EnterViewTabItem1:addEventListeners()
	VersionActivity3_4EnterViewTabItem1.super.addEventListeners(self)
	self.clickCollider:AddMouseUpListener(self.onClickCollider, self)
end

function VersionActivity3_4EnterViewTabItem1:removeEventListeners()
	VersionActivity3_4EnterViewTabItem1.super.removeEventListeners(self)
	self.clickCollider:RemoveMouseUpListener()
end

function VersionActivity3_4EnterViewTabItem1:onClickCollider()
	if not self:checkIsTopView() then
		return
	end

	if self._isDrag then
		return
	end

	self:onClick()
end

function VersionActivity3_4EnterViewTabItem1:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		return viewName == ViewName.VersionActivity3_4EnterView
	end
end

function VersionActivity3_4EnterViewTabItem1:setDrag(isDrag)
	self._isDrag = isDrag
end

return VersionActivity3_4EnterViewTabItem1
