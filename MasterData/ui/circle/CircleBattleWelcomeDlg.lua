-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleWelcomeDlg.lua

local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "CircleBattleWelcomeDlg"
local CircleBattleWelcomeDlg = Class(strClassName, UIControls.Window)

function CircleBattleWelcomeDlg:ctor(...)
	self:initUI()
end

function CircleBattleWelcomeDlg:initUI(...)
	self.txtNum = UIControls.Label(self, "BgPanel/TextNum")
	self.txtDes = UIControls.Label(self, "BgPanel/TextDes")
	self.txtUpNum = UIControls.Label(self, "BgPanel/UpPanel/Up1/TextNum")
	self.txtUpRule = UIControls.Label(self, "BgPanel/UpPanel/Up1/TextRule")
	self.imgIcon = UIControls.Image(self, "BgPanel/UpPanel/Up1/Icon")
	self.panelUp = UIControls.Panel(self, "BgPanel/UpPanel")
end

function CircleBattleWelcomeDlg:onOpen(...)
	CircleBattleWelcomeDlg.super.onOpen(self)

	if CurAvatar.myCircle then
		local layer = CurAvatar.myCircle:getCurBattleLayer()

		self.txtNum:setText(layer)

		local desc = ClientUtils.getClientNotice(548)

		self.txtDes:setText(utils.format(desc, layer))

		local config = CurAvatar.myCircle:getCurBattleLayerConfig()

		if config and config.score_up then
			self.txtUpRule:setText(ClientUtils.getClientNotice(549))
			self.panelUp:setVisible(true)
			self.txtUpNum:setText(utils.format("+%1s%%", config.score_up * 0.01))

			local path = BaseObject.getItemIconPath(ResClanBattleMisc[1].score_id)

			if path then
				self.imgIcon:setImage(path[1], path[2])
			end
		else
			self.panelUp:setVisible(false)
		end
	end

	self.timer = Timer.New(self._autoClose, 1.8, 1)

	self.timer:Start()
end

function CircleBattleWelcomeDlg:setData(eventId)
	self.eventId = eventId
end

function CircleBattleWelcomeDlg._autoClose(...)
	local ui = UIManager.tryGetUI("circleBattleWelcomeDlg")

	if ui then
		ui:setVisible(false)
	end
end

function CircleBattleWelcomeDlg:destroy(...)
	if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) and not UIManager.tryGetUI("circleBattleMainDlg") then
		CurAvatar:jumpToShowActivity(ResClanBattleMisc[1].act_tmplid)
	end

	CircleBattleWelcomeDlg.super.destroy(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	CircleControlCenter.checkEvent(self.eventId)
	CircleControlCenter.showMyLogoAni()
end

return CircleBattleWelcomeDlg
