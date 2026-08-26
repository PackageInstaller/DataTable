-- chunkname: @modules/logic/dungeon/view/map/DungeonMapEquipEntry.lua

module("modules.logic.dungeon.view.map.DungeonMapEquipEntry", package.seeall)

local DungeonMapEquipEntry = class("DungeonMapEquipEntry", BaseView)

function DungeonMapEquipEntry:onInitView()
	self._goentryItem = gohelper.findChild(self.viewGO, "#go_res/entry/#go_entryItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapEquipEntry:addEvents()
	return
end

function DungeonMapEquipEntry:removeEvents()
	return
end

function DungeonMapEquipEntry:_editableInitView()
	self._goentry = gohelper.findChild(self.viewGO, "#go_res/entry")
end

function DungeonMapEquipEntry:onUpdateParam()
	return
end

function DungeonMapEquipEntry:onOpen()
	self._chapterId = self.viewParam.chapterId

	self:_showEntryItem()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function DungeonMapEquipEntry:_onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		gohelper.setActive(self._goentry, false)
	end
end

function DungeonMapEquipEntry:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		gohelper.setActive(self._goentry, true)
	end
end

function DungeonMapEquipEntry:_showEntryItem()
	local chapterConfig = DungeonConfig.instance:getChapterCO(self._chapterId)

	if chapterConfig.type ~= DungeonEnum.ChapterType.Equip then
		return
	end

	local list = DungeonMapModel.instance:getEquipSpChapters()

	for i, id in ipairs(list) do
		local go = gohelper.cloneInPlace(self._goentryItem)
		local item = MonoHelper.addLuaComOnceToGo(go, DungeonMapEquipEntryItem, {
			i,
			id
		})

		gohelper.setActive(go, true)
	end
end

function DungeonMapEquipEntry:onClose()
	return
end

function DungeonMapEquipEntry:onDestroyView()
	return
end

return DungeonMapEquipEntry
