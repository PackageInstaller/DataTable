-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterAwardDlg.lua

local ResMasterLevel = require("ClientData.ResMasterLevel")
local AwardCell = Class("MasterAwardDlg_AwardCell", UIControls.ScrollViewLoopCell)

function AwardCell:ctor()
	self.txtLv = UIControls.Label(self, "TextNum")
	self.btnGet = UIControls.Button(self, "BtnConfirm")

	self.btnGet:addEventClick(self.onClickBtnGet)
end

function AwardCell:setData(config, curLv, checkGot)
	self.lv = config.level

	self.txtLv:setText(string.format(Lang.get(80803), self.lv))

	self.awardCellList = self.awardCellList or {}

	ClientUtils.CreateBonusGrid(self, self.awardCellList, "AwardPanel", config.award)

	if curLv < self.lv then
		self:playStateAnimator("RankSelectTeacherAwardCellNml")
	elseif checkGot then
		self:playStateAnimator("RankSelectTeacherAwardCellDis")
	else
		self:playStateAnimator("RankSelectTeacherAwardHigh")
	end
end

function AwardCell:onClickBtnGet()
	RPC.masterGetLevelAward(self.lv)
end

local MasterAwardDlg = Class("MasterAwardDlg", UIControls.Window)

function MasterAwardDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.txtLv = UIControls.Label(self, "BgPanel/TextLv")
	self.slider = UIControls.Slider(self, "BgPanel/Slider")
	self.txtSlider = UIControls.Label(self, "BgPanel/TextNum")
	self.scrollAward = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList")

	self.scrollAward:addEventCellChanged(self.onScrollAwardChange)
end

function MasterAwardDlg:onOpen()
	MasterAwardDlg.super.onOpen(self)
	self.txtLv:setText(string.format(Lang.get(80803), CurAvatar.masterLv))

	local checkMaxLv = CurAvatar:isMaxMasterLevel()

	self.txtSlider:setVisible(not checkMaxLv)
	self.txtSlider:setVisible(not checkMaxLv)

	if not checkMaxLv then
		local lastExp = ResMasterLevel[CurAvatar.masterLv] and ResMasterLevel[CurAvatar.masterLv].need_xp or 0
		local nextExp = ResMasterLevel[CurAvatar.masterLv + 1].need_xp - lastExp

		self.txtSlider:setText(CurAvatar.masterExp .. "/" .. nextExp)
		self.slider:setValue(CurAvatar.masterExp / nextExp)
	end

	self:refreshAward()
end

function MasterAwardDlg:refreshAward()
	local jumpIdx = 1

	for i, config in ipairs(ResMasterLevel) do
		if config.level > CurAvatar.masterLv then
			break
		end

		if not CurAvatar.masterLvAwardGotDic[config.level] then
			jumpIdx = i

			break
		end
	end

	if jumpIdx > #ResMasterLevel - 4 then
		jumpIdx = #ResMasterLevel - 4
	end

	self.scrollAward:setTotalCount(#ResMasterLevel, jumpIdx)
end

function MasterAwardDlg:onScrollAwardChange(sender, cell, idx)
	if not cell then
		cell = AwardCell(sender, "System/HandBook/RankSelectTeacherAwardCell", idx)
	else
		cell.mIndex = idx
	end

	cell:setData(ResMasterLevel[idx], CurAvatar.masterLv, CurAvatar.masterLvAwardGotDic[ResMasterLevel[idx].level])
end

function MasterAwardDlg:onClickBtnClose()
	self:setVisible(false)
end

function MasterAwardDlg:onMasterGetLevelAwardResp()
	self:refreshAward()
end

return MasterAwardDlg
