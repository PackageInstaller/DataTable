-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataDrawNewBieUp.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityDrawNewbieUpDetail = require("ClientData/ResOpActivityDrawNewbieUpDetail")
local ResOpActivityDrawNewbieUpMisc = require("ClientData/ResOpActivityDrawNewbieUpMisc")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResRandClient = require("ClientData/ResRandClient")
local ActivityDataDrawNewBieUp = Class("ActivityDataDrawNewBieUp", ActivityDataBase)

function ActivityDataDrawNewBieUp:ctor()
	self.careerDrawData = {}
	self.cycle = 1

	for i = 1, 5 do
		if self.careerDrawData[i] == nil then
			self.careerDrawData[i] = {}
			self.careerDrawData[i].totalDrawCount = 0
			self.careerDrawData[i].getHeroId = 0
		end
	end
end

function ActivityDataDrawNewBieUp:CurAvatarCheckNew(oldValue, newValue)
	if oldValue and newValue then
		if newValue <= oldValue then
			self.skipCheckItemNew = true

			return
		else
			self.skipCheckItemNew = false
		end
	end

	CurAvatar:checkUpActivityNew()
end

function ActivityDataDrawNewBieUp:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityDrawNewbieUpDetail[actId] or {}
	self.miscData = ResOpActivityDrawNewbieUpMisc[actId] or {}
	self.randReplaceId = self.miscData.related_rand_replace_id
	self.achieveId = self.miscData.achieve_id

	if self.achieveId then
		CurAvatar:addActivityRelated(self.achieveId, "drawCardMainDlg", self.actId)
	end

	self.poolId = self:getPoolId()

	if self.poolId then
		self.poolRandInfo = ResDrawFakeRand[self.poolId]

		if not self.itemReddotInited and self.poolRandInfo and self.poolRandInfo.item_id then
			CurAvatar:registerItemChangedCallBack(self.poolRandInfo.item_id, Slot(self.CurAvatarCheckNew, self))

			self.itemReddotInited = true
		end
	end
end

function ActivityDataDrawNewBieUp:updateRoleData(roleData)
	local drawData = roleData.draw_newbie_up

	if drawData then
		self.cycle = drawData.cycle + 1
		self.totalDrawCount = 0

		for i, v in ipairs(drawData.career_draw_data) do
			self.totalDrawCount = self.totalDrawCount + v.count
			self.careerDrawData[v.career] = {}
			self.careerDrawData[v.career].totalDrawCount = v.count
			self.careerDrawData[v.career].getHeroId = v.first_get_hero_id
		end

		local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

		if drawCardMainDlg then
			drawCardMainDlg:refreshPool()
		end
	end
end

function ActivityDataDrawNewBieUp:checkNew()
	local hasItemTicket

	hasItemTicket = (not self:checkAllCareerDrawOver() or not self:isMaxCycle() or false) and (not self.skipCheckItemNew or false) and self:_checkItemTicket()

	local hasAwardToGet = false

	for i = 1, 5 do
		if self:focusAchieveStateByCareer(i) == Const.ACT_ACHIEVE_STATE_ENOUGH then
			hasAwardToGet = true
		end
	end

	return hasItemTicket or hasAwardToGet
end

function ActivityDataDrawNewBieUp:registerRDEvent()
	if self.actObject.redDotId then
		RedDotManager.setKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_DRAWCARD)
	end
end

function ActivityDataDrawNewBieUp:unRegistRDEvent()
	if self.actObject.redDotId then
		RedDotManager.delKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_DRAWCARD)
	end
end

function ActivityDataDrawNewBieUp:_checkItemTicket()
	local itemEnough = false

	if self.poolRandInfo and self.poolRandInfo.item_id then
		local nowCount = CurAvatar:getItemNumById(self.poolRandInfo.item_id)

		if nowCount >= self.poolRandInfo.item_num then
			itemEnough = true
		end
	end

	return itemEnough
end

function ActivityDataDrawNewBieUp:isMaxCycle()
	if self.clientData and self.clientData[1] and self.clientData[1].max_cycle then
		return self.clientData[1].max_cycle == self.cycle
	end

	return self.cycle == 6
end

