-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/scene/UnitMainSceneClockLight.lua

module("logic.extensions.chamber.scene.UnitMainSceneClockLight", package.seeall)

local M = class("UnitMainSceneClockLight")
local kMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._index = 0

	self:_init()
end

function M:OnDestroy()
	self._materialSetter:Clear()

	self._materialSetter = nil
end

function M:_init()
	self._materialSetter = BatchMaterialSetter.Get(self._mainGO)
end

function M:setIndex(idx)
	self._index = idx
end

function M:getMainGO()
	return self._mainGO
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:resetTrs()
	TransformUtils.SetLocalPosition(self._mainGO.transform, 0, 0, 0)
	TransformUtils.SetLocalEulerAngles(self._mainGO.transform, 0, 0, 0)
	TransformUtils.SetLocalScale(self._mainGO.transform, 1, 1, 1)
end

function M:refresh()
	local slotMO = ChamberModel.instance:getSlot(self._index)

	if slotMO:getItemUUID() then
		self:setVisible(true)

		local itemData = ItemModel.instance:getItemDataByUuid(tostring(slotMO:getItemUUID()))

		if itemData then
			local cfg = itemData:getItemInfo()

			self._materialSetter:SetColor(kMainColorID, cfg.light)
		else
			self:setVisible(false)
		end
	else
		self:setVisible(false)
	end
end

return M
