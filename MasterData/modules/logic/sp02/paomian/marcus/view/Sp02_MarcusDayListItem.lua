-- chunkname: @modules/logic/sp02/paomian/marcus/view/Sp02_MarcusDayListItem.lua

module("modules.logic.sp02.paomian.marcus.view.Sp02_MarcusDayListItem", package.seeall)

local Sp02_MarcusDayListItem = class("Sp02_MarcusDayListItem", LuaCompBase)

function Sp02_MarcusDayListItem:init(go)
	self.go = go
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._goUnselect = gohelper.findChild(self.go, "go_Unselect")
	self._goLock = gohelper.findChild(self.go, "go_Lock")
	self._txtSelectDay = gohelper.findChildText(self.go, "go_Select/txt_Day")
	self._txtUnselectDay = gohelper.findChildText(self.go, "go_Unselect/txt_Day")
	self._txtLockDay = gohelper.findChildText(self.go, "go_Lock/txt_Day")
	self._goReddot = gohelper.findChild(self.go, "go_Reddot")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.go)

	self._animatorPlayer:Play("idle", self._onPlayIdleAnimDone, self)
end

function Sp02_MarcusDayListItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Sp02_MarcusDayListItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_MarcusDayListItem:_btnClickOnClick()
	if self._isSelect then
		return
	end

	if self._status == Sp02_MarcusEnum.BonusStatus.Lock then
		local openTime = Sp02_MarcusConfig.instance:getBonusOpenTime(self._activityId, self._id)
		local limitTime = openTime - ServerTime.now()

		if limitTime > 0 then
			local limitTimeStr = TimeUtil.secondToRoughTime3(limitTime)

			GameFacade.showToast(ToastEnum.SP02MarcusNotUnlock, limitTimeStr)
		else
			GameFacade.showToast(ToastEnum.SP02MarcusNotPassPre)
		end

		return
	end

	Sp02_PaoMianController.instance:dispatchEvent(Sp02_MarcusEvent.OnSelectMarcusDay, self._index)
end

function Sp02_MarcusDayListItem:onUpdateMO(index, config, isSelect)
	self._index = index
	self._config = config
	self._activityId = config and config.activityId
	self._id = config and config.id
	self._isSelect = isSelect
	self._preStatus = self._status
	self._status = Sp02_MarcusModel.instance:getStatus(self._activityId, self._id)
	self._activityCo = ActivityConfig.instance:getActivityCo(self._activityId)
	self._redDotId = self._activityCo and self._activityCo.redDotId

	self:refreshUI()
end

function Sp02_MarcusDayListItem:refreshUI()
	RedDotController.instance:addRedDot(self._goReddot, self._redDotId, self._id)

	local dayStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_marcusview_day"), string.format("%02d", self._index))

	self._txtSelectDay.text = dayStr
	self._txtUnselectDay.text = dayStr
	self._txtLockDay.text = dayStr

	gohelper.setActive(self._goSelect, self._isSelect)
	gohelper.setActive(self._goUnselect, not self._isSelect and self._status ~= Sp02_MarcusEnum.BonusStatus.Lock)
	gohelper.setActive(self._goLock, not self._isSelect and self._status == Sp02_MarcusEnum.BonusStatus.Lock)

	if self._preStatus == Sp02_MarcusEnum.BonusStatus.Lock and self._status == Sp02_MarcusEnum.BonusStatus.CanGet then
		self._animatorPlayer:Play("unlock", self._onPlayUnlockAnimDone, self)
	end
end

function Sp02_MarcusDayListItem:_onPlayIdleAnimDone()
	return
end

function Sp02_MarcusDayListItem:_onPlayUnlockAnimDone()
	gohelper.setActive(self._goLock, self._status == Sp02_MarcusEnum.BonusStatus.Lock)
end

return Sp02_MarcusDayListItem
