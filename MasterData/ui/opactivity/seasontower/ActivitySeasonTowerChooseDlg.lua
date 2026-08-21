-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerChooseDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local MAX_TEAM_NUM = 4
local strClassName = "ActivitySeasonTowerGroupCell"
local ActivitySeasonTowerGroupCell = Class(strClassName, UIControls.Panel)

function ActivitySeasonTowerGroupCell:ctor()
	self.textProgress = UIControls.Label(self, self.mPath .. "/ProgressPanel/Txt")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.textLock = UIControls.Label(self, self.mPath .. "/LockPanel/Txt")
	self.btnSensor = UIControls.Button(self, self.mPath)

	self.btnSensor:addEventClick(self.onSensorClick)

	self.imgGame = UIControls.RawImage(self, self.mPath .. "/GamePanel/ImgGame")
	self.iconTeam = {}

	for index = 1, MAX_TEAM_NUM do
		local newIcon = UIControls.Image(self, self.mPath .. "/TeamPanel/Team" .. index)

		table.insert(self.iconTeam, newIcon)
	end

	self.aniCell = UIControls.UIAni(self, self.mPath)
	self.panelNew = UIControls.Panel(self, self.mPath .. "/IconNew")
end

function ActivitySeasonTowerGroupCell:setData(towerData)
	self.towerData = towerData
	self.towerId = towerData.towerId

	self.textProgress:setText(utils.format(Lang.get(30635), towerData.passedLayer, #towerData.stageData))

	local teamLimit = towerData.teamLimit

	for index, icon in ipairs(self.iconTeam) do
		local team = teamLimit[index]

		if team and UIConst.HERO_TEAM_CONFIG[team] then
			icon:setVisible(true)
			icon:setImage(UIConst.HERO_TEAM_CONFIG[team].iconPath, UIConst.HERO_TEAM_CONFIG[team].iconS)
		else
			icon:setVisible(false)
		end
	end

	if towerData.weekConfig.icon then
		self.imgGame:setImage("NoAlpha/SeasonTower/" .. towerData.weekConfig.icon)
	end
end

function ActivitySeasonTowerGroupCell:setState(isLock, towerTime, isLast)
	self.isLock = isLock
	self.towerTime = towerTime

	self.panelLock:setVisible(true)
	self.textLock:setText(towerTime or "")
	self.textLock:setFontColor(ResColor.WHITE)

	if self.isLock then
		self.imgGame:setObjGray(true)

		if towerTime and towerTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textLock, towerTime, false, Lang.get(45383))
		else
			ClientTimerManager.RemoveSecondTickUI(self.textLock)
			self.textLock:setText(Lang.get(30622))
		end
	else
		self.imgGame:setObjGray(false)

		if towerTime and towerTime > 0 then
			if isLast then
				self.textLock:setFontColor(ResColor.RED)
				ClientTimerManager.AddSecondFormatTickUI(self.textLock, towerTime, false, Lang.get(48685))
			else
				ClientTimerManager.AddSecondFormatTickUI(self.textLock, towerTime, false, Lang.get(48655))
			end
		else
			ClientTimerManager.RemoveSecondTickUI(self.textLock)
			self.textLock:setText("")
		end
	end

	if not self.isLock and self.mParent.actObj.actData:getTowerBuffNew(self.towerId) then
		self.panelNew:setVisible(true)
	else
		self.panelNew:setVisible(false)
	end
end

function ActivitySeasonTowerGroupCell:onSensorClick()
	if self.isLock then
		MsgManager.notice(Lang.get(30638))
	else
		self.mParent:onCellClick(self)
	end
end

local strClassName = "ActivitySeasonTowerLimitCell"
local ActivitySeasonTowerLimitCell = Class(strClassName, UIControls.Panel)

function ActivitySeasonTowerLimitCell:ctor()
	self.textProgress = UIControls.Label(self, self.mPath .. "/ProgressPanel/Txt")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.textLock = UIControls.Label(self, self.mPath .. "/LockPanel/Txt")
	self.btnSensor = UIControls.Button(self, self.mPath)

	self.btnSensor:addEventClick(self.onSensorClick)

	self.imgGame = UIControls.Image(self, self.mPath .. "/GamePanel/ImgGame")
	self.panelNew = UIControls.Panel(self, self.mPath .. "/IconNew")
end

function ActivitySeasonTowerLimitCell:setData(towerData)
	self.towerData = towerData
	self.towerId = towerData.towerId

	self.textProgress:setText(string.format(Lang.get(30086), towerData.passedLayer))

	self.teamId = towerData.towerConfig.group_limit

	if UIConst.HERO_TEAM_CONFIG[self.teamId] then
		self.imgGame:setImage(UIConst.HERO_TEAM_CONFIG[self.teamId].cellIconPath, UIConst.HERO_TEAM_CONFIG[self.teamId].cellIcon)
	end
end

function ActivitySeasonTowerLimitCell:setState(isLock, towerTime, isLast)
	self.isLock = isLock
	self.towerTime = towerTime

	self.panelLock:setVisible(true)
	self.textLock:setFontColor(ResColor.WHITE)

	if self.isLock then
		self.imgGame:setImageGray(true)

		if towerTime and towerTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textLock, towerTime, false, Lang.get(45383))
		else
			ClientTimerManager.RemoveSecondTickUI(self.textLock)
			self.textLock:setText(Lang.get(30622))
		end
	else
		self.imgGame:setImageGray(false)

		if towerTime and towerTime > 0 then
			if isLast then
				self.textLock:setFontColor(ResColor.RED)
				ClientTimerManager.AddSecondFormatTickUI(self.textLock, towerTime, false, Lang.get(48685))
			else
				ClientTimerManager.AddSecondFormatTickUI(self.textLock, towerTime, false, Lang.get(48655))
			end
		else
			ClientTimerManager.RemoveSecondTickUI(self.textLock)
			self.textLock:setText("")
		end
	end

	if not self.isLock and self.mParent.actObj.actData:getTowerBuffNew(self.towerId) then
		self.panelNew:setVisible(true)
	else
		self.panelNew:setVisible(false)
	end
