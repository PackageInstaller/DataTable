-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterPanel.lua

local ResMasterLevel = require("ClientData.ResMasterLevel")
local ResSignet = require("ClientData/ResSignet")
local EventConst = require("EventConst")
local SignetCell = Class("MasterPanel_SignetCell", UIControls.Panel)

function SignetCell:ctor()
	self.noHavePanel = UIControls.Panel(self, self.mPath .. "/ImgNoContent")
	self.havePanel = UIControls.Panel(self, self.mPath .. "/AchiPanel")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/AchiPanel/Icon")
end

function SignetCell:setData(signetData)
	self.signetData = signetData
	self.signetId = self.signetData and self.signetData.id or nil

	local checkData = self.signetData ~= nil

	self.noHavePanel:setVisible(not checkData)
	self.havePanel:setVisible(checkData)

	if checkData then
		local config = ResSignet[self.signetId]

		if config.big_icon then
			self.imgIcon:setImage("Atlas/CommonAtlas/IconAtlas/" .. config.big_icon_path, config.big_icon)
		end
	end
end

local MasterPanel = Class("MasterPanel", UIControls.Child)

function MasterPanel:ctor()
	self.headCell = UIControls.PlayerHeadGridChild(self, "BgPanel/TeacherInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtName = UIControls.Label(self, "BgPanel/TeacherInfoPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "BgPanel/TeacherInfoPanel/TextPlayerName/IconSex")
	self.txtServer = UIControls.Label(self, "BgPanel/TeacherInfoPanel/TextServer")
	self.imgServer = UIControls.Image(self, "BgPanel/TeacherInfoPanel/TextServer/IconServer")
	self.imgMasterLv = UIControls.Image(self, "BgPanel/TeacherInfoPanel/IconTeacherLv")
	self.txtMasterLv = UIControls.Label(self, "BgPanel/TeacherInfoPanel/IconTeacherLv/TextNum")
	self.txtPower = UIControls.Label(self, "BgPanel/TeacherInfoPanel/PowerPanel/Text")
	self.txtProgress = UIControls.Label(self, "BgPanel/TeacherInfoPanel/DetailPanel/ProgressPanel/Text")
	self.txtFavor = UIControls.Label(self, "BgPanel/TeacherInfoPanel/DetailPanel/VisitPanel/Text")
	self.txtGuild = UIControls.Label(self, "BgPanel/TeacherInfoPanel/DetailPanel/GuildPanel/Text")
	self.txtHelp = UIControls.Label(self, "BgPanel/TeacherInfoPanel/DetailPanel/CaseTaskPanel/Text")
	self.btnChat = UIControls.Button(self, "BgPanel/TeacherInfoPanel/BtnChat")

	self.btnChat:addEventClick(self.onClickBtnChat)

	self.btnBattleGuide = UIControls.Button(self, "BgPanel/TeacherInfoPanel/BtnRequest")

	self.btnBattleGuide:addEventClick(self.onClickBtnBattleGuide)

	self.nmlBattleGuide = UIControls.Panel(self, "BgPanel/TeacherInfoPanel/BtnRequest/NmlPanel")
	self.disBattleGuide = UIControls.Panel(self, "BgPanel/TeacherInfoPanel/BtnRequest/DisPanel")
	self.redBattleGuide = UIControls.RedDot(self, "BgPanel/TeacherInfoPanel/BtnRequest/NmlPanel/IconNew")

	self.redBattleGuide:addHint({
		UIConst.RD_HINT_APPRENTICE_BATTLE_GUIDE
	})

	self.cardHeros = {}

	for i = 1, 5 do
		local newGrid = UIControls.HeroCardChild(self, "BgPanel/CardList/Content", "System/Hero/GridHeroCard")

		newGrid:setVisible(false)

		newGrid.mIndex = i
		newGrid.imgSkinFlag = UIControls.Image(self, "BgPanel/CardList/HeroSkinCornerPanel/Corner" .. i)

		table.insert(self.cardHeros, newGrid)
	end

	self:setHeroCellClickCallBack(Slot(self.onHeroCellClick, self))

	self.slotOnUpdatePlayerInfo = Slot(self.onUpdatePlayerInfo, self)
	self.signetCellList = {}

	for i = 1, 6 do
		local cell = SignetCell(self, "BgPanel/AchievementPanel/GridAchiPanel/GridAchi" .. i)

		table.insert(self.signetCellList, cell)
	end

	EventCenter.addEventListener(EventConst.UPDATE_PLAYER_INFO, self.slotOnUpdatePlayerInfo)
end

function MasterPanel:onDestroy()
	EventCenter.removeEventListener(EventConst.UPDATE_PLAYER_INFO, self.slotOnUpdatePlayerInfo)
end

function MasterPanel:onShow()
	self:refreshShow()
