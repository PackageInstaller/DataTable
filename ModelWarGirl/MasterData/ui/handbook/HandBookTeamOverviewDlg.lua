-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookTeamOverviewDlg.lua

local HandBookTeamCell = Class("HandBookTeamCell", UIControls.Button)
local EventConst = require("EventConst")

function HandBookTeamCell:ctor(...)
	self:initUI()
end

function HandBookTeamCell:initUI(...)
	self.btnSensor = UIControls.Button(self, self.mPath .. "/BtnTeam")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.txtVer = UIControls.Label(self, self.mPath .. "/BtnTeam/TextVer")
	self.txtName = UIControls.Label(self, self.mPath .. "/BtnTeam/TextName")
	self.txtProficient = UIControls.Label(self, self.mPath .. "/BtnTeam/GPPanel/TextGP")
	self.imgNew = UIControls.Image(self, self.mPath .. "/BtnTeam/IconNew")

	if UIControls.checkControlFunc(self, self.mPath .. "/BtnTeam/PatchPanel") then
		self.patchPanel = UIControls.Panel(self, self.mPath .. "/BtnTeam/PatchPanel")
		self.txtPatchNum = UIControls.Label(self, self.mPath .. "/BtnTeam/PatchPanel/TextPatch")
	end
end

function HandBookTeamCell:setData(teamIndex)
	self.teamIndex = teamIndex

	self:refreshData()

	if RegionUtils.isJP() then
		self.txtName:setVisible(false)
	else
		self.txtName:setText(Const.HERO_TEAM_CONFIG[self.teamIndex].name)
	end
end

function HandBookTeamCell:refreshData(...)
	local gInfo = CurAvatar:getProficientGInfo(self.teamIndex)
	local level = 0

	if gInfo then
		level = gInfo.level
	end

	self.txtVer:setText(level)

	local groupInfo = CurAvatar:getProficientGInfo(self.teamIndex)
	local score = 0

	if groupInfo then
		score = groupInfo.score
	end

	self.txtProficient:setText(score)
	self.imgNew:setVisible(CurAvatar:isNewProficient(self.teamIndex) or CurAvatar:isProficientLvUp(self.teamIndex))

	if self.patchPanel then
		local check = CurAvatar:checkTeamPatchFuncOpen()

		self.patchPanel:setVisible(check)
		self.txtPatchNum:setText(CurAvatar:getTeamPatchTotalNum(self.teamIndex))
	end
end

function HandBookTeamCell:onBtnSensorClick(...)
	UIManager.getUI("handBookTeamDetailDlg", true):show(self.teamIndex)
end

local strClassName = "HandBookTeamOverviewDlg"
local HandBookTeamOverviewDlg = Class(strClassName, UIControls.Window)

function HandBookTeamOverviewDlg:ctor(...)
	self:initUI()
end

function HandBookTeamOverviewDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnHelp = UIControls.Button(self, "MainInfoPanel/BgOverview/BtnHelp")

	self.btnHelp:addEventClick(self.onBtnHelpClick)

	self.btnOther = UIControls.Button(self, "MainInfoPanel/BgOverview/BtnOther")

	self.btnOther:addEventClick(self.onBtnOtherClick)

	self.btnUR = UIControls.Button(self, "MainInfoPanel/BgOverview/BtnUR")

	self.btnUR:addEventClick(self.onBtnURClick)
	self.btnUR:setVisible(Const.UR_HAND_BOOK_OPEN)

	self.imgNewUR = UIControls.Image(self, "MainInfoPanel/BgOverview/BtnUR/IconNew")
	self.imgNewOther = UIControls.Image(self, "MainInfoPanel/BgOverview/BtnOther/IconNew")
	self.txtProficient = UIControls.Label(self, "MainInfoPanel/BgOverview/TextGP")
	self.btnCells = {}

	for i = 1, 6 do
		local btn = HandBookTeamCell(self, "MainInfoPanel/BgInfo/InfoPanel/Team" .. i)

		table.insert(self.btnCells, btn)
		btn:setData(i)
	end

	self.btnOther:setVisible(Const.IS_SHOW_OTHER_TEAM_PROFICIENT)

	if UIControls.checkControlFunc(self, "MainInfoPanel/BgInfo/BtnPatch") then
		self.btnPatch = UIControls.Button(self, "MainInfoPanel/BgInfo/BtnPatch")

		self.btnPatch:addEventClick(self.onClickBtnPatch)

		self.redDotPatch = UIControls.RedDot(self, "MainInfoPanel/BgInfo/BtnPatch/IconNew")

		self.redDotPatch:addHint({
			UIConst.RD_HINT_HANDBOOK_TEAM_PATCH
		})

		self.slotOnHandBookTeamPatchChange = Slot(self.onHandBookTeamPatchChange, self)

		EventCenter.addEventListener(EventConst.HANDBOOK_TEAM_PATCH_CHANGE, self.slotOnHandBookTeamPatchChange)
	end
end

function HandBookTeamOverviewDlg:onOpen(...)
	HandBookTeamOverviewDlg.super.onOpen(self)
	self:show()
	self:refreshData()
	self:refreshPatch()
end

function HandBookTeamOverviewDlg:destroy()
	if self.btnPatch then
		EventCenter.removeEventListener(EventConst.HANDBOOK_TEAM_PATCH_CHANGE, self.slotOnHandBookTeamPatchChange)
	end

	HandBookTeamOverviewDlg.super.destroy(self)
end

function HandBookTeamOverviewDlg:show(...)
	self.txtProficient:setText(CurAvatar:getTotalProficient())
end

function HandBookTeamOverviewDlg:refreshData(...)
	for _, cell in ipairs(self.btnCells) do
		cell:refreshData()
	end

	if Const.IS_SHOW_OTHER_TEAM_PROFICIENT then
		local result = false

		result = CurAvatar:isOtherNewProficient()

		self.imgNewOther:setVisible(result)
	end

	if Const.UR_HAND_BOOK_OPEN then
		self.imgNewUR:setVisible(CurAvatar:isNewProficient(Const.UR_TEAM_INDEX, true) or CurAvatar:isProficientLvUp(Const.UR_TEAM_INDEX, nil, true))
	end
end

function HandBookTeamOverviewDlg:refreshPatch()
	if self.btnPatch then
		local check = CurAvatar:checkTeamPatchFuncOpen()

		self.btnPatch:setVisible(check)
	end
end

function HandBookTeamOverviewDlg:onBtnURClick()
	UIManager.getUI("handBookTeamDetailDlg", true):show(Const.UR_TEAM_INDEX, true)
end

function HandBookTeamOverviewDlg:onBtnOtherClick(...)
	UIManager.getUI("handBookTeamDetailDlg", true):show()
end

function HandBookTeamOverviewDlg:onBtnHelpClick(...)
	UIManager.getUI("rentTeamOverviewDlg", true)
end

function HandBookTeamOverviewDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function HandBookTeamOverviewDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_TEAM)
end

function HandBookTeamOverviewDlg:onClickBtnPatch()
	UIManager.getUI("handBookTeamPatchDlg", true)
end

function HandBookTeamOverviewDlg:onHandBookTeamPatchChange(teamId)
	self:refreshData()
end

return HandBookTeamOverviewDlg
