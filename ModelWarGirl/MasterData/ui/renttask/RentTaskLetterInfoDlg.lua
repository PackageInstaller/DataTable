-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTaskLetterInfoDlg.lua

local RentTaskLetterInfoDlg = Class("RentTaskLetterInfoDlg", UIControls.Window)
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local OtherPlayer = require("Common/Object/OtherPlayer")

RentTaskLetterInfoDlg.data = {}

function RentTaskLetterInfoDlg:ctor(...)
	self:initUI()
end

function RentTaskLetterInfoDlg:initUI()
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self._onClickClose)

	self.btnReply = UIControls.Button(self, "Bg/BtnReply")

	self.btnReply:addEventClick(self._onBtnReplayClick)

	self.friendGiftPanel = UIControls.Panel(self, "Bg/FriendGiftPanel")
	self.textNum = UIControls.Label(self, "Bg/FriendGiftPanel/TextNum")
	self.textPlayerName = UIControls.Label(self, "Bg/TextPlayerName")
	self.textServer = UIControls.Label(self, "Bg/TextServer")
	self.gridPlayer = UIControls.PlayerHeadGridChild(self, "Bg/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.iconSex = UIControls.Image(self, "Bg/TextPlayerName/IconSex")
	self.textLetter = UIControls.Label(self, "Bg/TextLetter")
	self.textTile = UIControls.Label(self, "Bg/TextTile")
	self.heroPortrait = UIControls.Role(self, "Bg/GridHeroPortraitPanel/HeroPanel")
	self.imgRelationship = UIControls.Image(self, "Bg/TextPlayerName/ImgRelationship")
	self.imgRelationship2 = UIControls.Image(self, "Bg/TextPlayerName/ImgRelationship2")
	self.letterType = "RECEIVED"
end

function RentTaskLetterInfoDlg:setDealedData(data)
	if not data then
		return
	end

	self.data = data

	self:refresh()
end

function RentTaskLetterInfoDlg:setData(letter)
	if not letter then
		return
	end

	self.data = RentTaskUtils.simpleLetterData(letter)

	self:refresh()
end

function RentTaskLetterInfoDlg:setLetterType(type)
	self.letterType = type
end

function RentTaskLetterInfoDlg:refresh()
	local d = self.data
	local mvpId = d.team.mvpId

	if d.award > 0 then
		self.textNum:setText(d.award or "")
		self.friendGiftPanel:setVisible(true)
	else
		self.friendGiftPanel:setVisible(false)
	end

	local playerName, serverName, commInfo

	if self.letterType == "SELF_SEND" then
		playerName = CurAvatar.name
		serverName = CurAvatar.serverName
		commInfo = CurAvatar:getMyCommInfo()

		RentTaskUtils.setRelationImage(self.imgRelationship, d.uid, true, self.imgRelationship2)
	else
		playerName, serverName = utils.GetPlayerName(d.playerName)
		commInfo = d

		RentTaskUtils.setRelationImage(self.imgRelationship, d.uid)
	end

	self.gridPlayer:setCommInfo(commInfo, false, self)
	self.textPlayerName:setText(playerName or "")
	self.textServer:setText(serverName or "")

	if d.content == "" then
		local letter = RentTaskUtils.getLetterByIndex(d.defaultLetterId, mvpId)

		self.textLetter:setText(letter or "")
	else
		local contentStr = ClientUtils.checkMarkIllegal(d.content or "")

		self.textLetter:setText(contentStr)
	end

	if d.gender == 1 then
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	else
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	end

	local taskName = RentTaskUtils.getTaskTitle(d.taskId)

	self.textTile:setText(taskName or "")

	if mvpId == nil or mvpId == 0 then
		if d.team[1] then
			local firstHero = d.team[1].heroId

			self.heroPortrait:showRole(firstHero)
		end
	else
		self.heroPortrait:showRole(mvpId)
	end
end

function RentTaskLetterInfoDlg:_onBtnReplayClick()
	local replayId = self.data.replayId

	local function yesFunc(...)
		local replayEnv = {}

		replayEnv.replayId = replayId
		replayEnv.letterType = self.letterType

		GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)
		RPC.pVEBattleReplay(replayId, BattleConst.BATTLE_TYPE_RENT)
		RentTaskUtils.storeLastLetterInfo(self.data)
	end

	local msgContent = ClientUtils.getClientNotice(302)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, nil)
end

function RentTaskLetterInfoDlg:_onBtnGridHeroClick(index)
	local d = self.data.team[index]

	if not d then
		return
	end

	local heroId = d.heroId
	local heroTips = UIManager.getUI("heroTips")
	local hero = BaseObject.GetObject(heroId)

	heroTips:showObj(self, hero)
end

function RentTaskLetterInfoDlg:_onClickClose()
	self:setVisible(false)
end

return RentTaskLetterInfoDlg
