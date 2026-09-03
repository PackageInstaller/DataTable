-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/model/WorldSwearChat.lua

WorldSwearChat = class("WorldSwearChat", objectlua.Object)

WorldSwearChat:has("_isSign", {
	is = "rw"
})
WorldSwearChat:has("_groupData", {
	is = "rw"
})
WorldSwearChat:has("_critLog", {
	is = "rw"
})
WorldSwearChat:has("_groupRank", {
	is = "rw"
})
WorldSwearChat:has("_bosses", {
	is = "rw"
})
WorldSwearChat:has("_ownChat", {
	is = "rw"
})
WorldSwearChat:has("_praisePhaseOneTimes", {
	is = "rw"
})
WorldSwearChat:has("_phaseTwoTimes", {
	is = "rw"
})
WorldSwearChat:has("_giftPhaseOneTimes", {
	is = "rw"
})
WorldSwearChat:has("_changeBossTimes", {
	is = "rw"
})
WorldSwearChat:has("_groupId", {
	is = "rw"
})
WorldSwearChat:has("_chatBossId", {
	is = "rw"
})
WorldSwearChat:has("_todayGiftTimes", {
	is = "rw"
})

function WorldSwearChat:initialize()
	super.initialize(self)

	self._praisePhaseOneTimes = {}
	self._phaseTwoTimes = {}
	self._giftPhaseOneTimes = {}
	self._changeBossTimes = {}
	self._todayGiftTimes = 0
end

function WorldSwearChat:synchronize(data)
	if not data then
		return
	end

	local ownChat = data.ownChat
	local data = data.data

	if ownChat then
		self._ownChat = ownChat
	end

	if data.groupData then
		self._groupData = data.groupData
	end

	if data.critLog then
		self._critLog = data.critLog

		for k, v in pairs(self._critLog) do
			for k_, v_ in pairs(v) do
				self._critLog[k][k_].chatTime = v_.time
			end
		end
	end

	if data.groupRank then
		self._groupRank = data.groupRank
	end

	if data.bosses then
		self._bosses = data.bosses
	end
end

function WorldSwearChat:synchronizeOtherInfo(data)
	if not data then
		return
	end

	if data.praisePhaseOneTimes then
		if data.praisePhaseOneTimes.updateTime then
			self._praisePhaseOneTimes.updateTime = data.praisePhaseOneTimes.updateTime
		end

		if data.praisePhaseOneTimes.nextRefreshTime then
			self._praisePhaseOneTimes.nextRefreshTime = data.praisePhaseOneTimes.nextRefreshTime
		end

		if data.praisePhaseOneTimes.value then
			self._praisePhaseOneTimes.value = data.praisePhaseOneTimes.value
		end
	end

	if data.phaseTwoTimes then
		if data.phaseTwoTimes.updateTime then
			self._phaseTwoTimes.updateTime = data.phaseTwoTimes.updateTime
		end

		if data.phaseTwoTimes.nextRefreshTime then
			self._phaseTwoTimes.nextRefreshTime = data.phaseTwoTimes.nextRefreshTime
		end

		if data.phaseTwoTimes.value then
			self._phaseTwoTimes.value = data.phaseTwoTimes.value
		end
	end

	if data.giftPhaseOneTimes then
		if data.giftPhaseOneTimes.updateTime then
			self._giftPhaseOneTimes.updateTime = data.giftPhaseOneTimes.updateTime
		end

		if data.giftPhaseOneTimes.nextRefreshTime then
			self._giftPhaseOneTimes.nextRefreshTime = data.giftPhaseOneTimes.nextRefreshTime
		end

		if data.giftPhaseOneTimes.value then
			self._giftPhaseOneTimes.value = data.giftPhaseOneTimes.value
		end
	end

	if data.changeBossTimes then
		if data.changeBossTimes.updateTime then
			self._changeBossTimes.updateTime = data.changeBossTimes.updateTime
		end

		if data.changeBossTimes.nextRefreshTime then
			self._changeBossTimes.nextRefreshTime = data.changeBossTimes.nextRefreshTime
		end

		if data.changeBossTimes.value then
			self._changeBossTimes.value = data.changeBossTimes.value
		end
	end

	if data.groupId then
		self._groupId = data.groupId
	end

	if data.chatBossId then
		self._chatBossId = data.chatBossId
	end

	if data.todayGiftTimes then
		self._todayGiftTimes = data.todayGiftTimes
	end
end
