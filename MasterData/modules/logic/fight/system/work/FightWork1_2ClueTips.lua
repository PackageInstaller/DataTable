-- chunkname: @modules/logic/fight/system/work/FightWork1_2ClueTips.lua

module("modules.logic.fight.system.work.FightWork1_2ClueTips", package.seeall)

local FightWork1_2ClueTips = class("FightWork1_2ClueTips", BaseWork)

function FightWork1_2ClueTips:onStart()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	self._data = VersionActivity1_2NoteModel.instance:getClueData()

	self:_showView()
end

function FightWork1_2ClueTips:_showView()
	if self._data and #self._data > 0 then
		local data = table.remove(self._data, 1)

		if data.id ~= 101 and data.id ~= 204 then
			ViewMgr.instance:openView(ViewName.VersionActivity_1_2_DungeonMapNoteView, data)
		else
			self:_showView()
		end
	else
		self:onDone(true)
	end
end

function FightWork1_2ClueTips:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity_1_2_DungeonMapNoteView then
		self:_showView()
	end
end

function FightWork1_2ClueTips:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return FightWork1_2ClueTips
