-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/model/MountModel.lua

module("logic.extensions.material.model.MountModel", package.seeall)

local MountModel = class("MountModel", BaseModel)
local json = require("cjson")

MountModel.Logic_Balloon = "balloon"
MountModel.TeamMountStatus = {
	InTeamMount_Captain = 1,
	InTeamMount_Member = 2,
	NotInTeamMount = 0
}
MountModel.TeamMountMemberIndex = {
	Member = 2,
	Chapion = 1
}
MountModel.TeamMountMemberIds = {
	MountModel.TeamMountMemberIndex.Chapion,
	MountModel.TeamMountMemberIndex.Member
}

function MountModel:ctor()
	return
end

function MountModel:onInit()
	self:onReset()
end

function MountModel:onReset()
	self._curMountId = nil
	self._lockmounts = {}
	self.hasAttrInit = false
	self.totalZdl = 0
	self.petAttrs = {}
	self.selectMountId = nil
	self._curTeamUserIds = {}
	self._curTeamLeaderId = nil
	self._curTeamMemberId = nil
	self._curTeamMountStatus = MountModel.TeamMountStatus.NotInTeamMount
	self._needSwitchToTeamMountStateInMainUI = false
end

function MountModel:setSelectMountId(idx)
	self.selectMountId = idx
end

function MountModel:getSelectMountId()
	if self.selectMountId == nil then
		self.selectMountId = 1
	end

	return self.selectMountId
end

function MountModel:getAllMounts()
	return MountConfig.instance:getAllMounts()
end

function MountModel:getLockmounts()
	return self._lockmounts
end

function MountModel:getMountAttr()
	if self.hasAttrInit == false then
		self.hasAttrInit = true
		self.totalZdl = 0
		self.petAttrs = {}

		for k, info in pairs(self._lockmounts or {}) do
			if info.isActive then
				local cfg = MountConfig.instance:getAttrByPlanLvl(info.mountId, info.level)

				if cfg then
					self.totalZdl = self.totalZdl + checknumber(cfg.zdl)

					local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.attribute) or {}

					self.petAttrs = AttrMo.addSameAttrs(attrs, self.petAttrs)

					for k, property in pairs(info.property or {}) do
						local attrType = property.type
						local attrVal = property.value

						if attrType and attrVal > 0 then
							self.petAttrs[attrType] = checknumber(self.petAttrs[attrType]) + checknumber(attrVal)
						end
					end
				end
			end
		end
	end

	return self.petAttrs, self.totalZdl
end

function MountModel:getLockmountsById(mountId)
	for k, v in pairs(self._lockmounts) do
		if v.mountId == mountId then
			return v
		end
	end

	return false
end

function MountModel:getActiveMountIds()
	local list = {}

	for k, v in pairs(self._lockmounts) do
		if v.isActive and #v.property > 0 then
			table.insert(list, v.mountId)
		end
	end

	return list
end

function MountModel:getActiveMountNum()
	local num = 0

	for k, v in pairs(self._lockmounts) do
		if v.isActive and #v.property > 0 then
			num = num + 1
		end
	end

	return num
end

function MountModel:getIsActive(mountId)
	for k, v in pairs(self._lockmounts) do
		if v.mountId == mountId then
			return not not v.isActive
		end
	end

	return false
end

function MountModel:getMountZDL()
	local petAttrs = self:getMountAttr()

	return (AttrMo.calcFightPowerByAttrs(petAttrs))
end

function MountModel:getMountZDLById(id)
	local list = {}

	for k, info in pairs(self._lockmounts) do
		if info.mountId == id then
			local cfg = MountConfig.instance:getAttrByPlanLvl(info.mountId, info.level)

			if cfg then
				self.totalZdl = self.totalZdl + checknumber(cfg.zdl)

				local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.attribute) or {}

				list = AttrMo.addSameAttrs(attrs, list)

				for k, property in pairs(info.property or {}) do
					local attrType = property.type
					local attrVal = property.value

					if attrType and attrVal > 0 then
						list[attrType] = checknumber(list[attrType]) + checknumber(attrVal)
					end
				end
			end
		end
	end

	return (AttrMo.calcFightPowerByAttrs(list))
end

function MountModel:getTempMountZdl(list)
	local zdlList = {}

	for k, id in pairs(list) do
		local info = self:getLockmountsById(id)
		local cfg = MountConfig.instance:getAttrByPlanLvl(info.mountId, info.level)

		if cfg then
			self.totalZdl = self.totalZdl + checknumber(cfg.zdl)

			local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.attribute) or {}

			zdlList = AttrMo.addSameAttrs(attrs, zdlList)

			for k, property in pairs(info.property or {}) do
				local attrType = property.type
				local attrVal = property.value

				if attrType and attrVal > 0 then
					zdlList[attrType] = checknumber(zdlList[attrType]) + checknumber(attrVal)
				end
			end
		end
	end

	return (AttrMo.calcFightPowerByAttrs(zdlList))
end

