-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsPageTabItem.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPageTabItem", package.seeall)

local SportsNewsPageTabItem = class("SportsNewsPageTabItem", LuaCompBase)

function SportsNewsPageTabItem:onInitView()
	self._imagebg = gohelper.findChildImage(self.viewGO, "#image_bg")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._txtselect = gohelper.findChildText(self.viewGO, "#go_select/#txt_select")
	self._txtselectnum = gohelper.findChildText(self.viewGO, "#go_select/#txt_selectnum")
	self._gounselect = gohelper.findChild(self.viewGO, "#go_unselect")
	self._txtunselect = gohelper.findChildText(self.viewGO, "#go_unselect/#txt_unselect")
	self._txtunselectnum = gohelper.findChildText(self.viewGO, "#go_unselect/#txt_unselectnum")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._imagelockbg = gohelper.findChildImage(self._golock, "image_lockbg")
	self._imageanilockbg = gohelper.findChildImage(self._golock, "ani/image_lockbg")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_lock/#txt_lock")
	self._txtlocknum = gohelper.findChildText(self.viewGO, "#go_lock/#txt_locknum")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_redpoint")
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsPageTabItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function SportsNewsPageTabItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function SportsNewsPageTabItem:_btnclickOnClick()
	local status = self:getTabStatus()

	if status == SportsNewsEnum.PageTabStatus.UnSelect then
		ActivityWarmUpController.instance:switchTab(self._index)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnCutTab, 1)
	end
end

function SportsNewsPageTabItem:_editableInitView()
	return
end

function SportsNewsPageTabItem:onUpdateParam()
	return
end

function SportsNewsPageTabItem:onOpen()
	return
end

function SportsNewsPageTabItem:onClose()
	return
end

function SportsNewsPageTabItem:onDestroyView()
	self:removeEvents()
	TaskDispatcher.cancelTask(self.runDelayCallBack, self)
end

function SportsNewsPageTabItem:initData(index, go)
	self._index = index
	self.viewGO = go

	self:onInitView()
	self:addEvents()

	local lockindex = self._index == 4 and 2 or 1
	local bgSpr = "v1a5_news_tabbtnlock0" .. lockindex

	UISpriteSetMgr.instance:setNewsSprite(self._imagelockbg, bgSpr, true)
	UISpriteSetMgr.instance:setNewsSprite(self._imageanilockbg, bgSpr, true)

	self._txtselectnum.text = index
	self._txtunselectnum.text = index
	self._txtlocknum.text = index

	self:playTabAnim()
end

function SportsNewsPageTabItem:onRefresh()
	local status = self:getTabStatus()

	self:enableStatusGameobj()

	local bgSpr

	UISpriteSetMgr.instance:setNewsSprite(self._imagebg, status == SportsNewsEnum.PageTabStatus.Select and "v1a5_news_tabbtnselect" or "v1a5_news_tabbtnnormal", true)
end

function SportsNewsPageTabItem:enableStatusGameobj()
	local status = self:getTabStatus()
	local isLock = status == SportsNewsEnum.PageTabStatus.Lock
	local isSelect = status == SportsNewsEnum.PageTabStatus.Select
	local isUnselect = status == SportsNewsEnum.PageTabStatus.UnSelect

	gohelper.setActive(self._golock, self._playingAnim or isLock)
	gohelper.setActive(self._imagebg.gameObject, not isLock)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._gounselect, isUnselect)
end

function SportsNewsPageTabItem:getTabStatus()
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()
	local isSelect = ActivityWarmUpModel.instance:getSelectedDay() == self._index
	local isLock = curDay < self._index

	if isLock then
		return SportsNewsEnum.PageTabStatus.Lock
	elseif isSelect then
		return SportsNewsEnum.PageTabStatus.Select
	else
		return SportsNewsEnum.PageTabStatus.UnSelect
	end
end

function SportsNewsPageTabItem:enableRedDot(enable, id, uid)
	gohelper.setActive(self._goreddot, enable)

	if enable then
		RedDotController.instance:addRedDot(self._goreddot, id, uid)
	end
end

function SportsNewsPageTabItem:playTabAnim()
	local unlock = self:isCanPlayAnim()

	TaskDispatcher.cancelTask(self.runDelayCallBack, self)

	if unlock then
		self._playingAnim = true

		self:enableStatusGameobj()
		self._animatorPlayer:Play(UIAnimationName.Unlock, self.onFinishUnlockAnim, self)
		TaskDispatcher.runDelay(self.runDelayCallBack, self, 1)
	end
end

function SportsNewsPageTabItem:runDelayCallBack()
	TaskDispatcher.cancelTask(self.runDelayCallBack, self)

	self._playingAnim = nil

	self:setUnlockPrefs(self._index)
end

function SportsNewsPageTabItem:onFinishUnlockAnim()
	self:enableStatusGameobj()
end

function SportsNewsPageTabItem:isCanPlayAnim()
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()
	local dayUnlock = self:getUnlockPrefs(self._index)

	return curDay >= self._index and dayUnlock == 0
end

SportsNewsPageTabItem.DayUnlockPrefs = "v1a5_news_prefs_day_tab"

function SportsNewsPageTabItem:getUnlockPrefs(index)
	local prefs = SportsNewsPageTabItem.DayUnlockPrefs .. index

	return (SportsNewsModel.instance:getPrefs(prefs))
end

function SportsNewsPageTabItem:setUnlockPrefs(index)
	local prefs = SportsNewsPageTabItem.DayUnlockPrefs .. index

	SportsNewsModel.instance:setPrefs(prefs)
end

return SportsNewsPageTabItem
