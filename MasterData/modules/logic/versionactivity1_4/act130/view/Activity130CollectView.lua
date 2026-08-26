-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130CollectView.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130CollectView", package.seeall)

local Activity130CollectView = class("Activity130CollectView", BaseView)

function Activity130CollectView:onInitView()
	self._btnCloseMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CloseMask")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "BG/#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/txt_Title")
	self._goquestion = gohelper.findChild(self.viewGO, "Question")
	self._txtQuestion = gohelper.findChildText(self.viewGO, "Question/#txt_Question")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ChapterList")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_ChapterList/Viewport/Content")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self._txtEmpty = gohelper.findChildText(self.viewGO, "#go_Empty/#txt_Empty")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130CollectView:addEvents()
	self._btnCloseMask:AddClickListener(self._btnCloseMaskOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Activity130CollectView:removeEvents()
	self._btnCloseMask:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Activity130CollectView:_btnCloseMaskOnClick()
	self:closeThis()
end

function Activity130CollectView:_btnCloseOnClick()
	self:closeThis()
end

function Activity130CollectView:_editableInitView()
	NavigateMgr.instance:addEscape(ViewName.Activity130CollectView, self._btnCloseOnClick, self)
end

function Activity130CollectView:onUpdateParam()
	return
end

function Activity130CollectView:onOpen()
	self._collectItems = {}

	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	self._config = Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId)

	self:_refreshItem()
end

function Activity130CollectView:_refreshItem()
	local operGroupId = Activity130Model.instance:getEpisodeOperGroupId(self._config.episodeId)

	gohelper.setActive(self._goquestion, operGroupId ~= 0)

	if operGroupId ~= 0 then
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local groupId = Activity130Model.instance:getEpisodeOperGroupId(self._config.episodeId)
		local decryptId = Activity130Model.instance:getDecryptIdByGroupId(groupId)
		local operCo = Activity130Config.instance:getActivity130DecryptCo(actId, decryptId)

		self._txtQuestion.text = operCo.puzzleTxt
	end

	local collects = Activity130Model.instance:getCollects(self._config.episodeId)

	if #collects < 1 then
		gohelper.setActive(self._goEmpty, true)
		gohelper.setActive(self._scrollChapterList.gameObject, false)

		local tipId, stepId = Activity130Model.instance:getEpisodeTaskTip(self._config.episodeId)

		if tipId ~= 0 then
			local dialogCo = Activity130Config.instance:getActivity130DialogCo(tipId, stepId)

			self._txtEmpty.text = dialogCo.content
		end

		return
	end

	gohelper.setActive(self._goEmpty, false)
	gohelper.setActive(self._scrollChapterList.gameObject, true)

	for _, v in pairs(self._collectItems) do
		v:hideItems()
	end

	for i = 1, #collects do
		if not self._collectItems[i] then
			local path = self.viewContainer:getSetting().otherRes[1]
			local childGO = self:getResInst(path, self._gocontent, "item" .. tostring(i))
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, Activity130CollectItem)

			item:init(childGO)
			table.insert(self._collectItems, item)
		end

		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local co = Activity130Config.instance:getActivity130OperateGroupCos(actId, operGroupId)[collects[i]]

		self._collectItems[i]:setItem(co, i)
	end
end

function Activity130CollectView:onClose()
	return
end

function Activity130CollectView:onDestroyView()
	return
end

return Activity130CollectView
