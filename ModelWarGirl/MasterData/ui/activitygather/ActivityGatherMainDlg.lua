-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\ActivityGather\\ActivityGatherMainDlg.lua

local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local ResRandClient = require("ClientData/ResRandClient")
local ResActivityGatherConfig = require("ClientData/ResActivityGatherConfig")
local ResColor = require("ClientData/ResColor")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local VersionUtils = require("System/VersionUtils")
local GatherBaseChild = require("UI/ActivityGather/GatherBaseChild")
local GatherWorldBossBtn = Class("GatherWorldBossBtn", GatherBaseChild)

function GatherWorldBossBtn:setData(btnConfig, state)
	GatherWorldBossBtn.super.setData(self, btnConfig, state)

	if state == Const.SHOW_STATE_PREDICT then
		if not self.textPredict then
			self.textPredict = UIControls.Label(self, "BtnFun/Content/AnnouncePanel/TxtRule")
		end

		if self.actId and self.actObj then
			local isValid, unlockDesc = self.actObj:isValid()

			self.textPredict:setText(unlockDesc or "")
		end
	end
end

function GatherWorldBossBtn:_showOpenState(btnConfig, state)
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self.rdNew:clearHint()

	if self.actObj then
		self.panelWillEnd:setVisible(false)

		local leftTime = WorldBossCommon.getCurBossLeftTime()
		local bossInfo = self.actObj.actData:getCurBossInfo()

		self.imgIcon:setImage("NoAlpha/MainMenu/BgWorldBoss" .. bossInfo.type)

		if leftTime >= 0 and leftTime <= WorldBossCommon.getConfigFrozenTime() then
			self.textTime:setText(Lang.get(30121))
			self.textTime:setFontColor(ResColor.WHITE)
			self.aniTime:stopAni("LoopBtnWorldBoss")
		elseif leftTime > WorldBossCommon.getConfigFrozenTime() then
			leftTime = leftTime - WorldBossCommon.getConfigFrozenTime()

			ClientTimerManager.AddSecondFormatTickUI(self.textTime, leftTime, false, Lang.get(48654), Slot(self.onTimeOut, self))

			if leftTime > self.actObj:willEndCountDown() then
				self.textTime:setFontColor(ResColor.WHITE)
				self.aniTime:stopAni("LoopBtnWorldBoss")
			else
				self.textTime:setFontColor(ResColor.RED)
				self.aniTime:startAniLoop("LoopBtnWorldBoss")
				self.panelWillEnd:setVisible(true)
			end
		end

		if self.actObj:isNewOpened() then
			self.rdNewOpen:setVisible(true)
		elseif self.actObj.redDotId then
			self.rdNewOpen:setVisible(false)
			self.rdNew:addHint({
				self.actObj.redDotId
			})
		end
	end
end

local GatherSeasonTowerBtn = Class("GatherSeasonTowerBtn", GatherBaseChild)

function GatherSeasonTowerBtn:_showOpenState()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self.rdNew:clearHint()

	if self.actObj then
		self.panelWillEnd:setVisible(false)

		local leftTime = self.actObj:getRemainOpenTime()

		if leftTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textTime, leftTime, false, Lang.get(48654), Slot(self.onTimeOut, self))

			if leftTime > self.actObj:willEndCountDown() then
				self.textTime:setFontColor(ResColor.WHITE)
				self.aniTime:stopAni("LoopBtnWorldBoss")
			else
				self.aniTime:startAniLoop("LoopBtnWorldBoss")
				self.panelWillEnd:setVisible(true)
				self.textTime:setFontColor(ResColor.RED)
			end
		else
			self.textTime:setFontColor(ResColor.WHITE)
			self.aniTime:stopAni("LoopBtnWorldBoss")
			self.textTime:setText(Lang.get(30121))
		end

		if self.actObj:isNewOpened() then
			self.rdNewOpen:setVisible(true)
		elseif self.actObj.redDotId then
			self.rdNewOpen:setVisible(false)
			self.rdNew:addHint({
				self.actObj.redDotId
			})
		end
	end
end

local GatherRentTaskBtn = Class("GatherRentTaskBtn", UIControls.Child)

function GatherRentTaskBtn:ctor(...)
	self:initUI()
end

