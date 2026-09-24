-- chunkname: @modules/logic/college/model/rpcmo/CollegeWorldMapAreaMo.lua

module("modules.logic.college.model.rpcmo.CollegeWorldMapAreaMo", package.seeall)

local CollegeWorldMapAreaMo = pureTable("CollegeWorldMapAreaMo")

function CollegeWorldMapAreaMo:init(data)
	self.id = data.id
	self.slotCharacterUid = data.slotCharacterUid
	self.characterUidIndex = GameUtil.listToDict(self.slotCharacterUid)
	self.explorationProp = GameUtil.rpcInfoToMo(data.explorationProp, CollegeAreaExplorationPropMo, self.explorationProp)
	self.attributeContainer = GameUtil.rpcInfoToMo(data.attributeContainer, CollegeAttributeContainerMo, self.attributeContainer)
	self.unlock = true

	self:initCo()

	self.status = self.explorationProp.progress >= self.co.requiredProgress and CollegeEnum.AreaStatus.Explored or #self.slotCharacterUid > 0 and CollegeEnum.AreaStatus.Exploring or self.explorationProp.progress > 0 and CollegeEnum.AreaStatus.Suspend or CollegeEnum.AreaStatus.Unexplore
	self.isFinish = self.status == CollegeEnum.AreaStatus.Explored
end

function CollegeWorldMapAreaMo.Create(id)
	local mo = CollegeWorldMapAreaMo.New()

	mo.id = id
	mo.unlock = false

	mo:initCo()

	mo.status = CollegeEnum.AreaStatus.None

	return mo
end

function CollegeWorldMapAreaMo:initCo()
	if self.co then
		return
	end

	self.type = CollegeEnum.SceneType.Map
	self.co = lua_college_location.configDict[self.id]

	if self.co then
		self.slotNum = self.co.slots or 0
	end

	if self.co and not string.nilorempty(self.co.pos) then
		local arr = string.splitToNumber(self.co.pos, "#")

		self.pos = Vector3.New(arr[1], arr[2], arr[3])
	else
		self.pos = Vector3.New(0, 0, 0)
	end
end

function CollegeWorldMapAreaMo:canProduceItem()
	if not self.unlock or not self.isFinish or #self.slotCharacterUid <= 0 or self.co.locationType ~= CollegeEnum.BuildingType.ProduceResource then
		return false
	end

	return true
end

function CollegeWorldMapAreaMo:getCurProduceItem()
	if not self:canProduceItem() then
		return
	end

	for k, v in pairs(CollegeEnum.ItemIdToAttrSuffix) do
		local attrId = CollegeEnum.AttrId["AreaItem" .. v]
		local val = self.attributeContainer:getAttrVal(attrId)

		if val > 0 then
			return k, math.floor(val)
		end
	end
end

function CollegeWorldMapAreaMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeWorldMapAreaMo" then
		return false
	end

	local isSame = true

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeWorldMapAreaMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.unlock ~= otherMo.unlock then
		isSame = false

		logError(string.format("CollegeWorldMapAreaMo compareWith unlock not same: %s >> %s", self.unlock, otherMo.unlock))

		return false
	end

	if not self.unlock and not otherMo.unlock then
		return true
	end

	if #self.slotCharacterUid ~= #otherMo.slotCharacterUid then
		isSame = false

		logError(string.format("CollegeWorldMapAreaMo compareWith slotCharacterUid count not same: %s >> %s", #self.slotCharacterUid, #otherMo.slotCharacterUid))
	else
		for i = 1, #self.slotCharacterUid do
			if self.slotCharacterUid[i] ~= otherMo.slotCharacterUid[i] then
				isSame = false

				logError(string.format("CollegeWorldMapAreaMo compareWith slotCharacterUid not same: [%s] %s >> %s", i, self.slotCharacterUid[i], otherMo.slotCharacterUid[i]))

				break
			end
		end
	end

	if not self.explorationProp:compareWith(otherMo.explorationProp) then
		isSame = false

		logError("CollegeWorldMapAreaMo compareWith explorationProp not same")
	end

	if not self.attributeContainer:compareWith(otherMo.attributeContainer) then
		isSame = false

		logError("CollegeWorldMapAreaMo compareWith attributeContainer not same")
	end

	return isSame
end

return CollegeWorldMapAreaMo
