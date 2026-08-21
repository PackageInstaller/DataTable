-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\SweepMainDlg.lua

local ResColor = require("ClientData/ResColor")
local ResStepCost = require("ClientData/ResStepCost")
local ResTower = require("ClientData/ResTower")
local ResEquipTower = require("ClientData/ResEquipTower")
local ResRandClient = require("ClientData/ResRandClient")
local ResGamePlayNotice = require("ClientData/ResGamePlayNotice")
local EventConst = require("EventConst")
local ResBossTowerExpandCamp = require("ClientData/ResBossTowerExpandCamp")
local ResBossTowerExpandLevel = require("ClientData/ResBossTowerExpandLevel")
local ResBossTowerExpandMisc = require("ClientData/ResBossTowerExpandMisc")
local strClassName = "SweepNeedPanel"
local SweepNeedPanel = Class(strClassName, UIControls.Panel)

function SweepNeedPanel:ctor()
	self.needNum = 0

	self:initUI()
end

function SweepNeedPanel:initUI()
	self.txtName = UIControls.Label(self, self.mPath .. "/TextName")
	self.txtNumHave = UIControls.Label(self, self.mPath .. "/TextNum")
	self.txtNumNeed = UIControls.Label(self, self.mPath .. "/TextNumNeed")
	self.txtClean = UIControls.Label(self, self.mPath .. "/TextClean/TextNum1")
	self.panelCleanSpeed = UIControls.Panel(self, self.mPath .. "/TextClean")
end

function SweepNeedPanel:refreshNeedPanel()
	local haveCostNum = CurAvatar:getItemNumById(self.needId)

	self.txtNumHave:setText(ClientUtils.getNumShortStr(haveCostNum))

	local strColor = haveCostNum >= self.needNum and ResColor.WHITE or ResColor.RED

	self.txtNumHave:setFontColor(strColor)
end

function SweepNeedPanel:setCleanSpeedInfo(num)
	self.panelCleanSpeed:setVisible(true)
	self.txtClean:setText(utils.format(Lang.get(50270), num))
end

function SweepNeedPanel:setNeedInfo(needId, needNum)
	self.needId = needId
	self.needNum = needNum or 0

	local fakeItem = BaseObject.GetObject(self.needId)

	if not self.awardGrid then
		self.awardGrid = UIControls.getGridChild(fakeItem, self, self.mPath .. "/GridPanel")
	end

	self.txtName:setText(fakeItem.name)
	self.awardGrid:setVisible(true)
	self.awardGrid:setObj(fakeItem)

	self.awardGrid.mEventClick = nil
	self.awardGrid.mDisableWays = true

	self.txtNumNeed:setText(self.needNum)

	local haveCostNum = CurAvatar:getItemNumById(self.needId)

	self.txtNumHave:setText(ClientUtils.getNumShortStr(haveCostNum))

	local strColor = haveCostNum >= self.needNum and ResColor.WHITE or ResColor.RED

	self.txtNumHave:setFontColor(strColor)
end

local strClassName = "SweepMainDlg"
local SweepMainDlg = Class(strClassName, UIControls.Window)

function SweepMainDlg:ctor()
	self:initUI()
end

