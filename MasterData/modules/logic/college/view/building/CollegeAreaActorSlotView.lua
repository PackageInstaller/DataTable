-- chunkname: @modules/logic/college/view/building/CollegeAreaActorSlotView.lua

module("modules.logic.college.view.building.CollegeAreaActorSlotView", package.seeall)

local CollegeAreaActorSlotView = class("CollegeAreaActorSlotView", ListScrollCellExtend)

function CollegeAreaActorSlotView:onInitView()
	self._goDispatchSlots = gohelper.findChild(self.viewGO, "#go_DispatchSlots")
	self._goDispatchSlotItem = gohelper.findChild(self.viewGO, "#go_DispatchSlots/#go_Item")
end

function CollegeAreaActorSlotView:onUpdateMO(data)
	self:initData(data or self._data)
	self:refreshUI()
end

function CollegeAreaActorSlotView:initData(data)
	self._mapAreaMo = data
	self._mapAreaCo = self._mapAreaMo.co
	self._areaId = self._mapAreaMo.id
	self._characterBox = CollegeModel.instance:getSceneMo().characterBox
	self._slotInfoList = self:_buildSlotInfoList()
end

function CollegeAreaActorSlotView:_buildSlotInfoList()
	local slotInfoList = {}

	if self._mapAreaCo then
		if not self._mapAreaCo.slots then
			local slotNum = 0

			for i = 1, slotNum do
				local actorUid = self._mapAreaMo.slotCharacterUid[i]

				if actorUid then
					::label_4_0::

					local actorMo = self._characterBox:getCharacterMo(actorUid)

					if actorMo then
						if not CollegeEnum.BuildingActorSlotState.Use then
							local state = CollegeEnum.BuildingActorSlotState.Empty
							local slotInfo = {
								actorMo = actorMo,
								locationMo = self._mapAreaMo,
								state = state
							}

							table.insert(slotInfoList, slotInfo)
						end
					end
				end
			end

			return slotInfoList
		end
	end
end

function CollegeAreaActorSlotView:refreshUI()
	gohelper.setActive(self.viewGO, true)
	gohelper.CreateObjList(self, self._refreshSlotItem, self._slotInfoList, self._goDispatchSlots, self._goDispatchSlotItem, CollegeBuildingActorSlotItem)
end

function CollegeAreaActorSlotView:_refreshSlotItem(slotItem, slotInfo, index)
	slotItem:onUpdateMO(slotInfo, index)
end

return CollegeAreaActorSlotView