function GatherRentTaskBtn:initUI(...)
	self.imgIcon = UIControls.RawImage(self, "BtnFun/Content/Img")
	self.textTitls = UIControls.Label(self, "BgShelf/TxtTitle")
	self.panelPredict = UIControls.Panel(self, "BtnFun/Content/AnnouncePanel")
	self.textPredict = UIControls.Label(self, "BtnFun/Content/AnnouncePanel/TxtRule")
	self.panelLock = UIControls.Panel(self, "BtnFun/Content/LockPanel")
	self.rdNew = UIControls.RedDot(self, "BtnFun/Content/IconNewContainer")
	self.rdNewOpen = UIControls.Panel(self, "BtnFun/Content/IconNewOpen")
	self.btnSensor = UIControls.Button(self, "BtnFun")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.upWeekImg = UIControls.Image(self, "BtnFun/Content/ImgUp")
end

function GatherRentTaskBtn:setData(btnConfig, state)
	self.state = state
	self.btnConfig = btnConfig

	if state == Const.SHOW_STATE_LOCK then
		self.imgIcon:setObjGray(true)
		self.panelLock:setVisible(true)
		self.panelPredict:setVisible(false)
		self.textTitls:setVisible(false)
		self.upWeekImg:setVisible(false)
	elseif state == Const.SHOW_STATE_PREDICT then
		self.imgIcon:setObjGray(true)
		self.panelLock:setVisible(false)
		self.panelPredict:setVisible(true)
		self.textTitls:setVisible(false)
		self.upWeekImg:setVisible(false)

		if btnConfig.show_condition then
			self.textPredict:setText(ConditionLimitManager.getLimitUnlockDesc(btnConfig.show_condition))
		end
	else
		self.imgIcon:setObjGray(false)
		self.panelLock:setVisible(false)
		self.panelPredict:setVisible(false)
		self.textTitls:setVisible(true)
		self.upWeekImg:setVisible(CurAvatar.isRentUpWeek or false)
	end

	self:_showOpenState()
end

function GatherRentTaskBtn:_showOpenState()
	local hasNewTask = RedDotManager.getKeyState(UIConst.RD_HINT_RENT_UNSELECT)
	local mainHasNew = RedDotManager.getKeyState(UIConst.RD_HINT_RENT_MAIN)

	self.rdNewOpen:setVisible(hasNewTask)

	if hasNewTask then
		self.rdNew:setVisible(false)
	else
		self.rdNew:setVisible(mainHasNew)
	end

	self.hasNewTask = hasNewTask
end

function GatherRentTaskBtn:onSensorClick(...)
	if self.state == Const.SHOW_STATE_LOCK then
		MsgManager.clientNotice(345)

		return
	end

	local targetGtid

	if self.hasNewTask then
		targetGtid = RentTaskUtils.getFirstNewGtid()
	else
		targetGtid = RentTaskUtils.getFirstHasNewGtid()
	end

	UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks(targetGtid)
end

local GatherRecommendChild = Class("GatherRecommendChild", UIControls.Child)

function GatherRecommendChild:ctor()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.panelNew = UIControls.Panel(self, "IconNewContainer")
	self.btnRD = UIControls.RedDot(self, "IconNewContainer/IconNew")
	self.iconNewOpen = UIControls.RedDot(self, "IconNewOpen")
end

function GatherRecommendChild:setData(btnConfig, showState)
	self.btnConfig = btnConfig

	self.btnRD:clearHint()

	self.isGray = false

	if btnConfig.btn_type == Const.BTN_TYPE_ACTIVITY then
		self.actId = btnConfig.btn_args[1]
		self.actObj = CurAvatar:getActivityObj(self.actId)

		if self.actObj then
			if not self.actObj:isValid() and self.btnConfig.show_condition and not ConditionLimitManager.inLimitState(self.btnConfig.show_condition) then
				self.btnSensor:setObjGray(true)

				self.isGray = true
			else
				if self.actObj.redDotId then
					self.btnRD:addHint({
						self.actObj.redDotId
					})
				end

				self.btnSensor:setObjGray(false)
			end

			if self.isGray then
				self.panelNew:setVisible(false)
				self.iconNewOpen:setVisible(false)
			elseif self.actObj:isNewOpened() then
				self.iconNewOpen:setVisible(true)
				self.panelNew:setVisible(false)
			else
				self.panelNew:setVisible(true)
				self.iconNewOpen:setVisible(false)
			end

			local btnName = "TextTime"

			if UIControls.checkControlFunc(self, btnName) then
				local leftTime = self.actObj:getRemainOpenTime()

				if leftTime > 0 then
					self.btnTime = UIControls.Label(self, btnName)

					ClientTimerManager.AddSecondFormatTickUI(self.btnTime, leftTime, false, Lang.get(48655), Slot(self._onTimeDownEnd, self), nil, 1)
				else
					self:setVisible(false)
				end
			end
		end
	end
