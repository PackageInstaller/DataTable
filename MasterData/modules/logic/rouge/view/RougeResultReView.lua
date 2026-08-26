-- chunkname: @modules/logic/rouge/view/RougeResultReView.lua

module("modules.logic.rouge.view.RougeResultReView", package.seeall)

local RougeResultReView = class("RougeResultReView", BaseView)

function RougeResultReView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_fail/#simage_mask")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._simagerightmask = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_rightmask")
	self._simageleftmask = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_leftmask")
	self._godlctitles = gohelper.findChild(self.viewGO, "Left/title/#go_dlctitles")
	self._godifficulty = gohelper.findChild(self.viewGO, "Left/#go_difficulty")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "Left/#go_difficulty/#txt_difficulty")
	self._txtend = gohelper.findChildText(self.viewGO, "Left/#txt_end")
	self._gofaction = gohelper.findChild(self.viewGO, "Left/#go_faction")
	self._imageTypeIcon = gohelper.findChildImage(self.viewGO, "Left/#go_faction/#image_TypeIcon")
	self._txtTypeName = gohelper.findChildText(self.viewGO, "Left/#go_faction/image_NameBG/#txt_TypeName")
	self._txtLv = gohelper.findChildText(self.viewGO, "Left/#go_faction/#txt_Lv")
	self._gocollection = gohelper.findChild(self.viewGO, "Left/#go_collection")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "Left/#go_collection/#txt_collectionnum")
	self._gocoin = gohelper.findChild(self.viewGO, "Left/#go_coin")
	self._txtcoinnum = gohelper.findChildText(self.viewGO, "Left/#go_coin/#txt_coinnum")
	self._scrollherogroup = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_herogroup")
	self._goline1 = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_line1")
	self._goline2 = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_line2")
	self._goplayinfo = gohelper.findChild(self.viewGO, "Right/#go_playinfo")
	self._txtplayername = gohelper.findChildText(self.viewGO, "Right/#go_playinfo/#txt_playername")
	self._txtplayerlv = gohelper.findChildText(self.viewGO, "Right/#go_playinfo/#txt_playerlv")
	self._txttime = gohelper.findChildText(self.viewGO, "Right/#go_playinfo/#txt_time")
	self._simageplayericon = gohelper.findChildSingleImage(self.viewGO, "Right/#go_playinfo/#simage_playericon")
	self._gochessboard = gohelper.findChild(self.viewGO, "Right/#go_chessboard")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "Right/#go_chessboard/#go_meshContainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "Right/#go_chessboard/#go_meshContainer/#go_meshItem")
	self._gochessitem = gohelper.findChild(self.viewGO, "Right/#go_chessboard/#go_dragContainer/#go_chessitem")
	self._gocellModel = gohelper.findChild(self.viewGO, "Right/#go_chessboard/#go_cellModel")
	self._godragarea = gohelper.findChild(self.viewGO, "Right/#go_chessboard/#go_dragarea")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gohide = gohelper.findChild(self.viewGO, "#go_hide")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "#go_hide/#btn_hide")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeResultReView:addEvents()
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RougeResultReView:removeEvents()
	self._btnhide:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RougeResultReView:_btnhideOnClick()
	return
end

function RougeResultReView:_btncloseOnClick()
	self:closeThis()
end

function RougeResultReView:_editableInitView()
	self._heroLineTab = self:getUserDataTb_()
	self._gonormaltitle = gohelper.findChild(self.viewGO, "Left/title/normal")
end

function RougeResultReView:onUpdateParam()
	return
end

function RougeResultReView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.PurdahPull)

	if self.viewParam then
		self:refreshUI(self.viewParam)
		gohelper.setActive(self._gotopleft, self.viewParam and self.viewParam.showNavigate)
	end
end

function RougeResultReView:onOpenFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.NextShowSettlementTxt)
end

function RougeResultReView:refreshUI(reviewInfo)
	if not reviewInfo then
		return
	end

	local isSucc = reviewInfo:isSucceed()

	gohelper.setActive(self._gosuccess, isSucc)
	gohelper.setActive(self._gofail, not isSucc)

	self._txtend.text = RougeResultReView.refreshEndingDesc(reviewInfo)

	self:refreshBaseInfo(reviewInfo)
	self:refreshTitle(reviewInfo)
	self:refreshStyleInfo(reviewInfo)
	self:refreshInitHeroUI(reviewInfo)
	self:refreshPlayerInfo(reviewInfo)
	self:refreshCollectionSlotArea(reviewInfo)
end

function RougeResultReView.refreshEndingDesc(reviewInfo)
	local isSucc = reviewInfo:isSucceed()
	local desc = ""

	if isSucc then
		local endingId = reviewInfo.endId
		local endingCfg = RougeConfig.instance:getEndingCO(endingId)

		desc = endingCfg and endingCfg.desc
	else
		local layerId = reviewInfo.layerId
		local middleLayerId = reviewInfo.middleLayerId
		local isInMiddleLayer = reviewInfo:isInMiddleLayer()
		local finalStepLayerName = ""

		if isInMiddleLayer then
			local middleLayerCfg = lua_rouge_middle_layer.configDict[middleLayerId]

			finalStepLayerName = middleLayerCfg and middleLayerCfg.name
		else
			local layerCfg = lua_rouge_layer.configDict[layerId]

			finalStepLayerName = layerCfg and layerCfg.name
		end

		desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_rougeresultreportview_txt_dec5"), finalStepLayerName)
	end

	return desc
