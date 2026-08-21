-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookMainDlg.lua

local strClassName = "HandBookMainDlg"
local ResMonument = require("ClientData/ResMonument")
local HandBookMainDlg = Class(strClassName, UIControls.Window)

function HandBookMainDlg:ctor()
	self:initUI()
end

function HandBookMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnHero = UIControls.Button(self, "MainInfoPanel/ScrollView/Content/BtnHero")

	self.btnHero:addEventClick(self.onBtnHeroClick)

	self.imgBtnHero = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnHero/Content")
	self.imgBtnHeroLock = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnHero/Content/StatePanel")
	self.txtHeroNum = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnHero/Content/TextNum")
	self.txtHero = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnHero/Content/Text1")
	self.btnBadge = UIControls.Button(self, "MainInfoPanel/ScrollView/Content/BtnBadge")

	self.btnBadge:addEventClick(self.onBtnBadgeClick)

	self.imgBtnBadge = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnBadge/Content")
	self.imgBtnBadgeLock = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnBadge/Content/StatePanel")
	self.txtBadge = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnBadge/Content/Text1")
	self.txtBadgeNum = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnBadge/Content/TextNum")
	self.btnStory = UIControls.Button(self, "MainInfoPanel/ScrollView/Content/BtnStory")

	self.btnStory:addEventClick(self.onBtnStoryClick)

	self.imgBtnStory = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnStory/Content")
	self.imgBtnStoryLock = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnStory/Content/StatePanel")
	self.txtStory = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnStory/Content/Text1")
	self.btnHeroShow = UIControls.Button(self, "MainInfoPanel/ScrollView/Content/BtnHeroShow")

	self.btnHeroShow:addEventClick(self.onBtnHeroShowClick)
	self.btnHeroShow:setVisible(CurAvatar:checkRelationRegionPass())

	self.imgBtnHeroShow = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnHeroShow/Content")
	self.imgBtnHeroShowLock = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnHeroShow/Content/StatePanel")
	self.txtHeroShow = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnHeroShow/Content/Text1")
	self.btnTeam = UIControls.Button(self, "MainInfoPanel/ScrollView/Content/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.txtTeam = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnTeam/Content/Text1")
	self.redHintTeam = UIControls.RedDot(self, "MainInfoPanel/ScrollView/Content/BtnTeam/Content/IconNew")

	self.redHintTeam:addHint({
		UIConst.RD_HINT_PROFICIENT
	})

	self.imgTeam = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnTeam/Content")
	self.imgBtnTeamLock = UIControls.Image(self, "MainInfoPanel/ScrollView/Content/BtnTeam/Content/StatePanel")
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnAchievement = UIControls.Button(self, "MainInfoPanel/ScrollView/Content/BtnAchievement")

	self.btnAchievement:addEventClick(self.onClickBtnAchievement)

	self.txtAchievement = UIControls.Label(self, "MainInfoPanel/ScrollView/Content/BtnAchievement/Content/TextNum")
	self.redDotAchievement = UIControls.RedDot(self, "MainInfoPanel/ScrollView/Content/BtnAchievement/Content/IconNew")

	self.redDotAchievement:addHint({
		UIConst.RD_SIGNET
	})

	local handBookRD = UIControls.RedDot(self, "MainInfoPanel/ScrollView/Content/BtnHero/Content/IconNew")

	handBookRD:addHint({
		UIConst.RD_HINT_HANDBOOK_AWARD
	})

	self.redHintPlotRewind = UIControls.RedDot(self, "MainInfoPanel/ScrollView/Content/BtnStory/Content/IconNew")

	self.redHintPlotRewind:addHint({
		UIConst.RD_HINT_PLOTREWIND
	})

	self.redHintRelation = UIControls.RedDot(self, "MainInfoPanel/ScrollView/Content/BtnHeroShow/Content/IconNew")

	self.redHintRelation:addHint({
		UIConst.RD_HINT_RELATION
	})
	self:initBtnStatus()
end

