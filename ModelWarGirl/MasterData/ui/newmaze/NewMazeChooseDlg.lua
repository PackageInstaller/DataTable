-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeChooseDlg.lua

local NewMazeBaseFunc = require("UI/NewMaze/NewMazeBaseFunc")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "RogueBoxCell"
local RogueBoxCell = Class(strClassName, UIControls.Child)

function RogueBoxCell:ctor()
	self:initUI()
end

function RogueBoxCell:initUI()
	self.btnRogue = UIControls.Button(self, "BtnRogue")

	self.btnRogue:addEventClick(self.onBtnRogueClick)

	self.bgBox = UIControls.Image(self, "BtnRogue/BgBox")
	self.imgRogue = UIControls.Image(self, "BtnRogue/ImgRogue")
	self.textName = UIControls.Label(self, "BtnRogue/TextName")
	self.iconLevel = UIControls.Image(self, "BtnRogue/TextName/IconLevel")
	self.textLvNum = UIControls.Label(self, "BtnRogue/BgTextLv/TextLvNum")
	self.textNum = UIControls.Label(self, "BtnRogue/NumMask/TextNum")
	self.textTheme = UIControls.Image(self, "BtnRogue/TextTheme")
	self.onGoingPanel = UIControls.Panel(self, "BtnRogue/OnGoingPanel")
	self.lockPanel = UIControls.Panel(self, "BtnRogue/LockPanel")
	self.finishPanel = UIControls.Panel(self, "BtnRogue/FinishPanel")
	self.textLayerNum = UIControls.Label(self, "BtnRogue/OnGoingPanel/BgTopLayer/TextLayerNum")
	self.textRule = UIControls.Label(self, "BtnRogue/LockPanel/TextRule")
	self.aniSelf = UIControls.UIAni(self, "")
	self.bgLevel = UIControls.Image(self, "BtnRogue/BgLevel")
	self.iconLevel = UIControls.Image(self, "BtnRogue/TextName/IconLevel")
	self.bgTop = UIControls.Image(self, "BtnRogue/BgTop")
	self.bgBottom = UIControls.RawImage(self, "BtnRogue/BgBottom")
	self.bgGoingThemeDec = UIControls.Image(self, "BtnRogue/OnGoingPanel/BgTopLayer/BgThemeDec")
	self.bgLockThemeDec = UIControls.Image(self, "BtnRogue/LockPanel/BgTopLayer/BgThemeDec")
	self.bgFinishThemeDec = UIControls.Image(self, "BtnRogue/FinishPanel/BgTopLayer/BgThemeDec")
end

function RogueBoxCell:setData(data, index)
	self.boxData = data
	self.index = index

	self.bgBox:setImage("Atlas/MazeAtlas/MazeAtlas", "BgMazeBox")
	self.onGoingPanel:setVisible(self.mParent.ratingLevel == data.level)
	self.finishPanel:setVisible(self.mParent.ratingLevel > data.level)
	self.lockPanel:setVisible(self.mParent.ratingLevel < data.level)
	self.textName:setText(data.level_name)

	local upScore = self.mParent.tableHeroCount * self.boxData.score_upper
	local lowScore = self.mParent.tableHeroCount * self.boxData.score_lower + 1

	self.boxData.upScore = upScore
	self.boxData.lowScore = lowScore

	self.textLvNum:setText(lowScore .. "-" .. upScore)

	if data.level >= 10 then
		self.textNum:setText(data.level)
	else
		self.textNum:setText("0" .. data.level)
	end

	self.bgTop:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgThemeTop0" .. self.boxData.level_subject_type)
	self.bgBottom:setImage("NoAlpha/Rogue/BgBoxDec0" .. self.boxData.level_subject_type)
	self.bgLevel:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgDec0" .. self.boxData.difficulty_level + 4)
	self.imgRogue:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgTheme0" .. self.boxData.level_subject_type)
	self.textTheme:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "TxtChallenge0" .. self.boxData.level_subject_type)
	self.iconLevel:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgDec0" .. self.boxData.difficulty_level)
	self.bgGoingThemeDec:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgThemeDec0" .. self.boxData.level_subject_type)
	self.bgLockThemeDec:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgThemeDec0" .. self.boxData.level_subject_type)
	self.bgFinishThemeDec:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgThemeDec0" .. self.boxData.level_subject_type)

	if self.mParent.ratingLevel == data.level then
		if self.mParent.ratingLevel == self.mParent.newMazeData.seasonBestGradeLevel then
			self.textLayerNum:setText(self.mParent.newMazeData.seasonBestGradeLayer)
		elseif self.mParent.ratingLevel > self.mParent.newMazeData.seasonBestGradeLevel then
			self.textLayerNum:setText(0)
		else
			self.textLayerNum:setText(Lang.get(724))
		end
	end

	if self.mParent.ratingLevel < data.level then
		self.textRule:setText(ResNewMazeDisplay[13060006].desc)
	end
