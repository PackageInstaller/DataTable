-- chunkname: @modules/logic/season/view1_6/Season1_6MainView.lua

module("modules.logic.season.view1_6.Season1_6MainView", package.seeall)

local Season1_6MainView = class("Season1_6MainView", BaseView)

function Season1_6MainView:onInitView()
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
	self._goEnterEffect = gohelper.findChild(self.viewGO, "eff")

	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.SeasonTaskLevel)

	self._goletter = gohelper.findChild(self.viewGO, "#go_letter")
	self._btnletter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_letter/#btn_try")
	self._gotry = gohelper.findChild(self.viewGO, "#go_try")
	self._trialTxtNameen = gohelper.findChildTextMesh(self._gotry, "#txt_characteren")
	self._trialTxtNamecn = gohelper.findChildTextMesh(self._gotry, "#txt_charactercn")
	self._btntrial = gohelper.findChildButtonWithAudio(self._gotry, "#btn_try")
	self._trialCardGo = gohelper.findChild(self._gotry, "#go_card")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6MainView:addEvents()
	self._btnreadprocess:AddClickListener(self._btnreadprocessOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btncelebrity:AddClickListener(self._btncelebrityOnClick, self)
	self._btnretail:AddClickListener(self._btnretailOnClick, self)
	self._btnentrance:AddClickListener(self._btnentranceOnClick, self)
	self._btndiscount:AddClickListener(self._btndiscountOnClick, self)
	self._btndiscountlock:AddClickListener(self._btndiscountlockOnClick, self)
	self._btncurrencyicon:AddClickListener(self._btncurrencyiconOnClick, self)
	self._btnletter:AddClickListener(self._btnletterOnClick, self)
	self._btntrial:AddClickListener(self._btntrialOnClick, self)
	self._animationEvent:AddEventListener("levelup", self.onLevelUp, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.SeasonShowUTTU, self._showUTTU, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season1_6MainView:removeEvents()
	self._btnreadprocess:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btncelebrity:RemoveClickListener()
	self._btnretail:RemoveClickListener()
	self._btnentrance:RemoveClickListener()
	self._btndiscount:RemoveClickListener()
	self._btndiscountlock:RemoveClickListener()
	self._btncurrencyicon:RemoveClickListener()
	self._btnletter:RemoveClickListener()
	self._btntrial:RemoveClickListener()
	self._animationEvent:RemoveEventListener("levelup")
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.SeasonShowUTTU, self._showUTTU, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season1_6MainView:hideMask()
	gohelper.setActive(self._goMask, false)

	local actId = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:getIsPopSummary(actId) and Activity104Model.instance:getLastMaxLayer(actId) > 0 then
		Activity104Controller.instance:openSeasonSumView()
	else
		Activity104Controller.instance:dispatchEvent(Activity104Event.EnterSeasonMainView)
	end
end

function Season1_6MainView:activeMask(active)
	gohelper.setActive(self._goMask, active)
end

function Season1_6MainView:_btnletterOnClick()
	Activity104Controller.instance:openSeasonSumView()
end

function Season1_6MainView:_btntrialOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local trialId = Activity104Model.instance:getTrialId(actId)
	local co = SeasonConfig.instance:getTrialConfig(actId, trialId)

	if co then
		Activity104Model.instance:enterAct104Battle(co.episodeId, trialId)
	end
end

function Season1_6MainView:onTrialBattleReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:onStartAct104BattleReply(msg)
end

function Season1_6MainView:_btndiscountOnClick()
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function Season1_6MainView:_btndiscountlockOnClick()
	return
end

function Season1_6MainView:_btnretailOnClick()
	Activity104Controller.instance:openSeasonRetailView()
end

function Season1_6MainView:_btnentranceOnClick()
	Activity104Controller.instance:openSeasonMarketView()
end

function Season1_6MainView:_btnreadprocessOnClick()
	Activity104Controller.instance:openSeasonStoreView()
end

function Season1_6MainView:_btntaskOnClick()
	Activity104Controller.instance:openSeasonTaskView()
end

function Season1_6MainView:_btncelebrityOnClick()
	Activity104Controller.instance:openSeasonCardBook()
end

function Season1_6MainView:_btncurrencyiconOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, id)
end

function Season1_6MainView:_editableInitView()
	self._progressItems = {}

	local parentGo = gohelper.findChild(self.viewGO, "#go_entrance/progress")

	for i = 1, 7 do
		self._progressItems[i] = self:createProgress(i, parentGo)
	end
end

function Season1_6MainView:onUpdateParam()
	self:_refreshUI()
	self:checkJump()
end

function Season1_6MainView:onOpen()
	self:activeMask(true)
	TaskDispatcher.cancelTask(self.hideMask, self)
	TaskDispatcher.runDelay(self.hideMask, self, 1.5)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_hippie_open)

	self.levelUpStage = self.viewParam and self.viewParam.levelUpStage

	if self.levelUpStage then
		self.viewContainer:getScene():showLevelObjs(self.levelUpStage)
	end

	self:_refreshUI()
	TaskDispatcher.runDelay(self._checkShowEquipSelfChoiceView, self, 0.1)
	self:checkJump()
