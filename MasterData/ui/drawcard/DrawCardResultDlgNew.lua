-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardResultDlgNew.lua

local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local ResColor = require("ClientData/ResColor")
local CARD_HEIGHT = {
	rare = 830,
	normal = 766
}
local strClassName = "DrawCardResultDlg"
local DrawCardResultDlg = Class(strClassName, UIControls.Window)
local EffectHeroCardPanel = Class("EffectHeroCardPanel", UIControls.Panel)

function EffectHeroCardPanel:ctor()
	self:initUI()
end

function EffectHeroCardPanel:initUI(...)
	self.flashEff = UIControls.LazyEffectPlayer(self, self.mPath .. "/EfxFlash/Efx")
	self.effectPanel = UIControls.Panel(self, self.mPath .. "/EfxQuality")
	self.qualityEff = UIControls.LazyEffectPlayer(self, self.mPath .. "/EfxQuality/Efx")
	self.efxJoinPanel = UIControls.Panel(self, self.mPath .. "/EfxJion")
	self.joinEff = UIControls.LazyEffectPlayer(self, self.mPath .. "/EfxJion/Efx")
	self.childPath = self.mPath
end

local QUALITY_EFFECT_PATH = {
	nil,
	nil,
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Gold.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_loop_Pink.prefab"
}
local JOIN_HERO_EFFECT_PATH = {
	nil,
	nil,
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Purple.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Gold.prefab",
	"Effects/UI/efx_ui_HeroPoolResultCanvas_Join_Pink.prefab"
}
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

function EffectHeroCardPanel:setHero(hero, isNew)
	self.hero = hero

	if not self.heroPanel then
		self.heroPanel = UIControls.HeroPoolCardChild(self, self.childPath, "System/HeroPool/HeroPoolGridHeroCard", 0, 0, true)

		self.heroPanel:setSelectCallback(Slot(self._onSelectHero, self))

		self.rectPanel = UIControls.Panel(self.heroPanel, "")
		self.orgSize = self.rectPanel:getRectSize()
	end

	self.heroPanel:setHero(hero, hero.star >= 5)

	if not self.newIcon then
		self.newIcon = UIControls.Image(self.heroPanel, "InfoPanel1/IconNew")
	end

	self.newIcon:setVisible(isNew)
	self:playEff(hero.star)
end

function EffectHeroCardPanel:playEff(quality)
	if QUALITY_FLASH_EFFECT_PATH[quality] ~= nil then
		self.flashEff:playEffectByPath(QUALITY_FLASH_EFFECT_PATH[quality])
	else
		self.flashEff:playEffectByPath(QUALITY_FLASH_EFFECT_PATH.common)
	end

	if QUALITY_EFFECT_PATH[quality] ~= nil then
		self.qualityEff:playEffectByPath(QUALITY_EFFECT_PATH[quality])
		self.effectPanel:setVisible(true)
	else
		self.effectPanel:setVisible(false)
	end

	if JOIN_HERO_EFFECT_PATH[quality] ~= nil then
		self.joinEff:playEffectByPath(JOIN_HERO_EFFECT_PATH[quality])
		self.efxJoinPanel:setVisible(true)
	else
		self.efxJoinPanel:setVisible(false)
	end
end

function EffectHeroCardPanel:_onSelectHero()
	UIManager.getUI("heroPreviewTips"):showObj(self, self.hero)
end

function EffectHeroCardPanel:stopEffect(...)
	if self.effectPanel then
		self.effectPanel:setVisible(false)
	end
end

function DrawCardResultDlg:ctor(...)
	self:initUI()
end

local MAX_NUM = 10

