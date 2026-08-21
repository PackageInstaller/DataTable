-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoPandoraPanel.lua

local ResRelics = require("ClientData/ResRelics")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local BtnDebuffChild = require("UI/Maze/BtnDebuffChild")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "MazeLvInfoPandoraPanel"
local MazeLvInfoPandoraPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoPandoraPanel, MazeNodePanelMixin, true)

function MazeLvInfoPandoraPanel:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function MazeLvInfoPandoraPanel:initUI(...)
	self.btnSensor = UIControls.Button(self, "BtnSensor")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.txtDebuffInfoName = UIControls.Label(self, "BtnSensor/DebuffInfoPanel/TextName")
	self.txtDebuffDesc = UIControls.Label(self, "BtnSensor/DebuffInfoPanel/TextEffect")
	self.txtAwardName = UIControls.Label(self, "FrontPanel/AwardPanel/TextName")
	self.txtDebuffName = UIControls.Label(self, "FrontPanel/DebuffPanel/TextName")
	self.txtDesc = UIControls.Label(self, "FrontPanel/TextDes")
end

function MazeLvInfoPandoraPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initAward(branchData.param[1], "FrontPanel/AwardPanel")
	self.txtAwardName:setText(self.itemGrids[1].object.name)
	self:initPandura(branchData.param[2])
	self.txtDesc:setText(ResMazeNodeConfig[branchData.type].desc)
end

function MazeLvInfoPandoraPanel:initPandura(hallowId)
	if ResRelics[hallowId] then
		self.hallowCell = BtnDebuffChild(self, "FrontPanel/DebuffPanel", "System/Mazz/BtnMazzDebuff")

		self.hallowCell:setVisible(true)

		self.hallowCell.mClickEvent = Slot(self.onBtnDebuffClick, self)

		self.hallowCell:setData(hallowId)
		self.hallowCell:hideBg()

		local resRelic = ResRelics[hallowId]

		self.txtDebuffName:setText(resRelic.name)
		self.txtDebuffInfoName:setText(resRelic.name)
		self.txtDebuffDesc:setText(resRelic.dec)
	end
end

function MazeLvInfoPandoraPanel:onBtnDebuffClick(...)
	self.btnSensor:setVisible(true)
end

function MazeLvInfoPandoraPanel:onBtnSensorClick(...)
	self.btnSensor:setVisible(false)
end

function MazeLvInfoPandoraPanel:onBtnFuncClick(...)
	local function yesFunc(...)
		self.mWindow:hide()
		MsgManager.notice(Lang.get(30585))

		for _, itemGrid in ipairs(self.itemGrids) do
			if itemGrid:getVisible() then
				itemGrid.grid:flyToCommonFuncEntryPanel()
			end
		end

		local ui = UIManager.getUI("mazeMainDlg", nil, false)

		if ui then
			FlyIconUtils.setFlyUItoUI(self.hallowCell.imgIcon, ui:getDebuffFlyObj())
		end

		RPC.mazeSelectBranch(self.branchIndex)
	end

	local content = Lang.get(30586)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, -1, Lang.get(104), Lang.get(569))
end

return MazeLvInfoPandoraPanel
