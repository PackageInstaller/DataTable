-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/titleappoint/view/TitleAppointmentView.lua

module("modules.logic.versionactivity3_4.laplaceforum.titleappoint.view.TitleAppointmentView", package.seeall)

local TitleAppointmentView = class("TitleAppointmentView", BaseView)

function TitleAppointmentView:onInitView()
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_jump")
	self._txtjumpnum = gohelper.findChildText(self.viewGO, "root/#btn_jump/#txt_jumpnum")
	self._gojumpreddot = gohelper.findChild(self.viewGO, "root/#btn_jump/#go_jumpreddot")
	self._gotag = gohelper.findChild(self.viewGO, "root/#go_tag")
	self._imagetitlebg = gohelper.findChildImage(self.viewGO, "root/#go_tag/#image_titlebg")
	self._txttag = gohelper.findChildText(self.viewGO, "root/#go_tag/#txt_tag")
	self._gotageff = gohelper.findChildText(self.viewGO, "root/#go_tag/refresh")
	self._imagebigreward = gohelper.findChildImage(self.viewGO, "root/#image_bigreward")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "root/progress/#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "root/progress/#scroll_view/Viewport/Content")
	self._gofillbg = gohelper.findChild(self.viewGO, "root/progress/#scroll_view/Viewport/Content/#go_fillbg")
	self._gofill = gohelper.findChild(self.viewGO, "root/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._goprogressitem = gohelper.findChild(self.viewGO, "root/progress/#scroll_view/Viewport/Content/#go_progressitem")
	self._gobonus = gohelper.findChild(self.viewGO, "root/progress/#go_Bonus")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TitleAppointmentView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function TitleAppointmentView:removeEvents()
	self._btnjump:RemoveClickListener()
end

function TitleAppointmentView:_btnjumpOnClick()
	return
end

function TitleAppointmentView:_editableInitView()
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint
	self._progressItems = self:getUserDataTb_()

	gohelper.setActive(self._gotageff, false)
	self:_addSelfEvents()
end

function TitleAppointmentView:_addSelfEvents()
	self._scrollview:AddOnValueChanged(self._onScrollRectValueChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onProgressChanged, self)
	self.addEventCb(self, TitleAppointmentController.instance, TitleAppointmentEvent.RewardInfoChanged, self._onRewardInfoChanged, self)
end

function TitleAppointmentView:_removeSelfEvents()
	self._scrollview:RemoveOnValueChanged()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onProgressChanged, self)
	self.removeEventCb(self, TitleAppointmentController.instance, TitleAppointmentEvent.RewardInfoChanged, self._onRewardInfoChanged, self)
end

function TitleAppointmentView:_onProgressChanged()
	self:_refresh()

	local popularCount = TitleAppointmentModel.instance:getPopularValueCount()

	if popularCount <= self._popularCount then
		return
	end

	self:_progressFocus()
end

function TitleAppointmentView:_onRewardInfoChanged()
	self:_refresh()
	self:_progressFocus()
end

function TitleAppointmentView:_onScrollRectValueChanged()
	self:_refreshBonus()
end

function TitleAppointmentView:onOpen()
	self._titleId = TitleAppointmentModel.instance:getTargetTitle()

	self:_refresh()
	self:_progressFocus()
end

function TitleAppointmentView:_refresh()
	self:_refreshUI()
	self:_refreshProgress()
	self:_refreshBonus()
end

function TitleAppointmentView:_refreshUI()
	local titleId = TitleAppointmentModel.instance:getTargetTitle()

	self._popularCount = TitleAppointmentModel.instance:getPopularValueCount()
	self._txtjumpnum.text = GameUtil.numberDisplay(self._popularCount)

	gohelper.setActive(self._gotag, titleId > 0)

	if titleId > 0 then
		if self._titleId ~= titleId then
			gohelper.setActive(self._gotageff, true)
			TaskDispatcher.runDelay(self._onShowRefreshFinished, self, 1)

			self._titleId = titleId
		end

		local titleCo = TitleAppointmentConfig.instance:getTitleCo(titleId)

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagetitlebg, titleCo.titleBackground)

		self._txttag.text = titleCo.titleName
	end
end

function TitleAppointmentView:_onShowRefreshFinished()
	gohelper.setActive(self._gotageff, false)
end

function TitleAppointmentView:_refreshProgress()
	local bonusCos = TitleAppointmentConfig.instance:getMilestoneBonusCos(self._actId)

	for _, bonusCo in ipairs(bonusCos) do
		if not self._progressItems[bonusCo.id] then
			self._progressItems[bonusCo.id] = TitleAppointmentProgressItem.New()

			local go = gohelper.cloneInPlace(self._goprogressitem)

			self._progressItems[bonusCo.id]:init(go)
		end

		self._progressItems[bonusCo.id]:refresh(bonusCo)
	end

	TaskDispatcher.runDelay(self._setFill, self, 0.01)
end

function TitleAppointmentView:_setFill()
	local bonusCos = TitleAppointmentConfig.instance:getMilestoneBonusCos()
	local maxScore = bonusCos[#bonusCos].coinNum
	local popularCount = TitleAppointmentModel.instance:getPopularValueCount()
	local totalWidth = recthelper.getWidth(self._gofillbg.transform)

	if not (popularCount * totalWidth / maxScore) then
		recthelper.setWidth(self._gofill.transform, popularCount * totalWidth / maxScore)
	end
end

local StartContentPos = -800
local InterverPos = 268
local StartRewardIndex = 6

function TitleAppointmentView:_refreshBonus()
	if not self._bonusItem then
		self._bonusItem = TitleAppointmentProgressItem.New()

		self._bonusItem:init(self._gobonus)
		self._bonusItem:setGuideBonus(true)
	end

	local cPosx = transformhelper.getLocalPos(self._gocontent.transform)
	local curRewardIndex = StartRewardIndex + 1 + math.floor(math.abs(StartContentPos - cPosx) / InterverPos)
	local curGuideBousId = TitleAppointmentModel.instance:getTargetGuideBonusId(curRewardIndex)

	if self._curGuideBonusId == curGuideBousId then
		return
	end

	self._curGuideBonusId = curGuideBousId

	local bonusCo = TitleAppointmentConfig.instance:getMilestoneBonusCo(self._curGuideBonusId)

	self._bonusItem:refresh(bonusCo)
end

function TitleAppointmentView:_progressFocus()
	local curIndex = TitleAppointmentModel.instance:getCurRewardIndex() + 1

	if curIndex <= StartRewardIndex then
		return
	end

	local cPosx, cPosY = transformhelper.getLocalPos(self._gocontent.transform)
	local targetPosX = StartContentPos - (curIndex - StartRewardIndex) * InterverPos

	transformhelper.setLocalPosXY(self._gocontent.transform, targetPosX, cPosY)
end

function TitleAppointmentView:onClose()
	TaskDispatcher.cancelTask(self._onShowRefreshFinished, self)
end

function TitleAppointmentView:onDestroyView()
	self:_removeSelfEvents()
	TaskDispatcher.cancelTask(self._setFill, self)

	if self._progressItems then
		for _, progressItem in pairs(self._progressItems) do
			progressItem:destroy()
		end

		self._progressItems = nil
	end
end

return TitleAppointmentView
