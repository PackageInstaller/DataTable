-- chunkname: @modules/logic/season/view/SeasonMainView.lua

module("modules.logic.season.view.SeasonMainView", package.seeall)

local SeasonMainView = class("SeasonMainView", BaseView)

function SeasonMainView:onInitView()
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._goreadprocess = gohelper.findChild(self.viewGO, "leftbtns/#go_readprocess")
	self._btnreadprocess = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtns/#go_readprocess/#btn_readprocess")
	self._gotask = gohelper.findChild(self.viewGO, "leftbtns/#go_task")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtns/#go_task/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "leftbtns/#go_task/#go_taskreddot")
	self._gocelebrity = gohelper.findChild(self.viewGO, "rightbtns/#go_celebrity")
	self._btncelebrity = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	self._goretail = gohelper.findChild(self.viewGO, "rightbtns/#go_retail")
	self._gocurrency = gohelper.findChild(self.viewGO, "rightbtns/#go_retail/#go_currency")
	self._imagecurrencyicon = gohelper.findChildImage(self.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	self._btncurrencyicon = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	self._txtcurrencycount = gohelper.findChildText(self.viewGO, "rightbtns/#go_retail/#go_currency/#txt_currencycount")
	self._btnretail = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_retail/#btn_retail")
	self._goassemblying = gohelper.findChild(self.viewGO, "rightbtns/#go_retail/#go_assemblying")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_title/txt_unlocktime")
	self._goentrance = gohelper.findChild(self.viewGO, "#go_entrance")
	self._gotop = gohelper.findChild(self.viewGO, "#go_entrance/#go_top")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_entrance/#txt_index")
	self._txtmapname = gohelper.findChildText(self.viewGO, "#go_entrance/#txt_mapname")
	self._btnentrance = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance/#btn_entrance", AudioEnum.UI.play_ui_leimi_biguncharted_open)
	self._godiscount = gohelper.findChild(self.viewGO, "#go_discount")
	self._btndiscount = gohelper.findChildButtonWithAudio(self.viewGO, "#go_discount/#btn_discount")
	self._godiscountlock = gohelper.findChild(self.viewGO, "#go_discount_lock")
	self._txtdiscountunlock = gohelper.findChildText(self.viewGO, "#go_discount_lock/#txt_discountunlock")
	self._btndiscountlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_discount_lock/#btn_discountlock")
	self._goMask = gohelper.findChild(self.viewGO, "#go_mask")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_entrance/decorates/#go_arrow")
	self._animationEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.SeasonTaskLevel)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonMainView:addEvents()
	self._btnreadprocess:AddClickListener(self._btnreadprocessOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btncelebrity:AddClickListener(self._btncelebrityOnClick, self)
	self._btnretail:AddClickListener(self._btnretailOnClick, self)
	self._btnentrance:AddClickListener(self._btnentranceOnClick, self)
	self._btndiscount:AddClickListener(self._btndiscountOnClick, self)
	self._btndiscountlock:AddClickListener(self._btndiscountlockOnClick, self)
	self._btncurrencyicon:AddClickListener(self._btncurrencyiconOnClick, self)
	self._animationEvent:AddEventListener("levelup", self.onLevelUp, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.SeasonShowUTTU, self._showUTTU, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._refreshUI, self)
end

function SeasonMainView:removeEvents()
	self._btnreadprocess:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btncelebrity:RemoveClickListener()
	self._btnretail:RemoveClickListener()
	self._btnentrance:RemoveClickListener()
	self._btndiscount:RemoveClickListener()
	self._btndiscountlock:RemoveClickListener()
	self._btncurrencyicon:RemoveClickListener()
	self._animationEvent:RemoveEventListener("levelup")
	self.removeEventCb(self, GuideController.instance, GuideEvent.SeasonShowUTTU, self._showUTTU, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._refreshUI, self)
end

function SeasonMainView:activeMask(active)
	gohelper.setActive(self._goMask, active)
end

function SeasonMainView:_btndiscountOnClick()
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function SeasonMainView:_btndiscountlockOnClick()
	return
end

function SeasonMainView:_btnretailOnClick()
	Activity104Controller.instance:openSeasonRetailView()
end

function SeasonMainView:_btnentranceOnClick()
	Activity104Controller.instance:openSeasonMarketView()
end

function SeasonMainView:_btnreadprocessOnClick()
	VersionActivityController.instance:openSeasonStoreView()
end

function SeasonMainView:_btntaskOnClick()
	Activity104Controller.instance:openSeasonTaskView()
end

function SeasonMainView:_btncelebrityOnClick()
	Activity104Controller.instance:openSeasonCardBook(Activity104Model.instance:getCurSeasonId())
end

function SeasonMainView:_btncurrencyiconOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, id)
end

