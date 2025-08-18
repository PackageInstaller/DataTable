-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/EliminateGame\\EliminateEditDlg.lua

local EliminateDragCenter = require("EliminateGame/EliminateDragCenter")
local strClassName = "EliminateEditDlg"
local EliminateEditDlg = Class(strClassName, UIControls.Window)

function EliminateEditDlg:ctor(...)
	self:initUI()

	self.dragPutEnable = true
end

function EliminateEditDlg:initUI(...)
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

function EliminateEditDlg:onOpen(...)
	EliminateEditDlg.super.onOpen(self)

	self.mainState = GameFsm.getState(Const.STATE_ELIMINATE)

	self.mainState:setCurUI(self)
	EliminateDragCenter.setMode(self)
	self.mainState:setCameraOrthographic(true)
end

function EliminateEditDlg:show()
	return
end

function EliminateEditDlg:showWarning(show, content)
	self.imgWarning:setVisible(show)
	self.txtWarning:setText(content or Lang.get(97827))
end

function EliminateEditDlg:onSliderValueChange(com, value)
	EliminateDragCenter.onSliderValueChange(value)
end

function EliminateEditDlg:setSliderValue(value)
	self.slider:setValue(value)
end

function EliminateEditDlg:onBtnCloseClick(...)
	GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
end

return EliminateEditDlg
