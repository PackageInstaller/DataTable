-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomLineLvUpSatisfy.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomLineLvUpSatisfy", package.seeall)

local WaitGuideActionRoomLineLvUpSatisfy = class("WaitGuideActionRoomLineLvUpSatisfy", BaseGuideAction)
local MaterialStr = "1#190007#8"

function WaitGuideActionRoomLineLvUpSatisfy:onStart(context)
	WaitGuideActionRoomLineLvUpSatisfy.super.onStart(self, context)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self._check, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._check, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._check, self)
	RoomController.instance:registerCallback(RoomEvent.GuideOpenInitBuilding1, self._delayCheck, self)
	RoomController.instance:registerCallback(RoomEvent.GuideOpenInitBuilding2, self._delayCheck, self)

	local nextStepId = GuideConfig.instance:getNextStepId(self.guideId, self.stepId)
	local nextStepCO = GuideConfig.instance:getStepCO(self.guideId, nextStepId)

	self._nextStepBtn = nextStepCO and nextStepCO.goPath
	self._material = GameUtil.splitString2(MaterialStr, true)
	self._openView = ViewName.RoomInitBuildingView
	self._blockViews = {
		[ViewName.CommonPropView] = true,
		[ViewName.GuideView] = true
	}
end

function WaitGuideActionRoomLineLvUpSatisfy:_delayCheck()
	TaskDispatcher.runRepeat(self._check, self, 0.0333, 30)
end

function WaitGuideActionRoomLineLvUpSatisfy:_check()
	if self:_checkOpenView() and self:_checkMaterials() and self:_checkBtnExist() then
		self:onDone(true)
	end
end

function WaitGuideActionRoomLineLvUpSatisfy:_checkBtnExist()
	local btn = gohelper.find(self._nextStepBtn)

	return GuideUtil.isGOShowInScreen(btn)
end

function WaitGuideActionRoomLineLvUpSatisfy:_checkOpenView()
	if ViewMgr.instance:isOpenFinish(self._openView) then
		local openViewNames = ViewMgr.instance:getOpenViewNameList()

		for i = #openViewNames, 1, -1 do
			local name = openViewNames[i]

			if name == self._openView then
				return true
			end

			if ViewMgr.instance:isFull(name) or ViewMgr.instance:isModal(name) or self._blockViews[name] then
				return false
			end
		end
	end
end

function WaitGuideActionRoomLineLvUpSatisfy:_checkMaterials()
	local enough = true

	for _, one in ipairs(self._material) do
		local type = one[1]
		local id = one[2]
		local quantity = one[3]
		local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

		if hasQuantity < quantity then
			enough = false

			break
		end
	end

	if enough then
		return true
	end
end

function WaitGuideActionRoomLineLvUpSatisfy:clearWork()
	TaskDispatcher.cancelTask(self._check, self)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self._checkMaterials, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._check, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._check, self)
	RoomController.instance:unregisterCallback(RoomEvent.GuideOpenInitBuilding1, self._delayCheck, self)
	RoomController.instance:unregisterCallback(RoomEvent.GuideOpenInitBuilding2, self._delayCheck, self)
end

return WaitGuideActionRoomLineLvUpSatisfy