end

function GatherRecommendChild:onSensorClick()
	if self.actId and self.actObj then
		local isValid, unlockDesc = self.actObj:isValid()

		if isValid then
			CurAvatar:jumpToShowActivity(self.actId)

			if self.actObj:isNewOpened() then
				RPC.opActSetFocus(self.actObj.opId, 1)
			end
		else
			MsgManager.notice(unlockDesc)
		end
	end
end

function GatherRecommendChild:_onTimeDownEnd(...)
	self.mParent:onRefresh()
end

local GatherWishSignInBtn = Class("GatherWishSignInBtn", GatherRecommendChild)

function GatherWishSignInBtn:ctor()
	self.imgBack = UIControls.Panel(self, "ImgBack")
	self.imgAwardIcon = UIControls.Image(self, "ImgBack/ImgIcon")
	self.bgTime = UIControls.Panel(self, "BgTime")
	self.txtTime = UIControls.Label(self, "BgTime/TimeText")
end

function GatherWishSignInBtn:setData(btnConfig)
	GatherWishSignInBtn.super.setData(self, btnConfig)
	self:resetBtn()
end

function GatherWishSignInBtn:resetBtn()
	local state = self.actObj.actData:getState()
	local actData = self.actObj.actData

	self.iconNewOpen:setVisible(false)
	self.bgTime:setVisible(false)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if state == 3 then
		if #actData.wishPool > 0 then
			local awardId = actData.wishPool[#actData.wishPool].index

			if actData.resAwards[awardId] then
				local rewardId = actData.resAwards[awardId].reward_id
				local showId = ResRandClient[rewardId].show_ids[1]
				local obj = BaseObject.GetObject(showId)
				local iconPath = obj:getIconPath()

				if iconPath then
					self.imgAwardIcon:setImage(iconPath[1], iconPath[2])
					self.imgBack:setVisible(true)
				end
			end
		end

		self.panelNew:setVisible(true)
		self.btnRD:setVisible(true)
		self.iconNewOpen:setVisible(false)
	elseif state == 2 then
		self.iconNewOpen:setVisible(false)
		self.panelNew:setVisible(false)
		self.imgBack:setVisible(false)

		if actData.rewardTime and actData.rewardTime > 0 then
			local timeLeft = actData.rewardTime - ClientUtils.getServerTime()

			if timeLeft > 0 then
				ClientTimerManager.AddSecondFormatTickUI(self.txtTime, timeLeft, false, Lang.get(48656), Slot(self._onTimeDownEnd, self))
			end
		end

		self.bgTime:setVisible(true)
	elseif state == 1 then
		self.iconNewOpen:setVisible(true)
		self.panelNew:setVisible(false)
		self.imgBack:setVisible(false)
	else
		self.iconNewOpen:setVisible(false)
		self.panelNew:setVisible(false)
		self.imgBack:setVisible(false)
	end
end

function GatherWishSignInBtn:_onTimeDownEnd(...)
	self.bgTime:setVisible(false)
	self.mParent:onRefresh()
end

local GatherActivityPvpBtn = Class("GatherActivityPvpBtn", GatherBaseChild)

function GatherActivityPvpBtn:_showOpenState(btnConfig, state)
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self.rdNew:clearHint()

	if self.actObj and self.actObj.actData then
		self.panelWillEnd:setVisible(false)

		local leftTime = self.actObj.actData:getLeftTimeToFreeze()

		if leftTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textTime, leftTime, nil, Lang.get(48654), Slot(self.onFreeze, self), nil)

			if leftTime < 43200 then
				self.panelWillEnd:setVisible(true)
				self.textTime:setFontColor(ResColor.RED)
				self.aniTime:startAniLoop("LoopBtnWorldBoss")
			else
				self.panelWillEnd:setVisible(false)
				self.textTime:setFontColor(ResColor.WHITE)
				self.aniTime:stopAni("LoopBtnWorldBoss")
			end
		else
			self.panelWillEnd:setVisible(false)
			self.aniTime:stopAni("LoopBtnWorldBoss")
			self.textTime:setText(Lang.get(30121))
			self.textTime:setFontColor(ResColor.WHITE)
		end

		if self.actObj:isNewOpened() then
			self.rdNewOpen:setVisible(true)
		elseif self.actObj.redDotId then
			self.rdNewOpen:setVisible(false)
			self.rdNew:addHint({
				UIConst.RD_HINT_OPACTPVP
			})
		end
	end
