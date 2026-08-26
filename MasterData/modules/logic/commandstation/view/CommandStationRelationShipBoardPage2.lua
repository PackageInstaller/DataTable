-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipBoardPage2.lua

module("modules.logic.commandstation.view.CommandStationRelationShipBoardPage2", package.seeall)

local CommandStationRelationShipBoardPage2 = class("CommandStationRelationShipBoardPage2", CommandStationRelationShipBoardPage)

function CommandStationRelationShipBoardPage2:onInitView()
	self._btnteam1 = gohelper.findChildButtonWithAudio(self.viewGO, "gridlayout/#go_btngroup/#btn_team1")
	self._btnteam2 = gohelper.findChildButtonWithAudio(self.viewGO, "gridlayout/#go_btngroup/#btn_team2")
	self._btnteam3 = gohelper.findChildButtonWithAudio(self.viewGO, "gridlayout/#go_btngroup/#btn_team3")
	self._btnteam4 = gohelper.findChildButtonWithAudio(self.viewGO, "gridlayout/#go_btngroup/#btn_team4")
	self._btnteam5 = gohelper.findChildButtonWithAudio(self.viewGO, "gridlayout/#go_btngroup/#btn_team5")
	self._btnteam6 = gohelper.findChildButtonWithAudio(self.viewGO, "gridlayout/#go_btngroup/#btn_team6")
	self._btnteam7 = gohelper.findChildButtonWithAudio(self.viewGO, "gridlayout/#go_btngroup/#btn_team7")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationRelationShipBoardPage2:addEvents()
	self._btnteam1:AddClickListener(self._btnteam1OnClick, self)
	self._btnteam2:AddClickListener(self._btnteam2OnClick, self)
	self._btnteam3:AddClickListener(self._btnteam3OnClick, self)
	self._btnteam4:AddClickListener(self._btnteam4OnClick, self)
	self._btnteam5:AddClickListener(self._btnteam5OnClick, self)
	self._btnteam6:AddClickListener(self._btnteam6OnClick, self)
	self._btnteam7:AddClickListener(self._btnteam7OnClick, self)
end

function CommandStationRelationShipBoardPage2:removeEvents()
	self._btnteam1:RemoveClickListener()
	self._btnteam2:RemoveClickListener()
	self._btnteam3:RemoveClickListener()
	self._btnteam4:RemoveClickListener()
	self._btnteam5:RemoveClickListener()
	self._btnteam6:RemoveClickListener()
	self._btnteam7:RemoveClickListener()
end

function CommandStationRelationShipBoardPage2:ctor(pageIndex)
	self._pageIndex = pageIndex
end

function CommandStationRelationShipBoardPage2:_btnteam1OnClick()
	self:_openCommandStationTeamDetailView(1)
end

function CommandStationRelationShipBoardPage2:_btnteam2OnClick()
	self:_openCommandStationTeamDetailView(2)
end

function CommandStationRelationShipBoardPage2:_btnteam3OnClick()
	self:_openCommandStationTeamDetailView(3)
end

function CommandStationRelationShipBoardPage2:_btnteam4OnClick()
	self:_openCommandStationTeamDetailView(4)
end

function CommandStationRelationShipBoardPage2:_btnteam5OnClick()
	self:_openCommandStationTeamDetailView(5)
end

function CommandStationRelationShipBoardPage2:_btnteam6OnClick()
	self:_openCommandStationTeamDetailView(6)
end

function CommandStationRelationShipBoardPage2:_btnteam7OnClick()
	self:_openCommandStationTeamDetailView(7)
end

function CommandStationRelationShipBoardPage2:_openCommandStationTeamDetailView(location)
	local camp = self:_getCampByLocation(location)

	CommandStationController.setOnceActionKey(CommandStationEnum.PrefsKey.CampNewFlag, camp)
	CommandStationController.instance:openCommandStationTeamDetailView({
		camp = camp
	})
	self:_updateTeamNewFlag()
end

function CommandStationRelationShipBoardPage2:onOpen()
	CommandStationRelationShipBoardPage2.super.onOpen(self)

	self._teamVisible = {}

	self:_initTeamNameVisible()
	self:_updateTeamNewFlag()
	self:_initTeamBtnVisible()
end

function CommandStationRelationShipBoardPage2:_needShowFirstOpenAnim(i)
	return not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenTeam, i) or self._showAllFirstOpenAnim
end

function CommandStationRelationShipBoardPage2:_initFirstOpenTeam()
	return
end

function CommandStationRelationShipBoardPage2:_playFirstOpenTeamAnim()
	for i = 1, CommandStationEnum.MaxCampLocationIndex do
		local go = gohelper.findChild(self.viewGO, "Team" .. i)

		if self._teamVisible[i] then
			gohelper.setActive(go, true)
			CommandStationController.setOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenTeam, i)

			local animator = go and go:GetComponent("Animator")

			if animator then
				animator:Play("firstopen", 0, 0)
			end
		end
	end
end

function CommandStationRelationShipBoardPage2:_initTeamBtnVisible()
	for i = 1, CommandStationEnum.MaxCampLocationIndex do
		local btn = self["_btnteam" .. i]
		local camp = self:_getCampByLocation(i)
		local config = lua_copost_character_camp.configDict[camp]

		if config then
			::label_17_0::

			local visible = DungeonModel.instance:hasPassLevelAndStory(config.unlockId)

			gohelper.setActive(btn, visible)
		end
	end
end

function CommandStationRelationShipBoardPage2:_updateTeamNewFlag()
	for i = 1, CommandStationEnum.MaxCampLocationIndex do
		local go = gohelper.findChild(self.viewGO, "gridlayout/#go_btngroup/#btn_team" .. i)
		local newGo = go and gohelper.findChild(go, "#go_new")
		local showNew = not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.CampNewFlag, self:_getCampByLocation(i))

		gohelper.setActive(newGo, showNew)
	end
end

function CommandStationRelationShipBoardPage2:_initTeamNameVisible()
	for i = 1, CommandStationEnum.MaxCampLocationIndex do
		local go = gohelper.findChild(self.viewGO, "Team" .. i)
		local txt = go and gohelper.findChild(go, "image_Sticker/txt_Team" .. i)
		local camp = self:_getCampByLocation(i)
		local isNoCharacter = self:_noCharacterCamp(camp)

		if not self._campStatusMap[camp] then
			gohelper.setActive(txt, self._campStatusMap[camp])

			if isNoCharacter then
				local config = lua_copost_character_camp.configDict[camp]

				if config then
					::label_19_0::

					local visible = DungeonModel.instance:hasPassLevelAndStory(config.unlockId)

					gohelper.setActive(go, visible)

					if visible and self:_needShowFirstOpenAnim(i) then
						gohelper.setActive(go, false)

						self._teamVisible[i] = true
					end
				end
			elseif self:_needShowFirstOpenAnim(i) then
				gohelper.setActive(go, false)

				self._teamVisible[i] = true
			end
		end
	end
end

function CommandStationRelationShipBoardPage2:_noCharacterCamp(camp)
	return CommandStationController.noCharacterCamp(camp)
end

return CommandStationRelationShipBoardPage2
