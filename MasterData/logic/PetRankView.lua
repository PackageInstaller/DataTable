-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetRankView.lua

module("logic.extensions.handbook.view.rank.PetRankView", package.seeall)

local PetRankView = class("PetRankView", ViewComponent)
local TitlePosPlan = {
	[PetRankModel.RankType_1] = 0,
	[PetRankModel.RankType_2] = 0,
	[PetRankModel.RankType_3] = 0,
	[PetRankModel.RankType_4] = 0,
	[PetRankModel.RankType_5] = 1,
	[PetRankModel.RankType_6] = 1
}
local TitleArenaName = {
	[PetRankModel.RankType_1] = "区服",
	[PetRankModel.RankType_2] = "家族",
	[PetRankModel.RankType_3] = "区服",
	[PetRankModel.RankType_4] = "家族",
	[PetRankModel.RankType_5] = "区服",
	[PetRankModel.RankType_6] = "家族"
}
local EffectPath = "20220701/paihangbang/fx_ui_jlpaihang_jiemian.prefab"

function PetRankView:_cellSize(view, index)
	return 132, 64
end

function PetRankView:ctor()
	PetRankView.super.ctor(self)

	self._filterType = PetFilterMgr.TYPE_PET_RANK
	self._cacheParams = {}
end

function PetRankView:unbindEvents()
	PetRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnCultivate)
	GameUtil.rmClickHandler(self._btnGainPet)
	GameUtil.rmClickHandler(self._btnPowerCheck)
	GameUtil.rmClickHandler(GameUtil.asBtn(self._btnFliterGo))
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(GameUtil.asBtn(self._canGet))
	GameUtil.rmClickHandler(GameUtil.asBtn(self._canGet2))
	self._btnOnekey:RemoveClickListener()
end

function PetRankView:bindEvents()
	PetRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onclickRule, self)
	GameUtil.addClickHandler(self._btnCultivate, self._onClickCultivate, self)
	GameUtil.addClickHandler(self._btnGainPet, self._onClickGainPet, self)
	GameUtil.addClickHandler(self._btnPowerCheck, self._onClickPowerCheck, self)
	GameUtil.addClickHandler(GameUtil.asBtn(self._btnFliterGo), self._onClickFliter, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(GameUtil.asBtn(self._canGet), self._onClickReward, self)
	GameUtil.addClickHandler(GameUtil.asBtn(self._canGet2), self._onClickReward, self)
	self._btnOnekey:AddClickListener(self._onClickbtnOnekey, self)
end

function PetRankView:buildUI()
	PetRankView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._btnRule = self:getBtn("btnRule")
	self._btnClose = self:getBtn("btnClose")
	self._btnFliterGo = self:getGo("container/bottom/btnFliter")
	self._btnPowerCheck = self:getBtn("container/bottom/btnPowerCheck")
	self._btnCultivate = self:getBtn("container/bottom/btnCultivate")
	self._btnCultivateGo = self:getGo("container/bottom/btnCultivate")
	self._btnGainPet = self:getBtn("container/bottom/btnGet")
	self._btnGainPetGo = self:getGo("container/bottom/btnGet")
	self._petCellGo = self:getGo("container/bottom/pet")
	self._petScrollerGo = self:getGo("container/bottom/tableview")
	self._txtTitleArenaName = self:getTxt("container/title/txt3")
	self._rankCellGo = self:getGo("container/cell")
	self._rankScrollerGo = self:getGo("container/tableview")
	self._empty = self:getGo("container/empty")
	self._txtMyRank = self:getTxt("container/myRank/txtMyRank")
	self._txtTip = self:getTxt("container/myRank/txtTip")
	self._btnTip = self:getGo("container/myRank/btnTip")
	self._rewards = self:getGo("container/myRank/reward/rewards")
	self._reward2 = self:getGo("container/myRank/reward/rewards/reward2")
	self._receive = goutil.findChild(self._rewards, "reward1/receive")
	self._canGet = goutil.findChild(self._rewards, "reward1/canGet")
	self._rewardItem = goutil.findChild(self._rewards, "reward1/item")
	self._rewardItem2 = goutil.findChild(self._reward2, "item")
	self._receive2 = goutil.findChild(self._reward2, "receive")
	self._canGet2 = goutil.findChild(self._reward2, "canGet")
	self._impressNum = self:getGo("container/myRank/txtImpressNum")
	self._txtImpressNum = self:getTxt("container/myRank/txtImpressNum/impressNum")
	self._txtPowerBtnTips = self:getTxt("container/bottom/txtPowerBtnTips")
	self._effectGo = self:getGo("effect")
	self._rankTitle = self:getGo("container/title"):GetComponent("TestRecordPos")

	goutil.setActive(self._petCellGo, false)
	goutil.setActive(self._rankCellGo, false)
	goutil.setActive(self._empty, false)

	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateExtCell, self), GameUtil.handler(self._onUpdateRight, self))
	self._tabConfs = HandbookConfig.instance:getPetRankTabConfs()

	self._commonTab:clearAllData()

	for i, data in ipairs(self._tabConfs) do
		local obj = self._commonTab:addTabData(data.name, data)
	end

	self._btnOnekey = self:getBtn("btnOnekey")
	self._redpointGo = self:getGo("btnOnekey/redpoint")
