-- chunkname: @modules/logic/season/view1_3/Season1_3RetailView.lua

module("modules.logic.season.view1_3.Season1_3RetailView", package.seeall)

local Season1_3RetailView = class("Season1_3RetailView", BaseView)

function Season1_3RetailView:onInitView()
	self._goentrance1 = gohelper.findChild(self.viewGO, "#go_entrance1")
	self._goitem1 = gohelper.findChild(self.viewGO, "#go_entrance1/#go_item1")
	self._txtlevelnum1 = gohelper.findChildText(self.viewGO, "#go_entrance1/#go_item1/mask/#txt_levelnum1")
	self._btngo1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance1/#go_item1/#btn_go1")
	self._gorewards1 = gohelper.findChild(self.viewGO, "#go_entrance1/#go_item1/#go_rewards1")
	self._scrollcelebritycard1 = gohelper.findChildScrollRect(self.viewGO, "#go_entrance1/#go_item1/#go_rewards1/rewardlist/#scroll_celebritycard1")
	self._gotag1 = gohelper.findChild(self.viewGO, "#go_entrance1/#go_item1/#go_tag1")
	self._gonormaltips1 = gohelper.findChild(self.viewGO, "#go_entrance1/#go_item1/#go_normaltips1")
	self._gospecialtips1 = gohelper.findChild(self.viewGO, "#go_entrance1/#go_item1/#go_specialtips1")
	self._goentrance2 = gohelper.findChild(self.viewGO, "#go_entrance2")
	self._goitem2 = gohelper.findChild(self.viewGO, "#go_entrance2/#go_item2")
	self._txtlevelnum2 = gohelper.findChildText(self.viewGO, "#go_entrance2/#go_item2/mask/#txt_levelnum2")
	self._btngo2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance2/#go_item2/#btn_go2")
	self._gorewards2 = gohelper.findChild(self.viewGO, "#go_entrance2/#go_item2/#go_rewards2")
	self._scrollcelebritycard2 = gohelper.findChildScrollRect(self.viewGO, "#go_entrance2/#go_item2/#go_rewards2/rewardlist/#scroll_celebritycard2")
	self._gotag2 = gohelper.findChild(self.viewGO, "#go_entrance2/#go_item2/#go_tag2")
	self._gonormaltips2 = gohelper.findChild(self.viewGO, "#go_entrance2/#go_item2/#go_normaltips2")
	self._gospecialtips2 = gohelper.findChild(self.viewGO, "#go_entrance2/#go_item2/#go_specialtips2")
	self._goentrance3 = gohelper.findChild(self.viewGO, "#go_entrance3")
	self._goitem3 = gohelper.findChild(self.viewGO, "#go_entrance3/#go_item3")
	self._txtlevelnum3 = gohelper.findChildText(self.viewGO, "#go_entrance3/#go_item3/mask/#txt_levelnum3")
	self._btngo3 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance3/#go_item3/#btn_go3")
	self._gorewards3 = gohelper.findChild(self.viewGO, "#go_entrance3/#go_item3/#go_rewards3")
	self._scrollcelebritycard3 = gohelper.findChildScrollRect(self.viewGO, "#go_entrance3/#go_item3/#go_rewards3/rewardlist/#scroll_celebritycard3")
	self._gotag3 = gohelper.findChild(self.viewGO, "#go_entrance3/#go_item3/#go_tag3")
	self._gonormaltips3 = gohelper.findChild(self.viewGO, "#go_entrance3/#go_item3/#go_normaltips3")
	self._gospecialtips3 = gohelper.findChild(self.viewGO, "#go_entrance3/#go_item3/#go_specialtips3")
	self._goentrance4 = gohelper.findChild(self.viewGO, "#go_entrance4")
	self._goitem4 = gohelper.findChild(self.viewGO, "#go_entrance4/#go_item4")
	self._txtlevelnum4 = gohelper.findChildText(self.viewGO, "#go_entrance4/#go_item4/mask/#txt_levelnum4")
	self._btngo4 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance4/#go_item4/#btn_go4")
	self._gorewards4 = gohelper.findChild(self.viewGO, "#go_entrance4/#go_item4/#go_rewards4")
	self._scrollcelebritycard4 = gohelper.findChildScrollRect(self.viewGO, "#go_entrance4/#go_item4/#go_rewards4/rewardlist/#scroll_celebritycard4")
	self._gotag4 = gohelper.findChild(self.viewGO, "#go_entrance4/#go_item4/#go_tag4")
	self._gonormaltips4 = gohelper.findChild(self.viewGO, "#go_entrance4/#go_item4/#go_normaltips4")
	self._gospecialtips4 = gohelper.findChild(self.viewGO, "#go_entrance4/#go_item4/#go_specialtips4")
	self._goentrance5 = gohelper.findChild(self.viewGO, "#go_entrance5")
	self._goitem5 = gohelper.findChild(self.viewGO, "#go_entrance5/#go_item5")
	self._txtlevelnum5 = gohelper.findChildText(self.viewGO, "#go_entrance5/#go_item5/mask/#txt_levelnum5")
	self._btngo5 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance5/#go_item5/#btn_go5")
	self._gorewards5 = gohelper.findChild(self.viewGO, "#go_entrance5/#go_item5/#go_rewards5")
	self._scrollcelebritycard5 = gohelper.findChildScrollRect(self.viewGO, "#go_entrance5/#go_item5/#go_rewards5/rewardlist/#scroll_celebritycard5")
	self._gotag5 = gohelper.findChild(self.viewGO, "#go_entrance5/#go_item5/#go_tag5")
	self._gonormaltips5 = gohelper.findChild(self.viewGO, "#go_entrance5/#go_item5/#go_normaltips5")
	self._gospecialtips5 = gohelper.findChild(self.viewGO, "#go_entrance5/#go_item5/#go_specialtips5")
	self._goentrance6 = gohelper.findChild(self.viewGO, "#go_entrance6")
	self._goitem6 = gohelper.findChild(self.viewGO, "#go_entrance6/#go_item6")
	self._txtlevelnum6 = gohelper.findChildText(self.viewGO, "#go_entrance6/#go_item6/mask/#txt_levelnum6")
	self._btngo6 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance6/#go_item6/#btn_go6")
	self._gorewards6 = gohelper.findChild(self.viewGO, "#go_entrance6/#go_item6/#go_rewards6")
	self._scrollcelebritycard6 = gohelper.findChildScrollRect(self.viewGO, "#go_entrance6/#go_item6/#go_rewards6/rewardlist/#scroll_celebritycard6")
	self._gotag6 = gohelper.findChild(self.viewGO, "#go_entrance6/#go_item6/#go_tag6")
	self._gonormaltips6 = gohelper.findChild(self.viewGO, "#go_entrance6/#go_item6/#go_normaltips6")
	self._gospecialtips6 = gohelper.findChild(self.viewGO, "#go_entrance6/#go_item6/#go_specialtips6")
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_summon/#btn_summon")
	self._txtpropnum = gohelper.findChildText(self.viewGO, "right/#go_summon/#go_currency/#txt_propnum")
	self._imagecurrencyicon = gohelper.findChildImage(self.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	self._btncurrencyicon = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	self._btnruledetail = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_ruledetail")
	self._goruletipdetail = gohelper.findChild(self.viewGO, "right/#go_ruletipdetail")
	self._btncloseruletip = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_ruletipdetail/#btn_closeruletip")
	self._txtruletips = gohelper.findChildText(self.viewGO, "right/#go_ruletips/#txt_ruletips")
	self._gomaxrarecard = gohelper.findChild(self.viewGO, "right/#go_ruletips/#txt_ruletips/#go_maxrarecard")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._txttitletips = gohelper.findChildText(self.viewGO, "title/tips/tips")
	self._txtsummon1 = gohelper.findChildText(self.viewGO, "right/#go_summon/circle/#txt_summon1")
	self._txtsummon2 = gohelper.findChildText(self.viewGO, "right/#go_summon/circle/#txt_summon2")
	self._goprogress1 = gohelper.findChild(self.viewGO, "title/progress/#go_progress1")
	self._goprogress2 = gohelper.findChild(self.viewGO, "title/progress/#go_progress2")
	self._goprogress3 = gohelper.findChild(self.viewGO, "title/progress/#go_progress3")
	self._goprogress4 = gohelper.findChild(self.viewGO, "title/progress/#go_progress4")
	self._goprogress5 = gohelper.findChild(self.viewGO, "title/progress/#go_progress5")
	self._goprogress6 = gohelper.findChild(self.viewGO, "title/progress/#go_progress6")
	self._goprogress7 = gohelper.findChild(self.viewGO, "title/progress/#go_progress7")
	self._animationEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	MainCameraMgr.instance:addView(ViewName.Season1_3RetailView, self.autoInitRetailViewCamera, nil, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_3RetailView:addEvents()
	self._btngo1:AddClickListener(self._btngo1OnClick, self)
	self._btngo2:AddClickListener(self._btngo2OnClick, self)
	self._btngo3:AddClickListener(self._btngo3OnClick, self)
	self._btngo4:AddClickListener(self._btngo4OnClick, self)
	self._btngo5:AddClickListener(self._btngo5OnClick, self)
	self._btngo6:AddClickListener(self._btngo6OnClick, self)
	self._btncurrencyicon:AddClickListener(self._btncurrencyiconOnClick, self)
	self._btnsummon:AddClickListener(self._btnsummonOnClick, self)
	self._btnruledetail:AddClickListener(self._btnruledetailOnClick, self)
	self._btncloseruletip:AddClickListener(self._btncloseruletipOnClick, self)
	self._animationEvent:AddEventListener("switch", self.onSwitchCard, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season1_3RetailView:removeEvents()
	self._btngo1:RemoveClickListener()
	self._btngo2:RemoveClickListener()
	self._btngo3:RemoveClickListener()
	self._btngo4:RemoveClickListener()
	self._btngo5:RemoveClickListener()
	self._btngo6:RemoveClickListener()
	self._btncurrencyicon:RemoveClickListener()
	self._btnsummon:RemoveClickListener()
	self._btnruledetail:RemoveClickListener()
	self._btncloseruletip:RemoveClickListener()
	self._animationEvent:RemoveEventListener("switch")
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season1_3RetailView:_btngo1OnClick()
	self:_enterLevelInfoView(1)
end

function Season1_3RetailView:_btngo2OnClick()
	self:_enterLevelInfoView(2)
end

function Season1_3RetailView:_btngo3OnClick()
	self:_enterLevelInfoView(3)
end

function Season1_3RetailView:_btngo4OnClick()
	self:_enterLevelInfoView(4)
end

function Season1_3RetailView:_btngo5OnClick()
	self:_enterLevelInfoView(5)
end

function Season1_3RetailView:_btngo6OnClick()
	self:_enterLevelInfoView(6)
end

function Season1_3RetailView:_btnruledetailOnClick()
	gohelper.setActive(self._goruletipdetail, true)
end

function Season1_3RetailView:_btncloseruletipOnClick()
	gohelper.setActive(self._goruletipdetail, false)
end

function Season1_3RetailView:_btncurrencyiconOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, id)
end

function Season1_3RetailView:_enterLevelInfoView(index)
	local retails = Activity104Model.instance:getAct104Retails()

	for _, v in pairs(retails) do
		if v.position == index then
			local data = {}

			data.retail = v
			data.episodeId = v.id

			Activity104Controller.instance:openSeasonRetailLevelInfoView(data)

			return
		end
	end
end

function Season1_3RetailView:_btnsummonOnClick()
	if self._waitRefreshingRetailReply then
		return
	end

	if self._hasEnoughTicket then
		local function requestRefreshRetail(self)
			local actId = Activity104Model.instance:getCurSeasonId()

			Activity104Rpc.instance:sendRefreshRetailRequest(actId)

			self._waitRefreshingRetailReply = false
		end

		local retails = Activity104Model.instance:getAct104Retails()

		if tabletool.len(retails) == 0 then
			requestRefreshRetail(self)
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.SeasonRetailTicketLimited, MsgBoxEnum.BoxType.Yes_No, requestRefreshRetail, nil, nil, self)
		end
	else
		GameFacade.showToast(ToastEnum.SeasonReadCountLimitedAndWait)
	end
end

function Season1_3RetailView:_editableInitView()
	return
end

function Season1_3RetailView:onUpdateParam()
	return
end

function Season1_3RetailView:onOpen()
	if self.viewParam then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_return)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	self._waitRefreshingRetailReply = false

	self.addEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetailSuccess, self)

	self._rewardCardItems = {}

	for i = 1, 6 do
		self._rewardCardItems[i] = {}
		self._rewardCardItems[i].celebrityCards = {}
	end

	self:_refreshLevel()
	self:_refreshTitle()
	self:_refreshConstTips()
