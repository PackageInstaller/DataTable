-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpBpReplayDlg.lua

local strClassName = "TopPvpBpReplayDlg"
local TopPvpBpReplayDlg = Class(strClassName, UIControls.Window)
local TopPvpBpHeroIconCell = require("UI/PVPMode/TopPVP/TopPvpBpHeroIconCell")

function TopPvpBpReplayDlg:ctor()
	self:initUI()
end

function TopPvpBpReplayDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnsHead = {}
	self.btnsHead[1] = UIControls.PlayerHeadGridChild(self, "MainInfoPanel/LeftPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[1].playerName = UIControls.Label(self, "MainInfoPanel/LeftPlayerPanel/TextPlayerName")
	self.btnsHead[1].imgState = UIControls.Image(self, "MainInfoPanel/LeftPlayerPanel/TextPlayerName/ImgState")
	self.btnsHead[1].imgFirst = UIControls.Image(self, "MainInfoPanel/LeftPlayerPanel/TextPlayerName/ImgFirst")
	self.btnsHead[1].banHeros = {}
	self.btnsHead[1].pickHeros = {}
	self.gridHero1 = UIControls.Panel(self, "MainInfoPanel/LeftPlayerPanel/HeroPickPanel/GridHero1")

	for i = 1, 5 do
		local newCell = TopPvpBpHeroIconCell(self, "MainInfoPanel/LeftPlayerPanel/HeroPickPanel/GridHero" .. i, "System/StarUp/GridHeroStarUp")

		newCell:setVisible(true)

		newCell.txtName = UIControls.Label(self, "MainInfoPanel/LeftPlayerPanel/HeroPickPanel/GridHero" .. i .. "/TextName")

		table.insert(self.btnsHead[1].pickHeros, newCell)
	end

	self.gridHero = UIControls.Panel(self, "MainInfoPanel/LeftPlayerPanel/HeroBanPanel/GridHero1/GridHero")

	for i = 1, 4 do
		local newCell = TopPvpBpHeroIconCell(self, "MainInfoPanel/LeftPlayerPanel/HeroBanPanel/GridHero" .. i .. "/GridHero", "System/StarUp/GridHeroStarUp")

		newCell:setVisible(true)

		newCell.txtName = UIControls.Label(self, "MainInfoPanel/LeftPlayerPanel/HeroBanPanel/GridHero" .. i .. "/TextName")

		table.insert(self.btnsHead[1].banHeros, newCell)
	end

	self.btnsHead[2] = UIControls.PlayerHeadGridChild(self, "MainInfoPanel/RightPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[2].playerName = UIControls.Label(self, "MainInfoPanel/RightPlayerPanel/TextPlayerName")
	self.btnsHead[2].imgState = UIControls.Image(self, "MainInfoPanel/RightPlayerPanel/TextPlayerName/ImgState")
	self.btnsHead[2].imgFirst = UIControls.Image(self, "MainInfoPanel/RightPlayerPanel/TextPlayerName/ImgFirst")
	self.btnsHead[2].banHeros = {}
	self.btnsHead[2].pickHeros = {}

	for i = 1, 5 do
		local newCell = TopPvpBpHeroIconCell(self, "MainInfoPanel/RightPlayerPanel/HeroPickPanel/GridHero" .. i, "System/StarUp/GridHeroStarUp")

		newCell:setVisible(true)

		newCell.txtName = UIControls.Label(self, "MainInfoPanel/RightPlayerPanel/HeroPickPanel/GridHero" .. i .. "/TextName")

		table.insert(self.btnsHead[2].pickHeros, newCell)
	end

	self.gridHero = UIControls.Panel(self, "MainInfoPanel/RightPlayerPanel/HeroBanPanel/GridHero1/GridHero")

	for i = 1, 4 do
		local newCell = TopPvpBpHeroIconCell(self, "MainInfoPanel/RightPlayerPanel/HeroBanPanel/GridHero" .. i .. "/GridHero", "System/StarUp/GridHeroStarUp")

		newCell.txtName = UIControls.Label(self, "MainInfoPanel/RightPlayerPanel/HeroBanPanel/GridHero" .. i .. "/TextName")

		newCell:setVisible(true)
		table.insert(self.btnsHead[2].banHeros, newCell)
	end

	self.btnsTab = {}

	for i = 1, 3 do
		self.btnsTab[i] = UIControls.Button(self, "MainInfoPanel/TabRoundsPanel/BtnTab" .. i)
		self.btnsTab[i].index = i

		self.btnsTab[i]:setVisible(true)
		self.btnsTab[i]:addEventClick(self.onBtnTabClick)
	end
end

function TopPvpBpReplayDlg:getCommByUid(uid)
	if not uid then
		return
	end

	for index, comm in pairs(self.comm) do
		if comm.uid == tostring(uid) then
			return comm
		end
	end
end

function TopPvpBpReplayDlg:setCommData()
	local uids = {}

	for index, one in pairs(self.roomData.knockout_member) do
		if one.uid then
			table.insert(uids, tostring(one.uid))
		end
	end

	self.comm = {}
	self.uidVisMap = {}

	local function setCommFun(infos)
		for _, info in pairs(infos) do
			for i, player in pairs(self.roomData.knockout_member) do
				if tostring(player.uid) == info.uid then
					self.comm[i] = info.commInfo
				end
			end
		end

		self:setCommShow()
	end

	CurAvatar:getRoleCommInfosNoTip(uids, setCommFun)
end

function TopPvpBpReplayDlg:setCommShow(...)
	local leftPlayerUid, rightPlayerUid

	if self.roomData.first_bp_uid == 1 then
		leftPlayerUid = self.roomData.knockout_member[1].uid
		rightPlayerUid = self.roomData.knockout_member[2].uid
	else
		leftPlayerUid = self.roomData.knockout_member[2].uid
		rightPlayerUid = self.roomData.knockout_member[1].uid
	end

	local leftPlayer = self:getCommByUid(leftPlayerUid)

	if leftPlayer then
		self.btnsHead[1]:setCommInfo(leftPlayer, true, self)
		self.btnsHead[1].imgFirst:setVisible(true)

		local name = utils.GetPlayerName(leftPlayer.name)

		self.btnsHead[1].playerName:setText(name)
	end

	local rightPlayer = self:getCommByUid(rightPlayerUid)

	if rightPlayer then
		self.btnsHead[2]:setCommInfo(rightPlayer, true, self)
		self.btnsHead[2].imgFirst:setVisible(false)

		local name = utils.GetPlayerName(rightPlayer.name)

		self.btnsHead[2].playerName:setText(name)
	end
end

function TopPvpBpReplayDlg:show(roomInfo)
	self.roomData = roomInfo

	self:setCommData()
	self:setCommShow()
	self:setSelect(1)
end

function TopPvpBpReplayDlg:setSelect(index)
	index = index or 1

	for i = 1, 3 do
		self.btnsTab[i]:setEnable(index ~= i)
	end

	local leftBpPool, rightBpPool

	if self.roomData.first_bp_uid == 1 then
		leftBpPool = self.roomData.knockout_member[1].bppool[index].bpnode
		rightBpPool = self.roomData.knockout_member[2].bppool[index].bpnode
	else
		leftBpPool = self.roomData.knockout_member[2].bppool[index].bpnode
		rightBpPool = self.roomData.knockout_member[1].bppool[index].bpnode
	end

	local leftPickHeros = {}
	local leftBanHeros = {}

	for i = 1, #leftBpPool do
		if leftBpPool[i].state >= 101 and leftBpPool[i].state <= 105 then
			table.insert(leftBanHeros, leftBpPool[i])
		end

		if leftBpPool[i].state >= 201 and leftBpPool[i].state <= 205 then
			table.insert(leftPickHeros, leftBpPool[i])
		end
	end

	for i = 1, #leftBanHeros do
		local hero = BaseObject.GetObject(leftBanHeros[i].hero_id)

		if hero then
			local name = hero.name

			self.btnsHead[1].banHeros[i]:setHero(hero)
			self.btnsHead[1].banHeros[i].txtName:setText(name)
		end
	end

	for i = 1, #leftPickHeros do
		local hero = BaseObject.GetObject(leftPickHeros[i].hero_id)

		if hero then
			local name = hero.name

			self.btnsHead[1].pickHeros[i]:setHero(hero)
			self.btnsHead[1].pickHeros[i].txtName:setText(name)
		end
	end

	local rightPickHeros = {}
	local rightBanHeros = {}

	for i = 1, #rightBpPool do
		if rightBpPool[i].state >= 101 and rightBpPool[i].state <= 105 then
			table.insert(rightBanHeros, rightBpPool[i])
		end

		if rightBpPool[i].state >= 201 and rightBpPool[i].state <= 205 then
			table.insert(rightPickHeros, rightBpPool[i])
		end
	end

	for i = 1, #rightBanHeros do
		local hero = BaseObject.GetObject(rightBanHeros[i].hero_id)

		if hero then
			local name = hero.name

			self.btnsHead[2].banHeros[i]:setHero(hero)
			self.btnsHead[2].banHeros[i].txtName:setText(name)
		end
	end

	for i = 1, #rightPickHeros do
		local hero = BaseObject.GetObject(rightPickHeros[i].hero_id)

		if hero then
			local name = hero.name

			self.btnsHead[2].pickHeros[i]:setHero(hero)
			self.btnsHead[2].pickHeros[i].txtName:setText(name)
		end
	end
end

function TopPvpBpReplayDlg:onBtnTabClick(sender)
	self:setSelect(sender.index)
end

function TopPvpBpReplayDlg:onBtnCloseClick()
	self:setVisible(false)
end

return TopPvpBpReplayDlg
