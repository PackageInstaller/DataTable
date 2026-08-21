-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpLiveConfirmDlg.lua

local strClassName = "TopPvpLiveConfirmDlg"
local ResBPPvpRound = require("ClientData/ResBPPvpRound")
local TopPvpLiveConfirmDlg = Class(strClassName, UIControls.Window)

function TopPvpLiveConfirmDlg:ctor(...)
	self:initUI()
end

function TopPvpLiveConfirmDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnLive = UIControls.Button(self, "BgPanel/BtnLive")

	self.btnLive:addEventClick(self.onBtnLiveClick)

	self.txtMatch = UIControls.Label(self, "BgPanel/TextMatch")
	self.btnHead = {}
	self.btnHead[1] = UIControls.PlayerHeadGridChild(self, "BgPanel/LeftPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnHead[1].txtPlayerName = UIControls.Label(self, "BgPanel/LeftPlayerPanel/TextPlayerName")
	self.btnHead[2] = UIControls.PlayerHeadGridChild(self, "BgPanel/RightPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnHead[2].txtPlayerName = UIControls.Label(self, "BgPanel/RightPlayerPanel/TextPlayerName")
end

function TopPvpLiveConfirmDlg:setPlayerComm(...)
	local uids = {}
	local member = self.roomData.knockout_member

	if member then
		for i = 1, #member do
			table.insert(uids, member[i].uid)
		end
	end

	local function fun(infos)
		for _, info in pairs(infos) do
			for index, uid in pairs(uids) do
				if uid == info.uid then
					local comm = info.commInfo

					if comm then
						self.btnHead[index]:setCommInfo(comm, true, self)

						local name = utils.GetPlayerName(comm.name)

						self.btnHead[index].txtPlayerName:setText(name)
					end
				end
			end
		end
	end

	CurAvatar:getRoleCommInfosNoTip(uids, fun)
end

function TopPvpLiveConfirmDlg:show(roominfo)
	if roominfo then
		self.roomData = roominfo

		self:setPlayerComm()

		local round = math.floor(roominfo.room_id % 100 / 10)
		local resData = ResBPPvpRound[round]

		if resData then
			local roundName = resData.round_name

			if roundName then
				local test

				if round ~= 6 then
					test = utils.format(Lang.get(90292), roundName)
				else
					test = roundName
				end

				self.txtMatch:setText(test)
			end
		end
	end
end

function TopPvpLiveConfirmDlg:onBtnLiveClick()
	if self.roomData then
		local roomId = self.roomData.room_id
		local areaID

		if roomId then
			areaID = math.floor(roomId % 10000 / 100)
		end

		if roomId and areaID then
			local actId = CurAvatar:getTopPVPActivityOpId()

			if actId then
				RPC.bPPvpKnockoutEnterRoom(actId, areaID, roomId)
			end
		end
	end
end

function TopPvpLiveConfirmDlg:onBtnCloseClick()
	self:setVisible(false)
end

return TopPvpLiveConfirmDlg