end

function Season1_6MainView:checkJump()
	if self.viewParam then
		if self.viewParam then
			local jumpParam = self.viewParam.jumpParam

			if self.viewParam == Activity104Enum.JumpId.Market then
				Activity104Controller.instance:openSeasonMarketView(jumpParam)
			elseif self.viewParam == Activity104Enum.JumpId.Retail then
				Activity104Controller.instance:openSeasonRetailView(jumpParam)
			elseif self.viewParam == Activity104Enum.JumpId.Discount then
				Activity104Controller.instance:openSeasonSpecialMarketView(jumpParam)
			end
		end
	end
end

function Season1_6MainView:_checkShowEquipSelfChoiceView()
	Activity104Controller.instance:checkShowEquipSelfChoiceView()
end

function Season1_6MainView:onLevelUp()
	if not self.levelUpStage then
		return
	end

	self:activeProgressLevup(self.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	self._passStage = self.levelUpStage

	TaskDispatcher.runDelay(self._showPassTips, self, 0.6)

	self.levelUpStage = nil
end

function Season1_6MainView:_showPassTips()
	if self._passStage == 7 then
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips2)
	else
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips1)
	end
end

function Season1_6MainView:_refreshUI()
	self:_refreshMain()
	self:_refreshRetail()
	TaskDispatcher.cancelTask(self._refreshMain, self)
	TaskDispatcher.runRepeat(self._refreshMain, self, 60)
end

local indexNormalPos = Vector2(-92.8, -42.3)
local indexMaxLayerPos = Vector2(-76.6, -42.3)
local arrowNormalPos = Vector2(53.3, 15.7)
local arrowMaxLayerPos = Vector2(72, 16.1)

function Season1_6MainView:_refreshMain()
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
							gohelper.setActive(self._gotop, maxLayer == layer and Activity104Model.instance:isLayerPassed(actId, layer))

							local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

							self._txtmapname.text = episodeCo.stageName

							local stage = Activity104Model.instance:getAct104CurStage()

							self:activeProgress(self._progressItems[7], stage == 7)

							for i, v in ipairs(self._progressItems) do
								self:updateProgress(v, stage)
							end

							local actInfoMo = ActivityModel.instance:getActMO(actId)
							local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
							local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
							local hourSecond = offsetSecond % TimeUtil.OneDaySecond
							local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
							local timeStr = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
								day,
								hour
							})

							self._txtunlocktime.text = formatLuaLang("remain", timeStr)

							self:refreshTrial()
						end
					end
				end
			end
		end
	end
end

