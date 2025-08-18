-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ResultSidePanel.lua

local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResultSidePanel = Class("ResultSidePanel", UIControls.Panel)
local ResPVP = require("ClientData/ResAsyncPVPMisc")
local ResRobotName = require("ClientData/ResRobotName")
local PVPCommon = require("Logic/PVP/PVPCommon")

function ResultSidePanel:ctor()
	self:initUI()
end

function ResultSidePanel:initUI()
	self.txtScore = UIControls.Label(self, self.mPath .. "ScorePanel/TextScore")
	self.txtRank = UIControls.Label(self, self.mPath .. "RankPanel/TextRank")
	self.txtPlayerName = UIControls.Label(self, self.mPath .. "PlayerInfoPanel/TextPlayerName")
	self.txtPower = UIControls.Label(self, self.mPath .. "PlayerInfoPanel/TextPower")
	self.txtLevel = UIControls.Label(self, self.mPath .. "PlayerInfoPanel/TextLv")
	self.btnHead = UIControls.PlayerHeadGridChild(self, self.mPath .. "PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead.txtLv:setVisible(false)
	self.btnHead:setEnable(false)
end

function ResultSidePanel:initData(data, outPower)
	if data.changeScore ~= nil then
		if data.changeScore > 0 then
			self.txtScoreChange:setText("+" .. data.changeScore)
		else
			self.txtScoreChange:setText(data.changeScore)
		end

		self.txtScore:jumpTo(data.score - data.changeScore, data.score, 1)
	else
		self.txtScore:setText(data.score)
		CurAvatar:refreshOpponentInfo(data.uid, data.score)
	end

	local _name = data.name

	if utils.isRobot(data.uid) then
		local info = PVPCommon.getAsyncPvpRobotInfo(data.uid)

		if info then
			_name = info.name
		end
	end

	local name = utils.GetPlayerName(_name)

	self.txtPlayerName:setText(name)
	self.txtLevel:setText(data.level or 0)

	if self.imgAward and self.txtNum then
		self.imgAward:setImage(UIConst.MONEY_ID2INFO[Const.MONEY_ID_PVP][1], UIConst.MONEY_ID2INFO[Const.MONEY_ID_PVP][2])

		if self.mWindow.win then
			self.txtNum:setText("+" .. ResPVP[1].win_item_num)
		else
			self.txtNum:setText("+" .. ResPVP[1].lose_item_num)
		end
	end

	if self.isMySide then
		if data.rank > 0 then
			if CurAvatar.pvpRank and CurAvatar.pvpRank > 0 then
				self.txtRank:jumpTo(CurAvatar.pvpRank, data.rank, 1)

				CurAvatar.pvpRank = data.rank
			else
				self.txtRank:setText(data.rank)
			end
		else
			self.txtRank:setText("--")
		end

		local power = self:getMyPower()

		self.txtPower:setText(power)
	else
		if data.rank > 0 then
			self.txtRank:setText(data.rank)
		else
			self.txtRank:setText("--")
		end

		local power = 0

		if GameFsm.isInState(Const.STATE_BATTLE) then
			local state = GameFsm.getCurState()

			if state then
				power = CapacityHelper.getFormationCapacity(state.battlePreInfo.asyncPVPData.asyncPVPEnemy)

				CurAvatar:refreshOpponentInfo(data.uid, data.score, state.battlePreInfo.asyncPVPData.asyncPVPEnemy)
			end
		end

		self.txtPower:setText(power)
	end

	self.btnHead:setCommInfo(data, false, self)

	if outPower then
		self.txtPower:setText(outPower)
	end
end

function ResultSidePanel:getMyPower(...)
	local power = CurAvatar:getNowFormationCapacity(Const.FORMATION_MAIN_STAGE)

	return power
end

function ResultSidePanel:exraUI()
	self.txtScoreChange = UIControls.Label(self, self.mPath .. "ScorePanel/TextScoreChange")
	self.imgAward = UIControls.Image(self, self.mPath .. "AwardPanel/IconAward")
	self.txtNum = UIControls.Label(self, self.mPath .. "AwardPanel/TextNum")
	self.isMySide = true
end

return ResultSidePanel
