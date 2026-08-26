-- chunkname: @modules/logic/dungeon/view/map/DungeonMapTaskInfoItem.lua

module("modules.logic.dungeon.view.map.DungeonMapTaskInfoItem", package.seeall)

local DungeonMapTaskInfoItem = class("DungeonMapTaskInfoItem", LuaCompBase)

function DungeonMapTaskInfoItem:setParam(param)
	if self._anim and (not self.viewGO.activeInHierarchy or self._elementId ~= param[2]) then
		self._anim:Play("taskitem_in", 0, 0)
	end

	self._index = param[1]
	self._elementId = param[2]

	local elementConfig = lua_chapter_map_element.configDict[self._elementId]

	if not elementConfig then
		logError("元件表找不到元件id:" .. self._elementId)
	end

	self._txtinfo.text = elementConfig.title

	DungeonMapTaskInfoItem.setIcon(self._icon, self._elementId, "zhuxianditu_renwuicon_")
	self:refreshStatus()
end

function DungeonMapTaskInfoItem.setIcon(icon, elementId, name)
	local elementConfig = lua_chapter_map_element.configDict[elementId]
	local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)

	if not DungeonEnum.ElementTypeUIResIdMap[elementConfig.type] then
		local resId = elementConfig.type

		UISpriteSetMgr.instance:setUiFBSprite(icon, name .. resId .. (isFinish and 1 or 0))
	end
end

function DungeonMapTaskInfoItem:refreshStatus()
	local isFinish = DungeonMapModel.instance:elementIsFinished(self._elementId)

	if isFinish then
		local color = GameUtil.parseColor("#c66030")

		self._txtinfo.color = color
		self._icon.color = color
	else
		self._txtinfo.color = GameUtil.parseColor("#ded9d4")
		self._icon.color = GameUtil.parseColor("#a1a3a6")
	end
end

function DungeonMapTaskInfoItem:init(go)
	self.viewGO = go
	self._txtinfo = gohelper.findChildText(self.viewGO, "info")
	self._icon = gohelper.findChildImage(go, "icon")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
end

function DungeonMapTaskInfoItem:playTaskOutAnim()
	if self.viewGO.activeInHierarchy then
		self._anim:Play("taskitem_out")
		TaskDispatcher.cancelTask(self._hideGo, self)
		TaskDispatcher.runDelay(self._hideGo, self, 0.24)
	end
end

function DungeonMapTaskInfoItem:_hideGo()
	gohelper.setActive(self.viewGO, false)
end

function DungeonMapTaskInfoItem:addEventListeners()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
end

function DungeonMapTaskInfoItem:removeEventListeners()
	return
end

function DungeonMapTaskInfoItem:_setEpisodeListVisible(value)
	if value then
		self._anim:Play("taskitem_in", 0, 0)
	else
		self._anim:Play("taskitem_out", 0, 0)
	end
end

function DungeonMapTaskInfoItem:onStart()
	return
end

function DungeonMapTaskInfoItem:onDestroy()
	TaskDispatcher.cancelTask(self._hideGo, self)
end

function DungeonMapTaskInfoItem:_playEnterAnim(viewName)
	if viewName == ViewName.DungeonMapTaskView then
		self._anim:Play("taskitem_in", 0, 0)
	end
end

function DungeonMapTaskInfoItem:_playOutAnim(viewName)
	if viewName == ViewName.DungeonMapTaskView then
		self._anim:Play("taskitem_out", 0, 0)
	end
end

return DungeonMapTaskInfoItem
