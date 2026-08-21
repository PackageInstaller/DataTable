-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpBpMainDlg.lua

local ResBPPvpBPRound = require("ClientData/ResBPPvpBPRound")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local ResBPPvpRoomTimer = require("ClientData/ResBPPvpRoomTimer")
local TopPvpBpHeroIconCell = require("UI/PVPMode/TopPVP/TopPvpBpHeroIconCell")
local CommonBulletSendPanel = require("UI/PVPMode/TopPVP/CommonBulletSendPanel")
local TopPvpBpHeroCell = Class("TopPvpBpHeroCell", UIControls.Child)

function TopPvpBpHeroCell:ctor()
	self:initUI()
end

function TopPvpBpHeroCell:initUI()
	self.imgHeroIcon = TopPvpBpHeroIconCell(self, "HeroPanel/GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")
	self.btnHeroPanel = UIControls.Button(self, "HeroPanel")

	self.btnHeroPanel:addEventClick(self.onBtnHeroPanelClick)

	self.imgPicked = UIControls.Image(self, "HeroPanel/ImgPicked")
	self.imgBanned = UIControls.Image(self, "HeroPanel/ImgBanned")
	self.imgPick = UIControls.Image(self, "HeroPanel/ImgPick")
	self.imgBan = UIControls.Image(self, "HeroPanel/ImgBan")
	self.dis = UIControls.Image(self, "HeroPanel/Dis")
	self.efxBanPanel = UIControls.LazyEffectPlayer(self, "HeroPanel/EfxBanPanel")
end

function TopPvpBpHeroCell:setData(data)
	self.hero = BaseObject.GetObject(data.hero_id)

	if not self.hero then
		-- block empty
	end

	self.imgHeroIcon:setHero(self.hero)
end

function TopPvpBpHeroCell:setVis(vis)
	self.imgHeroIcon:setVisible(vis)
	self.btnHeroPanel:setVisible(vis)
end

function TopPvpBpHeroCell:setState(state, dis, click)
	self.imgPick:setVisible(false)
	self.imgBan:setVisible(false)

	if type(state) == "number" and state <= 0 then
		state = -state
	end

	if type(state) == "number" then
		if state >= 101 and state <= 105 then
			self.imgPicked:setVisible(false)
			self.imgBanned:setVisible(true)
		elseif state >= 201 and state <= 205 then
			self.imgPicked:setVisible(true)
			self.imgBanned:setVisible(false)
		else
			self.imgPicked:setVisible(false)
			self.imgBanned:setVisible(false)
		end
	else
		self.imgPicked:setVisible(false)
		self.imgBanned:setVisible(false)
	end

	if dis == true then
		self.dis:setVisible(true)
	else
		self.dis:setVisible(false)
	end

	if click == true then
		self.btnHeroPanel:setEnable(true)
	else
		self.btnHeroPanel:setEnable(false)
	end
end

function TopPvpBpHeroCell:setSelected(state, mode)
	if state == false then
		self.imgBan:setVisible(false)
		self.imgPick:setVisible(false)
	elseif mode == 1 then
		self.imgBan:setVisible(true)
		self.imgPick:setVisible(false)
	else
		self.imgPick:setVisible(true)
		self.imgBan:setVisible(false)
	end
end

function TopPvpBpHeroCell:onBtnHeroPanelClick(sender)
	if self.selectCallback then
		self.selectCallback(self)
	end
end

function TopPvpBpHeroCell:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

local TopPvpBpBanPanelCell = Class("TopPvpBpBanPanelCell", UIControls.Child)

function TopPvpBpBanPanelCell:ctor()
	self:initUI()
end

function TopPvpBpBanPanelCell:initUI()
	self.txtTips = UIControls.Label(self, "BanPanel/TextTitle")
	self.panel = UIControls.Panel(self, "")
	self.banCells = {}

	for i = 1, 3 do
		local newCell = TopPvpBpHeroCell(self, "BanPanel/ListHero", "System/TopPVP/TopPVPBPHeroCell")

		newCell:setVisible(true)
		table.insert(self.banCells, newCell)
	end

	self.aniInfo = UIControls.UIAni(self, "")
end

function TopPvpBpBanPanelCell:setData(heros)
	if #heros == 0 then
		self.panel:setVisible(false)
		self.mParent.panelBan:setVisible(false)

		return
	else
		self.mParent.panelBan:setVisible(true)
		self.panel:setVisible(true)
	end

	self.txtTips:setText(Lang.get(76452))

	if #heros > #self.banCells then
		for i = 1, #heros - #self.banCells do
			local newCell = TopPvpBpHeroCell(self, "BanPanel/ListHero", "System/TopPVP/TopPVPBPHeroCell")

			newCell:setVisible(true)
			table.insert(self.banCells, newCell)
		end
	end

	for i = 1, #heros do
		self.banCells[i]:setVisible(true)
		self.banCells[i]:setVis(true)
		self.banCells[i]:setData(heros[i])
		self.banCells[i].efxBanPanel:setVisible(true)
	end

	for i = #heros + 1, #self.banCells do
		self.banCells[i]:setVisible(false)
	end

	self.aniInfo:startAni("InTopPVPBPBanPanelCell", true)
	self.aniInfo:addEventFinish(Slot(self.onQuiet, self))
end

