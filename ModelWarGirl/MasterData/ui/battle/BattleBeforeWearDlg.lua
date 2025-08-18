-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleBeforeWearDlg.lua

local BagWearPart = require("UI/MainState/BagWearPart")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local UserData = require("Helper/UserData")
local strClassName = "BattleBeforeWearDlg"
local BattleBeforeWearDlg = Class(strClassName, UIControls.Window)

function BattleBeforeWearDlg:ctor()
	self:initUI()
end

function BattleBeforeWearDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)
end

function BattleBeforeWearDlg:createSubPanel()
	self.panelWear = BagWearPart(self, "BagWearingPanel", "System/Bag/ArrayBagWearingPanel")

	self.panelWear:setVisible(true)
	self.panelWear:setEquipWearingPanelData("BtnArrayEquipWearingPanel", self.heroInfos, self.battleType, self.petId)
	self.panelWear:refreshData()
	self.panelWear:initPlanList()
	self.panelWear:revertToCurWear()
end

function BattleBeforeWearDlg:setData(heroInfos, battleType, petId)
	self.heroInfos = heroInfos
	self.battleType = battleType
	self.petId = petId

	self:createSubPanel()
end

function BattleBeforeWearDlg:onCloseClick()
	local ui = UIManager.tryGetUI("topPvpTimeDlg")

	if ui and ui:getVisible() then
		ui:setVisible(false)
	end

	if self.panelWear then
		local function func()
			self:setVisible(false)
		end

		self.panelWear:closeDuel(Slot(func, self))
	end
end

function BattleBeforeWearDlg:onReconnect()
	self:refreshItem()
end

function BattleBeforeWearDlg:refreshItem()
	if self.panelWear then
		self.panelWear:refreshNoSort()
	end
end

function BattleBeforeWearDlg:onClose()
	BattleBeforeWearDlg.super.onClose(self)

	local ui = ClientUtils.getNowDragDlg()

	if ui then
		ui:updateHeroBag()
	end
end

return BattleBeforeWearDlg
