-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleKillBossEfxDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "CircleBattleKillBossEfxDlg"
local CircleBattleKillBossEfxDlg = Class(strClassName, UIControls.Window)

function CircleBattleKillBossEfxDlg:ctor(...)
	self:initUI()
end

function CircleBattleKillBossEfxDlg:initUI(...)
	return
end

function CircleBattleKillBossEfxDlg:onOpen(...)
	CircleBattleKillBossEfxDlg.super.onOpen(self)

	self.timer = Timer.New(function(...)
		local ui = UIManager.tryGetUI("circleBattleKillBossEfxDlg")

		if ui then
			ui:setVisible(false)
		end
	end, 1.2, 1)

	self.timer:Start()
end

function CircleBattleKillBossEfxDlg:setData(eventId)
	self.eventId = eventId
end

function CircleBattleKillBossEfxDlg:destroy(...)
	CircleBattleKillBossEfxDlg.super.destroy(self)
	CircleControlCenter.checkEvent(self.eventId)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return CircleBattleKillBossEfxDlg
