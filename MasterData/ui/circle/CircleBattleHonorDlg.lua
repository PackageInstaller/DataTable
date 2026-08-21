-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleHonorDlg.lua

local HonorInfoCell = require("UI/Circle/HonorInfoCell")
local ResClanMisc = require("ClientData/ResClanMisc")
local strClassName = "CircleBattleHonorDlg"
local CircleBattleHonorDlg = Class(strClassName, UIControls.Window)

function CircleBattleHonorDlg:ctor()
	self:initUI()
end

function CircleBattleHonorDlg:initUI()
	self.txtTitleAction = UIControls.Label(self, "BgPanel/TitlePanel/ActionPanel/TextTotal")
	self.txtTitleSearch = UIControls.Label(self, "BgPanel/TitlePanel/SearchPanel/TextTotal")
	self.txtTitleTreasure = UIControls.Label(self, "BgPanel/TitlePanel/SearchPanel/TextTreasure")
	self.txtTitleFindBoss = UIControls.Label(self, "BgPanel/TitlePanel/SearchPanel/TextBoss")
	self.txtTitleRune = UIControls.Label(self, "BgPanel/TitlePanel/SearchPanel/TextRune")
	self.txtTitleBattle = UIControls.Label(self, "BgPanel/TitlePanel/BattlePanel/TextTotal")
	self.txtTitleKillMan = UIControls.Label(self, "BgPanel/TitlePanel/BattlePanel/TextKill")
	self.txtTitleBattleBoss = UIControls.Label(self, "BgPanel/TitlePanel/BattlePanel/TextBoss")
	self.txtTitleKillBoss = UIControls.Label(self, "BgPanel/TitlePanel/BattlePanel/TextKillBoss")
	self.penaltyPanel = UIControls.Panel(self, "BgPanel/TitlePanel/PenaltyPanel")
	self.btnPenaltyTips = UIControls.Button(self, "BgPanel/TitlePanel/PenaltyPanel/BtnTips")

	self.btnPenaltyTips:addEventClick(self.onClickBtnPenaltyTips)

	self.txtPenalty = UIControls.Label(self, "BgPanel/TitlePanel/PenaltyPanel/TextPenalty")
	self.btnRecord = UIControls.Button(self, "BtnRecord")

	self.btnRecord:addEventClick(self.onBtnRecordClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtTime = UIControls.Label(self, "BgPanel/TimePanel/TextTime")
	self.cells = {}
	self.scrollHonorInfo = UIControls.ScrollViewLoopH(self, "BgPanel/HonorList")

	self.scrollHonorInfo:addEventCellChanged(self.onHonorInfoChanged)
	self:initTitleShow()
	self:refreshTime()
end

function CircleBattleHonorDlg:initTitleShow()
	self.txtTitleAction:setText(Lang.get(41688))
	self.txtTitleSearch:setText(Lang.get(38781))
	self.txtTitleTreasure:setText(Lang.get(33388))
	self.txtTitleFindBoss:setText(Lang.get(37081))
	self.txtTitleRune:setText(Lang.get(40573))
	self.txtTitleBattle:setText(Lang.get(699))
	self.txtTitleKillMan:setText(Lang.get(37083))
	self.txtTitleBattleBoss:setText(Lang.get(37084))
	self.txtTitleKillBoss:setText(Lang.get(37085))
end

function CircleBattleHonorDlg:onHonorInfoChanged(sender, targetCell, newIdx)
	targetCell = targetCell or HonorInfoCell(sender, "System/CircleBattle/HonorInfoCell", newIdx)

	if not self.honorInfoDataList or #self.honorInfoDataList == 0 then
		return
	end

	if self.honorInfoDataList[newIdx] ~= nil then
		targetCell:setHonorInfoData(self.honorInfoDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell

	self:refreshPenaltyPanel()
end

function CircleBattleHonorDlg:setHonorInfoData(honorInfoDataList)
	self.honorInfoDataList = honorInfoDataList

	self.scrollHonorInfo:setTotalCount(#self.honorInfoDataList)
	self:refreshPenaltyPanel()
end

function CircleBattleHonorDlg:refreshTime(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local leftTime = 0
	local actObj = CurAvatar:getCircleBattleActivity()

	if actObj then
		leftTime = actObj.actData:getLeftTimeToEnd()
	end

	if leftTime > 0 then
		self.txtTime:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(30590), nil, nil)
	else
		self.txtTime:setVisible(false)
	end
end

function CircleBattleHonorDlg:onBtnRecordClick()
	local circleBattleActionRecordDlg = UIManager.getUI("circleBattleActionRecordDlg", true)
end

function CircleBattleHonorDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CircleBattleHonorDlg:onMarkDataChange(uid)
	self:refreshPenaltyPanel()

	for _, cell in pairs(self.cells) do
		if cell and cell.member and cell.member.base and cell.member.base.uid == uid then
			cell:refreshPenaltyPanel()

			break
		end
	end
end

function CircleBattleHonorDlg:refreshPenaltyPanel()
	local checkShow = CurAvatar:checkCircleActivityOpen()
	local checkCanMarkMember = CurAvatar:checkCanMarkMember()

	self.penaltyPanel:setVisible(checkShow)

	if checkShow then
		if checkCanMarkMember then
			local markNum = CurAvatar.myCircle:getMarkMemberNum()

			self.txtPenalty:setText(string.format(Lang.get(74321), markNum, ResClanMisc[1].mark_max_num))
		else
			self.txtPenalty:setText(string.format(Lang.get(74322)))
		end
	end
end

function CircleBattleHonorDlg:onClickBtnPenaltyTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_CIRCLE_MARK_MEMBER)
end

function CircleBattleHonorDlg:destroy()
	for _, cell in pairs(self.cells) do
		cell:destroy()
	end

	CircleBattleHonorDlg.super.destroy(self)
end

return CircleBattleHonorDlg
