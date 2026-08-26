-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitMassifAdd.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitMassifAdd", package.seeall)

local ArcadeSkillHitMassifAdd = class("ArcadeSkillHitMassifAdd", ArcadeSkillHitBase)

function ArcadeSkillHitMassifAdd:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._targetClzId = tonumber(params[2])
	self._floorId = tonumber(params[3])
	self._targetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._targetClzId)
end

function ArcadeSkillHitMassifAdd:onHit()
	if self._targetBase then
		self._targetBase:findByContext(self._context)

		local unitMOList = self._targetBase:getTargetList()

		self:addHiterList(unitMOList)

		if unitMOList and #unitMOList > 0 then
			local moDadaList = {}

			for _, unitMO in ipairs(unitMOList) do
				local gridX, gridY = unitMO:getGridPos()
				local moData = {
					x = gridX,
					y = gridY,
					id = self._floorId
				}

				table.insert(moDadaList, moData)
			end

			ArcadeGameFloorController.instance:tryAddFloorByList(moDadaList)
		end
	end
end

function ArcadeSkillHitMassifAdd:onHitPrintLog()
	logNormal(string.format("%s ==> 在目标选择器格子上生成一个指定类型的地块:%s", self:getLogPrefixStr(), self._floorId))
end

return ArcadeSkillHitMassifAdd