function HandBookMainDlg:initBtnStatus()
	self.txtHeroNum:setText(utils.getTableElemCount(CurAvatar.handBookHeroDic) .. "/" .. #CurAvatar:getHandBookHeroList())
	self.txtBadgeNum:setText(utils.getTableElemCount(CurAvatar.handBookArtifactDic) .. "/" .. #CurAvatar:getHandBookArtifactList())

	self.heroIsLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_HERO)
	self.artifactIsLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_ARTIFACT)
	self.teamIsLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_TEAM)
	self.plotRewindLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_PLOTREWIND)
	self.relationLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_RELATION)

	self.imgBtnHero:setObjGray(self.heroIsLocked)

	local TEXT_COLOR_GRAY = {
		165,
		165,
		165
	}
	local TEXT_COLOR_ORANGE = {
		235,
		177,
		56
	}

	if not self.heroIsLocked then
		self.txtHero:setFontColor(ResColor.WHITE)
		self.txtHeroNum:setColorByRGBA(TEXT_COLOR_ORANGE[1] / 255, TEXT_COLOR_ORANGE[2] / 255, TEXT_COLOR_ORANGE[3] / 255)
	else
		self.txtHeroNum:setColorByRGBA(TEXT_COLOR_GRAY[1] / 255, TEXT_COLOR_GRAY[2] / 255, TEXT_COLOR_GRAY[3] / 255)
		self.txtHero:setColorByRGBA(TEXT_COLOR_GRAY[1] / 255, TEXT_COLOR_GRAY[2] / 255, TEXT_COLOR_GRAY[3] / 255)
	end

	self.imgBtnHeroLock:setVisible(self.heroIsLocked)
	self.imgBtnBadge:setObjGray(self.artifactIsLocked)
	self.imgBtnBadgeLock:setVisible(self.artifactIsLocked)

	if not self.artifactIsLocked then
		self.txtBadgeNum:setColorByRGBA(TEXT_COLOR_ORANGE[1] / 255, TEXT_COLOR_ORANGE[2] / 255, TEXT_COLOR_ORANGE[3] / 255)
		self.txtBadge:setFontColor(ResColor.WHITE)
	else
		self.txtBadgeNum:setColorByRGBA(TEXT_COLOR_GRAY[1] / 255, TEXT_COLOR_GRAY[2] / 255, TEXT_COLOR_GRAY[3] / 255)
		self.txtBadge:setColorByRGBA(TEXT_COLOR_GRAY[1] / 255, TEXT_COLOR_GRAY[2] / 255, TEXT_COLOR_GRAY[3] / 255)
	end

	self.imgBtnStory:setObjGray(self.plotRewindLocked)
	self.imgBtnStoryLock:setVisible(self.plotRewindLocked)

	if not self.plotRewindLocked then
		self.txtStory:setFontColor(ResColor.WHITE)
	else
		self.txtStory:setColorByRGBA(TEXT_COLOR_GRAY[1] / 255, TEXT_COLOR_GRAY[2] / 255, TEXT_COLOR_GRAY[3] / 255)
	end

	self.imgTeam:setObjGray(self.teamIsLocked)
	self.imgBtnTeamLock:setVisible(self.teamIsLocked)

	if not self.teamIsLocked then
		self.txtTeam:setFontColor(ResColor.WHITE)
	else
		self.txtTeam:setColorByRGBA(TEXT_COLOR_GRAY[1] / 255, TEXT_COLOR_GRAY[2] / 255, TEXT_COLOR_GRAY[3] / 255)
	end

	self.imgBtnHeroShow:setObjGray(self.relationLocked)
	self.imgBtnHeroShowLock:setVisible(self.relationLocked)

	if not self.relationLocked then
		self.txtHeroShow:setFontColor(ResColor.WHITE)
	else
		self.txtHeroShow:setColorByRGBA(TEXT_COLOR_GRAY[1] / 255, TEXT_COLOR_GRAY[2] / 255, TEXT_COLOR_GRAY[3] / 255)
	end

	if VersionUtils.IsReviewVersion() and RegionUtils.isJP() then
		self.btnStory:setVisible(false)
	end

	self:refreshBtnAchievement()
end

function HandBookMainDlg:refreshBtnAchievement()
	local checkSignetOpen = CurAvatar:checkSignetOpen()

	self.btnAchievement:setVisible(checkSignetOpen)

	if checkSignetOpen then
		self.txtAchievement:setText(CurAvatar:getCurSignetNum() .. "/" .. CurAvatar:getMaxSignetNum())
	end
end

function HandBookMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HandBookMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK)
end

function HandBookMainDlg:onBtnHeroClick()
	if self.heroIsLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HANDBOOK_HERO))

		return
	end

	UIManager.getUI("handBookHeroListDlg", true)
end

function HandBookMainDlg:onBtnBadgeClick()
	if self.artifactIsLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HANDBOOK_ARTIFACT))

		return
	end

	UIManager.getUI("handBookArtifactDlg", true)
end

function HandBookMainDlg:onBtnRankClick()
	UIManager.getUI("handBookRankSelectDlg", true)
end

function HandBookMainDlg:onBtnStoryClick()
	if self.plotRewindLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HANDBOOK_PLOTREWIND))

		return
	end

	UIManager.getUI("plotRewindDlg", true)
end

function HandBookMainDlg:onBtnHeroShowClick()
	if self.relationLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_RELATION))

		return
	end

	local heroShowRoomMainDlg = UIManager.getUI("heroShowRoomMainDlg", true)
end

function HandBookMainDlg:onBtnTeamClick(...)
	if self.teamIsLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HANDBOOK_TEAM))

		return
	end

	UIManager.getUI("handBookTeamOverviewDlg", true)
end

function HandBookMainDlg:onClickBtnAchievement()
	local ui = UIManager.getUI("signetMainDlg", true)
end

return HandBookMainDlg
