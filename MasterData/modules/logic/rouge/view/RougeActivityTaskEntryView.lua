-- chunkname: @modules/logic/rouge/view/RougeActivityTaskEntryView.lua

module("modules.logic.rouge.view.RougeActivityTaskEntryView", package.seeall)

local RougeActivityTaskEntryView = class("RougeActivityTaskEntryView", BaseViewExtended)

function RougeActivityTaskEntryView:ctor(rootPath)
	self._rootPath = rootPath

	if string.nilorempty(self._rootPath) then
		logError("肉鸽活跃任务入口挂点路径为空")
	end
end

function RougeActivityTaskEntryView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, self._rootPath)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeActivityTaskEntryView:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshActivityState, self)
end

function RougeActivityTaskEntryView:removeEvents()
	return
end

function RougeActivityTaskEntryView:_editableInitView()
	self._taskActId = RougeConfig.instance:getConstNumValue(RougeEnum.OutsideConst.ActivityTaskId)
end

function RougeActivityTaskEntryView:onOpen()
	self:tryLoadTaskEntry(self._taskActId)
end

function RougeActivityTaskEntryView:_refreshActivityState(actId)
	if not actId or self._taskActId ~= actId then
		return
	end

	self:tryLoadTaskEntry(actId)
end

function RougeActivityTaskEntryView:tryLoadTaskEntry(actId)
	if not actId then
		return
	end

	local isOpen = ActivityHelper.isOpen(actId)

	if not isOpen then
		self:_onActivityOffline()

		return
	end

	self:_onActivityOnline()
end

function RougeActivityTaskEntryView:_onActivityOffline()
	if not self._entryItem then
		if self._loader then
			self._loader:dispose()

			self._loader = nil
		end

		return
	end

	self._entryItem:onActivityOffline()
end

function RougeActivityTaskEntryView:_onActivityOnline()
	if not self._entryItem then
		self._loader = PrefabInstantiate.Create(self._goRoot)

		self._loader:startLoad(RougeEnum.ResPath.ActivityTaskEntryItem, self._onLoadEntryItemDone, self)

		return
	end

	self._entryItem:onActivityOnline(self._taskActId)
end

function RougeActivityTaskEntryView:_onLoadEntryItemDone(loader)
	local goEntryItem = loader:getInstGO()

	if gohelper.isNil(goEntryItem) then
		return
	end

	self._entryItem = MonoHelper.addNoUpdateLuaComOnceToGo(goEntryItem, RougeActivityTaskEntryItem)

	self._entryItem:onActivityOnline(self._taskActId)
end

function RougeActivityTaskEntryView:onClose()
	self._entryItem = nil
end

return RougeActivityTaskEntryView
