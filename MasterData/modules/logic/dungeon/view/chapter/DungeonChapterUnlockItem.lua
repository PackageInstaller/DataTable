-- chunkname: @modules/logic/dungeon/view/chapter/DungeonChapterUnlockItem.lua

module("modules.logic.dungeon.view.chapter.DungeonChapterUnlockItem", package.seeall)

local DungeonChapterUnlockItem = class("DungeonChapterUnlockItem", ListScrollCellExtend)

function DungeonChapterUnlockItem:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gotemplate = gohelper.findChild(self.viewGO, "#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonChapterUnlockItem:addEvents()
	return
end

function DungeonChapterUnlockItem:removeEvents()
	return
end

function DungeonChapterUnlockItem:ctor(config)
	self._config = config
end

function DungeonChapterUnlockItem:_editableInitView()
	self:_showUnlockContent()
	self:_showBeUnlockEpisode()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self._delayShow, self, 0.7)
end

function DungeonChapterUnlockItem:_delayShow()
	gohelper.setActive(self.viewGO, true)
end

function DungeonChapterUnlockItem:_showUnlockContent()
	local list = DungeonChapterUnlockItem.getUnlockContentList(self._config.id)

	for i, v in ipairs(list) do
		local go = gohelper.clone(self._gotemplate, self._gocontainer)

		gohelper.setActive(go, true)

		local txt = gohelper.findChildTextMesh(go, "#txt_condition")
		local image = gohelper.findChildImage(go, "#image_icon")

		UISpriteSetMgr.instance:setUiFBSprite(image, "jiesuo", true)

		txt.text = v
	end
end

function DungeonChapterUnlockItem.getUnlockContentList(id, isToast)
	local list = {}

	if DungeonModel.instance:isReactivityEpisode(id) then
		return list
	end

	local openList = OpenConfig.instance:getOpenShowInEpisode(id)

	if openList then
		for i, v in ipairs(openList) do
			local openCfg = lua_open.configDict[v]
			local content

			if isToast and openCfg and openCfg.bindActivityId ~= 0 then
				local activityId = openCfg.bindActivityId

				if ActivityHelper.getActivityStatus(activityId) == ActivityEnum.ActivityStatus.Normal then
					content = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.ActivityOpen, v)
				end
			else
				content = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.Open, v)
			end

			if content then
				table.insert(list, content)
			end
		end
	end

	local unlockEpisodeList = DungeonConfig.instance:getUnlockEpisodeList(id)

	if unlockEpisodeList then
		for i, v in ipairs(unlockEpisodeList) do
			local content = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.Episode, v)

			if content then
				table.insert(list, content)
			end
		end
	end

	local openGroupList = OpenConfig.instance:getOpenGroupShowInEpisode(id)

	if openGroupList then
		for i, v in ipairs(openGroupList) do
			local content = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.OpenGroup, v)

			if content then
				table.insert(list, content)
			end
		end
	end

	return list
end

function DungeonChapterUnlockItem:_showBeUnlockEpisode()
	if self._config.unlockEpisode <= 0 or DungeonModel.instance:hasPassLevelAndStory(self._config.id) then
		return
	end

	local go = gohelper.clone(self._gotemplate, self._gocontainer)

	gohelper.setActive(go, true)

	local txt = gohelper.findChildTextMesh(go, "#txt_condition")
	local image = gohelper.findChildImage(go, "#image_icon")

	UISpriteSetMgr.instance:setUiFBSprite(image, "suo1", true)

	local episodeCfg = DungeonConfig.instance:getEpisodeCO(self._config.unlockEpisode)

	txt.text = formatLuaLang("dungeon_unlock_episode", string.format("%s %s", DungeonController.getEpisodeName(episodeCfg), episodeCfg.name))
end

function DungeonChapterUnlockItem:_editableAddEvents()
	return
end

function DungeonChapterUnlockItem:_editableRemoveEvents()
	return
end

function DungeonChapterUnlockItem:onUpdateMO(mo)
	return
end

function DungeonChapterUnlockItem:onSelect(isSelect)
	return
end

function DungeonChapterUnlockItem:onDestroyView()
	TaskDispatcher.cancelTask(self._delayShow, self)
end

return DungeonChapterUnlockItem