end

function PetRankView:onExit()
	PetRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookPowerCheckRank, self._updateRank, self)
	PetManualAgent.instance:removeHandler(PetManualAgent.GainRankPrizeRes, self._gainRankPrizeHandler)
	self._petScrollList:dispose()
	self._rankScrollList:dispose()
	MaterialMgr.resetAll(self._rewardItem)
	MaterialMgr.resetAll(self._rewardItem2)
	self:_clearEffect()
	self:_removeBgEffect()

	if not self._bClickClose then
		self:_cache()
	end
end

function PetRankView:onEnter()
	PetRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OneKeyPetRankPrizeInfoRes, self._onOneKeyPetRankPrizeInfoRes, self)
	self.addGEvent(self, GlobalNotify.OneKeyPetRankClearRedDot, self._onOneKeyPetRankClearRedDot, self)

	self._bClickClose = false

	local params = self:getOpenParam()

	if params then
		self._raceId = self._cacheParams[2] or checknumber(params[2])
		self._bOnlyOnePet = self._cacheParams[3] or checkbool(params[3])
	else
		self._raceId = self._cacheParams[2] or 0
		self._bOnlyOnePet = self._cacheParams[3] or false
	end

	UIStateManager.instance:popByName(ViewName.PowercheckView)
	GlobalDispatcher:addListener(GlobalNotify.HandBookPowerCheckRank, self._updateRank, self)

	self._gainRankPrizeHandler = PetManualAgent.instance:addHandler(PetManualAgent.GainRankPrizeRes, self._updateRankPrizeState, self)

	PetFilterMgr.instance:resetDataByType(self._filterType)

	self._petScrollList = ScrollerList.create(self._petScrollerGo, self._petCellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollList:regGetCellSize(function(...)
		return 100, 100
	end)

	self._rankScrollList = ScrollerList.create(self._rankScrollerGo, self._rankCellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))

	self._rankScrollList:regGetCellSize(function(...)
		return 100, 100
	end)
	self:_tryInitSelectTab()
	self._commonTab:jumpTabByData()
	self:_invalidateConf()
	self:_updateByFilterData()
	self:_tryInitSelectPet()
	self:_playBgEffect()

	self._cacheParams = {}

	ImpressionStickersController.instance:sendPM_Annuity2025ChangeRankInfoReq()
	PowerCheckController.instance:sendOneKeyPetRankPrizeInfoReq(true)
	goutil.setActive(self._redpointGo, false)
end

function PetRankView:_playBgEffect()
	self:_removeBgEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, EffectPath, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function PetRankView:_removeBgEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function PetRankView:_invalidateConf()
	local tabConf = self._tabConfs[self._tabId]
	local allPet = PetRankModel.instance:getPetRankConfsByRankType(tabConf.rankType)
	local result = {}

	if self._bOnlyOnePet then
		for _, conf in ipairs(allPet) do
			if conf.raceId == self._raceId then
				table.insert(result, conf)

				break
			end
		end
	else
		result = allPet
	end

	self._allPet = result
end