end

function ActivitySeasonTowerLimitCell:onSensorClick()
	if self.isLock then
		MsgManager.notice(Lang.get(30638))
	else
		self.mParent:onCellClick(self)
	end
end

local strClassName = "ActivitySeasonTowerChooseDlg"
local ActivitySeasonTowerChooseDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySeasonTowerChooseDlg, ActivityPanelMixin)

local MAX_GROUP_TOWER_NUM = 3

function ActivitySeasonTowerChooseDlg:initUI()
	self.hasLimitTower = self.actObj.actData:hasLimitTower()
	self.textActTime = UIControls.Label(self, "MainInfoPanel/TxtTime")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onClickTips)

	self.btnRank = UIControls.Button(self, "MainInfoPanel/BtnRank")

	self.btnRank:addEventClick(self.onRankClick)

	self.btnAward = UIControls.Button(self, "MainInfoPanel/BtnAward")

	self.btnAward:addEventClick(self.onAwardClick)

	self.panelAwardNew = UIControls.Panel(self, "MainInfoPanel/BtnAward/IconNew")
	self.groupCells = {}
	self.limitCells = {}
	self.imgShelf = {}

	for index = 1, MAX_GROUP_TOWER_NUM do
		local newGroupCell = ActivitySeasonTowerGroupCell(self, "MainInfoPanel/BtnMixTower" .. index)

		table.insert(self.groupCells, newGroupCell)

		if self.hasLimitTower then
			local newLimitCell1 = ActivitySeasonTowerLimitCell(self, "MainInfoPanel/BtnLimitTower" .. index * 2 - 1)

			table.insert(self.limitCells, newLimitCell1)

			local newLimitCell2 = ActivitySeasonTowerLimitCell(self, "MainInfoPanel/BtnLimitTower" .. index * 2)

			table.insert(self.limitCells, newLimitCell2)
		end

		local newGroupShelf = UIControls.Image(self, "MainInfoPanel/BgDec/ImgShelf" .. index + 3)

		table.insert(self.imgShelf, newGroupShelf)
	end

	self.btnHangUp = UIControls.Button(self, "MainInfoPanel/BtnHangUp")

	self.btnHangUp:addEventClick(self.onHangUpClick)

	self.aniHangUp = UIControls.UIAni(self, "MainInfoPanel/BtnHangUp/Icon")
	self.iconHangUpNew = UIControls.Panel(self, "MainInfoPanel/BtnHangUp/IconNew")
	self.textHangUpSpeed = UIControls.Label(self, "MainInfoPanel/BtnHangUp/AwardSpeedPanel/TextNum")
	self.textHangUp = UIControls.Label(self, "MainInfoPanel/BtnHangUp/AwardTotalPanel/TextNum")
	self.timerHangUp = Timer.New(Slot(self.refreshHangUp, self), 30, -1)

	self.timerHangUp:Start()
