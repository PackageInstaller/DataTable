-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterGroupItem.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterGroupItem", package.seeall)

local RougeLimiterGroupItem = class("RougeLimiterGroupItem", LuaCompBase)
local LimiterStateName = {
	Locked2UnLocked = "tounlock",
	Locked = "locked",
	UnLocked = "unlock",
	MaxLevel = "tohighest"
}

function RougeLimiterGroupItem:init(go)
	self.go = go
	self._gounlock = gohelper.findChild(self.go, "#go_unlock")
	self._imagebufficon = gohelper.findChildImage(self.go, "#go_unlock/#image_bufficon")
	self._txtbufflevel = gohelper.findChildText(self.go, "#go_unlock/#txt_bufflevel")
	self._btncancel = gohelper.findChildButtonWithAudio(self.go, "#btn_cancel")
	self._golocked = gohelper.findChild(self.go, "#go_locked")
	self._btnclick = gohelper.findChildButton(self.go, "#btn_click")
	self._gofulleffect = gohelper.findChild(self.go, "debuff3_light")
	self._goaddeffect = gohelper.findChild(self.go, "click")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)

	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, self._updateLimiterGroup, self)
end

function RougeLimiterGroupItem:addEventListeners()
	self._btncancel:AddClickListener(self._btncancelkOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeLimiterGroupItem:removeEventListeners()
	self._btncancel:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function RougeLimiterGroupItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function RougeLimiterGroupItem:refreshUI()
	local limiterState = RougeDLCModel101.instance:getCurLimiterGroupState(self._mo.id)
	local isLocked = limiterState == RougeDLCEnum101.LimitState.Locked

	self._curLimitGroupLv = RougeDLCModel101.instance:getCurLimiterGroupLv(self._mo.id)
	self._maxLimitGroupLv = RougeDLCConfig101.instance:getLimiterGroupMaxLevel(self._mo.id)
	self._isCurMaxGroupLv = self._curLimitGroupLv >= self._maxLimitGroupLv

	gohelper.setActive(self._golocked, isLocked)
	gohelper.setActive(self._gounlock, not isLocked)
	gohelper.setActive(self._btncancel.gameObject, not isLocked and self._curLimitGroupLv > 0)
	gohelper.setActive(self._txtbufflevel.gameObject, not isLocked and self._curLimitGroupLv <= self._maxLimitGroupLv)

	if not isLocked then
		self._txtbufflevel.text = GameUtil.getRomanNums(self._curLimitGroupLv)

		UISpriteSetMgr.instance:setRouge4Sprite(self._imagebufficon, self._mo.icon)
	end

	local animName = LimiterStateName.Locked

	if not isLocked then
		if self._isCurMaxGroupLv then
			animName = LimiterStateName.MaxLevel
		else
			local isNewUnlocked = RougeDLCModel101.instance:isLimiterGroupNewUnlocked(self._mo.id)

			animName = isNewUnlocked and LimiterStateName.Locked2UnLocked or LimiterStateName.UnLocked
		end
	end

	gohelper.setActive(self._gofulleffect, self._isCurMaxGroupLv)
	self._animator:Play(animName, 0, 0)
end

function RougeLimiterGroupItem:_btncancelkOnClick()
	RougeDLCModel101.instance:removeLimiterGroupLv(self._mo.id)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips, self._mo.id)
end

function RougeLimiterGroupItem:_btnclickOnClick()
	local limiterState = RougeDLCModel101.instance:getCurLimiterGroupState(self._mo.id)
	local isLocked = limiterState == RougeDLCEnum101.LimitState.Locked

	if isLocked then
		RougeDLCController101.instance:openRougeLimiterLockedTipsView({
			limiterGroupId = self._mo.id
		})

		return
	end

	if not self._isCurMaxGroupLv then
		gohelper.setActive(self._goaddeffect, false)
		gohelper.setActive(self._goaddeffect, true)

		if self._curLimitGroupLv + 1 == self._maxLimitGroupLv then
			AudioMgr.instance:trigger(AudioEnum.UI.ClickLimiter2MaxLevel)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.AddLimiterLevel)
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.MaxLevelLimiter)
	end

	RougeDLCModel101.instance:addLimiterGroupLv(self._mo.id)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips, self._mo.id)
end

function RougeLimiterGroupItem:_updateLimiterGroup(limiterGroupId)
	if self._mo and self._mo.id == limiterGroupId then
		self:refreshUI()
	end
end

function RougeLimiterGroupItem:onDestroy()
	return
end

return RougeLimiterGroupItem
