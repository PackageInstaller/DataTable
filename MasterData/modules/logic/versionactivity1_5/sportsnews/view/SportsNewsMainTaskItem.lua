-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsMainTaskItem.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsMainTaskItem", package.seeall)

local SportsNewsMainTaskItem = class("SportsNewsMainTaskItem", LuaCompBase)

function SportsNewsMainTaskItem:onInitView()
	self._gounlocked = gohelper.findChild(self.viewGO, "go_unlocked")
	self._imageItemBG1 = gohelper.findChildImage(self.viewGO, "go_unlocked/#image_ItemBG1")
	self._gounlockedpic = gohelper.findChildSingleImage(self.viewGO, "go_unlocked/#go_unlockedpic")
	self._txtunlocktitle = gohelper.findChildText(self.viewGO, "go_unlocked/#txt_unlocktitle")
	self._scrollunlockdesc = gohelper.findChildScrollRect(self.viewGO, "go_unlocked/#scroll_unlockdesc")
	self._txtunlockdescr = gohelper.findChildText(self.viewGO, "go_unlocked/#scroll_unlockdesc/Viewport/#txt_unlockdescr")
	self._golocked = gohelper.findChild(self.viewGO, "go_locked")
	self._imageItemBG2 = gohelper.findChildImage(self.viewGO, "go_locked/#image_ItemBG2")
	self._golockedpic = gohelper.findChildSingleImage(self.viewGO, "go_locked/#go_lockedpic")
	self._txtlocktitle = gohelper.findChildText(self.viewGO, "go_locked/#txt_locktitle")
	self._scrolllockdesc = gohelper.findChildScrollRect(self.viewGO, "go_locked/#scroll_lockdesc")
	self._txtlockdescr = gohelper.findChildText(self.viewGO, "go_locked/#scroll_lockdesc/Viewport/#txt_lockdescr")
	self._btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "go_locked/#btn_Finish/Click")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "go_locked/#btn_Go/Click")
	self._goRedPoint = gohelper.findChild(self.viewGO, "#go_RedPoint")
	self._goFinish = gohelper.findChild(self.viewGO, "go_locked/#btn_Finish")
	self._goGo = gohelper.findChild(self.viewGO, "go_locked/#btn_Go")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "go_unlocked/#btn_Info/Click")
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsMainTaskItem:addEvents()
	self._btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self.addEventCb(self, SportsNewsController.instance, SportsNewsEvent.OnCutTab, self.onCutTab, self)
end

function SportsNewsMainTaskItem:removeEvents()
	self._btnFinish:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self.removeEventCb(self, SportsNewsController.instance, SportsNewsEvent.OnCutTab, self.onCutTab, self)
end

function SportsNewsMainTaskItem:_btnFinishOnClick()
	if self._playingAnim then
		return
	end

	local actId = VersionActivity1_5Enum.ActivityId.SportsNews

	SportsNewsModel.instance:finishOrder(actId, self.orderMO.id)
	self:playAnim()
end

function SportsNewsMainTaskItem:_btnGoOnClick()
	if self._playingAnim then
		return
	end

	SportsNewsController.instance:jumpToFinishTask(self.orderMO, nil, self)
end

function SportsNewsMainTaskItem:_btnInfoOnClick()
	if self._playingAnim then
		return
	end

	if self.orderMO.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
		local actId = VersionActivity1_5Enum.ActivityId.SportsNews

		SportsNewsModel.instance:onReadEnd(actId, self.orderMO.id)
	end

	ViewMgr.instance:openView(ViewName.SportsNewsReadView, {
		orderMO = self.orderMO
	})
end

function SportsNewsMainTaskItem:_editableInitView()
	return
end

function SportsNewsMainTaskItem:onUpdateParam()
	return
end

function SportsNewsMainTaskItem:onOpen()
	return
end

function SportsNewsMainTaskItem:onClose()
	return
end

function SportsNewsMainTaskItem:onDestroyView()
	self:removeEvents()
	self._gounlockedpic:UnLoadImage()
	self._golockedpic:UnLoadImage()
end

