-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeCareerEventChooseDlg.lua

local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local NewMazeCareerEventCareerPanel = Class("NewMazeCareerEventCareerPanel", UIControls.Panel)

function NewMazeCareerEventCareerPanel:ctor()
	self.btnChoose = UIControls.Button(self, self.mPath .. "/BtnNml")

	self.btnChoose:addEventClick(self.onChooseClick)

	self.panelDisable = UIControls.Panel(self, self.mPath .. "/DisPanel")
end

function NewMazeCareerEventCareerPanel:setValid(valid)
	self.valid = valid

	self.panelDisable:setVisible(not valid)
end

function NewMazeCareerEventCareerPanel:onChooseClick()
	self.mParent:onChooseClick(self)
end

local strClassName = "NewMazeCareerEventChooseDlg"
local NewMazeCareerEventChooseDlg = Class(strClassName, UIControls.Window)

function NewMazeCareerEventChooseDlg:ctor()
	self:initUI()
end

function NewMazeCareerEventChooseDlg:initUI()
	self.careerPanels = {}

	for index = 1, 5 do
		local newPanel = NewMazeCareerEventCareerPanel(self, "MainInfoPanel/CareerPanel/ItemPanel" .. index)

		newPanel.career = index

		table.insert(self.careerPanels, newPanel)
	end

	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.panelConfirmNml = UIControls.Panel(self, "MainInfoPanel/BtnConfirm/NmlPanel")
	self.panelConfirmDis = UIControls.Panel(self, "MainInfoPanel/BtnConfirm/DisPanel")
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)
end

function NewMazeCareerEventChooseDlg:onShow(opId, chooseIndex, poolId, validCareer)
	self.opId = opId
	self.chooseIndex = chooseIndex

	local validTab = {}

	for _, car in ipairs(validCareer) do
		validTab[car] = true
	end

	for index, pan in pairs(self.careerPanels) do
		pan:setValid(validTab[index])
	end
end

function NewMazeCareerEventChooseDlg:onChooseClick(sender)
	if not sender.valid then
		MsgManager.notice(Lang.get(102254))

		return
	end

	if self.selectCareer == sender.career then
		self.selectCareer = nil

		self.panelConfirmNml:setVisible(false)
		self.panelConfirmDis:setVisible(true)
	else
		self.selectCareer = sender.career

		self.panelConfirmNml:setVisible(true)
		self.panelConfirmDis:setVisible(false)
	end

	for index, pan in pairs(self.careerPanels) do
		pan.btnChoose:setEnable(pan.career ~= self.selectCareer)
	end
end

function NewMazeCareerEventChooseDlg:onConfirmClick()
	if self.selectCareer then
		RPC.newMazeRandomEventOptionSelect(self.opId, self.chooseIndex, {
			self.selectCareer
		})
		self:setVisible(false)

		local randomDetailDlg = UIManager.tryGetUI("newMazeRandomDetailDlg")

		if randomDetailDlg then
			randomDetailDlg:setVisible(false)
		end
	else
		MsgManager.notice(Lang.get(102255))
	end
end

function NewMazeCareerEventChooseDlg:onCloseClick()
	self:setVisible(false)
end

return NewMazeCareerEventChooseDlg