end

function GatherActivityPvpBtn:onSensorClick()
	if self:checkIsLock() then
		return
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_OPACTPVP) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_OPACTPVP)

		MsgManager.notice(unlockDesc)

		return
	end

	local tip = true
	local actObj = CurAvatar:getPVPArenaActivity()
	local arenaData

	if actObj then
		arenaData = actObj.actData.arenaData

		if arenaData and arenaData.opened ~= 0 then
			tip = false

			CurAvatar:jumpToShowActivity(actObj.actId)
		end

		if actObj:isNewOpened() then
			RPC.opActSetFocus(actObj.opId, 1)
			self.rdNewOpen:setVisible(false)
		end
	else
		MsgManager.notice(Lang.get(29962))

		return
	end

	if actObj and actObj:inFreeze() then
		if tip then
			MsgManager.notice(Lang.get(29961))
		end

		return
	end

	if arenaData == nil or arenaData.opened == 0 then
		local actId = CurAvatar:getPVPArenaActivityOpId()

		if actId then
			RPC.opactArenaRoleOpen(actId)
		end
	end

	if arenaData == nil or arenaData.enrolled == 0 then
		local actId = CurAvatar:getPVPArenaActivityOpId()

		if actId then
			local formation = CurAvatar:getNowFormation(Const.FORMATION_MULTIPVP_DEFEND_1)

			if formation == nil or next(formation) == nil then
				formation = CurAvatar:getNowFormation(Const.FORMATION_OPACTPVP_DEFEND_1)

				if formation == nil or next(formation) == nil then
					return
				end
			end

			RPC.opactArenaEnroll(actId)
		end
	end
end

local GatherNewMazeBtn = Class("GatherNewMazeBtn", GatherBaseChild)

function GatherNewMazeBtn:ctor()
	self.imgIcon = UIControls.RawImage(self, "BtnFun/Content/Img")
	self.panelWillReset = UIControls.Panel(self, "TimeUpPanel1")
	self.rolePortrait = UIControls.Role(self, "BtnFun/Content/Mask/Bg/HeroPanel", 0, 0)
end

function GatherNewMazeBtn:setData(btnConfig, state)
	GatherNewMazeBtn.super.setData(self, btnConfig, state)
	self.rolePortrait:showRole(self.actObj.actData.heroId, UIConst.ROLEIMAGE_SHOWTYPE_NEW_MAZE_UPHERO)
end

