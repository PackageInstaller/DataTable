-- chunkname: @modules/logic/signin/view/SignInListItem.lua

module("modules.logic.signin.view.SignInListItem", package.seeall)

local SignInListItem = class("SignInListItem", ListScrollCellExtend)

function SignInListItem:init(go)
	self._go = go
	self._gonormal = gohelper.findChild(go, "normal")
	self._bgImg = gohelper.findChildImage(go, "normal/bg")
	self._gobirthday = gohelper.findChild(go, "birthday")
	self._gobirthday_act = gohelper.findChild(go, "birthday_act")
	self._txtbirthdaydate = gohelper.findChildText(go, "birthday/date")
	self._txtbirthdaydate_act = gohelper.findChildText(self._gobirthday_act, "date")
	self._gosingle = gohelper.findChild(go, "single")
	self._imagesinglerolebg = gohelper.findChildImage(self._gosingle, "bg")
	self._simagesingleicon = gohelper.findChildSingleImage(self._gosingle, "icon")
	self._gomultiple = gohelper.findChild(go, "multiple")
	self._goroles = {}
	self._imagerolesbg = {}
	self._simagemultiroleicons = {}

	for i = 1, 3 do
		self._goroles[i] = gohelper.findChild(self._gomultiple, "role" .. tostring(i))
		self._imagerolesbg[i] = gohelper.findChildImage(self._gomultiple, "role" .. tostring(i) .. "/bg")
		self._simagemultiroleicons[i] = gohelper.findChildSingleImage(self._gomultiple, "role" .. tostring(i) .. "/icon")
	end

	self._gocurrent = gohelper.findChild(go, "current")
	self._gogold = gohelper.findChild(go, "#go_gold")
	self._txtgolddaydate = gohelper.findChildText(go, "#go_gold/date")
	self._imageweek = gohelper.findChildImage(go, "img_week")
	self._imagebirthdayicon = gohelper.findChildImage(go, "img_birthdayicon")
	self._icon = gohelper.findChildSingleImage(go, "icon")
	self._gocount = gohelper.findChild(go, "count")
	self._quantity = gohelper.findChildText(go, "count/num")
	self._txtnormaldate = gohelper.findChildText(go, "normal/date")
	self._gomask = gohelper.findChild(go, "mask")
	self._gopast = gohelper.findChild(go, "#go_past")
	self._gosigned = gohelper.findChild(go, "#go_past/#go_signed")
	self._gonosigned = gohelper.findChild(go, "#go_past/#go_nosigned")
	self._pastselect = gohelper.findChild(go, "#go_past/select")
	self._get = gohelper.findChild(go, "get")
	self._itemClick = gohelper.getClickWithAudio(go)
	self._goanim = go:GetComponent(typeof(UnityEngine.Animator))
	self._bgcanvasGroup = self._bgImg:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._datecanvasGroup = self._txtnormaldate:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(self._go, false)
end

function SignInListItem:addEventListeners()
	self._itemClick:AddClickListener(self._onItemClick, self)
	SignInController.instance:registerCallback(SignInEvent.ClickSignInMonthItem, self._closeItemEffect, self)
	SignInController.instance:registerCallback(SignInEvent.GetSignInReply, self._onGetSignInReply, self)
	SignInController.instance:registerCallback(SignInEvent.SwitchBirthdayState, self._onRefreshBirthdayState, self)
end

function SignInListItem:removeEventListeners()
	self._itemClick:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.ClickSignInMonthItem, self._closeItemEffect, self)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInReply, self._onGetSignInReply, self)
	SignInController.instance:unregisterCallback(SignInEvent.SwitchBirthdayState, self._onRefreshBirthdayState, self)
end

function SignInListItem:_onItemClick()
	if self._isCurMonth then
		if not SignInModel.instance:isSignDayRewardGet(self._moDay) and self._moDay <= self._curDate.day then
			GameFacade.showToast(ToastEnum.SignInError)

			return
		end
	elseif 12 * (self._curDate.year - self._targetDate[1] - 1) + 13 - self._targetDate[2] + self._curDate.month <= 13 and not self:_isHistoryDaySigned() then
		GameFacade.showToast(ToastEnum.SignInError)

		return
	end

	if not self._isCurMonth or self._moDay <= self._curDate.day then
		SignInModel.instance:setTargetDate(self._targetDate[1], self._targetDate[2], self._moDay)
		SignInController.instance:dispatchEvent(SignInEvent.SignInItemClick)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_calendar_day_turn)
	elseif not self._showBirthday then
		MaterialTipController.instance:showMaterialInfo(self._mo.materilType, self._mo.materilId)
	end