end

function Season1_3RetailView:_refreshConstTips()
	local weight, maxRare, equipId = Activity104Model.instance:caleStageEquipRareWeight()

	if equipId ~= 0 then
		if not self._rareCard then
			self._rareCard = Season1_3CelebrityCardItem.New()

			self._rareCard:init(self._gomaxrarecard)
		end

		self._rareCard:reset(equipId)
	end

	local weightPercent = math.floor(weight * 100)
	local tag = {
		luaLang("seasonretailview_rare_" .. maxRare),
		weightPercent
	}

	self._txtruletips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("seasonretailview_rule1"), tag)
end

function Season1_3RetailView:_onRefreshRetailSuccess()
	self._waitRefreshingRetailReply = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)
	self.viewContainer:playAnim(UIAnimationName.Switch, 0, 0)
end

function Season1_3RetailView:onSwitchCard()
	self:_refreshLevel()
	self:_refreshTitle()
end

function Season1_3RetailView:_refreshTitle()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)
	local currencyname = CurrencyConfig.instance:getCurrencyCo(id).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrencyicon, currencyname .. "_1", true)
	self:_setStages()
end

function Season1_3RetailView:_setStages()
	local stage = Activity104Model.instance:getAct104CurStage()

	gohelper.setActive(self._goprogress7, stage == 7)

	for i = 1, 7 do
		local lvDark = gohelper.findChildImage(self["_goprogress" .. i], "dark")
		local lvLight = gohelper.findChildImage(self["_goprogress" .. i], "light")

		gohelper.setActive(lvLight.gameObject, i <= stage)
		gohelper.setActive(lvDark.gameObject, stage < i)

		local color = i == 7 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(lvLight, color)
	end
