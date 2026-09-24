-- chunkname: @modules/logic/college/view/building/CollegeBuildingActorSlotView.lua

module("modules.logic.college.view.building.CollegeBuildingActorSlotView", package.seeall)

local CollegeBuildingActorSlotView = class("CollegeBuildingActorSlotView", ListScrollCellExtend)

function CollegeBuildingActorSlotView:onInitView()
	self._goDispatchSlots = gohelper.findChild(self.viewGO, "#go_DispatchSlots")
	self._goDispatchSlotItem = gohelper.findChild(self.viewGO, "#go_DispatchSlots/#go_Item")
end

function CollegeBuildingActorSlotView:onUpdateMO(buildingMo)
	self:initData(buildingMo or self._buildingMo)
	self:refreshUI()
end

function CollegeBuildingActorSlotView:initData(buildingMo)
	self._buildingMo = buildingMo
	self._buildingId = self._buildingMo.id
	self._buildingLv = self._buildingMo.level
	self._characterBox = CollegeModel.instance:getSceneMo().characterBox
	self._slotInfoList = self:_buildSlotInfoList()
end

function CollegeBuildingActorSlotView:_buildSlotInfoList()
	local slotInfoList = {}
	local slotCoTab = CollegeConfig.instance:getBuildingSlotInfo(self._buildingId)

	if slotCoTab then
		if not slotCoTab.maxSlotNum then
			local maxSlotNum = 0

			if slotCoTab then
				if not slotCoTab.slotNumUpdateMap then
					local numUpdateMap = {}

					for i = 1, maxSlotNum do
						local actorUid = self._buildingMo.slotCharacterUid[i]

						if actorUid then
							::label_4_0::

							local actorMo = self._characterBox:getCharacterMo(actorUid)
							local state = CollegeEnum.BuildingActorSlotState.Use

							if not actorMo then
								local isLvFit = numUpdateMap[i] <= self._buildingLv

								state = isLvFit and CollegeEnum.BuildingActorSlotState.Empty or CollegeEnum.BuildingActorSlotState.Lock
							end

							table.insert(slotInfoList, {
								actorMo = actorMo,
								locationMo = self._buildingMo,
								state = state,
								unlockLv = numUpdateMap[i]
							})
						end
					end

					return slotInfoList
				end
			end
		end
	end
end

function CollegeBuildingActorSlotView:refreshUI()
	if self._slotInfoList then
		local hasSlot = #self._slotInfoList > 0

		gohelper.setActive(self.viewGO, hasSlot)

		if not hasSlot then
			return
		end

		gohelper.CreateObjList(self, self._refreshSlotItem, self._slotInfoList, self._goDispatchSlots, self._goDispatchSlotItem, CollegeBuildingActorSlotItem)
	end
end

function CollegeBuildingActorSlotView:_refreshSlotItem(slotItem, slotInfo, index)
	slotItem:onUpdateMO(slotInfo, index)
end

return CollegeBuildingActorSlotView
