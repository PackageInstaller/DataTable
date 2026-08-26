-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonBaseComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseComp", package.seeall)

local Act183DungeonBaseComp = class("Act183DungeonBaseComp", LuaCompBase)

function Act183DungeonBaseComp:init(go)
	self:__onInit()

	self.go = go
	self.tran = go.transform
end

function Act183DungeonBaseComp:checkIsVisible()
	return true
end

function Act183DungeonBaseComp:onUpdateMO(episodeMo)
	self:updateInfo(episodeMo)
	self:refresh()
end

function Act183DungeonBaseComp:updateInfo(episodeMo)
	self._episodeMo = episodeMo
	self._status = self._episodeMo:getStatus()
	self._episodeCo = self._episodeMo:getConfig()
	self._episodeId = self._episodeMo:getEpisodeId()
	self._episodeType = self._episodeMo:getEpisodeType()
	self._passOrder = self._episodeMo:getPassOrder()
	self._groupId = self._episodeCo.groupId
	self._activityId = self._episodeCo.activityId
	self._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(self._groupId)
	self._groupType = self._groupEpisodeMo:getGroupType()
end

function Act183DungeonBaseComp:refresh()
	self._isVisible = self:checkIsVisible()

	gohelper.setActive(self.go, self._isVisible)

	if not self._isVisible then
		return
	end

	self:show()
end

function Act183DungeonBaseComp:show()
	return
end

function Act183DungeonBaseComp:createObjList(dataList, goTable, gotemplate, initFunc, refreshFunc, freeFunc)
	if not dataList or not goTable or not gotemplate or not initFunc or not refreshFunc or not freeFunc then
		logError("缺失参数")

		return
	end

	local useMap = {}

	for index, data in ipairs(dataList) do
		local goItem = self:_getOrCreateItem(index, goTable, gotemplate, initFunc)

		gohelper.setActive(goItem.go, true)
		refreshFunc(self, goItem, data, index)

		useMap[goItem] = true
	end

	for _, goItem in pairs(goTable) do
		if not useMap[goItem] then
			freeFunc(self, goItem)
		end
	end

	gohelper.setActive(gotemplate, false)
end

function Act183DungeonBaseComp:createObjListNum(count, goTable, gotemplate, initFunc, refreshFunc, freeFunc)
	if not count or not goTable or not gotemplate or not initFunc or not refreshFunc or not freeFunc then
		logError("缺失参数")

		return
	end

	local useMap = {}

	for index = 1, count do
		local goItem = self:_getOrCreateItem(index, goTable, gotemplate, initFunc)

		refreshFunc(self, goItem, nil, index)
		gohelper.setActive(goItem.go, true)

		useMap[goItem] = true
	end

	for _, goItem in pairs(goTable) do
		if not useMap[goItem] then
			freeFunc(self, goItem)
		end
	end

	gohelper.setActive(gotemplate, false)
end

function Act183DungeonBaseComp:_getOrCreateItem(index, goTable, gotemplate, initFunc)
	local goItemTab = goTable[index]

	if not goItemTab then
		goItemTab = self:getUserDataTb_()
		goItemTab.go = gohelper.cloneInPlace(gotemplate, "item_" .. index)
		goItemTab.index = index

		initFunc(self, goItemTab, index)

		goTable[index] = goItemTab
	end

	return goItemTab
end

function Act183DungeonBaseComp:_defaultItemFreeFunc(goItem)
	gohelper.setActive(goItem.go, false)
end

function Act183DungeonBaseComp:getHeight()
	if not self.tran then
		logError(string.format("Transform组件不存在 cls = %s", self.__cname))

		return 0
	end

	if not self._isVisible then
		return 0
	end

	ZProj.UGUIHelper.RebuildLayout(self.tran)

	return recthelper.getHeight(self.tran)
end

function Act183DungeonBaseComp:focus(params)
	return 0
end

function Act183DungeonBaseComp:onDestroy()
	self:__onDispose()
end

return Act183DungeonBaseComp