end

function SignInListItem:onUpdateMO(mo)
	TaskDispatcher.cancelTask(self._showItemEffect)

	if self._mo == mo then
		return
	end

	self._mo = mo

	if mo then
		self._moDay = mo.day or 0
	end

	if mo then
		self._moWDay = mo.wday or 0
	end

	gohelper.setActive(self._go, false)

	if not self:_isEmptyMODay() then
		self:_refreshData()
		self:_startShowItem()
	end
end

function SignInListItem:_isEmptyMODay()
	if not self._mo or self._mo.isEmpty then
		return true
	end

	return false
end

function SignInListItem:_refreshData()
	self._targetDate = SignInModel.instance:getSignTargetDate()
	self._curDate = SignInModel.instance:getCurDate()
	self._isCurMonth = self._targetDate[1] == self._curDate.year and self._targetDate[2] == self._curDate.month
	self._isSelect = self._moDay == self._targetDate[3]
	self._isFollowDay = self._curDate.day < self._moDay
	self._rewardGet = SignInModel.instance:isSignDayRewardGet(self._moDay)

	if self:_specialMonthDay() and self._moDay <= self._curDate.day then
		self._isCurMonth = false
	end

	local registerDate = tonumber(PlayerModel.instance:getPlayinfo().registerTime)
	local date = os.date("!*t", registerDate / 1000 + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600)

	self._isBeforeRegisterTime = self._targetDate[1] == date.year and self._targetDate[2] == date.month and self._moDay < date.day
	self._showBirthday = SignInModel.instance:isShowBirthday()
	self._birthHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._moDay)

	if self._isCurMonth and not self._isBeforeRegisterTime then
		if self._moDay == self._curDate.day then
			self._birthHeros = SignInModel.instance:getCurDayBirthdayHeros()
		elseif self._moDay > self._curDate.day then
			self._birthHeros = SignInModel.instance:getNoSignBirthdayHeros(self._targetDate[2], self._moDay)
		elseif not self._rewardGet then
			self._birthHeros = SignInModel.instance:getNoSignBirthdayHeros(self._targetDate[2], self._moDay)
		end
	end

	local isAllowShowHead = #self._birthHeros > 0

	if isAllowShowHead and self._isCurMonth then
		local isTodayOrFuture = self._moDay >= self._curDate.day
		local isPast = not isTodayOrFuture

		isAllowShowHead = isPast and isAllowShowHead and self._rewardGet or isAllowShowHead and isTodayOrFuture
	end

	self._isAllowShowHead = isAllowShowHead
end

function SignInListItem:_startShowItem()
	if SignInModel.instance:isNewShowDetail() then
		self._delayTime = self._moWDay * 0.03

		TaskDispatcher.runDelay(self._showItemEffect, self, self._delayTime)

		return
	end

	if SignInModel.instance:isNewSwitch() then
		self._delayTime = self._moWDay * 0.03

		TaskDispatcher.runDelay(self._showSwitchEffect, self, self._delayTime)

		return
	end

	self._goanim.enabled = false

	self:_refreshItem()
end

function SignInListItem:_refreshItem()
	if self:_isEmptyMODay() then
		return
	end

	if self._isCurMonth then
		if self._showBirthday then
			self:_refreshBirthdayCurrentMonth()
		else
			self:_refreshNormalCurrentMonth()
		end
	elseif self._showBirthday then
		self:_refreshBirthdayPastMonth()
	else
		self:_refreshNormalPastMonth()
	end
end

function SignInListItem:_showSwitchEffect()
	if self._delayTime >= 0.16 then
		SignInModel.instance:setNewSwitch(false)
	end

	self._goanim.enabled = true

	self._goanim:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.runDelay(self._refreshItem, self, 0.3)
end

function SignInListItem:_showItemEffect()
	if self._delayTime >= 0.16 then
		SignInModel.instance:setNewShowDetail(false)
	end

	self:_refreshItem()

	self._goanim.enabled = true

	self._goanim:Play(UIAnimationName.Open)
end

