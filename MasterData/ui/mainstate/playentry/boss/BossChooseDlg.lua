-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossChooseDlg.lua

local ResColor = require("ClientData/ResColor")
local ResBossTower = require("ClientData/ResBossTower")
local ResBossTowerMisc = require("ClientData/ResBossTowerMisc")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResBossTowerExpandMisc = require("ClientData/ResBossTowerExpandMisc")
local BossChooseExpandEntry = Class("BossChooseExpandEntry", UIControls.Button)

function BossChooseExpandEntry:ctor(...)
	self:initUI()
end

function BossChooseExpandEntry:initUI(...)
	self.txtNum = UIControls.Label(self, self.mPath .. "/OpenPanel/TextNum")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.redHint = UIControls.RedDot(self, self.mPath .. "/IconNew")

	local panelSweepExtra1 = UIControls.Panel(self, self.mPath .. "/UpPanel")
	local extraSweepNum = CurAvatar:getActPrivilege(Const.ACT_PRIVILEGE_TYPE_NEW_BOSS_SWEEP, 0)

	panelSweepExtra1:setVisible(extraSweepNum > 0)
end

function BossChooseExpandEntry:setData(bossType)
	self.bType = bossType

	local bossData = ResBossTower[bossType]

	self.redHint:addHint({
		UIConst["RD_HINT_CHALLENGE_BOSS_EXPAND_" .. self.bType]
	})
	self.txtTitle:setText(bossData[1].name)
	self:refreshCleanTimes()
end

function BossChooseExpandEntry:refreshCleanTimes(...)
	if CurAvatar.bossExpandData and CurAvatar.bossExpandData.boss_data then
		local total = CurAvatar:getBossExpandSweepMaxNum()
		local cleanedTimes = CurAvatar.bossExpandData.boss_data[self.bType].sweep_cnt or 0
		local leftTimes = math.max(total - cleanedTimes, 0)

		self.txtNum:setText(string.format(Lang.get(50280), leftTimes, total))
	end
end

local BossChooseEntry = Class("BossChooseEntry", UIControls.Button)

function BossChooseEntry:ctor()
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.panelOpen = UIControls.Panel(self, self.mPath .. "/OpenPanel")
	self.txtNum = UIControls.Label(self, self.mPath .. "/OpenPanel/TextNum")
	self.txtTimeUpdate = UIControls.Label(self, self.mPath .. "/OpenPanel/TextNumBreak")

	local timeClosePath = self.mPath .. "/OpenPanel/TextLockNum"

	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.lockPanel = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.txtUnlock = UIControls.Label(self, self.mPath .. "/LockPanel/TextLv")
end

function BossChooseEntry:_checkEntryData(dayInfos)
	if dayInfos == nil then
		self._timeCheck = ClientUtils.getServerTimeNextDay()

		return false
	end

	self._timeCheck = nil

	for i, wday in ipairs(dayInfos) do
		local nextTime = ClientUtils.getServerTimeNextWday(wday)

		if nextTime then
			if self._timeCheck then
				self._timeCheck = math.min(nextTime, self._timeCheck)
			else
				self._timeCheck = nextTime
			end
		else
			self._timeCheck = ClientUtils.getServerTimeNextDay()
			self._timeCheckClose = nil

			for j = 1, 7 do
				local findWday = wday + j

				if findWday > 7 then
					findWday = findWday - 7
				end

				local isFind = false

				for k, wwday in ipairs(dayInfos) do
					if wwday == findWday then
						self._timeCheckClose = self._timeCheck + j * 24 * 3600
						isFind = true

						break
					end
				end

				if not isFind then
					break
				end
			end

			if self._timeCheckClose then
				self._timeCheckClose = nil
			else
				self._timeCheckClose = self._timeCheck
				self._timeCheck = nil
			end

			return false
		end
	end

	return true
end

