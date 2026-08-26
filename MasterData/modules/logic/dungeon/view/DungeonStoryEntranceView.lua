-- chunkname: @modules/logic/dungeon/view/DungeonStoryEntranceView.lua

module("modules.logic.dungeon.view.DungeonStoryEntranceView", package.seeall)

local DungeonStoryEntranceView = class("DungeonStoryEntranceView", BaseView)

function DungeonStoryEntranceView:onInitView()
	self._btnblack = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_black")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_play")
	self._txtchapter = gohelper.findChildText(self.viewGO, "#txt_chapter")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#txt_nameen")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonStoryEntranceView:addEvents()
	self._btnblack:AddClickListener(self._btnblackOnClick, self)
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
end

function DungeonStoryEntranceView:removeEvents()
	self._btnblack:RemoveClickListener()
	self._btnplay:RemoveClickListener()
end

function DungeonStoryEntranceView:_btnblackOnClick()
	self:closeThis()
end

function DungeonStoryEntranceView:_btnplayOnClick()
	DungeonRpc.instance:sendStartDungeonRequest(self._config.chapterId, self._config.id)

	local param = {}

	param.mark = true
	param.episodeId = self._config.id

	StoryController.instance:playStory(self._config.beforeStory, param, self.onStoryFinished, self)
end

function DungeonStoryEntranceView:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(self.viewName)
end

function DungeonStoryEntranceView:_editableInitView()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copiesdetails)
end

function DungeonStoryEntranceView:onUpdateParam()
	return
end

function DungeonStoryEntranceView:onOpen()
	self._config = self.viewParam[1]
	self._txtname.text = self._config.name
	self._txtnameen.text = self._config.name_En
	self._txtdesc.text = self._config.desc

	DungeonLevelItem.showEpisodeName(self._config, self.viewParam[3], self.viewParam[4], self._txtchapter)
end

function DungeonStoryEntranceView:onClose()
	return
end

function DungeonStoryEntranceView:onDestroyView()
	return
end

return DungeonStoryEntranceView
