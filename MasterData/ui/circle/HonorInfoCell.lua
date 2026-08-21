-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\HonorInfoCell.lua

local ResClanMisc = require("ClientData/ResClanMisc")
local strClassName = "HonorInfoCell"
local HonorInfoCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function HonorInfoCell:ctor()
	self:initUI()
end

function HonorInfoCell:initUI()
	self.imgBgTop = UIControls.Image(self, "BgTop")
	self.imgRank = UIControls.Image(self, "ImgRank")
	self.txtRank = UIControls.Label(self, "TextRank")
	self.txtPlayerName = UIControls.Label(self, "TextPlayerName")
	self.panelJob = UIControls.Panel(self, "JobPanel")
	self.bgJob = UIControls.Image(self, "JobPanel/BgJob")
	self.imgIconJob = UIControls.Image(self, "JobPanel/IconJob")
	self.txtJob = UIControls.Label(self, "JobPanel/TextJob")
	self.txtContribute = UIControls.Label(self, "ContributePanel/TextContribute")
	self.txtAction = UIControls.Label(self, "ActionPanel/TextTotal")
	self.txtSearch = UIControls.Label(self, "SearchPanel/TextTotal")
	self.txtTreasure = UIControls.Label(self, "SearchPanel/TextTreasure")
	self.txtFindBoss = UIControls.Label(self, "SearchPanel/TextBoss")
	self.txtRune = UIControls.Label(self, "SearchPanel/TextRune")
	self.txtBattle = UIControls.Label(self, "BattlePanel/TextTotal")
	self.txtKillMan = UIControls.Label(self, "BattlePanel/TextMonster")
	self.txtBattleBoss = UIControls.Label(self, "BattlePanel/TextBoss")
	self.txtKillBoss = UIControls.Label(self, "BattlePanel/TextKillBoss")
	self.penaltyPanel = UIControls.Panel(self, "PenaltyPanel")
	self.penaltyLederPanel = UIControls.Panel(self, "PenaltyPanel/PenaltyLederPanel")
	self.penaltySwitch = UIControls.Panel(self, "PenaltyPanel/PenaltyLederPanel/PenaltySwitch")
	self.btnPenaltyNormal = UIControls.Button(self, "PenaltyPanel/PenaltyLederPanel/PenaltySwitch/BtnNml")
	self.btnPenaltySelect = UIControls.Button(self, "PenaltyPanel/PenaltyLederPanel/PenaltySwitch/BtnSel")
	self.txtPenaltyCD = UIControls.Label(self, "PenaltyPanel/PenaltyLederPanel/TextCD")
	self.imgPenalty = UIControls.Panel(self, "PenaltyPanel/ImgPenalty")

	self.btnPenaltyNormal:addEventClick(self.onClickBtnPaneltyNormal)
	self.btnPenaltySelect:addEventClick(self.onClickBtnPaneltySelect)
end

function HonorInfoCell:setHonorInfoData(honorInfoData, rank)
	self.member = honorInfoData
	self.rank = rank

	if self.rank <= 3 then
		self.imgBgTop:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgRank" .. self.rank)
		self.imgRank:setVisible(true)
		self.imgRank:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "IconBadge" .. self.rank)
		self.bgJob:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgJob" .. self.rank)
		self.txtRank:setVisible(false)
	else
		self.imgBgTop:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgRankOther")
		self.bgJob:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgJobOther")
		self.imgRank:setVisible(false)
		self.txtRank:setVisible(true)
	end

	if not self.gridPlayer then
		self.gridPlayer = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon", 0, 0, true)

		self.gridPlayer:hideLevel()
	end

	self.gridPlayer:setCommInfo(self.member.base, false, self)
	self.txtRank:setText(self.rank)

	self.name, self.serverName = utils.GetPlayerName(self.member.base.name)

	self.txtPlayerName:setText(self.name)

	if self.member.duty ~= Const.CIRCLE_DUTY_MEMBER then
		self.panelJob:setVisible(true)
		self.txtJob:setText(CurAvatar:getDutyName(self.member.duty))

		local dutyImgPath = CurAvatar:getDutySpritePath(self.member.duty)

		if dutyImgPath then
			self.imgIconJob:setImage(dutyImgPath[1], dutyImgPath[2])
		end
	else
		self.panelJob:setVisible(false)
	end

	self.txtContribute:setText(self.member.battle_data.contribution)
	self.txtAction:setText(self.member.battle_data.honor and self.member.battle_data.honor.action_point or 0)
	self.txtSearch:setText(self.member.battle_data.honor and self.member.battle_data.honor.open_cnt or 0)
	self.txtTreasure:setText(self.member.battle_data.honor and self.member.battle_data.honor.find_box or 0)
	self.txtFindBoss:setText(self.member.battle_data.honor and self.member.battle_data.honor.find_boss or 0)
	self.txtRune:setText(self.member.battle_data.honor and self.member.battle_data.honor.find_rune or 0)
	self.txtBattle:setText(self.member.battle_data.honor and self.member.battle_data.honor.pve_cnt or 0)
	self.txtKillMan:setText(self.member.battle_data.honor and self.member.battle_data.honor.pve_win_cnt or 0)
	self.txtBattleBoss:setText(self.member.battle_data.honor and self.member.battle_data.honor.boss_cnt or 0)
	self.txtKillBoss:setText(self.member.battle_data.honor and self.member.battle_data.honor.boss_win_cnt or 0)
	self:refreshPenaltyPanel()
