-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardOperateDlg.lua

local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local DrawCardShowPanel = require("UI/DrawCard/DrawCardShowPanel")
local GameSettings = require("Helper/GameSettings")
local strClassName = "DrawCardOperateDlg"
local DrawCardOperateDlg = Class(strClassName, UIControls.Window)
local SLIDE_STEP = 3

function DrawCardOperateDlg:ctor(...)
	self:initUI()
end

function DrawCardOperateDlg:initUI(...)
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelControl = UIControls.Panel(self, "ModelControl")
	self.slotOfModelStageLoaded = Slot(self.onModelStageLoaded, self)
	self.slotOfSlideEnd = Slot(self.slideEnd, self)
	self.skipAllBtn = UIControls.Button(self, "BtnOver")

	self.skipAllBtn:addEventClick(self.onClickSkip)

	self.showHeroPanel = DrawCardShowPanel(self, "HeroShowPanel")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/ChoukaModeStage", self.slotOfModelStageLoaded)

	self.modelStage:connectImage(self.modelViewport)

	self.needInAnim = true
end

function DrawCardOperateDlg:onOpen(...)
	DrawCardOperateDlg.super.onOpen(self)
end

function DrawCardOperateDlg:onClose(...)
	GameSettings.resetShadowDistance("DrawCard")
	self.showHeroPanel:clear()
	self.modelStage:resetShadow()
	DrawCardOperateDlg.super.onClose(self)
end

function DrawCardOperateDlg:onModelStageLoaded(modelStage)
	modelStage:initSlideOperation(self.modelControl, SLIDE_STEP, self.slotOfSlideEnd)
end

function DrawCardOperateDlg:showDrawCardOperate(drawType, isSmall, groupId, customId)
	self.drawType = drawType
	self.drawItems = CurAvatar.lastDrawItems or {}

	self:_getPoolInfoCache()

	local boxId = self:_getBoxId(isSmall, groupId, customId)

	self.modelStage:setOperateModel(boxId, Functor(self._onBoxModelLoaded, self, isSmall))
	self.skipAllBtn:setVisible(false)
	self.showHeroPanel:clear()
	self.showHeroPanel:setVisible(false)
end

function DrawCardOperateDlg:_getPoolInfoCache(...)
	if not CurAvatar then
		return
	end

	self.pooInfoCache = {
		drawNeedItemId = CurAvatar.drawNeedItemId,
		drawNeedItemNum = CurAvatar.drawNeedItemNum,
		drawPoolId = CurAvatar.drawPoolId,
		drawDroup = CurAvatar.drawDroup,
		drawOpActId = CurAvatar.drawOpActId
	}
end

function DrawCardOperateDlg:_getBoxId(isSmall, groupId, customId)
	if customId then
		if not isSmall then
			return 100 + customId
		else
			return 200 + customId
		end
	elseif groupId then
		if not isSmall then
			return 10 + groupId
		else
			return 20 + groupId
		end
	elseif not isSmall then
		return 1
	else
		return 2
	end
end

function DrawCardOperateDlg:_onBoxModelLoaded(isSmall)
	if self.needInAnim then
		self.modelStage:playIn()

		self.needInAnim = false
	else
		self:resetStage()
	end

	local maxStarLv = 0
	local num4Star = 0
	local num5Star = 0
	local num6Star = 0
	local starCount = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	local idxList = {}

	for i, hero in ipairs(self.drawItems) do
		local heroStar = hero.star

		starCount[heroStar] = starCount[heroStar] + 1

		if maxStarLv < heroStar then
			maxStarLv = hero.star
		end

		if heroStar == 4 or heroStar == 3 then
			num4Star = num4Star + 1
		elseif heroStar == 5 then
			num5Star = num5Star + 1
		elseif heroStar == 6 then
			num6Star = num6Star + 1
		end

		idxList[i] = DrawCardConfig.CELL_INDEX_MAP[heroStar]
	end

	if isSmall then
		self.modelStage:setEffectColor(maxStarLv, starCount)
	elseif num6Star > 0 then
		self.modelStage:setFlyEffectActive({
			0,
			0,
			0,
			0,
			1
		})
	elseif num5Star > 0 and num4Star > 0 then
		self.modelStage:setFlyEffectActive({
			0,
			0,
			0,
			1,
			0
		})
	elseif num5Star > 0 then
		self.modelStage:setFlyEffectActive({
			0,
			0,
			1,
			0,
			0
		})
	elseif num4Star > 0 then
		self.modelStage:setFlyEffectActive({
			0,
			1,
			0,
			0,
			0
		})
	else
		self.modelStage:setFlyEffectActive({
			1,
			0,
			0,
			0,
			0
		})
	end

	self.modelStage:setLittleCells(idxList)
	self.modelStage:setOpenAudioPath(maxStarLv)
	self.modelStage:setBoxShadow(isSmall)
end

function DrawCardOperateDlg:slideEnd()
	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_OPEN_BOX)
	self.modelStage:playResult()

	if not self.showResultTimer then
		self.showResultTimer = Timer.New(Slot(self._showResult, self), DrawCardConfig.SHOW_HERO_DURATION)
	end

	self.showResultTimer:Restart()
end

function DrawCardOperateDlg:_showResult(...)
	local needShowHeroPanel = false

	if #self.drawItems == 1 then
		needShowHeroPanel = true
	else
		for _, hero in ipairs(self.drawItems) do
			if hero.star > DrawCardConfig.SKIP_SHOW_START then
				needShowHeroPanel = true
			end
		end
	end

	self.showHeroPanel:setVisible(needShowHeroPanel)

	if needShowHeroPanel then
		self.showHeroPanel:setResults(self.drawType, self.drawItems, self.pooInfoCache)
		self.skipAllBtn:setVisible(#self.drawItems > 1)
	else
		self.skipAllBtn:setVisible(false)
		CurAvatar:showDrawResultDlg(self.drawType, self.drawItems)
	end

	GameSettings.setShadowDistance(25, "DrawCard")
end

function DrawCardOperateDlg:resetStage(...)
	self.modelStage:initSlideOperation(self.modelControl, SLIDE_STEP, self.slotOfSlideEnd)
	self.modelStage:directPlayInEnd()
	self.modelStage:resetShadow()
end

function DrawCardOperateDlg:onClickSkip()
	self.skipAllBtn:setVisible(false)

	if not self.showHeroPanel:getVisible() then
		if self.showResultTimer then
			self.showResultTimer:Stop()
		end

		self.modelStage:directPlayOpened()
		CurAvatar:showDrawResultDlg(self.drawType, self.drawItems)
	elseif #self.drawItems > 1 then
		self.showHeroPanel:onClickSkip()
	end
end

return DrawCardOperateDlg
