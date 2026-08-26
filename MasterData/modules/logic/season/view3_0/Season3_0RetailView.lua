-- chunkname: @modules/logic/season/view3_0/Season3_0RetailView.lua

module("modules.logic.season.view3_0.Season3_0RetailView", package.seeall)

local Season3_0RetailView = class("Season3_0RetailView", BaseView)

function Season3_0RetailView:onInitView()
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_summon/#btn_summon")
	self._txtpropnum = gohelper.findChildText(self.viewGO, "right/#go_summon/#go_currency/#txt_propnum")
	self._imagecurrencyicon = gohelper.findChildImage(self.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	self._btncurrencyicon = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	self._btnruledetail = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_ruledetail")
	self._goruletipdetail = gohelper.findChild(self.viewGO, "right/#go_ruletipdetail")
	self._btncloseruletip = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_ruletipdetail/#btn_closeruletip")
	self._goruletips = gohelper.findChild(self.viewGO, "right/#go_ruletips")
	self._txtruletips = gohelper.findChildText(self.viewGO, "right/#go_ruletips/#txt_ruletips")
	self._gomaxrarecard = gohelper.findChild(self.viewGO, "right/#go_ruletips/#txt_ruletips/#go_maxrarecard")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._txttitletips = gohelper.findChildText(self.viewGO, "title/tips/tips")
	self._txtsummon1 = gohelper.findChildText(self.viewGO, "right/#go_summon/circle/#txt_summon1")
	self._txtsummon2 = gohelper.findChildText(self.viewGO, "right/#go_summon/circle/#txt_summon2")
	self._goprogress = gohelper.findChild(self.viewGO, "title/progress")
	self._animationEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	MainCameraMgr.instance:addView(ViewName.Season3_0RetailView, self.autoInitRetailViewCamera, nil, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0RetailView:addEvents()
	self._btncurrencyicon:AddClickListener(self._btncurrencyiconOnClick, self)
	self._btnsummon:AddClickListener(self._btnsummonOnClick, self)
	self._btnruledetail:AddClickListener(self._btnruledetailOnClick, self)
	self._btncloseruletip:AddClickListener(self._btncloseruletipOnClick, self)
	self._animationEvent:AddEventListener("switch", self.onSwitchCard, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season3_0RetailView:removeEvents()
	self._btncurrencyicon:RemoveClickListener()
	self._btnsummon:RemoveClickListener()
	self._btnruledetail:RemoveClickListener()
	self._btncloseruletip:RemoveClickListener()
	self._animationEvent:RemoveEventListener("switch")
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season3_0RetailView:_btnruledetailOnClick()
	gohelper.setActive(self._goruletipdetail, true)
end

function Season3_0RetailView:_btncloseruletipOnClick()
	gohelper.setActive(self._goruletipdetail, false)
end

function Season3_0RetailView:_btncurrencyiconOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, id)
end

function Season3_0RetailView:_enterLevelInfoView(index)
	local retails = Activity104Model.instance:getAct104Retails()

	for _, v in pairs(retails) do
		if v.position == index then
			local data = {}

			data.retail = v

			Activity104Controller.instance:openSeasonRetailLevelInfoView(data)

			return
		end
	end
end

function Season3_0RetailView:_btnsummonOnClick()
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

function Season3_0RetailView:_editableInitView()
	return
end

function Season3_0RetailView:onUpdateParam()
	return
end

function Season3_0RetailView:onOpen()
	if self.viewParam then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_return)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	self._waitRefreshingRetailReply = false

	self.addEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetailSuccess, self)
	self:_refreshLevel()
	self:_refreshTitle()
	self:_refreshConstTips()
end

function Season3_0RetailView:_refreshConstTips()
	local weight, maxRare, equipId = Activity104Model.instance:caleRetailEquipRareWeight()

	if equipId == 0 then
		gohelper.setActive(self._goruletips, false)

		return
	end

	gohelper.setActive(self._goruletips, true)

	if not self._rareCard then
		self._rareCard = Season3_0CelebrityCardItem.New()

		self._rareCard:init(self._gomaxrarecard)
	end

	self._rareCard:reset(equipId)

	local weightPercent = math.floor(weight * 100)
	local tag = {
		luaLang("seasonretailview_rare_" .. maxRare),
		weightPercent
	}

	self._txtruletips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("seasonretailview_rule1"), tag)
end

function Season3_0RetailView:_onRefreshRetailSuccess()
	self._waitRefreshingRetailReply = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)
	self.viewContainer:playAnim(UIAnimationName.Switch, 0, 0)
end

function Season3_0RetailView:onSwitchCard()
	self:_refreshLevel()
	self:_refreshTitle()
end

function Season3_0RetailView:_refreshTitle()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)
	local currencyname = CurrencyConfig.instance:getCurrencyCo(id).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrencyicon, currencyname .. "_1", true)
	self:_setStages()
end

