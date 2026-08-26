-- chunkname: @modules/logic/commandstation/view/CommandStationTeamDetailView.lua

module("modules.logic.commandstation.view.CommandStationTeamDetailView", package.seeall)

local CommandStationTeamDetailView = class("CommandStationTeamDetailView", BaseView)

function CommandStationTeamDetailView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goteamprofilepanel = gohelper.findChild(self.viewGO, "#go_teamprofilepanel")
	self._goteam1 = gohelper.findChild(self.viewGO, "#go_teamprofilepanel/#go_team1")
	self._goteam2 = gohelper.findChild(self.viewGO, "#go_teamprofilepanel/#go_team2")
	self._goteam3 = gohelper.findChild(self.viewGO, "#go_teamprofilepanel/#go_team3")
	self._goteam4 = gohelper.findChild(self.viewGO, "#go_teamprofilepanel/#go_team4")
	self._goteam5 = gohelper.findChild(self.viewGO, "#go_teamprofilepanel/#go_team5")
	self._goteam6 = gohelper.findChild(self.viewGO, "#go_teamprofilepanel/#go_team6")
	self._goteam7 = gohelper.findChild(self.viewGO, "#go_teamprofilepanel/#go_team7")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_teamprofilepanel/#txt_title")
	self._txtDescr1 = gohelper.findChildText(self.viewGO, "#go_teamprofilepanel/Scroll View/Viewport/content/#txt_Descr1")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationTeamDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CommandStationTeamDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CommandStationTeamDetailView:_btncloseOnClick()
	self:closeThis()
end

function CommandStationTeamDetailView:onClickModalMask()
	self:closeThis()
end

function CommandStationTeamDetailView:_editableInitView()
	return
end

function CommandStationTeamDetailView:onUpdateParam()
	return
end

function CommandStationTeamDetailView:onOpen()
	self._camp = self.viewParam.camp

	for i = 1, 7 do
		gohelper.setActive(self["_goteam" .. i], CommandStationConfig.instance:getCampByLocation(i) == self._camp)
	end

	local config = lua_copost_character_camp.configDict[self._camp]

	if not config then
		return
	end

	self._txtDescr1.text = config.text
end

function CommandStationTeamDetailView:onClose()
	return
end

function CommandStationTeamDetailView:onDestroyView()
	return
end

return CommandStationTeamDetailView