function SignInListItem:_refreshNormalCurrentMonth()
	local state = SignInModel.instance:checkIsGoldDayAndPass(self._targetDate, true, self._moDay)
	local datets = TimeUtil.timeToTimeStamp(self._targetDate[1], self._targetDate[2], self._moDay, TimeDispatcher.DailyRefreshTime, 1, 1)
	local week = os.date("%w", datets)

	gohelper.setActive(self._go, true)
	gohelper.setActive(self._gopast, false)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._gomultiple, false)
	gohelper.setActive(self._gosingle, false)

	self._txtnormaldate.text = string.format("%02d", self._moDay)
	self._txtbirthdaydate.text = string.format("%02d", self._moDay)
	self._txtgolddaydate.text = string.format("%02d", self._moDay)

	UISpriteSetMgr.instance:setSignInSprite(self._imageweek, "date_small_" .. week)

	self._bgcanvasGroup.alpha = 1
	self._datecanvasGroup.alpha = 1

	gohelper.setActive(self._icon.gameObject, true)
	gohelper.setActive(self._gocount, true)
	gohelper.setActive(self._gocurrent, self._isSelect)

	if self._isBeforeRegisterTime then
		self:_refreshNormalPastMonth()
	else
		gohelper.setActive(self._gopast, false)

		local config, icon = ItemModel.instance:getItemConfigAndIcon(self._mo.materilType, self._mo.materilId, true)

		self._icon:LoadImage((tonumber(self._mo.materilType) == MaterialEnum.MaterialType.Equip or nil) and ResUrl.getPropItemIcon(config.icon))

		self._quantity.text = luaLang("multiple") .. GameUtil.numberDisplay(self._mo.quantity)

		gohelper.setActive(self._get, self._rewardGet)
		gohelper.setActive(self._gomask, not self._rewardGet and self._moDay < self._curDate.day)
	end

	gohelper.setActive(self._gogold, state)
	gohelper.setActive(self._imagebirthdayicon.gameObject, self._isAllowShowHead)
	self:_setActive_birthday(self._isAllowShowHead)
	UISpriteSetMgr.instance:setSignInSprite(self._imagebirthdayicon, (self._moDay >= self._curDate.day or nil) and "birthday_icon1")
end