end

function RogueBoxCell:onBtnRogueClick()
	self.mParent:onCellClick(self)
end

function RogueBoxCell:playBoxChooseAni()
	self.aniSelf:startAni("ShowRogueBox")
end

function RogueBoxCell:playBoxUnLockAni()
	self.aniSelf:startAni("UnlockRogueBox")
end

local OPEN_DETAIL_TIME = 0.2
local strClassName = "NewMazeChooseDlg"
local NewMazeChooseDlg = Class(strClassName, NewMazeBaseFunc)

MixinClass(NewMazeChooseDlg, ActivityPanelMixin)

function NewMazeChooseDlg:ctor(...)
	self:initUI()
end

function NewMazeChooseDlg:initUI()
	NewMazeChooseDlg.super.initUI(self)

	self.chooseList = UIControls.ScrollView(self, "MainInfoPanel/ChooseList")
	self.btnHeroUnique = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnHeroUnique")

	self.btnHeroUnique:addEventClick(self.onBtnHeroUniqueClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self.onAniFinish)

	self.scrollPage = UIControls.ScrollView(self, "MainInfoPanel/ChooseListMask/ChooseList")

	self.scrollPage:addScrollCorrectOnChanged(self.onCorrectEvent)

	self.emptyPanel = UIControls.Panel(self, "EmptyPanel")
	self.cellList = {}
	self.iconHero = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnHeroUnique/Mask/IconHero")
	self.btnTalent = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnSkill")

	self.btnTalent:addEventClick(self.onTalentClick)

	self.iconNewTalent = UIControls.Panel(self, "MainInfoPanel/FuncPanel/BtnSkill/IconNew")
end

function NewMazeChooseDlg:_setData(needPlayUnLockAni)
	if not self.actObj then
		self.actObj = CurAvatar:getNewMazeActivity()
	end

	self.newMazeData = self.actObj.actData

	NewMazeChooseDlg.super.setData(self)

	self.achieveActId = self.actObj.actData.miscData.relate_achieve_id

	CurAvatar:addActivityRelated(self.achieveActId, "newMazeChooseDlg", self.actObj.actId)

	self.ratingLevel = self.newMazeData.ratingLevel or 0
	self.tableHeroCount = self.newMazeData:getAllTableHeroCount()
	self.allLevelData = {}

	for i, v in ipairs(self.newMazeData.levelMiscData) do
		table.insert(self.allLevelData, v)
	end

	self.bestGradeLayer = self.newMazeData.bestGradeLayer

	for i, data in ipairs(self.allLevelData or {}) do
		local cell = self.cellList[i]

		if cell == nil then
			cell = RogueBoxCell(self, "MainInfoPanel/ChooseListMask/ChooseList/Content", "System/Rogue/RogueBoxCell", 0, 0, true)
		end

		cell:setData(data, i)

		self.cellList[i] = cell

		if data.level == self.ratingLevel then
			self.curChooseBoxIndex = i
		end
	end

	self.scrollPage:scrollToCorrectPage(self.curChooseBoxIndex)

	if needPlayUnLockAni then
		self.cellList[self.curChooseBoxIndex]:playBoxUnLockAni()
	end

	local hero = BaseObject.GetObject(self.newMazeData.heroId)
	local iconPath = hero:getIconPath(true)

	if iconPath then
		self.iconHero:setImage(iconPath[1], iconPath[2])
	end

	if self.newMazeData.inheritHeroPoolFlag then
		local settleType

		if self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleOver then
			settleType = Const.NEW_MAZE_SETTLEMENT_TYPE.Over
		elseif self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleReset then
			settleType = Const.NEW_MAZE_SETTLEMENT_TYPE.Reset
		elseif self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleNext then
			settleType = Const.NEW_MAZE_SETTLEMENT_TYPE.Next
		end

		if settleType then
			local newMazeInheritDlg = UIManager.getUI("newMazeInheritDlg", true)

			newMazeInheritDlg:setData(Const.PUT_IN_INHERIT_POOL, settleType, true)
		end
	end

	self:refreshTalentUI()
