-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPChooseDlg.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local strClassName = "PVPChooseDlg"
local PVPChooseDlg = Class(strClassName, UIControls.Window)
local BUTTON_CONFIG = {
	BtnAsynPVP = {
		leftTimeFunc = "getAsyncPvpLeftTime",
		disFunc = "onBtnAsynPvpDisClick",
		normalFunc = "onBtnAsynPvpClick",
		redHint = {
			UIConst.RD_HINT_PVP
		},
		condition = Const.CONDITION_LIMIT_PVP
	},
	BtnSeniorPVP = {
		leftTimeFunc = "getSeniorPvpLeftTime",
		disFunc = "onBtnSeniorPvpDisClick",
		normalFunc = "onBtnSeniorPvpClick",
		redHint = {
			UIConst.RD_HINT_SENIORPVP
		},
		condition = Const.CONDITION_LIMIT_MULTIPVP
	}
}

function PVPChooseDlg:ctor(...)
	self:initUI()
end

function PVPChooseDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTip = UIControls.Button(self, "BtnTips")

	self.btnTip:addEventClick(self.onBtnTipClick)

	self.buttonInfo = {}

	local path

	for name, info in pairs(BUTTON_CONFIG) do
		local data = {}

		path = "MainInfoPanel/" .. name
		data.btnNormal = UIControls.Button(self, path)

		data.btnNormal:addEventClick(self[info.normalFunc])

		data.txtTime = UIControls.Label(self, path .. "/Content/TextTime")
		data.condition = info.condition

		local pathDis = path .. "Dis"

		data.btnDis = UIControls.Button(self, pathDis)

		data.btnDis:addEventClick(self[info.disFunc])

		data.imgLock = UIControls.Image(self, pathDis .. "/Content/ImgLock")
		data.txtLimit = UIControls.Label(self, pathDis .. "/Content/TextLock")
		data.txtTimeDis = UIControls.Label(self, pathDis .. "/Content/TextTime")

		local imgContent = UIControls.Image(self, pathDis .. "/Content")

		imgContent:setObjGray(true)

		if info.redHint then
			data.redHint = UIControls.RedDot(self, path .. "/Content/IconNew")

			data.redHint:addHint(info.redHint)
		end

		self.buttonInfo[name] = data
	end
end

function PVPChooseDlg:show(...)
	self.inited = true

	self:refreshUI()
end

function PVPChooseDlg:onOpen(...)
	PVPChooseDlg.super.onOpen(self)
	self:checkPvpState()
	self:playAni("ShowPVPMainCanvas", nil, true)
end

local jumpUIs = {
	"pvpMainDlg",
	"seniorPvpMainDlg"
}

function PVPChooseDlg:jumpToPvp(index)
	if self.inited == nil then
		self:show()
	end

	local name = jumpUIs[index]

	if name then
		local ui = UIManager.tryGetUI(name)

		if ui == nil then
			UIManager.getUI(name, true):show()
		end
	end
end

function PVPChooseDlg:refreshTimeDown(...)
	for name, info in pairs(self.buttonInfo) do
		local leftTime = PVPCommon[BUTTON_CONFIG[name].leftTimeFunc]()

		if info.txtTime:getVisible() then
			ClientTimerManager.RemoveSecondTickUI(info.txtTime)
			ClientTimerManager.AddSecondFormatTickUI(info.txtTime, leftTime, nil, Lang.get(48687), nil, nil)
		end

		if info.txtTimeDis:getVisible() then
			ClientTimerManager.RemoveSecondTickUI(info.txtTimeDis)
			ClientTimerManager.AddSecondFormatTickUI(info.txtTimeDis, leftTime, nil, Lang.get(48687), nil, nil)
		end
	end

	self:refreshOpactPvpTime()
end

function PVPChooseDlg:refreshOpactPvpTime(...)
	return
end

function PVPChooseDlg:refreshUI(...)
	for name, info in pairs(self.buttonInfo) do
		if ConditionLimitManager.inLimitState(info.condition) then
			local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(info.condition)

			info.imgLock:setVisible(true)
			info.txtLimit:setVisible(true)
			info.txtLimit:setText(unlockDesc)
			info.txtTimeDis:setVisible(false)
			info.btnNormal:setVisible(false)
			info.btnDis:setVisible(true)

			info.btnDis.tipText = unlockDesc
		elseif false then
			info.imgLock:setVisible(false)
			info.txtLimit:setVisible(false)
			info.btnDis:setVisible(true)
			info.btnNormal:setVisible(false)

			info.btnDis.tipText = Lang.get(30644)
		else
			info.btnDis:setVisible(false)
			info.btnNormal:setVisible(true)
		end
	end

	self:refreshTimeDown()
end

function PVPChooseDlg:tryOpenActivityPvp(...)
	return
end

function PVPChooseDlg:checkPvpState(...)
	return
end

function PVPChooseDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function PVPChooseDlg:onBtnTipClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PVP_CHOOSE)
end

function PVPChooseDlg:onBtnAsynPvpClick(...)
	UIManager.getUI("pvpMainDlg", true):show()
end

function PVPChooseDlg:onBtnAsynPvpDisClick(sender)
	MsgManager.notice(sender.tipText or "")
end

function PVPChooseDlg:onBtnSeniorPvpClick(...)
	UIManager.getUI("seniorPvpMainDlg", true)
end

function PVPChooseDlg:onBtnSeniorPvpDisClick(sender)
	MsgManager.notice(sender.tipText or "")
end

function PVPChooseDlg:onBtnActivityPvpClick(...)
	return
end

return PVPChooseDlg