end

function ActivitySeasonTowerChooseDlg:onHangUpClick(sender)
	if self.itemNum > 0 then
		RPC.opActTowerGetDepositAward(self.actObj.opId)
		FlyIconUtils.sendFlyEvent(sender, self.actObj.actData.hookItemId, self.actObj.actData:getHookBonusNum())
	end
end

function ActivitySeasonTowerChooseDlg:refreshHangUp()
	self.itemNum = self.actObj.actData:getHookBonusNum()

	self.textHangUpSpeed:setText(string.format(Lang.get(30636), self.actObj.actData:getDepositValue()))
	self.textHangUp:setText(self.itemNum)

	local hasNew = false

	if self.itemNum > 0 then
		if self.actObj.actData:getRemainOpenTime() < 0 and self.actObj.actData:getFreezeOpenTime() > 0 then
			hasNew = true
		elseif ClientUtils.getServerTime() - self.actObj.actData.lastGetTick > 43200 then
			hasNew = true
		end

		if hasNew then
			self.iconHangUpNew:setVisible(true)
			self.aniHangUp:stopAni("LoopAwardGet")
		elseif ClientUtils.getServerTime() - self.actObj.actData.lastGetTick > 21600 then
			self.iconHangUpNew:setVisible(false)
			self.aniHangUp:startAniLoop("LoopAwardGet")
		else
			self.iconHangUpNew:setVisible(false)
			self.aniHangUp:stopAni("LoopAwardGet")
		end
	else
		self.iconHangUpNew:setVisible(false)
		self.aniHangUp:stopAni("LoopAwardGet")
	end
end

function ActivitySeasonTowerChooseDlg:_setData()
	self:_refreshData()
	self.actObj.actData:refreshTowerBuffData()

	if not self.actObj.actData:isTowerSweeped() and self.actObj.actData:getRemainOpenTime() > 0 then
		RPC.opActTowerSweep(self.actObj.opId)
	end

	RPC.opActTowerEnter(self.actObj.opId)

	local mainColor = self.clientTemplateData.main_color

	if mainColor then
		self.textActTime:setColorByRGBA(mainColor[1] / 255, mainColor[2] / 255, mainColor[3] / 255, 1)
	end

	ClientTimerManager.AddSecondFormatTickUI(self.textActTime, self.actObj:getRemainOpenTime(), false, Lang.get(48686), Slot(self._actTimerOver, self))
end

function ActivitySeasonTowerChooseDlg:_actTimerOver()
	if self.textActTime and self.textActTime:isAlive() then
		self.textActTime:setText(Lang.get(30622))
	end
end

function ActivitySeasonTowerChooseDlg:_refreshData()
	self.openedTower = {}

	local actData = self.actObj.actData

	self.groupData = actData:getGroupTowerData()

	local cachedNew = CurAvatar:getNewDataCache(Const.NEW_DATA_CACHE_SEASON_TOWER)

	for index = 1, MAX_GROUP_TOWER_NUM do
		local oneGroupData = self.groupData[index]
		local groupData = oneGroupData[1]
		local isLock, lockTime, isLast = actData:isTowerLocked(groupData.towerId)

		if not oneGroupData[2] then
			self.groupCells[index]:setVisible(true)
			self.groupCells[index]:setData(oneGroupData[1])
			self.groupCells[index]:setState(isLock, lockTime, isLast)

			if self.hasLimitTower then
				self.limitCells[index * 2 - 1]:setVisible(false)
				self.limitCells[index * 2]:setVisible(false)
			end

			self.imgShelf[index]:setVisible(false)

			if not isLock then
				self.openedTower[oneGroupData[1].towerId] = true
			end
		else
			if cachedNew == index then
				if self.mOpening then
					self.needPlaySplitAnim = {
						index,
						oneGroupData[1]
					}
				else
					self:playSplitAnim(index, oneGroupData[1])
				end
			else
				self.groupCells[index]:setVisible(false)
			end

			if self.hasLimitTower then
				self.limitCells[index * 2 - 1]:setVisible(true)
				self.limitCells[index * 2 - 1]:setData(oneGroupData[2])
				self.limitCells[index * 2 - 1]:setState(isLock, lockTime, isLast)
				self.limitCells[index * 2]:setVisible(true)
				self.limitCells[index * 2]:setData(oneGroupData[3])
				self.limitCells[index * 2]:setState(isLock, lockTime, isLast)
			end

			self.imgShelf[index]:setVisible(true)

			if not isLock then
				self.openedTower[oneGroupData[2].towerId] = true
				self.openedTower[oneGroupData[3].towerId] = true
			end
		end
	end

	if self.actObj.actData:checkScoreAchieveNew() then
		self.panelAwardNew:setVisible(true)
	else
		self.panelAwardNew:setVisible(false)
	end

	self:refreshHangUp()
