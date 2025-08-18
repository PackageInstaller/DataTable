-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySignInDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local SignInDayPanel = Class("SignInDayPanel", UIControls.Panel)
local SPECIAL_STATE_CFG = {
	nml = {
		"NmlReturnSignIn",
		"HighReturnSignIn",
		"DisReturnSignIn"
	},
	spc = {
		"NmlReturnSignIn7",
		"HighReturnSignIn7",
		"DisReturnSignIn7"
	}
}

function SignInDayPanel:ctor()
	self.btn = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btn:addEventClick(self.onBtnClick)

	self.items = {}
end

function SignInDayPanel:setData(data, state, isLastDay)
	self.data = data
	self.state = state

	self:setitems()
	self:setState(isLastDay)
end

function SignInDayPanel:setitems()
	if #self.items <= 0 then
		ClientUtils.CreateBonusGrid(self, self.items, self.mPath .. "/BtnConfirm/GridPanel", self.data.award, true, nil, true)
	end

	for i, item in ipairs(self.items) do
		if self.state == 3 then
			item:setIconGray(false)

			item.grid.mEnableTips = true
		elseif self.state == 2 then
			item:setIconGray(false)

			item.grid.mEnableTips = false
		else
			item:setIconGray(true)

			item.grid.mEnableTips = true
		end
	end
end

function SignInDayPanel:setState(isLastDay)
	local index = self.data.index
	local animCfg = isLastDay and SPECIAL_STATE_CFG.spc or SPECIAL_STATE_CFG.nml

	if self.state == 3 then
		self:playStateAnimator(animCfg[1])
	elseif self.state == 2 then
		self:playStateAnimator(animCfg[2])
	else
		self:playStateAnimator(animCfg[3])
	end
end

function SignInDayPanel:onBtnClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local strClassName = "ActivitySignInDlg"
local ActivitySignInDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySignInDlg, ActivityPanelMixin)

function ActivitySignInDlg:initUI()
	self.textTime = UIControls.Label(self, "BgPanel/BgTime/TxtTime")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.btns = {}
end

function ActivitySignInDlg:_setData()
	local clientData = self.actObj.actData.clientData

	if not self.actType then
		for type, data in pairs(clientData) do
			self.actType = type

			break
		end
	end

	self.detailData = clientData[self.actType]
	self.totalDay = #self.detailData

	self:_refreshData()
end

function ActivitySignInDlg:_refreshData()
	self:_setItems()
end

function ActivitySignInDlg:_setItems()
	local actData = self.actObj.actData

	if self.totalDay > 0 then
		for i = 1, self.totalDay do
			if not self.btns[i] then
				self.btns[i] = SignInDayPanel(self, "BgPanel/InfoPanel/DayPanel" .. i)
				self.btns[i].mEventClick = Slot(self.onCellClick, self)
			end

			local btnState = actData:getAchieveState(self.actType, i)
			local isLastDay = i == self.totalDay

			self.btns[i]:setData(self.detailData[i], btnState, isLastDay)
		end
	end
end

function ActivitySignInDlg:onCellClick(sender)
	if sender.state == 2 then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, sender.data.param, self.actType), self.actObj.opId)
	end
end

function ActivitySignInDlg:onClickClose()
	self:setVisible(false)
end

function ActivitySignInDlg:updateActivityData(actObj)
	self.actObj = actObj

	self:_refreshData()
end

return ActivitySignInDlg
