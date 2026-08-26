-- chunkname: @modules/logic/dungeon/view/DungeonStoryView.lua

module("modules.logic.dungeon.view.DungeonStoryView", package.seeall)

local DungeonStoryView = class("DungeonStoryView", BaseView)

function DungeonStoryView:onInitView()
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "top_left/#btn_back")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_play")
	self._txtchapter = gohelper.findChildText(self.viewGO, "#txt_chapter")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#txt_nameen")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonStoryView:addEvents()
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
end

function DungeonStoryView:removeEvents()
	self._btnback:RemoveClickListener()
	self._btnplay:RemoveClickListener()
end

function DungeonStoryView:_btnbackOnClick()
	self:closeThis()
end

function DungeonStoryView:_btnplayOnClick()
	return
end

function DungeonStoryView:_editableInitView()
	return
end

function DungeonStoryView:onUpdateParam()
	return
end

function DungeonStoryView:onOpen()
	self._txtchapter.text = ""
	self._txtname.text = self.viewParam.name
	self._txtdesc.text = self.viewParam.desc
end

function DungeonStoryView:onClose()
	return
end

function DungeonStoryView:onDestroyView()
	return
end

return DungeonStoryView