function SweepMainDlg:initUI()
	self.awardGrids = {}
	self.imgIconEnergy = UIControls.Image(self, "BgPanel/FuncPanel/BtnClean/IconEnergy")
	self.imgIconEnergyAll = UIControls.Image(self, "BgPanel/FuncPanel/BtnCleanAll/IconEnergy")
	self.txtEnergyCost = UIControls.Label(self, "BgPanel/FuncPanel/BtnClean/TextNum")
	self.txtEnergyCostAll = UIControls.Label(self, "BgPanel/FuncPanel/BtnCleanAll/TextNum")
	self.txtSweepCountsAll = UIControls.Label(self, "BgPanel/FuncPanel/BtnCleanAll/Text")
	self.txtCleanNum = UIControls.Label(self, "BgPanel/FuncPanel/TextCleanNum")
	self.needPanel = SweepNeedPanel(self, "BgPanel/FuncPanel/NeedPanel")
	self.cleaningPanel = UIControls.Panel(self, "BgPanel/CleaningPanel")
	self.resultPanel = UIControls.UIAni(self, "BgPanel/ResultPanel")
	self.txtTitle2 = UIControls.Label(self, "BgPanel/TextTitle2")
	self.scrollResult = UIControls.ScrollView(self, "BgPanel/ResultPanel/ResultList")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnClean = UIControls.Button(self, "BgPanel/FuncPanel/BtnClean")

	self.btnClean:addEventClick(self.onBtnCleanClick)

	self.btnCleanAll = UIControls.Button(self, "BgPanel/FuncPanel/BtnCleanAll")

	self.btnCleanAll:addEventClick(self.onBtnCleanAllClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/FuncPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnSkip = UIControls.Button(self, "BgPanel/CleaningPanel/BtnSkip")

	self.btnSkip:addEventClick(self.onBtnSkipClick)

	self.slot4RefreshPower = Slot(self._refreshForPowerUpdate, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshPower)

	self.panelPowerNum = UIControls.Panel(self, "BgPanel/CapacityPanel")
	self.imgPower = UIControls.Image(self, "BgPanel/CapacityPanel/Icon")
	self.textPowerNum = UIControls.Label(self, "BgPanel/CapacityPanel/TextNum")
	self.imgSuperClean = UIControls.Panel(self, "BgPanel/FuncPanel/BtnClean/IconUp")
	self.imgSuperCleanAll = UIControls.Panel(self, "BgPanel/FuncPanel/BtnCleanAll/IconUp")
	self.imgClean = UIControls.Image(self, "BgPanel/ImgClean")
	self.panelHighLevel = UIControls.Panel(self, "BgPanel/HighLevelPanel")
	self.txtHighDes = UIControls.Label(self, "BgPanel/HighLevelPanel/TxtDes")
	self.btnJumpHigh = UIControls.Button(self, "BgPanel/HighLevelPanel/BtnChallenge")

	self.btnJumpHigh:addEventClick(self.onBtnJumpHighClick)

	self.lastSweepTick = 0
	self.panelExpandBossSweep = UIControls.Panel(self, "BgPanel/FuncPanel/UpPanel")
	self.imgPrivilege = UIControls.Image(self, "BgPanel/ImgPrivilege")
end

function SweepMainDlg:destroy()
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshPower)
	SweepMainDlg.super.destroy(self)
end

function SweepMainDlg:sweepStepTower(jumpArg, grid)
	local args = utils.splitString(jumpArg, ",")

	self.stepLayer = tonumber(args[1])
	self.stepLevel = tonumber(args[2])

	local hero = grid.hero
	local totalNeed = 0

	for i, v in ipairs(ResStepCost[hero.resData.step_up_id][hero.step + 1].materials) do
		if v.id == grid.object.id then
			totalNeed = v.num
		end
	end

	local towerRes = ResTower[self.stepLayer][self.stepLevel]
	local costNum = towerRes.power_cost
	local rewardIdSweep = towerRes.award
	local randItemSweep = ResRandClient[rewardIdSweep]
	local getNumOnce = 0

	for i, id in ipairs(randItemSweep.show_ids) do
		if id == grid.object.id then
			getNumOnce = randItemSweep.show_nums and randItemSweep.show_nums[i] and randItemSweep.show_nums[i] or 1
		end
	end

	local passNum = CurAvatar.stepTowerLayerData[self.stepLayer].stage[self.stepLevel].num

	self:initForSweepInfo(Const.GAME_PLAY_NOTICE_TOWER, Slot(self.sweepTower, self), Const.MONEY_ID_POWER, costNum, {
		remainTimes = towerRes.times - passNum,
		totalTimes = towerRes.times,
		needId = grid.object.id,
		needNum = totalNeed,
		getNumOnce = getNumOnce
	})
end

function SweepMainDlg:sweepEquipTower(jumpArg, grid)
	local args = utils.splitString(jumpArg, ",")

	self.equipTowerType = tonumber(args[1])
	self.equipTowerlayer = tonumber(args[2])

	local totalNeed = grid.needNum
	local towerRes = ResEquipTower[self.equipTowerType][self.equipTowerlayer]
	local costNum = towerRes.power_cost
	local rewardIdSweep = towerRes.normal_sweep_award
	local randItemSweep = ResRandClient[rewardIdSweep]
	local getNumOnce = 0

	for i, id in ipairs(randItemSweep.show_ids) do
		if id == grid.object.id then
			getNumOnce = randItemSweep.show_nums and randItemSweep.show_nums[i] and randItemSweep.show_nums[i] or 1
		end
	end

	self:initForSweepInfo(Const.GAME_PLAY_NOTICE_EQUIP_TOWER, Slot(self.sweepEquipTowerRPC, self), Const.MONEY_ID_POWER, costNum, {
		superNotice = "",
		defSweepCount = 10,
		superTimes = 0,
		needId = grid.object.id,
		needNum = totalNeed,
		getNumOnce = getNumOnce
	})
end

