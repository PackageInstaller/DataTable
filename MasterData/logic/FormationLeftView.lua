-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationLeftView.lua

module("logic.extensions.formation.view.FormationLeftView", package.seeall)

local FormationLeftView = class("FormationLeftView", FormationLeftViewBase)

function FormationLeftView:buildUI()
	FormationLeftView.super.buildUI(self)
	printInfo("test 战前布阵己方阵型")
end

function FormationLeftView:_onEnterBindingEvent()
	FormationLeftView.super._onEnterBindingEvent(self)
	GlobalDispatcher:addListener(GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationEnterSeat, self._onFormationEnterSeat, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationExitSeat, self._onFormationExitSeat, self)
end

function FormationLeftView:_onExitUnbindingEvent()
	FormationLeftView.super._onExitUnbindingEvent(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEnterSeat, self._onFormationEnterSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationExitSeat, self._onFormationExitSeat, self)
end

function FormationLeftView:onEnter()
	FormationLeftView.super.onEnter(self)
	self:_initRecPos()
	self:_initAtkSelfItems()
end

function FormationLeftView:_onBagBeginDrag(bagPetMo)
	FormationLeftView.super._onBagBeginDrag(self, bagPetMo)

	local raceId = bagPetMo:getDefineId()

	self:_setRecPos(true, raceId)
end

function FormationLeftView:_onBagEndDrag()
	FormationLeftView.super._onBagEndDrag(self)
	self:_setRecPos(false)
	self:_closeAllAtkSelfItem()
end

function FormationLeftView:_onFormationBeginDragSeat(bagPetMo, startPosIndex)
	local raceId = bagPetMo:getDefineId()

	self:_setRecPos(true, raceId)
	self:_setAtkSelfItemState(bagPetMo:getId(), startPosIndex)
end

function FormationLeftView:_onFormationEndDragSeat()
	self:_setRecPos(false)
	self:_closeAllAtkSelfItem()
end

function FormationLeftView:_initRecPos()
	local prefabGo = self:getPrefab(MissionViewPresentor.RecPosItem)

	if prefabGo then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

			itemSeat:initRecPosItem(prefabGo)
		end
	end
end

function FormationLeftView:_setRecPos(isOpen, raceId)
	if isOpen then
		local isOff = GameUtil.getUserData(ViewName.MissionSettingView .. GameEnum.MissionSetting.RecPos)

		if isOff then
			return
		end
	end

	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		if self:_isFixedPos(itemSeat:GetPosition()) then
			itemSeat:setRecPosIsOpen(false)
		else
			itemSeat:setRecPosIsOpen(isOpen)

			if raceId then
				itemSeat:setRecPosState(raceId)
			end
		end
	end
end

function FormationLeftView:_onFormationEnterSeat(petId, enterPosIndex)
	self:_setAtkSelfItemState(petId, enterPosIndex)
end

function FormationLeftView:_onFormationExitSeat(petId, enterPosIndex)
	self:_closeAllAtkSelfItem()
end

function FormationLeftView:_initAtkSelfItems()
	local prefabGo = self:getPrefab(MissionViewPresentor.AtkSelfItem)

	if prefabGo then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

			itemSeat:initAtkSelfItem(prefabGo)
		end
	end
end

function FormationLeftView:_setAtkSelfItemIsOpen(index, isOpen)
	if self._seats[index] then
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[index])

		itemSeat:setAtkSelfItemIsOpen(isOpen)
	end
end

function FormationLeftView:_closeAllAtkSelfItem()
	if not self._seats then
		return
	end

	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		itemSeat:setAtkSelfItemIsOpen(false)
	end
end

function FormationLeftView:_setAtkSelfItemState(petId, enterPosIndex)
	local isOff = GameUtil.getUserData(ViewName.MissionSettingView .. GameEnum.MissionSetting.AtkTarget)

	if isOff then
		return
	end

	if not self._seats then
		return
	end

	local itemSeats = {}
	local tempPetIds = {}

	for i = 1, 9 do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.Get(self._seats[i])

		itemSeats[i] = itemSeat
		tempPetIds[i] = itemSeat:getTempPetId()
	end

	local param = AtkTargetStrategy.instance:createSelfParam()

	param.dragPetId = petId
	param.enterPosIndex = enterPosIndex
	param.tempPetIds = tempPetIds

	local result = AtkTargetStrategy.instance:getResult(param)

	for i = 1, 9 do
		self:_setAtkSelfItemIsOpen(i, result[i])
	end
end

function FormationLeftView:_clearDragging()
	FormationLeftView.super._clearDragging(self)
	self:_setRecPos(false)
	self:_closeAllAtkSelfItem()
end

return FormationLeftView