function SignInListItem:_refreshBirthdayCurrentMonth()
	if self._isBeforeRegisterTime then
		self:_refreshBirthdayPastMonth()

		return
	end

	local daySigned = self:_isHistoryDaySigned()
	local isTodayOrFuture = self._moDay >= self._curDate.day
	local isPast = not isTodayOrFuture
	local datets = TimeUtil.timeToTimeStamp(self._targetDate[1], self._targetDate[2], self._moDay, TimeDispatcher.DailyRefreshTime, 1, 1)
	local week = os.date("%w", datets)
	local isAllowShowHead = self._isAllowShowHead
	local isShowSingle = isAllowShowHead and #self._birthHeros == 1
	local isShowMulti = isAllowShowHead and #self._birthHeros > 1
	local birthdayicon = "birthday_icon2"
	local rolebg = "birthday_herobg2"

	if isTodayOrFuture then
		birthdayicon = "birthday_icon1"
		rolebg = "birthday_herobg1"
	end

	gohelper.setActive(self._go, true)
	gohelper.setActive(self._gopast, false)

	self._txtnormaldate.text = string.format("%02d", self._moDay)
	self._txtbirthdaydate.text = string.format("%02d", self._moDay)
	self._txtgolddaydate.text = string.format("%02d", self._moDay)

	UISpriteSetMgr.instance:setSignInSprite(self._imageweek, "date_small_" .. week)
	gohelper.setActive(self._icon.gameObject, false)
	gohelper.setActive(self._gocurrent, self._isSelect)
	gohelper.setActive(self._gomask, not self._rewardGet and isPast)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._gocount, false)
	gohelper.setActive(self._get, self._rewardGet)
	gohelper.setActive(self._gosingle, isShowSingle)
	gohelper.setActive(self._gomultiple, isShowMulti)
	gohelper.setActive(self._gogold, false)
	gohelper.setActive(self._imagebirthdayicon.gameObject, isAllowShowHead)
	UISpriteSetMgr.instance:setSignInSprite(self._imagebirthdayicon, birthdayicon)

	if isAllowShowHead then
		if #self._birthHeros > 1 then
			for i = 1, 3 do
				gohelper.setActive(self._goroles[i], i <= #self._birthHeros)

				if i <= #self._birthHeros then
					local heroMo = HeroModel.instance:getByHeroId(self._birthHeros[i])

					if heroMo then
						if not heroMo.skin then
							local icon = HeroConfig.instance:getHeroCO(self._birthHeros[i]).skinId

							self._simagemultiroleicons[i]:LoadImage(ResUrl.getHeadIconSmall(icon))
							UISpriteSetMgr.instance:setSignInSprite(self._imagerolesbg[i], rolebg)
						end
					end
				end
			end
		elseif #self._birthHeros == 1 then
			local heroMo = HeroModel.instance:getByHeroId(self._birthHeros[1])

			if heroMo then
				if not heroMo.skin then
					local icon = HeroConfig.instance:getHeroCO(self._birthHeros[1]).skinId

					self._simagesingleicon:LoadImage(ResUrl.getHeadIconSmall(icon))
					UISpriteSetMgr.instance:setSignInSprite(self._imagesinglerolebg, rolebg)
				end
			end
		end
	end

	self:_setActive_birthday(isAllowShowHead)
end

function SignInListItem:_refreshNormalPastMonth()
	local daySigned = self:_isHistoryDaySigned()
	local datets = TimeUtil.timeToTimeStamp(self._targetDate[1], self._targetDate[2], self._moDay, TimeDispatcher.DailyRefreshTime, 1, 1)
	local week = os.date("%w", datets)

	if self._isAllowShowHead then
		local isAllowShowHead = daySigned
		local state = SignInModel.instance:checkIsGoldDay(self._targetDate, true, self._moDay)

		self._txtnormaldate.text = string.format("%02d", self._moDay)
		self._txtbirthdaydate.text = string.format("%02d", self._moDay)
		self._txtgolddaydate.text = string.format("%02d", self._moDay)

		UISpriteSetMgr.instance:setSignInSprite(self._imageweek, "date_small_" .. week)
		gohelper.setActive(self._go, true)
		gohelper.setActive(self._gopast, true)
		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._gosingle, false)
		gohelper.setActive(self._gomultiple, false)
		gohelper.setActive(self._pastselect, self._isSelect)
		gohelper.setActive(self._gocurrent, false)
		gohelper.setActive(self._gomask, false)
		gohelper.setActive(self._icon.gameObject, false)
		gohelper.setActive(self._gocount, false)
		gohelper.setActive(self._get, false)

		self._bgcanvasGroup.alpha = 0.6
		self._datecanvasGroup.alpha = 0.6

		gohelper.setActive(self._imagebirthdayicon.gameObject, isAllowShowHead)

		if isAllowShowHead then
			UISpriteSetMgr.instance:setSignInSprite(self._imagebirthdayicon, "birthday_icon2")
		end

		if 12 * (self._curDate.year - self._targetDate[1] - 1) + 13 - self._targetDate[2] + self._curDate.month > 13 then
			self:_setActive_sign(false)
		else
			self:_setActive_sign(not daySigned)
		end

		gohelper.setActive(self._gogold, state)
		self:_setActive_birthday(isAllowShowHead)
	end
end