function GatherNewMazeBtn:_showOpenState()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self.rdNew:clearHint()

	if self.actObj and self.actObj.actData then
		local iconName = "NoAlpha/MainMenu/BgRouge" .. self.actObj.actData.heroId

		self.imgIcon:setImage(iconName)

		local leftTime = self.actObj.actData:getLeftTimeToFreeze()
		local resetTime = self.actObj.actData:getResetTime()
		local str = Lang.get(48654)

		if leftTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textTime, leftTime, nil, str, Slot(self._onTimeDownEnd, self), nil)

			if leftTime <= resetTime then
				self.panelWillEnd:setVisible(true)
				self.panelWillReset:setVisible(false)
				self.textTime:setFontColor(ResColor.RED)
				self.aniTime:startAniLoop("LoopBtnWorldBoss")
			else
				self.panelWillEnd:setVisible(false)

				if resetTime <= 86400 and resetTime > 0 then
					self.panelWillReset:setVisible(true)
				else
					self.panelWillReset:setVisible(false)
				end

				self.textTime:setFontColor(ResColor.WHITE)
				self.aniTime:stopAni("LoopBtnWorldBoss")
			end
		else
			self.panelWillEnd:setVisible(false)
			self.panelWillReset:setVisible(false)
			self.aniTime:stopAni("LoopBtnWorldBoss")
			self.textTime:setText(Lang.get(30121))
			self.textTime:setFontColor(ResColor.WHITE)
		end

		if self.actObj:isNewOpened() then
			self.rdNewOpen:setVisible(true)
		elseif self.actObj.redDotId then
			self.rdNewOpen:setVisible(false)
			self.rdNew:addHint({
				self.actObj.redDotId
			})
		end

		if self.actObj.actData.miscData.relate_achieve_id then
			local relaActObj = CurAvatar:getActivityObj(self.actObj.actData.miscData.relate_achieve_id)

			if relaActObj then
				self.rdNew:addHint({
					relaActObj.redDotId
				})
			end
		end
	end
end

function GatherNewMazeBtn:onSensorClick()
	if self:checkIsLock() then
		return
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_NEW_MAZE) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_NEW_MAZE)

		MsgManager.notice(unlockDesc)

		return
	end

	local actObj = CurAvatar:getNewMazeActivity()

	if actObj then
		if actObj.actData.seasonCache and actObj.actData.seasonCache.cur_cycle == -1 and actObj.actData.hasGotFirstPassAward[1] then
			if actObj and actObj:inFreeze() then
				CurAvatar:jumpToShowActivity(actObj.actId)
			else
				RPC.newMazeOpen(actObj.opId)
			end
		elseif actObj.actData.ratingLevel and actObj.actData.ratingLevel ~= 0 then
			if actObj.actData.layer == 0 or actObj.actData.layer == -1 or actObj.actData.redheart <= 0 and actObj.actData.levelStatus ~= Const.NEW_MAZE_LEVEL_STATUS.Start then
				CurAvatar:jumpToShowActivity(actObj.actId)
			else
				local mainDlg = UIManager.getUI("newMazeMainDlg", true)

				mainDlg:setData(true)
			end
		else
			RPC.newMazeOpen(actObj.opId)
		end

		if actObj:isNewOpened() then
			RPC.opActSetFocus(actObj.opId, 1)
			self.rdNewOpen:setVisible(false)
		end
	else
		MsgManager.notice(Lang.get(29962))

		return
	end
end

function GatherNewMazeBtn:_onTimeDownEnd(...)
	self.mParent:onRefresh()
end

local GatherActivityTopPvpBtn = Class("GatherActivityTopPvpBtn", GatherBaseChild)

function GatherActivityTopPvpBtn:ctor()
	self.bgTime = UIControls.Image(self, "BtnFun/Content/BgTime")
	self.txtGroupMatCh = UIControls.Label(self, "BtnFun/Content/BgTime/TxtGroupMatch")
	self.comingSoonPanel = UIControls.Panel(self, "BtnFun/Content/ComingSoonPanel")

	self.comingSoonPanel:setVisible(false)

	self.txtTime1 = UIControls.Label(self, "BtnFun/Content/ComingSoonPanel/BgTime/TxtTime")
	self.groupMatchPanel = UIControls.Panel(self, "BtnFun/Content/GroupMatchPanel")
	self.txtTime2 = UIControls.Label(self, "BtnFun/Content/GroupMatchPanel/BgTime/TxtTime")
	self.txtEliminateMatch = UIControls.Label(self, "BtnFun/Content/BgTime/TxtEliminateMatch")
end

local ResBPPvpRound = require("ClientData/ResBPPvpRound")

function GatherActivityTopPvpBtn:resetBtn(...)
	self:_showOpenState()
end

