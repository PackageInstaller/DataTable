-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossAwardCircleDlg.lua

local ResBossTower = require("ClientData/ResBossTower")
local ResClanMisc = require("ClientData/ResClanMisc")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "BossAwardCircleDlg"
local BossAwardCircleDlg = Class(strClassName, UIControls.Window)

function BossAwardCircleDlg:ctor()
	self:initUI()
end

function BossAwardCircleDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.panelMemberInfo = UIControls.Panel(self, "BgPanel/MemberInfoPanel")
	self.txtName = UIControls.Label(self, "BgPanel/MemberInfoPanel/TextPlayerName")
	self.imgIconSex = UIControls.Image(self, "BgPanel/MemberInfoPanel/TextPlayerName/IconSex")
	self.txtProgress = UIControls.Label(self, "BgPanel/MemberInfoPanel/TextProgressTitle/TextProgress")
	self.panelCircleAward = UIControls.Panel(self, "BgPanel/CircleAwardPanel")
	self.txtTime = UIControls.Label(self, "BgPanel/CircleAwardPanel/TextTime")
	self.panelNone = UIControls.Panel(self, "BgPanel/NonePanel")
end

function BossAwardCircleDlg:setMemberRankData(rankData)
	self.rankData = rankData

	local roleCommon = self.rankData.data.comm
	local name, svrName = utils.GetPlayerName(roleCommon.name)

	self.txtName:setText(name)

	self.gridPlayer = UIControls.PlayerHeadGridChild(self, "BgPanel/MemberInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon", 0, 0, true)

	self.gridPlayer:setCommInfo(roleCommon, false, self)

	if roleCommon.gender == Const.GENDER_MAN then
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	local score = self.rankData.data.score
	local scoreStr = UIConst.getRankScoreStr(Const.RANK_TYPE_BOSSTOWER3, score)

	self.txtProgress:setText(scoreStr)

	local layer = math.floor(score / 100000)
	local level = score - layer * 100000

	if ResBossTower[Const.BOSS_TOWER_TYPE_ZOMBIE][layer] and ResBossTower[Const.BOSS_TOWER_TYPE_ZOMBIE][layer].clan_award[level] then
		local awardId = ResBossTower[Const.BOSS_TOWER_TYPE_ZOMBIE][layer].clan_award[level].award

		for i, itemId in ipairs(ResRandClient[awardId].show_ids) do
			local itemNum = ResRandClient[awardId].show_nums[i]
			local item = BaseObject.GetObject(itemId, itemNum)
			local itemGrid = UIControls.getGridChild(item, self, "BgPanel/CircleAwardPanel/AwardPanel")

			itemGrid:setObj(item)
			itemGrid:setVisible(true)

			itemGrid.mDisableWays = true
		end
	end

	local mailTick = 0

	if ResClanMisc[1].settle == Const.CIRCLE_BOSS_AWARD_DAY_SA then
		mailTick = ClientUtils.getServerTimeNextDay()
	elseif ResClanMisc[1].settle == Const.CIRCLE_BOSS_AWARD_WEEK_SA then
		mailTick = ClientUtils.getServerTimeNextWday(Const.CIRCLE_BOSS_AWARD_SA_WDAY)
	end

	local remainTime = mailTick - ClientUtils.getServerTime()

	if remainTime > 0 then
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, Lang.get(48671), Slot(self.timeDownCallBack, self))
	else
		self:timeDownCallBack()
		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	end
end

function BossAwardCircleDlg:timeDownCallBack()
	self.txtTime:setText(Lang.get(715))
end

function BossAwardCircleDlg:setEmptyStatus()
	self.panelNone:setVisible(true)
	self.panelMemberInfo:setVisible(false)
	self.panelCircleAward:setVisible(false)
end

function BossAwardCircleDlg:onBtnCloseClick()
	self:setVisible(false)
end

function BossAwardCircleDlg:onBtnConfirmClick()
	self:setVisible(false)
end

return BossAwardCircleDlg
