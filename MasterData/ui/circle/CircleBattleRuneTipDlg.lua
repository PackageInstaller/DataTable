-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleRuneTipDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local ResClanBattleRune = require("ClientData/ResClanBattleRune")
local strClassName = "CircleBattleRuneTipDlg"
local CircleBattleRuneTipDlg = Class(strClassName, UIControls.Window)

function CircleBattleRuneTipDlg:ctor()
	self:initUI()
end

function CircleBattleRuneTipDlg:initUI()
	self.txtAttr = UIControls.Label(self, "BgPanel/RuneCell/TextAttr")
	self.txtAttrValue = UIControls.Label(self, "BgPanel/RuneCell/TextAttrValue")
	self.imgIcon = UIControls.Image(self, "BgPanel/RuneCell/Icon")
	self.timer = Timer.New(self._autoClose, 1.5, 1)

	self.timer:Start()
end

function CircleBattleRuneTipDlg._autoClose(...)
	local ui = UIManager.tryGetUI("circleBattleRuneTipDlg")

	if ui then
		ui:setVisible(false)
	end
end

function CircleBattleRuneTipDlg:setData(runeId, eventId)
	self.eventId = eventId

	local info = ResClanBattleRune[runeId]

	if info then
		if info.props then
			local zhName, valueStr = ClientUtils.getRolePropZhNameByType(info.props[1].type, info.props[1].value)

			self.txtAttr:setText(zhName)
			self.txtAttrValue:setText(valueStr)

			local path = ClientUtils.getRolePropIconByType(info.props[1].type)

			if path then
				self.imgIcon:setImage(path[1], path[2])
			end
		else
			self.txtAttr:setText(info.prop_desc)

			local propValue = tonumber(string.format("%.2f", info.prop_value / 100)) .. "%"

			self.txtAttrValue:setText(propValue)

			if self.imgIcon then
				self.imgIcon:setImage(info.icon_path, info.icon_name)
			end
		end
	end
end

function CircleBattleRuneTipDlg:onBtnConfirmClick(...)
	self:setVisible(false)
end

function CircleBattleRuneTipDlg:destroy(...)
	CircleBattleRuneTipDlg.super.destroy(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	CircleControlCenter.checkEvent(self.eventId)
end

return CircleBattleRuneTipDlg