function GatherActivityTopPvpBtn:_showOpenState()
	self.rdNew:clearHint()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)

	if self.actObj and self.actObj.actData then
		local leftTimeToOpen = self.actObj:getPreOpenTime()

		if leftTimeToOpen then
			self.comingSoonPanel:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime1, leftTimeToOpen, false, Lang.get(45383), nil)
		else
			local checkCrossData = self.actObj.actData:checkTopPvpCrossdata()

			if checkCrossData then
				local nowState = self.actObj.actData:getTopPvpStage()

				if nowState then
					local num = self.actObj.actData.reStateMap.GroupSettle

					if nowState <= num then
						self.txtGroupMatCh:setVisible(true)

						if nowState == num then
							self.txtGroupMatCh:setText(Lang.get(81132))
						end

						self.txtEliminateMatch:setVisible(false)

						local can = CurAvatar:checkTopPVPGroupMatchQualification()

						if can then
							self.groupMatchPanel:setVisible(false)
						else
							self.groupMatchPanel:setVisible(true)
						end
					else
						self.groupMatchPanel:setVisible(false)
						self.txtGroupMatCh:setVisible(false)
						self.txtEliminateMatch:setVisible(true)

						local round = self.actObj.actData:getKnockoutRound()

						if round ~= 0 then
							if round <= 6 then
								self.txtEliminateMatch:setText(ResBPPvpRound[round].round_name .. Lang.get(693))
							else
								self.txtEliminateMatch:setText(Lang.get(79917))
							end
						end
					end
				end
			end

			if self.actObj:isNewOpened() then
				self.rdNewOpen:setVisible(true)
				self.rdNew:setVisible(false)
			elseif self.actObj.redDotId then
				if self.actObj.actData:checkTopPvpCrossdata() then
					self.actObj.actData:checkGathetBtnRedDot()
				end

				self.rdNewOpen:setVisible(false)
				self.rdNew:addHint({
					self.actObj.redDotId
				})
			end
		end
	end
end

function GatherActivityTopPvpBtn:onSensorClick()
	if self:checkIsLock() then
		return
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_TOPPVP) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_TOPPVP)

		MsgManager.notice(unlockDesc)

		return
	end

	if self.actId and self.actObj then
		local leftTimeToOpen = self.actObj:getPreOpenTime()

		if leftTimeToOpen then
			MsgManager.notice(Lang.get(77962))
		else
			local isValid, unlockDesc = self.actObj:isValid()

			if isValid then
				local actData = self.actObj.actData
				local checkCrossData = actData:checkTopPvpCrossdata()

				if checkCrossData then
					local nowState = actData:getTopPvpStage()

					if nowState then
						if nowState <= actData.reStateMap.GroupSettle then
							if CurAvatar:checkTopPVPGroupMatchQualification() then
								local actId = CurAvatar:getTopPVPActivityOpId()

								if actId then
									RPC.bPPvpActivityStateGet(actId)
								end

								CurAvatar:jumpToShowActivity(self.actId)

								if self.actObj:isNewOpened() then
									RPC.opActSetFocus(self.actObj.opId, 1)
									self.rdNewOpen:setVisible(false)
								end
							else
								local groupMatchRemainTime = self.actObj.actData:getGroupMatchRemainTime()
								local time = utils.calcTimeTxt(groupMatchRemainTime)

								MsgManager.notice(utils.format(Lang.get(90291), time))
							end
						else
							local actId = CurAvatar:getTopPVPActivityOpId()

							if actId then
								RPC.bPPvpActivityStateGet(actId)
							end

							CurAvatar:jumpToShowActivity(self.actId)

							if self.actObj:isNewOpened() then
								RPC.opActSetFocus(self.actObj.opId, 1)
								self.rdNewOpen:setVisible(false)
							end
						end
					end
				else
					MsgManager.notice(Lang.get(78293))
				end
			else
				MsgManager.notice(unlockDesc)
			end
		end
	end
end

local GatherActivityCircleBattleBtn = require("UI/ActivityGather/GatherActivityCircleBattleBtn")
local GatherActivitySneakBattleBtn = Class("GatherActivitySneakBattleBtn", GatherBaseChild)

function GatherActivitySneakBattleBtn:ctor()
	self.img = UIControls.RawImage(self, "BtnFun/Content/Img")
	self.txtTime = UIControls.Label(self, "BtnFun/Content/BgTime/TxtTime")
end

function GatherActivitySneakBattleBtn:setData(btnConfig, showState)
	GatherActivitySneakBattleBtn.super.setData(self, btnConfig, showState)

	if self.actObj and self.actObj.actData then
		local type = self.actObj.actData.type or 1

		self.img:setImage("NoAlpha/MainMenu/BgSneakBattle" .. type, "BgSneakBattle" .. type)
	end
