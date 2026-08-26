-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapTaskView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskView", package.seeall)

local VersionActivity1_5DungeonMapTaskView = class("VersionActivity1_5DungeonMapTaskView", BaseView)

function VersionActivity1_5DungeonMapTaskView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._gotasklist = gohelper.findChild(self.viewGO, "#go_tasklist")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_tasklist/#go_taskitem")
	self._txtopen = gohelper.findChildText(self.viewGO, "#go_tipbg/#txt_open")
	self._gotipsbg = gohelper.findChild(self.viewGO, "#go_tipbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonMapTaskView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity1_5DungeonMapTaskView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity1_5DungeonMapTaskView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity1_5DungeonMapTaskView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getV1a5DungeonSingleBg("v1a5_dungeonmaptask_tipbg"))
end

function VersionActivity1_5DungeonMapTaskView:onUpdateParam()
	return
end

function VersionActivity1_5DungeonMapTaskView:onOpen()
	local episodeId = self.viewParam.episodeId

	self:_showTaskList(episodeId)

	self._txtopen.text = luaLang("v1a5_revival_task_finish_tip")
end

function VersionActivity1_5DungeonMapTaskView:_showTaskList(episodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)
	local listStr = episodeCO.elementList

	if string.nilorempty(listStr) then
		return
	end

	local list = string.splitToNumber(listStr, "#")

	self._listCount = #list

	for i, id in ipairs(list) do
		local go = gohelper.cloneInPlace(self._gotaskitem)
		local item = MonoHelper.addLuaComOnceToGo(go, VersionActivity1_5DungeonMapTaskItem)

		item:setParam({
			i,
			id
		})
		gohelper.setActive(item.viewGO, true)
	end
end

function VersionActivity1_5DungeonMapTaskView:onClose()
	return
end

function VersionActivity1_5DungeonMapTaskView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivity1_5DungeonMapTaskView