function BossChooseEntry:setData(bossType)
	local bossData = ResBossTower[bossType]
	local defData = ResBossTowerMisc[bossType]

	if bossData == nil or defData == nil or CurAvatar == nil then
		return
	end

	self.bType = bossType
	self._timeCheck = nil
	self._timeCheckClose = nil

	self.txtTitle:setText(bossData[1].name)

	self.isLock = false

	if self.bType == Const.BOSS_TOWER_TYPE_ZOMBIE and (not CurAvatar:isInCircle() or ConditionLimitManager.inLimitState(defData.lock_id)) then
		local lockDesc = ""
		local conditionData = ResConditionLimit[defData.lock_id] or {}

		if ConditionLimitManager.inLimitState(defData.lock_id) then
			lockDesc = conditionData.unlock_desc or Lang.get(30513)
			self.msgLock = utils.format(Lang.get(30511), ResClientNotice[191].notice, conditionData.unlock_desc or Lang.get(30513))
		else
			lockDesc = "<color=#11C116>" .. (conditionData.unlock_desc or Lang.get(30513)) .. "</color>"

			if RegionUtils.isJP() then
				self.msgLock = ResClientNotice[191].notice
			else
				self.msgLock = string.format(Lang.get(30512), ResClientNotice[191].notice)
			end
		end

		if CurAvatar:isInCircle() then
			lockDesc = lockDesc .. "\n<color=#11C116>" .. ResClientNotice[191].notice .. "</color>"
		else
			lockDesc = lockDesc .. "\n" .. ResClientNotice[191].notice
		end

		self.lockPanel:setVisible(true)
		self.txtUnlock:setText(lockDesc)

		self.isLock = true
	elseif ConditionLimitManager.inLimitState(defData.lock_id) then
		local conditionData = ResConditionLimit[defData.lock_id] or {}

		self.lockPanel:setVisible(true)
		self.txtUnlock:setText(conditionData.unlock_desc)

		self.msgLock = conditionData.unlock_desc or Lang.get(30513)
		self.isLock = true
	else
		local imgRD = UIControls.RedDot(self, self.mPath .. "/IconNew")

		imgRD:addHint({
			UIConst["RD_HINT_CHALLENGE_BOSS_" .. self.bType]
		})
	end

	if not self.isLock then
		if self:_checkEntryData(defData.open_days) then
			self.isLock = true
			self.msgLock = Lang.get(30514)
		end
	elseif self.txtTimeUnlock then
		self.txtTimeUnlock:setText("")
	end

	self.txtTimeUpdate:setText("")
	self.panelLock:setVisible(self.isLock)
	self.panelOpen:setVisible(not self.isLock)

	if not self.isLock and ClientUtils.getServerTime() < ClientUtils.getServerTimeNextDay() then
		local remainTime = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime() + 5

		ClientTimerManager.AddSecondFormatTickUI(self.txtTimeUpdate, remainTime, false, Lang.get(48670))
	end

	self.txtNum:setText("")
end

local BOSS_SHOW_TYPE = {
	NEW = 2,
	OLD = 1
}
local BOSS_CONFIG = {
	[BOSS_SHOW_TYPE.OLD] = {
		class = BossChooseEntry,
		redDot = UIConst.RD_HINT_CHALLENGE_BOSS,
		name = Lang.get(727)
	},
	[BOSS_SHOW_TYPE.NEW] = {
		class = BossChooseExpandEntry,
		redDot = UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND,
		name = Lang.get(48602)
	}
}
local BOSS_NUMS = 2
local strClassName = "BossChooseDlg"
local BossChooseDlg = Class(strClassName, UIControls.Window)

function BossChooseDlg:ctor()
	self:initUI()

	self.showType = BOSS_SHOW_TYPE.OLD
end

function BossChooseDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelTime = UIControls.Panel(self, "MainInfoPanel/FunPanel/TimePanel")
	self.txtTime = UIControls.Label(self, "MainInfoPanel/FunPanel/TimePanel/TxtTime")
	self.entrysBoss = {}

	for j = 1, BOSS_NUMS do
		local btn = UIControls.Button(self, "MainInfoPanel/FunPanel/BtnTower" .. j)

		btn:addEventClick(self.onBossShowTabClick)

		local redDot = UIControls.RedDot(self, "MainInfoPanel/FunPanel/BtnTower" .. j .. "/IconNew")

		redDot:addHint({
			BOSS_CONFIG[j].redDot
		})

		btn.type = j

		btn:setVisible(Const.IS_NEW_BOSSTOWER_SHOW and not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_EXPAND))

		local page = {
			btns = {}
		}

		page.tab = btn

		local path = "MainInfoPanel/ChallengeBossPanel" .. j

		page.panel = UIControls.Panel(self, path)

		page.panel:setVisible(false)

		self.entrysBoss[j] = page

		for i = 1, #ResBossTower do
			local entry = BOSS_CONFIG[j].class(self, path .. "/BtnBoss" .. i)

			entry:addEventClick(self.onEntryClick)

			entry.id = i
			entry.showType = j
			self.entrysBoss[j].btns[i] = entry
		end
	end

	self.needRefresh = true

	self.panelTime:setVisible(true)

	self.imgPriVilege = UIControls.Image(self, "ImgPrivilege")