end

function GatherActivitySneakBattleBtn:resetBtn(...)
	self:_showOpenState()
end

function GatherActivitySneakBattleBtn:_showOpenState(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	self.panelWillEnd:setVisible(false)

	if self.actObj and self.actObj.actData then
		local remainTime = self.actObj.actData:getCurLeftTime()

		if remainTime >= 0 and remainTime <= self.actObj.actData:getConfigFrozenTime() then
			self.txtTime:setText(Lang.get(30121))
			self.txtTime:setFontColor(ResColor.WHITE)
			self.aniTime:stopAni("LoopBtnWorldBoss")
		elseif remainTime > self.actObj.actData:getConfigFrozenTime() then
			remainTime = remainTime - self.actObj.actData:getConfigFrozenTime()

			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, Lang.get(48654), nil)

			if remainTime > self.actObj:willEndCountDown() then
				self.txtTime:setFontColor(ResColor.WHITE)
				self.aniTime:stopAni("LoopBtnWorldBoss")
			else
				self.panelWillEnd:setVisible(true)
				self.txtTime:setFontColor(ResColor.RED)
				self.aniTime:startAniLoop("LoopBtnWorldBoss")
			end
		end

		local type = self.actObj.actData.type or 1

		self.img:setImage("NoAlpha/MainMenu/BgSneakBattle" .. type, "BgSneakBattle" .. type)

		if self.actObj:isNewOpened() then
			self.rdNewOpen:setVisible(true)
		elseif self.actObj.redDotId then
			self.rdNewOpen:setVisible(false)
			self.rdNew:addHint({
				self.actObj.redDotId
			})
		end
	end
end

function GatherActivitySneakBattleBtn:onSensorClick(...)
	if self:checkIsLock() then
		return
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_SNEAKBATTLE) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_SNEAKBATTLE)

		MsgManager.notice(unlockDesc)

		return
	end

	if self.actId and self.actObj then
		if self.actObj:isNewOpened() then
			RPC.opActSetFocus(self.actObj.opId, 1)
			self.rdNewOpen:setVisible(false)
			self.actObj.actData:checkNew()
		end

		CurAvatar:jumpToShowActivity(self.actId)
	end
end

local PREFAB_INFO = {
	worldboss = GatherWorldBossBtn,
	wishSignIn = GatherWishSignInBtn,
	seasontower = GatherSeasonTowerBtn,
	rentTask = GatherRentTaskBtn,
	activityPvp = GatherActivityPvpBtn,
	activityCircleBattle = GatherActivityCircleBattleBtn,
	activityNewMaze = GatherNewMazeBtn,
	activityTopPvp = GatherActivityTopPvpBtn,
	activitySneakBattle = GatherActivitySneakBattleBtn
}
local ActivityGatherMainDlg = Class("ActivityGatherMainDlg", UIControls.Window)

function ActivityGatherMainDlg:ctor()
	self.actChilds = {}

	self:onRefresh()

	self.gameEntryList = UIControls.ScrollView(self, "MainInfoPanel/GameEntryList")

	self.gameEntryList:addEventValueChanged(self._onScrollValueChanged)

	self.imgL = UIControls.Image(self, "MainInfoPanel/ArrowPanel/ImgL")
	self.imgR = UIControls.Image(self, "MainInfoPanel/ArrowPanel/ImgR")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function ActivityGatherMainDlg:isShow(checkPos, index)
	if checkPos == 1 then
		return true
	end

	if not self.repeatMap then
		self.repeatMap = {}

		for index, btnConfig in ipairs(ResActivityGatherConfig) do
			local pos = btnConfig.pos

			if not self.repeatMap[pos] then
				self.repeatMap[pos] = {
					btnConfig
				}
			else
				table.insert(self.repeatMap[pos], btnConfig)
			end
		end
	end

	local list = self.repeatMap[checkPos]

	if list and #list > 1 then
		local showIndex = -1

		for i = #list, 1, -1 do
			local actId = list[i].btn_args[1]
			local actObj = CurAvatar:getActivityObj(actId)

			if not actObj or actObj:inCloseState() or actObj:inNoneState() or showIndex ~= -1 then
				-- block empty
			else
				showIndex = list[i].id
			end
		end

		if showIndex ~= -1 then
			return showIndex == index
		else
			return list[1].id == index
		end
	else
		return true
	end