function SignInListItem:_refreshBirthdayPastMonth()
	local rolebg = "birthday_herobg2"
	local daySigned = self:_isHistoryDaySigned()
	local var_15_0 = self._showBirthday

	if self._showBirthday then
		var_15_0 = self._isAllowShowHead

		if self._isAllowShowHead then
			local hasHeroBirth = daySigned
			local isShowSingle = hasHeroBirth and #self._birthHeros == 1
			local isShowMulti = hasHeroBirth and #self._birthHeros > 1
			local datets = TimeUtil.timeToTimeStamp(self._targetDate[1], self._targetDate[2], self._moDay, TimeDispatcher.DailyRefreshTime, 1, 1)
			local week = os.date("%w", datets)

			self._txtnormaldate.text = string.format("%02d", self._moDay)
			self._txtbirthdaydate.text = string.format("%02d", self._moDay)
			self._txtgolddaydate.text = string.format("%02d", self._moDay)

			gohelper.setActive(self._gopast, true)
			gohelper.setActive(self._go, true)
			gohelper.setActive(self._gomask, false)
			gohelper.setActive(self._icon.gameObject, false)
			gohelper.setActive(self._gocount, false)
			gohelper.setActive(self._pastselect, self._isSelect)
			gohelper.setActive(self._gocurrent, false)
			gohelper.setActive(self._get, false)

			self._bgcanvasGroup.alpha = 0.6
			self._datecanvasGroup.alpha = 0.6

			UISpriteSetMgr.instance:setSignInSprite(self._imageweek, "date_small_" .. week)

			if self._showBirthday then
				gohelper.setActive(self._icon.gameObject, false)
			end

			gohelper.setActive(self._gonormal, true)
			gohelper.setActive(self._imagebirthdayicon.gameObject, hasHeroBirth)

			if hasHeroBirth then
				UISpriteSetMgr.instance:setSignInSprite(self._imagebirthdayicon, "birthday_icon2")
			end

			gohelper.setActive(self._gosingle, isShowSingle)
			gohelper.setActive(self._gomultiple, isShowMulti)

			if hasHeroBirth then
				if #self._birthHeros > 1 then
					for i = 1, 3 do
						gohelper.setActive(self._goroles[i], i <= #self._birthHeros)

						if i <= #self._birthHeros then
							local heroMo = HeroModel.instance:getByHeroId(self._birthHeros[i])

							if heroMo then
								if not heroMo.skin then
									local icon = HeroConfig.instance:getHeroCO(self._birthHeros[i]).skinId

									self._simagemultiroleicons[i]:LoadImage(ResUrl.getHeadIconSmall(icon))
									UISpriteSetMgr.instance:setSignInSprite(self._imagerolesbg[i], rolebg)
								end
							end
						end
					end
				elseif #self._birthHeros == 1 then
					local heroMo = HeroModel.instance:getByHeroId(self._birthHeros[1])

					if heroMo then
						if not heroMo.skin then
							local icon = HeroConfig.instance:getHeroCO(self._birthHeros[1]).skinId

							self._simagesingleicon:LoadImage(ResUrl.getHeadIconSmall(icon))
							UISpriteSetMgr.instance:setSignInSprite(self._imagesinglerolebg, rolebg)
						end
					end
				end
			end

			if 12 * (self._curDate.year - self._targetDate[1] - 1) + 13 - self._targetDate[2] + self._curDate.month > 13 then
				self:_setActive_sign(false)
			else
				self:_setActive_sign(not daySigned)
			end

			gohelper.setActive(self._gogold, false)
			self:_setActive_birthday(hasHeroBirth)
		end
	end
end

function SignInListItem:_closeItemEffect()
	return
end

function SignInListItem:_onRefreshBirthdayState()
	self:_refreshData()
	self:_startShowItem()
end

function SignInListItem:_onGetSignInReply()
	if self._targetDate[1] ~= self._curDate.year or self._targetDate[2] ~= self._curDate.month or self._curDate.day ~= self._moDay then
		return
	end

	self:_refreshData()
	self:_startShowItem()
end

function SignInListItem:onClose()
	gohelper.setActive(self._go, false)
end

function SignInListItem:onDestroy()
	self._icon:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshItem, self, 0.3)
	TaskDispatcher.cancelTask(self._showItemEffect, self)
	TaskDispatcher.cancelTask(self._showSwitchEffect, self)
end

function SignInListItem:parent()
	return self._mo.parent
end

function SignInListItem:haveFestival()
	local p = self:parent()

	return p and p:haveFestival() or false
end

function SignInListItem:_setActive_birthday(isActive)
	local haveFestival = self:haveFestival()

	gohelper.setActive(self._gobirthday, isActive and not haveFestival)
	gohelper.setActive(self._gobirthday_act, isActive and haveFestival)

	self._txtbirthdaydate_act.text = string.format("%02d", self._moDay)
end

function SignInListItem:_setActive_sign(isActive)
	gohelper.setActive(self._gosigned, isActive)
	gohelper.setActive(self._gonosigned, not isActive)
end

function SignInListItem:_specialMonthDay()
	local specialDate = SignInModel.instance:getSpecialdate()

	if self._targetDate.year == specialDate.year and self._targetDate.month == specialDate.month and self._curDate.year == specialDate.year and self._curDate.month == specialDate.month and self._moDay < specialDate.day then
		return true
	end

	return false
end

function SignInListItem:_isHistoryDaySigned()
	if self:_specialMonthDay() and self._rewardGet then
		return true
	end

	return SignInModel.instance:isHistoryDaySigned(self._targetDate.month, self._moDay)
end

return SignInListItem