function PetRankView:_tryInitSelectTab()
	local tabIndex = 1
	local params = self:getOpenParam()

	tabIndex = params and (self._cacheParams[1] or MathUtil.clamp(checknumber(params[1]), 1, #self._tabConfs)) or self._cacheParams[1] or tabIndex
	self._tabId = tabIndex

	local tabConf = self._tabConfs[self._tabId]

	if tabConf and checknumber(tabConf.behaviour) > 0 then
		SurveyController.instance:reportBehavior(checknumber(tabConf.behaviour))
	end

	self:_updateMyRankTips()
end

function PetRankView:_tryInitSelectPet()
	self:_onClickPet()
	self._petScrollList:reloadData(self._pets)
end

function PetRankView:_updateByFilterData()
	local petFilterMgr = PetFilterMgr.instance
	local pets = {}

	for _, config in ipairs(self._allPet) do
		local raceId = config.raceId
		local petConf = CharacterConfig.instance:getPetCo(raceId)

		if petConf and raceId > 0 and petFilterMgr:checkIsMatch(self._filterType, petConf) then
			table.insert(pets, config)
		end
	end

	self._pets = pets

	self._petScrollList:reloadData(self._pets)
end

function PetRankView:_updateFilterData()
	self:_updateByFilterData()
	self:_onClickPet()
end

function PetRankView:_queryRank()
	self:_updateRankEmpty()

	if self._raceId > 0 then
		local tabConf = self._tabConfs[self._tabId]

		PetRankModel.instance:queryRank(tabConf.rankType, self._raceId, tabConf.rankShowRange or 100)
	end
end

function PetRankView:_updateCell(view, cell, data)
	local imgBg = goutil.findChildComponent(cell, "imgBg", ComponentType.UIImageSpriteChange)
	local click = goutil.findChild(cell, "click")
	local txtSel = goutil.findChildTextComponent(cell, "txtName")
	local txtChange = txtSel:GetComponent(ComponentType.UITextColorChange)
	local redPoint = goutil.findChild(cell, "dot")
	local isSelected = self._tabId == data.tab

	imgBg:SetState(isSelected and 1 or 0)

	txtSel.text = data.name

	txtChange:SetState(isSelected and 1 or 0)
	GameUtil.addClickHandler(click, GameUtil.handler(self._onClickTabCell, self, data))

	if data.bNeedRedDot then
		local redPointKey = PetRankModel.instance:getRankTabRedPointKey(data.rankType)

		RedPointController.instance:unregRedPoint(redPoint)
		RedPointController.instance:regRedPoint(redPoint, redPointKey)
	end
end

function PetRankView:_onUpdateExtCell(view, cell, tabData, tag)
	local redpoint = goutil.findChild(cell, "redpoint")
	local data = tabData.data

	GameUtil.SetActive(redpoint, false)

	if data.bNeedRedDot then
		local redPointKey = PetRankModel.instance:getRankTabRedPointKey(data.rankType)

		RedPointController.instance:unregRedPoint(redpoint)
		RedPointController.instance:regRedPoint(redpoint, redPointKey)
	end
end

function PetRankView:_onUpdateRight(tabData)
	if tabData == nil then
		return
	end

	local data = tabData.data

	self:_onClickTabCell(data)
end

function PetRankView:_clearTableview(cell)
	local redPoint = goutil.findChild(cell, "dot")

	RedPointController.instance:unregRedPoint(redPoint)
end

function PetRankView:_onClickTabCell(data)
	self._tabId = data.tab

	local tabConf = self._tabConfs[self._tabId]

	if tabConf and checknumber(tabConf.behaviour) > 0 then
		SurveyController.instance:reportBehavior(checknumber(tabConf.behaviour))
	end

	self:_invalidateConf()
	self:_updateByFilterData()
	self:_onClickPet()
	self:_updateMyRankTips()
end

function PetRankView:_updatePetCell(view, cell, data, tag)
	local redPoint = goutil.findChild(cell, "dot")
	local petContainer = goutil.findChild(cell, "petContainer")
	local raceId = data.raceId
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, petContainer)

	if proxy then
		local bHasGotPet = HandbookModel.instance:isHasPet(raceId)

		proxy.binder:setGray(not bHasGotPet)
		proxy.binder:setSelected(self._raceId == raceId)
		proxy.binder:setClickCallBack(function()
			self:_onClickPet(data)
		end)
	end

	local tabConf = self._tabConfs[self._tabId]

	if tabConf.bNeedRedDot then
		RedPointController.instance:unregRedPoint(redPoint)

		local redPointKey = PetRankModel.instance:getRankRedPointKey(tabConf.rankType, raceId)

		RedPointController.instance:regRedPoint(redPoint, redPointKey)
	end
end

function PetRankView:_clearPetCell(cell)
	local petContainer = goutil.findChild(cell, "petContainer")
	local redPoint = goutil.findChild(cell, "dot")

	MaterialMgr.resetAll(petContainer)
	RedPointController.instance:unregRedPoint(redPoint)
end

function PetRankView:_updateRankCell(view, cell, data, tag)
	local tabConf = self._tabConfs[self._tabId]
	local plan = TitlePosPlan[tabConf.rankType]
	local imgRank = goutil.findChildComponent(cell, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgIcon = goutil.findChild(cell, "head")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")

	cell:GetComponent("TestRecordPos"):LoadPlan(plan)

	txtName.text = data.headInfo.userName

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	goutil.setActive(imgRank.gameObject, isTop3)
	goutil.setActive(txtRank.gameObject, not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtRank.text = tostring(rank)
	txtArea.text = string.nilorempty(data.param) and lang("text_none") or data.param
	txtPower.text = tostring(data.zdl or 0)

	local time = GameUtil.time2date(checknumber(data.time / 1000))

	txtTime.text = langPara("PetRankView__1", time.year, time.month, time.day, time.hour, time.min, time.sec)

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgIcon)
			end
		end)
	end
end

function PetRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function PetRankView:_clearRankCell(cell)
	local imgIcon = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

function PetRankView:_updateRank()
	local tabConf = self._tabConfs[self._tabId]
	local rankData, myRank, bHasGainPrize = PetRankModel.instance:getRankData(tabConf.rankType)

	if #rankData <= 0 then
		self:_updateRankEmpty()
	else
		goutil.setActive(self._empty, false)
		self._rankScrollList:reloadData(rankData)

		myRank = checknumber(myRank)

		if myRank > 0 then
			local rankRange = checknumber(tabConf.rankRange)

			self._txtMyRank.text = (rankRange <= 0 or myRank < rankRange) and myRank or langPara("PetTop5RankView__4", rankRange)
		else
			self._txtMyRank.text = lang("world_Boss_tip9")
		end
	end

	self:_updateRankPrizeState()
	self:_updateImpressNum()
end

function PetRankView:_updateImpressNum()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
	local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize, PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID)

	goutil.setActive(self._impressNum, showPrizeConf ~= nil)

	if showPrizeConf and showPrizeConf.isImpressionSticker then
		local totalNum = HandbookConfig.instance:getFinalRange(rankConf.id, tabConf.rankType, myRank, rankSize, PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID) or 0
		local curLeftNum = Mathf.Max(0, totalNum - rankSize)

		self._txtImpressNum.text = totalNum < rankSize and totalNum .. "/" .. totalNum or rankSize .. "/" .. totalNum
	end