function SweepMainDlg:sweepBossExpand(jumpArg, grid)
	local args = utils.splitString(jumpArg, ",")

	self.bossExpandTower = tonumber(args[1])
	self.bossExpandlayer = tonumber(args[2])
	self.bossExpandLevel = CurAvatar:getBossExpandSweepDiff(self.bossExpandTower, self.bossExpandlayer)

	local totalNeed = grid.needNum or 0
	local levelConfig = ResBossTowerExpandLevel[self.bossExpandTower][self.bossExpandlayer]
	local towerRes = levelConfig[self.bossExpandLevel]

	if towerRes then
		local costNum = towerRes.power_cost
		local rewardIdSweep = towerRes.clean_award
		local randItemSweep = ResRandClient[rewardIdSweep]
		local getNumOnce = 0

		for i, id in ipairs(randItemSweep.show_ids) do
			if id == grid.object.id then
				getNumOnce = randItemSweep.show_nums and randItemSweep.show_nums[i] and randItemSweep.show_nums[i] or 1
			end
		end

		self.needPanel:setCleanSpeedInfo(getNumOnce)

		local remainCount, totalCount = CurAvatar:getBossExpandSweepCount(self.bossExpandTower)

		local function jumpFunc(self)
			CurAvatar:jumpToBossExpandCurStage(self.bossExpandTower, self.bossExpandlayer)
			self:setVisible(false)
		end

		if CurAvatar:isBossExpandCanFightHigher(self.bossExpandTower, self.bossExpandlayer) then
			self:showJumpHigh(Slot(jumpFunc, self), ClientUtils.getClientNotice(634))
		end

		self:initForSweepInfo(Const.GAME_PLAY_NOTICE_BOSS_EXPAND, Slot(self.sweepBossExpandRPC, self), Const.MONEY_ID_POWER, costNum, {
			superNotice = "",
			superTimes = 0,
			remainTimes = remainCount,
			totalTimes = totalCount,
			needId = grid.object.id,
			needNum = totalNeed,
			getNumOnce = getNumOnce,
			defSweepCount = CurAvatar:getBossExpandSweepMaxNum()
		})
	end
end

function SweepMainDlg:sweepBossExpandRPC(times)
	local data = {}

	data.tower = self.bossExpandTower
	data.layer = self.bossExpandlayer
	data.level = self.bossExpandLevel
	data.times = times

	RPC.campTowerSweep({
		data
	})
end

function SweepMainDlg:sweepTower(times)
	local sweepData = {}

	sweepData.layer = self.stepLayer
	sweepData.level = self.stepLevel
	sweepData.times = times

	RPC.towerSweep({
		sweepData
	})
end

function SweepMainDlg:sweepEquipTowerRPC(times)
	RPC.equipTowerSweep(self.equipTowerType, self.equipTowerlayer, times)
end

function SweepMainDlg:initForSweepInfo(gamePlayId, sweepRPC, costId, costNum, extraArgs)
	self:_initForSweepInfo(gamePlayId, sweepRPC, costId, costNum, extraArgs)
	self:setInitIsEnough()
end

function SweepMainDlg:_initForSweepInfo(gamePlayId, sweepRPC, costId, costNum, extraArgs)
	self.gamePlayId = gamePlayId
	self.sweepRPC = sweepRPC
	self.costId = costId
	self.costNum = costNum
	self.extraArgs = extraArgs
	self.needId = extraArgs.needId
	self.needNum = extraArgs.needNum or 0
	self.getNumOnce = extraArgs.getNumOnce
	self.remainTimes = extraArgs.remainTimes
	self.totalTimes = extraArgs.totalTimes
	self.superTimes = extraArgs.superTimes
	self.superNotice = extraArgs.superNotice
	self.defSweepCount = extraArgs.defSweepCount or 10

	if self.remainTimes then
		self.txtCleanNum:setVisible(true)
		self.txtCleanNum:setText(utils.format(Lang.get(50540), self.remainTimes, self.totalTimes))
	elseif self.superNotice then
		self.txtCleanNum:setVisible(true)
		self.txtCleanNum:setText(self.superNotice)
	else
		self.txtCleanNum:setVisible(false)
	end

	self.txtTitle2:setText(ResGamePlayNotice[self.gamePlayId].name)

	self.costItem = BaseObject.GetObject(self.costId)

	local iconPath = self.costItem:getIconPath()

	if iconPath then
		self.imgPower:setImage(iconPath[1], iconPath[2])
		self.imgIconEnergy:setImage(iconPath[1], iconPath[2])
		self.imgIconEnergyAll:setImage(iconPath[1], iconPath[2])
	end

	self.haveCostNum = ClientUtils.getMoney(self.costId)
	self.haveNeedNum = ClientUtils.getMoney(self.needId)

	self.textPowerNum:setText(self.haveCostNum .. "/" .. self.costNum)

	if self.gamePlayId == Const.GAME_PLAY_NOTICE_BOSS_EXPAND then
		local extraSweepNum = CurAvatar:getActPrivilege(Const.ACT_PRIVILEGE_TYPE_NEW_BOSS_SWEEP, 0)

		self.panelExpandBossSweep:setVisible(extraSweepNum > 0)
	end

	if self.gamePlayId == Const.GAME_PLAY_NOTICE_EQUIP_TOWER or self.gamePlayId == Const.GAME_PLAY_NOTICE_BOSS_EXPAND then
		self.imgPrivilege:setVisible(CurAvatar:checkPrivielgeMonthCardEffect())
	end