end

function RougeResultReView:refreshBaseInfo(reviewInfo)
	self._txtcollectionnum.text = reviewInfo.collectionNum
	self._txtcoinnum.text = reviewInfo.gainCoin

	local season = reviewInfo.season
	local difficulty = reviewInfo.difficulty
	local difficultyCfg = lua_rouge_difficulty.configDict[season][difficulty]

	self._txtdifficulty.text = difficultyCfg and difficultyCfg.title
	self._txtLv.text = string.format("Lv.%s", reviewInfo.teamLevel)
end

function RougeResultReView:refreshTitle(reviewInfo)
	local versions = reviewInfo and reviewInfo:getVersions()
	local newVersionStr = RougeDLCHelper.versionListToString(versions)
	local dlcTitleCount = self._godlctitles.transform.childCount

	for i = 1, dlcTitleCount do
		local goDLCTitle = self._godlctitles.transform:GetChild(i - 1).gameObject
		local goDLCName = goDLCTitle.name

		gohelper.setActive(goDLCTitle, goDLCName == newVersionStr)
	end

	local hasAddDLC = versions and #versions > 0

	gohelper.setActive(self._gonormaltitle, not hasAddDLC)
end

function RougeResultReView:refreshStyleInfo(reviewInfo)
	local season = reviewInfo.season
	local style = reviewInfo.style
	local styleCfg = lua_rouge_style.configDict[season][style]

	self._txtTypeName.text = styleCfg and styleCfg.name

	local styleIconName = styleCfg and styleCfg.icon
	local resultIconName = string.format("%s_light", styleIconName)

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageTypeIcon, resultIconName)
end

function RougeResultReView:refreshInitHeroUI(reviewInfo)
	local teamInfo = reviewInfo:getTeamInfo()
	local heroIds, maxOtherHeroIndex = self:buildHeroPlaceMap(teamInfo)
	local startIndex, endIndex = 0, 0
	local lineIndex = 1

	while lineIndex <= 4 or endIndex <= maxOtherHeroIndex do
		local lineItem = self:getOrCreateHeroIconLine(lineIndex)
		local lineHeroCount = self:getLineHeroCount(lineIndex)

		startIndex = startIndex + 1
		endIndex = startIndex + lineHeroCount - 1

		self:refreshLineItem(lineItem, lineIndex, heroIds, startIndex, startIndex + lineHeroCount - 1)

		startIndex = endIndex
		lineIndex = lineIndex + 1
	end
end

function RougeResultReView:buildHeroPlaceMap(teamInfo)
	local allHeroIds = {}
	local battleHeroIds, supportHeroIds, otherHeroIds = self:splitAllHeros(teamInfo)
	local battleHeroPlaceIndex = RougeResultReView.SingleHeroCountPerLine

	for i = 1, RougeEnum.FightTeamNormalHeroNum do
		local index = i + battleHeroPlaceIndex

		allHeroIds[index] = battleHeroIds[i] or 0
	end

	local supportHeroPlaceIndex = RougeResultReView.SingleHeroCountPerLine + RougeResultReView.DoubleHeroCountPerLine + 1
	local maxSupportHeroCount = RougeEnum.FightTeamHeroNum - RougeEnum.FightTeamNormalHeroNum

	for i = 1, maxSupportHeroCount do
		local index = i + supportHeroPlaceIndex

		allHeroIds[index] = supportHeroIds[i] or 0
	end

	local otherHeroCount = #otherHeroIds
	local maxOtherHeroIndex = 0

	for i = 1, otherHeroCount do
		local index = i

		index = i <= RougeResultReView.SingleHeroCountPerLine and i or i == RougeResultReView.SingleHeroCountPerLine + 1 and RougeResultReView.SingleHeroCountPerLine + RougeResultReView.DoubleHeroCountPerLine + 1 or RougeResultReView.DoubleHeroCountPerLine * 2 + i
		allHeroIds[index] = otherHeroIds[i]

		if maxOtherHeroIndex < index then
			maxOtherHeroIndex = index
		end
	end

	return allHeroIds, maxOtherHeroIndex
end

function RougeResultReView:splitAllHeros(teamInfo)
	local heroList = teamInfo and teamInfo:getAllHeroId()
	local supportHeroIds = {}
	local battleHeroIds = {}
	local otherHeroIds = {}
	local countHeroMap = {}

	self._needFrameHeroIdMap = {}

	local battleHeroList = teamInfo and teamInfo:getBattleHeroList()

	if battleHeroList then
		for _, heroMO in ipairs(battleHeroList) do
			local battleId = heroMO.heroId
			local supportId = heroMO.supportHeroId

			table.insert(battleHeroIds, battleId)
			table.insert(supportHeroIds, supportId)

			countHeroMap[battleId] = true
			countHeroMap[supportId] = true
			self._needFrameHeroIdMap[battleId] = true
			self._needFrameHeroIdMap[supportId] = true
		end
	end

	if heroList then
		for _, heroId in ipairs(heroList) do
			if not countHeroMap[heroId] then
				table.insert(otherHeroIds, heroId)
			end
		end
	end

	return battleHeroIds, supportHeroIds, otherHeroIds
