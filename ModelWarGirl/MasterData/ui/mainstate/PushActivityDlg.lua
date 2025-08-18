-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PushActivityDlg.lua

local ResActivityPushConfig = require("ClientData/ResActivityPushConfig")
local UserData = require("Helper/UserData")
local BTN_MAX_NUM = 3
local PushActivityNmlChild = Class("PushActivityNmlChild", UIControls.Child)

function PushActivityNmlChild:ctor()
	self.jumpBtns = {}

	for index = 1, BTN_MAX_NUM do
		local btnGo = UIControls.Button(self, "FuncPanel/BtnGo" .. index)

		btnGo.index = index

		btnGo:addEventClick(self.onGoClick)
	end
end

function PushActivityNmlChild:setData(oneData)
	self.oneData = oneData

	for index, btn in ipairs(self.jumpBtns) do
		if oneData["jump_id" .. index] then
			btn:setVisible(true)
		else
			btn:setVisible(false)
		end
	end
end

function PushActivityNmlChild:onGoClick(sender)
	local index = sender.index
	local jumpId = self.oneData["jump_id" .. index]

	JumpGuideManager.jump(jumpId)
end

local strClassName = "PushActivityDlg"
local PushActivityDlg = Class(strClassName, UIControls.Window)

function PushActivityDlg:ctor()
	self:initUI()
end

function PushActivityDlg:initUI()
	self.btnNext = UIControls.Button(self, "EmptyClick")

	self.btnNext:addEventClick(self.onNextClick)

	self.toggleSkip = UIControls.Toggle(self, "BtnSkip")
end

function PushActivityDlg:onOpen()
	PushActivityDlg.super.onOpen(self)

	if not self.showData then
		self.showData = {}

		for id, configInfo in pairs(ResActivityPushConfig) do
			if ClientUtils.isPushConfigValid(configInfo) then
				table.insert(self.showData, configInfo)
			end
		end

		table.sort(self.showData, utils.getSortingFunc("id", true))
		self:onShow(1)
	end
end

function PushActivityDlg:onShow(pageNum)
	self.pageNum = pageNum

	if self.showData[pageNum] then
		if self.curPanel then
			if self.curPanel.nowPrefab ~= self.showData[pageNum].prefab_path then
				self.curPanel:setVisible(false)

				self.curPanel = PushActivityNmlChild(self, "PreviewPanel", "System/" .. self.showData[pageNum].prefab_path)
				self.curPanel.nowPrefab = self.showData[pageNum].prefab_path

				self.curPanel:setVisible(true)
			end
		else
			self.curPanel = PushActivityNmlChild(self, "PreviewPanel", "System/" .. self.showData[pageNum].prefab_path)
			self.curPanel.nowPrefab = self.showData[pageNum].prefab_path

			self.curPanel:setVisible(true)
		end

		self.curPanel:setData(self.showData[pageNum])
	else
		if self.toggleSkip:isOn() then
			UserData.saveCommonData("PushActivityTick", tostring(ClientUtils.getServerTime()))
		end

		self:setVisible(false)
	end
end

function PushActivityDlg:onNextClick()
	self:onShow(self.pageNum + 1)
end

return PushActivityDlg
