-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetTriangle.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetTriangle", package.seeall)

local ArcadeSkillTargetTriangle = class("ArcadeSkillTargetTriangle", ArcadeSkillTargetBase)

function ArcadeSkillTargetTriangle:onCtor()
	self._range = 0
end

function ArcadeSkillTargetTriangle:onConfigParams()
	if self._effectParams then
		self._range = math.max(0, tonumber(self._effectParams[1]))
	end
end

function ArcadeSkillTargetTriangle:onFindTarget()
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if not curRoom then
		return
	end

	if not self._cfgNeedTargetTypeDict then
		return
	end

	local gridList = self:_findTriangleGridList()

	for targetEntityType, _ in pairs(self._cfgNeedTargetTypeDict) do
		local repeatDict = {}
		local entityLayer = ArcadeGameEnum.EntityType2Layer[targetEntityType]

		for _, grid in ipairs(gridList) do
			local uid, entityType
			local entityData = curRoom:getEntityDataInTargetGrid(grid.x, grid.y, entityLayer)

			if entityData then
				uid = entityData.uid
				entityType = entityData.entityType
			end

			local unitMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

			if unitMO and not repeatDict[uid] then
				repeatDict[uid] = true

				self:addTarget(unitMO)
			end
		end
	end
end

function ArcadeSkillTargetTriangle:_findTriangleGridList()
	local gridList = {}
	local baseX, baseY = ArcadeGameHelper.getUnitMidXYInDir(self.gridX, self.gridY, self.sizeX, self.sizeY, self.direction)
	local range = tonumber(self._range) or 0

	if not baseX or not baseY or range <= 0 then
		return gridList
	end

	if not ArcadeEnum.DirChangeGridX[self.direction] then
		local fdx = 0

		if not ArcadeEnum.DirChangeGridY[self.direction] then
			local fdy = 0
			local ldx = fdy
			local ldy = fdx
			local repeatDict = {}

			for d = 1, range do
				local dGridX = fdx * d
				local dGridY = fdy * d
				local width = 2 * d - 1

				for i = 1, width do
					local k = i - d
					local px = baseX + dGridX + ldx * k
					local py = baseY + dGridY + ldy * k
					local gridId = ArcadeGameHelper.getGridId(px, py)

					if not repeatDict[gridId] then
						repeatDict[gridId] = true

						table.insert(gridList, {
							x = px,
							y = py
						})
					end
				end
			end

			return gridList
		end
	end
end

return ArcadeSkillTargetTriangle
