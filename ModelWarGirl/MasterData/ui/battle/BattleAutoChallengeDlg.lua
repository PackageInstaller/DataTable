-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleAutoChallengeDlg.lua

local ResEquipTower = require("ClientData/ResEquipTower")
local ResBossTowerExpandLevel = require("ClientData/ResBossTowerExpandLevel")
local ResBossTowerExpandCamp = require("ClientData/ResBossTowerExpandCamp")
local ResAutoBattlePower = require("ClientData/ResAutoBattlePower")
local strClassName = "BattleAutoChallengeCell"
local BattleAutoChallengeCell = Class(strClassName, UIControls.Child)

function BattleAutoChallengeCell:ctor()
	self:initUI()
end

function BattleAutoChallengeCell:initUI()
	self.panelWin = UIControls.Panel(self, "ContentPanel/WinPanel")
	self.panelLose = UIControls.Panel(self, "ContentPanel/FailPanel")
	self.grids = {}
	self.textNum = UIControls.Label(self, "ContentPanel/BgTitle/TextNum")
	self.textName = UIControls.Label(self, "ContentPanel/BgTitle/TextLevel")
end

function BattleAutoChallengeCell:setData(result, finish, itemBonus, battleNum, titleName)
	self.textName:setText(titleName)
	self.textNum:setText(battleNum)

	if result == BattleConst.BATTLE_RESULT_WIN then
		self.panelWin:setVisible(true)
		self.panelLose:setVisible(false)

		if itemBonus then
			local clientItems = {}

			for _, item in pairs(itemBonus) do
				table.insert(clientItems, item)
			end

			for index, item in ipairs(clientItems) do
				local newGrid = UIControls.getGridChild(item, self, "ContentPanel/WinPanel/AwardPanel/Content")

				newGrid:setVisible(true)
				newGrid:setObj(item)

				newGrid.mDisableWays = true

				table.insert(self.grids, newGrid)
			end
		end
	else
		self.panelWin:setVisible(false)
		self.panelLose:setVisible(true)
	end
end

local strClassName = "BattleAutoChallengeDlg"
local BattleAutoChallengeDlg = Class(strClassName, UIControls.Window)

function BattleAutoChallengeDlg:ctor()
	self:initUI()
end

function BattleAutoChallengeDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.battleCells = {}
	self.panelBattleTime = UIControls.Panel(self, "BgPanel/BattlePanel/TextPanel")
	self.textBattleTime = UIControls.Panel(self, "BgPanel/BattlePanel/TextPanel/TextBattle")
	self.textBattleWaiting = UIControls.Panel(self, "BgPanel/BattlePanel/TextPanel/ImgRefresh")
	self.panelMask = UIControls.Panel(self, "BgPanel/ImglMask01")
	self.panelMask2 = UIControls.Panel(self, "BgPanel/ImgMask02")
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.textLoading = UIControls.Panel(self, "BgPanel/TextLoading")

	self.textLoading:setVisible(true)

	self.textNum = UIControls.Label(self, "BgPanel/TextNumPanel/TextNum")
	self.textNumTime = UIControls.Label(self, "BgPanel/TextNumPanel/TextTime")
	self.btnBattle = UIControls.Button(self, "BgPanel/BtnStart")

	self.btnBattle:addEventClick(self.onBattleClick)

	self.btnStop = UIControls.Button(self, "BgPanel/BtnStop")

	self.btnStop:addEventClick(self.onStopClick)

	self.toggleFailStop = UIControls.Toggle(self, "BgPanel/BtnAutoStop")
	self.curBattleNum = 1
	self.scrollResult = UIControls.ScrollView(self, "BgPanel/ResultList")
end

