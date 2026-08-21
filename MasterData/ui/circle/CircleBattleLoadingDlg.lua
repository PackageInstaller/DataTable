-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleLoadingDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "CircleBattleLoadingDlg"
local CircleBattleLoadingDlg = Class(strClassName, UIControls.Window)

function CircleBattleLoadingDlg:ctor(...)
	self:initUI()
end

function CircleBattleLoadingDlg:initUI(...)
	return
end

function CircleBattleLoadingDlg:onOpen(...)
	CircleBattleLoadingDlg.super.onOpen(self)

	self.timer = Timer.New(function(...)
		if not self._waitSceneLoadFinish then
			self:setVisible(false)
		end

		self.timer = nil
	end, 2, 1)

	self.timer:Start()
end

function CircleBattleLoadingDlg:setData(callBack)
	self.callBack = callBack
end

function CircleBattleLoadingDlg:startLoad(...)
	return
end

function CircleBattleLoadingDlg:waitSceneLoadFinish(...)
	self._waitSceneLoadFinish = true
end

function CircleBattleLoadingDlg:sceneLoadFinish(...)
	self._waitSceneLoadFinish = nil

	if not self.timer then
		self:setVisible(false)
	end
end

function CircleBattleLoadingDlg:destroy(...)
	CircleBattleLoadingDlg.super.destroy(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	if self.callBack then
		self.callBack()
	end
end

return CircleBattleLoadingDlg