end

function Season1_3RetailView:_refreshLevel()
	self:_refreshTicket()
	self:_showEntrance()
end

function Season1_3RetailView:_refreshTicket()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)
	local needTicket = CurrencyConfig.instance:getCurrencyCo(id).recoverLimit
	local hasTicket = CurrencyModel.instance:getCurrency(id).quantity

	self._hasEnoughTicket = hasTicket >= 1

	if hasTicket == 0 then
		if not ("<color=#CF4543>" .. hasTicket .. "</color>/" .. needTicket) then
			self._txtpropnum.text = hasTicket .. "/" .. needTicket
		end
	end
end

function Season1_3RetailView:_onChangeRetail(changeIds)
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	if not id or not changeIds[id] then
		return
	end

	self:_refreshTicket()
end

local commonRewardParams = {
	targetFlagUIPosX = -25.9,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 19.5,
	showNewFlag2 = false
}

function Season1_3RetailView:_showEntrance()
	gohelper.setActive(self._goentrance1, false)
	gohelper.setActive(self._goentrance2, false)
	gohelper.setActive(self._goentrance3, false)
	gohelper.setActive(self._goentrance4, false)
	gohelper.setActive(self._goentrance5, false)
	gohelper.setActive(self._goentrance6, false)

	local retails = Activity104Model.instance:getAct104Retails()
	local retailCount = 0
	local actId = Activity104Model.instance:getCurSeasonId()

	for _, v in pairs(retails) do
		retailCount = retailCount + 1

		gohelper.setActive(self["_goentrance" .. v.position], true)

		local showStage = math.min(Activity104Model.instance:getAct104CurStage(), 6)
		local tagCo = SeasonConfig.instance:getSeasonTagDesc(actId, v.tag)

		self["_txtlevelnum" .. v.position].text = string.format("%s %s", tagCo.name, GameUtil.getRomanNums(showStage))

		gohelper.setActive(self["_gonormaltips" .. v.position], v.advancedId ~= 0 and v.advancedRare == 1)
		gohelper.setActive(self["_gospecialtips" .. v.position], v.advancedId ~= 0 and v.advancedRare == 2)

		if v.advancedId ~= 0 and v.advancedRare == 2 then
			local name = ""

			for _, equipId in pairs(v.showActivity104EquipIds) do
				local co = SeasonConfig.instance:getSeasonEquipCo(equipId)

				if co.isOptional == 1 then
					name = co.name

					break
				end
			end

			local txttip = gohelper.findChildText(self["_gospecialtips" .. v.position], "tips")

			txttip.text = string.format(luaLang("season_retail_specialtips"), name)
		end

		local cardRoot = gohelper.findChild(self["_scrollcelebritycard" .. v.position].gameObject, "scrollcontent_seasoncelebritycarditem")

		if #self._rewardCardItems[v.position].celebrityCards > 0 then
			for _, card in pairs(self._rewardCardItems[v.position].celebrityCards) do
				gohelper.setActive(card.go, false)
			end
		end

		for i = 1, 3 do
			local equipId = v.showActivity104EquipIds[i]
			local isNew = Activity104Model.instance:isNew104Equip(equipId)

			if not self._rewardCardItems[v.position].celebrityCards[i] then
				self._rewardCardItems[v.position].celebrityCards[i] = Season1_3CelebrityCardItem.New()
				commonRewardParams.showNewFlag2 = isNew

				self._rewardCardItems[v.position].celebrityCards[i]:init(cardRoot, equipId, commonRewardParams)
				self._rewardCardItems[v.position].celebrityCards[i]:showTag(true)
			else
				local cardItem = self._rewardCardItems[v.position].celebrityCards[i]

				gohelper.setActive(cardItem.go, true)
				cardItem:reset(equipId)
				cardItem:showNewFlag2(isNew)
			end
		end
	end

	if retailCount == 0 then
		self._txttitletips.text = luaLang("seasonretailview_unrefreshlevel")
		self._txtsummon1.text = luaLang("p_seasonretailview_search")
		self._txtsummon2.text = luaLang("p_seasonretailview_search")
	else
		self._txttitletips.text = luaLang("p_seasonretailview_tips")
		self._txtsummon1.text = luaLang("p_seasonsecretlandview_btnsummon")
		self._txtsummon2.text = luaLang("p_seasonsecretlandview_btnsummon")
	end
end

function Season1_3RetailView:onClose()
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, false)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetailSuccess, self)
end

function Season1_3RetailView:autoInitRetailViewCamera()
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, true)
end

function Season1_3RetailView:onDestroyView()
	if self._rewardCardItems then
		for _, v in pairs(self._rewardCardItems) do
			for _, card in pairs(v.celebrityCards) do
				card:destroy()
			end
		end

		self._rewardCardItems = nil
	end
end

return Season1_3RetailView
