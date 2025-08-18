-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardResultLightDlg.lua

local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResColor = require("ClientData/ResColor")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
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
local QUALITY_EFFECT_PATH = {
	nil,
	nil,
	"Effects/UI/efx_ui_HeroPool_GridPurple.prefab",
	"Effects/UI/efx_ui_HeroPool_GridPurple.prefab",
	"Effects/UI/efx_ui_HeroPool_GridOrange.prefab",
	"Effects/UI/efx_ui_HeroPool_GridOrange.prefab"
}

function EffectItemCardPanel:setResultItem(item)
	self.isHero = item:isHero()
	self.item = item

	if self.itemChild then
		self.itemChild:destroy()

		self.itemChild = nil
	end

	self.itemChild = UIControls.getGridChild(item, self, self.childPath)

	self.itemChild:setObj(item)

	self.itemChild.mDisableWays = true

	if self.isHero then
		self.itemChild.isShowPreviewTips = true
	end

	self.itemChild:setVisible(true)

	if self.isHero and QUALITY_EFFECT_PATH[item.star] ~= nil then
		self.effectPanel:setVisible(true)
		self.qualityEff:playEffectByPath(QUALITY_EFFECT_PATH[item.star])
	elseif not self.isHero and ITEM_DISP_STAR[item.id] ~= nil then
		self.effectPanel:setVisible(true)
		self.qualityEff:playEffectByPath(QUALITY_EFFECT_PATH[ITEM_DISP_STAR[item.id]])
	else
		self.effectPanel:setVisible(false)
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

	local hasHero = self:_hasHeros(items)
	local aniName = self.drawCount == 1 and "ShowHeroPoolResultGridOne" or "ShowHeroPoolResultGridTen"

	self.uiAni:startAni(aniName)

	for index, itemCard in ipairs(self.cardList) do
		local item = items[index]

		if item then
			itemCard:setVisible(true)
			itemCard:setResultItem(item)
		else
			itemCard:setVisible(false)
		end
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

	if itemEnough then
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
	else
		self.againBtn:setVisible(false)
		self.closeBtn:setVisible(false)
		self.confirmBtn:setVisible(true)
	end
end

function DrawCardResultLightDlg:_calcNewHeros(drawType, items)
	local heroCount = {}

	for i, item in ipairs(items) do
		local heroId = item.id

		if not heroCount[heroId] then
			heroCount[heroId] = 1
		else
			heroCount[heroId] = heroCount[heroId] + 1
		end
	end

	local heroIsNew = {}

	for heroId, count in pairs(heroCount) do
		local nowHasCount = CurAvatar:getHeroCountByResId(heroId)

		if drawType == Const.DrawTypeNewbie then
			heroIsNew[heroId] = nowHasCount == 0
		else
			heroIsNew[heroId] = nowHasCount - count <= 0
		end
	end

	return heroIsNew
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

function DrawCardResultLightDlg:_onClickAgain(...)
	if not DrawCardUtils.checkBag(self.drawCount) then
		return
	end

	local drawCost = DrawCardUtils.checkDrawCost(self.poolId, self.drawCount)

	if drawCost ~= false then
		DrawCardUtils.realDrawCard(self.drawType, self.drawCount, drawCost, self.needItemId, self.needItemNum, self.poolId, self.groupId)
	end

	self:_startClose()
end

function DrawCardResultLightDlg:_onClickConfirm(...)
	self:_onClickClose()
end

return DrawCardResultLightDlg
