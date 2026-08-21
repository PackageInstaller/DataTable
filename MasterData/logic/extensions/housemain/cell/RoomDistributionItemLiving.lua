-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomDistributionItemLiving.lua

module("logic.extensions.housemain.cell.RoomDistributionItemLiving", package.seeall)

local M = class("RoomDistributionItemLiving", RoomDistributionItemCell)

function M:onCellBindUI()
	return
end

function M:onCellDestroyUI()
	return
end

function M:onCellBindEvents()
	return
end

function M:onCellUnBindEvents()
	return
end

function M:onCellEnter()
	return
end

function M:onCellExit()
	return
end

function M:onCellClick()
	return
end

function M:reflashData()
	M.super.reflashData(self)

	if self:getRoomOpenState() == HouseMainEnum.RoomOpenTyp.OpenActive then
		local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(self:getRoomId())
		local liveZoneTyp = zoneMo and zoneMo:getType() or nil
		local working = checknumber(liveZoneTyp) > 0

		goutil.setActive(self._goTypRootNormal, working)
		goutil.setActive(self._goTypeUnUse, not working)
	end
end

function M:onCellSetData()
	self:updateWorkingStateHint(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateProcess(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateSign(self:getRoomId(), self:getRoomTyp(), self:getRoomOpenState())
	self:updateLivingRoomTypeSign()
end

function M:updateWorkingStateHint(roomId, roomType, roomOpenState)
	local hint

	if roomOpenState == HouseMainEnum.RoomOpenTyp.OpenUnActive then
		hint = lang("tip_no_activate")
	end

	self._txtHint.text = hint
end

function M:updateSign(roomId, roomType, roomOpenState)
	return
end

function M:updateProcess(roomId, roomType, roomOpenState)
	goutil.setActive(self._goProcessRoot, false)
end

function M:updateLivingRoomTypeSign()
	local liveZoneTyp

	if self:getRoomOpenState() == HouseMainEnum.RoomOpenTyp.OpenActive then
		local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(self:getRoomId())

		liveZoneTyp = zoneMo and zoneMo:getType() or nil
	end

	self:setFormSign(liveZoneTyp)
end

return M
