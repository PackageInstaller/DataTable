-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\OtherPlayer.lua

local strClassName = "OtherPlayer"
local OtherPlayer = Class(strClassName)

function OtherPlayer:ctor()
	self:_initData()
end

function OtherPlayer:_initData()
	return
end

function OtherPlayer:initFriendData(friendData)
	self:_updateFriendName(friendData.simple.comm.name)

	self.time = friendData.time
	self.logout_tick = friendData.simple.logout_tick

	self:_initFromCommonData(friendData.simple.comm)
	self:updateConfidant(friendData.bond)
	self:updateBeBond(friendData.bebond)
	self:updateFriendState(friendData.online, friendData.gift_got, friendData.gift_given)
end

function OtherPlayer:updateFriendState(online, gift_got, gift_given)
	if gift_given then
		self.giftSend = gift_given ~= 0
	end

	if gift_got then
		if gift_got == 1 then
			self.giftGet = true
			self.giftReceive = false
		elseif gift_got == 2 then
			self.giftGet = true
			self.giftReceive = true
		else
			self.giftGet = false
			self.giftReceive = false
		end
	end

	if online then
		self.online = online == 1
	end
end

function OtherPlayer:updateConfidant(bond)
	self.isMyConfidant = bond == 1
end

function OtherPlayer:updateBeBond(bebond)
	self.confidantOnMe = bebond == 1
end

function OtherPlayer:_updateFriendName(name)
	self.name, self.serverName, self.serverId = utils.GetPlayerName(name)
	self.sameServer = self:_isSameServer()
end

function OtherPlayer:updateFriendData(friendData)
	for propKey, propValue in pairs(friendData) do
		if propKey == "online" then
			self:updateFriendState(propValue)
		elseif propKey == "gift_got" then
			self:updateFriendState(nil, propValue)
		elseif propKey == "gift_given" then
			self:updateFriendState(nil, nil, propValue)
		elseif propKey == "bond" then
			self:updateConfidant(propValue)
		elseif propKey == "bebond" then
			self:updateBeBond(propValue)
		elseif propKey == "simple" then
			for simpleProp, simpleValue in pairs(propValue) do
				if simpleProp == "comm" then
					for commProp, commValue in pairs(simpleValue) do
						if commProp == "name" then
							self:_updateFriendName(commValue)
						else
							self[commProp] = commValue
						end
					end
				else
					self[simpleProp] = simpleValue
				end
			end
		else
			self[propKey] = propValue
		end
	end
end

function OtherPlayer:newDayFriendData()
	self.giftSend = nil

	if self.giftGet and not self.giftReceive then
		-- block empty
	else
		self.giftGet = nil
		self.giftReceive = nil
	end
end

function OtherPlayer:initDataByMsg(msgItem)
	if msgItem == nil then
		return
	end

	local player = {}

	self.uid = nil

	if msgItem.suid == CurAvatar.uid then
		self.uid = msgItem.ruid
	else
		self.uid = msgItem.suid
	end

	if msgItem.sattr then
		local comm = msgItem.sattr

		self.name = comm.name
		self.serverName = comm.serverName
		self.serverId = comm.serverId

		self:_initFromCommonData(comm, true)

		self.chat_bubble_id = comm.chat_bubble_id or 0
		self.chat_bubble_end_time = comm.chat_bubble_end_time or 0
		self.time = msgItem.time
	end
end

function OtherPlayer:_ensureHeadFrameId(id)
	if id == 0 then
		return Const.DEFAULT_HEAD_FRAME_ID
	else
		return id
	end
end

function OtherPlayer:_initFromCommonData(comm, fromChat)
	self.uid = comm.uid
	self.level = math.max(comm.level or 1, 1)
	self.gender = comm.gender
	self.head = comm.head
	self.vip = comm.vip
	self.vip_hide = comm.vip_hide
	self.headFrameId = self:_ensureHeadFrameId(comm.head_frame_id)
	self.sameServer = self:_isSameServer()
	self.head_frame_end_time = comm.head_frame_end_time or 0
	self.help_cnt = comm.help_cnt or 0

	if fromChat then
		self.symbol_power = 0
	else
		self.symbol_power = comm.symbol_power or 0
	end
end

function OtherPlayer:initDataByCommonData(comm)
	self.name, self.serverName, self.serverId = utils.GetPlayerName(comm.name)
	self.crystalLv = comm.crystal_level or 0

	self:_initFromCommonData(comm)
end

function OtherPlayer:initDataByMasterApprenticeData(info)
	self.time = info.time
	self.online = info.online == 1
	self.logout_tick = info.simple.logout_tick
	self.guideNum = info.guide_cnt or 0
	self.rentNum = info.rent_cnt or 0

	local comm = info.simple.comm

	self:initDataByCommonData(comm)

	self.stage = comm.stage or 0

	self:_parseStage(self.stage)

	self.crystalLv = comm.crystal_level or 0
	self.masterLv, self.masterExp = CurAvatar:getMasterLevel(comm.master_exp or 0)
end

function OtherPlayer:_isSameServer(...)
	if self.serverId then
		return self.serverId == SvrListManager.getSelectedSvrID()
	else
		return self.serverName == SvrListManager.getCurServerName()
	end
end

function OtherPlayer:_parseStage(stage)
	stage = stage or 0

	local s1, s2, s3

	s1 = stage % 100
	s2 = math.floor(stage / 100) % 100
	s3 = math.floor(stage / 10000)
	self.stageInfo = {
		s3,
		s2,
		s1
	}
end

return OtherPlayer
