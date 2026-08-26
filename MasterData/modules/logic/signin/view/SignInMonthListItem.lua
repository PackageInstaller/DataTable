-- chunkname: @modules/logic/signin/view/SignInMonthListItem.lua

module("modules.logic.signin.view.SignInMonthListItem", package.seeall)

local SignInMonthListItem = class("SignInMonthListItem", LuaCompBase)

function SignInMonthListItem:init(go)
	self._obj = gohelper.findChild(go, "obj")
	self._normal = gohelper.findChild(go, "obj/normal")
	self._select = gohelper.findChild(go, "obj/select")
	self._txtmonthnormal = gohelper.findChildText(go, "obj/normal/txt_normalmonth")
	self._txtmonthselect = gohelper.findChildText(go, "obj/select/txt_selectmonth")
	self._itemClick = gohelper.getClickWithAudio(self._obj)
end

function SignInMonthListItem:addEventListeners()
	self._itemClick:AddClickListener(self._onItemClick, self)
	SignInController.instance:registerCallback(SignInEvent.GetHistorySignInSuccess, self._onCheckSignInMonthUnlocked, self)
end

function SignInMonthListItem:removeEventListeners()
	self._itemClick:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.GetHistorySignInSuccess, self._onCheckSignInMonthUnlocked, self)
end

function SignInMonthListItem:_onItemClick()
	local targetdate = SignInModel.instance:getSignTargetDate()

	if self._mo.year == targetdate[1] and self._mo.month == targetdate[2] then
		return
	end

	SignInModel.instance:setNewShowDetail(false)

	local curDate = SignInModel.instance:getCurDate()

	if self._mo.year == curDate.year and self._mo.month == curDate.month then
		SignInModel.instance:setTargetDate(self._mo.year, self._mo.month, curDate.day, curDate.wday)
		self:_refreshMonthItem()
	elseif 12 * (curDate.year - self._mo.year - 1) + 13 - self._mo.month + curDate.month > 13 then
		SignInModel.instance:setTargetDate(self._mo.year, self._mo.month, 1)
		self:_refreshMonthItem()
	else
		SignInRpc.instance:sendSignInHistoryRequest(self._mo.month)
	end
end

function SignInMonthListItem:_onCheckSignInMonthUnlocked(month)
	local curDate = SignInModel.instance:getCurDate()

	if self._mo.month == curDate.month and self._mo.year == curDate.year then
		return
	end

	if self._mo.month == month then
		local signInDays = SignInModel.instance:getHistorySignInDays(month)

		if signInDays and #signInDays > 0 then
			SignInModel.instance:setTargetDate(self._mo.year, self._mo.month, signInDays[1])
			self:_refreshMonthItem()
		else
			GameFacade.showToast(ToastEnum.SignInError)
		end
	end
end

function SignInMonthListItem:_refreshMonthItem()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_calendar_month_turn)
	SignInController.instance:dispatchEvent(SignInEvent.ClickSignInMonthItem)
end

function SignInMonthListItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()
end

function SignInMonthListItem:_refreshItem()
	self._txtmonthnormal.text = self._mo.month
	self._txtmonthselect.text = self._mo.month

	local targetdate = SignInModel.instance:getSignTargetDate()
	local select = self._mo.year == targetdate[1] and self._mo.month == targetdate[2]

	gohelper.setActive(self._select, select)
	gohelper.setActive(self._normal, not select)
end

function SignInMonthListItem:onDestroy()
	return
end

return SignInMonthListItem