end

function SweepMainDlg:refreshForSweepInfo(gamePlayId, sweepRPC, costId, costNum, extraArgs)
	if extraArgs then
		self:_initForSweepInfo(gamePlayId, sweepRPC, costId, costNum, extraArgs)
		self:refreshSweepShow()
	end
end

function SweepMainDlg:refreshSweepShow()
	if self.needId then
		self.needPanel:setVisible(true)

		if not self.needPanel.needId then
			self.needPanel:setNeedInfo(self.needId, self.needNum)
		end

		self.needPanel:refreshNeedPanel()

		if not self.isInitEnough then
			self.sweepRealTimes = math.min(math.floor(self.haveCostNum / self.costNum), math.ceil(math.max(self.needNum - self.haveNeedNum, 1) / self.getNumOnce), self.remainTimes or 999, self.defSweepCount)
		else
			self.sweepRealTimes = math.min(math.floor(self.haveCostNum / self.costNum), self.remainTimes or 999, self.defSweepCount)
		end
	else
		self.needPanel:setVisible(false)

		self.sweepRealTimes = math.min(math.floor(self.haveCostNum / self.costNum), self.defSweepCount, self.remainTimes or 999)
	end

	if self.superTimes and self.superTimes > 0 then
		self.sweepRealTimes = math.min(self.sweepRealTimes, self.superTimes)

		self.imgSuperClean:setVisible(true)
		self.imgSuperCleanAll:setVisible(true)
	else
		self.imgSuperClean:setVisible(false)
		self.imgSuperCleanAll:setVisible(false)
	end

	local strColor = self.haveCostNum >= self.costNum and ResColor.GREYDIS or ResColor.RED

	self.txtEnergyCost:setText(self.costNum)
	self.txtEnergyCost:setFontColor(strColor)

	strColor = self.haveCostNum >= self.sweepRealTimes * self.costNum and ResColor.GREYDIS or ResColor.RED

	self.txtEnergyCostAll:setText(self.sweepRealTimes * self.costNum)
	self.txtSweepCountsAll:setFontColor(strColor)
	self.txtSweepCountsAll:setText(string.format(Lang.get(1871), self.sweepRealTimes))
	self.btnCleanAll:setVisible(self.sweepRealTimes > 1)
end

function SweepMainDlg:setInitIsEnough()
	self.isInitEnough = self.needNum ~= nil and self.needNum - self.haveNeedNum <= 0 or false

	self:refreshSweepShow()
end

local function _sortEquip(a, b)
	if a.quality ~= b.quality then
		return a.quality > b.quality
	else
		return a.part > b.part
	end
end

local function _sortItem(a, b)
	if a.quality ~= b.quality then
		return a.quality > b.quality
	else
		return a.id > b.id
	end
end

