-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleKillMonsterEfxDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "CircleBattleKillMonsterEfxDlg"
local CircleBattleKillMonsterEfxDlg = Class(strClassName, UIControls.Window)

function CircleBattleKillMonsterEfxDlg:ctor(...)
	self:initUI()
end

function CircleBattleKillMonsterEfxDlg:initUI(...)
	return
end

function CircleBattleKillMonsterEfxDlg:onOpen(...)
	CircleBattleKillMonsterEfxDlg.super.onOpen(self)

	self.timer = Timer.New(function(...)
		local ui = UIManager.tryGetUI("circleBattleKillMonsterEfxDlg")

		if ui then
			ui:setVisible(false)
		end
	end, 1.2, 1)

	self.timer:Start()
end

function CircleBattleKillMonsterEfxDlg:setData(eventId)
	self.eventId = eventId
end

function CircleBattleKillMonsterEfxDlg:destroy(...)
	CircleBattleKillMonsterEfxDlg.super.destroy(self)
	CircleControlCenter.checkEvent(self.eventId)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return CircleBattleKillMonsterEfxDlg
