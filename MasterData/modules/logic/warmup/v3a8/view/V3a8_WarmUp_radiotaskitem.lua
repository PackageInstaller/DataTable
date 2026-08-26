-- chunkname: @modules/logic/warmup/v3a8/view/V3a8_WarmUp_radiotaskitem.lua

module("modules.logic.warmup.v3a8.view.V3a8_WarmUp_radiotaskitem", package.seeall)

local V3a8_WarmUp_radiotaskitem = class("V3a8_WarmUp_radiotaskitem", RougeSimpleItemBase)

function V3a8_WarmUp_radiotaskitem:onInitView()
	self._goDateUnSelected = gohelper.findChild(self.viewGO, "#go_DateUnSelected")
	self._goDateSelected = gohelper.findChild(self.viewGO, "#go_DateSelected")
	self._txtDateSelected = gohelper.findChildText(self.viewGO, "#go_DateSelected/#txt_DateSelected")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_WarmUp_radiotaskitem:addEvents()
	return
end

function V3a8_WarmUp_radiotaskitem:removeEvents()
	return
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer
local kAnimEvt = "onSwitch"

function V3a8_WarmUp_radiotaskitem:_getEpisodeConfig(episodeId)
	return self:_assetGetViewContainer():getEpisodeConfig(episodeId or self:episodeId())
end

function V3a8_WarmUp_radiotaskitem:_getRLOC(episodeId)
	return self:_assetGetViewContainer():getRLOC(episodeId or self:episodeId())
end

function V3a8_WarmUp_radiotaskitem:_isEpisodeDayOpen(episodeId)
	return self:_assetGetViewContainer():isEpisodeDayOpen(episodeId or self:episodeId())
end

function V3a8_WarmUp_radiotaskitem:_isEpisodeUnLock(episodeId)
	return self:_assetGetViewContainer():isEpisodeUnLock(episodeId or self:episodeId())
end

function V3a8_WarmUp_radiotaskitem:_isEpisodeReallyOpen(episodeId)
	return self:_assetGetViewContainer():isEpisodeReallyOpen(episodeId or self:episodeId())
end

function V3a8_WarmUp_radiotaskitem:episodeId()
	return self._mo
end

function V3a8_WarmUp_radiotaskitem:ctor(ctorParam)
	V3a8_WarmUp_radiotaskitem.super.ctor(self, ctorParam)
end

function V3a8_WarmUp_radiotaskitem:_editableInitView()
	V3a8_WarmUp_radiotaskitem.super._editableInitView(self)

	self._txtDateUnSelected = gohelper.findChildText(self._goDateUnSelected, "")
	self._click = gohelper.findChildButton(self.viewGO, "btn_click")
	self._txtDateLocked = gohelper.findChildText(self._goLocked, "")
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animSelf = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._animEvent:AddEventListener(kAnimEvt, self._onSwitchEvent, self)
	gohelper.setActive(self._goDateSelected, true)
	gohelper.setActive(self._goDateUnSelected, true)
	gohelper.setActive(self._goLocked, true)
end

function V3a8_WarmUp_radiotaskitem:onDestroyView()
	self._animEvent:RemoveAllEventListener()
	V3a8_WarmUp_radiotaskitem.super.onDestroyView(self)
end

function V3a8_WarmUp_radiotaskitem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function V3a8_WarmUp_radiotaskitem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function V3a8_WarmUp_radiotaskitem:setSelected(isSelect, bSlient)
	if self:isSelected() == isSelect then
		return
	end

	self:onSelect(isSelect, bSlient)
end

function V3a8_WarmUp_radiotaskitem:onSelect(isSelect, bSlient)
	if isSelect then
		if bSlient then
			self:playAnimIdleSelected()
		else
			self:playAnimSelect()
		end

		return
	end

	if not self._mo then
		self:playAnimLocked()
	else
		local isLock = not self:_isEpisodeReallyOpen()
		local bShowLocked = isLock or self:_unlockedIndex() < self:index()

		if bShowLocked then
			self:playAnimLocked()
		else
			self:playAnimIdleUnSelected()
		end
	end
end

function V3a8_WarmUp_radiotaskitem:setData(mo)
	V3a8_WarmUp_radiotaskitem.super.setData(self, mo)

	local episodeCfg = self:_getEpisodeConfig()
	local openDay = episodeCfg.openDay
	local isLock = not self:_isEpisodeReallyOpen()
	local isRecevied = self:_getRLOC()
	local showReddot = not isLock and not isRecevied
	local openDayDesc = formatLuaLang("warmup_radiotaskitem_day", openDay)

	self._txtDateUnSelected.text = openDayDesc
	self._txtDateSelected.text = openDayDesc
	self._txtDateLocked.text = openDayDesc

	gohelper.setActive(self._goreddot, showReddot and self:_unlockedIndex() >= self:index())

	local bShowLocked = isLock or self:_unlockedIndex() < self:index()

	if bShowLocked then
		self:playAnimLocked()
	end
end

function V3a8_WarmUp_radiotaskitem:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a8_WarmUp_radiotaskitem:playAnimLocked(cb, cbObj)
	self:_playAnim("locked", cb, cbObj)
end

function V3a8_WarmUp_radiotaskitem:playAnimIdleUnSelected(cb, cbObj)
	self:_playAnim("idle_unselected", cb, cbObj)
end

function V3a8_WarmUp_radiotaskitem:playAnimIdleSelected(cb, cbObj)
	self:_playAnim("idle_selected", cb, cbObj)
end

function V3a8_WarmUp_radiotaskitem:playAnimSelect(cb, cbObj)
	self:_playAnim(UIAnimationName.Select, cb, cbObj)
end

function V3a8_WarmUp_radiotaskitem:playAnimUnlock(cb, cbObj)
	gohelper.setActive(self._goreddot, false)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
	self._playAnim(self, UIAnimationName.Unlock, function(_)
		self:_onUnlockDone(cb, cbObj)
	end, self)
end

function V3a8_WarmUp_radiotaskitem:_onUnlockDone(cb, cbObj)
	local episodeId = self._mo
	local isLock = not self:_isEpisodeReallyOpen(episodeId)
	local isRecevied = self:_getRLOC(episodeId)
	local showReddot = not isLock and not isRecevied

	gohelper.setActive(self._goreddot, showReddot)

	if cb then
		cb(cbObj)
	end
end

function V3a8_WarmUp_radiotaskitem:_onClick()
	local p = self:_assetGetParent()

	p:onClickTab(self._mo)
end

function V3a8_WarmUp_radiotaskitem:_unlockedIndex()
	local p = self:_assetGetParent()

	return p._unlockedIndex or 0
end

function V3a8_WarmUp_radiotaskitem:_onSwitchEvent()
	local p = self:_assetGetParent()

	p:_onSwitchEvent(self)
end

return V3a8_WarmUp_radiotaskitem
