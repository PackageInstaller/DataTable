-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeChooseDlg.lua

local ResMazeConfig = require("ClientData/ResMazeConfig")
local ResMazeInitConfig = require("ClientData/ResMazeInitConfig")
local ResRelics = require("ClientData/ResRelics")
local ResMaze = require("ClientData/ResMaze")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResRandClient = require("ClientData/ResRandClient")
local ResMazeMisc = require("ClientData/ResMazeMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local DIFF_COLOR = {
	"WHITE",
	"ORANGEBTN",
	"RED01"
}
local MazeChoosePanel = Class("MazeChoosePanel", UIControls.Panel)

function MazeChoosePanel:ctor(...)
	self:initUI()
end

function MazeChoosePanel:initUI(...)
	self.btnMaze = UIControls.Button(self, self.mPath, "TextName")

	self.btnMaze:addEventClick(self.onBtnMazeClick)

	self.imgSel = UIControls.Image(self, self.mPath .. "/ImgSel")
	self.txtLevel = UIControls.Label(self, self.mPath .. "/TextLv")
	self.txtOrder = UIControls.Label(self, self.mPath .. "/NumMask/TextNum")
	self.imgHallow = UIControls.Image(self, self.mPath .. "/IconMask/IconHallow")
end

function MazeChoosePanel:setData()
	if self.panelLock then
		self.panelLock:setVisible(false)
	end

	self.mazeData = self.mParent.mazeData
	self.name = self.mazeData.maze_name

	self.btnMaze:setText(self.name)

	self.initData = self.mParent.initData

	self.txtLevel:setText(self.mParent.recommendLevel)

	if self.mazeData.id >= 10 then
		self.txtOrder:setText(self.mazeData.id)
	else
		self.txtOrder:setText("0" .. self.mazeData.id)
	end

	local hallowId = ResMazeInitConfig[self.mazeData.id].relics_id

	if hallowId and ResRelics[hallowId] then
		local data = ResRelics[hallowId]

		self.imgHallow:setImage(data.relic_icon_path or "", data.relic_icon_name or "")
	end
end

function MazeChoosePanel:setSpecailNormal(...)
	self.panelLock = UIControls.Panel(self, self.mPath .. "/ImgLock")
	self.txtTimeDown = UIControls.Label(self, self.mPath .. "/ImgLock/TextTime")
end

function MazeChoosePanel:timeDown(mazzTime)
	ClientTimerManager.AddSecondTickUI(self.txtTimeDown, mazzTime, nil, "", "")
end

function MazeChoosePanel:setSpecialDis(...)
	self.imgMaze = UIControls.Image(self, self.mPath .. "/ImgMazz")

	self.imgMaze:setImageGray(true)
end

function MazeChoosePanel:onBtnMazeClick(...)
	self.mWindow:onBtnMazeClick(self.mParent)
end

function MazeChoosePanel:setSelect(v)
	self.imgSel:setVisible(v)
end

function MazeChoosePanel:setEnable(v)
	self.btnMaze:setEnable(v)
end

local MazeChooseCell = Class("MazeChooseCell", UIControls.Child)

function MazeChooseCell:ctor(...)
	self:initUI()
end

function MazeChooseCell:initUI(...)
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self.onAniFinish)

	self.panelCell = MazeChoosePanel(self, "BtnMazz")

	self.panelCell:setSpecailNormal()

	self.panelCellDis = MazeChoosePanel(self, "BtnMazzDis")

	self.panelCellDis:setSpecialDis()
end

function MazeChooseCell:setData(mazeId, isLimit, desc)
	self.isLimit = isLimit
	self.limitDesc = desc

	local data = ResMazeConfig[mazeId]

	self.mazeId = mazeId

	local layer = #data
	local recordLayer = self.mWindow.mazeRecord[self.mazeId].layer

	self.isClaimed = layer <= recordLayer
	self.mazeData = data[layer]
	self.name = self.mazeData.maze_name
	self.diffIndex = math.min(3, self.mazeData.difficult_flag)
	self.diffDesc = self.mazeData.difficult_desc
	self.initData = ResMazeInitConfig[self.mazeId]
	self.recommendLevel = self.mazeData.recommend_level

	self.panelCell:setData()
	self.panelCellDis:setData()

	if self.initData then
		self.canSweep = self.initData.can_sweep
		self.passedCount = CurAvatar:getMazeNoHurtCount(mazeId)
		self.needPassCount = self.initData.sweep_available_condition
	end
