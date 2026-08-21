-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpLiveLoadingDlg.lua

local strClassName = "TopPvpLiveLoadingDlg"
local TopPvpLiveLoadingDlg = Class(strClassName, UIControls.Window)

function TopPvpLiveLoadingDlg:ctor(...)
	self:initUI()
end

function TopPvpLiveLoadingDlg:initUI(...)
	self.aniInfo = UIControls.UIAni(self, "")
	self.btnHead = {}
	self.btnHead[1] = UIControls.PlayerHeadGridChild(self, "GridLeftPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnHead[1].txtPlayerName = UIControls.Label(self, "GridLeftPlayer/TextPlayerName")
	self.btnHead[2] = UIControls.PlayerHeadGridChild(self, "GridRightPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnHead[2].txtPlayerName = UIControls.Label(self, "GridRightPlayer/TextPlayerName")
	self.bg = UIControls.RawImage(self, "Bg")
	self.imgBottom = UIControls.Image(self, "ImgBottom")
end

function TopPvpLiveLoadingDlg:setPlayerComm(...)
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

function TopPvpLiveLoadingDlg:show(roomInfo)
	if roomInfo then
		self.roomData = roomInfo

		self:setPlayerComm()
	end

	self.aniInfo:startAni("ShowTopPVPLiveLoading", true)
	self.aniInfo:addEventFinish(Slot(self.onQuiet, self))
end

function TopPvpLiveLoadingDlg:onQuiet(...)
	self.aniInfo:clearEventFinish()

	if self.roomData and self.roomData.room_id and self.roomData.room_id ~= 0 then
		local actId = CurAvatar:getTopPVPActivityOpId()

		if actId then
			local areaId = math.floor(self.roomData.room_id % 1000 / 100)

			if areaId and areaId ~= 0 then
				RPC.bPPvpKnockoutEnterRoom(actId, areaId, self.roomData.room_id)
			end
		end
	else
		self:setVisible(false)
	end
end

return TopPvpLiveLoadingDlg
