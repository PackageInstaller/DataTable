-- chunkname: @modules/logic/player/view/IconListItem.lua

module("modules.logic.player.view.IconListItem", package.seeall)

local IconListItem = class("IconListItem", ListScrollCellExtend)

function IconListItem:onInitView()
	self._simageheadIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_headIcon")
	self._goframenode = gohelper.findChild(self.viewGO, "#simage_headIcon/#go_framenode")
	self._gochoosing = gohelper.findChild(self.viewGO, "#go_choosing")
	self._goblackShadow = gohelper.findChild(self.viewGO, "#go_blackShadow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IconListItem:addEvents()
	self._portraitclick:AddClickListener(self._selectPortrait, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.SelectPortrait, self._onSelectPortrait, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.SetPortrait, self._onSetPortrait, self)
end

function IconListItem:removeEvents()
	self._portraitclick:RemoveClickListener()
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.SelectPortrait, self._onSelectPortrait, self)
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.SetPortrait, self._onSetPortrait, self)
end

function IconListItem:_editableInitView()
	self._goportrait = gohelper.findChild(self.viewGO, "#simage_headIcon")
	self._portraitclick = SLFramework.UGUI.UIClickListener.Get(self._goportrait)
end

function IconListItem:_editableRemoveEvents()
	return
end

function IconListItem:_selectPortrait()
	IconTipModel.instance:setSelectIcon(self._usePortrait)
end

function IconListItem:_onSelectPortrait(id)
	local isSelf = self._usePortrait == id or self._mo.effectPortraitDic[id]

	gohelper.setActive(self._gochoosing, isSelf)
end

function IconListItem:_onSetPortrait(id)
	if self._mo.effectPortraitDic and self._mo.effectPortraitDic[id] then
		self:_refreshUI()
	end
end

function IconListItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
end

function IconListItem:_refreshUI()
	local mo = self._mo

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageheadIcon)

	local curPortrait = PlayerModel.instance:getPlayinfo().portrait
	local usePortrait = mo.effectPortraitDic and mo.effectPortraitDic[curPortrait] and curPortrait or mo.id

	self._usePortrait = usePortrait

	self._liveHeadIcon:setLiveHead(usePortrait)

	local selectIcon = IconTipModel.instance:getSelectIcon()

	gohelper.setActive(self._gochoosing, usePortrait == selectIcon)
end

function IconListItem:onDestroyView()
	self._simageheadIcon:UnLoadImage()
end

return IconListItem
