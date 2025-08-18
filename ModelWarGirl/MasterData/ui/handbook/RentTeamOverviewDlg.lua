-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\RentTeamOverviewDlg.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "RentTeamOverviewDlg"
local RentTeamOverviewDlg = Class(strClassName, UIControls.Window)

function RentTeamOverviewDlg:ctor(...)
	self:initUI()
end

function RentTeamOverviewDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.txtRule = UIControls.Label(self, "Bg/TextRule")
	self.txtPre = UIControls.Label(self, "Bg/LevelInfoPanel/LevelPre/Text")
	self.txtProficient = UIControls.Label(self, "Bg/LevelInfoPanel/ArrowPanel/TextGP")
	self.txtNext = UIControls.Label(self, "Bg/LevelInfoPanel/LevelNext/Text")
	self.panelMax = UIControls.Panel(self, "Bg/LevelInfoPanel/TextMax")
	self.panelNext = UIControls.Panel(self, "Bg/LevelInfoPanel/LevelNext")
	self.panelProficient = UIControls.Panel(self, "Bg/LevelInfoPanel/ArrowPanel")
end

function RentTeamOverviewDlg:onOpen(...)
	RentTeamOverviewDlg.super.onOpen(self)
	self:show()
end

function RentTeamOverviewDlg:show(...)
	self.txtTitle:setText(Lang.get(1055))
	self.txtRule:setText(Lang.get(30323))

	local curInfo, nextInfo, isMax = CurAvatar:getRentTeamCount()

	self.txtPre:setText(curInfo.team_count)

	if isMax then
		self.txtPre:setFontColor(ResColor.ORANGEBTN)
		self.panelMax:setVisible(true)
		self.panelNext:setVisible(false)
		self.panelProficient:setVisible(false)
	else
		self.txtPre:setFontColor(ResColor.WHITE)
		self.txtNext:setFontColor(ResColor.WHITE)
		self.panelMax:setVisible(false)
		self.panelNext:setVisible(true)
		self.panelProficient:setVisible(true)
		self.txtNext:setText(nextInfo.team_count)
		self.txtProficient:setText(CurAvatar:getTotalProficient() .. "/" .. nextInfo.total_score)
	end
end

return RentTeamOverviewDlg
