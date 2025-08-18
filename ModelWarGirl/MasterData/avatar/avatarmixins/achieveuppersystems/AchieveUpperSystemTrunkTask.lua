-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\AchieveUpperSystems\\AchieveUpperSystemTrunkTask.lua

local AchieveUpperSystemBase = require("Avatar/AvatarMixins/AchieveUpperSystems/AchieveUpperSystemBase")
local ResAchieve = require("ClientData/ResAchieve")
local AchieveUpperSystemTrunkTask = Class("AchieveUpperSystemTrunkTask", AchieveUpperSystemBase)

function AchieveUpperSystemTrunkTask:initUpperSystem(svrData)
	self.groupEndDict = {}
	self.stageAchieveList = {}

	for achieveId, achieveInfo in pairs(ResAchieve) do
		if achieveInfo.trunk_flag and achieveInfo.trunk_flag == Const.ACHEVE_UPPER_SYSTEM_TRUNKTASK then
			self.achieveDict[achieveId] = true

			table.insert(self.achieveList, achieveId)

			local groupId = achieveInfo.group_id

			if groupId then
				if not self.groupEndDict[groupId] then
					self.groupEndDict[groupId] = achieveId
				else
					local tmpId = self.groupEndDict[groupId]

					self.groupEndDict[groupId] = math.max(achieveId, tmpId)
				end
			end

			local stageId = achieveInfo.stage_id

			if stageId then
				if not self.stageAchieveList[stageId] then
					self.stageAchieveList[stageId] = {}
				end

				table.insert(self.stageAchieveList[stageId], achieveId)
			end
		end
	end

	table.sort(self.achieveList, function(a, b)
		return a < b
	end)

	self.currentFocusAchieve = self:_getFocusTrunkAchieve()
	self.currentGroupEndAchieve = self:_getGroupEndAchieve(self.currentFocusAchieve)

	self:_refreshRedDotEvent()
end

function AchieveUpperSystemTrunkTask:onAchieveQualify(achieveId)
	if achieveId == self.currentFocusAchieve then
		self:_refreshDlg()
		self:_refreshRedDotEvent()
	end
end

function AchieveUpperSystemTrunkTask:onAchieveGot(achieveId)
	if achieveId == self.currentFocusAchieve then
		for i, id in ipairs(self.achieveList) do
			if id == achieveId then
				local nextIndex = math.min(i + 1, #self.achieveList)

				self.currentFocusAchieve = self.achieveList[nextIndex]
				self.currentGroupEndAchieve = self:_getGroupEndAchieve(self.currentFocusAchieve)

				break
			end
		end

		self:_refreshDlg()
		self:_refreshRedDotEvent()
	end
end

function AchieveUpperSystemTrunkTask:isAchieveNeedCare(achieveId)
	return achieveId == self.currentFocusAchieve
end

function AchieveUpperSystemTrunkTask:achieveIsGroupEnd(targetAchieveId)
	return targetAchieveId == self:_getGroupEndAchieve(targetAchieveId)
end

function AchieveUpperSystemTrunkTask:achieveIsStageEnd(targetAchieveId)
	local achieveInfo = ResAchieve[targetAchieveId]

	if achieveInfo and achieveInfo.stage_id then
		local achieveList = self.stageAchieveList[achieveInfo.stage_id]

		if achieveList and targetAchieveId == achieveList[#achieveList] then
			return true
		end
	end

	return false
end

function AchieveUpperSystemTrunkTask:achieveIsTrunkEnd(targetAchieveId)
	return self.achieveList[#self.achieveList] == targetAchieveId
end

function AchieveUpperSystemTrunkTask:_getFocusTrunkAchieve(...)
	for i, achieveId in ipairs(self.achieveList) do
		local isQualify = CurAvatar.achieveQualify[achieveId]

		if not isQualify then
			return achieveId
		end

		local isGot = CurAvatar.achieveAwardGot[achieveId]

		if not isGot then
			return achieveId
		end
	end

	return self.achieveList[#self.achieveList]
end

function AchieveUpperSystemTrunkTask:_getGroupEndAchieve(targetAchieveId)
	local achieveInfo = ResAchieve[targetAchieveId]

	if not achieveInfo or not self.achieveDict[targetAchieveId] then
		return
	end

	local groupId = achieveInfo.group_id

	if not groupId then
		return targetAchieveId
	end

	return self.groupEndDict[groupId] or targetAchieveId
end

function AchieveUpperSystemTrunkTask:_refreshDlg(...)
	local dlg = UIManager.getUI("achieveMainDlg", nil, false)

	if dlg then
		dlg:refreshAchieves()
	end
end

function AchieveUpperSystemTrunkTask:_refreshRedDotEvent()
	if self.currentFocusAchieve then
		local isQualify = CurAvatar.achieveQualify[self.currentFocusAchieve]
		local isGot = CurAvatar.achieveAwardGot[self.currentFocusAchieve]

		RedDotManager.setKeyState(UIConst.RD_HINT_TRUNK_ACHIEVE, isQualify and not isGot)
	end
end

return AchieveUpperSystemTrunkTask
