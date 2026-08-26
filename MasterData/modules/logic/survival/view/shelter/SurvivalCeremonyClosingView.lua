-- chunkname: @modules/logic/survival/view/shelter/SurvivalCeremonyClosingView.lua

module("modules.logic.survival.view.shelter.SurvivalCeremonyClosingView", package.seeall)

local SurvivalCeremonyClosingView = class("SurvivalCeremonyClosingView", BaseView)

function SurvivalCeremonyClosingView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG")
	self._simagePanelBG1 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG1")
	self._simagePanelBG2 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG2")
	self._scrollcontentlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_contentlist")
	self._goEnding = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Ending")
	self._simageending = gohelper.findChildSingleImage(self.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#simage_ending")
	self._txtending = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#txt_ending")
	self._goendingScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#go_endingScore")
	self._txtendingScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#go_endingScore/#txt_endingScore")
	self._goNpc = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc")
	self._gonpcitem = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcitem")
	self._imagenpc = gohelper.findChildImage(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcitem/#image_npc")
	self._gonpcline1 = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcline1")
	self._gonpcline2 = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcline2")
	self._gonpcScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/#go_npcScore")
	self._txtnpcScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/#go_npcScore/#txt_npcScore")
	self._goBoss = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Boss")
	self._gobossitem = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossitem")
	self._imageboss = gohelper.findChildImage(self.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossitem/#image_boss")
	self._gobossline1 = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossline1")
	self._gobossline2 = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossline2")
	self._gobossScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/#go_bossScore")
	self._txtbossScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/#go_bossScore/#txt_bossScore")
	self._gosurvivalTime = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime")
	self._txtsurvivalTime = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime/#txt_survivalTime")
	self._goscore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime/#go_score")
	self._txtscore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime/#go_score/#txt_score")
	self._goextraTarget = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget")
	self._txtextraTarget = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget/#txt_extraTarget")
	self._goextraScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget/#go_extraScore")
	self._txtextraScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget/#go_extraScore/#txt_extraScore")
	self._goCollection = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Collection")
	self._txtCollection = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/#txt_Collection")
	self._gocollectionScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/#go_collectionScore")
	self._txtcollectionScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/#go_collectionScore/#txt_collectionScore")
	self._goItem = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Item")
	self._txtItem = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Item/#txt_Item")
	self._goItemScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Item/#go_ItemScore")
	self._txtItemScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Item/#go_ItemScore/#txt_ItemScore")
	self._goTotalScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore")
	self._txtTotalScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore/#txt_TotalScore")
	self._txtTotalCoin = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore/go_currency/#txt_TotalScore")
	self._gocurrency = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore/go_currency")
	self._gocurrencyLimit = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore/go_currency/layout/txt_desc")
	self._gocurrencymax = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore/go_currency_max")
	self._gorewardTips = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_rewardTips")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalCeremonyClosingView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SurvivalCeremonyClosingView:removeEvents()
	self._btnclose:RemoveClickListener()
end

local addHeight = 50
local showTime = {
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5
}
local scoreEnum = {
	boss = 3,
	extraTarget = 5,
	item = 7,
	npc = 2,
	survival = 4,
	collection = 1,
	winScore = 6
}
local ZProj_TweenHelper = ZProj.TweenHelper

function SurvivalCeremonyClosingView:_btncloseOnClick()
	self:closeThis()
end

function SurvivalCeremonyClosingView:_editableInitView()
	self._nextClick = gohelper.findChildClickWithAudio(self.viewGO, "go_click")

	self._nextClick:AddClickListener(self.enterNext, self)

	self._canvasGroupEnding = self._goEnding:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupNpc = self._goNpc:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupBoss = self._goBoss:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupSurvivalTime = self._gosurvivalTime:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupExtraTarget = self._goextraTarget:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupCollection = self._goCollection:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupItem = self._goItem:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupTotalScore = self._goTotalScore:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupTalentGain = self._gorewardTips:GetComponent(gohelper.Type_CanvasGroup)
	self._animationEnding = self._goEnding:GetComponent(gohelper.Type_Animation)
	self._animationNpc = self._goNpc:GetComponent(gohelper.Type_Animation)
	self._animationBoss = self._goBoss:GetComponent(gohelper.Type_Animation)
	self._animationSurvivalTime = self._gosurvivalTime:GetComponent(gohelper.Type_Animation)
	self._animationExtraTarget = self._goextraTarget:GetComponent(gohelper.Type_Animation)
	self._animationCollection = self._goCollection:GetComponent(gohelper.Type_Animation)
	self._animationExtraItem = self._goItem:GetComponent(gohelper.Type_Animation)
	self._animationTotalScore = self._goTotalScore:GetComponent(gohelper.Type_Animation)
	self._animationGoCurrency = self._gocurrency:GetComponent(gohelper.Type_Animation)
	self._animationGoCurrencyMax = self._gocurrencymax:GetComponent(gohelper.Type_Animation)
	self._animationTalentGain = self._gorewardTips:GetComponent(gohelper.Type_Animation)

	local content = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content")

	self._contentRect = content.transform:GetComponent(gohelper.Type_RectTransform)

	local scrollContentTr = self._scrollcontentlist.transform:GetComponent(gohelper.Type_RectTransform)

	self._scrollHeight = recthelper.getHeight(scrollContentTr)
	self._goCollectionLayout = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/layout")
	self._goItemLayout = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Item/layout")
	self._txtTips = gohelper.findChildText(self.viewGO, "txt_tips")

	gohelper.setActive(self._btnclose.gameObject, false)
	gohelper.setActive(self._txtTips.gameObject, false)
	gohelper.setActive(self._gonpcitem, false)

	self._txtTalentGainTip = gohelper.findChildTextMesh(self._gorewardTips, "txt_title")
	self._image_role = gohelper.findChildImage(self._gorewardTips, "image_role")
end

function SurvivalCeremonyClosingView:onUpdateParam()
	return
end

function SurvivalCeremonyClosingView:onOpen()
	self._isWin = self.viewParam.isWin or false
	self.commonTechPoint = self.viewParam.commonTechPoint
	self.roleTechPoint = self.viewParam.roleTechPoint

	local report = self.viewParam.report

	if not string.nilorempty(report) then
		self._report = cjson.decode(report)
	end

	self._totalScore = self._report.totalCount
	self._coinNum = self.viewParam.score

	SurvivalShelterChooseNpcListModel.instance:clearSelectList()
	SurvivalShelterChooseEquipListModel.instance:clearSelectList()

	local extraData = self._report.extraData

	if not string.nilorempty(extraData) then
		local data = string.split(extraData, "|")
		local npcIdsStr = data[1]
		local equipIdsStr = data[2]

		if not string.nilorempty(npcIdsStr) then
			local npcIds = string.splitToNumber(npcIdsStr, "#")

			SurvivalShelterChooseNpcListModel.instance:setNeedSelectNpcList(npcIds)
		end

		if not string.nilorempty(equipIdsStr) then
			local equipIds = string.splitToNumber(equipIdsStr, "#")

			SurvivalShelterChooseEquipListModel.instance:setNeedSelectEquipList(equipIds)
		end
	end

	self:_initView()
end

function SurvivalCeremonyClosingView:_initView()
	self._allShowGO = self:getUserDataTb_()
	self._allShowAnimation = self:getUserDataTb_()
	self._showTime = {}
	self._extraAnims = {}
	self._maxStep = 0

	self:_initEnding()
	self:_initNpc()
	self:_initBoss()
	self:_initSurvivalTime()
	self:_initExtraTarget()
	self:_initCollection()
	self:_initItem()
	self:_initTotalScore()

	self._progress = 1

	self:_refreshCurProgress()
	self:_initTalentGain()
end

function SurvivalCeremonyClosingView:_initEnding()
	local score = self:getScoreByType(scoreEnum.winScore)

	self._txtendingScore.text = score

	gohelper.setActive(self._goendingScore, score > 0)

	local endId = self._report.endId
	local endConfig = lua_survival_end.configDict[endId]
	local path = endConfig.endImg

	self._simageending:LoadImage(path)

	self._txtending.text = endConfig.endDesc

	self:addShowStep(self._animationEnding, showTime[1], self._canvasGroupEnding)
end

local lineMax = 9
local count = 0

function SurvivalCeremonyClosingView:_initNpc()
	local score = self:getScoreByType(scoreEnum.npc)

	count = 0

	gohelper.setActive(self._goNpc, score > 0)

	if score <= 0 then
		return
	end

	self._txtnpcScore.text = score

	if self._npcItems == nil then
		self._npcItems = self:getUserDataTb_()
	end

	local npcIdList = self._report.gainNpcSet
	local npcListCount = #npcIdList

	for i = 1, npcListCount do
		local npcId = npcIdList[i]
		local config = SurvivalConfig.instance:getNpcConfig(npcId)
		local item = self._npcItems[i]

		if item == nil then
			local parent = self:getNpcLine()

			item = gohelper.clone(self._gonpcitem, parent, npcId)

			gohelper.setActive(item, true)
			table.insert(self._npcItems, item)

			if not parent.activeSelf then
				gohelper.setActive(parent, true)
			end
		end

		local sImage = gohelper.findChildSingleImage(item, "#image_npc")

		if config and not string.nilorempty(config.smallIcon) then
			local path = ResUrl.getSurvivalNpcIcon(config.smallIcon)

			sImage:LoadImage(path)
		end
	end

	self:addShowStep(self._animationNpc, showTime[2], self._canvasGroupNpc)
end

function SurvivalCeremonyClosingView:getNpcLine()
	count = count + 1

	local index = math.ceil(count / lineMax)

	if self._npcLines == nil then
		self._npcLines = self:getUserDataTb_()
	end

	if self._npcLines[index] ~= nil then
		return self._npcLines[index]
	end

	local go = gohelper.cloneInPlace((index % 2 == 0 or nil) and self._gonpcline2, index)

	self._npcLines[index] = go

	return go
end

function SurvivalCeremonyClosingView:_initBoss()
	local score = self:getScoreByType(scoreEnum.boss)

	gohelper.setActive(self._goBoss, score > 0)

	if score <= 0 then
		return
	end

	self._txtbossScore.text = score

	if self._bossItems == nil then
		self._bossItems = self:getUserDataTb_()
	end

	local fightIds = self._report.fightIds
	local lineMax = 9
	local npcListCount = #fightIds

	for i = 1, npcListCount do
		local fightId = tonumber(fightIds[i])
		local config = lua_survival_shelter_intrude_fight.configDict[fightId]
		local item = self._bossItems[i]

		if item == nil then
			item = gohelper.clone(self._gobossitem, (lineMax < i or nil) and self._gobossline2, fightId)

			gohelper.setActive(item, true)
			table.insert(self._bossItems, item)
		end

		local sImage = gohelper.findChildSingleImage(item, "#image_boss")

		if not string.nilorempty(config.smallheadicon) then
			local path = ResUrl.monsterHeadIcon(config.smallheadicon)

			sImage:LoadImage(path)
		end
	end

	gohelper.setActive(self._gobossline2, lineMax < npcListCount)
	self:addShowStep(self._animationBoss, showTime[3], self._canvasGroupBoss)
end

function SurvivalCeremonyClosingView:_initSurvivalTime()
	local score = self:getScoreByType(scoreEnum.survival)

	gohelper.setActive(self._gosurvivalTime, score > 0)

	if score <= 0 then
		return
	end

	self._txtscore.text = score

	local day = self._report.day

	self._txtsurvivalTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_survivalTime"), day)

	self:addShowStep(self._animationSurvivalTime, showTime[4], self._canvasGroupSurvivalTime)
end

function SurvivalCeremonyClosingView:_initExtraTarget()
	local score = self:getScoreByType(scoreEnum.extraTarget)

	gohelper.setActive(self._goextraTarget, score > 0)

	if score <= 0 then
		return
	end

	self._txtextraScore.text = score

	local normalTaskCount = self._report.normalTaskCount

	self._txtextraTarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_extraTarget"), normalTaskCount)

	self:addShowStep(self._animationExtraTarget, showTime[5], self._canvasGroupExtraTarget)
end

function SurvivalCeremonyClosingView:_initCollection()
	local collectionScore = self:getScoreByType(scoreEnum.collection)

	gohelper.setActive(self._goCollection, collectionScore > 0)

	if collectionScore <= 0 then
		return
	end

	self._txtcollectionScore.text = collectionScore

	if self._collectionItems == nil then
		self._collectionItems = self:getUserDataTb_()
	end

	local itemId2Count = self._report.itemId2Count
	local allItemIds = {}

	for itemId, _ in pairs(itemId2Count) do
		table.insert(allItemIds, itemId)
	end

	table.sort(allItemIds, function(a, b)
		local countA = itemId2Count[a]
		local countB = itemId2Count[b]

		return countB < countA
	end)
	gohelper.setActive(self._item, false)

	for i = 1, #allItemIds do
		local count = itemId2Count[allItemIds[i]]
		local id = tonumber(allItemIds[i])
		local mo = SurvivalBagItemMo.New()

		mo:init({
			id = id,
			count = count
		})

		if mo.equipCo ~= nil then
			local itemRes = self.viewContainer:getSetting().otherRes.itemRes
			local item = self:getResInst(itemRes, self._goCollectionLayout)
			local equipItem = MonoHelper.addNoUpdateLuaComOnceToGo(item, SurvivalBagItem)

			equipItem:updateMo(mo)
			equipItem:setShowNum(true)
			equipItem:setItemSize(150, 150)
			gohelper.setActive(item, true)
			table.insert(self._collectionItems, equipItem)
		end
	end

	local equipNum = self._report.equipCount

	if equipNum > 0 then
		self._txtCollection.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_collection"), equipNum)
	end

	gohelper.setActive(self._txtCollection.gameObject, equipNum > 0)
	self:addShowStep(self._animationCollection, showTime[6], self._canvasGroupCollection)
end

function SurvivalCeremonyClosingView:_initItem()
	local itemScore = self:getScoreByType(scoreEnum.item)

	gohelper.setActive(self._goItem, itemScore > 0)

	if itemScore <= 0 then
		return
	end

	if self._collectionItems == nil then
		self._collectionItems = self:getUserDataTb_()
	end

	self._txtItemScore.text = itemScore

	local itemId2Count = self._report.itemId2Count
	local allItemIds = {}

	for itemId, _ in pairs(itemId2Count) do
		table.insert(allItemIds, itemId)
	end

	table.sort(allItemIds, function(a, b)
		local countA = itemId2Count[a]
		local countB = itemId2Count[b]

		return countB < countA
	end)

	local itemNum = 0

	gohelper.setActive(self._item, false)

	for i = 1, #allItemIds do
		local count = itemId2Count[allItemIds[i]]
		local id = tonumber(allItemIds[i])
		local mo = SurvivalBagItemMo.New()

		mo:init({
			id = id,
			count = count
		})

		if mo.equipCo == nil and (not mo:isCurrency() or mo.co.subType ~= SurvivalEnum.CurrencyType.Enthusiastic) then
			itemNum = itemNum + count

			local itemRes = self.viewContainer:getSetting().otherRes.itemRes
			local item = self:getResInst(itemRes, self._goItemLayout)
			local equipItem = MonoHelper.addNoUpdateLuaComOnceToGo(item, SurvivalBagItem)

			equipItem:updateMo(mo)
			equipItem:setShowNum(true)
			equipItem:setItemSize(150, 150)
			gohelper.setActive(item, true)
			table.insert(self._collectionItems, equipItem)
		end
	end

	self._txtItem.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_item"), itemNum)

	self:addShowStep(self._animationExtraItem, showTime[7], self._canvasGroupItem)
end

function SurvivalCeremonyClosingView:_initTotalScore()
	self._txtTotalScore.text = self._totalScore
	self._txtTotalCoin.text = self._coinNum

	local isMax = self._coinNum == -1

	gohelper.setActive(self._gocurrency, not isMax)
	gohelper.setActive(self._gocurrencymax, isMax)

	local num = tonumber(lua_survival_const.configDict[6003].value)

	gohelper.setActive(self._gocurrencyLimit, (num <= self._coinNum or nil) and true)
	self:addShowStep(self._animationTotalScore, showTime[8], self._canvasGroupTotalScore, {
		self._animationGoCurrency,
		self._animationGoCurrencyMax
	})
end

function SurvivalCeremonyClosingView:addShowStep(anim, time, canvasGroup, extraAnims)
	extraAnims = extraAnims or {}

	table.insert(self._allShowAnimation, anim)
	table.insert(self._allShowGO, anim.gameObject)
	table.insert(self._showTime, time)
	table.insert(self._extraAnims, extraAnims)

	self._maxStep = self._maxStep + 1

	self:_initCanvasAlpha(canvasGroup)
end

function SurvivalCeremonyClosingView:getScoreByType(scoreType)
	if self._report then
		local scoreMap = self._report.module2Score

		for index, v in pairs(scoreMap) do
			if tonumber(index) == scoreType then
				return v
			end
		end
	end

	return 0
end

function SurvivalCeremonyClosingView:_initCanvasAlpha(canvas)
	if canvas then
		canvas.alpha = 0
	end
end

function SurvivalCeremonyClosingView:enterNext()
	if not self._canEnterNext then
		return
	end

	if self._progress == self._maxStep then
		return
	end

	self._progress = self._progress + 1

	self:_refreshCurProgress()
end

function SurvivalCeremonyClosingView:getContentY()
	if self._allContentY == nil or #self._allContentY <= 0 then
		self._allContentY = {}

		local count = tabletool.len(self._allShowGO)

		for i = 1, count do
			local go = self._allShowGO[i]
			local tr = go.transform

			ZProj.UGUIHelper.RebuildLayout(tr)

			local rectTr = tr:GetComponent(gohelper.Type_RectTransform)
			local height = recthelper.getHeight(rectTr)

			if height ~= 0 then
				self._allContentY[i] = height + addHeight
			end
		end
	end

	if self._progress == self._maxStep then
		local height = recthelper.getHeight(self._contentRect)

		return height - self._scrollHeight
	end

	local allHeight = 0
	local count = math.min(self._progress, #self._allContentY)

	for i = 1, count do
		allHeight = allHeight + self._allContentY[i]
	end

	return allHeight - self._scrollHeight
end

function SurvivalCeremonyClosingView:_refreshCurProgress()
	self._canEnterNext = false

	local go = self._allShowGO[self._progress]
	local time = self._showTime[self._progress]
	local animation = self._allShowAnimation[self._progress]
	local extraAnims = self._extraAnims[self._progress]
	local contentY = self:getContentY()

	if contentY > 0 then
		self._moveTweenId = ZProj_TweenHelper.DOAnchorPosY(self._contentRect, contentY, time)
	end

	if go ~= nil then
		self._tweenId = ZProj_TweenHelper.DOFadeCanvasGroup(go, 0, 1, time, self._progressFinish, self)
	end

	if animation then
		animation:Play()
	end

	for i, anim in ipairs(extraAnims) do
		anim:Play()
	end
end

function SurvivalCeremonyClosingView:_initTalentGain()
	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local have = survivalShelterRoleMo:haveRole()

	gohelper.setActive(self._gorewardTips, have)

	if have then
		local roleId = survivalShelterRoleMo.roleId
		local outSideTechSpriteId = 0
		local roleTechSpriteId = lua_survival_role.configDict[roleId].techSpriteId
		local roleName = lua_survival_role.configDict[roleId].name
		local spriteStr1 = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalCeremonyClosingView_2"), {
			outSideTechSpriteId,
			self.commonTechPoint
		})

		self._txtTalentGainTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalCeremonyClosingView_1"), {
			roleName,
			spriteStr1,
			(roleTechSpriteId ~= 0 or nil) and GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalCeremonyClosingView_2"), {
				roleTechSpriteId,
				self.roleTechPoint
			})
		})

		self:addShowStep(self._animationTalentGain, showTime[9], self._canvasGroupTalentGain)

		local path = SurvivalRoleConfig.instance:getRoleHeadImage(roleId)

		if not string.nilorempty(path) then
			UISpriteSetMgr.instance:setSurvivalSprite2(self._image_role, path)
		end
	end
end

function SurvivalCeremonyClosingView:_progressFinish()
	self._canEnterNext = true

	local isFinish = self._progress == self._maxStep

	gohelper.setActive(self._nextClick.gameObject, not isFinish)
	gohelper.setActive(self._txtTips.gameObject, isFinish)
	gohelper.setActive(self._btnclose.gameObject, isFinish)
end

function SurvivalCeremonyClosingView:onClose()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType == SceneType.SurvivalShelter or curSceneType == SceneType.Fight then
		SurvivalController.instance:exitMap()
	end

	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	if outSideMo then
		outSideMo.inWeek = false
	end
end

function SurvivalCeremonyClosingView:onDestroyView()
	TaskDispatcher.cancelTask(self._progressFinish, self)

	if self._nextClick then
		self._nextClick:RemoveClickListener()

		self._nextClick = nil
	end

	if self._tweenId then
		ZProj_TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return SurvivalCeremonyClosingView