end

function RougeResultReView:getOrCreateHeroIconLine(lineIndex)
	local lineItem = self._heroLineTab[lineIndex]

	if not lineItem then
		if lineIndex % 2 == 1 then
			if not self._goline1 then
				local prefab = self._goline2

				lineItem = self:getUserDataTb_()
				lineItem.parent = gohelper.cloneInPlace(prefab, "line_" .. lineIndex)
				lineItem.heroItems = self:getUserDataTb_()

				local item = gohelper.findChild(lineItem.parent, "go_item")
				local iconRes = self.viewContainer._viewSetting.otherRes[1]
				local lineHeroCount = self:getLineHeroCount(lineIndex)

				for i = 1, lineHeroCount do
					local item = gohelper.cloneInPlace(item, "heroitem_" .. i)

					self:getResInst(iconRes, item, "icon")

					lineItem.heroItems[i] = item

					if i ~= 1 and lineIndex ~= 2 and lineIndex ~= 3 then
						local isPlaceLeft = i % 2 == 0

						if isPlaceLeft then
							item.transform:SetAsFirstSibling()
						end
					end
				end

				self._heroLineTab[lineIndex] = lineItem
			end
		end
	end

	return lineItem
end

RougeResultReView.DoubleHeroCountPerLine = 4
RougeResultReView.SingleHeroCountPerLine = 5

function RougeResultReView:getLineHeroCount(lineIndex)
	if lineIndex % 2 == 1 then
		if not RougeResultReView.SingleHeroCountPerLine then
			return RougeResultReView.DoubleHeroCountPerLine
		end
	end
end

function RougeResultReView:refreshLineItem(lineItem, lineIndex, heroIds, startIndex, endIndex)
	if not lineItem then
		return
	end

	for index = startIndex, endIndex do
		local heroItem = lineItem.heroItems[index - startIndex + 1]
		local heroId = heroIds and heroIds[index]

		self:refreshHeroUI(heroItem, heroId)
	end

	gohelper.setActive(lineItem.parent, true)
end

function RougeResultReView:refreshHeroUI(heroItem, heroId)
	if not heroItem then
		return
	end

	local hasHero = heroId and heroId > 0
	local goempty = gohelper.findChild(heroItem, "icon/#go_heroitem/empty")
	local goFrame = gohelper.findChild(heroItem, "icon/#go_heroitem/frame")
	local iconImage = gohelper.findChildSingleImage(heroItem, "icon/#go_heroitem/#image_rolehead")

	gohelper.setActive(heroItem, true)
	gohelper.setActive(goempty, not hasHero)
	gohelper.setActive(goFrame, false)
	gohelper.setActive(iconImage.gameObject, hasHero)

	if hasHero then
		local heroCfg = HeroConfig.instance:getHeroCO(heroId)
		local skinCfg
		local heroMO = HeroModel.instance:getByHeroId(heroId)

		if heroMO then
			skinCfg = HeroModel.instance:getCurrentSkinConfig(heroId)
		else
			local skinId = heroCfg and heroCfg.skinId

			skinCfg = SkinConfig.instance:getSkinCo(skinId)
		end

		local heroIcon = skinCfg and skinCfg.headIcon

		iconImage:LoadImage(ResUrl.getHeadIconSmall(heroIcon))

		local isNeedFrame = self._needFrameHeroIdMap[heroId]

		gohelper.setActive(goFrame, isNeedFrame)
	end
end

function RougeResultReView:refreshPlayerInfo(reviewInfo)
	self._txtplayername.text = reviewInfo.playerName

	local playerLevel = reviewInfo.playerLevel

	self._txtplayerlv.text = string.format("Lv.%s", playerLevel)

	local finishTime = reviewInfo.finishTime / 1000

	self._txttime.text = TimeUtil.localTime2ServerTimeString(finishTime, "%Y.%m.%d %H:%M")
	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageplayericon)

	self._liveHeadIcon:setLiveHead(reviewInfo.portrait)
end

function RougeResultReView:refreshCollectionSlotArea(reviewInfo)
	local style = reviewInfo.style
	local season = reviewInfo.season
	local collections = reviewInfo:getSlotCollections()

	self._slotComp = self._slotComp or RougeCollectionSlotComp.Get(self._gochessboard, RougeCollectionHelper.ResultReViewCollectionSlotParam)

	local bagSize = RougeCollectionConfig.instance:getStyleCollectionBagSize(season, style)

	self._slotComp:onUpdateMO(bagSize.col, bagSize.row, collections)
end

function RougeResultReView:onClose()
	return
end

function RougeResultReView:onDestroyView()
	if self._slotComp then
		self._slotComp:destroy()
	end
end

return RougeResultReView
