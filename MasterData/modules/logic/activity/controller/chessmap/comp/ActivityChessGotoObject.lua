-- chunkname: @modules/logic/activity/controller/chessmap/comp/ActivityChessGotoObject.lua

module("modules.logic.activity.controller.chessmap.comp.ActivityChessGotoObject", package.seeall)

local ActivityChessGotoObject = class("ActivityChessGotoObject")

function ActivityChessGotoObject:ctor(interactObj)
	self._target = interactObj
	self._srcList = nil
	self._itemTrackMark = false

	local extendData = self._target.originData.data

	if extendData then
		self._goToObjectId = extendData.goToObject
	end

	self:initAttract()
end

function ActivityChessGotoObject:init()
	local extendData = self._target.originData.data

	if extendData and extendData.goToObject then
		local targetInteractId = extendData.goToObject
		local targetInteractObj = ActivityChessGameController.instance.interacts:get(targetInteractId)

		if targetInteractObj then
			targetInteractObj.goToObject:addSource(self._target.originData.id)
		end
	end
end

function ActivityChessGotoObject:initAttract()
	self._attractEnemyMap = {}

	if self._target.config and self._target.config.interactType == ActivityChessEnum.InteractType.Item and not string.nilorempty(self._target.config.showParam) then
		local showIds = string.splitToNumber(self._target.config.showParam, "#")

		for _, id in pairs(showIds) do
			logNormal("ActivityChessGotoObject initAttract : " .. tostring(id))

			self._attractEnemyMap[id] = true
		end
	end
end

function ActivityChessGotoObject:updateGoToObject()
	local newId
	local extendData = self._target.originData.data

	if extendData then
		newId = extendData.goToObject
	end

	if self._goToObjectId == newId then
		return
	end

	self:deleteRelation()

	self._goToObjectId = newId

	local selfId = self._target.originData.id
	local targetInteract = ActivityChessGameController.instance.interacts:get(newId)

	if targetInteract ~= nil then
		targetInteract.goToObject:addSource(selfId)
	end

	self:refreshTarget()
end

function ActivityChessGotoObject:deleteRelation()
	local selfId = self._target.originData.id

	if self._goToObjectId then
		local targetInteract = ActivityChessGameController.instance.interacts:get(self._goToObjectId)

		if targetInteract ~= nil and targetInteract.goToObject ~= nil then
			targetInteract.goToObject:removeSource(selfId)
		end
	end
end

function ActivityChessGotoObject:refreshSource()
	if self._target.avatar and self._target.avatar.goTracked then
		if self._srcList then
			gohelper.setActive(self._target.avatar.goTracked, #self._srcList > 0)
		else
			gohelper.setActive(self._target.avatar.goTracked, false)
		end
	end
end

function ActivityChessGotoObject:refreshTarget()
	if self._target.avatar then
		local isPlayerTrack = false
		local isItemTrack = false

		if self._goToObjectId ~= nil and self._goToObjectId ~= 0 then
			local targetType
			local targetInteract = ActivityChessGameController.instance.interacts:get(self._goToObjectId)

			if targetInteract ~= nil then
				targetType = targetInteract.objType
			end

			if targetType == ActivityChessEnum.InteractType.Item or targetType == ActivityChessEnum.InteractType.NoEffectItem then
				isItemTrack = true
			else
				isPlayerTrack = true
			end
		end

		local extendData = self._target.originData.data

		if extendData and extendData.lostTarget == true then
			gohelper.setActive(self._target.avatar.goTrackItem, false)
			gohelper.setActive(self._target.avatar.goTrack, false)

			return
		end

		gohelper.setActive(self._target.avatar.goTrackItem, isItemTrack or self._itemTrackMark)
		gohelper.setActive(self._target.avatar.goTrack, isPlayerTrack)
	end
end

function ActivityChessGotoObject:addSource(srcId)
	self._srcList = self._srcList or {}

	table.insert(self._srcList, srcId)
	self:refreshSource()
end

function ActivityChessGotoObject:removeSource(srcId)
	if self._srcList then
		tabletool.removeValue(self._srcList, srcId)
	end

	self:refreshSource()
end

function ActivityChessGotoObject:setItemTrackMark(value)
	self._itemTrackMark = value
end

function ActivityChessGotoObject:setMarkAttract(value)
	for showId, _ in pairs(self._attractEnemyMap) do
		local targetInteract = ActivityChessGameController.instance.interacts:get(showId)

		if targetInteract ~= nil then
			targetInteract.goToObject:setItemTrackMark(value)
			targetInteract.goToObject:refreshTarget()
		end
	end
end

function ActivityChessGotoObject:onAvatarLoaded()
	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	self._target.avatar.goTracked = gohelper.findChild(loader:getInstGO(), "piecea/vx_tracked")
	self._target.avatar.goTrack = gohelper.findChild(loader:getInstGO(), "piecea/vx_track")
	self._target.avatar.goTrackItem = gohelper.findChild(loader:getInstGO(), "piecea/vx_wenao")

	self:refreshSource()
	self:refreshTarget()
end

function ActivityChessGotoObject:dispose()
	self:deleteRelation()
end

return ActivityChessGotoObject
