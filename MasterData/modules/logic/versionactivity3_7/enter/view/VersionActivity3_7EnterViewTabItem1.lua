-- chunkname: @modules/logic/versionactivity3_7/enter/view/VersionActivity3_7EnterViewTabItem1.lua

module("modules.logic.versionactivity3_7.enter.view.VersionActivity3_7EnterViewTabItem1", package.seeall)

local VersionActivity3_7EnterViewTabItem1 = class("VersionActivity3_7EnterViewTabItem1", VersionActivity3_7EnterViewTabItemBase)

function VersionActivity3_7EnterViewTabItem1:init(go)
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

function VersionActivity3_7EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_7EnterViewTabItem1:addEventListeners()
	VersionActivity3_7EnterViewTabItem1.super.addEventListeners(self)
	self.clickCollider:AddMouseUpListener(self.onClickCollider, self)
end

function VersionActivity3_7EnterViewTabItem1:removeEventListeners()
	VersionActivity3_7EnterViewTabItem1.super.removeEventListeners(self)
	self.clickCollider:RemoveMouseUpListener()
end

function VersionActivity3_7EnterViewTabItem1:onClickCollider()
	if not self:checkIsTopView() then
		return
	end

	if self._isDrag then
		return
	end

	self:onClick()
end

function VersionActivity3_7EnterViewTabItem1:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		return viewName == ViewName.VersionActivity3_7EnterView
	end
end

function VersionActivity3_7EnterViewTabItem1:onClick()
	VersionActivity3_7EnterViewTabItem1.super.onClick(self)

	if self.isSelect then
		return
	end
end

function VersionActivity3_7EnterViewTabItem1:setDrag(isDrag)
	self._isDrag = isDrag
end

return VersionActivity3_7EnterViewTabItem1
