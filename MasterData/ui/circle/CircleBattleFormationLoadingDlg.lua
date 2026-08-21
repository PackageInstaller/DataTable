-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleFormationLoadingDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "CircleBattleFormationLoadingDlg"
local CircleBattleFormationLoadingDlg = Class(strClassName, UIControls.Window)

function CircleBattleFormationLoadingDlg:ctor(...)
	self:initUI()
end

function CircleBattleFormationLoadingDlg:initUI(...)
	return
end

function CircleBattleFormationLoadingDlg:onOpen(...)
	CircleBattleFormationLoadingDlg.super.onOpen(self)

	self.timer = Timer.New(function(...)
		self:setVisible(false)
	end, 1, 1)

	self.timer:Start()
end

function CircleBattleFormationLoadingDlg:setData(callBack)
	self.callBack = callBack
end

function CircleBattleFormationLoadingDlg:destroy(...)
	CircleBattleFormationLoadingDlg.super.destroy(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	if self.callBack then
		self.callBack()
	end
end

return CircleBattleFormationLoadingDlg
