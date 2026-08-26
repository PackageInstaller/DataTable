-- chunkname: @modules/logic/gm/view/GMVideoListItem.lua

module("modules.logic.gm.view.GMVideoListItem", package.seeall)

local GMVideoListItem = class("GMVideoListItem", ListScrollCell)
local SelectColor = Color.New(1, 0.8, 0.8, 1)
local NotSelectColor = Color.white
local PrevSelectVideo

function GMVideoListItem:init(go)
	self._btn = gohelper.findChildButtonWithAudio(go, "btn")

	self._btn:AddClickListener(self._onClickItem, self)
	recthelper.setWidth(go.transform, 500)
	recthelper.setWidth(self._btn.transform, 500)

	self._imgBtn = gohelper.findChildImage(go, "btn")
	self._txtName = gohelper.findChildText(go, "btn/Text")
	self._txtName.alignment = TMPro.TextAlignmentOptions.MidlineLeft
end

function GMVideoListItem:onUpdateMO(mo)
	self._mo = mo
	self._txtName.text = self._mo.id .. ": " .. self._mo.video

	self:onSelect(self._mo.video == PrevSelectVideo)
end

function GMVideoListItem:_onClickItem()
	PrevSelectVideo = self._mo.video

	self._view:setSelect(self._mo)
	ViewMgr.instance:openView(ViewName.GMVideoPlayView, self._mo.video)
end

function GMVideoListItem:onSelect(isSelect)
	if isSelect then
		self._imgBtn.color = SelectColor or NotSelectColor
	end
end

function GMVideoListItem:onDestroy()
	if self._btn then
		self._btn:RemoveClickListener()

		self._btn = nil
	end
end

return GMVideoListItem
