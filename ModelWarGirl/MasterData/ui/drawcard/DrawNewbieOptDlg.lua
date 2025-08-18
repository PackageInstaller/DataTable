-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawNewbieOptDlg.lua

local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local ResColor = require("ClientData/ResColor")
local Hero = require("Common/Object/Hero")
local strClassName = "DrawNewbieOptDlg"
local DrawNewbieOptDlg = Class(strClassName, UIControls.Window)
local NewbieHeroCell = Class("NewbieHeroCell", UIControls.Child)

function NewbieHeroCell:ctor(...)
	self:initUI()
end

function NewbieHeroCell:initUI(...)
	self.efxPanel = UIControls.LazyEffectPlayer(self, "EfxHeroCard")
end

function NewbieHeroCell:setHero(hero)
	if not self.heroCell then
		self.heroCell = UIControls.HeroCardChild(self, "", "System/Hero/GridHeroCard", 0, 0, true)
	end

	self.hero = hero

	self.heroCell:setHero(hero)
	self.heroCell:setSelectCallback(Slot(self._onSelectHero, self))

	local quality = hero.quality

	if quality >= Const.HERO_QUALITY_S then
		self.efxPanel:playEffectByPath("Effects/UI/efx_ui_Cards_orange1.prefab")
		self.efxPanel:setVisible(true)
	elseif quality == Const.HERO_QUALITY_A then
		self.efxPanel:playEffectByPath("Effects/UI/efx_ui_Cards_blue1.prefab")
		self.efxPanel:setVisible(true)
	else
		self.efxPanel:setVisible(false)
	end
end

function NewbieHeroCell:_onSelectHero()
	if self.heroCell then
		UIManager.getUI("heroPreviewTips"):showObj(self, self.hero)
	end
end

function NewbieHeroCell:clearHero(...)
	self.efxPanel:setVisible(false)
	self.heroCell:clearSelectCallback()
end

local NewbieHeroList = Class("NewbieHeroList", UIControls.Panel)

function NewbieHeroList:ctor(...)
	self:initUI()
end

function NewbieHeroList:initUI(...)
	self.cellMountPath = self.mPath .. "/GridHeroPanel"
	self.cellList = {}
	self.scoreTxt = UIControls.Label(self, self.mPath .. "/BgScore/TxtScore")
	self.recommendImg = UIControls.Image(self, self.mPath .. "/IconRecommend")
	self.superRecommendImg = UIControls.Image(self, self.mPath .. "/IconRecommend1")
	self.bgImg = UIControls.Image(self, self.mPath .. "/BackgroudPanel/ImgBg")
end

function NewbieHeroList:setHeroList(heroList)
	if #heroList == 0 then
		self:clearHeroList()

		return
	end

	for i, itemInfo in ipairs(heroList) do
		local heroId = itemInfo.id
		local hero = BaseObject.GetObject(heroId)
		local heroCell = self.cellList[i]

		if not heroCell then
			heroCell = NewbieHeroCell(self, self.cellMountPath, "System/HeroPool/GridHeroNewPanel", 0, 0, true)
			self.cellList[i] = heroCell
		end

		heroCell:setHero(hero)
	end

	local orange, purple, blue, orangeHeroIdList = DrawCardUtils.getHeroQualitys(heroList)
	local playerOranges = DrawCardUtils.getAllOrangeHeros()
	local score = DrawCardConfig.CalcNewbieRecordScore(orangeHeroIdList, purple, blue, playerOranges)

	self.scoreTxt:setText(score)

	local checkSuperRec = score >= DrawCardConfig.SUPER_RECOMMEND_SCORE
	local checkRec = not checkSuperRec and score >= DrawCardConfig.RECOMMEND_SCORE

	self.recommendImg:setVisible(checkRec)
	self.superRecommendImg:setVisible(checkSuperRec)

	if orange > 0 then
		self.bgImg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas5", "BgGoldBottom")
	else
		self.bgImg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas5", "BgOrdinaryBottom")
	end