end

function PetRankView:_updateRankPrizeState()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
	local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize)
	local showImpressionStickerConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize, PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID)
	local isOpen = showPrizeConf ~= nil and not string.nilorempty(showPrizeConf.prize)
	local bCanGainPrize = false
	local bCanGainImpressionStickerPrize = false
	local isInPrizeRange = false

	if showPrizeConf then
		bCanGainPrize = not bHasGainPrize and myRank > 0 and self:_isInRange(myRank, showPrizeConf)
	end

	if showPrizeConf then
		isInPrizeRange = myRank > 0 and self:_isInRange(myRank, showPrizeConf)
	end

	if showImpressionStickerConf then
		bCanGainImpressionStickerPrize = not bHasGainPrize and myRank > 0 and self:_isInRange(myRank, showImpressionStickerConf)
	end

	MaterialMgr.resetAll(self._rewardItem)
	MaterialMgr.resetAll(self._rewardItem2)
	goutil.setActive(self._reward2, showImpressionStickerConf ~= nil)

	if showImpressionStickerConf then
		goutil.setActive(self._canGet2, isOpen and bCanGainImpressionStickerPrize and not bHasGainPrize)
		goutil.setActive(self._receive2, isOpen and bHasGainPrize and showImpressionStickerConf.isImpressionSticker)
	end

	goutil.setActive(self._canGet, true)
	goutil.setActive(self._receive, isOpen and bHasGainPrize and isInPrizeRange)

	if isOpen then
		local prize = string.split(showPrizeConf.prize, "#")[1]

		MaterialMgr.setCellByCfg((myRank <= 0 and showPrizeConf.hideIfNotReach or not isInPrizeRange or nil) and HandbookConfig.instance:getPetRankClientCommon("default_reward_icon"), self._rewardItem)

		if showImpressionStickerConf and showImpressionStickerConf.isImpressionSticker then
			local impressionPrize = string.split(showImpressionStickerConf.prize, "#")[1]
			local matType, matId, matNum = MaterialMgr.getMatParams(impressionPrize)

			MaterialMgr.setCell(matType, matId, self._rewardItem2)

			if bCanGainImpressionStickerPrize then
				self:_playImpressionStickerEffect()
			else
				self:_clearImpressionStickerEffect()
			end
		end

		if bCanGainPrize then
			self:_playEffect()
		else
			self:_clearEffect()
		end
	else
		self:_clearEffect()
	end
