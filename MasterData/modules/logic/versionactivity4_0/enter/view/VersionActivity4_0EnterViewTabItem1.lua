-- chunkname: @modules/logic/versionactivity4_0/enter/view/VersionActivity4_0EnterViewTabItem1.lua

module("modules.logic.versionactivity4_0.enter.view.VersionActivity4_0EnterViewTabItem1", package.seeall)

local VersionActivity4_0EnterViewTabItem1 = class("VersionActivity4_0EnterViewTabItem1", VersionActivity4_0EnterViewTabItemBase)

function VersionActivity4_0EnterViewTabItem1:init(go)
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

function VersionActivity4_0EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity4_0EnterViewTabItem1:addEventListeners()
	VersionActivity4_0EnterViewTabItem1.super.addEventListeners(self)
	self.clickCollider:AddMouseUpListener(self.onClickCollider, self)
end

function VersionActivity4_0EnterViewTabItem1:removeEventListeners()
	VersionActivity4_0EnterViewTabItem1.super.removeEventListeners(self)
	self.clickCollider:RemoveMouseUpListener()
end

function VersionActivity4_0EnterViewTabItem1:onClickCollider()
	if not self:checkIsTopView() then
		return
	end

	if self._isDrag then
		return
	end

	self:onClick()
end

function VersionActivity4_0EnterViewTabItem1:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		return viewName == ViewName.VersionActivity4_0EnterView
	end
end

function VersionActivity4_0EnterViewTabItem1:onClick()
	VersionActivity4_0EnterViewTabItem1.super.onClick(self)

	if self.isSelect then
		return
	end
end

function VersionActivity4_0EnterViewTabItem1:setDrag(isDrag)
	self._isDrag = isDrag
end

return VersionActivity4_0EnterViewTabItem1