end

function NewbieHeroList:clearHeroList()
	for i, heroCell in ipairs(self.cellList) do
		heroCell:clearHero()
		heroCell:destroy()
	end

	self.cellList = {}
end

function NewbieHeroList:destroyHeroList(...)
	for i, heroCell in ipairs(self.cellList) do
		heroCell:destroy()
	end

	self.cellList = {}
end

local NewbieRecordThumbCell = Class("NewbieRecordThumbCell", UIControls.ScrollViewLoopCell)

function NewbieRecordThumbCell:ctor(...)
	self:initUI()
end

function NewbieRecordThumbCell:initUI(...)
	self.bgImg = UIControls.Image(self, "ImgCard")
	self.recommendImg = UIControls.Image(self, "IconRecommend")
	self.superRecommendImg = UIControls.Image(self, "IconRecommend1")
	self.gridPanel = UIControls.Panel(self, "GridPanel")
	self.gridPanelDouble = UIControls.Panel(self, "GridPanelDouble")
	self.rootBtn = UIControls.Button(self, "")

	self.rootBtn:addEventClick(self._onClickSelect)
end

function NewbieRecordThumbCell:setThumbData(record)
	self.resultIndex = record.index
	self.heroList = record.item

	local hasOrange = record.orangeCount > 0
	local orangeHeroIdList = record.orangeHeroIdList

	if record.orangeCount > 1 then
		self.bgImg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas4", "BgTwoGoldCard")
		self.gridPanel:setVisible(false)
		self.gridPanelDouble:setVisible(true)

		self.heroGridList = self.heroGridList or {}

		for i, heroId in ipairs(orangeHeroIdList) do
			local heroGrid = self.heroGridList[i]

			if not heroGrid then
				heroGrid = UIControls.HeroGridChild(self, "GridPanelDouble", "System/StarUp/GridHeroStarUp", 0, 0, true)
				heroGrid.mEnableTips = false
				heroGrid.isShowPreviewTips = false

				table.insert(self.heroGridList, heroGrid)
			end

			heroGrid:setVisible(true)

			local hero = BaseObject.GetObject(heroId, 1)

			heroGrid:setObj(hero)
		end

		for i = #orangeHeroIdList + 1, #self.heroGridList do
			self.heroGridList[i]:setVisible(false)
		end
	elseif record.orangeCount == 1 then
		self.bgImg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas4", "BgGoldCard")
		self.gridPanel:setVisible(true)
		self.gridPanelDouble:setVisible(false)

		if not self.heroGrid then
			self.heroGrid = UIControls.HeroGridChild(self, "GridPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
			self.heroGrid.mEnableTips = false
			self.heroGrid.isShowPreviewTips = false
		end

		self.heroGrid:setVisible(true)

		local heroId = orangeHeroIdList[1]
		local hero = BaseObject.GetObject(heroId, 1)

		self.heroGrid:setObj(hero)
	else
		self.bgImg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas4", "BgOrdinaryCard")
		self.gridPanel:setVisible(false)
		self.gridPanelDouble:setVisible(false)
	end

	local checkSuperRec = record.score >= DrawCardConfig.SUPER_RECOMMEND_SCORE
	local checkRec = not checkSuperRec and record.score >= DrawCardConfig.RECOMMEND_SCORE

	self.recommendImg:setVisible(checkRec)
	self.superRecommendImg:setVisible(checkSuperRec)
end

function NewbieRecordThumbCell:setSelected(isSelected)
	self.rootBtn:setEnable(not isSelected)
end

function NewbieRecordThumbCell:_onClickSelect()
	self.mParent:onSelectThumb(self.mIndex)
end

function DrawNewbieOptDlg:ctor(...)
	self:initUI()
end

function DrawNewbieOptDlg:initUI(...)
	self.specialHeroListPanel = NewbieHeroList(self, "MainInfoPanel/HeroOrderPanel1")
	self.commonHeroListPanel = NewbieHeroList(self, "MainInfoPanel/HeroOrderPanel2")
	self.confirmBtn = UIControls.Button(self, "MainInfoPanel/BtnConfirmOrder")

	self.confirmBtn:addEventClick(self._onClickConfirm)

	self.drawBtn = UIControls.Button(self, "MainInfoPanel/BtnAnotherOrder", "Text2")

	self.drawBtn:addEventClick(self._onClickDraw)

	self.drawBtnNumTxt = UIControls.Label(self, "MainInfoPanel/BtnAnotherOrder/Text1")
	self.findBtn = UIControls.Button(self, "MainInfoPanel/BtnFind")

	self.findBtn:addEventClick(self._onClickFindFirst)

	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self._onClickTips)

	self.animSelf = UIControls.UIAni(self, "")

	self.animSelf:addEventFinish(self._onAnimEnd)

	self.animInfoPanel = UIControls.UIAni(self, "MainInfoPanel")

	self.animInfoPanel:addEventFinish(self._onAnimEnd)

	self.recordThumbList = {}
	self.recordThumbScroll = UIControls.ScrollViewLoopV(self, "MainInfoPanel/OrderChooseList")

	self.recordThumbScroll:addEventCellChanged(self.onRecordThumbChanged)

	self.orangeOnlyBtn = UIControls.Button(self, "MainInfoPanel/Bglist/SelPanel/BtnSel")

	self.orangeOnlyBtn:addEventClick(self.onOrangeOnlyClick)

	self.orangeFlagImg = UIControls.Panel(self, "MainInfoPanel/Bglist/SelPanel/Checkmark")
	self.orangeFlag = DrawCardUtils.getOrangeOnlyFlag()

	self.orangeFlagImg:setVisible(self.orangeFlag)

	self.orangeFlagPanel = UIControls.Panel(self, "MainInfoPanel/Bglist/SelPanel")
	self.btnReset = UIControls.Button(self, "MainInfoPanel/BtnReOrder")

	self.btnReset:addEventClick(self.onClickBtnReset)

	self.txtResetTimes = UIControls.Label(self, "MainInfoPanel/BtnReOrder/Text2")