function MountModel:initMountInfo(msg)
	if msg then
		if msg.lockMounts then
			for _, v in ipairs(msg.lockMounts) do
				self:readMount(v)
			end
		end

		self._curMountId = msg.curMountId
	end

	BagPetsController.instance:calcAllMountAttr()
	self:updateMountLogicRaceIds()
	self:updateTeamMountStatusAfterChangeMount()
end

function MountModel:readMount(newMountInfo)
	self.hasAttrInit = false

	local single = {}

	single.mountId = newMountInfo.mountId
	single.level = newMountInfo.level
	single.isActive = newMountInfo.isActive

	local attMaxList = self:getAttMax(newMountInfo.mountId, newMountInfo.level)

	single.property = {}

	for i = 1, #attMaxList do
		local had = false

		for _, v2 in ipairs(newMountInfo.property) do
			if v2.propertyType == attMaxList[i].type then
				had = true

				table.insert(single.property, {
					value = tonumber(v2.propertyValue),
					type = v2.propertyType
				})
			end
		end

		if not had then
			table.insert(single.property, {
				value = 0,
				type = attMaxList[i].type
			})
		end
	end

	local had = false

	for k, v in pairs(self._lockmounts) do
		if v.mountId == newMountInfo.mountId then
			self._lockmounts[k] = single
			had = true
		end
	end

	if not had then
		table.insert(self._lockmounts, single)
	end

	MountController.instance:checkEntranceRedPoint()
end

function MountModel:mountChange(mountId)
	self._curMountId = mountId

	self:updateMountLogicRaceIds()
	self:updateTeamMountStatusAfterChangeMount()
end

function MountModel:updateMountLogicRaceIds()
	local raceMaps
	local mountCo = MountConfig.instance:getMountCo(self._curMountId)

	if mountCo and mountCo.logic_cls == MountModel.Logic_Balloon then
		raceMaps = MountConfig.instance:getMountLogicParams(self._curMountId)
	end

	local userVar = SceneMainPlayer.instance.userVar
	local oldRaceIds = userVar:getOriginVar(UserVarKey.MOUNT_DECORATORS) or {}
	local oldRaceMap = {}

	for i, v in ipairs(oldRaceIds) do
		oldRaceMap[v] = true
	end

	if not raceMaps then
		local varObj = userVar:deleteVar(UserVarKey.MOUNT_DECORATORS)

		if varObj then
			CityAgent.instance:sendSetUserVari(varObj)
		end
	else
		local isDirty = false
		local raceIds = {}

		for k, v in pairs(raceMaps) do
			local raceId = checknumber(k)

			if BagModel.instance:getPetIdByRaceId(raceId) ~= nil then
				table.insert(raceIds, raceId)

				if not oldRaceMap[raceId] then
					isDirty = true
				end
			elseif oldRaceMap[raceId] then
				isDirty = true
			end
		end

		if isDirty then
			local varObj = userVar:setString(UserVarKey.MOUNT_DECORATORS, json.encode(raceIds))

			if varObj then
				CityAgent.instance:sendSetUserVari(varObj)
			end
		end
	end
end

function MountModel:checkMountLogicRaceId(raceId)
	if not self._curMountId or self._curMountId == 0 then
		return
	end

	local raceMaps
	local mountCo = MountConfig.instance:getMountCo(self._curMountId)

	if mountCo and mountCo.logic_cls == MountModel.Logic_Balloon then
		raceMaps = MountConfig.instance:getMountLogicParams(self._curMountId)
	end

	if raceMaps and raceMaps[tostring(raceId)] then
		self:updateMountLogicRaceIds()
	end
end

function MountModel:getCurMountId()
	if self._curMountId then
		return self._curMountId
	else
		return 0
	end
end

function MountModel:getLevelupPlanById(mountId)
	return MountConfig.instance:getMountCo(mountId).levelUpPlan
end

function MountModel:getActivationItem(mountId)
	return MountConfig.instance:getMountCo(mountId).activationItem
end

function MountModel:getName(mountId)
	return MountConfig.instance:getMountCo(mountId).name
end

function MountModel:getPosition(mountId)
	return MountConfig.instance:getMountCo(mountId).position
end

function MountModel:getScale(mountId)
	return MountConfig.instance:getMountCo(mountId).Scale
end

function MountModel:getAllLevelupPlan()
	return MountConfig.instance:getlevelupPlan()
end

function MountModel:getMaxLevel(id)
	return MountConfig.instance:getMaxLevel(id)
end

function MountModel:getAttMax(mountId, level)
	local cfg = MountConfig.instance:getAttrByPlanLvl(mountId, level)
	local tb = {}

	if cfg then
		local strs = string.split(cfg.attributeMax, "#")

		for i = 1, 4 do
			local strs2 = string.split(strs[i], "+")
			local attrType = strs2[1]
			local idx = table.indexof(GameEnum.AttrTypeName, attrType)

			table.insert(tb, {
				type = idx,
				value = tonumber(strs2[2]),
				attrType = attrType
			})
		end
	end

	return tb
end

