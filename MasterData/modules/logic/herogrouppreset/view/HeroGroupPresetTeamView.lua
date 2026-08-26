-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetTeamView.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamView", package.seeall)

local HeroGroupPresetTeamView = class("HeroGroupPresetTeamView", BaseView)

function HeroGroupPresetTeamView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#scroll_tab")
	self._scrollgroup = gohelper.findChildScrollRect(self.viewGO, "#scroll_group")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetTeamView:addEvents()
	return
end

function HeroGroupPresetTeamView:removeEvents()
	return
end

function HeroGroupPresetTeamView:_editableInitView()
	return
end

function HeroGroupPresetTeamView:onUpdateParam()
	return
end

function HeroGroupPresetTeamView:onOpen()
	HeroGroupPresetTabListModel.instance:initTabList()
end

function HeroGroupPresetTeamView:onClose()
	HeroGroupPresetItemListModel.instance:clearInfo()
end

function HeroGroupPresetTeamView:onDestroyView()
	return
end

return HeroGroupPresetTeamView
