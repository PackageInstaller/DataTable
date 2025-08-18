-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardResultLightDlgNew.lua

local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResColor = require("ClientData/ResColor")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local CARD_HEIGHT = {
	rare = 830,
	normal = 766
}
local strClassName = "DrawCardResultLightDlg"
local DrawCardResultLightDlg = Class(strClassName, UIControls.Window)
local EffectItemCardPanel = Class("EffectItemCardPanel", UIControls.Panel)

function EffectItemCardPanel:ctor()
	self:initUI()
end

function EffectItemCardPanel:initUI(...)
	self.flashEff = UIControls.LazyEffectPlayer(self, self.mPath .. "/EfxFlash/Efx")
	self.effectPanel = UIControls.Panel(self, self.mPath .. "/EfxQuality")
	self.qualityEff = UIControls.LazyEffectPlayer(self, self.mPath .. "/EfxQuality/Efx")
	self.efxJoinPanel = UIControls.Panel(self, self.mPath .. "/EfxJion")
	self.joinEff = UIControls.LazyEffectPlayer(self, self.mPath .. "/EfxJion/Efx")
	self.childPath = self.mPath
end

local ITEM_DISP_STAR = {
	[540063] = 4,
	[540061] = 4,
	[540068] = 5,
	[540066] = 5,
	[540062] = 4,
	[540067] = 5
}
local ITEM_TYPE_SORT = {
	[Const.ITEM_TYPE_ITEM] = 128,
	[Const.ITEM_TYPE_FRAG_ITEM] = 256,
	[Const.ITEM_TYPE_RAND_FRAG_ITEM] = 2,
	[Const.ITEM_TYPE_EQUIP] = 2,
	[Const.ITEM_TYPE_ARTIFACT] = 2,
	[Const.ITEM_TYPE_RELIC] = 2,
	[Const.ITEM_TYPE_EQUIP_TEMPLETE] = 2,
	[Const.ITEM_TYPE_HERO] = 512,
	[Const.ITEM_TYPE_SKIN] = 2
}
local QUALITY_HERO_EFFECT_PATH = {
	nil,
	nil,
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Gold.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Pink.prefab"
}
local QUALITY_ITEM_EFFECT_PATH = utils.deepcopy(QUALITY_HERO_EFFECT_PATH)

QUALITY_ITEM_EFFECT_PATH[5] = "Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Gold_01.prefab"

local JOIN_HERO_EFFECT_PATH = {
	nil,
	nil,
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Gold.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Pink.prefab"
}
local JOIN_ITEM_EFFECT_PATH = utils.deepcopy(JOIN_HERO_EFFECT_PATH)

JOIN_ITEM_EFFECT_PATH[5] = "Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Gold_01.prefab"

local QUALITY_FLASH_EFFECT_PATH = {
	nil,
	nil,
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Gold.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Pink.prefab",
	common = "Effects/UI/efx_ui_HeroPoolResultCanvas_Common.prefab"
}
local QUALITY_PANEL_AUDIO_PATH = {
	purple = "Audios/SFX/UI/ui_Heropool_Purplequality.ogg",
	gold = "Audios/SFX/UI/ui_Heropool_goldquality.ogg"
}

function EffectItemCardPanel:setResultItem(item, isNew)
	self.isHero = item:isHero()
	self.item = item

	if self.itemChild then
		self.itemChild:destroy()

		self.itemChild = nil
	end

	self.itemChild = UIControls.HeroPoolCardChild(self, self.childPath, "System/HeroPool/HeroPoolGridHeroCard", 0, 0, true)

	self.itemChild:setVisible(true)

	if self.isHero then
		self.heroChild = self.itemChild
		self.hero = item

		self.heroChild:setHero(self.hero, self.hero.star >= 5)
		self.heroChild:setSelectCallback(Slot(self._onSelectHero, self))

		local heroChildNewMark = UIControls.Image(self.heroChild, "InfoPanel1/IconNew")

		heroChildNewMark:setVisible(isNew)
	else
		self.ItemObj = self.itemChild:setItem(item)
		self.realItemChild = UIControls.getGridChild(item, self.itemChild, self.itemChild.itemInfoPanel.mPath)

		self.realItemChild:setObj(item)
		self.realItemChild:setVisible(true)

		self.realItemChild.mDisableWays = true

		self.itemChild:setSelectCallback(Slot(self._onSelectItem, self))

		if item.itemType == Const.ITEM_TYPE_FRAG_ITEM then
			local itemChildSlider = UIControls.Panel(self.realItemChild, "Slider")

			if itemChildSlider then
				itemChildSlider:setVisible(false)
			end

			local itemChildTextNum = UIControls.Label(self.realItemChild, "TextNum")

			if itemChildTextNum then
				itemChildTextNum:setVisible(false)
			end
		end
	end

	self:playEff(self:_getItemStar(), self.isHero)
