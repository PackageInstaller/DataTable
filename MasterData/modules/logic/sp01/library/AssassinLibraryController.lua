-- chunkname: @modules/logic/sp01/library/AssassinLibraryController.lua

module("modules.logic.sp01.library.AssassinLibraryController", package.seeall)

local AssassinLibraryController = class("AssassinLibraryController", BaseController)

function AssassinLibraryController:onInit()
	self._waitLibraryIdList = {}
	self._waitLibraryIdMap = {}
	self._toastLibraryIdMap = {}
	self._isEnableToast = true
end

function AssassinLibraryController:reInit()
	self:onInit()
end

function AssassinLibraryController:addConstEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.EnableLibraryToast, self._onEnableLibraryToast, self)
end

function AssassinLibraryController:_onOpenViewFinish(viewName)
	self:tryToast()
end

function AssassinLibraryController:_onCloseViewFinish(viewName)
	self:tryToast()
end

function AssassinLibraryController:tryToast()
	local canToast = self:checkCanToast()

	if not canToast then
		return
	end

	if self._waitLibraryIdList then
		if not #self._waitLibraryIdList then
			local waitLibraryIdNum = 0

			if waitLibraryIdNum <= 0 then
				return
			end

			local readyToastList = {}
			local odysseyToastList = {}

			for i = waitLibraryIdNum, 1, -1 do
				local libraryId = self._waitLibraryIdList[i]
				local libraryCo = AssassinConfig.instance:getLibrarConfig(libraryId)

				if libraryCo.activityId == VersionActivity2_9Enum.ActivityId.Outside then
					table.insert(readyToastList, 1, libraryId)
				elseif libraryCo.activityId == VersionActivity2_9Enum.ActivityId.Dungeon2 then
					table.insert(odysseyToastList, 1, libraryId)
				else
					logError(string.format("资料库飘字未定义行为 libraryId = %s", libraryId))
				end

				self:onLibraryToast(libraryId)
			end

			if #odysseyToastList > 0 then
				ViewMgr.instance:openView(ViewName.OdysseyLibraryToastView, odysseyToastList)

				for _, libraryId in ipairs(odysseyToastList) do
					if OdysseyConfig.instance:checkIsOptionDataBase(libraryId) then
						AssassinController.instance:openAssassinLibraryDetailView(libraryId)

						break
					end
				end
			end

			if #readyToastList > 0 then
				ViewMgr.instance:openView(ViewName.AssassinLibraryToastView, readyToastList)
			end
		end
	end
end

function AssassinLibraryController:checkCanToast()
	if not self._isEnableToast then
		return
	end

	self:_buildForbidenViewNameMap()

	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #viewNameList, 1, -1 do
		local viewName = viewNameList[i]

		if self._fobidenViewNameMap[viewName] then
			return false
		end

		return true
	end

	return true
end

function AssassinLibraryController:_buildForbidenViewNameMap()
	self._fobidenViewNameMap = self._fobidenViewNameMap or {}
end

function AssassinLibraryController:addNeedToastLibraryIds(libraryIds)
	self._toastLibraryIdMap = self._toastLibraryIdMap or {}
	self._waitLibraryIdList = self._waitLibraryIdList or {}
	self._waitLibraryIdMap = self._waitLibraryIdMap or {}

	for _, libraryId in ipairs(libraryIds) do
		if not self._waitLibraryIdMap[libraryId] and not self._toastLibraryIdMap[libraryId] then
			self._waitLibraryIdMap[libraryId] = true

			table.insert(self._waitLibraryIdList, libraryId)
		end
	end

	self:tryToast()
end

function AssassinLibraryController:onLibraryToast(libraryId)
	if not self._waitLibraryIdMap[libraryId] then
		return
	end

	self._toastLibraryIdMap[libraryId] = true
	self._waitLibraryIdMap[libraryId] = nil

	tabletool.removeValue(self._waitLibraryIdList, libraryId)
end

function AssassinLibraryController:onUnlockLibraryIds(unlockLibraryIds)
	self:addNeedToastLibraryIds(unlockLibraryIds)
	AssassinLibraryModel.instance:updateLibraryInfos(unlockLibraryIds)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnUnlockLibrarys, unlockLibraryIds)
	AssassinController.instance:dispatchEvent(AssassinEvent.UpdateLibraryReddot)
end

function AssassinLibraryController:_onEnableLibraryToast(isEnable)
	self._isEnableToast = isEnable

	if isEnable then
		self:tryToast()
	end
end

AssassinLibraryController.instance = AssassinLibraryController.New()

return AssassinLibraryController
