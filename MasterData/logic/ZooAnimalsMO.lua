-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/ZooAnimalsMO.lua

module("logic.extensions.petzoo.model.ZooAnimalsMO", package.seeall)

local ZooAnimalsMO = class("ZooAnimalsMO")

function ZooAnimalsMO:ctor()
	self._animalList = {}
end

function ZooAnimalsMO:addAnimal(animalMo)
	self._animalList[animalMo.id] = animalMo
end

function ZooAnimalsMO:recycleAnimal(id)
	self._animalList[id] = nil
end

function ZooAnimalsMO:setAnimalList(animalList)
	self._animalList = {}

	if animalList then
		for index, value in ipairs(animalList) do
			local id = tonumber(value.id)

			self._animalList[id] = AnimalModel.New()

			self._animalList[id]:initData(value)
		end
	end
end

function ZooAnimalsMO:getAnimalById(animalId)
	if self._animalList then
		return self._animalList[animalId]
	end

	return {}
end

function ZooAnimalsMO:getAnimalList()
	local result = {}

	if self._animalList then
		for index, value in pairs(self._animalList) do
			table.insert(result, value)
		end
	end

	return result
end

function ZooAnimalsMO:setAnimalsPlaced(placed)
	if self._animalList then
		for index, value in pairs(self._animalList) do
			value.place = placed
		end
	end
end

function ZooAnimalsMO:setAnimalFollowed(id, isFollow)
	local animalInfo = self:getAnimalById(id)

	if animalInfo then
		if isFollow then
			for _, v in pairs(self._animalList) do
				if v ~= animalInfo then
					v.follow = false
				end
			end
		end

		animalInfo.follow = isFollow
	end
end

function ZooAnimalsMO:getAllPetAttr(force)
	if self._animalList and (self.baseAttr == nil or self.percentAttr == nil) or force then
		local res = {}
		local res2 = {}

		for k, mo in pairs(self._animalList) do
			local propertyGenes = mo.propertyGenes

			if propertyGenes then
				for i, id in ipairs(propertyGenes) do
					local cfg = ZooConfig.instance:getGeneBenefitById(id)

					if cfg then
						local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

						res = AttrMo.addSameAttrs(attrs, res)

						local perAttr = HandbookModel.instance:parseAttrValues(cfg.formulaPropertyType, cfg.formulaWanPercent / 10000)

						res2 = AttrMo.addSameAttrs(perAttr, res2)
					end
				end
			end
		end

		self.baseAttr = res
		self.percentAttr = res2

		BagPetsController.instance:calcAllAnimalAttr()
	end

	return self.baseAttr, self.percentAttr
end

function ZooAnimalsMO:getPetAttrByProps(propertyGenes)
	local res = {}
	local res2 = {}

	if propertyGenes then
		for i, id in ipairs(propertyGenes) do
			local cfg = ZooConfig.instance:getGeneBenefitById(id)

			if cfg then
				local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

				res = AttrMo.addSameAttrs(attrs, res)

				local perAttr = HandbookModel.instance:parseAttrValues(cfg.formulaPropertyType, cfg.formulaWanPercent / 10000)

				res2 = AttrMo.addSameAttrs(perAttr, res2)
			end
		end
	end

	return res, res2
end

return ZooAnimalsMO
