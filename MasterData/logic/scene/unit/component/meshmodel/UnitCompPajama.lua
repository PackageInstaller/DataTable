-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/meshmodel/UnitCompPajama.lua

module("logic.scene.unit.component.meshmodel.UnitCompPajama", package.seeall)

local M = class("UnitCompPajama", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._inPajama = false
end

function M:onInit()
	self._inPajama = false

	HouseDispatcher:addEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnituresUpdate, self)
end

function M:onReuse()
	HouseDispatcher:addEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnituresUpdate, self)
end

function M:onReset()
	HouseDispatcher:removeEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnituresUpdate, self)

	self._inPajama = false
end

function M:onDestroy()
	self:onReset()
end

function M:inPajama()
	return self._inPajama
end

function M:canPajama()
	local CO = HouseConfig.instance:getConfigByKey(ConfigName.HouseCard, self._unit.heroId)

	if CO then
		return CO.canPajama == 1
	end

	return false
end

function M:setPajama(putOn)
	if putOn then
		if not self._inPajama then
			self._inPajama = true

			local url = HouseSceneUtil.getPajamaMeshUrl(self._unit.heroId)

			self._unit.material:clear()
			self._unit.meshModel:setBody(url)
		end
	elseif self._inPajama then
		self._inPajama = false

		local url = HouseSceneUtil.getNormalMeshUrl(self._unit.heroId)

		self._unit.material:clear()
		self._unit.meshModel:setBody(url)
	end
end

function M:_onFurnituresUpdate()
	if self._inPajama and not HouseSceneUtil.playersRoomHasBath(self._unit.heroId) then
		self:setPajama(false)
	end
end

return M
