-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/ReceiveStatusComponent.lua

module("logic.extensions.backpack.cellcomponent.ReceiveStatusComponent", package.seeall)

local M = class("ReceiveStatusComponent", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._numNode = nil
	self._numText = nil
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()
	local mainGO = registry:findUIElement("rewards_detail_item_2141037416")

	self._hasGotSignGo = registry:findUIElement("backpack_item_1042455870")
	self._canGetGo = {
		goutil.findChild(mainGO, "UIParticle"),
		goutil.findChild(mainGO, "glow_02"),
		goutil.findChild(mainGO, "glow"),
		goutil.findChild(mainGO, "UIParticle2"),
		goutil.findChild(mainGO, "canReceive")
	}
end

function M:updateData(data)
	return
end

function M:setRewardStatus(status)
	goutil.setActive(self._canGetSignGo, false)
	goutil.setActive(self._hasGotSignGo, false)

	for i, v in pairs(self._canGetGo) do
		goutil.setActive(v, false)
	end

	if status == CommEnum.RewardEnum.HasGot then
		goutil.setActive(self._hasGotSignGo, true)
	elseif status == CommEnum.RewardEnum.CanGot then
		for i, v in pairs(self._canGetGo) do
			goutil.setActive(v, true)
		end
	end
end

function M:setIndex(index)
	self._index = index
end

function M:getIndex()
	return self._index
end

return M