end

function ActivityGatherMainDlg:onRefresh()
	local configData = {}

	for index, btnConfig in ipairs(ResActivityGatherConfig) do
		local pos = btnConfig.pos

		if not configData[pos] then
			configData[pos] = {}
		end

		btnConfig.index = index

		table.insert(configData[pos], btnConfig)
	end

	for _, btnsData in ipairs(configData) do
		for index, btnConfig in ipairs(btnsData) do
			local pos = btnConfig.pos

			if btnConfig.prefab then
				if btnConfig.btn_type == Const.BTN_TYPE_ACTIVITY then
					local showState = Const.SHOW_STATE_LOCK

					for _, actId in ipairs(btnConfig.btn_args) do
						if CurAvatar:isActivityValid(actId) then
							showState = Const.SHOW_STATE_OPEN

							break
						elseif btnConfig.show_condition and not ConditionLimitManager.inLimitState(btnConfig.show_condition) then
							showState = Const.SHOW_STATE_PREDICT

							break
						end
					end

					if (pos ~= 1 or showState ~= Const.SHOW_STATE_LOCK) and not self.actChilds[pos] and self:isShow(pos, btnConfig.index) then
						local childClass = GatherRecommendChild

						if PREFAB_INFO[btnConfig.prefab_type] then
							childClass = PREFAB_INFO[btnConfig.prefab_type]
						end

						if btnConfig.prefab_type == "activitySneakBattle" then
							if Const.SNEAK_BATTLE_OPEN then
								self.actChilds[pos] = childClass(self, "MainInfoPanel/GameEntryList/Viewport/Content", "System/MainMenu/" .. btnConfig.prefab)

								self.actChilds[pos]:setVisible(true)
								self.actChilds[pos]:setData(btnConfig, showState)
							end
						else
							if btnConfig.prefab_type == "wishSignIn" then
								self.actChilds[pos] = childClass(self, "MainInfoPanel/GameEntryList/Viewport/Content/WishPanel", "System/MainMenu/" .. btnConfig.prefab)
							else
								self.actChilds[pos] = childClass(self, "MainInfoPanel/GameEntryList/Viewport/Content", "System/MainMenu/" .. btnConfig.prefab)
							end

							self.actChilds[pos]:setVisible(true)
							self.actChilds[pos]:setData(btnConfig, showState)
						end
					end
				elseif btnConfig.btn_type == Const.BTN_TYPE_RENT and CurAvatar.rentTaskFlag then
					local conditionId = Const.CONDITION_LIMIT_RENTTASK
					local showState = Const.SHOW_STATE_LOCK

					if not ConditionLimitManager.inLimitState(conditionId) then
						showState = Const.SHOW_STATE_OPEN
					elseif btnConfig.show_condition and not ConditionLimitManager.inLimitState(btnConfig.show_condition) then
						showState = Const.SHOW_STATE_PREDICT
					end

					if not self.actChilds[pos] then
						local childClass = GatherRecommendChild

						if PREFAB_INFO[btnConfig.prefab_type] then
							childClass = PREFAB_INFO[btnConfig.prefab_type]
						end

						self.actChilds[pos] = childClass(self, "MainInfoPanel/GameEntryList/Viewport/Content", "System/MainMenu/" .. btnConfig.prefab)

						self.actChilds[pos]:setVisible(true)
					end

					self.actChilds[pos]:setData(btnConfig, showState)
				end
			end
		end
	end
end

function ActivityGatherMainDlg:onOpen()
	ActivityGatherMainDlg.super.onOpen(self)
	self:onRefresh()
end

function ActivityGatherMainDlg:onBtnsRefresh()
	for k, btn in pairs(self.actChilds) do
		if btn.resetBtn then
			btn:resetBtn()
		end
	end
end

function ActivityGatherMainDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function ActivityGatherMainDlg:_onScrollValueChanged(sender, valueX, valueY)
	self.imgL:setVisible(valueX ~= 0)
	self.imgR:setVisible(valueX ~= 1)
end

return ActivityGatherMainDlg
