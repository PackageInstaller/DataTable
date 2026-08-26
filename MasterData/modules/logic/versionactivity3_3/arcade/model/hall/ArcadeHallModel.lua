-- chunkname: @modules/logic/versionactivity3_3/arcade/model/hall/ArcadeHallModel.lua

module("modules.logic.versionactivity3_3.arcade.model.hall.ArcadeHallModel", package.seeall)

local ArcadeHallModel = class("ArcadeHallModel", BaseModel)

function ArcadeHallModel:onInit()
	return
end

function ArcadeHallModel:reInit()
	return
end

function ArcadeHallModel:onOpenHallView()
	if not self._interactiveMos then
		self:initInteractiveMOs()
	end

	self:refreshInteractiveReddot()
end

function ArcadeHallModel:initInteractiveMOs()
	self._interactiveMos = {}

	for id, param in pairs(ArcadeHallEnum.HallInteractiveParams) do
		if param then
			if not param.MO then
				local mo = ArcadeHallInteractiveMO

				self._interactiveMos[id] = mo.New(id)
			end
		end
	end
end

function ArcadeHallModel:refreshInteractiveReddot()
	self:refreshHandBookReddot()
	self:refreshDevelopReddot()
	self:refreshTaskReddot()
end

function ArcadeHallModel:refreshHandBookReddot()
	local mo = self._interactiveMos[ArcadeHallEnum.HallInteractiveId.HandBook]

	if not mo then
		return
	end

	local hasReddot = ArcadeHandBookModel.instance:hasReddot()

	if hasReddot then
		if not ArcadeEnum.ReddotType.New then
			local type = ArcadeEnum.ReddotType.None

			mo:setReddotType(type)
		end
	end
end

function ArcadeHallModel:refreshDevelopReddot()
	local mo = self._interactiveMos[ArcadeHallEnum.HallInteractiveId.Develop]

	if not mo then
		return
	end

	local type = ArcadeHeroModel.instance:getReddotType()

	mo:setReddotType(type)
end

function ArcadeHallModel:refreshTaskReddot()
	local mo = self._interactiveMos[ArcadeHallEnum.HallInteractiveId.Task]

	if not mo then
		return
	end

	local hasReddot = ArcadeOutSizeModel.instance:hasRewardReddot()

	if hasReddot then
		if not ArcadeEnum.ReddotType.Normal then
			local type = ArcadeEnum.ReddotType.None

			mo:setReddotType(type)
		end
	end
end

function ArcadeHallModel:getInteractiveMOs()
	if not self._interactiveMos then
		self:initInteractiveMOs()
	end

	return self._interactiveMos
end

function ArcadeHallModel:getInteractiveMO(interactiveId)
	if not self._interactiveMos then
		self:initInteractiveMOs()
	end

	return self._interactiveMos and self._interactiveMos[interactiveId]
end

function ArcadeHallModel:getEquipedCharacterMO()
	return self:getCharacterMOById(ArcadeHeroModel.instance:getEquipHeroId())
end

function ArcadeHallModel:getCharacterMOById(id)
	self._characterMO = self._characterMO or {}
	id = id or ArcadeHeroModel.instance:getEquipHeroId()
	self._characterMO[id] = self._characterMO[id] or ArcadeHallHeroMO.New(id)

	return self._characterMO[id]
end

function ArcadeHallModel:setHeroGrid(x, y)
	self._heroGridX, self._heroGridY = x, y
end

function ArcadeHallModel:getHeroGrid()
	return self._heroGridX, self._heroGridY
end

function ArcadeHallModel:getHallGridSize()
	self._hallGridSize = self._hallGridSize or ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.HallGridSize, true, "#")

	return self._hallGridSize
end

function ArcadeHallModel:saveHeroGrid()
	local characterMo = self:getEquipedCharacterMO()

	if characterMo then
		local curGridX, curGridY = characterMo:getGridPos()

		ArcadeOutSideRpc.instance:sendArcadeGamePlayerMOveRequest(curGridX, curGridY)
	end
end

ArcadeHallModel.instance = ArcadeHallModel.New()

return ArcadeHallModel