function TopPvpBpBanPanelCell:onQuiet(...)
	self.aniInfo:clearEventFinish()
	self.aniInfo:startAni("OutTopPVPBPBanPanelCell", true)
end

local TopPvpHeroPanelCell = Class("TopPvpHeroPanelCell", UIControls.Child)

function TopPvpHeroPanelCell:ctor(...)
	self:initUI()
end

function TopPvpHeroPanelCell:initUI()
	self.heroPanelLeft = UIControls.Panel(self, "HeroPanelLeft")
	self.bgLeftBlue = UIControls.Image(self, "HeroPanelLeft/BgBlue")
	self.bgLeftRed = UIControls.Image(self, "HeroPanelLeft/BgRed")
	self.btnLeftMore = UIControls.Button(self, "HeroPanelLeft/BtnMore")

	self.btnLeftMore:addEventClick(self.onBtnMoreClick)

	self.panelEfx = UIControls.Panel(self, "HeroPanelLeft/EfxPanel")

	self.panelEfx:setVisible(true)

	self.heroPanelRight = UIControls.Panel(self, "HeroPanelRight")
	self.bgRightBlue = UIControls.Image(self, "HeroPanelRight/BgBlue")
	self.bgRightRed = UIControls.Image(self, "HeroPanelRight/BgRed")
	self.btnRightMore = UIControls.Button(self, "HeroPanelRight/BtnMore")

	self.btnRightMore:addEventClick(self.onBtnMoreClick)

	self.leftBgs = {}
	self.rightBgs = {}

	for i = 1, 5 do
		local leftCell = UIControls.Image(self, "HeroPanelLeft/ListHero/Hero" .. i .. "/Bg")
		local rightCell = UIControls.Image(self, "HeroPanelRight/ListHero/Hero" .. i .. "/Bg")

		table.insert(self.leftBgs, leftCell)
		table.insert(self.rightBgs, rightCell)
	end
end

function TopPvpHeroPanelCell:setHolder(index)
	self.holder = index

	if index == 2 then
		self.bgRightRed:setVisible(true)
		self.bgRightBlue:setVisible(false)
		self.bgLeftBlue:setVisible(false)
		self.bgLeftRed:setVisible(true)

		for i = 1, 5 do
			self.rightBgs[i]:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas5", "TeamEmpty02")
			self.leftBgs[i]:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas5", "TeamEmpty02")
		end
	else
		self.bgLeftBlue:setVisible(true)
		self.bgLeftRed:setVisible(false)
		self.bgRightRed:setVisible(false)
		self.bgRightBlue:setVisible(true)

		for i = 1, 5 do
			self.leftBgs[i]:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas5", "TeamEmpty01")
			self.rightBgs[i]:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas5", "TeamEmpty01")
		end
	end
end

function TopPvpHeroPanelCell:setData(index)
	self.index = index

	if index == 2 then
		self.heroPanelLeft:setVisible(false)
		self.heroPanelRight:setVisible(true)

		self.path = "HeroPanelRight"
	else
		self.heroPanelRight:setVisible(false)
		self.heroPanelLeft:setVisible(true)

		self.path = "HeroPanelLeft"
	end

	self.efxPickingPanels = {}

	for i = 1, 5 do
		local pickingCell = UIControls.Panel(self, self.path .. "/EfxPanel/EfxPicking" .. i)

		pickingCell:setVisible(false)

		self.efxPickingPanels[i] = pickingCell
	end

	self.heroCells = {}

	for i = 1, 5 do
		local newCell = TopPvpBpHeroCell(self, self.path .. "/ListHero/Hero" .. i, "System/TopPVP/TopPVPBPHeroCell")

		newCell:setVisible(true)
		newCell:setVis(true)
		table.insert(self.heroCells, newCell)
	end

	self.efxCells = {}

	for i = 1, 5 do
		local newCell = UIControls.LazyEffectPlayer(self, self.path .. "/EfxPanel/EfxPicked" .. i)

		newCell:setVisible(true)
		table.insert(self.efxCells, newCell)
	end
end