function MountModel:getActiveAtt(mountId, level)
	local cfg = MountConfig.instance:getAttrByPlanLvl(mountId, level)

	if cfg then
		return cfg.attribute
	else
		return nil
	end
end

function MountModel:getBreachConsume(mountId, level)
	local cfg = MountConfig.instance:getAttrByPlanLvl(mountId, level)

	if cfg then
		return cfg.breachConsume
	else
		return nil
	end
end

function MountModel:getCurAtt(mountId)
	for k, v in pairs(self._lockmounts) do
		if v.mountId == mountId then
			return v.property
		end
	end
end

function MountModel:getAttPlanId(mountId, level)
	local cfg = MountConfig.instance:getAttrByPlanLvl(mountId, level)

	if cfg then
		return cfg.attributePlan
	end
end

function MountModel:getlevelUpConsume(mountId, level)
	local cfg = MountConfig.instance:getAttrByPlanLvl(mountId, level)

	if cfg then
		return cfg.levelUpConsume
	end
end

function MountModel:getActivationAtt(mountId)
	local levelupPlan = self:getLevelupPlanById(mountId)
	local _levelupPlan = MountConfig.instance:getlevelupPlan()
	local ret = {}

	for k, v in pairs(_levelupPlan) do
		if v.levelUpPlan == levelupPlan and #v.attribute > 0 then
			table.insert(ret, v)
		end
	end

	return ret
end

function MountModel:checkRedPoint()
	return
end

function MountModel:updateTeamMountStatusAfterChangeMount()
	if self:isTeamMountFull() then
		return
	end

	self._needSwitchToTeamMountStateInMainUI = false

	local mountCo = MountConfig.instance:getMountCo(self._curMountId)

	self._curTeamUserIds = {}

	if mountCo and mountCo.isTeamMount then
		self._curTeamMountStatus = MountModel.TeamMountStatus.InTeamMount_Captain
		self._curTeamLeaderId = checknumber(RoleModel.instance:getUserId())
		self._curTeamMemberId = nil
		self._needSwitchToTeamMountStateInMainUI = true
	else
		self._curTeamMountStatus = MountModel.TeamMountStatus.NotInTeamMount
		self._curTeamLeaderId = nil
		self._curTeamMemberId = nil
	end
end

function MountModel:onNotifyTeamMountChangedRes(msg)
	self._curTeamUserIds = {}
	self._curTeamLeaderId = nil
	self._curTeamMemberId = nil
	self._curTeamMountStatus = MountModel.TeamMountStatus.NotInTeamMount
	self._needSwitchToTeamMountStateInMainUI = false

	if not msg.inTeam then
		if msg.inTeam then
			self._curTeamLeaderId = checknumber(msg.captainUserId)

			local userId = checknumber(RoleModel.instance:getUserId())

			self._curTeamMountStatus = userId == self._curTeamLeaderId and MountModel.TeamMountStatus.InTeamMount_Captain or MountModel.TeamMountStatus.InTeamMount_Member

			if not msg.curTeamUserIds then
				local curTeamUserIds = {}

				for k, v in ipairs(curTeamUserIds) do
					table.insert(self._curTeamUserIds, checknumber(v))

					if checknumber(v) ~= self._curTeamLeaderId then
						self._curTeamMemberId = checknumber(v)
					end
				end

				self._needSwitchToTeamMountStateInMainUI = true
			end
		else
			self:updateTeamMountStatusAfterChangeMount()
		end
	end
end

function MountModel:getIsInTeamMount()
	return self._curTeamMountStatus == MountModel.TeamMountStatus.InTeamMount_Captain or self._curTeamMountStatus == MountModel.TeamMountStatus.InTeamMount_Member
end

function MountModel:getTeamUserIdByIndex(index)
	if index == MountModel.TeamMountMemberIndex.Chapion then
		return self._curTeamLeaderId
	elseif index == MountModel.TeamMountMemberIndex.Member then
		return self._curTeamMemberId
	end
end

function MountModel:getCurTeamMountStatus()
	return self._curTeamMountStatus
end

function MountModel:isTeamMountMember()
	return self._curTeamMountStatus == MountModel.TeamMountStatus.InTeamMount_Member
end

function MountModel:isTeamMountFull()
	return #self._curTeamUserIds >= 2
end

function MountModel:getTeamMountMateName()
	local mateUserId
	local userId = checknumber(RoleModel.instance:getUserId())

	for k, v in ipairs(self._curTeamUserIds) do
		if checknumber(v) ~= userId then
			mateUserId = checknumber(v)

			break
		end
	end

	if mateUserId then
		local playerMo = FriendModel.instance:getFriendMo(mateUserId)

		if playerMo then
			return playerMo:getValue("name")
		end
	end

	return "好友"
end

function MountModel:getNeedSwitchToTeamMountStateInMainUI()
	return self._needSwitchToTeamMountStateInMainUI
end

function MountModel:resetMainUINeedSwitchTeamMountState()
	self._needSwitchToTeamMountStateInMainUI = false
end

MountModel.instance = MountModel.New()

return MountModel
