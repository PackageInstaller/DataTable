-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleExitDlg.lua

local ResClanMisc = require("ClientData/ResClanMisc")
local strClassName = "CircleExitDlg"
local CircleExitDlg = Class(strClassName, UIControls.Window)

function CircleExitDlg:ctor()
	self:initUI()
end

function CircleExitDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.inputReason = UIControls.Input(self, "Bg/ReasonInputField")
	self.txtTips = UIControls.Label(self, "Bg/TextTips1/TextTips2")

	self.txtTips:setText(string.format(Lang.get(30190), ResClanMisc[1].join_cd))

	self.txtTips1 = UIControls.Label(self, "Bg/TextTips1")

	local actOj = CurAvatar:getActivityObj(Const.CIRCLE_BATTLE_ACTIVITY_ID)

	if actOj and (actOj:inOpenState() or actOj:inFreeze()) then
		self.txtTips1:setText(ClientUtils.getClientNotice(500))
	else
		self.txtTips1:setText(Lang.get(831))
	end

	self.beSelectReasons = {}
	self.btnSelList = {}
	self.imgSelList = {}

	for i = 1, 4 do
		local btnSel = UIControls.Button(self, "Bg/SelPanel/BtnSel" .. i)

		btnSel:addEventClick(self.onBtnSelClick)

		self.btnSelList[i] = btnSel

		local imgSel = UIControls.Image(self, "Bg/SelPanel/BtnSel" .. i .. "/BgSel/ImgSel")

		self.imgSelList[i] = imgSel
	end
end

function CircleExitDlg:onBtnSelClick(sender)
	for idx, btnSel in ipairs(self.btnSelList) do
		if btnSel == sender then
			if self.beSelectReasons[idx] then
				self.beSelectReasons[idx] = nil
			else
				self.beSelectReasons[idx] = true
			end

			self.imgSelList[idx]:setVisible(self.beSelectReasons[idx] ~= nil)

			if idx == 4 then
				if self.beSelectReasons[4] then
					self.uiAni:startAni("ShowReasonInput", true)
				else
					self.uiAni:startAni("HideReasonInput", true)
				end
			end
		end
	end
end

function CircleExitDlg:onBtnConfirmClick()
	if self.beSelectReasons[4] then
		local strReason = self.inputReason:getText()
		local len = utils.utf8len(strReason, 2)

		if len > Const.MAX_CIRCLE_EXIT_REASON_MAXLEN then
			MsgManager.notice(Lang.get(30191))

			return
		end
	end

	RPC.clanExit()
end

function CircleExitDlg:onBtnDenyClick()
	self:setVisible(false)
end

return CircleExitDlg
