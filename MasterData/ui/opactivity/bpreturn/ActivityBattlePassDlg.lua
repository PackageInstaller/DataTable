-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\BPReturn\\ActivityBattlePassDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local BPReturnMainPanel = require("UI/OpActivity/BPReturn/BPReturnMainPanel")
local BPReturnTaskPanel = require("UI/OpActivity/BPReturn/BPReturnTaskPanel")
local strClassName = "ActivityBattlePassDlg"
local ActivityBattlePassDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityBattlePassDlg, ActivityPanelMixin)

ActivityBattlePassDlg.subTabName = {
	Lang.get(50894),
	Lang.get(50895),
	Lang.get(50896),
	Lang.get(50897)
}

function ActivityBattlePassDlg:initUI()
	self.panelReturnBPInfo = BPReturnMainPanel(self, "BgPanel/ReturnBPInfo")
	self.panelReturnGetBPInfo = BPReturnTaskPanel(self, "BgPanel/ReturnGetBPInfo")
	self.textTime = UIControls.Label(self, "BgPanel/TextTime")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.btnSubTabs = {}
	self.redDots = {}

	for i = 1, 4 do
		self.btnSubTabs[i] = UIControls.Button(self, "BgPanel/TabPanel/Btn" .. i)

		self.btnSubTabs[i]:addEventClick(Functor(self.onSubTabClick, self, i))

		self.redDots[i] = UIControls.Panel(self, "BgPanel/TabPanel/Btn" .. i .. "/IconNew")
	end

	self.selectedBtnIdx = 1

	self.btnSubTabs[self.selectedBtnIdx]:setEnable(false)

	self.showRefreshTimes = 0
	self.tryGetAwardTimes = 0
end

function ActivityBattlePassDlg:onSubTabClick(idx)
	self.btnSubTabs[self.selectedBtnIdx]:setEnable(true)

	if self.selectedBtnIdx == idx then
		self.isNewData = true
	end

	self.selectedBtnIdx = idx

	self.btnSubTabs[self.selectedBtnIdx]:setEnable(false)

	if idx == 1 then
		self.panelReturnBPInfo:setVisible(true)
		self.panelReturnGetBPInfo:setVisible(false)
		self.panelReturnBPInfo:onSubTabClick(idx)
	else
		self.panelReturnBPInfo:setVisible(false)
		self.panelReturnGetBPInfo:setVisible(true)
		self.panelReturnGetBPInfo:onSubTabClick(self.isNewData, self.actDatas[idx - 1] or {})
	end

	self.isNewData = nil
end

function ActivityBattlePassDlg:onClickClose()
	self:setVisible(false)
end

function ActivityBattlePassDlg:onGetActivityBonus(actId, callback)
	callback()

	if self.selectedBtnIdx ~= 1 then
		self.panelReturnGetBPInfo:onGetActivityBonus()
	end
end

function ActivityBattlePassDlg:_setData()
	self.tryGetAwardTimes = 0
	self.showRefreshTimes = 0
	self.actTime = self.actObj.opActivityMgrItem
	self.roundMaxInfo = self.actObj.actData.roundMaxInfo

	local sData = self.actObj.actData.serverData

	self.clientData = self.actObj.actData:getActivityClientShowData()
	self.serverData = {}

	if sData then
		for i, v in pairs(sData) do
			self.serverData[i] = v
		end
	end

	self.relate_act = self.actObj.templateData and self.actObj.templateData.relate_act

	if self.relate_act then
		self.actDatas = {}

		for i, v in ipairs(self.relate_act) do
			self.actDatas[i] = CurAvatar:getActivityObj(v)
		end
	end

	self:refreshRedDot()

	local round = self:modf()

	self:onSubTabClick(self.selectedBtnIdx or 1)

	if not self.lv then
		self.lv = round
	end

	self:tryShowLvUp(round)
end

function ActivityBattlePassDlg:tryShowLvUp(lv)
	if lv and self.lv and lv > self.lv then
		if self.canShowLvUp then
			UIManager.getUI("bPLvUpResultBox", true):onShowNewText(Lang.get(51872), self.lv, lv)
		end

		self:setLvUpBoxEnable(false)
	end

	self.lv = lv
end

function ActivityBattlePassDlg:setLvUpBoxEnable(isShow)
	self.canShowLvUp = isShow
end

function ActivityBattlePassDlg:refreshRedDot()
	for index, redDotObj in ipairs(self.redDots) do
		if index == 1 then
			redDotObj:setVisible(self.actObj.actData:checkNew())
		elseif self.actDatas[index - 1] and self.actDatas[index - 1].actData then
			redDotObj:setVisible(self.actDatas[index - 1].actData:checkNew())
		end
	end
end

function ActivityBattlePassDlg:getFreezeTime()
	local freezetime = self.actTime.time and self.actTime.time.freezetime

	return os.date("%d", freezetime - os.time())
end

function ActivityBattlePassDlg:destroy()
	ActivityBattlePassDlg.super.destroy(self)

	if self.coFunc then
		coroutine.stop(self.coFunc)

		self.coFunc = nil
	end
end

function ActivityBattlePassDlg:modf()
	local cData = self.clientData

	self.actType = cData[1].type

	local svrData = self.serverData[self.actType] or {}

	self.clientMaxRound = self.roundMaxInfo[self.actType]

	if not svrData.progress then
		svrData.progress = 0
	end

	self.curProgress = svrData.progress

	local round = 0

	for _, cellData in ipairs(cData) do
		if svrData.progress > cellData.param then
			round = round + 1
		else
			if svrData.progress == cellData.param and round ~= 0 and svrData.progress < self.clientMaxRound then
				round = round + 1
			end

			break
		end

		if false then
			break
		end
	end

	if round == 0 then
		if svrData.progress == cData[1].param then
			return 1, 0, cData[2].param - cData[1].param
		end

		return 0, svrData.progress, cData[1].param
	elseif svrData.progress >= self.clientMaxRound then
		return #self.clientData, -1, -1, svrData.progress - self.clientMaxRound
	else
		return round, svrData.progress - cData[round].param, cData[round + 1].param - cData[round].param
	end
end

function ActivityBattlePassDlg:updateActivityData()
	self.showRefreshTimes = self.showRefreshTimes + 1

	if self:tryRefreshData() then
		self.tryGetAwardTimes = 0
		self.showRefreshTimes = 0

		if self.timerStageEnergyResume then
			self.timerStageEnergyResume:Stop()
		end

		self:_setData()
	end
end

function ActivityBattlePassDlg:tryRefreshData()
	if self.tryGetAwardTimes == 1 then
		return true
	elseif self.tryGetAwardTimes == self.showRefreshTimes then
		return true
	elseif self.tryGetAwardTimes > self.showRefreshTimes then
		if not self.timerStageEnergyResume then
			self.timerStageEnergyResume = Timer.New(Slot(self._setData, self), 5, 1)
		end

		self.timerStageEnergyResume:Restart()
	end

	return true
end

function ActivityBattlePassDlg:cacheAwardTimes()
	self.tryGetAwardTimes = self.tryGetAwardTimes + 1
end

function ActivityBattlePassDlg:onClose()
	ActivityBattlePassDlg.super.onClose(self)
	self.panelReturnGetBPInfo:onClose()
end

return ActivityBattlePassDlg