function ActivityDataDrawNewBieUp:getUnlockCareer()
	local unlockCareer = {}

	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj then
		local randReplaceData = self.randReplaceActObj.actData.randReplaceData

		for i, data in ipairs(randReplaceData or {}) do
			local career = 0

			for _, v in pairs(self.clientData) do
				if data.group_id == v.group_id then
					career = v.career_id
				end
			end

			if career ~= 0 then
				table.insert(unlockCareer, career)
			end
		end
	end

	return unlockCareer
end

function ActivityDataDrawNewBieUp:getSetHeroId(career)
	if career == nil then
		return 0
	end

	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj then
		local randReplaceData = self.randReplaceActObj.actData.randReplaceData
		local groupId = self.clientData[career].group_id
		local index = 0

		for i, data in pairs(randReplaceData or {}) do
			if data.group_id == groupId then
				index = data.index
			end
		end

		local heroId = self.randReplaceActObj.actData:getHeroId(groupId, index)

		return heroId or 0
	end

	return 0
end

function ActivityDataDrawNewBieUp:getAllSelectHeroIds(career)
	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj and self.randReplaceActObj:isValid() then
		local groupId = self.clientData[career].group_id
		local allHeroIds = self.randReplaceActObj.actData:getAllHeroIds(groupId)
		local heroIds = {}

		for i, v in ipairs(allHeroIds) do
			table.insert(heroIds, v.heroId)
		end

		return heroIds
	end

	return {}
end

function ActivityDataDrawNewBieUp:getRandReplaceGroupAndIndex(career, heroId)
	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj and self.randReplaceActObj:isValid() then
		local groupId = self.clientData[career].group_id
		local allHeroIds = self.randReplaceActObj.actData:getAllHeroIds(groupId)

		for i, v in ipairs(allHeroIds) do
			if v.heroId == heroId then
				return self.randReplaceActObj.opId, groupId, v.index
			end
		end
	end
end

function ActivityDataDrawNewBieUp:getPoolId()
	if self.clientData and self.clientData[1] and self.clientData[1].draw_pool_id then
		return self.clientData[1].draw_pool_id
	end
end

function ActivityDataDrawNewBieUp:getPoolIdByCareer(career)
	if self.clientData and self.clientData[career] and self.clientData[career].draw_pool_id then
		return self.clientData[career].draw_pool_id
	end
end

function ActivityDataDrawNewBieUp:getRelaAchieveObj()
	local achieveId = self.miscData.achieve_id or 0
	local achieveObj = CurAvatar:getActivityObj(achieveId)

	if achieveObj and achieveObj:isValid() then
		return achieveObj
	end

	return nil
end

function ActivityDataDrawNewBieUp:_clientDataAchievePostInit()
	local achieveInfo = {}
	local achieveObj = self:getRelaAchieveObj()

	if achieveObj then
		for career, v in ipairs(self.clientData) do
			local achieveType = v.achieve_type
			local achData = achieveObj.actData.clientData[achieveType]
			local achieveData = {}
			local replaceItems = self:getRandReplaceItems(career)

			for i, data in ipairs(achData or {}) do
				local achInfo = {}

				achInfo.award = data.award

				for i, item in pairs(replaceItems or {}) do
					if achInfo.award == item.rand_id then
						achInfo.award = item.target_rand_id

						break
					end
				end

				achInfo.count = data.param
				achInfo.desc = data.desc_name

				table.insert(achieveData, achInfo)
			end

			achieveInfo[career] = achieveData
		end
	end

	return achieveInfo
end

function ActivityDataDrawNewBieUp:getRandReplaceItems(career)
	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj and self.randReplaceActObj:isValid() then
		local groupId = self.clientData[career].group_id
		local randReplaceData = self.randReplaceActObj.actData.randReplaceData
		local index = 0

		for i, data in pairs(randReplaceData or {}) do
			if data.group_id == groupId then
				index = data.index
			end
		end

		local items = self.randReplaceActObj.actData:getReplaceItems(groupId, index)

		return items
	end

	return {}
end

function ActivityDataDrawNewBieUp:getCareerAchieveType(career)
	return self.clientData[career].achieve_type
end

