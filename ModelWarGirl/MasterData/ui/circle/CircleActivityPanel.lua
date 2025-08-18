-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleActivityPanel.lua

local ResBossTowerMisc = require("ClientData/ResBossTowerMisc")
local strClassName = "CircleActivityPanel"
local CircleActivityPanel = Class(strClassName, UIControls.Panel)
local GatherActivityCircleBattleBtn = require("UI/ActivityGather/GatherActivityCircleBattleBtn")
local BtnCircleBattleHonor = require("UI/Circle/BtnCircleBattleHonor")
local ActivityEntry = Class("ActivityEntry", UIControls.Child)

function ActivityEntry:ctor()
	self.panelContent = UIControls.Panel(self, "BtnFun/Content")
	self.btnCircleBattleHonor = UIControls.Button(self, "BtnFun")

	self.btnCircleBattleHonor:addEventClick(self.onClickBtnFunc)

	self.txtTime = UIControls.Label(self, "BtnFun/Content/BgTime/TxtTime")
	self.panelNewOpen = UIControls.Panel(self, "BtnFun/Content/IconNewOpen")
	self.panelNew = UIControls.Panel(self, "BtnFun/Content/IconNewContainer")
	self.panelRank = UIControls.Panel(self, "BtnFun/RankPanel")

	self:onRefresh()
end

function ActivityEntry:onRefresh()
	self.actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_GUESS)

	if self.actObj and self.actObj:inOpenState() then
		self.actOpening = true

		self.panelContent:setVisible(true)
		self.panelRank:setVisible(false)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj:getRemainOpenTime(), false, Lang.get(48655))

		if self.actObj:isNewOpened() then
			self.panelNew:setVisible(false)
			self.panelNewOpen:setVisible(true)
		elseif self.actObj.actData:checkNew() then
			self.panelNew:setVisible(true)
			self.panelNewOpen:setVisible(false)
		else
			self.panelNew:setVisible(false)
			self.panelNewOpen:setVisible(false)
		end
	else
		self.actOpening = false

		self.panelContent:setVisible(false)
		self.panelRank:setVisible(true)
	end
end

function ActivityEntry:onClickBtnFunc()
	if self.actOpening then
		CurAvatar:jumpToShowActivity(self.actObj.actId)

		if self.actObj:isNewOpened() then
			RPC.opActSetFocus(self.actObj.opId, 1)
		end
	else
		CurAvatar:tryGetClanGuessRanking()
	end
end

local CircleShopEntry = Class("CircleShopEntry", UIControls.Child)

function CircleShopEntry:ctor()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnCircleShopClick)
end

function CircleShopEntry:onBtnCircleShopClick()
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_SHOP)

	if isLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_SHOP))

		return
	end

	UIManager.createAndFunc("mallDlg", "showShop", Const.JUMPSHOPTYPE_CIRCLESHOP)
end

function CircleActivityPanel:ctor()
	self:initUI()
end

function CircleActivityPanel:initUI()
	self.btnBoss = UIControls.Button(self, self.mPath .. "/Content/BtnBoss")

	self.btnBoss:addEventClick(self.onBtnBossClick)

	self.entryNum = 1
	self.scrollList = UIControls.ScrollView(self, self.mPath)

	self.scrollList:addEventValueChanged(self._onScrollValueChanged)

	self.panelArrow = UIControls.Panel(self, self.mPath .. "/ArrowNext")
end

function CircleActivityPanel:onBtnBossClick()
	local lockId = ResBossTowerMisc[Const.BOSS_TOWER_TYPE_ZOMBIE].lock_id
	local isLocked = ConditionLimitManager.inLimitState(lockId)

	if isLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(lockId))

		return
	end

	local bossMainDlg = UIManager.getUI("bossMainDlg", true)

	bossMainDlg:show(Const.BOSS_TOWER_TYPE_ZOMBIE)
end

function CircleActivityPanel:setCircle(circle)
	self.circle = circle

	if Const.OPEN_CIRCLE_GUESS_ACTIVITY and not self.btnGuessEntry then
		self.btnGuessEntry = ActivityEntry(self, self.mPath .. "/Content", "System/Activity/ActivityFigureGuess/BtnGuessEntrance")

		self.btnGuessEntry:setVisible(true)

		self.entryNum = self.entryNum + 1
	end

	if Const.FORCE_OPEN_CIRCLE_BATTLE then
		local actOj = CurAvatar:getActivityObj(Const.CIRCLE_BATTLE_ACTIVITY_ID)

		if actOj and (actOj:inOpenState() or actOj:inFreeze()) then
			if self.btnCircleBattleHonor then
				self.btnCircleBattleHonor:destroy()

				self.btnCircleBattleHonor = nil
			end

			if not self.btnEnterCircleBattle then
				self.btnEnterCircleBattle = GatherActivityCircleBattleBtn(self, self.mPath .. "/Content", "System/Circle/BtnCircleBattle", 0, 0, true)
				self.entryNum = self.entryNum + 1
			end

			self.btnEnterCircleBattle:setDataByDefineConfig()
		else
			if self.btnEnterCircleBattle then
				self.btnEnterCircleBattle:destroy()

				self.btnEnterCircleBattle = nil
			end

			if not self.btnCircleBattleHonor then
				self.btnCircleBattleHonor = BtnCircleBattleHonor(self, self.mPath .. "/Content", "System/Circle/BtnCircleBattleHonor", 0, 0, true)
				self.entryNum = self.entryNum + 1
			end
		end
	end

	if not self.btnCircleShop then
		self.btnCircleShop = CircleShopEntry(self, self.mPath .. "/Content", "System/Circle/BtnCircleShop")

		self.btnCircleShop:setVisible(true)

		self.entryNum = self.entryNum + 1
	end

	if self.entryNum > 3 then
		self.panelArrow:setVisible(true)
	else
		self.panelArrow:setVisible(false)
	end
end

function CircleActivityPanel:onRefresh()
	if self.btnEnterCircleBattle then
		self.btnEnterCircleBattle:setDataByDefineConfig()
	end

	if self.btnGuessEntry then
		self.btnGuessEntry:onRefresh()
	end
end

function CircleActivityPanel:_onScrollValueChanged(sender, valueX, valueY)
	if self.entryNum and self.entryNum > 3 then
		local barValue = self.scrollList:getHorizontalValue()

		if barValue == self.oldBarValue then
			return
		end

		self.oldBarValue = barValue

		if barValue >= 1 then
			self.panelArrow:setVisible(false)
		else
			self.panelArrow:setVisible(true)
		end
	end
end

return CircleActivityPanel