function Season3_0RetailView:_setStages()
	local stage = Activity104Model.instance:getAct104CurStage()
	local maxStage = Activity104Model.instance:getMaxStage()

	self.starComp = self.starComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._goprogress, SeasonStarProgressComp)

	self.starComp:refreshStar("#go_progress", stage, maxStage)
end

function Season3_0RetailView:_refreshLevel()
	self:_refreshTicket()
	self:_showEntrance()
end

function Season3_0RetailView:_refreshTicket()
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

function Season3_0RetailView:_onChangeRetail(changeIds)
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

function Season3_0RetailView:_showEntrance()
	self:_initRetailItemList()

	local retails = Activity104Model.instance:getAct104Retails()
	local retailCount = #retails

	for _, v in pairs(retails) do
		self:_refreshRetailEpisode(v)
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

function Season3_0RetailView:_initRetailItemList()
	if not self._retailItemList then
		self._retailItemList = {}

		for i = 1, 6 do
			self._retailItemList[i] = self:_createRetailItem(i)
		end
	end

	for i, v in ipairs(self._retailItemList) do
		gohelper.setActive(v.go, false)
	end
end

function Season3_0RetailView:_createRetailItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.findChild(self.viewGO, string.format("#go_entrance%s", index))
	item.goitem = gohelper.findChild(item.go, string.format("#go_item%s", index))
	item.txtlevelnum = gohelper.findChildText(item.goitem, string.format("mask/#txt_levelnum%s", index))
	item.btngo = gohelper.findChildButtonWithAudio(item.goitem, string.format("#btn_go%s", index))
	item.gorewards = gohelper.findChild(item.goitem, string.format("#go_rewards%s", index))
	item.cardRoot = gohelper.findChild(item.gorewards, string.format("rewardlist/#scroll_celebritycard%s/scrollcontent_seasoncelebritycarditem", index))
	item.gotag = gohelper.findChild(item.goitem, string.format("#go_tag%s", index))
	item.gonormaltips = gohelper.findChild(item.goitem, string.format("#go_normaltips%s", index))
	item.gospecialtips = gohelper.findChild(item.goitem, string.format("#go_specialtips%s", index))
	item.txtspecialtips = gohelper.findChildText(item.gospecialtips, "tips")

	item.btngo:AddClickListener(self._enterLevelInfoView, self, index)

	return item
end

function Season3_0RetailView:_refreshRetailEpisode(retailInfo)
	if not retailInfo then
		return
	end

	local position = retailInfo.position
	local item = self._retailItemList[position]

	if not item then
		logError(string.format("no find retail episode position, episodeId:%s  position:%s", retailInfo.id, position))

		return
	end

	gohelper.setActive(item.go, true)

	local actId = Activity104Model.instance:getCurSeasonId()
	local episodeCo = SeasonConfig.instance:getSeasonRetailEpisodeCo(actId, retailInfo.id)
	local advancedId = retailInfo.advancedId
	local advancedRare = retailInfo.advancedRare

	if episodeCo then
		item.txtlevelnum.text = episodeCo.desc or ""
	end

	gohelper.setActive(item.gonormaltips, advancedId ~= 0 and advancedRare == 1)
	gohelper.setActive(item.gospecialtips, advancedId ~= 0 and advancedRare == 2)

	if advancedId ~= 0 and advancedRare == 2 then
		local name = ""

		for _, equipId in pairs(retailInfo.showActivity104EquipIds) do
			local co = SeasonConfig.instance:getSeasonEquipCo(equipId)

			if co.isOptional == 1 then
				name = co.name

				break
			end
		end

		item.txtspecialtips.text = formatLuaLang("season_retail_specialtips", name)
	end

	item.cardItems = item.cardItems or {}

	for i = 1, 3 do
		local cardItem = item.cardItems[i]
		local equipId = retailInfo.showActivity104EquipIds[i]

		if equipId and equipId ~= 0 then
			local isNew = Activity104Model.instance:isNew104Equip(equipId)

			if not cardItem then
				cardItem = Season3_0CelebrityCardItem.New()
				commonRewardParams.showNewFlag2 = isNew

				cardItem:init(item.cardRoot, equipId, commonRewardParams)
				cardItem:showTag(true)

				item.cardItems[i] = cardItem
			else
				cardItem:reset(equipId)
				cardItem:showNewFlag2(isNew)
			end
		elseif cardItem then
			cardItem:setVisible(false)
		end
	end
end

function Season3_0RetailView:onClose()
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, false)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetailSuccess, self)
end

function Season3_0RetailView:autoInitRetailViewCamera()
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, true)
end

function Season3_0RetailView:onDestroyView()
	if self._retailItemList then
		for _, v in pairs(self._retailItemList) do
			v.btngo:RemoveClickListener()

			if v.cardItems then
				for _, cardItem in pairs(v.cardItems) do
					cardItem:destroy()
				end
			end
		end
	end
end

return Season3_0RetailView