function BattleAutoChallengeDlg:setData(battleType, battleArgs)
	self.battleType = battleType
	self.battleArgs = battleArgs
	self.toMax = false

	if battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		self.towerType = battleArgs.towerType
		self.towerData = CurAvatar.equipTowerData[self.towerType] or {}
		self.passedLevel = self.towerData.layer or 0
		self.equipData = ResEquipTower[self.towerType]

		if self.passedLevel >= #self.equipData then
			self:onStopBattle()

			self.toMax = true
			self.equipData = self.equipData[#self.equipData]
		else
			self.equipData = self.equipData[self.passedLevel + 1]
		end

		self.textTitle:setText(self.equipData.full_name or "")

		self.gameId = Const.GAME_PLAY_ID_EQUIP_TOWER
	elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		self.expandTowerId = battleArgs.towerId
		self.expandTowerLayer = battleArgs.layer
		self.passedLevel = CurAvatar:getBossExpandPassLevel(self.expandTowerId, self.expandTowerLayer)

		local towerData = ResBossTowerExpandLevel[self.expandTowerId][self.expandTowerLayer]

		if self.passedLevel >= #towerData then
			self:onStopBattle()

			towerData = towerData[#towerData]
			self.toMax = true
		else
			towerData = towerData[self.passedLevel + 1]
		end

		self.pveId = towerData.pve_id

		self.textTitle:setText(utils.format(Lang.get(96889), towerData.name or "", self.expandTowerLayer, towerData.diff))

		self.gameId = Const.GAME_PLAY_ID_CAMP_TOWER
	end

	self.powerConfigData = ResAutoBattlePower[self.gameId]
	self.loseNum = self.powerConfigData.try_count or 3
	self.maxNum = self.powerConfigData.power_max

	self:onRefreshPower()
end

function BattleAutoChallengeDlg:onRefreshPower()
	self.power, self.nextTick = CurAvatar:getAutoBattlePower(self.gameId)

	self.textNum:setText(self.power .. "/" .. self.maxNum)

	if self.power > 0 then
		self.textNum:setFontColor(ResColor.WHITE)
	else
		self.textNum:setFontColor(ResColor.RED)
	end

	ClientTimerManager.RemoveSecondTickUI(self.textNumTime)

	if self.nextTick < 0 then
		self.textNumTime:setText("")
	else
		ClientTimerManager.AddSecondFormatTickUI(self.textNumTime, self.nextTick, nil, Lang.get(96991), Slot(self.tickOver, self))
	end
end

function BattleAutoChallengeDlg:tickOver()
	self:onRefreshPower()
end

function BattleAutoChallengeDlg:onCloseClick()
	self:onStopBattle()
	self:setVisible(false)
end

function BattleAutoChallengeDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(489)
end

function BattleAutoChallengeDlg:onBattleClick()
	self:onStopBattle()

	self.coBattleRunning = coroutine.start(self.coStartBattle, self)
end

function BattleAutoChallengeDlg:onStopBattle()
	self.panelMask2:setVisible(false)
	self.panelMask:setVisible(false)
	self.btnBattle:setVisible(true)
	self.btnStop:setVisible(false)

	self.waiting = false
	self.stoping = false

	self.panelBattleTime:setVisible(false)

	if self.coBattleRunning then
		coroutine.stop(self.coBattleRunning)

		self.coBattleRunning = nil
	end
end

function BattleAutoChallengeDlg:coStartBattle()
	self.panelMask2:setVisible(true)
	self.panelMask:setVisible(true)
	self.btnBattle:setVisible(false)
	self.btnStop:setVisible(true)
	self.panelBattleTime:setVisible(true)

	self.failNum = 0
	self.waiting = false
	self.stoping = false

	for index = 1, 1000 do
		if self.toMax then
			MsgManager.notice(Lang.get(724))
			self:onStopBattle()

			return
		end

		if self.power <= 0 then
			MsgManager.notice(Lang.get(96992))
			self:onStopBattle()

			return
		end

		if self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER and self.equipData.no_equip_bag ~= 1 and CurAvatar:getEquipRemainBlankNum() <= 0 then
			CurAvatar:confirmBagAdd(Const.BAG_TYPE_EQUIP)
			self:onStopBattle()

			return
		end

		if self.failNum >= self.loseNum then
			MsgManager.notice(Lang.get(96890))
			self:onStopBattle()

			return
		end

		if self.stoping then
			self:onStopBattle()

			return
		end

		self.textBattleTime:setVisible(true)
		self.textBattleWaiting:setVisible(false)
		coroutine.wait(3)
		self:rpcBattle()
		self.btnStop:setText(Lang.get(96993))

		self.waiting = true
		self.stoping = false

		for index = 1, 1000 do
			coroutine.wait(0.1)

			if self.rpcResult then
				self.textBattleTime:setVisible(false)
				self.textBattleWaiting:setVisible(true)

				local result = self.rpcResult[1]
				local finish = self.rpcResult[2]
				local itemBonus = self.rpcResult[3]

				self.rpcResult = nil

				local newCell = BattleAutoChallengeCell(self, "BgPanel/ResultList/Content", "System/AutoChallenge/AutoChallengeResultCell")

				newCell:setData(result, finish, itemBonus, self.curBattleNum, self.textTitle:getText())

				self.curBattleNum = self.curBattleNum + 1

				newCell:setVisible(true)
				self.textLoading:setVisible(false)
				coroutine.wait(0.1)
				self.scrollResult:gotoVerticalEnd()

				if result == BattleConst.BATTLE_RESULT_WIN then
					coroutine.wait(1)

					self.waiting = false

					self:setData(self.battleType, self.battleArgs)

					break
				end

				coroutine.wait(1)

				self.waiting = false
				self.failNum = self.failNum + 1

				self:onRefreshPower()

				if self.toggleFailStop:isOn() then
					self:onStopBattle()

					return
				end

				break
			end
		end
	end
end

function BattleAutoChallengeDlg:rpcBattle()
	local specData = {}

	if self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		specData.equip_tower = {}
		specData.equip_tower.type = self.towerType
		specData.equip_tower.layer = self.passedLevel + 1
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		specData.camp_tower = {}
		specData.camp_tower.tower = self.expandTowerId
		specData.camp_tower.layer = self.expandTowerLayer
		specData.camp_tower.level = self.passedLevel + 1
		specData.camp_tower.pve_id = self.pveId
	end

	RPC.pVEAutoBattle(self.battleType, specData)
	CurAvatar:onPVEFinishRequest(self.battleType)
end

function BattleAutoChallengeDlg:onPVEAutoBattleResp(type, result, finish, itemBonus)
	self.rpcResult = {
		result,
		finish,
		itemBonus
	}
end

function BattleAutoChallengeDlg:onStopClick()
	if self.waiting then
		self.stoping = true
	else
		self:onStopBattle()
	end
end

function BattleAutoChallengeDlg:onReconnect()
	self:setData(self.battleType, self.battleArgs)
	self:onStopBattle()
end

function BattleAutoChallengeDlg:onPVEStartRespError(ecode)
	self:onStopBattle()
	UIManager.showConfirmWithId(1119)
end

return BattleAutoChallengeDlg