end

function MasterPanel:refreshShow()
	self.otherPlayer = CurAvatar.master

	self.headCell:setPlayer(self.otherPlayer, true, self)
	self.txtName:setText(self.otherPlayer.name)

	if self.otherPlayer.gender == Const.GENDER_MAN then
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.txtServer:setText(self.otherPlayer.serverName or "")

	if self.otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	local lv = self.otherPlayer.masterLv
	local config = ResMasterLevel[math.max(lv, 1)]

	self.imgMasterLv:setImage(config.icon_path, config.icon)
	self.txtMasterLv:setText(string.format(Lang.get(80803), lv))

	self.roleInfo = CurAvatar:applyGetRoleInfo(self.otherPlayer.uid, true)

	if self.roleInfo then
		self:refreshRoleInfo()
	end

	local levelInfo = CurAvatar:getNextMainStageInfo()
	local stage = levelInfo.season * 10000 + levelInfo.chapter * 100 + levelInfo.level

	self.checkBattleGuide = CurAvatar.masterBattleGuideData.stage == stage

	self.nmlBattleGuide:setVisible(self.checkBattleGuide)
	self.disBattleGuide:setVisible(not self.checkBattleGuide)
end

function MasterPanel:refreshRoleInfo()
	self.txtPower:setText(self.roleInfo.power)
	self.txtProgress:setText(self.roleInfo.stage)

	local favorNum = self.roleInfo.houseFavor or 0

	self.txtFavor:setText(favorNum)

	local guildName = self.roleInfo:getGuildName()

	if guildName == nil or guildName == "" then
		guildName = Lang.get(30754)
	end

	self.txtGuild:setText(guildName)

	local helpNum = self.roleInfo.commInfo.help_cnt or 0

	self.txtHelp:setText(helpNum)

	self.heros = {}

	for i, hero in ipairs(self.roleInfo.heros) do
		table.insert(self.heros, hero)
	end

	self:refreshHeroShow(self.heros)
	self:refreshSignetShow(self.roleInfo.signet)
end

function MasterPanel:setHeroCellClickCallBack(callBack)
	for i, cell in ipairs(self.cardHeros) do
		cell:setSelectCallback(callBack)
	end
end

function MasterPanel:refreshHeroShow(heros)
	local count = math.min(#heros, #self.cardHeros)

	for i = 1, count do
		local cell = self.cardHeros[i]

		cell:setHero(heros[i])
		cell:setVisible(true)

		if heros[i]:getSkinQuality() == Const.HERO_SKIN_QUALITY_COLLECTOR then
			cell.imgSkinFlag:setImage("Atlas/HeroAtlas/HeroSkinCornerAtlas", "HeroSkinCornerMvp")
			cell.imgSkinFlag:setVisible(true)
		else
			cell.imgSkinFlag:setVisible(false)
		end
	end

	for i = count + 1, #self.cardHeros do
		self.cardHeros[i]:setVisible(false)
		self.cardHeros[i].imgSkinFlag:setVisible(false)
	end

	if self.checkEmpty then
		self:checkEmpty(count)
	end
end

function MasterPanel:onHeroCellClick(sender)
	local ui = UIManager.getUI("roleInfoHeroDlg")

	ui:setData(self.roleInfo.heros, sender.mIndex, self)
	ui:setPlayerInfo(self.roleInfo)
end

function MasterPanel:refreshSignetShow(signetList)
	for i = 1, #self.signetCellList do
		local cell = self.signetCellList[i]
		local signetData = signetList and signetList[i]

		cell:setData(signetData)
	end
end

function MasterPanel:onClickBtnChat()
	UIManager.getUI("chatDlg", true):addFriendTalk(self.otherPlayer)
end

function MasterPanel:onClickBtnBattleGuide()
	if self.checkBattleGuide then
		local levelInfo = CurAvatar:getNextMainStageInfo()
		local stageInfo = {}

		stageInfo.stageData = {
			levelInfo.season,
			levelInfo.chapter,
			levelInfo.level,
			levelInfo
		}

		local outFormation = {}

		for _, v in pairs(CurAvatar.masterBattleGuideData.formation) do
			outFormation[v.gid] = v.idx
		end

		stageInfo.outFormation = outFormation

		CurAvatar:clearMasterBattleGuideRed()
		CurAvatar:enterFormation(levelInfo.pve_id, BattleConst.BATTLE_TYPE_STAGE, stageInfo)
	else
		MsgManager.clientNotice(788)
	end
end

function MasterPanel:onUpdatePlayerInfo(uid)
	if uid == self.otherPlayer.uid then
		self.roleInfo = CurAvatar:applyGetRoleInfo(self.otherPlayer.uid)

		if self.roleInfo then
			self:refreshRoleInfo()
		end
	end
end

return MasterPanel
