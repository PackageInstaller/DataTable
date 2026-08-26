-- chunkname: @modules/logic/versionactivity3_8/enter/view/VersionActivity3_8EnterViewTabItem1.lua

module("modules.logic.versionactivity3_8.enter.view.VersionActivity3_8EnterViewTabItem1", package.seeall)

local VersionActivity3_8EnterViewTabItem1 = class("VersionActivity3_8EnterViewTabItem1", VersionActivity3_8EnterViewTabItemBase)

function VersionActivity3_8EnterViewTabItem1:init(go)
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

function VersionActivity3_8EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity3_8EnterViewTabItem1:addEventListeners()
	VersionActivity3_8EnterViewTabItem1.super.addEventListeners(self)
	self.clickCollider:AddMouseUpListener(self.onClickCollider, self)
end

function VersionActivity3_8EnterViewTabItem1:removeEventListeners()
	VersionActivity3_8EnterViewTabItem1.super.removeEventListeners(self)
	self.clickCollider:RemoveMouseUpListener()
end

function VersionActivity3_8EnterViewTabItem1:onClickCollider()
	if not self:checkIsTopView() then
		return
	end

	if self._isDrag then
		return
	end

	self:onClick()
end

function VersionActivity3_8EnterViewTabItem1:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		return viewName == ViewName.VersionActivity3_8EnterView
	end
end

function VersionActivity3_8EnterViewTabItem1:onClick()
	VersionActivity3_8EnterViewTabItem1.super.onClick(self)

	if self.isSelect then
		return
	end

	if self.actId == VersionActivity3_8Enum.ActivityId.Dungeon then
		self._audioId = AudioMgr.instance:trigger(AudioEnum3_8.VersionActivity3_8.play_ui_shiji_3_8_open_2)
	end
end

function VersionActivity3_8EnterViewTabItem1:setDrag(isDrag)
	self._isDrag = isDrag
end

function VersionActivity3_8EnterViewTabItem1:getWidth()
	local width = recthelper.getWidth(self.go.transform)

	if width > 0 then
		return width
	end

	return 420
end

return VersionActivity3_8EnterViewTabItem1
