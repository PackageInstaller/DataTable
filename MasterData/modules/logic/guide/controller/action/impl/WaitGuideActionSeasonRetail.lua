-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionSeasonRetail.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionSeasonRetail", package.seeall)

local WaitGuideActionSeasonRetail = class("WaitGuideActionSeasonRetail", BaseGuideAction)
local seasonRetailRareGuideIds

function WaitGuideActionSeasonRetail:onStart(context)
	WaitGuideActionSeasonRetail.super.onStart(self, context)

	local paramList = string.split(self.actionParam, "#")

	self._viewName = ViewName[paramList[1]]

	local funcName = paramList[2]

	self._conditionParam = paramList[3]
	self._conditionCheckFun = self[funcName]

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
	Activity104Controller.instance:registerCallback(Activity104Event.RefreshRetail, self._refreshRetail, self)
end

function WaitGuideActionSeasonRetail:_checkOpenView(viewName, viewParam)
	if self._viewName == viewName and self._conditionCheckFun(self._conditionParam) then
		seasonRetailRareGuideIds = seasonRetailRareGuideIds or {}

		if not tabletool.indexOf(seasonRetailRareGuideIds, self.guideId) then
			table.insert(seasonRetailRareGuideIds, self.guideId)
		end

		TaskDispatcher.runDelay(self._delayDone, self, 0.01)
	end
end

function WaitGuideActionSeasonRetail:_refreshRetail()
	if ViewMgr.instance:isOpen(self._viewName) and self._conditionCheckFun(self._conditionParam) then
		seasonRetailRareGuideIds = seasonRetailRareGuideIds or {}

		if not tabletool.indexOf(seasonRetailRareGuideIds, self.guideId) then
			table.insert(seasonRetailRareGuideIds, self.guideId)
		end

		TaskDispatcher.runDelay(self._delayDone, self, 0.01)
	end
end

function WaitGuideActionSeasonRetail:_delayDone()
	if seasonRetailRareGuideIds then
		local highestGuideId = GuideConfig.instance:getHighestPriorityGuideId(seasonRetailRareGuideIds)

		if highestGuideId == self.guideId then
			seasonRetailRareGuideIds = nil

			self:onDone(true)
		end
	end
end

function WaitGuideActionSeasonRetail:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
	Activity104Controller.instance:unregisterCallback(Activity104Event.RefreshRetail, self._refreshRetail, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function WaitGuideActionSeasonRetail.seasonRetailRare(param)
	local targetPositions = string.splitToNumber(param, "_")
	local retails = Activity104Model.instance:getAct104Retails()

	for _, v in pairs(retails) do
		local position = v.position
		local advancedId = v.advancedId
		local advancedRare = v.advancedRare

		if tabletool.indexOf(targetPositions, position) and advancedId ~= 0 and advancedRare ~= 0 then
			return true
		end
	end

	return false
end

return WaitGuideActionSeasonRetail