function SeasonMainView:_editableInitView()
	self._progressItems = {}

	for i = 1, 7 do
		self._progressItems[i] = self:createProgress(i)
	end

	self._simagemask:LoadImage(ResUrl.getSeasonIcon("full/mask.png"))
end

function SeasonMainView:onUpdateParam()
	self:_refreshUI()
	self:checkJump()
end

function SeasonMainView:onOpen()
	self:activeMask(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_hippie_open)

	self.levelUpStage = self.viewParam and self.viewParam.levelUpStage

	if self.levelUpStage then
		self.viewContainer:getScene():showLevelObjs(self.levelUpStage)
	end

	self:_refreshUI()
	TaskDispatcher.runDelay(self._checkShowEquipSelfChoiceView, self, 0.1)
	self:checkJump()
end

function SeasonMainView:checkJump()
	if self.viewParam then
		if self.viewParam == Activity104Enum.JumpId.Market then
			Activity104Controller.instance:openSeasonMarketView()
		elseif self.viewParam == Activity104Enum.JumpId.Retail then
			Activity104Controller.instance:openSeasonRetailView()
		elseif self.viewParam == Activity104Enum.JumpId.Discount then
			Activity104Controller.instance:openSeasonSpecialMarketView()
		end
	end
end

function SeasonMainView:_checkShowEquipSelfChoiceView()
	local actId = Activity104Model.instance:getCurSeasonId()

	Activity104Controller.instance:checkShowEquipSelfChoiceView(actId)
end

function SeasonMainView:onLevelUp()
	if not self.levelUpStage then
		return
	end

	self:activeProgressLevup(self.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	self._passStage = self.levelUpStage

	TaskDispatcher.runDelay(self._showPassTips, self, 0.6)

	self.levelUpStage = nil
end

function SeasonMainView:_showPassTips()
	if self._passStage == 7 then
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips2)
	else
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips1)
	end
end

function SeasonMainView:_refreshUI()
	self:_refreshMain()
	self:_refreshRetail()
end

local indexNormalPos = Vector2(-92.8, -42.3)
local indexMaxLayerPos = Vector2(-76.6, -42.3)
local arrowNormalPos = Vector2(53.3, 15.7)
local arrowMaxLayerPos = Vector2(72, 16.1)

