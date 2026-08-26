-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterBuffListItem.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffListItem", package.seeall)

local RougeLimiterBuffListItem = class("RougeLimiterBuffListItem", ListScrollCellExtend)

function RougeLimiterBuffListItem:onInitView()
	self._imagebuffbg = gohelper.findChildImage(self.viewGO, "#image_buffbg")
	self._imagebufficon = gohelper.findChildImage(self.viewGO, "#image_bufficon")
	self._goequiped = gohelper.findChild(self.viewGO, "#go_equiped")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._gounnecessary = gohelper.findChild(self.viewGO, "#go_unnecessary")
	self._txtunnecessary = gohelper.findChildText(self.viewGO, "#go_unnecessary/txt_unnecessary")
	self._gocd = gohelper.findChild(self.viewGO, "#go_cd")
	self._txtcd = gohelper.findChildText(self.viewGO, "#go_cd/#txt_cd")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._lockedAnimator = ZProj.ProjAnimatorPlayer.Get(self._golocked)
	self._isSelect = false
end

function RougeLimiterBuffListItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, self._onUpdateBuffState, self)
end

function RougeLimiterBuffListItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeLimiterBuffListItem:_btnclickOnClick()
	local isSelect = not self._isSelect

	self._view:selectCell(self._index, isSelect)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.OnSelectBuff, self._mo.id, isSelect)
end

function RougeLimiterBuffListItem:onUpdateMO(mo)
	self._mo = mo
	self._buffState = nil

	self:refreshSelectUI()
	self:refreshBuff()
end

function RougeLimiterBuffListItem:refreshBuff()
	self:refreshBuffState()
	UISpriteSetMgr.instance:setRouge4Sprite(self._imagebufficon, self._mo.icon)
	UISpriteSetMgr.instance:setRouge3Sprite(self._imagebuffbg, "rouge_dlc1_buffbg" .. self._mo.buffType)
end

function RougeLimiterBuffListItem:refreshSelectUI()
	local isSelect = self._view:getFirstSelect() == self._mo

	gohelper.setActive(self._goselect, isSelect)
end

function RougeLimiterBuffListItem:refreshBuffState()
	local curBuffState = RougeDLCModel101.instance:getLimiterBuffState(self._mo.id)
	local isPreLocked = self._buffState == RougeDLCEnum101.BuffState.Locked
	local isCurUnlocked = curBuffState ~= RougeDLCEnum101.BuffState.Locked

	self._buffState = curBuffState

	self._lockedAnimator:Stop()

	if isPreLocked and isCurUnlocked then
		self._lockedAnimator:Play("unlock", self.refreshUI, self)

		return
	end

	self:refreshUI()
end

function RougeLimiterBuffListItem:refreshUI()
	gohelper.setActive(self._golocked, self._buffState == RougeDLCEnum101.BuffState.Locked)
	gohelper.setActive(self._goequiped, self._buffState == RougeDLCEnum101.BuffState.Equiped)
	gohelper.setActive(self._gocd, self._buffState == RougeDLCEnum101.BuffState.CD)
	gohelper.setActive(self._gounnecessary, self._mo.blank == 1)

	if self._buffState == RougeDLCEnum101.BuffState.CD then
		self._txtcd.text = RougeDLCModel101.instance:getLimiterBuffCD(self._mo.id)
	end
end

function RougeLimiterBuffListItem:_onUpdateBuffState(buffId)
	self:refreshBuffState()
end

function RougeLimiterBuffListItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goselect, isSelect)
end

function RougeLimiterBuffListItem:onDestroyView()
	return
end

return RougeLimiterBuffListItem