function DrawCardResultDlg:initUI(...)
	self.gridMountPanel = UIControls.Panel(self, "HeroCardListPanel")
	self.gridMountPath = "HeroCardListPanel"
	self.cardList = {}

	for i = 1, MAX_NUM do
		local heroCard = EffectHeroCardPanel(self, "HeroCardListPanel/GridHeroCard" .. i)

		self.cardList[i] = heroCard
	end

	self.uiAni = UIControls.UIAni(self, "")
	self.bgImg = UIControls.RawImage(self, "RawImage")
	self.blockImg = UIControls.Panel(self, "Block")
	self.closeBtn = UIControls.Button(self, "BtnPanel/BtnClose", "Text")

	self.closeBtn:addEventClick(self._onClickClose)

	self.confirmBtn = UIControls.Button(self, "BtnPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickConfirmNewbie)

	self.againBtn = UIControls.Button(self, "BtnPanel/BtnAgain", "Text")

	self.againBtn:addEventClick(self._onClickAgain)

	self.againNumTxt = UIControls.Label(self, "BtnPanel/BtnAgain/TextNum")
	self.againBubble = UIControls.Image(self, "BtnPanel/BtnAgain/ImgBubble")
	self.againBubbleTxt = UIControls.Label(self, "BtnPanel/BtnAgain/ImgBubble/Text")
	self.againCostImg = UIControls.Image(self, "BtnPanel/BtnAgain/Icon")
	self.againCostTxt = UIControls.Label(self, "BtnPanel/BtnAgain/TextNum")
	self.noticePanel = UIControls.Panel(self, "BtnPanel/ImgProbability")
	self.noticeTxt = UIControls.Label(self, "BtnPanel/ImgProbability/TextUp")
	self.shareTitle = UIControls.Image(self, "BgTitle")
	self.audioPlayer = UIControls.LazyAudioPlayer(self, "HeroCardListPanel/AudioPanel1")
	self.sharePanel = ShareAchievePanel(self, "SharePanel")
end

function DrawCardResultDlg:onOpen()
	DrawCardResultDlg.super.onOpen(self)
	CameraModeManager.set2DHDR(true)
end

function DrawCardResultDlg:onClose(...)
	CameraModeManager.set2DHDR(false)

	if self.lackItem then
		UIManager.tryHideUI("drawCardOperateDlg")
	end

	DrawCardResultDlg.super.onClose(self)
end

function DrawCardResultDlg:_startClose(...)
	for _, cardPanel in ipairs(self.cardList) do
		cardPanel:stopEffect()
	end

	self:setVisible(false)
end

function DrawCardResultDlg:showDrawCardResult(drawType, items)
	self.drawType = drawType
	self.drawCount = #items
	self.needItemId = CurAvatar.drawNeedItemId
	self.needItemNum = CurAvatar.drawNeedItemNum
	self.poolId = CurAvatar.drawPoolId
	self.groupId = CurAvatar.drawDroup
	self.actId = CurAvatar.drawOpActId

	local isCostDraw = drawType == Const.DrawTypeStandard or drawType == Const.DrawTypeCustom or drawType == Const.DrawTypeGroup

	if isCostDraw and self.drawCount == 1 then
		self.bgImg:setVisible(false)
		self.gridMountPanel:setVisible(false)
	else
		self.gridMountPanel:setVisible(true)

		local newHeroDict = self:_calcNewHeros(drawType, items)
		local aniName = self.drawCount == 1 and "ShowHeroPoolResultOne" or "ShowHeroPoolResultTen1"

		self.uiAni:startAni(aniName)

		local sortedItems = self:_sortData(items, newHeroDict)
		local maxStar = -1

		for index, heroCard in ipairs(self.cardList) do
			local hero = sortedItems[index]

			if hero then
				heroCard:setVisible(true)
				heroCard:setHero(hero, newHeroDict[hero.id] or false)

				maxStar = math.max(maxStar, hero.star)
			else
				heroCard:setVisible(false)
			end
		end

		local needBg = drawType == Const.DrawTypeFree or drawType == Const.DrawTypeNewbie

		self.bgImg:setVisible(needBg)

		if maxStar >= 5 then
			self.audioPlayer:setAudioPath(QUALITY_PANEL_AUDIO_PATH.gold)
		else
			self.audioPlayer:setAudioPath(QUALITY_PANEL_AUDIO_PATH.purple)
		end
	end

	local needNotice = isCostDraw and DrawCardUtils.isNextProbiliatyUp(items)

	self.noticePanel:setVisible(needNotice)

	if needNotice then
		self.noticeTxt:setText(DrawCardUtils.probilityUpText())
	end

	if drawType ~= Const.DrawTypeNewbie and not self.poolId then
		self.confirmBtn:setVisible(false)
		self.againBtn:setVisible(false)
		self.closeBtn:setText(Lang.get(30260))

		return
	end

	if drawType == Const.DrawTypeNewbie and DrawCardUtils.isNewabieResultRetrieve() then
		self.againBtn:setVisible(false)
		self.confirmBtn:setVisible(false)
		self.closeBtn:setVisible(true)
		self.closeBtn:setText(Lang.get(30260))

		return
	end

	if isCostDraw then
		self:_refreshStandardButtons()
		self:_refreshShareBtns(true, items)

		local actObj = CurAvatar:getActivityObj(self.actId)

		if actObj and actObj.actData:checkIsOldRoleUpDraw() then
			self.sharePanel:hideAwardPanel(true)
		elseif actObj and actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP then
			if actObj.actData:checkCanDrawAgainByPoolId(self.poolId, self.drawCount) then
				self.againBtn:setVisible(true)
			else
				self.againBtn:setVisible(false)
			end
		end
	elseif drawType == Const.DrawTypeFree then
		self:_refreshFreeButtons()
		self:_refreshShareBtns(false)
	elseif drawType == Const.DrawTypeNewbie then
		-- block empty
	end
end

function DrawCardResultDlg:_refreshStandardButtons()
	self.confirmBtn:setVisible(false)
	self.closeBtn:setText(Lang.get(30260))

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
	self.againNumTxt:setVisible(false)

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

function DrawCardResultDlg:_refreshFreeButtons()
	self.confirmBtn:setVisible(false)
	self.closeBtn:setText(Lang.get(30260))

	local poolClientInfo = DrawCardUtils.getPoolClientInfo(self.poolId)

	if poolClientInfo then
		local poolName = poolClientInfo.title or ""

		self.againBubble:setVisible(true)
		self.againBubbleTxt:setText(string.format(Lang.get(30258), poolName))
	end

	local canDrawCount = 0

	if self.needItemId and self.needItemNum then
		canDrawCount = DrawCardUtils.calcFreeDrawCount(self.needItemId, self.needItemNum)
	end

	if canDrawCount > 0 then
		self.againBtn:setVisible(true)
		self.againBtn:setText(string.format(Lang.get(30259), Const.NUMBER_TO_WORD[canDrawCount]))
		self.againNumTxt:setVisible(false)
	else
		self.againBtn:setVisible(false)
		self.closeBtn:setFontColor(ResColor.WHITE)
		self.closeBtn:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir01Nml")
	end

	self.drawCount = canDrawCount
end

function DrawCardResultDlg:_refresNewbieButtons(...)
	self.confirmBtn:setVisible(true)
	self.closeBtn:setText(Lang.get(569))
	self.closeBtn:setFontColor(ResColor.BLACK)
	self.closeBtn:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir00Nml")

	if DrawCardUtils.hasNewbieCount() then
		self.againBtn:setVisible(true)
		self.againBtn:setText(Lang.get(30261))
		self.againNumTxt:setVisible(true)

		local leftCount = DrawCardUtils.getNewbieLeftCount()
		local maxCount = DrawCardUtils.getNewbieMaxCount()

		if leftCount <= DrawCardUtils.getNewbieRemainCount() then
			self.againNumTxt:setText("<color=#" .. ResColor.RED.ff .. ">" .. leftCount .. "/" .. maxCount .. "</color>")
			self.againBubble:setVisible(true)
			self.againBubbleTxt:setText(Lang.get(1327))
		else
			self.againNumTxt:setText(leftCount .. "/" .. maxCount)
			self.againBubble:setVisible(false)
		end
	else
		self.againBtn:setVisible(false)
	end
end

function DrawCardResultDlg:_refreshShareBtns(isVisible, items)
	self.sharePanel:setVisible(isVisible)

	if isVisible then
		self.needShare = false

		local opHasShareAward = false

		for i, item in ipairs(items or {}) do
			if item.star >= DrawCardConfig.SHOW_SHARE_STAR then
				self.needShare = true

				if self.actId then
					local hasAward = CurAvatar:drawActivityHasShareAward(self.actId, item.id)

					opHasShareAward = opHasShareAward or hasAward
				end
			end
		end

		if self.needShare then
			if self.actId and opHasShareAward then
				self.sharePanel:setActivityInfo(self.actId, self.mUIName)
			else
				self.sharePanel:setAchieveInfo(Const.ACHIEVE_TYPE_SHARE_STANDARDDRAW, self.mUIName)
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
end

function DrawCardResultDlg:_refreshShareTitle(isShare)
	if self and self.shareTitle and self.drawCount then
		self.shareTitle:setVisible(isShare and self.drawCount == MAX_NUM)
	end
end

function DrawCardResultDlg:_sortData(items, newHeroDic)
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
		local tempHero, tempNew, targetIndex

		for index, hero in ipairs(tempItems) do
			local thisNew = newHeroDic[hero.id] or false

			if tempHero == nil or hero.star > tempHero.star or hero.star == tempHero.star and thisNew and not tempNew then
				tempHero = hero
				tempNew = newHeroDic[tempHero.id] or false
				targetIndex = index
			end
		end

		rv[order] = tempHero

		table.remove(tempItems, targetIndex)
	end

	return rv
end

function DrawCardResultDlg:_calcNewHeros(drawType, items)
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

function DrawCardResultDlg:_onClickClose(...)
	local optDlg = UIManager.getUI("drawCardOperateDlg", nil, false)

	if optDlg then
		optDlg:setVisible(false)
	end

	self:_startClose()

	if self.needShare then
		CurAvatar:tryOpenGameEvaluateDlg("DrawCardResultDlg")
	end
end

function DrawCardResultDlg:onJumpRecharge()
	self:setVisible(false)
end

function DrawCardResultDlg:_onClickAgain(...)
	if self.drawType == Const.DrawTypeNewbie then
		self:_onClickAgainNewbie()

		return
	end

	if self.drawType == Const.DrawTypeCustom and not DrawCardUtils.checkOpActCanDraw(self.actId) then
		self:_onClickClose()

		return
	end

	if self.lackItem then
		self:_refreshStandardButtons()

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

	if not DrawCardUtils.checkBag(self.drawCount) then
		return
	end

	local drawCost = DrawCardUtils.checkDrawCost(self.poolId, self.drawCount)

	if drawCost ~= false then
		if self.drawType ~= Const.DrawTypeCustom then
			DrawCardUtils.realDrawCard(self.drawType, self.drawCount, drawCost, self.needItemId, self.needItemNum, self.poolId, self.groupId)
		else
			DrawCardUtils.realDrawOpActCard(self.actId, self.drawCount, drawCost, self.needItemId, self.needItemNum, self.poolId)
		end
	end

	self:_startClose()
end

function DrawCardResultDlg:_onClickConfirmNewbie(...)
	if self.drawType ~= Const.DrawTypeNewbie then
		return
	end

	local leftCount = DrawCardUtils.getNewbieLeftCount()
	local confirmDlg = UIManager.getUI("drawNewbieConfirmDlg", true)

	confirmDlg:setDrawInfo(leftCount, Slot(self._startClose, self))
end

function DrawCardResultDlg:_onClickAgainNewbie(...)
	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", Lang.get(30262), Slot(self._againConfirmYes, self), Slot(self._againConfirmNo, self), -1)
end

function DrawCardResultDlg:_againConfirmYes(...)
	DrawCardUtils.realDrawCard(self.drawType, 10)
end

function DrawCardResultDlg:_againConfirmNo(...)
	return
end

return DrawCardResultDlg