function SeasonMainView:_refreshMain()
	local actId = Activity104Model.instance:getCurSeasonId()
	local spOpen = Activity104Model.instance:isSpecialOpen()
	local isEnterSpecial = Activity104Model.instance:isEnterSpecial()
	local layer = Activity104Model.instance:getAct104CurLayer()
	local maxLayer = Activity104Model.instance:getMaxLayer()
	local openLayerCo = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SpecialOpenLayer)

	if openLayerCo then
		if not openLayerCo.value1 then
			local openLayer = 0
			local layerReached = openLayer < layer

			gohelper.setActive(self._godiscount, spOpen)
			gohelper.setActive(self._godiscountlock, isEnterSpecial or layerReached)

			if not spOpen then
				if layerReached then
					local dayCo = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SpecialOpenDayCount)
					local dayCount = dayCo.value1 - 1
					local limitSec = ActivityModel.instance:getActStartTime(actId) / 1000 + dayCount * 86400 - ServerTime.now()
					local timeStr = string.format("%s%s", TimeUtil.secondToRoughTime2(limitSec))

					self._txtdiscountunlock.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
				else
					self._txtdiscountunlock.text = string.format(luaLang("seasonmainview_layeropencondition"), openLayer)
				end
			else
				gohelper.setActive(self._godiscountlock, false)
			end

			self._txtindex.text = string.format("%02d", layer)

			if maxLayer == layer then
				if not indexMaxLayerPos then
					local targetIndexPos = indexNormalPos

					if maxLayer == layer then
						if not arrowMaxLayerPos then
							local targetArrowPos = arrowNormalPos

							recthelper.setAnchor(self._txtindex.transform, targetIndexPos.x, targetIndexPos.y)
							recthelper.setAnchor(self._goarrow.transform, targetArrowPos.x, targetArrowPos.y)
							gohelper.setActive(self._gotop, maxLayer == layer and Activity104Model.instance:isLayerPassed(layer))

							local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

							self._txtmapname.text = episodeCo.stageName

							local stage = Activity104Model.instance:getAct104CurStage()

							self:activeProgress(7, stage == 7)

							for i, v in ipairs(self._progressItems) do
								self:updateProgress(i, stage)
							end

							local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
							local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
							local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
							local hourSecond = offsetSecond % TimeUtil.OneDaySecond
							local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
							local timeStr = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
								day,
								hour
							})

							self._txtunlocktime.text = formatLuaLang("remain", timeStr)
						end
					end
				end
			end
		end
	end
end

function SeasonMainView:_refreshRetail()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)
	local currencyname = CurrencyConfig.instance:getCurrencyCo(id).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrencyicon, currencyname .. "_1", true)

	local isNotGuide = not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU)
	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)

	gohelper.setActive(self._goretail, isNotGuide and isOpen)

	self._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

	gohelper.setActive(self._goassemblying, self._retailProcessing)
	gohelper.setActive(self._gocurrency, not self._retailProcessing)

	if not self._retailProcessing then
		local needTicket = CurrencyConfig.instance:getCurrencyCo(id).recoverLimit
		local hasTicket = CurrencyModel.instance:getCurrency(id).quantity

		self._hasEnoughTicket = hasTicket >= 1

		local hasTxt = hasTicket > 0 and hasTicket or "<color=#CF4543>" .. hasTicket .. "</color>"

		self._txtcurrencycount.text = string.format("%s/%s", hasTxt, needTicket)
	end
end

function SeasonMainView:_showUTTU()
	self:_refreshRetail()

	local animator = gohelper.onceAddComponent(self._goretail, typeof(UnityEngine.Animator))

	if animator then
		animator:Play(UIAnimationName.Switch, 0, 0)
	end
end

function SeasonMainView:_onRefreshRetail()
	self:_refreshRetail()
end

function SeasonMainView:createProgress(index)
	local item = self:getUserDataTb_()

	item.go = gohelper.findChild(self.viewGO, string.format("#go_entrance/progress/#go_progress%s", index))
	item.dark = gohelper.findChild(item.go, "dark")
	item.light = gohelper.findChild(item.go, "light")
	item.lightImg = item.light:GetComponent(gohelper.Type_Image)
	item.leveup = gohelper.findChild(item.go, "leveup")

	return item
end

function SeasonMainView:activeProgress(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.go, active)
end

function SeasonMainView:activeProgressLevup(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.leveup, active)
end

function SeasonMainView:activeProgressLight(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.light, active)
end

function SeasonMainView:updateProgress(index, stage)
	local item = self._progressItems[index]

	if not item then
		return
	end

	local color = index == 7 and "#B83838" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(item.lightImg, color)
	gohelper.setActive(item.light, index <= stage and self.levelUpStage ~= index)
	gohelper.setActive(item.dark, stage < index)
end

function SeasonMainView:onClose()
	return
end

function SeasonMainView:onDestroyView()
	self._simagemask:UnLoadImage()
	TaskDispatcher.cancelTask(self._showPassTips, self)
	TaskDispatcher.cancelTask(self._checkShowEquipSelfChoiceView, self)
end

return SeasonMainView
