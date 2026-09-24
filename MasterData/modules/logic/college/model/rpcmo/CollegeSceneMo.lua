-- chunkname: @modules/logic/college/model/rpcmo/CollegeSceneMo.lua

module("modules.logic.college.model.rpcmo.CollegeSceneMo", package.seeall)

local CollegeSceneMo = pureTable("CollegeSceneMo")

function CollegeSceneMo:init(data)
	self.buildingBox = GameUtil.rpcInfoToMo(data.buildingBox, CollegeBuildingBoxMo, self.buildingBox)
	self.eventBox = GameUtil.rpcInfoToMo(data.eventBox, CollegeEventBoxMo, self.eventBox)
	self.taskBox = GameUtil.rpcInfoToMo(data.taskBox, CollegeTaskBoxMo, self.taskBox)
	self.bag = GameUtil.rpcInfoToMo(data.bag, CollegeBagMo, self.bag)
	self.worldMap = GameUtil.rpcInfoToMo(data.worldMap, CollegeWorldMapMo, self.worldMap)
	self.milestoneBox = GameUtil.rpcInfoToMo(data.milestoneBox, CollegeMilestoneBoxMo, self.milestoneBox)
	self.characterBox = GameUtil.rpcInfoToMo(data.characterBox, CollegeCharacterBoxMo, self.characterBox)
	self.prop = GameUtil.rpcInfoToMo(data.prop, CollegeScenePropMo, self.prop)
	self.player = GameUtil.rpcInfoToMo(data.player, CollegePlayerMo, self.player)

	self:updateCharacterStatus()
end

function CollegeSceneMo:updateCharacterStatus()
	for i, v in ipairs(self.characterBox.characters) do
		v:setInLocationStatus()

		v.isRefreshEntry = false
	end

	for i, v in ipairs(self.buildingBox.buildings) do
		if v.unlock then
			for _, uid in ipairs(v.slotCharacterUid) do
				local characterMo = self.characterBox.charactersMap[uid]

				if characterMo then
					characterMo:setInLocationStatus(v)
				end
			end

			if v.refinedProp.uid ~= 0 then
				local characterMo = self.characterBox.charactersMap[v.refinedProp.uid]

				if characterMo then
					characterMo.isRefreshEntry = true
				end
			end
		end
	end

	for i, v in ipairs(self.worldMap.areas) do
		if v.unlock then
			for _, uid in ipairs(v.slotCharacterUid) do
				local characterMo = self.characterBox.charactersMap[uid]

				if characterMo then
					characterMo:setInLocationStatus(v)
				end
			end
		end
	end
end

function CollegeSceneMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeSceneMo" then
		return false
	end

	local isSame = true

	if not self.buildingBox:compareWith(otherMo.buildingBox) then
		isSame = false

		logError("CollegeSceneMo compareWith buildingBox not same")
	end

	if not self.eventBox:compareWith(otherMo.eventBox) then
		isSame = false

		logError("CollegeSceneMo compareWith eventBox not same")
	end

	if not self.taskBox:compareWith(otherMo.taskBox) then
		isSame = false

		logError("CollegeSceneMo compareWith taskBox not same")
	end

	if not self.bag:compareWith(otherMo.bag) then
		isSame = false

		logError("CollegeSceneMo compareWith bag not same")
	end

	if not self.worldMap:compareWith(otherMo.worldMap) then
		isSame = false

		logError("CollegeSceneMo compareWith worldMap not same")
	end

	if not self.milestoneBox:compareWith(otherMo.milestoneBox) then
		isSame = false

		logError("CollegeSceneMo compareWith milestoneBox not same")
	end

	if not self.characterBox:compareWith(otherMo.characterBox) then
		isSame = false

		logError("CollegeSceneMo compareWith characterBox not same")
	end

	if not self.prop:compareWith(otherMo.prop) then
		isSame = false

		logError("CollegeSceneMo compareWith prop not same")
	end

	if not self.player:compareWith(otherMo.player) then
		isSame = false

		logError("CollegeSceneMo compareWith player not same")
	end

	return isSame
end

return CollegeSceneMo