end

function BossChooseDlg:onOpen()
	BossChooseDlg.super.onOpen(self)

	self.isFirstIn = true

	self:show()
end

function BossChooseDlg:show()
	if self.needRefresh then
		for _, info in ipairs(self.entrysBoss) do
			for i, entry in ipairs(info.btns) do
				entry:setData(i)
			end
		end
	end

	self.needRefresh = nil

	self:refreshTime()

	local state, time = CurAvatar:checkPrivielgeMonthCardEffect()

	if state then
		self.imgPriVilege:setVisible(true)
	else
		self.imgPriVilege:setVisible(false)

		if time then
			CurAvatar:checkPrivilegeMonthCardLapseShow(time, Const.PRIVITY_KEY_EXPAND_BOSS)
		end
	end
end

function BossChooseDlg:initShow(...)
	self:jumpPage()
end

function BossChooseDlg:jumpPage(pageType)
	self.showType = pageType or self.showType

	local page = self.entrysBoss[self.showType]

	self:onBossShowTabClick(page.tab)
end

function BossChooseDlg:refreshTime(...)
	local leftTime = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime()

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48670), Slot(self.refreshTime, self))
end

function BossChooseDlg:refreshUI(...)
	local page = self.entrysBoss[BOSS_SHOW_TYPE.NEW]

	if page then
		for i, btn in ipairs(page.btns) do
			btn:refreshCleanTimes()
		end
	end
end

function BossChooseDlg:entryBoss(bossType, winResult)
	if self.isFirstIn then
		self:jumpPage(BOSS_SHOW_TYPE.OLD)
	end

	local page = self.entrysBoss[self.showType]
	local bTypes = {}

	for i, entry in ipairs(page.btns) do
		if not entry.isLock then
			table.insert(bTypes, entry.bType)
		end
	end

	UIManager.getUI("bossMainDlg", true):show(bossType, bTypes, winResult)
end

function BossChooseDlg:entryExpandBoss(bossType, camp, layer)
	if self.isFirstIn then
		self:jumpPage(BOSS_SHOW_TYPE.NEW)
	end

	local page = self.entrysBoss[self.showType]
	local bTypes = {}

	for i, entry in ipairs(page.btns) do
		if not entry.isLock then
			table.insert(bTypes, entry.bType)
		end
	end

	UIManager.getUI("bossExpandMainDlg", true):show(bossType, bTypes, camp, layer)
end

function BossChooseDlg:refreshPageShow()
	local page = self.entrysBoss[self.showType]

	if page then
		page.panel:setVisible(true)
		page.tab:setEnable(false)
	end

	local name = BOSS_CONFIG[self.showType].name

	self.btnClose:setText(name)

	if self.isFirstIn then
		self.isFirstIn = nil
	else
		self:playAni("ShowChallengeBossPanel" .. self.showType)
	end
end

function BossChooseDlg:onBossShowTabClick(sender)
	local page = self.entrysBoss[self.showType]

	if page then
		page.panel:setVisible(false)
		page.tab:setEnable(true)
	end

	self.showType = sender.type

	self:refreshPageShow()
end

function BossChooseDlg:onEntryClick(sender)
	if sender.showType == BOSS_SHOW_TYPE.OLD then
		if sender.isLock then
			MsgManager.notice(sender.msgLock or "")

			return
		end

		self:entryBoss(sender.id)
	else
		if sender.isLock then
			MsgManager.notice(sender.msgLock or "")

			return
		end

		self:entryExpandBoss(sender.id)
	end
end

function BossChooseDlg:onBtnCloseClick(sender)
	self:setVisible(false)
end

return BossChooseDlg
