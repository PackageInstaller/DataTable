-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeBoxDetailDlg.lua

local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResColor = require("ClientData/ResColor")
local ResNewMazeInherit = require("ClientData/ResNewMazeInherit")
local strClassName = "NewMazeBoxDetailDlg"
local NewMazeBoxDetailDlg = Class(strClassName, UIControls.Window)

function NewMazeBoxDetailDlg:ctor(...)
	self:initUI()
end

function NewMazeBoxDetailDlg:initUI()
	self.bgBox = UIControls.Image(self, "BgPanel/BgBox")
	self.imgRogue = UIControls.Image(self, "BgPanel/ImgRogue")
	self.textName = UIControls.Label(self, "BgPanel/TextName")
	self.iconLevel = UIControls.Image(self, "BgPanel/TextName/IconLevel")
	self.textNum = UIControls.Label(self, "BgPanel/NumMask/TextNum")
	self.textTheme = UIControls.Image(self, "BgPanel/TextTheme")
	self.textDes = UIControls.Label(self, "BgPanel/DesPanel/TextContentList/Content/TextDes")
	self.panelContentList = UIControls.Panel(self, "BgPanel/DesPanel/TextContentList")
	self.scrollContentList = UIControls.ScrollView(self, "BgPanel/DesPanel/TextContentList")

	self.scrollContentList:addEventValueChanged(self.onScrollValueChanged)

	self.arrowNext = UIControls.Panel(self, "BgPanel/DesPanel/ArrowNext")
	self.textLvNum = UIControls.Label(self, "BgPanel/BgTextLv/TextLvNum")
	self.textLayerNum = UIControls.Label(self, "BgPanel/BgTopLayer/TextLayerNum")
	self.btnChallenge = UIControls.Button(self, "BgPanel/BtnChallenge")

	self.btnChallenge:addEventClick(self.onBtnChallengeClick)

	self.lockPanel = UIControls.Panel(self, "BgPanel/LockPanel")
	self.finishPanel = UIControls.Panel(self, "BgPanel/FinishPanel")
	self.bgTopLayer = UIControls.Panel(self, "BgPanel/BgTopLayer")
	self.textLockRule = UIControls.Label(self, "BgPanel/LockPanel/TextRule")
	self.iconStar = UIControls.Image(self, "BgPanel/BgMiniStar/IconStar")
	self.cellGrids = {}
	self.btnInherit = UIControls.Button(self, "BgPanel/BtnInherit")

	self.btnInherit:addEventClick(self.onBtnInheritClick)

	self.iconInheritNew = UIControls.Image(self, "BgPanel/BtnInherit/IconNew")
end

function NewMazeBoxDetailDlg:setData(boxData)
	self.boxData = boxData
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	self.level = self.newMazeData.ratingLevel

	self.btnInherit:setVisible(Const.NEW_MAZE_ITERATION_OPEN == true and self.level == self.boxData.level)

	self.bestGradeLayer = self.level == self.newMazeData.seasonBestGradeLevel and self.newMazeData.seasonBestGradeLayer or 0
	self.tickets = self.newMazeData.tickets

	self.textLockRule:setText(ResNewMazeDisplay[13060006].desc)
	self.bgBox:setImage("Atlas/MazeAtlas/MazeAtlas", "BgMazeBox")
	self.btnChallenge:setVisible(self.level == self.boxData.level)
	self.finishPanel:setVisible(self.level > self.boxData.level)
	self.lockPanel:setVisible(self.level < self.boxData.level)
	self.textName:setText(self.boxData.level_name)
	self.textLvNum:setText(self.boxData.lowScore .. "-" .. self.boxData.upScore)

	local myScore = CurAvatar:getTotalProficient()

	if myScore < self.boxData.lowScore then
		self.textLvNum:setFontColor(ResColor.RED01)
	elseif myScore >= self.boxData.lowScore and myScore <= self.boxData.upScore then
		self.textLvNum:setFontColor(ResColor.ORANGE)
	else
		self.textLvNum:setFontColor(ResColor.GREEN)
	end

	self.textDes:setText(self.boxData.level_description)

	if self.textDes:getHeight() > self.panelContentList:getRectSize().height then
		self.arrowNext:setVisible(true)

		self.isScroll = true
	end

	self.imgRogue:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgTheme0" .. self.boxData.level_subject_type)
	self.textTheme:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "TxtChallenge0" .. self.boxData.level_subject_type)
	self.iconLevel:setImage("Atlas/RogueAtlas/RougeChooseAtlas", "BgDec0" .. self.boxData.difficulty_level)

	local iconStarName

	if self.boxData.guarantee_star < 10 then
		iconStarName = "IconStar0" .. self.boxData.guarantee_star
	else
		iconStarName = "IconStar" .. self.boxData.guarantee_star
	end

	self.iconStar:setImage("Atlas/HeroAtlas/HeroCardCommonAtlas", iconStarName)

	if self.boxData.level >= 10 then
		self.textNum:setText(self.boxData.level)
	else
		self.textNum:setText("0" .. self.boxData.level)
	end

	if self.level == self.boxData.level then
		if self.level == self.newMazeData.seasonBestGradeLevel then
			self.textLayerNum:setText(self.bestGradeLayer)
		elseif self.level > self.newMazeData.seasonBestGradeLevel then
			self.textLayerNum:setText(0)
		else
			self.textLayerNum:setText(Lang.get(724))
		end

		self.bgTopLayer:setVisible(true)
	else
		self.bgTopLayer:setVisible(false)
	end

	ClientUtils.CreateBonusGrid(self, self.cellGrids, "BgPanel/AwardPanel/BgAward/GridPanel", self.boxData.first_pass_award_id, true, nil, true)

	local hasGotFirstPassAward = self.newMazeData.hasGotFirstPassAward
	local hasGot = hasGotFirstPassAward[self.boxData.level] ~= nil

	if hasGot then
		for index, grid in ipairs(self.cellGrids) do
			grid:setGet(true)
		end
	end

	self:refreshInheritIconNew()
