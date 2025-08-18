-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpReadyDlg.lua

local ResBPPvpTimer = require("ClientData/ResBPPvpTimer")
local strClassName = "TopPvpReadyDlg"
local TopPvpReadyDlg = Class(strClassName, UIControls.Window)

function TopPvpReadyDlg:ctor()
	self:initUI()
end

function TopPvpReadyDlg:initUI()
	self.panelMy = UIControls.Panel(self, "InforPanel/MyPanel")
	self.txtPlayerMyName = UIControls.Label(self, "InforPanel/MyPanel/TextPlayerName")
	self.btnHeadMy = UIControls.PlayerHeadGridChild(self, "InforPanel/MyPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtPowerMy = UIControls.Label(self, "InforPanel/MyPanel/TextPower")
	self.panelRival = UIControls.Panel(self, "InforPanel/RivalPanel")
	self.txtPlayerRivalName = UIControls.Label(self, "InforPanel/RivalPanel/TextPlayerName")
	self.txtPowerRival = UIControls.Label(self, "InforPanel/RivalPanel/TextPower")
	self.btnHeadRival = UIControls.PlayerHeadGridChild(self, "InforPanel/RivalPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtTime = UIControls.Label(self, "InforPanel/TextTime")
	self.btnClose = UIControls.Button(self, "InforPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function TopPvpReadyDlg:onOpen()
	TopPvpReadyDlg.super.onOpen(self)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local actData = CurAvatar:getTopPVPActivityData()

	self.timer = nil

	if actData then
		local nowState = actData:getTopPvpStage()

		if actData.stateMap[nowState] == "KnockoutRoomPrepare" then
			local timerId = actData:getTopPvpTimerId()
			local endTime

			for i = timerId, #ResBPPvpTimer do
				local state = ResBPPvpTimer[i].state

				if actData.stateMap[state] == "KnockoutBPPoolSync" then
					endTime = ResBPPvpTimer[i].end_time

					break
				end
			end

			if endTime then
				local remainTime = actData.openTime + endTime - ClientUtils.getServerTime()

				if remainTime >= 0 then
					ClientTimerManager.AddSecondTickUI(self.txtTime, remainTime, false)

					local function fun()
						if self:getVisible() then
							self:setVisible(false)
						end
					end

					self.timer = Timer.New(fun, remainTime, 1)

					self.timer:Start()
				end
			end
		end
	end
end

function TopPvpReadyDlg:show(comm)
	local rivalData, myData

	for k, v in pairs(comm) do
		if v.uid ~= CurAvatar.uid then
			rivalData = v
		else
			myData = v
		end
	end

	if rivalData then
		local power = rivalData.power

		if power then
			self.txtPowerRival:setText(power)
		end

		local name = utils.GetPlayerName(rivalData.name)

		self.txtPlayerRivalName:setText(name)
		self.btnHeadRival:setCommInfo(rivalData, true, self)
	end

	if myData then
		local power = myData.power

		if power then
			self.txtPowerMy:setText(power)
		end

		local name = utils.GetPlayerName(myData.name)

		self.txtPlayerMyName:setText(name)
		self.btnHeadMy:setCommInfo(myData, true, self)
	end
end

function TopPvpReadyDlg:onBtnCloseClick()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateInKnockoutRoomId(nil)
	end

	self:setVisible(false)
end

function TopPvpReadyDlg:destory()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	TopPvpReadyDlg.super.destory(self)
end

return TopPvpReadyDlg