end

function PetRankView:_updateRankEmpty()
	goutil.setActive(self._empty, true)
	self._rankScrollList:reloadData({})

	self._txtMyRank.text = lang("world_Boss_tip9")
end

function PetRankView:_updateMyRankTips()
	local tabConf = self._tabConfs[self._tabId]
	local tip = ""
	local statTime

	if self._raceId then
		local conf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)

		if conf then
			tip = self:_getTip()
			statTime = conf.submitStartTime
		end
	end

	self._txtTip.text = tip

	goutil.setActive(self._btnTip, not string.nilorempty(tabConf.popTip))

	local plan = TitlePosPlan[tabConf.rankType]
	local arenaName = TitleArenaName[tabConf.rankType]

	self._rankTitle:LoadPlan(plan)

	self._txtTitleArenaName.text = arenaName or ""

	local bGainRank = tabConf.rankType == PetRankModel.RankType_5 or tabConf.rankType == PetRankModel.RankType_6

	goutil.setActive(self._btnGainPetGo, bGainRank)
	goutil.setActive(self._btnCultivateGo, not bGainRank)

	if not string.nilorempty(statTime) then
		local startTimestamp = GameUtil.string2time(statTime)

		if startTimestamp > ServerTime.now() then
			local startDate = GameUtil.time2date(startTimestamp)

			self._txtPowerBtnTips.text = string.format("%d.%d %d:%2d开放", startDate.month, startDate.day, startDate.hour, startDate.min)

			GameUtil.SetActive(self._txtPowerBtnTips.gameObject, true)
		else
			GameUtil.SetActive(self._txtPowerBtnTips.gameObject, false)
		end
	else
		GameUtil.SetActive(self._txtPowerBtnTips.gameObject, false)
	end
end

function PetRankView:_playEffect()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
	local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize)
	local showImpressionStickerConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize, PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID)
	local isOpen = showPrizeConf ~= nil and not string.nilorempty(showPrizeConf.prize)

	self:_clearEffect()

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._canGet.transform, 0, 0, true, nil, nil, function(view, uiEff)
		uiEff:setClipping(self._canGet.transform)
	end)

	uiEffect:setParent(self._canGet.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._rewardEffect = uiEffect
end

function PetRankView:_clearEffect()
	if self._rewardEffect then
		UIEffectManager.instance:stopEffect(self._rewardEffect)

		self._rewardEffect = nil
	end
end

function PetRankView:_playImpressionStickerEffect()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
	local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize)
	local showImpressionStickerConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize, PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID)

	self:_clearEffect()

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	if showImpressionStickerConf and showImpressionStickerConf.isImpressionSticker then
		local uiEffect2 = UIEffectManager.instance:playEffect(self, effPath, self._canGet2.transform, 0, 0, true, nil, nil, function(view, uiEff)
			uiEff:setClipping(self._canGet2.transform)
		end)

		uiEffect2:setParent(self._canGet2.transform)
		uiEffect2:setLocalPos(0, 0, 0)
		uiEffect2:setScale(1)

		self._rewardEffect2 = uiEffect2
	end
end

function PetRankView:_clearImpressionStickerEffect()
	if self._rewardEffect2 then
		UIEffectManager.instance:stopEffect(self._rewardEffect2)

		self._rewardEffect2 = nil
	end
end

function PetRankView:_onClickPet(data)
	local tabConf = self._tabConfs[self._tabId]

	if not data then
		if self._raceId > 0 then
			local index = 0

			for i, config in ipairs(self._pets) do
				if self._raceId == config.raceId then
					index = i - 1

					break
				end
			end

			if self._pets[index + 1] then
				data = self._pets[index + 1]
			end

			self._petScrollList:MoveCellInView(index, false)
		else
			data = self._pets[1]

			self._petScrollList:MoveCellInView(0, false)
		end
	end

	self._raceId = data and data.raceId or 0

	self._petScrollList:reloadData(self._pets)

	if self._raceId then
		PetRankModel.instance:saveRaceIdOnceRed(tabConf.rankType, self._raceId)
	end

	self:_updateMyRankTips()
	self:_queryRank()
end

