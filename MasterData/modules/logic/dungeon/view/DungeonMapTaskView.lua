-- chunkname: @modules/logic/dungeon/view/DungeonMapTaskView.lua

module("modules.logic.dungeon.view.DungeonMapTaskView", package.seeall)

local DungeonMapTaskView = class("DungeonMapTaskView", BaseView)

function DungeonMapTaskView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._gotasklist = gohelper.findChild(self.viewGO, "#go_tasklist")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_tasklist/#go_taskitem")
	self._txtopen = gohelper.findChildText(self.viewGO, "#go_tipbg/#txt_open")
	self._gotipsbg = gohelper.findChild(self.viewGO, "#go_tipbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapTaskView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DungeonMapTaskView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function DungeonMapTaskView:_btncloseOnClick()
	self:closeThis()
end

function DungeonMapTaskView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.setActive(self._gotaskitem, false)
end

function DungeonMapTaskView:onUpdateParam()
	return
end

function DungeonMapTaskView:onOpen()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickGuidepost)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	local episodeId = self.viewParam.viewParam

	self:_showTaskList(episodeId)

	local targetEpisodeId = DungeonConfig.instance:getUnlockEpisodeId(episodeId)
	local episodeConfig = lua_episode.configDict[targetEpisodeId]
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if episodeConfig and chapterConfig then
		local episodeIndex, type = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)
		local index = string.format("%s-%s", (type == DungeonEnum.EpisodeType.Sp or nil) and "SP", episodeIndex)

		self._txtopen.text = string.format(lua_language_coder.configDict.dungeonmaptaskview_open.lang)
	end
end

function DungeonMapTaskView:_showTaskList(episodeId)
	local listStr = DungeonConfig.instance:getElementList(episodeId)
	local list = string.splitToNumber(listStr, "#")

	self._listCount = #list

	for i, id in ipairs(list) do
		local go = gohelper.cloneInPlace(self._gotaskitem)
		local item = MonoHelper.addLuaComOnceToGo(go, DungeonMapTaskItem)

		item:setParam({
			i,
			id,
			self.viewParam.viewParam,
			self.viewParam.isMain
		})
		gohelper.setActive(item.viewGO, true)
	end
end

function DungeonMapTaskView:onClose()
	return
end

function DungeonMapTaskView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return DungeonMapTaskView