function SweepMainDlg:onShow(notifyType, attrs, items, heros, equip, artifact, showTitle)
	self.scrollResult:gotoTop()
	self.resultPanel:setVisible(true)
	self.resultPanel:startAni("ShowCleanResult", true)

	local clientItems = {}

	for _, item in pairs(ClientUtils.getAttrItems(attrs)) do
		table.insert(clientItems, item)
	end

	local equipsItem = ClientUtils.getCommonEquips(equip)

	table.sort(equipsItem, _sortEquip)

	for _, item in pairs(equipsItem) do
		table.insert(clientItems, item)
	end

	local commonItems = ClientUtils.getCommonItems(items)

	table.sort(commonItems, _sortItem)

	for _, item in pairs(commonItems) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonArtifactsById(artifact)) do
		table.insert(clientItems, item)
	end

	for index, item in ipairs(clientItems) do
		local newGrid = {}

		if not self.awardGrids[index] then
			newGrid = UIControls.getGridContainer(self, "BgPanel/ResultPanel/ResultList/Content")
			newGrid.mDisableWays = true
			self.awardGrids[index] = newGrid
		end

		self.awardGrids[index]:setObj(item)
		self:checkCustomEquipGet(self.awardGrids[index])
		self.awardGrids[index]:setVisible(true)
	end

	if #clientItems < #self.awardGrids then
		for index = #clientItems + 1, #self.awardGrids do
			self.awardGrids[index]:destroy()

			self.awardGrids[index] = nil
		end
	end

	self.scrollResult:setObjEnabled(#clientItems > 12)

	if notifyType ~= Const.LISTATTR_USETYPE_EQUIPTOWER_SWEEP then
		self:refreshForSweepInfo(self.gamePlayId, self.sweepRPC, self.costId, self.costNum, self.extraArgs)
	end

	CurAvatar:refreshHeroDetail()

	if not self.isInitEnough and self.needId and self.haveNeedNum >= self.needNum then
		self.btnConfirm:setVisible(true)
		self.btnCleanAll:setVisible(false)
		self.btnClean:setVisible(false)
	end

	self.lastSweepTick = 0
end

function SweepMainDlg:showJumpHigh(jumpFunc, desc)
	self.jumpHighFunc = jumpFunc

	self.txtHighDes:setText(desc or "")
	self.panelHighLevel:setVisible(true)
end

function SweepMainDlg:onReconnect()
	self:_refreshForPowerUpdate(CurAvatar.realPowerNum)
end

function SweepMainDlg:_refreshForPowerUpdate(power)
	self:refreshForSweepInfo(self.gamePlayId, self.sweepRPC, self.costId, self.costNum, self.extraArgs)
end

function SweepMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function SweepMainDlg:onBtnCleanClick()
	if not self.costNum then
		return
	end

	if ClientUtils.getServerTime() - self.lastSweepTick < 5 then
		return
	end

	if self.haveCostNum < self.costNum then
		if self.costId == Const.MONEY_ID_POWER then
			UIManager.getUI("buyCapacityDlg", true):initBuyType()
			self:setVisible(false)
		else
			MsgManager.notice(string.format(Lang.get(30228), self.costItem.name))
		end
	elseif self.remainTimes and self.remainTimes < 1 then
		MsgManager.notice(Lang.get(30229))
	else
		if self.remainTimes then
			self.remainTimes = self.remainTimes - 1
			self.extraArgs.remainTimes = self.remainTimes
		end

		self.lastSweepTick = ClientUtils.getServerTime()

		self.sweepRPC(1)
	end
end

function SweepMainDlg:onBtnCleanAllClick()
	if not self.costNum then
		return
	end

	if ClientUtils.getServerTime() - self.lastSweepTick < 5 then
		return
	end

	if self.haveCostNum < self.costNum * self.sweepRealTimes then
		if self.costId == Const.MONEY_ID_POWER then
			UIManager.getUI("buyCapacityDlg", true):initBuyType()
			self:setVisible(false)
		else
			MsgManager.notice(string.format(Lang.get(30228), self.costItem.name))
		end
	elseif self.remainTimes and self.remainTimes < 1 then
		MsgManager.notice(Lang.get(30229))
	else
		if self.remainTimes then
			self.remainTimes = self.remainTimes - self.sweepRealTimes
			self.extraArgs.remainTimes = self.remainTimes
		end

		self.lastSweepTick = ClientUtils.getServerTime()

		self.sweepRPC(self.sweepRealTimes)
	end
end

function SweepMainDlg:onBtnConfirmClick()
	self:setVisible(false)
end

function SweepMainDlg:onBtnSkipClick()
	self.sweepRPC(self.sweepRealTimes)
end

function SweepMainDlg:onBtnJumpHighClick(...)
	if self.jumpHighFunc then
		self.jumpHighFunc()
	end
end

function SweepMainDlg:refreshEquipTowerSweepInfo(superTimes, superNotice)
	if self.gamePlayId == Const.GAME_PLAY_NOTICE_EQUIP_TOWER then
		self.superTimes = superTimes
		self.superNotice = superNotice
		self.extraArgs.superTimes = superTimes
		self.extraArgs.superNotice = superNotice
	end
end

function SweepMainDlg:checkCustomEquipGet(grid)
	if grid.object.itemType == Const.ITEM_TYPE_EQUIP and grid.object:isDefineHeroEquip() then
		if not grid.customEquipEfx then
			local child = UIControls.Child(grid, "", "System/Common/Grid/GridAwardContainerEfxSpe", 0, 0, true)

			grid.customEquipEfx = child
		else
			grid.customEquipEfx:setVisible(true)
		end
	elseif grid.customEquipEfx then
		grid.customEquipEfx:setVisible(false)
	end
end

return SweepMainDlg
