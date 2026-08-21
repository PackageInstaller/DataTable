-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\ActivityGather\\GatherBaseChild.lua

local GatherBaseChild = Class("GatherBaseChild", UIControls.Child)

function GatherBaseChild:ctor()
	self:initUI()
end

function GatherBaseChild:initUI()
	self.imgIcon = UIControls.RawImage(self, "BtnFun/Content/Img")

	if UIControls.checkControlFunc(self, "BgShelf/TxtTitle") then
		self.textTitls = UIControls.Label(self, "BgShelf/TxtTitle")
	end

	self.panelPredict = UIControls.Panel(self, "BtnFun/Content/AnnouncePanel")
	self.textPredict = UIControls.Label(self, "BtnFun/Content/AnnouncePanel/TxtRule")
	self.panelLock = UIControls.Panel(self, "BtnFun/Content/LockPanel")
	self.textTime = UIControls.Label(self, "BtnFun/Content/BgTime/TxtTime")
	self.rdNew = UIControls.RedDot(self, "BtnFun/Content/IconNewContainer")
	self.rdNewOpen = UIControls.Panel(self, "BtnFun/Content/IconNewOpen")
	self.btnSensor = UIControls.Button(self, "BtnFun")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.aniTime = UIControls.UIAni(self, "BtnFun/Content/BgTime/TxtTime")

	if UIControls.checkControlFunc(self, "TimeUpPanel") then
		self.panelWillEnd = UIControls.Panel(self, "TimeUpPanel")
	end
end

function GatherBaseChild:setData(btnConfig, state)
	self.state = state
	self.btnConfig = btnConfig
	self.actId = btnConfig.btn_args[1]

	for _, actId in ipairs(btnConfig.btn_args) do
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj:isValid() then
			self.actId = actId

			break
		end
	end

	self.actObj = CurAvatar:getActivityObj(self.actId)

	if state == Const.SHOW_STATE_LOCK then
		self.imgIcon:setObjGray(true)
		self.panelLock:setVisible(true)
		self.panelPredict:setVisible(false)

		if self.textTitls then
			self.textTitls:setVisible(false)
		end

		self.textTime:setText("")
	elseif state == Const.SHOW_STATE_PREDICT then
		self.imgIcon:setObjGray(true)
		self.panelLock:setVisible(false)
		self.panelPredict:setVisible(true)
		self.textTime:setText("")

		if btnConfig.show_condition then
			self.textPredict:setText(ConditionLimitManager.getLimitUnlockDesc(btnConfig.show_condition))
		end
	else
		self.imgIcon:setObjGray(false)
		self.panelLock:setVisible(false)
		self.panelPredict:setVisible(false)

		if self.textTitls then
			self.textTitls:setVisible(true)
		end

		if self._showOpenState then
			self:_showOpenState()
		end
	end
end

function GatherBaseChild:onSensorClick()
	if self:checkIsLock() then
		return
	end

	if self.actId and self.actObj then
		local isValid, unlockDesc = self.actObj:isValid()

		if isValid then
			CurAvatar:jumpToShowActivity(self.actId)

			if self.actObj:isNewOpened() then
				RPC.opActSetFocus(self.actObj.opId, 1)
				self.rdNewOpen:setVisible(false)
			end
		else
			MsgManager.notice(unlockDesc)
		end
	end
end

function GatherBaseChild:checkIsLock(...)
	if self.state == Const.SHOW_STATE_LOCK then
		if self.actObj then
			local isOpen = self.actObj:isValidExceptCondition()
			local isConLimit, desc = self.actObj:isInConditionLimit()

			if isOpen then
				if isConLimit then
					MsgManager.notice(desc)

					return true
				else
					return false
				end
			else
				if isConLimit then
					local tips = ClientUtils.getClientNotice(410)

					tips = tips .. desc

					MsgManager.notice(tips)
				else
					MsgManager.clientNotice(409)
				end

				return true
			end
		else
			MsgManager.clientNotice(345)

			return true
		end
	end

	return false
end

function GatherBaseChild:onTimeOut()
	if self.textTime and self.textTime:isAlive() then
		self.textTime:setText(Lang.get(30121))
		self.textTime:setFontColor(ResColor.WHITE)
		self.aniTime:stopAni("LoopBtnWorldBoss")
	end
end

function GatherBaseChild:onFreeze(...)
	self.mParent:onRefresh()
end

return GatherBaseChild
