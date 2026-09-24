-- chunkname: @modules/logic/college/model/rpcmo/CollegeBuildingMo.lua

module("modules.logic.college.model.rpcmo.CollegeBuildingMo", package.seeall)

local CollegeBuildingMo = pureTable("CollegeBuildingMo")

function CollegeBuildingMo:init(data)
	self.id = data.id
	self.level = data.level
	self.slotCharacterUid = data.slotCharacterUid
	self.characterUidIndex = GameUtil.listToDict(self.slotCharacterUid)
	self.refinedProp = GameUtil.rpcInfoToMo(data.refinedProp, CollegeBuildingRefinedPropMo, self.refinedProp)
	self.recruitmentProp = GameUtil.rpcInfoToMo(data.recruitmentProp, CollegeBuildingRecruitmentPropMo, self.recruitmentProp)
	self.attributeContainer = GameUtil.rpcInfoToMo(data.attributeContainer, CollegeAttributeContainerMo, self.attributeContainer)

	self:initCo()

	self.unlock = true
end

function CollegeBuildingMo.Create(id)
	local mo = CollegeBuildingMo.New()

	mo.id = id
	mo.level = 0
	mo.unlock = false
	mo.slotCharacterUid = {}

	mo:initCo()

	return mo
end

function CollegeBuildingMo:initCo()
	if self.lvCo and self.lvCo.level == self.level then
		return
	end

	self.lvCo = lua_college_building_level.configDict[self.id][self.level]
	self.nextLvCo = lua_college_building_level.configDict[self.id][self.level + 1]

	if self.lvCo then
		self.slotNum = self.lvCo.slots or 0
	end

	self.upgradeCost = CollegeConfig.instance:getBuildingUpgradeCost(self.id, self.level + 1)
	self.type = CollegeEnum.SceneType.City
	self.co = lua_college_building.configDict[self.id]

	if self.co.buildingType == CollegeEnum.BuildingType.TrainCharacter and self.lvCo then
		self.refineCanLockNum = 0
		self.refineCostDict = {}

		if not string.nilorempty(self.lvCo.param) then
			local arr = string.split(self.lvCo.param, "_")

			for i, v in ipairs(arr) do
				local arr2 = string.split(v, "#")
				local lockNum = tonumber(arr2[1]) or 0

				self.refineCostDict[lockNum] = GameUtil.splitString2(arr2[2], true, "&", ":")
				self.refineCanLockNum = math.max(self.refineCanLockNum, lockNum)
			end
		end
	end

	if self.co.buildingType == CollegeEnum.BuildingType.RecruitCharacter and self.lvCo then
		self.recruitCount = 0
		self.recruitCost = {}

		if not string.nilorempty(self.lvCo.param) then
			local arr = string.split(self.lvCo.param, "#")

			self.recruitCount = tonumber(arr[1]) or 0
			self.recruitCost = GameUtil.splitString2(arr[2], true, "&", ":")
		end
	end

	if not self.pos then
		if self.co and not string.nilorempty(self.co.pos) then
			local arr = string.splitToNumber(self.co.pos, "#")

			self.pos = Vector3.New(arr[1], arr[2], arr[3])
		else
			self.pos = Vector3.New(0, 0, 0)
		end
	end
end

function CollegeBuildingMo:getAllSlotCharacterMo()
	local characterMoList = {}
	local characterBox = CollegeModel.instance:getSceneMo().characterBox

	for _, characterUid in ipairs(self.slotCharacterUid) do
		local characterMo = characterBox:getCharacterMo(characterUid)

		if characterMo then
			table.insert(characterMoList, characterMo)
		end
	end

	return characterMoList
end

function CollegeBuildingMo:canProduceItem()
	if not self.unlock or self.level <= 0 or self.co.buildingType ~= CollegeEnum.BuildingType.ProduceResource then
		return false
	end

	return #self.slotCharacterUid > 0
end

function CollegeBuildingMo:getCurProduceItem()
	if not self:canProduceItem() then
		return
	end

	for k, v in pairs(CollegeEnum.ItemIdToAttrSuffix) do
		local attrId = CollegeEnum.AttrId["BuildingItem" .. v]
		local val = self.attributeContainer:getAttrVal(attrId)

		if val > 0 then
			return k, math.floor(val)
		end
	end
end

function CollegeBuildingMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeBuildingMo" then
		return false
	end

	local isSame = true

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeBuildingMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.unlock ~= otherMo.unlock then
		isSame = false

		logError(string.format("CollegeBuildingMo compareWith unlock not same: %s >> %s", self.unlock, otherMo.unlock))

		return false
	end

	if not self.unlock and not otherMo.unlock then
		return true
	end

	if self.level ~= otherMo.level then
		isSame = false

		logError(string.format("CollegeBuildingMo compareWith level not same: %s >> %s", self.level, otherMo.level))
	end

	if #self.slotCharacterUid ~= #otherMo.slotCharacterUid then
		isSame = false

		logError(string.format("CollegeBuildingMo compareWith slotCharacterUid count not same: %s >> %s", #self.slotCharacterUid, #otherMo.slotCharacterUid))
	else
		for i = 1, #self.slotCharacterUid do
			if self.slotCharacterUid[i] ~= otherMo.slotCharacterUid[i] then
				isSame = false

				logError(string.format("CollegeBuildingMo compareWith slotCharacterUid not same: [%s] %s >> %s", i, self.slotCharacterUid[i], otherMo.slotCharacterUid[i]))

				break
			end
		end
	end

	if not self.refinedProp:compareWith(otherMo.refinedProp) then
		isSame = false

		logError("CollegeBuildingMo compareWith refinedProp not same")
	end

	if not self.recruitmentProp:compareWith(otherMo.recruitmentProp) then
		isSame = false

		logError("CollegeBuildingMo compareWith recruitmentProp not same")
	end

	if not self.attributeContainer:compareWith(otherMo.attributeContainer) then
		isSame = false

		logError("CollegeBuildingMo compareWith attributeContainer not same")
	end

	return isSame
end

return CollegeBuildingMo