end

function ActivitySeasonTowerChooseDlg:onOpenOver()
	ActivitySeasonTowerChooseDlg.super.onOpenOver(self)

	if self.needPlaySplitAnim then
		self:playSplitAnim(self.needPlaySplitAnim[1], self.needPlaySplitAnim[2])

		self.needPlaySplitAnim = nil
	end
end

function ActivitySeasonTowerChooseDlg:destroy()
	self.timerHangUp:Stop()
	ActivitySeasonTowerChooseDlg.super.destroy(self)
end

function ActivitySeasonTowerChooseDlg:playSplitAnim(index, groupData)
	self.groupCells[index]:setVisible(true)
	self.groupCells[index]:setData(groupData)
	self:playAni("ShowLimitTower" .. index)
end

function ActivitySeasonTowerChooseDlg:activityStateShow(actObj, extraStateArgs)
	local towerId = extraStateArgs

	if self.openedTower[towerId] then
		for index, cell in ipairs(self.groupCells) do
			if cell.towerId == towerId and cell:getVisible() then
				cell:onSensorClick()

				return
			end
		end

		for index, cell in ipairs(self.limitCells) do
			if cell.towerId == towerId and cell:getVisible() then
				cell:onSensorClick()

				return
			end
		end
	end
end

function ActivitySeasonTowerChooseDlg:onCellClick(sender)
	if sender.towerData then
		UIManager.getUI("activitySeasonTowerInfoDlg", true):onShowTower(self.actObj, sender.towerData.towerId)
	end
end

function ActivitySeasonTowerChooseDlg:onAwardClick()
	if self.hasLimitTower then
		UIManager.getUI("activitySeasonTowerScoreAwardDlg", true):onShowActivity({
			self.actObj.clientTemplateData,
			self.actObj
		})
	else
		UIManager.getUI("activityNoLimitScoreAwardDlg", true):onShowActivity({
			self.actObj.clientTemplateData,
			self.actObj
		})
	end
end

function ActivitySeasonTowerChooseDlg:onRankClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_SEASON_TOWER_SCORE, 0)
end

function ActivitySeasonTowerChooseDlg:onClickClose()
	self:setVisible(false)
end

function ActivitySeasonTowerChooseDlg:onClickTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(self.actObj.actData.miscData.rule_tips_id)
end

function ActivitySeasonTowerChooseDlg:updateActivityData()
	self:_refreshData()

	local activitySeasonTowerScoreAwardDlg = UIManager.tryGetUI("activitySeasonTowerScoreAwardDlg")

	if activitySeasonTowerScoreAwardDlg then
		activitySeasonTowerScoreAwardDlg:updateActivityData()
	end

	local activityNoLimitScoreAwardDlg = UIManager.tryGetUI("activityNoLimitScoreAwardDlg")

	if activityNoLimitScoreAwardDlg then
		activityNoLimitScoreAwardDlg:updateActivityData()
	end

	local activitySeasonTowerInfoDlg = UIManager.tryGetUI("activitySeasonTowerInfoDlg")

	if activitySeasonTowerInfoDlg then
		activitySeasonTowerInfoDlg:updateActivityData()
	end
end

function ActivitySeasonTowerChooseDlg:onNewRefresh()
	self:_refreshData()
end

return ActivitySeasonTowerChooseDlg