end

function HonorInfoCell:refreshPenaltyPanel()
	if self.timerPenalty then
		self.timerPenalty:Stop()

		self.timerPenalty = nil
	end

	local checkCircleActivityOpen = CurAvatar:checkCircleActivityOpen()
	local checkBoss = self.member.duty == Const.CIRCLE_DUTY_BOSS
	local checkCanMarkMember = CurAvatar:checkCanMarkMember()
	local checkMarked = self.member.battle_data.marked_flag and self.member.battle_data.marked_flag > 0
	local checkShowPenalty = checkCircleActivityOpen and not checkBoss and (checkCanMarkMember or checkMarked)

	self.penaltyPanel:setVisible(checkShowPenalty)

	if checkShowPenalty then
		self.penaltyLederPanel:setVisible(checkCanMarkMember)
		self.imgPenalty:setVisible(not checkCanMarkMember)

		if checkCanMarkMember then
			if checkMarked then
				self.penaltySwitch:setVisible(true)
				self.btnPenaltySelect:setVisible(true)
				self.btnPenaltyNormal:setVisible(false)
				self.txtPenaltyCD:setVisible(false)
			else
				local cd = ResClanMisc[1].marked_member_cd * 3600
				local cdEndTime = (self.member.battle_data.marked_tick or 0) + cd

				self.penaltyLeftTime = cdEndTime - ClientUtils.getServerTime()

				if self.penaltyLeftTime > 0 then
					self.penaltySwitch:setVisible(false)
					self.txtPenaltyCD:setVisible(true)
					self.txtPenaltyCD:setText(utils.calcTimeTxt(self.penaltyLeftTime))

					self.timerPenalty = Timer.New(Slot(self.refreshTxtPenaltyCD, self), 1, -1)

					self.timerPenalty:Start()
				else
					self.penaltySwitch:setVisible(true)
					self.btnPenaltyNormal:setVisible(true)
					self.btnPenaltySelect:setVisible(false)
					self.txtPenaltyCD:setVisible(false)
				end
			end
		end
	end
end

function HonorInfoCell:refreshTxtPenaltyCD()
	self.penaltyLeftTime = self.penaltyLeftTime - 1

	if self.penaltyLeftTime < 0 then
		self:refreshPenaltyPanel()
	else
		self.txtPenaltyCD:setText(utils.calcTimeTxt(self.penaltyLeftTime))
	end
end

function HonorInfoCell:onMarkStateChange()
	self:refreshPenaltyPanel()
end

function HonorInfoCell:onClickBtnPaneltyNormal()
	if CurAvatar.myCircle and not CurAvatar.myCircle:checkMarkMemberFull(true) then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(8), Lang.get(74327), Slot(self.paneltyNormalCallBack, self), nil)
	end
end

function HonorInfoCell:paneltyNormalCallBack()
	CurAvatar:sendMarkMemberReq(self.member.base.uid)
end

function HonorInfoCell:onClickBtnPaneltySelect()
	if CurAvatar.myCircle then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(8), Lang.get(74328), Slot(self.paneltySelectCallBack, self), nil)
	end
end

function HonorInfoCell:paneltySelectCallBack()
	CurAvatar:sendUnmarkMemberReq(self.member.base.uid)
end

function HonorInfoCell:destroy()
	if self.timerPenalty then
		self.timerPenalty:Stop()

		self.timerPenalty = nil
	end
end

return HonorInfoCell