end

function MazeChooseCell:refreshShow(...)
	if self.mWindow.showAniId == self.mazeId then
		self.panelCell:setVisible(true)
		self.panelCellDis:setVisible(true)
	else
		self.panelCell:setVisible(self.isLimit == false)
		self.panelCellDis:setVisible(self.isLimit == true)
	end
end

function MazeChooseCell:timeDown(mazzTime)
	self.panelCell:timeDown(mazzTime)
end

function MazeChooseCell:onBtnMazeClick(...)
	self.mWindow:onBtnMazeClick(self)
end

function MazeChooseCell:setSelect(v)
	self.panelCell:setSelect(v)
	self.panelCellDis:setSelect(v)
end

function MazeChooseCell:startAni(aniName)
	self.panelCell:setVisible(true)
	self.panelCell.panelLock:setVisible(true)
	self.uiAni:startAni(aniName)
end

function MazeChooseCell:onAniFinish(aniCom, aniName)
	if aniName == "UnlockMazzCell" then
		self.panelCellDis:setVisible(false)
	end
end

function MazeChooseCell:setEnable(v)
	self.panelCell:setEnable(v)
	self.panelCellDis:setEnable(v)
end

local strClassName = "MazeChooseDlg"
local ICON_PATH = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local MazeChooseDlg = Class(strClassName, UIControls.Window)

function MazeChooseDlg:ctor(...)
	self:initUI()
end

function MazeChooseDlg:initUI(...)
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnAwardMore = UIControls.Button(self, "MainInfoPanel/MazzInfoPanel/AwardPanel/BgTitle/BtnMore")

	self.btnAwardMore:addEventClick(self.onBtnAwardMoreClick)

	self.txtFitLevel = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/LvPanel/TextLv")
	self.txtName = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/TextName")
	self.txtDesc = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/TextDes")
	self.panelAward = UIControls.Panel(self, "MainInfoPanel/MazzInfoPanel/AwardPanel")
	self.btnFunc = UIControls.Button(self, "MainInfoPanel/MazzInfoPanel/BtnFunc")

	self.btnFunc:addEventClick(self.onBtnFuncClick)

	self.btnSweep = UIControls.Button(self, "MainInfoPanel/MazzInfoPanel/BtnClean")

	self.btnSweep:addEventClick(self.onBtnSweepClick)

	self.btnSweepDis = UIControls.Button(self, "MainInfoPanel/MazzInfoPanel/BtnCleanDis", "TextTips")

	self.btnSweepDis:addEventClick(self.onBtnSweepDisClick)

	self.panelHallow = UIControls.Panel(self, "MainInfoPanel/MazzInfoPanel/HallowPanel")
	self.panelLimit = UIControls.Panel(self, "MainInfoPanel/MazzInfoPanel/LimitPanel")
	self.txtLimit = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/LimitPanel/TextLimit")
	self.txtTimeLimit = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/LimitPanel/TextTime")
	self.imgHallowIcon = UIControls.Image(self, "MainInfoPanel/MazzInfoPanel/HallowPanel/HallowInfoPanel/BgHallow/Icon")
	self.imgHallowIconGroup = UIControls.Image(self, "MainInfoPanel/MazzInfoPanel/HallowPanel/HallowInfoPanel/BgHallow/IconGroup")
	self.txtHallowName = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/HallowPanel/HallowInfoPanel/TextHallowName")
	self.txtHallowEffect = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/HallowPanel/HallowInfoPanel/TextHallowEffect")
	self.scrollView = UIControls.ScrollView(self, "MainInfoPanel/MazzPanel")
	self.txtDifficult = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/AwardPanel/BgAward/TextDifficulty")
	self.imgDifficult = UIControls.Image(self, "MainInfoPanel/MazzInfoPanel/AwardPanel/BgAward/BgDifficulty")

	self.btnFunc:setVisible(false)
	self.panelAward:setVisible(false)
	self.panelHallow:setVisible(false)

	self.panelFinish = UIControls.Panel(self, "MainInfoPanel/MazzInfoPanel/FinishPanel")
	self.txtTimeFinish = UIControls.Label(self, "MainInfoPanel/MazzInfoPanel/FinishPanel/TextTime")
	self.panelRebackBonus = UIControls.Panel(self, "MainInfoPanel/MazzInfoPanel/ReturnUpPanel")
	self.curCell = nil
	self.awardCells = {}
	self.mazeCells = {}
	self.rowCells = {}

	self:clearNodeData()
