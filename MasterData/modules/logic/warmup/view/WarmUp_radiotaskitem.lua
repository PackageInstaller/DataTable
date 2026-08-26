-- chunkname: @modules/logic/warmup/view/WarmUp_radiotaskitem.lua

module("modules.logic.warmup.view.WarmUp_radiotaskitem", package.seeall)

local WarmUp_radiotaskitem = class("WarmUp_radiotaskitem", RougeSimpleItemBase)

function WarmUp_radiotaskitem:onInitView()
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WarmUp_radiotaskitem:addEvents()
	return
end

function WarmUp_radiotaskitem:removeEvents()
	return
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

function WarmUp_radiotaskitem:ctor(ctorParam)
	WarmUp_radiotaskitem.super.ctor(self, ctorParam)
end

function WarmUp_radiotaskitem:_editableInitView()
	WarmUp_radiotaskitem.super._editableInitView(self)

	self._txtDateUnSelected = gohelper.findChildText(self.viewGO, "txt_DateUnSelected")
	self._txtDateSelected = gohelper.findChildText(self.viewGO, "txt_DateSelected")
	self._goDateLocked = gohelper.findChild(self.viewGO, "image_Locked")
	self._goRed = gohelper.findChild(self.viewGO, "#go_reddot")
	self._click = gohelper.findChildButton(self.viewGO, "btn_click")
	self._txtDateSelectedGo = self._txtDateSelected.gameObject
	self._txtDateUnSelectedGo = self._txtDateUnSelected.gameObject
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animSelf = self._animatorPlayer.animator

	gohelper.setActive(self._goDateLocked, true)
end

function WarmUp_radiotaskitem:onDestroyView()
	WarmUp_radiotaskitem.super.onDestroyView(self)
end

function WarmUp_radiotaskitem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function WarmUp_radiotaskitem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function WarmUp_radiotaskitem:onSelect(isSelect)
	if isSelect then
		self:playAnimSelect()
	else
		self:playAnimIdle()
	end

	gohelper.setActive(self._txtDateSelectedGo, isSelect)
	gohelper.setActive(self._txtDateUnSelectedGo, not isSelect)
end

function WarmUp_radiotaskitem:_getEpisodeConfig(episodeId)
	return self:_assetGetViewContainer():getEpisodeConfig(episodeId)
end

function WarmUp_radiotaskitem:_getRLOC(episodeId)
	return self:_assetGetViewContainer():getRLOC(episodeId)
end

function WarmUp_radiotaskitem:_isEpisodeDayOpen(episodeId)
	return self:_assetGetViewContainer():isEpisodeDayOpen(episodeId)
end

function WarmUp_radiotaskitem:_isEpisodeUnLock(episodeId)
	return self:_assetGetViewContainer():isEpisodeUnLock(episodeId)
end

function WarmUp_radiotaskitem:_isEpisodeReallyOpen(episodeId)
	return self:_assetGetViewContainer():isEpisodeReallyOpen(episodeId)
end

function WarmUp_radiotaskitem:setData(mo)
	self._mo = mo

	local episodeId = mo
	local episodeCfg = self:_getEpisodeConfig(episodeId)
	local openDay = episodeCfg.openDay
	local isLock = not self:_isEpisodeReallyOpen(episodeId)
	local isRecevied = self:_getRLOC(episodeId)
	local showReddot = not isLock and not isRecevied
	local openDayDesc = formatLuaLang("warmup_radiotaskitem_day", openDay)

	self._txtDateUnSelected.text = openDayDesc
	self._txtDateSelected.text = openDayDesc

	gohelper.setActive(self._goRed, showReddot and self:_unlockedIndex() >= self:index())
	gohelper.setActive(self._goDateLocked, isLock or self:_unlockedIndex() < self:index())

	if self:index() == 1 then
		gohelper.setActive(self._goDateLocked, false)
	end
end

function WarmUp_radiotaskitem:_onClick()
	local p = self:_assetGetParent()

	p:onClickTab(self._mo)
end

function WarmUp_radiotaskitem:_unlockedIndex()
	local p = self:_assetGetParent()

	return p._unlockedIndex or 0
end

function WarmUp_radiotaskitem:_playAnim(name, cb, cbObj)
	local p = self:_assetGetParent()

	if p._openGo.activeSelf then
		self._animatorPlayer:Play(name, cb or function()
			return
		end, cbObj)
	elseif cb then
		cb(cbObj)
	end
end

function WarmUp_radiotaskitem:playAnimIdle(cb, cbObj)
	self:_playAnim(UIAnimationName.Idle, cb, cbObj)
end

function WarmUp_radiotaskitem:playAnimSelect(cb, cbObj)
	self:_playAnim(UIAnimationName.Select, cb, cbObj)
end

function WarmUp_radiotaskitem:playAnimUnlock(cb, cbObj)
	gohelper.setActive(self._goDateLocked, true)
	gohelper.setActive(self._goRed, false)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
	self._playAnim(self, UIAnimationName.Unlock, function(_)
		self:_onUnlockDone(cb, cbObj)
	end, self)
end

function WarmUp_radiotaskitem:_onUnlockDone(cb, cbObj)
	gohelper.setActive(self._goDateLocked, false)

	local episodeId = self._mo
	local isLock = not self:_isEpisodeReallyOpen(episodeId)
	local isRecevied = self:_getRLOC(episodeId)
	local showReddot = not isLock and not isRecevied

	gohelper.setActive(self._goRed, showReddot)

	if cb then
		cb(cbObj)
	end
end

return WarmUp_radiotaskitem