function SportsNewsMainTaskItem:initData(go, index)
	self.viewGO = go
	self.index = index

	self:onInitView()
	self:addEvents()
end

function SportsNewsMainTaskItem:onRefresh(orderMO)
	self.orderMO = orderMO

	if not self._playingAnim then
		self._anim.enabled = true

		self._anim:Play(UIAnimationName.Idle, 0, 0)
	end

	if self.orderMO.status == ActivityWarmUpEnum.OrderStatus.Finished then
		self:unlockState()

		local _isCanPlayAnim = self:isCanPlayAnim()

		if _isCanPlayAnim then
			self:playAnim()
		end
	else
		self:lockState()
	end
end

function SportsNewsMainTaskItem:_onJumpFinish()
	return
end

function SportsNewsMainTaskItem:unlockState()
	gohelper.setActive(self._gounlocked, true)
	gohelper.setActive(self._golocked, self._playingAnim)

	self._txtunlocktitle.text = self.orderMO.cfg.name
	self._txtunlockdescr.text = self.orderMO.cfg.desc

	local _descscroll = self._scrollunlockdesc:GetComponent(gohelper.Type_LimitedScrollRect)

	_descscroll.verticalNormalizedPosition = 1

	local iconName = self.orderMO.cfg.bossPic

	self._gounlockedpic:LoadImage(ResUrl.getV1a5News(iconName))
end

function SportsNewsMainTaskItem:lockState()
	gohelper.setActive(self._gounlocked, false)
	gohelper.setActive(self._golocked, true)

	local status = self.orderMO.status

	gohelper.setActive(self._goFinish, status == ActivityWarmUpEnum.OrderStatus.Collected)
	gohelper.setActive(self._goGo, status == ActivityWarmUpEnum.OrderStatus.Accepted)

	local desc

	self._txtlocktitle.text = self.orderMO.cfg.name
	self._txtlockdescr.text = string.format(luaLang("v1a5_news_order_goto_title"), self.orderMO.cfg.location)

	local _descscroll = self._scrolllockdesc:GetComponent(gohelper.Type_LimitedScrollRect)

	_descscroll.verticalNormalizedPosition = 1

	local iconName = self.orderMO.cfg.bossPic

	self._golockedpic:LoadImage(ResUrl.getV1a5News(iconName))
end

SportsNewsMainTaskItem.UI_CLICK_BLOCK_KEY = "SportsNewsMainTaskItemClick"

function SportsNewsMainTaskItem:playAnim()
	self._playingAnim = true

	self:setUnlockPrefs(self.orderMO.id)
	gohelper.setActive(self._gounlocked, true)
	gohelper.setActive(self._golocked, true)
	self._animatorPlayer:Play(UIAnimationName.Unlock, self.onFinishUnlockAnim, self)
	AudioMgr.instance:trigger(AudioEnum.ui_v1a5_news.play_ui_wulu_complete_burn)
end

function SportsNewsMainTaskItem:onFinishUnlockAnim()
	gohelper.setActive(self._golocked, false)
	gohelper.setActive(self._gounlocked, true)

	self._playingAnim = nil

	self:onRefresh(self.orderMO)
end

function SportsNewsMainTaskItem:isCanPlayAnim()
	local isPlayedAnim = self:getUnlockPrefs(self.orderMO.id)

	return isPlayedAnim == 0
end

SportsNewsMainTaskItem.DayUnlockPrefs = "v1a5_news_prefs_order"

function SportsNewsMainTaskItem:getUnlockPrefs(index)
	local prefs = SportsNewsMainTaskItem.DayUnlockPrefs .. index

	return (SportsNewsModel.instance:getPrefs(prefs))
end

function SportsNewsMainTaskItem:setUnlockPrefs(index)
	local prefs = SportsNewsMainTaskItem.DayUnlockPrefs .. index

	SportsNewsModel.instance:setPrefs(prefs)
end

function SportsNewsMainTaskItem:onCutTab(index)
	if self._playingAnim then
		self._anim:Play(UIAnimationName.Unlock, 0, 0)

		self._anim.enabled = false

		self:onFinishUnlockAnim()
	end
end

return SportsNewsMainTaskItem