function ActivityDataDrawNewBieUp:checkCurCycleHaveAchieve(curCareer)
	local career = curCareer or 1
	local achieveObj = self:getRelaAchieveObj()

	if achieveObj then
		local achType = self:getCareerAchieveType(career)
		local gotList = achieveObj.actData.serverData[achType] and achieveObj.actData.serverData[achType].got or {}
		local gotNum = #gotList
		local maxCount = 0
		local maxNum = 0
		local curCycleMaxNum = self.cycle * self.clientData[career].max_count_one_cycle
		local achieveData = achieveObj.actData.clientData[achType]

		for i, data in ipairs(achieveData) do
			maxCount = maxCount + 1

			if maxNum < data.param then
				maxNum = data.param
			end
		end

		if maxCount <= gotNum and maxNum < curCycleMaxNum then
			return false
		end

		return true
	end

	return false
end

function ActivityDataDrawNewBieUp:getFocusAchieveIdxByCareer(career)
	local achieveObj = self:getRelaAchieveObj()

	if achieveObj then
		local achType = self:getCareerAchieveType(career)
		local gotList = achieveObj.actData.serverData[achType] and achieveObj.actData.serverData[achType].got or {}
		local focusIdx = #gotList + 1
		local achieveData = achieveObj.actData.clientData[achType]
		local maxCount = 0
		local curCycleMaxNum = self.cycle * self.clientData[career].max_count_one_cycle

		for i, data in ipairs(achieveData) do
			if curCycleMaxNum >= data.param then
				maxCount = maxCount + 1
			end
		end

		if maxCount < focusIdx then
			return maxCount
		else
			return focusIdx
		end
	end

	return 1
end

function ActivityDataDrawNewBieUp:focusAchieveStateByCareer(career)
	if career == nil then
		return Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
	end

	local focusIdx = self:getFocusAchieveIdxByCareer(career)
	local achieveObj = self:getRelaAchieveObj()

	if achieveObj then
		local achtype = self:getCareerAchieveType(career)
		local state = achieveObj.actData:getAchieveState(achtype, focusIdx)

		return state
	end

	return Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
end

function ActivityDataDrawNewBieUp:getCareerRemainCount(career)
	local drawCount = self.careerDrawData[career].totalDrawCount
	local roundMaxTimes = self.clientData[career].max_count_one_cycle

	return roundMaxTimes * self.cycle - drawCount
end

function ActivityDataDrawNewBieUp:checkCanDrawAgainByPoolId(poolId, drawCount)
	for career, data in pairs(self.clientData) do
		if data.draw_pool_id == poolId then
			local remainCount = self:getCareerRemainCount(career)

			return drawCount <= remainCount
		end
	end

	return false
end

function ActivityDataDrawNewBieUp:checkAllCareerDrawOver()
	for career, data in pairs(self.clientData) do
		if not self:checkOneCareerDrawOver(career) then
			return false
		end
	end

	return true
end

function ActivityDataDrawNewBieUp:checkOneCareerDrawOver(career)
	local maxCount = self.clientData[career].max_count_one_cycle
	local drawCount = self.careerDrawData[career].totalDrawCount

	return drawCount >= maxCount * self.cycle
end

function ActivityDataDrawNewBieUp:getCareerIdByPoolId(poolId)
	for career, data in pairs(self.clientData) do
		if data.draw_pool_id == poolId then
			return data.career_id
		end
	end

	return 1
end

function ActivityDataDrawNewBieUp:checkIsOldRoleUpDraw()
	return false
end

function ActivityDataDrawNewBieUp:hasShared()
	return true
end

function ActivityDataDrawNewBieUp:getlimitId(...)
	return self.miscData.condition_id[1]
end

function ActivityDataDrawNewBieUp:getlimitIdGroup(...)
	local limitIdGroup = {}

	for i, id in pairs(self.miscData.condition_id or {}) do
		limitIdGroup[id] = true
	end

	return limitIdGroup
end

function ActivityDataDrawNewBieUp:isUnLock()
	for i, id in pairs(self.miscData.condition_id or {}) do
		local isUnlock = CurAvatar:checkActivityConditionLimit(id)

		if not isUnlock then
			return false
		end
	end

	return true
end

function ActivityDataDrawNewBieUp:getUpHero()
	return self:getSetHeroId(self.curDrawCareer)
end

function ActivityDataDrawNewBieUp:getCareerByGroupId(group)
	for _, v in pairs(self.clientData) do
		if group == v.group_id then
			return v.career_id
		end
	end

	return nil
end

function ActivityDataDrawNewBieUp:setCareerDrawHeroId(group_id, index)
	return
end

return ActivityDataDrawNewBieUp