function Season1_6MainView:refreshTrial()
	local actId = Activity104Model.instance:getCurSeasonId()
	local trialId = Activity104Model.instance:getTrialId(actId)
	local co = SeasonConfig.instance:getTrialConfig(actId, trialId)

	if co then
		gohelper.setActive(self._gotry, true)

		local layerCo = SeasonConfig.instance:getSeasonEpisodeCo(actId, co.unlockLayer)
		local stage = layerCo.stage

		if not self._trialProgressItems then
			self._trialProgressItems = {}

			local parentGo = gohelper.findChild(self._gotry, "progress")

			for i = 1, 7 do
				self._trialProgressItems[i] = self:createProgress(i, parentGo)
			end
		end

		self:activeProgress(self._trialProgressItems[7], stage == 7)

		for i, v in ipairs(self._trialProgressItems) do
			self:updateProgress(v, stage)
		end

		self._trialTxtNameen.text = co.nameEn
		self._trialTxtNamecn.text = co.name

		local episodeCo = DungeonConfig.instance:getEpisodeCO(co.episodeId)
		local battleId = episodeCo and episodeCo.battleId
		local battleCo = battleId and lua_battle.configDict[battleId]

		if not self.trialCardItem then
			self.trialCardItem = Season1_6CelebrityCardItem.New()

			self.trialCardItem:init(self._trialCardGo, battleCo.trialMainAct104EuqipId, {
				noClick = true
			})
		else
			self.trialCardItem:reset(battleCo.trialMainAct104EuqipId)
		end
	else
		gohelper.setActive(self._gotry, false)
	end
end

function Season1_6MainView:_refreshRetail()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)
	local currencyCo = CurrencyConfig.instance:getCurrencyCo(id)
	local currencyname = currencyCo and currencyCo.icon

	if currencyname then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrencyicon, currencyname .. "_1", true)
	end

	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)
	local isInUTTUGuide = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU)

	if not isInUTTUGuide then
		::label_27_0::

		local isInGuide = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)

		gohelper.setActive(self._goretail, isOpen and not isInUTTUGuide)

		self._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

		gohelper.setActive(self._goassemblying, self._retailProcessing)
		gohelper.setActive(self._gocurrency, not self._retailProcessing)

		if not self._retailProcessing then
			local needTicket = currencyCo and currencyCo.recoverLimit
			local readableMo = CurrencyModel.instance:getCurrency(id)

			if readableMo then
				if not readableMo.quantity then
					local hasTicket = 0

					self._hasEnoughTicket = hasTicket >= 1

					local hasTxt = hasTicket > 0 and hasTicket or "<color=#CF4543>" .. hasTicket .. "</color>"

					self._txtcurrencycount.text = string.format("%s/%s", hasTxt, needTicket)
				end
			end
		end

		gohelper.setActive(self._goEnterEffect, not isInGuide)
	end
end

function Season1_6MainView:_showUTTU()
	self:_refreshRetail()

	local animator = gohelper.onceAddComponent(self._goretail, typeof(UnityEngine.Animator))

	if animator then
		animator:Play(UIAnimationName.Switch, 0, 0)
	end
end

function Season1_6MainView:_onRefreshRetail()
	self:_refreshRetail()
end

function Season1_6MainView:_onChangeRetail(changeIds)
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	if not id or not changeIds[id] then
		return
	end

	self:_refreshRetail()
end

function Season1_6MainView:createProgress(index, parentGo)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.findChild(parentGo, string.format("#go_progress%s", index))
	item.dark = gohelper.findChild(item.go, "dark")
	item.light = gohelper.findChild(item.go, "light")
	item.lightImg = item.light:GetComponent(gohelper.Type_Image)
	item.leveup = gohelper.findChild(item.go, "leveup")

	return item
end

function Season1_6MainView:activeProgress(item, active)
	if not item then
		return
	end

	gohelper.setActive(item.go, active)
end

function Season1_6MainView:activeProgressLevup(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.leveup, active)
end

function Season1_6MainView:activeProgressLight(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.light, active)
end

function Season1_6MainView:updateProgress(item, stage)
	if not item then
		return
	end

	local index = item.index
	local color = index == 7 and "#B83838" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(item.lightImg, color)
	gohelper.setActive(item.light, index <= stage and self.levelUpStage ~= index)
	gohelper.setActive(item.dark, stage < index)
end

function Season1_6MainView:onTrialBattle(msg)
	return
end

function Season1_6MainView:onClose()
	return
end

function Season1_6MainView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshMain, self)
	TaskDispatcher.cancelTask(self.hideMask, self)
	TaskDispatcher.cancelTask(self._showPassTips, self)
	TaskDispatcher.cancelTask(self._checkShowEquipSelfChoiceView, self)
end

return Season1_6MainView
