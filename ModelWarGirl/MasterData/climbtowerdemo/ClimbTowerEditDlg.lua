-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\ClimbTowerEditDlg.lua

local ClimbTowerDragCenter = require("ClimbTowerDemo/ClimbTowerDragCenter")
local COLOR_MODE = {
	NORMAL = {
		g = 214,
		a = 255,
		b = 82,
		r = 242
	},
	UP = {
		g = 74,
		a = 255,
		b = 250,
		r = 65
	},
	YELLOW = {
		g = 0.7764705882352941,
		a = 1,
		b = 0.2784313725490196,
		r = 1
	}
}
local strClassName = "ClimbTowerEditDlg"
local ClimbTowerEditDlg = Class(strClassName, UIControls.Window)

function ClimbTowerEditDlg:ctor(...)
	self:initUI()

	self.dragPutEnable = true
end

function ClimbTowerEditDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelEdit = UIControls.Panel(self, "EditPanel")

	self.panelEdit:setVisible(false)

	self.panelBg = UIControls.DragClickPanel(self, "DragBg")
	self.imgWarning = UIControls.Panel(self, "ImgNotice")
	self.txtWarning = UIControls.Label(self, "ImgNotice/Text")
	self.slider = UIControls.Slider(self, "Slider")

	self.slider:addEventValueChanged(self.onSliderValueChange)

	self.items = {}
	self.curType = 5
end

function ClimbTowerEditDlg:onOpen(...)
	ClimbTowerEditDlg.super.onOpen(self)

	self.mainState = GameFsm.getState(Const.STATE_CLIMB_TOWER)

	self.mainState:setCurUI(self)
	ClimbTowerDragCenter.setMode(self)
	self.mainState:setCameraOrthographic(true)
end

function ClimbTowerEditDlg:show()
	return
end

function ClimbTowerEditDlg:showWarning(show, content)
	self.imgWarning:setVisible(show)
	self.txtWarning:setText(content or Lang.get(96888))
end

function ClimbTowerEditDlg:onSliderValueChange(com, value)
	ClimbTowerDragCenter.onSliderValueChange(value)
end

function ClimbTowerEditDlg:setSliderValue(value)
	self.slider:setValue(value)
end

function ClimbTowerEditDlg:onBtnCloseClick(...)
	GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
end

return ClimbTowerEditDlg
