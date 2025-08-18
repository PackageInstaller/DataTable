-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MiniGame\\MiniGameShowAwardDlg.lua

local ResClimbTowerLevel = require("ClientData/ResClimbTowerLevel")
local strClassName = "MiniGameShowAwardDlg"
local MiniGameShowAwardDlg = Class(strClassName, UIControls.Window)

function MiniGameShowAwardDlg:ctor(...)
	self:initUI()
end

function MiniGameShowAwardDlg:initUI(...)
	self.itemGrids = {}
end

function MiniGameShowAwardDlg:setData(type)
	self.type = type
	self.chapter, self.stage = CurAvatar:getPassChapterAndStage(type)

	local award = ResClimbTowerLevel[self.chapter][self.stage].award

	if CurAvatar.firstSelectGameType and CurAvatar.firstSelectGameType == self.type then
		award = ResClimbTowerLevel[self.chapter][self.stage].first_award
	end

	ClientUtils.CreateBonusGrid(self, self.itemGrids, "Bg/AwardPanel", award or 102, true, nil, true)
end

function MiniGameShowAwardDlg:onDestroy()
	self:playInfoPanelAni()

	local state = Const.MINI_GAME_INFO[self.type].state
	local classCenter = require(Const.MINI_GAME_INFO[self.type].dragCenter)

	if GameFsm.isInState(state) then
		classCenter.leaveLevel()
	end

	MiniGameShowAwardDlg.super.onDestroy(self)
end

function MiniGameShowAwardDlg:playInfoPanelAni()
	local ui = UIManager.tryGetUI("miniGameInfoDlg")

	if ui then
		ui:playAni()

		return
	end

	if not ui then
		ui = UIManager.getUI("miniGameInfoDlg", true)

		local chapter, stage = CurAvatar:getPassChapterAndStage(self.type)

		ui:setDataByChapterAndStage(self.type, chapter, stage)
		ui:playAni()
	end
end

return MiniGameShowAwardDlg