function TopPvpHeroPanelCell:setPreState(data)
	self.data = data
	self.nowConfirm = {}

	local bppool = data.bppool[self.mParent.nowBpRound].bpnode
	local pickindex = data.bppool[self.mParent.nowBpRound].pickPos

	if pickindex then
		for i = 1, #pickindex do
			table.insert(self.nowConfirm, bppool[pickindex[i].pos])
		end
	end

	self.capacity = math.min(5, #self.nowConfirm)

	for i = 1, self.capacity do
		self.heroCells[i]:setVis(true)
		self.heroCells[i]:setData(self.nowConfirm[i])
		self.heroCells[i]:setState(false, false, false)
	end

	for i = self.capacity + 1, 5 do
		self.heroCells[i]:setVis(false)
	end
end

function TopPvpHeroPanelCell:setState(data)
	self.nowPicking = {}

	if self.index == self.mParent.nowSelect and self.mParent.canChoose == true and self.mParent.banPick == 200 then
		for i = self.capacity + 1, self.capacity + self.mParent.canChooseNum do
			self.nowPicking[i] = true
		end
	end

	for i = 1, 5 do
		self.efxPickingPanels[i]:setVisible(self.nowPicking[i] == true and not self.mParent.showEffect)
	end
end

function TopPvpHeroPanelCell:refreshUI()
	local heros = self.mParent.herosBag
	local index = self.capacity

	for i = 1, #heros do
		if i + index <= 5 then
			self.heroCells[i + index]:setVis(true)

			local data = {}

			data.hero_id = heros[i].id

			self.heroCells[i + index]:setData(data)
			self.heroCells[i + index]:setState(false, false, false)
		end
	end

	local reIndex = index + #heros

	for i = reIndex + 1, 5 do
		self.heroCells[i]:setVis(false)
	end
end

function TopPvpHeroPanelCell:setPreRoundShow(num)
	local index = self.capacity - num + 1

	if self.mParent.showEffect then
		return
	end

	for i = index, self.capacity do
		if i >= 1 and i <= 5 then
			self.efxCells[i]:setVisible(true)
			self.efxCells[i]:playEffect()
		end
	end
end

function TopPvpHeroPanelCell:initMoreHeroShowData(data)
	local afterDate = {}

	for i = 1, 3 do
		afterDate[i] = {}

		local onepool = data.bppool[i].bpnode

		for j = 1, #onepool do
			if onepool[j].state >= 201 and onepool[j].state <= 205 then
				table.insert(afterDate[i], onepool[j])
			end
		end
	end

	return afterDate
end

function TopPvpHeroPanelCell:onBtnMoreClick()
	local data = self:initMoreHeroShowData(self.data)

	UIManager.getUI("topPvpBpMoreDlg", true):show(self.data)
end

local TopPvpBpPlayerPanelCell = Class("TopPvpBpPlayerPanelCell", UIControls.Child)

function TopPvpBpPlayerPanelCell:ctor()
	self:initUI()
end

function TopPvpBpPlayerPanelCell:initUI()
	self.panel = UIControls.Panel(self, "")
	self.bgMask = UIControls.Image(self, "PlayerPanel/BgMask")
	self.imgHint = UIControls.Image(self, "PlayerPanel/ImgHint")
	self.bgBlue = UIControls.Image(self, "PlayerPanel/BgBlue")
	self.bgRed = UIControls.Image(self, "PlayerPanel/BgRed")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "PlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtPlayerName = UIControls.Label(self, "PlayerPanel/TextPlayerName")
	self.tagFirstLeft = UIControls.Image(self, "PlayerPanel/TagFirstLeft")
	self.tagFirstRight = UIControls.Image(self, "PlayerPanel/TagFirstRight")
	self.watchPanel = UIControls.Panel(self, "PlayerPanel/WatchPanel")
	self.textTips = UIControls.Label(self, "PlayerPanel/WatchPanel/TextTips")
	self.efxTurnChange = UIControls.LazyEffectPlayer(self, "PlayerPanel/EfxTurnChange")
	self.heroCells = {}

	for i = 1, 10 do
		local newCell = TopPvpBpHeroCell(self, "PlayerPanel/ListHero", "System/TopPVP/TopPVPBPHeroCell")

		newCell:setVisible(true)
		table.insert(self.heroCells, newCell)
	end
end

function TopPvpBpPlayerPanelCell:setIndex(index)
	self.index = index
end

function TopPvpBpPlayerPanelCell:setHolder(holder)
	self.holder = holder

	self.bgBlue:setVisible(holder == 1)
	self.bgRed:setVisible(holder == 2)
end

function TopPvpBpPlayerPanelCell:setWatchShow()
	if self.mParent.qualification then
		self.watchPanel:setVisible(false)
	else
		self.watchPanel:setVisible(true)

		if self.holder == self.mParent.nowSelect then
			self.watchPanel:setVisible(true)
			self.textTips:setVisible(true)

			if self.mParent.banPick == 100 then
				self.textTips:setText(Lang.get(81135))
			else
				self.textTips:setText(Lang.get(81136))
			end
		else
			self.watchPanel:setVisible(false)
			self.textTips:setVisible(false)
		end
	end
end

function TopPvpBpPlayerPanelCell:setState(data)
	self.data = data

	if self.isFirst then
		self.tagFirstRight:setVisible(true)
		self.tagFirstLeft:setVisible(false)
	else
		self.tagFirstLeft:setVisible(false)
		self.tagFirstRight:setVisible(false)
	end

	self.heros = data.bppool[self.mParent.nowBpRound].bpnode

	for i = 1, 10 do
		self.heroCells[i]:setData(self.heros[i])
		self.heroCells[i]:setVis(true)
		self.heroCells[i]:setState(self.heros[i].state, not self.canChoose, self.canChoose and self.heros[i].state <= 100)
		self.heroCells[i]:setSelectCallback(self.mParent._slot4CellSelect)
	end

	if self.holder == 1 then
		self.bgBright = UIControls.Image(self, "PlayerPanel/BgBlue/BgBright")
		self.bgDark = UIControls.Image(self, "PlayerPanel/BgBlue/BgDark")
	else
		self.bgBright = UIControls.Image(self, "PlayerPanel/BgRed/BgBright")
		self.bgDark = UIControls.Image(self, "PlayerPanel/BgRed/BgDark")
	end

	if self.mParent.qualification then
		if self.canChoose then
			self.efxTurnChange:playEffect()
			self.imgHint:setVisible(true)
			self.bgMask:setVisible(false)
		else
			self.imgHint:setVisible(false)
			self.bgMask:setVisible(true)
		end
	else
		self.bgMask:setVisible(false)
		self.imgHint:setVisible(false)
	end
end

function TopPvpBpPlayerPanelCell:setPlayer(comm)
	self.btnHead:setCommInfo(comm, true, self)

	local name = utils.GetPlayerName(comm.name)

	self.txtPlayerName:setText(name)
end

local strClassName = "TopPvpBpMainDlg"
local TopPvpBpMainDlg = Class(strClassName, UIControls.Window)

function TopPvpBpMainDlg:ctor()
	self:initUI()
end

function TopPvpBpMainDlg:initUI(...)
	self.bulletSendpanel = CommonBulletSendPanel(self, "BPPanel/CommentPanel")
	self._slotsetBulletStateCb = Slot(self.setBulletStateCb, self)
	self._slotbulletSendCb = Slot(self.bulletSendCb, self)
	self.bulletSendpanel.setBulletStateCb = self._slotsetBulletStateCb
	self.bulletSendpanel.bulletSendCb = self._slotbulletSendCb
	self.bulletSendpanel.bulletSendTimeLimit = ResBPPvpMisc[1].bullet_send_cd or 15
	self.bulletSendpanel.bulletLengthLimit = ResBPPvpMisc[1].bullet_send_limit or 200
	self.btnGamble = UIControls.Button(self, "BPPanel/BtnGamble")

	self.btnGamble:addEventClick(self.onBtnGambleClick)

	self.aniInfo = UIControls.UIAni(self, "")
	self.playerPanels = {}

	for i = 1, 2 do
		local newCell = TopPvpBpPlayerPanelCell(self, "BPPanel/PlayerPanel" .. i, "System/TopPVP/TopPVPBPPlayerPanelCell")

		newCell:setVisible(true)
		newCell:setIndex(i)
		newCell:setHolder(i)
		table.insert(self.playerPanels, newCell)
	end

	self.heroPanels = {}

	for i = 1, 2 do
		local newCell = TopPvpHeroPanelCell(self, "BPPanel/HeroPanel" .. i, "System/TopPVP/TopPVPBPHeroPanelCell")

		newCell:setVisible(true)
		newCell:setData(i)
		newCell:setHolder(i)
		table.insert(self.heroPanels, newCell)
	end

	self.timePanel = UIControls.Image(self, "BPPanel/TimePanel")
	self.txtRoundTime = UIControls.Label(self, "BPPanel/TimePanel/TextRoundTime")
	self.txtExtraTime = UIControls.Label(self, "BPPanel/TimePanel/TextExtraTime")
	self.tipsPanel = UIControls.Image(self, "BPPanel/TipsPanel")
	self.txtTips = UIControls.Label(self, "BPPanel/TipsPanel/TextTips")
	self.btnConfirm = UIControls.Button(self, "BPPanel/TipsPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.tipsTimePanel = UIControls.Image(self, "BPPanel/TipsTimePanel")
	self.txtTipsTime = UIControls.Label(self, "BPPanel/TipsTimePanel/TextTime")
	self.bgBlue = UIControls.Image(self, "BPPanel/TimePanel/RoundPanel/BgBlue")
	self.bgRed = UIControls.Image(self, "BPPanel/TimePanel/RoundPanel/BgRed")
	self.bgGrey = UIControls.Image(self, "BPPanel/TimePanel/RoundPanel/BgGrey")
	self.txtHolder = UIControls.Label(self, "BPPanel/TimePanel/RoundPanel/Text")
	self._slot4CellSelect = Slot(self.onCellSelect, self)
	self.panelBan = TopPvpBpBanPanelCell(self, "BPPanel/BanPanel", "System/TopPVP/TopPVPBPBanPanelCell")
	self.txtTitle = UIControls.Label(self, "BPPanel/TextTitle")
	self.holder = nil
	self.firstPlayer = nil
	self.nowBpRound = nil
	self.state = nil
	self.myDataIndex = nil
	self.rivalDataindex = nil
	self.efxRoundTime = UIControls.LazyEffectPlayer(self, "BPPanel/TimePanel/EfxRoundTime")
	self.efxExtraTime = UIControls.LazyEffectPlayer(self, "BPPanel/TimePanel/EfxExtraTime")
	self.btnWatchExit = UIControls.Button(self, "BPPanel/BtnWatchExit")

	self.btnWatchExit:addEventClick(self.onBtnWatchExitClick)

	self.tipsWatchPanel = UIControls.Image(self, "BPPanel/TipsWatchPanel")
	self.watchPanelPlayer1 = UIControls.PlayerHeadGridChild(self, "BPPanel/TipsWatchPanel/PlayerPanel1/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.watchPanelPlayer1.txtPlayerName = UIControls.Label(self, "BPPanel/TipsWatchPanel/PlayerPanel1/TextPlayerName")
	self.watchPanelPlayer1.textPower = UIControls.Label(self, "BPPanel/TipsWatchPanel/PlayerPanel1/TextPower")
	self.watchPanelPlayer2 = UIControls.PlayerHeadGridChild(self, "BPPanel/TipsWatchPanel/PlayerPanel2/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.watchPanelPlayer2.txtPlayerName = UIControls.Label(self, "BPPanel/TipsWatchPanel/PlayerPanel2/TextPlayerName")
	self.watchPanelPlayer2.textPower = UIControls.Label(self, "BPPanel/TipsWatchPanel/PlayerPanel2/TextPower")
	self.txtTimeWatchTips = UIControls.Label(self, "BPPanel/TipsWatchPanel/TextTime")
	self.aniTurnPanel = UIControls.UIAni(self, "BPPanel")
end

function TopPvpBpMainDlg:setState(...)
	self.choosedHero = {}

	if self.nowBpRound == 2 then
		self.txtTitle:setText(Lang.get(79285))
	elseif self.nowBpRound == 3 then
		self.txtTitle:setText(Lang.get(79286))
	else
		self.txtTitle:setText(Lang.get(78396))
	end

	if self.qualification then
		if self.canChoose then
			self.btnConfirm:setVisible(true)
			self.txtHolder:setText(Lang.get(79924))

			if self.banPick == 100 then
				self.txtTips:setText(utils.format(Lang.get(90269), self.canChooseNum))
			else
				self.txtTips:setText(utils.format(Lang.get(90270), self.canChooseNum))
			end
		else
			self.btnConfirm:setVisible(false)
			self.txtHolder:setText(Lang.get(79925))

			if self.banPick == 100 then
				self.txtTips:setText(Lang.get(79926))
			else
				self.txtTips:setText(Lang.get(79927))
			end
		end
	elseif self.nowSelect == 1 then
		self.txtHolder:setText(Lang.get(79928))

		if self.banPick == 100 then
			self.txtTips:setText(Lang.get(79929))
		else
			self.txtTips:setText(Lang.get(81137))
		end
	else
		self.txtHolder:setText(Lang.get(79931))

		if self.banPick == 100 then
			self.txtTips:setText(Lang.get(79932))
		else
			self.txtTips:setText(Lang.get(81138))
		end
	end

	if self.qualification then
		if self.myDataIndex == self.nowSelect then
			self.bgGrey:setVisible(false)

			if self.nowSelect == 1 then
				self.bgBlue:setVisible(true)
				self.bgRed:setVisible(false)
			else
				self.bgRed:setVisible(true)
				self.bgBlue:setVisible(false)
			end
		else
			self.bgRed:setVisible(false)
			self.bgBlue:setVisible(false)
			self.bgGrey:setVisible(true)
		end
	else
		self.bgGrey:setVisible(false)

		if self.nowSelect == 1 then
			self.bgRed:setVisible(false)
			self.bgBlue:setVisible(true)
		else
			self.bgRed:setVisible(true)
			self.bgBlue:setVisible(false)
		end
	end

	self:refreshUI()
end

function TopPvpBpMainDlg:refreshUI()
	if self.canChooseNum == self.nowSelectNum then
		self.btnConfirm:setEnable(true)
	else
		self.btnConfirm:setEnable(false)
	end
end

function TopPvpBpMainDlg:initData(data)
	self.memberData = data.knockout_member

	local playerUid = CurAvatar.uid

	self.firstPlayer = data.first_bp_uid
	self.qualification = nil
	self.myDataIndex = nil
	self.enemyDataIndex = nil
	self.nowSelectNum = 0

	for i = 1, #self.memberData do
		local mUid = self.memberData[i].uid

		if CurAvatar.uid == mUid then
			self.qualification = true

			if i == self.firstPlayer then
				self.myDataIndex = 1
				self.enemyDataIndex = 2
			else
				self.myDataIndex = 2
				self.enemyDataIndex = 1
			end
		end

		if i == self.firstPlayer then
			self.leftData = self.memberData[i]
		else
			self.rightData = self.memberData[i]
		end
	end

	self.efxRoundTime:setVisible(false)
	self.efxExtraTime:setVisible(false)

	self.herosBag = {}
	self.roomdata = data

	if self.timerExtraTime then
		self.timerExtraTime:Stop()

		self.timerExtraTime = nil
	end

	if self.timerRounetime then
		self.timerRounetime:Stop()

		self.timerRounetime = nil
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTipsTime)
	ClientTimerManager.RemoveSecondTickUI(self.txtTimeWatchTips)

	self.timerId = data.state.timer_id

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.qualification then
		self.btnGamble:setVisible(false)
		self.bulletSendpanel:setVisible(false)
	else
		self.btnConfirm:setVisible(false)
		self.btnGamble:setVisible(true)
		self.bulletSendpanel:setVisible(true)

		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			self.showBulletFlag = actData:getBulletSwitch()

			if self.showBulletFlag == nil then
				self.bulletSendpanel:setBulletState(true)
			else
				self.bulletSendpanel:setBulletState(self.showBulletFlag)
			end
		end
	end
end

function TopPvpBpMainDlg:initPreRoundData()
	if self.nowSelect == 1 then
		self.playerPanels[1].bgBright:setVisible(true)
		self.playerPanels[1].bgDark:setVisible(false)
		self.playerPanels[2].bgBright:setVisible(false)
		self.playerPanels[2].bgDark:setVisible(true)
	else
		self.playerPanels[2].bgBright:setVisible(true)
		self.playerPanels[2].bgDark:setVisible(false)
		self.playerPanels[1].bgBright:setVisible(false)
		self.playerPanels[1].bgDark:setVisible(true)
	end

	local resPreData = ResBPPvpBPRound[self.state - 1]

	self.preBanHeros = {}

	if resPreData then
		local preSelect
		local prePlayer = resPreData.player

		if resPreData.bp_mode == 100 and self.myDataIndex ~= prePlayer then
			local preList

			if prePlayer == 1 then
				preList = self.leftData.preList
			else
				preList = self.rightData.preList
			end

			if preList then
				for i = 1, #preList do
					if preList[i] then
						local pos = preList[i] + 1

						if prePlayer == 1 then
							table.insert(self.preBanHeros, self.rightData.bppool[self.nowBpRound].bpnode[pos])
						else
							table.insert(self.preBanHeros, self.leftData.bppool[self.nowBpRound].bpnode[pos])
						end
					end
				end
			end
		end

		if resPreData.bp_mode == 200 then
			self.heroPanels[prePlayer]:setPreRoundShow(resPreData.bp_num)
		end
	end

	if #self.preBanHeros and not self.showEffect then
		self.panelBan:setData(self.preBanHeros)
	end
end

function TopPvpBpMainDlg:setExtraTimer(...)
	if self.timerExtraTime then
		self.timerExtraTime:Stop()

		self.timerExtraTime = nil
	end

	local function funcExtra()
		self.remainExtraTime = self.remainExtraTime - 1

		if self.remainExtraTime >= 0 then
			if self.remainExtraTime > 5 then
				CueManager.playUiSfx("Audios/SFX/UI/ui_toppvp_time_1.ogg")
			else
				CueManager.playUiSfx("Audios/SFX/UI/ui_toppvp_time_2.ogg")
			end

			if self.txtExtraTime then
				self.txtExtraTime:setText(self.remainExtraTime)
			end
		end

		if self.remainExtraTime == 0 then
			self.timerExtraTime:Stop()
		end
	end

	self.timerExtraTime = Timer.New(funcExtra, 1, -1)

	self.timerExtraTime:Start()
end

function TopPvpBpMainDlg:setTime(...)
	local timerData = ResBPPvpRoomTimer[self.timerId]

	if timerData and timerData.state == 101 then
		if self.nowSelect == 1 then
			self.remainTime = ResBPPvpRoomTimer[self.timerId].last_time - (ClientUtils.getServerTime() - self.roomdata.state.start_time)
			self.remainExtraTime = ResBPPvpMisc[1].bp_time - self.leftData.spare_bp_time
		else
			self.remainTime = ResBPPvpRoomTimer[self.timerId].last_time - (ClientUtils.getServerTime() - self.roomdata.state.start_time)
			self.remainExtraTime = ResBPPvpMisc[1].bp_time - self.rightData.spare_bp_time
		end

		if self.remainTime > ResBPPvpRoomTimer[self.timerId].last_time then
			self.remainTime = ResBPPvpRoomTimer[self.timerId].last_time
		end

		if self.remainTime >= 0 then
			if self.remainExtraTime >= 0 then
				self.txtExtraTime:setText(self.remainExtraTime)
			end

			self.efxRoundTime:setVisible(true)
			self.txtRoundTime:setText(self.remainTime)

			if self.timerRounetime then
				self.timerRounetime:Stop()

				self.timerRounetime = nil
			end

			local function funcRound()
				self.remainTime = self.remainTime - 1

				if self.remainTime >= 0 then
					if self.remainTime > 5 then
						CueManager.playUiSfx("Audios/SFX/UI/ui_toppvp_time_1.ogg")
					else
						CueManager.playUiSfx("Audios/SFX/UI/ui_toppvp_time_2.ogg")
					end

					if self.txtRoundTime then
						self.txtRoundTime:setText(self.remainTime)
					end
				end

				if self.remainTime == 0 then
					if self.remainExtraTime > 0 then
						if self.efxExtraTime then
							self.efxExtraTime:setVisible(true)
						end

						if self.efxRoundTime then
							self.efxRoundTime:setVisible(false)
						end

						if self.txtExtraTime and self.remainExtraTime then
							self:setExtraTimer()
						end

						self:setExtraTimer()
					end

					self.timerRounetime:Stop()

					self.timerRounetime = nil
				end
			end

			if self.remainTime == 0 then
				self.efxExtraTime:setVisible(true)
				self.efxRoundTime:setVisible(false)
				self:setExtraTimer()
			else
				self.timerRounetime = Timer.New(funcRound, 1, -1)

				self.timerRounetime:Start()
			end
		else
			self.remainExtraTime = self.remainExtraTime + self.remainTime

			if self.remainExtraTime >= 0 then
				self.efxExtraTime:setVisible(true)
				self.efxRoundTime:setVisible(false)
				self:setExtraTimer()
			end
		end
	end
end

function TopPvpBpMainDlg:setBpState()
	if self.state ~= 1 and self.state ~= 11 and self.state ~= 21 then
		CueManager.playUiSfx("Audios/SFX/UI/ui_toppvp_confirm.ogg")

		local resPreData = ResBPPvpBPRound[self.state - 1]
		local resData = ResBPPvpBPRound[self.state]

		if resPreData and resData then
			local prePlayer = resPreData.player
			local nowPlayer = resData.player

			if prePlayer == nowPlayer then
				self.aniTurnPanel:startAni("ChangeBPTurn", true)
			else
				self.aniTurnPanel:startAni("ChangePlayerTurn", true)
			end
		end
	end

	self.timePanel:setVisible(true)
	self.tipsPanel:setVisible(true)
	self.tipsTimePanel:setVisible(false)

	local resData = ResBPPvpBPRound[self.state]

	self.banPick = resData.bp_mode
	self.canChooseNum = resData.bp_num
	self.nowSelect = resData.player

	if self.qualification and self.nowSelect == self.myDataIndex then
		self.canChoose = true
	else
		self.canChoose = false
	end

	self:setTime()
end

function TopPvpBpMainDlg:setBpshowState(...)
	self.timePanel:setVisible(false)
	self.tipsPanel:setVisible(false)
	self.tipsTimePanel:setVisible(true)

	local remainTime = ResBPPvpRoomTimer[self.timerId].last_time

	ClientTimerManager.AddSecondTickUI(self.txtTipsTime, remainTime, false, "", "", nil, nil, 2)

	self.data.knockout_member[1].spare_bp_time = 0
	self.data.knockout_member[2].spare_bp_time = 0
end

function TopPvpBpMainDlg:setPlayerComm(...)
	local members = self.data.knockout_member
	local uids = {}

	for i = 1, #members do
		table.insert(uids, members[i].uid)
	end

	local function func(infos)
		for _, info in pairs(infos) do
			for index, uid in ipairs(uids) do
				if uid == info.uid then
					if index == self.firstPlayer then
						self.playerPanels[1]:setPlayer(info.commInfo)
					else
						self.playerPanels[2]:setPlayer(info.commInfo)
					end
				end
			end
		end
	end

	CurAvatar:getRoleCommInfosNoTip(uids, func)
end

function TopPvpBpMainDlg:setWatchPlayerComm()
	local members = self.data.knockout_member
	local uids = {}

	for i = 1, #members do
		table.insert(uids, members[i].uid)
	end

	local function func(infos)
		for _, info in pairs(infos) do
			for index, uid in ipairs(uids) do
				if uid == info.uid then
					local comm = info.commInfo
					local cell

					if index == 1 then
						cell = self.watchPanelPlayer1
					else
						cell = self.watchPanelPlayer2
					end

					if comm then
						cell:setCommInfo(comm, true, self)

						local name = utils.GetPlayerName(comm.name)

						cell.txtPlayerName:setText(name)
					end

					local power = info.power

					if power then
						cell.textPower:setText(power)
					end
				end
			end
		end
	end

	CurAvatar:_getRoleInfosCheck(uids, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL, func)
end

function TopPvpBpMainDlg:setData(isFirstRound)
	self.showEffect = isFirstRound

	local actData = CurAvatar:getTopPVPActivityData()
	local data = actData:getChaheRoomData()

	if data then
		self.data = data
	else
		return
	end

	self:initData(data)

	local nowStage = actData:getTopPvpStage()

	if actData.stateMap[nowStage] == "KnockoutRoomFight" then
		for i = 1, 2 do
			self.playerPanels[i]:setVisible(true)
			self.heroPanels[i]:setVisible(true)
		end

		self.txtTitle:setVisible(true)

		self.nowBpRound = ResBPPvpRoomTimer[self.timerId].bp_round
		self.state = ResBPPvpRoomTimer[self.timerId].bp_id or 0

		self.tipsWatchPanel:setVisible(false)

		if self.qualification then
			self.btnWatchExit:setVisible(false)
		else
			self.btnWatchExit:setVisible(true)
		end

		if self.state ~= 0 then
			self:setBpState()
			self:setState()
		else
			self:setBpshowState()

			self.canChoose = nil
		end

		self.heroPanels[1]:setPreState(self.leftData)
		self.heroPanels[2]:setPreState(self.rightData)
		self:setPlayerComm()

		if self.canChoose == true then
			if self.banPick == 100 then
				self.playerPanels[self.enemyDataIndex].canChoose = true
				self.playerPanels[self.myDataIndex].canChoose = false
			else
				self.playerPanels[self.myDataIndex].canChoose = true
				self.playerPanels[self.enemyDataIndex].canChoose = false
			end
		else
			self.playerPanels[1].canChoose = false
			self.playerPanels[2].canChoose = false
		end

		self.playerPanels[1].isFirst = true
		self.playerPanels[2].isFirst = false

		self.playerPanels[1]:setState(self.leftData)
		self.playerPanels[2]:setState(self.rightData)
		self.heroPanels[1]:setState(self.leftData)
		self.heroPanels[2]:setState(self.rightData)

		if self.myDataIndex then
			self.heroPanels[self.myDataIndex].isMe = true
			self.heroPanels[self.enemyDataIndex].isMe = false
		else
			self.heroPanels[1].isMe = false
			self.heroPanels[2].isMe = false
		end

		if self.state ~= 0 then
			self:initPreRoundData()
		end

		self.playerPanels[1]:setWatchShow()
		self.playerPanels[2]:setWatchShow()
	else
		self.panelBan:setVisible(false)

		for i = 1, 2 do
			self.playerPanels[i]:setVisible(false)
			self.heroPanels[i]:setVisible(false)
		end

		self.txtTitle:setVisible(false)

		self.nowBpRound = 1

		local remainTime = actData:getRemainNowRoundStartFightTime()

		if remainTime then
			ClientTimerManager.AddSecondTickUI(self.txtTimeWatchTips, remainTime, false)
		end

		self.tipsWatchPanel:setVisible(true)
		self.tipsTimePanel:setVisible(false)
		self.tipsPanel:setVisible(false)
		self.timePanel:setVisible(false)
		self.btnWatchExit:setVisible(true)

		self.canChoose = nil

		self:setWatchPlayerComm()
	end
end

function TopPvpBpMainDlg:refreshHeros(...)
	if not self.banPick == 200 then
		return
	end

	self.heroPanels[self.myDataIndex]:refreshUI()
end

function TopPvpBpMainDlg:onCellSelect(sender)
	local id = sender.hero.id

	if self.choosedHero[id] == true then
		sender:setSelected(false, self.banPick)

		self.choosedHero[id] = false

		local index

		for i = 1, #self.herosBag do
			if self.herosBag[i].id == id then
				index = i

				break
			end
		end

		table.remove(self.herosBag, index)

		self.nowSelectNum = self.nowSelectNum - 1
	elseif #self.herosBag >= self.canChooseNum then
		MsgManager.notice(Lang.get(79941))
	else
		self.choosedHero[id] = true

		sender:setSelected(true, self.banPick)
		table.insert(self.herosBag, sender.hero)

		self.nowSelectNum = self.nowSelectNum + 1
	end

	self:refreshUI()

	if self.banPick == 200 and self.canChoose then
		self:refreshHeros()
	end
end

function TopPvpBpMainDlg:onBtnGambleClick()
	UIManager.getUI("topPvpGambleSimpleDlg", true)

	local actId = CurAvatar:getTopPVPActivityOpId()

	RPC.bPPvpKnockoutBetInfoGet(actId)
end

function TopPvpBpMainDlg:setBulletStateCb(sender, state)
	local actData = CurAvatar:getTopPVPActivityData()
	local maxReq = 0

	if actData then
		actData:updateBulletSwitch(state)

		maxReq = actData:getBulletMaxSeq()
	end

	self.showBulletFlag = state

	if self.showBulletFlag == true then
		if not self.timerBullet then
			local function fun()
				CHATRPC.chatPull("kMsgChannelTypeBarrage", maxReq, self.roomdata.room_id)
			end

			self.timerBullet = Timer.New(fun, 5, -1)

			self.timerBullet:Start()
		end
	elseif self.timerBullet then
		if actData then
			actData:updateBulletMaxSeq(0)
		end

		self.timerBullet:Stop()

		self.timerBullet = nil
	end
end

function TopPvpBpMainDlg:bulletSendCb(sender, content)
	local actId = CurAvatar:getTopPVPActivityOpId()
	local data = {}

	data.content = content
	data.gid = self.data.room_id
	data.channel = "kMsgChannelTypeBarrage"

	RPC.bPPvpKnockouotChatReq(actId, data)

	self.bulletSendpanel.preSendTime = ClientUtils.getServerTime()

	self.bulletSendpanel:_closeBulletEdit()
end

function TopPvpBpMainDlg:onBtnWatchExitClick()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.timerExtraTime then
		self.timerExtraTime:Stop()

		self.timerExtraTime = nil
	end

	if self.timerRounetime then
		self.timerRounetime:Stop()

		self.timerRounetime = nil
	end

	if self.timerBullet then
		self.timerBullet:Stop()

		self.timerBullet = nil
	end

	local actData = CurAvatar:getTopPVPActivityData()

	actData:updateInKnockoutRoomId(nil)
	self:setVisible(false)
end

function TopPvpBpMainDlg:onBtnConfirmClick()
	local actId = CurAvatar:getTopPVPActivityOpId()
	local actData = CurAvatar:getTopPVPActivityData()
	local areaId = math.floor(actData.myKnockoutRoomId % 1000 / 100)
	local bpId = self.state
	local heroIds = {}

	for i = 1, #self.herosBag do
		table.insert(heroIds, self.herosBag[i].id)
	end

	if #heroIds == self.canChooseNum then
		RPC.bPPvpKnockoutBP(actId, areaId, self.data.room_id, self.state, heroIds)

		self.herosBag = {}

		self:refreshUI()
	end
end

function TopPvpBpMainDlg:destroy(...)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.timerExtraTime then
		self.timerExtraTime:Stop()

		self.timerExtraTime = nil
	end

	if self.timerRounetime then
		self.timerRounetime:Stop()

		self.timerRounetime = nil
	end

	if self.timerBullet then
		self.timerBullet:Stop()

		self.timerBullet = nil
	end

	if self.bulletTimer then
		self.bulletTimer:Stop()

		self.bulletTimer = nil
	end

	local ui = UIManager.tryGetUI("topPvpBpMoreDlg")

	if ui and ui:getVisible() then
		ui:setVisible(false)
	end

	local ui = UIManager.tryGetUI("topPvpGambleSimpleDlg")

	if ui and ui:getVisible() then
		ui:setVisible(false)
	end

	local ui = UIManager.tryGetUI("avgBulletEmojiBox")

	if ui and ui:getVisible() then
		ui:setVisible(false)
	end

	TopPvpBpMainDlg.super.destroy(self)
end

return TopPvpBpMainDlg