end

function EffectItemCardPanel:playEff(quality, isHero)
	if QUALITY_FLASH_EFFECT_PATH[quality] ~= nil then
		self.flashEff:playEffectByPath(QUALITY_FLASH_EFFECT_PATH[quality])
	else
		self.flashEff:playEffectByPath(QUALITY_FLASH_EFFECT_PATH.common)
	end

	local qualityMap

	if isHero then
		qualityMap = QUALITY_HERO_EFFECT_PATH
	else
		qualityMap = QUALITY_ITEM_EFFECT_PATH
	end

	if qualityMap[quality] ~= nil then
		self.effectPanel:setVisible(true)
		self.qualityEff:playEffectByPath(qualityMap[quality])
	else
		self.effectPanel:setVisible(false)
	end

	local joinMap

	if isHero then
		joinMap = JOIN_HERO_EFFECT_PATH
	else
		joinMap = JOIN_ITEM_EFFECT_PATH
	end

	if joinMap[quality] ~= nil then
		self.efxJoinPanel:setVisible(true)
		self.joinEff:playEffectByPath(joinMap[quality])
	else
		self.efxJoinPanel:setVisible(false)
	end
end

function EffectItemCardPanel:_getItemStar()
	if self.item.isHero() then
		return self.item.star
	else
		if ITEM_DISP_STAR[self.item.id] ~= nil then
			return ITEM_DISP_STAR[self.item.id]
		end

		return self.item.quality
	end
end

function EffectItemCardPanel:_onSelectHero()
	UIManager.getUI("heroPreviewTips"):showObj(self, self.hero)
end

function EffectItemCardPanel:_onSelectItem()
	if self.realItemChild.openTipsPanel ~= nil then
		self.realItemChild:openTipsPanel()
	end
end

function EffectItemCardPanel:stopEffect(...)
	if self.effectPanel then
		self.effectPanel:setVisible(false)
	end
end

function DrawCardResultLightDlg:ctor(...)
	self:initUI()
end

local MAX_NUM = 10