end

function NewMazeChooseDlg:refreshTalentUI()
	if self.newMazeData:isTalentUnlock() then
		self.btnTalent:setVisible(true)

		if self.newMazeData:checkTalentEnable() then
			self.iconNewTalent:setVisible(true)
		else
			self.iconNewTalent:setVisible(false)
		end
	else
		self.btnTalent:setVisible(false)
	end
end

function NewMazeChooseDlg:_onShow()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	NewMazeChooseDlg.super.setFuncTime(self)
end

function NewMazeChooseDlg:_chooseCell(sender)
	if sender.index ~= self.curChooseBoxIndex then
		self.scrollPage:scrollToCorrectPage(sender.index)

		self.curChooseBoxIndex = sender.index
		self.openDetailTimer = Timer.New(Functor(self.openDeatilDlg, self, sender.boxData), OPEN_DETAIL_TIME, 1)

		self.openDetailTimer:Start()
	else
		self:openDeatilDlg(sender.boxData)
	end
end

function NewMazeChooseDlg:onCellClick(sender)
	if self.newMazeData:checkTalentEnable() then
		local notice = Lang.get(102262)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), notice, Functor(self._chooseCell, self, sender))
	else
		self:_chooseCell(sender)
	end
end

function NewMazeChooseDlg:openDeatilDlg(boxData)
	if self.openDetailTimer then
		self.openDetailTimer:Stop()

		self.openDetailTimer = nil
	end

	local boxDetailDlg = UIManager.getUI("newMazeBoxDetailDlg", true)

	boxDetailDlg:setData(boxData)
end

function NewMazeChooseDlg:onCorrectEvent(sender, currentPageIndex)
	self.curChooseBoxIndex = currentPageIndex
end

function NewMazeChooseDlg:playChooseAni()
	self.aniSelf:startAni("ShowRogueChooseCanvas")
	self.emptyPanel:setVisible(true)

	if self.curChooseBoxIndex and self.cellList[self.curChooseBoxIndex] then
		self.cellList[self.curChooseBoxIndex]:playBoxChooseAni()
	end
end

function NewMazeChooseDlg:onAniFinish(aniCom, aniName)
	if aniName == "ShowRogueChooseCanvas" then
		self.emptyPanel:setVisible(false)

		local mainDlg = UIManager.getUI("newMazeMainDlg", true)

		mainDlg:setData(true)
	end
end

function NewMazeChooseDlg:onBtnHeroUniqueClick()
	UIManager.getUI("newMazeUpHeroDlg", true):setData()
end

function NewMazeChooseDlg:onBtnCloseClick()
	self:setVisible(false)
end

function NewMazeChooseDlg:onTalentClick()
	UIManager.getUI("newMazeTalentMainDlg", true):onShow(self.actObj)
end

return NewMazeChooseDlg