end

function MazeChooseDlg:show(isNeedAni)
	self.isNeedAni = isNeedAni
	self.curMazeId = CurAvatar.mazeData.maze_id
	self.newMazeId = 1

	self:initCurMazeRecord()

	local totalNum = #ResMazeConfig
	local rowCount = math.ceil(totalNum / 3)

	for i = 1, rowCount do
		local rowCell = self.rowCells[i]

		if rowCell == nil then
			rowCell = UIControls.Child(self, "MainInfoPanel/MazzPanel/Content", "System/Mazz/MazzListRowCell")

			table.insert(self.rowCells, rowCell)
		end

		rowCell:setVisible(true)

		local cellCount = math.min(totalNum - (i - 1) * 3, 3)

		for j = 1, cellCount do
			local mazeId = (i - 1) * 3 + j
			local cell = self.mazeCells[mazeId]
			local isLimit, desc = self:_checkIsOpen(mazeId)

			if not isLimit then
				self.newMazeId = mazeId
			end

			if cell == nil then
				cell = MazeChooseCell(rowCell, "", "System/Mazz/MazzCell")

				table.insert(self.mazeCells, cell)
			end

			cell:setVisible(true)
			cell:setData(mazeId, isLimit, desc)
		end
	end

	self:initCheckId()

	if self:_isNeedShowAni() == true then
		self.showAniId = self.newMazeId
	else
		self.showAniId = -1
	end

	if self.curCell == nil then
		local flag = self.newMazeId + 1
		local row = math.ceil(flag / 3)

		self.scrollView:gotoIndexVertical(row, 477)
		self.mazeCells[self.newMazeId]:onBtnMazeClick()
	else
		self:refreshRightPanel()
	end

	for _, cell in ipairs(self.mazeCells) do
		cell:refreshShow()
	end

	if totalNum <= 6 then
		self.scrollView:cancelScroll()
	end

	if CurAvatar:hasPrivilegeType(Const.PRIVITY_KEY_EBONUS_MAZE) then
		self.panelRebackBonus:setVisible(true)
	else
		self.panelRebackBonus:setVisible(false)
	end

	self:timeDown()

	self.aniTimer = Timer.New(Slot(self.unlockAni, self), 1, 1)

	self.aniTimer:Start()
end

function MazeChooseDlg:_isNeedShowAni(...)
	return self.isNeedAni == true and self.remindId == 1 and self.checkAniId == self.newMazeId
end

function MazeChooseDlg:isNeedShowTime(...)
	return self.isNeedAni == true
end

function MazeChooseDlg:timeDown(...)
	if self:isNeedShowTime() == false then
		return
	end

	local mazzTime = CurAvatar:getMazeLeftTime()
	local cell = self.mazeCells[self.newMazeId]

	if cell then
		cell:timeDown(mazzTime)
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTimeFinish)
	ClientTimerManager.RemoveSecondTickUI(self.txtTimeLimit)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTimeFinish, mazzTime, nil, Lang.get(30590))
	ClientTimerManager.AddSecondFormatTickUI(self.txtTimeLimit, mazzTime, nil, Lang.get(48675))
end

function MazeChooseDlg:_checkIsOpen(mazeId)
	local isLimit = false
	local desc = ""
	local data = ResMazeInitConfig[mazeId]
	local preRecord = self.mazeRecord[data.pre_maze_id]

	if data.pre_maze_id ~= nil and preRecord.passed == false then
		isLimit = true
		desc = string.format(Lang.get(30569), ResMazeConfig[data.pre_maze_id][1].maze_name)
	end

	if ConditionLimitManager.inLimitState(data.condition_id) then
		isLimit = true
		desc = desc .. "\n" .. ResConditionLimit[data.condition_id].unlock_desc
	end

	return isLimit, desc
