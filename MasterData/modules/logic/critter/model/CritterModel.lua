-- chunkname: @modules/logic/critter/model/CritterModel.lua

module("modules.logic.critter.model.CritterModel", package.seeall)

local CritterModel = class("CritterModel", BaseModel)

function CritterModel:ctor()
	CritterModel.super.ctor(self)

	self._sortAttrIdKeyMap = {}
	self._trainPreveiewMODict = {}
end

function CritterModel:onInit()
	self:clear()
	self:clearData()
end

function CritterModel:reInit()
	self:clearData()
end

function CritterModel:clearData()
	return
end

function CritterModel:isCritterUnlock(isToast)
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Critter)

	if not isUnlock and GuideModel.instance:isGuideFinish(CritterEnum.OppenFuncGuide.Critter) then
		isUnlock = true
	end

	if not isUnlock and isToast then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Critter))
	end

	return isUnlock
end

function CritterModel:initCritter(critterInfos)
	local moList = {}

	if critterInfos then
		for i, critterInfo in ipairs(critterInfos) do
			local critterMO = self:getById(critterInfo.uid)

			critterMO = critterMO or CritterMO.New()

			critterMO:init(critterInfo)
			table.insert(moList, critterMO)
		end
	end

	self:setList(moList)
end

function CritterModel:addCritter(critterInfo)
	local critterMO = self:getById(critterInfo.uid)

	if not critterMO then
		critterMO = CritterMO.New()

		critterMO:init(critterInfo)
		self:addAtLast(critterMO)
	else
		critterMO:init(critterInfo)
	end

	return critterMO
end

function CritterModel:setLockCritter(uid, isLock)
	local critterMO = self:getById(uid)

	if critterMO then
		critterMO.lock = isLock == true
	end
end

function CritterModel:setSortAttIdByKey(key, attrId)
	self._sortAttrIdKeyMap[key] = attrId
end

function CritterModel:getSortAttIdByKey(key)
	return self._sortAttrIdKeyMap[key]
end

function CritterModel:onStartTrainCritterReply(msg)
	return
end

function CritterModel:onSelectEventOptionReply(msg)
	return
end

function CritterModel:onFastForwardTrainReply(msg)
	return
end

function CritterModel:removeCritters(uids)
	for i, uid in ipairs(uids) do
		self:removeCritter(uid)
	end
end

function CritterModel:removeCritter(uid)
	local critterMO = self:getById(uid)

	if critterMO then
		self:remove(critterMO)
	end
end

function CritterModel:getCritterMOByUid(uid)
	return self:getById(uid)
end

function CritterModel:getAllCritters()
	return self:getList()
end

function CritterModel:getMaturityCritters()
	local culList = {}
	local critterMOList = self:getList()

	for i, critterMO in ipairs(critterMOList) do
		if critterMO:isMaturity() then
			table.insert(culList, critterMO)
		end
	end

	return culList
end

function CritterModel:getCultivatingCritters()
	local culList = {}
	local critterMOList = self:getList()

	for i, critterMO in ipairs(critterMOList) do
		if critterMO:isCultivating() then
			table.insert(culList, critterMO)
		end
	end

	return culList
end

function CritterModel:getCritterSkinId(critterUid)
	local result
	local critterMO = self:getCritterMOByUid(critterUid)

	return (critterMO or nil) and critterMO:getSkinId()
end

function CritterModel:getCanIncubateCritters()
	local moList = {}
	local critterMOList = self:getList()

	for i, critterMO in ipairs(critterMOList) do
		if critterMO:isMaturity() then
			table.insert(moList, critterMO)
		end
	end

	return moList
end

function CritterModel:checkGotCritter(critterDefineId)
	local critterMOList = self:getList()

	for i, critterMO in ipairs(critterMOList) do
		if critterMO.defineId == critterDefineId then
			return true
		end
	end

	return false
end

function CritterModel:getMoodCritters(mood)
	local list = {}
	local critterMOList = self:getList()

	for i, critterMO in ipairs(critterMOList) do
		if mood >= critterMO:getMoodValue() then
			table.insert(list, critterMO.id)
		end
	end

	return list
end

function CritterModel:getTrainPreviewMO(critterUid, heroId)
	return RoomHelper.get2KeyValue(self._trainPreveiewMODict, critterUid, heroId)
end

function CritterModel:addTrainPreviewMO(mo)
	local critterUid = mo.id
	local heroId = mo.trainInfo.heroId

	return RoomHelper.add2KeyValue(self._trainPreveiewMODict, critterUid, heroId, mo)
end

function CritterModel:getCritterCntById(id)
	local cnt = 0
	local critterMOList = self:getList()

	for _, mo in ipairs(critterMOList) do
		if mo.defineId == id then
			cnt = cnt + 1
		end
	end

	return cnt
end

CritterModel.instance = CritterModel.New()

return CritterModel