end

function DrawNewbieOptDlg:_readResultData()
	local records = DrawCardUtils.getDrawRecords()

	for i, record in ipairs(records) do
		local orange, purple, blue, orangeHeroIdList = DrawCardUtils.getHeroQualitys(record.item)
		local playerOranges = DrawCardUtils.getAllOrangeHeros()
		local score = DrawCardConfig.CalcNewbieRecordScore(orangeHeroIdList, purple, blue, playerOranges)

		record.score = score
		record.orangeCount = orange
		record.orangeHeroId = orangeHeroIdList[1]
		record.orangeHeroIdList = orangeHeroIdList
	end

	local orangeFlag = DrawCardUtils.getOrangeOnlyFlag()

	if not DrawCardUtils.hasNewbieCount() and orangeFlag then
		self.viewRecords = {}

		for _, heroList in ipairs(records) do
			if heroList.orangeCount > 0 then
				table.insert(self.viewRecords, heroList)
			end
		end
	else
		self.viewRecords = records
	end
end

function DrawNewbieOptDlg:onViewResult()
	self:_readResultData()

	if #self.viewRecords > 0 then
		self.curSelectIdx = 1

		local nowRecord = self.viewRecords[self.curSelectIdx]

		self:_setPanelsHeroList(nowRecord.item)
		self:_showPanels(true)
	else
		self.curSelectIdx = 0

		self:_setPanelsHeroList({})
	end

	self.recordThumbScroll:setTotalCount(#self.viewRecords, self.curSelectIdx)
	self:_refreshButtonsByState()
	self.animSelf:startAni("ShowPoolOrder2", true)

	if DrawCardUtils.getNewbieLeftCount() == 0 then
		BeginnerManager.NewBieDrawCardOver()
	end
end

function DrawNewbieOptDlg:onNewbieDraw(items)
	self:_readResultData()

	self.curSelectIdx = #self.viewRecords

	coroutine.start(self._coSetThumb, self)
	self:_refreshButtonsByState()
	self:_setPanelsHeroList(items)
	self:_showPanels(true)

	if DrawCardUtils.newbieDrawCountIs(1) then
		self.animSelf:startAni("ShowPoolOrder1", true)
	else
		self.animSelf:startAni("ShowPoolAnother", true)
	end

	if DrawCardUtils.getNewbieLeftCount() == 0 then
		BeginnerManager.NewBieDrawCardOver()
	end
end

function DrawNewbieOptDlg:_coSetThumb(...)
	self.recordThumbScroll:setTotalCount(#self.viewRecords)
	coroutine.step()
	self.recordThumbScroll:scrollToCell(self.curSelectIdx)
end

function DrawNewbieOptDlg:onSelectThumb(index, forceScroll)
	if not self.viewRecords[index] then
		return
	end

	if self.inSelectAnim then
		return
	end

	self.curSelectIdx = index

	local targetInView = false

	for _, cell in pairs(self.recordThumbList) do
		if cell.mIndex == index then
			targetInView = true
		end

		cell:setSelected(cell.mIndex == index)
	end

	if forceScroll then
		self.recordThumbScroll:scrollToCell(self.curSelectIdx)
	end

	self.inSelectAnim = true

	self:_setPanelsHeroList(nil, {})
	self:_showPanels(true, true)
	self.animInfoPanel:startAni("ShowGotOrder", true)
end

function DrawNewbieOptDlg:onRecordThumbChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = NewbieRecordThumbCell(sender, "System/HeroPool/OrderCell", newIdx, 0, 0)
	else
		self.recordThumbList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local record = self.viewRecords[newIdx]

	if record then
		targetCell:setThumbData(record)
		targetCell:setSelected(newIdx == self.curSelectIdx)
	end

	self.recordThumbList[newIdx] = targetCell
end

function DrawNewbieOptDlg:_setPanelsHeroList(commonHeroList, specHeroList)
	if commonHeroList then
		self.commonHeroListPanel:setHeroList(commonHeroList)
	end

	if specHeroList then
		self.specialHeroListPanel:setHeroList(specHeroList)
	end
end

function DrawNewbieOptDlg:_showPanels(comPanelVisible, specPanelVisible)
	self.commonHeroListPanel:setVisible(comPanelVisible or false)
	self.specialHeroListPanel:setVisible(specPanelVisible or false)
end

function DrawNewbieOptDlg:_refreshButtonsByState()
	local leftCount = DrawCardUtils.getNewbieLeftCount()

	if leftCount > 0 then
		self.findBtn:setVisible(false)
		self.drawBtn:setVisible(true)
		self.orangeFlagPanel:setVisible(false)
		self.btnReset:setVisible(false)

		local maxCount = DrawCardUtils.getNewbieMaxCount()
		local remainCount = DrawCardUtils.getNewbieRemainCount()

		if leftCount <= remainCount then
			self.drawBtnNumTxt:setText("<color=#" .. ResColor.RED.ff .. ">" .. leftCount .. "/" .. maxCount .. "</color>")
		else
			self.drawBtnNumTxt:setText(leftCount .. "/" .. maxCount)
		end
	else
		self.findBtn:setVisible(true)
		self.drawBtn:setVisible(false)
		self.orangeFlagPanel:setVisible(true)

		local leftResetTimes = DrawCardUtils.getNewbieLeftResetCount()

		if leftResetTimes > 0 then
			self.btnReset:setVisible(true)
			self.txtResetTimes:setText(string.format(Lang.get(103794), leftResetTimes))
		else
			self.btnReset:setVisible(false)
		end
	end
end

function DrawNewbieOptDlg:_onAnimEnd(animCon, animName)
	if animName == "ShowGotOrder" then
		local record = self.viewRecords[self.curSelectIdx]

		if record then
			self:_setPanelsHeroList(nil, record.item)
			self:_showPanels(true, true)
			self.animInfoPanel:startAni("ShowGotOrder1", true)
		end
	elseif animName == "ShowGotOrder1" then
		local record = self.viewRecords[self.curSelectIdx]

		if record then
			self:_setPanelsHeroList(record.item)
			self:_showPanels(true, true)
			self.animInfoPanel:startAni("HideGotOrder", true)
		end
	elseif animName == "HideGotOrder" then
		self:_showPanels(true, false)

		self.inSelectAnim = nil
	end
end

local function confirmDrawNext()
	DrawCardUtils.realDrawCard(Const.DrawTypeNewbie, 10)
end

function DrawNewbieOptDlg:_onClickDraw(...)
	confirmDrawNext()
end

function DrawNewbieOptDlg:_onClickFindFirst(...)
	local maxScoreIdx = 0
	local maxScore = 0

	for i, record in ipairs(self.viewRecords) do
		if maxScore < record.score then
			maxScoreIdx = i
			maxScore = record.score
		end
	end

	if maxScoreIdx ~= self.curSelectIdx then
		self:onSelectThumb(maxScoreIdx, true)
	end
end

function DrawNewbieOptDlg:onOrangeOnlyClick()
	self.orangeFlag = not self.orangeFlag

	DrawCardUtils.setOrangeOnlyFlag(self.orangeFlag)
	self.orangeFlagImg:setVisible(self.orangeFlag)

	local oldSelectRealIdx

	if self.curSelectIdx and self.viewRecords[self.curSelectIdx] then
		oldSelectRealIdx = self.viewRecords[self.curSelectIdx].index
	end

	self:_readResultData()

	self.curSelectIdx = 0

	if oldSelectRealIdx then
		for i, v in ipairs(self.viewRecords) do
			if v.index == oldSelectRealIdx then
				self.curSelectIdx = i

				break
			end
		end
	end

	if self.curSelectIdx == 0 then
		self.curSelectIdx = 1
	end

	coroutine.start(self._coResetThumb, self)

	local nowRecord = self.viewRecords[self.curSelectIdx]

	self:_setPanelsHeroList(nowRecord.item)
	self:_showPanels(true)
end

function DrawNewbieOptDlg:_coResetThumb()
	self.recordThumbScroll:clearCells()
	coroutine.step()
	self.recordThumbScroll:setTotalCount(#self.viewRecords)
	coroutine.step()
	self.recordThumbScroll:scrollToCell(self.curSelectIdx)
end

local function confirmLastChoose(index)
	if DrawCardUtils.checkBag(10) then
		RPC.drawNewbie(index)
		DrawCardUtils.setNewbieRetrieve()
	end
end

function DrawNewbieOptDlg:_onClickConfirm()
	local curRecord = self.viewRecords[self.curSelectIdx]

	if not curRecord then
		return
	end

	local recordRealIdx = curRecord.index
	local hasNew = DrawCardUtils.hasNewbieCount()
	local noticeId

	noticeId = hasNew and 412 or 411

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(noticeId), Functor(confirmLastChoose, recordRealIdx))
end

function DrawNewbieOptDlg:_onClickClose(...)
	self:setVisible(false)
end

function DrawNewbieOptDlg:_onClickTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_DRAWNEWBIE)
end

function DrawNewbieOptDlg:onClickBtnReset()
	self.drawNewbieResetFunc = self.drawNewbieResetFunc or function()
		RPC.drawNewbieReset()
	end

	UIManager.showConfirmWithId(1137, self.drawNewbieResetFunc)
end

return DrawNewbieOptDlg
