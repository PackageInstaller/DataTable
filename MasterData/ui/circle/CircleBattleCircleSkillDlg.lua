-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleCircleSkillDlg.lua

local CircleSkillCell = require("UI/Circle/CircleSkillCell")
local strClassName = "CircleBattleCircleSkillDlg"
local CircleBattleCircleSkillDlg = Class(strClassName, UIControls.Window)

function CircleBattleCircleSkillDlg:ctor()
	self:initUI()
end

function CircleBattleCircleSkillDlg:initUI()
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")
	self.imgContribute = UIControls.Image(self, "Bg/NotOwnedPanel/BgTitle/ContributePanel/Icon")
	self.txtContribute = UIControls.Label(self, "Bg/NotOwnedPanel/BgTitle/ContributePanel/TextNum")
	self.txtNone = UIControls.Panel(self, "Bg/OwnedPanel/TextNone")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.notHavecells = {}
	self.havecells = {}
	self.scrollNotHaveCircleSkill = UIControls.ScrollViewLoopH(self, "Bg/NotOwnedPanel/SkillList")

	self.scrollNotHaveCircleSkill:addEventCellChanged(self.onCircleNotHaveSkillChanged)

	self.scrollHaveCircleSkill = UIControls.ScrollViewLoopH(self, "Bg/OwnedPanel/SkillList")

	self.scrollHaveCircleSkill:addEventCellChanged(self.onCircleHaveSkillChanged)

	self.btnTips = UIControls.Button(self, "Bg/NotOwnedPanel/BgTitle/ContributePanel")

	self.btnTips:addEventClick(self.onBtnTipsClick)
	self:initCircleSkillData()
end

function CircleBattleCircleSkillDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_CIRCLE_BATTLE_CONTRIBUTION)
end

function CircleBattleCircleSkillDlg:onBtnCloseClick()
	self:setVisible(false)
end

local function _sortCircleSkill(skillA, skillB)
	if skillA.sortValue ~= skillB.sortValue then
		return skillA.sortValue < skillB.sortValue
	else
		return skillA.id < skillB.id
	end
end

function CircleBattleCircleSkillDlg:initCircleSkillData()
	if CurAvatar.myCircle then
		self.txtContribute:setText(ClientUtils.getNumShortStr(CurAvatar.myCircle:getCircleContribution()))

		local contributeIconPath = UIConst.CIRCLE_BATTLE_CONTRIBUTE_PATH

		if contributeIconPath then
			self.imgContribute:setImage(contributeIconPath[1], contributeIconPath[2])
		end
	end

	self.notHaveCircleSkillList = CurAvatar:getAllCircleSkill(false, true)
	self.haveCircleSkillList = CurAvatar:getAllCircleSkill(true)

	table.sort(self.haveCircleSkillList, _sortCircleSkill)
	table.sort(self.notHaveCircleSkillList, _sortCircleSkill)
	self.scrollNotHaveCircleSkill:setTotalCount(#self.notHaveCircleSkillList)
	self.scrollHaveCircleSkill:setTotalCount(#self.haveCircleSkillList)
	self.txtNone:setVisible(#self.haveCircleSkillList == 0)
end

function CircleBattleCircleSkillDlg:onCircleNotHaveSkillChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleSkillCell(sender, "System/CircleBattle/CircleSkillCell", newIdx)

	if not self.notHaveCircleSkillList or #self.notHaveCircleSkillList == 0 then
		return
	end

	if self.notHaveCircleSkillList[newIdx] ~= nil then
		targetCell:setCircleSkill(self.notHaveCircleSkillList[newIdx])
	end

	self.notHavecells[newIdx] = targetCell
end

function CircleBattleCircleSkillDlg:onCircleHaveSkillChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleSkillCell(sender, "System/CircleBattle/CircleSkillCell", newIdx)

	if not self.haveCircleSkillList or #self.haveCircleSkillList == 0 then
		return
	end

	if self.haveCircleSkillList[newIdx] ~= nil then
		targetCell:setCircleSkill(self.haveCircleSkillList[newIdx])
	end

	self.havecells[newIdx] = targetCell
end

return CircleBattleCircleSkillDlg