function PetRankView:_onclickRule()
	UIStateManager.instance:open(ViewName.RulesView, "petrank_rule")
end

function PetRankView:_onClickCultivate()
	if self._raceId then
		local conf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)

		if conf then
			local strengths = conf.strength

			if TableUtil.isTableEmpty(strengths) then
				local strengthsT = HandbookConfig.instance:getPetRankClientCommon("default_strengthen_func")

				strengths = string.splitToNumber(strengthsT, "#")
			end

			if not TableUtil.isTableEmpty(strengths) then
				UIStateManager.instance:open(ViewName.PetRankPopView, strengths)
			end
		end
	end
end

function PetRankView:_onClickGainPet()
	if self._raceId > 0 then
		MaterialMgr.openGetSource(MatType.PetPiece, self._raceId)
	end
end

function PetRankView:_onClickPowerCheck()
	local statTime

	if self._raceId then
		local conf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)

		if conf then
			statTime = conf.submitStartTime
		end
	end

	if not string.nilorempty(statTime) then
		local startTimestamp = GameUtil.string2time(statTime)

		if startTimestamp > ServerTime.now() then
			local startDate = GameUtil.time2date(startTimestamp)

			FloatWordMgr.instance:show(string.format("%d.%d %d点开放", startDate.month, startDate.day, startDate.hour))

			return
		end
	end

	local bagPetId = BagModel.instance:getMaxZdlPetIdByRaceId(self._raceId)

	if bagPetId and bagPetId > 0 then
		UIStateManager.instance:push(ViewName.PowercheckView, bagPetId)
	else
		FloatWordMgr.instance:show(langPara("PetTop5RankView__5"))
	end
end

function PetRankView:_onClickFliter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFliterGo)

	PetFilterMgr.instance:openFilterViewByType(self, self._filterType, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function PetRankView:_onClickbtnOnekey()
	PowerCheckController.instance:sendOneKeyPetRankPrizeInfoReq()
end

function PetRankView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PetRankView:_onClickTip()
	local tabConf = self._tabConfs[self._tabId]

	if not string.nilorempty(tabConf.popTip) then
		TipsFacade.instance:openTipWindow(lang("tip"), tabConf.popTip, function()
			return
		end, lang("confirm"))
	end
end

function PetRankView:_onClickReward()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
	local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize)
	local showImpressionStickerConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize, PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID)
	local bCanGainImpressionStickerPrize = false
	local isOpen = showPrizeConf ~= nil and not string.nilorempty(showPrizeConf.prize)

	if not isOpen then
		return
	end

	if showImpressionStickerConf then
		bCanGainImpressionStickerPrize = not bHasGainPrize and myRank > 0 and self:_isInRange(myRank, showImpressionStickerConf)
	end

	if myRank <= 0 or not ((showPrizeConf or nil) and myRank > 0 and self:_isInRange(myRank, showPrizeConf)) and not bCanGainImpressionStickerPrize then
		if self._raceId then
			UIStateManager.instance:push(ViewName.PetRankPrizeView, self._raceId, tabConf.rankType)
		end
	elseif not bHasGainPrize then
		PetRankModel.instance:gainReward(tabConf.rankType, self._raceId)
	else
		local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
		local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize)

		if showPrizeConf and not string.nilorempty(showPrizeConf.prize) then
			CommonTipsMgr.instance:openTipsByConfStr(self._canGet, string.split(showPrizeConf.prize, "#")[1])
		end
	end
end

function PetRankView:_onClickClose()
	self._bClickClose = true

	self:close()
end

function PetRankView:_isInRange(myRank, showPrizeConf)
	return myRank >= showPrizeConf.rankRange[1] and myRank <= showPrizeConf.rankRange[2]
end

function PetRankView:_getTip()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
	local showImpressionStickerConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize, PetRankModel.RANK_PRIZE_IMPRESSION_STICKER_ID)
	local tip = ""

	if self._raceId then
		local conf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)

		if conf then
			tip = string.format(tabConf.tip, tostring(checknumber(conf.submitZdl)))
		end
	end

	return tip
end

function PetRankView:_cache()
	self._cacheParams = {
		self._tabId,
		self._raceId,
		self._bOnlyOnePet
	}
end

function PetRankView:_onOneKeyPetRankPrizeInfoRes(items)
	goutil.setActive(self._redpointGo, items and #items > 0)
end

function PetRankView:_onOneKeyPetRankClearRedDot()
	goutil.setActive(self._redpointGo, false)
end

return PetRankView