end

function MazeChooseDlg:initCurMazeRecord(...)
	self.mazeRecord = {}

	local recordInfo

	for id, mazeInfo in ipairs(ResMazeConfig) do
		recordInfo = nil

		for i, data in ipairs(CurAvatar.mazeData.pass_record) do
			if data.maze_id == id then
				recordInfo = data

				break
			end
		end

		local info = {}

		info.mazeId = id

		if recordInfo == nil then
			info.layer = 0
			info.passed = false
		else
			info.layer = recordInfo.max_layer
			info.passed = #mazeInfo <= recordInfo.max_layer
		end

		self.mazeRecord[id] = info
	end
end

function MazeChooseDlg:clearNodeData(...)
	UserData.saveCommonData(CurAvatar.uid .. Const.MAZE_CHALLENGED_NODE, "")
end

function MazeChooseDlg:initCheckId(...)
	if self.checkAniId == nil then
		local id, remindId = CurAvatar:getMazeCheckOpenInfo()

		id = math.min(math.max(id, self.newMazeId), #ResMazeConfig)
		self.checkAniId = id

		if remindId == 0 and self:_checkIsOpen(id) == false then
			remindId = 1
		end

		self.remindId = remindId

		CurAvatar:saveMazeCheckOpenInfo(id, remindId)
	end
end

function MazeChooseDlg:initHallow(mazeId)
	local hallowId = ResMazeInitConfig[mazeId].relics_id

	if hallowId and ResRelics[hallowId] then
		self.panelHallow:setVisible(true)

		local data = ResRelics[hallowId]

		self.imgHallowIcon:setImage(data.relic_icon_path or "", data.relic_icon_name or "")

		if data.camp_id then
			self.imgHallowIconGroup:setImage(ICON_PATH, "IconGroup0" .. data.camp_id)
			self.imgHallowIconGroup:setVisible(true)
		else
			self.imgHallowIconGroup:setVisible(false)
		end

		self.txtHallowName:setText(data.name)
		self.txtHallowEffect:setText(data.dec)
	end
end

function MazeChooseDlg:initAward(mazeId)
	self.panelAward:setVisible(true)

	local id = self.curCell.mazeData.pass_award

	id = tonumber(id)

	local bonus = ResRandClient[id] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	self.imgDifficult:setImage("Atlas/MazeAtlas/MazeAtlas", "BgDifficulty" .. self.curCell.diffIndex)
	self.txtDifficult:setFontColor(ResColor[DIFF_COLOR[self.curCell.diffIndex]])
	self.txtDifficult:setText(self.curCell.diffDesc)

	for i = 1, #showNums do
		local cell = self.awardCells[i]

		if cell then
			-- block empty
		else
			cell = UIControls.getGridAwardContainer(self, "MainInfoPanel/MazzInfoPanel/AwardPanel/BgAward/GridPanel")

			table.insert(self.awardCells, cell)
		end

		if showIds[i] then
			local clientItem = BaseObject.GetObject(showIds[i], showNums[i])

			cell:setObj(clientItem)
			cell:setVisible(true)

			cell.grid.mDisableWays = true

			cell:setState(false, self.curCell.isClaimed, true)
		end
	end

	for i = #showNums + 1, #self.awardCells do
		self.awardCells[i]:setVisible(false)
	end
end

function MazeChooseDlg:initLimitPanel(...)
	if self:isNeedShowTime() == true then
		local compareId = self.newMazeId

		if self.showAniId ~= -1 then
			compareId = self.showAniId
		end

		if compareId == self.curCell.mazeId then
			if self.showAniId == -1 then
				self.panelFinish:setVisible(true)
				self.panelLimit:setVisible(false)
			else
				self.panelLimit:setVisible(true)
				self.panelFinish:setVisible(false)
				self.panelFinish:setVisible(false)
				self.txtLimit:setText(Lang.get(1471))
				self.txtTimeLimit:setVisible(true)
			end
		elseif compareId < self.curCell.mazeId then
			if self.curCell.isLimit then
				self.panelLimit:setVisible(true)
				self.panelFinish:setVisible(false)
				self.txtLimit:setText(self.curCell.limitDesc)
				self.txtTimeLimit:setVisible(false)
			else
				self.panelLimit:setVisible(false)
			end
		else
			self.panelFinish:setVisible(true)
			self.panelLimit:setVisible(false)
		end
	else
		self.panelFinish:setVisible(false)

		if self.curCell.isLimit then
			self.panelLimit:setVisible(true)
			self.txtLimit:setText(self.curCell.limitDesc)
			self.txtTimeLimit:setVisible(false)
		else
			self.panelLimit:setVisible(false)
		end
	end
end

function MazeChooseDlg:refreshRightPanel(...)
	local id = self.curCell.mazeId

	self:initAward(id)
	self:initHallow(id)
	self:initLimitPanel()
	self.txtDesc:setText(self.curCell.mazeData.maze_desc)
	self.txtName:setText(self.curCell.name)
	self.txtFitLevel:setText(self.curCell.recommendLevel)
	self.btnFunc:setVisible(CurAvatar.needResetMaze and not self.curCell.isLimit)

	if CurAvatar.needResetMaze and not self.curCell.isLimit and self.curCell.canSweep then
		if self.curCell.passedCount >= self.curCell.needPassCount then
			self.btnSweep:setVisible(true)
			self.btnSweepDis:setVisible(false)
		else
			self.btnSweep:setVisible(false)
			self.btnSweepDis:setVisible(true)
			self.btnSweepDis:setText(string.format(Lang.get(70771), self.curCell.passedCount .. "/" .. self.curCell.needPassCount))
		end
	else
		self.btnSweepDis:setVisible(false)
		self.btnSweep:setVisible(false)
	end
end

function MazeChooseDlg:unlockAni(...)
	if self.showAniId == self.newMazeId then
		self.mazeCells[self.newMazeId]:startAni("UnlockMazzCell")
	end
end

function MazeChooseDlg:onBtnAwardMoreClick(...)
	UIManager.getUI("mazeAwardCheckDlg", true):show(self.mazeRecord[self.curCell.mazeId])
end

function MazeChooseDlg:onBtnCloseClick(...)
	self:setVisible(false)

	if GameFsm.isInState(Const.STATE_BATTLE) then
		GameFsm.getCurState():exitBattle(false)
	elseif GameFsm.isInState(Const.STATE_MAIN_MAZE) then
		GameFsm.translateState(Const.STATE_MAIN_STAGE)
	end
end

function MazeChooseDlg:destroy(...)
	MazeChooseDlg.super.destroy(self)

	if self.aniTimer then
		self.aniTimer:Stop()
	end
end

function MazeChooseDlg:onBtnMazeClick(sender)
	if self.curCell ~= nil then
		self.curCell:setEnable(true)
		self.curCell:setSelect(false)
	end

	self.curCell = sender

	self.curCell:setEnable(false)
	self.curCell:setSelect(true)
	self:refreshRightPanel()
end

function MazeChooseDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_MAZE)
end

function MazeChooseDlg:onBtnFuncClick(...)
	if self.curCell then
		local function yesFunc(...)
			if self.curCell.canSweep and self.curCell.passedCount >= self.curCell.needPassCount then
				UIManager.showConfirmWithId(1080, Functor(self._realSelMaze, self))
			else
				self:_realSelMaze()
			end
		end

		if self.curCell.mazeId ~= self.newMazeId then
			local msgContent = ClientUtils.getClientNotice(295)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, nil)
		else
			yesFunc()
		end
	end
end

function MazeChooseDlg:_realSelMaze()
	RPC.mazeSelect(self.curCell.mazeId)
	self:setVisible(false)
	CurAvatar:saveMazeCheckOpenInfo(self.checkAniId, 2)
end

function MazeChooseDlg:onBtnSweepClick()
	if self.curCell and self.curCell.passedCount >= self.curCell.needPassCount then
		RPC.mazeSweep(self.curCell.mazeId)
	end
end

function MazeChooseDlg:onBtnSweepDisClick()
	if self.curCell then
		MsgManager.clientNotice(673)
	end
end

return MazeChooseDlg