function DrawCardResultLightDlg:initUI(...)
	self.gridMountPanel = UIControls.Panel(self, "HeroCardListPanel")
	self.cardList = {}

	for i = 1, MAX_NUM do
		local itemCard = EffectItemCardPanel(self, "HeroCardListPanel/GridHeroCard" .. i)

		self.cardList[i] = itemCard
	end

	self.uiAni = UIControls.UIAni(self, "")
	self.bgImg = UIControls.RawImage(self, "RawImage")
	self.closeBtn = UIControls.Button(self, "BtnPanel/BtnClose", "Text")

	self.closeBtn:addEventClick(self._onClickClose)

	self.confirmBtn = UIControls.Button(self, "BtnPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickConfirm)

	self.againBtn = UIControls.Button(self, "BtnPanel/BtnAgain", "Text")

	self.againBtn:addEventClick(self._onClickAgain)

	self.againBubble = UIControls.Image(self, "BtnPanel/BtnAgain/ImgBubble")
	self.againBubbleTxt = UIControls.Label(self, "BtnPanel/BtnAgain/ImgBubble/Text")
	self.againCostImg = UIControls.Image(self, "BtnPanel/BtnAgain/Icon")
	self.againCostTxt = UIControls.Label(self, "BtnPanel/BtnAgain/TextNum")
	self.noticePanel = UIControls.Panel(self, "BtnPanel/ImgProbability")
	self.noticeTxt = UIControls.Label(self, "BtnPanel/ImgProbability/TextUp")
	self.noticeImg = UIControls.Image(self, "BtnPanel/ImgProbability/Img")
	self.shareTitle = UIControls.Image(self, "BgTitle")
	self.audioPlayer = UIControls.LazyAudioPlayer(self, "HeroCardListPanel/AudioPanel1")
	self.sharePanel = ShareAchievePanel(self, "SharePanel")
end

function DrawCardResultLightDlg:_startClose(...)
	for _, cardPanel in ipairs(self.cardList) do
		cardPanel:stopEffect()
	end

	self:setVisible(false)
end

function DrawCardResultLightDlg:showDrawCardResult(items)
	self.drawType = Const.DrawTypeLightDark
	self.drawCount = CurAvatar.lastDrawCount
	self.needItemId = CurAvatar.drawNeedItemId
	self.needItemNum = CurAvatar.drawNeedItemNum
	self.poolId = CurAvatar.drawPoolId
	self.groupId = CurAvatar.drawDroup
	self.actId = CurAvatar.drawOpActId

	local hasHero = self:_hasHeros(items)
	local aniName = self.drawCount == 1 and "ShowHeroPoolResultGridOne1" or "ShowHeroPoolResultTen1"

	self.uiAni:startAni(aniName)

	local newHeroDict = self:_calcNewHeros(items)
	local sortedItems = self:_sortData(items, newHeroDict)
	local maxStar = -1

	for index, itemCard in ipairs(self.cardList) do
		local item = sortedItems[index]

		if item then
			itemCard:setVisible(true)
			itemCard:setResultItem(item, item.isHero() and (newHeroDict[item.id] or false))

			maxStar = math.max(maxStar, itemCard:_getItemStar())
		else
			itemCard:setVisible(false)
		end
	end

	if maxStar >= 5 then
		self.audioPlayer:setAudioPath(QUALITY_PANEL_AUDIO_PATH.gold)
	else
		self.audioPlayer:setAudioPath(QUALITY_PANEL_AUDIO_PATH.purple)
	end

	local needNotice = not hasHero

	self.noticePanel:setVisible(needNotice)

	if needNotice then
		self.noticeTxt:setText(DrawCardUtils.probilityUpText())

		local imgPath = self.drawCount == 1 and "IconProbability1" or "IconProbability2"

		self.noticeImg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas3", imgPath)
	end

	if not self.poolId then
		self.confirmBtn:setVisible(false)
		self.againBtn:setVisible(false)
		self.closeBtn:setText(Lang.get(30260))

		return
	end

	self:_refreshButtons()

	self.needShare = false

	local hasOpAward = false
	local opActId

	for i, item in ipairs(items) do
		if item:isHero() and item.star >= DrawCardConfig.SHOW_SHARE_STAR then
			self.needShare = true

			local tmpHasAward, tmpActId = CurAvatar:replaceActivityHasShareAward(item.id)

			if tmpHasAward then
				hasOpAward = true
				opActId = tmpActId

				break
			end
		end
	end

	if self.needShare then
		if hasOpAward then
			self.sharePanel:setActivityInfo(opActId, self.mUIName)
		else
			self.sharePanel:setAchieveInfo(Const.ACHIEVE_TYPE_SHARE_LIGHTDRAW, self.mUIName)
		end
	end

	self.sharePanel:setShareVisible(self.needShare)

	if self.needShare then
		self.sharePanel:setBeforeAction(self._refreshShareTitle, self, true)
		self.sharePanel:setFinishAction(self._refreshShareTitle, self, false)
	else
		self.sharePanel:setBeforeAction()
		self.sharePanel:setFinishAction()
	end
end

function DrawCardResultLightDlg:_refreshButtons()
	self.confirmBtn:setVisible(false)

	local poolClientInfo = DrawCardUtils.getPoolClientInfo(self.poolId)

	if poolClientInfo then
		local poolName = poolClientInfo.title or ""

		self.againBubble:setVisible(true)
		self.againBubbleTxt:setText(string.format(Lang.get(30258), poolName))
	end

	local itemEnough, realNeedItem, realNeedNum = DrawCardUtils.checkDrawCost(self.poolId, self.drawCount, true)

	self.lackItem = not itemEnough

	self.againBtn:setVisible(true)
	self.againBtn:setText(string.format(Lang.get(30259), Const.NUMBER_TO_WORD[self.drawCount]))
	self.closeBtn:setVisible(true)
	self.confirmBtn:setVisible(false)

	self.needItemId = realNeedItem
	self.needItemNum = realNeedNum

	local needItemObj = BaseObject.GetObject(self.needItemId)

	if needItemObj then
		local needItemIconPath = needItemObj:getIconPath()

		self.againCostImg:setVisible(true)
		self.againCostImg:setImage(needItemIconPath[1], needItemIconPath[2])
		self.againCostTxt:setVisible(true)
		self.againCostTxt:setText(realNeedNum)
	else
		self.againCostImg:setVisible(false)
		self.againCostTxt:setVisible(false)
	end
end

function DrawCardResultLightDlg:_refreshShareTitle(isShare)
	if self and self.shareTitle and self.drawCount then
		self.shareTitle:setVisible(isShare and self.drawCount == MAX_NUM)
	end
end

function DrawCardResultLightDlg:_calcNewHeros(items)
	local heroCount = {}

	for i, item in ipairs(items) do
		if item.isHero() then
			local heroId = item.id

			if not heroCount[heroId] then
				heroCount[heroId] = 1
			else
				heroCount[heroId] = heroCount[heroId] + 1
			end
		end
	end

	local heroIsNew = {}

	for heroId, count in pairs(heroCount) do
		local nowHasCount = CurAvatar:getHeroCountByResId(heroId)

		heroIsNew[heroId] = nowHasCount - count <= 0
	end

	return heroIsNew
end

function DrawCardResultLightDlg:_sortData(items, newHeroDic)
	local rv, tempItems = {}, {}

	for k, v in ipairs(items) do
		tempItems[k] = v
	end

	local bestOrder = {
		5,
		6,
		4,
		7,
		3,
		8,
		2,
		9,
		1,
		10
	}

	for _, order in ipairs(bestOrder) do
		local tempItem, tempNew, targetIndex

		for index, item in ipairs(tempItems) do
			local isHero = item:isHero()
			local thisNew = isHero and (newHeroDic[item.id] or false)

			if tempItem == nil or ITEM_TYPE_SORT[item.itemType] > ITEM_TYPE_SORT[tempItem.itemType] or isHero and item.star > tempItem.star or isHero and item.star == tempItem.star and thisNew and not tempNew or not isHero and ITEM_TYPE_SORT[item.itemType] == ITEM_TYPE_SORT[tempItem.itemType] and item.quality > tempItem.quality then
				tempItem = item
				tempNew = thisNew
				targetIndex = index
			end
		end

		rv[order] = tempItem

		table.remove(tempItems, targetIndex)
	end

	return rv
end

function DrawCardResultLightDlg:_hasHeros(items)
	local heroCount = 0

	for i, item in ipairs(items) do
		if item:isHero() and item.star >= 5 then
			heroCount = heroCount + 1
		end
	end

	return heroCount > 0
end

function DrawCardResultLightDlg:_onClickClose(...)
	local optDlg = UIManager.getUI("drawCardOptLightDlg", nil, false)

	if optDlg then
		optDlg:setVisible(false)
	end

	self:_startClose()

	if self.needShare then
		CurAvatar:tryOpenGameEvaluateDlg("DrawCardResultLightDlg")
	end
end

function DrawCardResultLightDlg:onJumpRecharge()
	self:setVisible(false)
end

function DrawCardResultLightDlg:_onClickAgain(...)
	if not DrawCardUtils.checkBag(self.drawCount) then
		return
	end

	if self.lackItem then
		self:_refreshButtons()

		if self.lackItem then
			if self.needItemId == Const.MONEY_ID_DIAMOND then
				ClientUtils.checkMoneyChange(self.needItemId, self.needItemNum, nil, nil, nil, Slot(self.onJumpRecharge, self))
			else
				BaseObject.ShowObjectTips(self.needItemId, self.needItemNum, self, {
					CloseSrcWindow = 1,
					AutoOpenGuide = 1
				})
			end

			return
		end
	end

	local drawCost = DrawCardUtils.checkDrawCost(self.poolId, self.drawCount)

	if drawCost ~= false then
		if self.groupId == Const.DrawNewBieCampLightDark then
			DrawCardUtils.realDrawOpActCard(self.actId, self.drawCount, drawCost, self.needItemId, self.needItemNum, self.poolId, self.groupId)
		else
			DrawCardUtils.realDrawCard(self.drawType, self.drawCount, drawCost, self.needItemId, self.needItemNum, self.poolId, self.groupId)
		end
	end

	self:_startClose()
end

function DrawCardResultLightDlg:_onClickConfirm(...)
	self:_onClickClose()
end

function DrawCardResultLightDlg:onClose()
	if self.lackItem then
		UIManager.tryHideUI("drawCardOptLightDlg")
	end

	DrawCardResultLightDlg.super.onClose(self)
end

return DrawCardResultLightDlg
