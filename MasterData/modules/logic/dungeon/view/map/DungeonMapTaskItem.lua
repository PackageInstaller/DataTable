-- chunkname: @modules/logic/dungeon/view/map/DungeonMapTaskItem.lua

module("modules.logic.dungeon.view.map.DungeonMapTaskItem", package.seeall)

local DungeonMapTaskItem = class("DungeonMapTaskItem", DungeonMapTaskInfoItem)

function DungeonMapTaskItem:setParam(param)
	if self._anim and (not self.viewGO.activeInHierarchy or self._elementId ~= param[2]) then
		self._anim:Play("taskitem_in", 0, 0)
	end

	self._index = param[1]
	self._elementId = param[2]
	self._episodeId = param[3]
	self._isMain = param[4]

	local elementConfig = lua_chapter_map_element.configDict[self._elementId]

	if not elementConfig then
		logError("元件表找不到元件id:" .. self._elementId)
	end

	self._txtinfo.text = elementConfig.title

	if self:_showIcon(elementConfig) then
		DungeonMapTaskInfoItem.setIcon(self._icon, self._elementId, "zhuxianditu_renwuicon_")
		gohelper.setActive(self._icon, true)
	else
		gohelper.setActive(self._icon, false)
	end

	self:refreshStatus()
end

function DungeonMapTaskItem:_showIcon(elementConfig)
	if elementConfig.type == DungeonEnum.ElementType.Investigate then
		return false
	end

	return true
end

function DungeonMapTaskItem:refreshStatus()
	local isFinish = DungeonMapModel.instance:elementIsFinished(self._elementId)

	if isFinish then
		local color = GameUtil.parseColor("#272525b2")

		self._txtinfo.color = color
		self._txtprogress.color = color
		self._icon.color = GameUtil.parseColor("#b2562b")
		self._txtprogress.text = "1/1"
	else
		local color = GameUtil.parseColor("#272525")

		self._txtinfo.color = color
		self._txtprogress.color = color
		self._icon.color = GameUtil.parseColor("#81807f")
		self._txtprogress.text = "0/1"
	end

	local episodeId = self._episodeId
	local episodeConfig = lua_episode.configDict[episodeId]
	local showArrow = not isFinish and DungeonModel.instance:isFinishElementList(episodeConfig)

	gohelper.setActive(self._goarrow, showArrow)
	gohelper.setActive(self._btnclick, showArrow)
end

function DungeonMapTaskItem:init(go)
	DungeonMapTaskItem.super.init(self, go)

	self._txtprogress = gohelper.findChildText(self.viewGO, "progress")
	self._goarrow = gohelper.findChild(self.viewGO, "arrow")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_goto")
end

function DungeonMapTaskItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function DungeonMapTaskItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function DungeonMapTaskItem:_btnclickOnClick()
	ViewMgr.instance:closeView(ViewName.DungeonMapTaskView)

	if self._isMain then
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpEpisodeItemAndElement, self._episodeId, self._elementId)

		return
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.ManualClickElement, self._elementId)
end

function DungeonMapTaskItem:onStart()
	return
end

function DungeonMapTaskItem:onDestroy()
	return
end

return DungeonMapTaskItem