end

function NewMazeBoxDetailDlg:refreshInheritIconNew()
	self.inheritPoolCardList = self.newMazeData:getInheritPoolHeros()
	self.maxInheritHeroNum = ResNewMazeInherit[Const.NEW_MAZE_INHERIT_TYPE_HERO][self.newMazeData.cycle].select_num

	self.iconInheritNew:setVisible(#self.newMazeData.inheritSelHeros < self.maxInheritHeroNum and #self.inheritPoolCardList > #self.newMazeData.inheritSelHeros)
end

function NewMazeBoxDetailDlg:onScrollValueChanged()
	if not self.isScroll then
		return
	end

	local barValue = self.scrollContentList:getVerticalValue()

	if barValue == self.oldBarValue then
		return
	end

	self.oldBarValue = barValue

	if barValue == 0 then
		self.arrowNext:setVisible(false)
	else
		self.arrowNext:setVisible(true)
	end
end

function NewMazeBoxDetailDlg:onBtnChallengeClick()
	if self.actObj and self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if self.tickets < 1 then
		MsgManager.notice(ResNewMazeDisplay[13060005].desc)

		return
	end

	if #self.newMazeData.inheritSelHeros < self.maxInheritHeroNum and #self.inheritPoolCardList > #self.newMazeData.inheritSelHeros then
		local msg = Lang.get(76037)
		local yesTxt = Lang.get(76039)
		local noTxt = Lang.get(76038)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msg, Slot(self.onBtnInheritClick, self), Slot(self.realChallenge, self), nil, yesTxt, noTxt)
	else
		self:realChallenge()
	end
end

function NewMazeBoxDetailDlg:realChallenge()
	if self.newMazeData.layer == 0 then
		self:sendInheritRPC()
		RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.Init)
	elseif self.newMazeData.layer == -1 then
		self:sendInheritRPC()
		RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.NextReset)
	elseif self.newMazeData.redheart <= 0 then
		self:sendInheritRPC()
		RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.FailReset)
	else
		local mainDlg = UIManager.getUI("newMazeMainDlg", true)

		mainDlg:setData(true)
	end

	self:setVisible(false)
end

function NewMazeBoxDetailDlg:sendInheritRPC()
	if Const.NEW_MAZE_ITERATION_OPEN and self.newMazeData.inheritSelHerosFlag then
		local itemList = {}

		for i, hero in ipairs(self.newMazeData.inheritSelHeros or {}) do
			table.insert(itemList, hero.hero_id)
		end

		RPC.newMazeSelectInherit(self.actObj.opId, Const.NEW_MAZE_INHERIT_TYPE.Hero, itemList)
	end
end

function NewMazeBoxDetailDlg:onBtnInheritClick()
	local newMazeInheritDlg = UIManager.getUI("newMazeInheritDlg", true)

	newMazeInheritDlg:openFromManual()
	newMazeInheritDlg:setData(Const.TAKE_FROM_INHERIT_POOL)
end

return NewMazeBoxDetailDlg
