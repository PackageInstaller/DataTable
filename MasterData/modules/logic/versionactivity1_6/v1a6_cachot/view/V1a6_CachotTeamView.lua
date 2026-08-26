-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamView", package.seeall)

local V1a6_CachotTeamView = class("V1a6_CachotTeamView", BaseView)

function V1a6_CachotTeamView:onInitView()
	self._gotipswindow = gohelper.findChild(self.viewGO, "#go_tipswindow")
	self._simageselect = gohelper.findChildSingleImage(self.viewGO, "#go_tipswindow/left/#simage_select")
	self._gopresetcontent = gohelper.findChild(self.viewGO, "#go_tipswindow/left/scroll_view/Viewport/#go_presetcontent")
	self._gopreparecontent = gohelper.findChild(self.viewGO, "#go_tipswindow/right/scroll_view/Viewport/#go_preparecontent")
	self._gostart = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_start")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tipswindow/#go_start/#btn_start")
	self._gostartlight = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_start/#btn_start/#go_startlight")
	self._imagepoint1 = gohelper.findChildImage(self.viewGO, "#go_tipswindow/#go_start/#image_point1")
	self._gopoin1light = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_start/#image_point1/#go_poin1_light")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotTeamView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotTeamView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotTeamView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotTeamView:_btnaddheartOnClick()
	return
end

function V1a6_CachotTeamView:_btnaddroleOnClick()
	return
end

function V1a6_CachotTeamView:_btnstartOnClick()
	local allHeros = {}
	local allEquips = {}
	local group = self:_getGroup(1, "", allHeros, allEquips, 1, V1a6_CachotEnum.HeroCountInGroup)
	local backupGroup = self:_getGroup(1, "", allHeros, allEquips, V1a6_CachotEnum.HeroCountInGroup + 1, V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)

	if #allHeros == 0 then
		GameFacade.showToast(ToastEnum.V1a6CachotToast02)

		return
	end

	RogueRpc.instance:sendEnterRogueRequest(V1a6_CachotEnum.ActivityId, V1a6_CachotTeamModel.instance:getSelectLevel(), group, backupGroup, allEquips)
	V1a6_CachotStatController.instance:statStart()
end

function V1a6_CachotTeamView:_getGroup(id, groupName, allHeros, allEquips, startIndex, endIndex)
	local group = {}

	group.id = id
	group.groupName = groupName

	local curGroupMO = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()
	local heroList = {}
	local equips = {}

	for i = startIndex, endIndex do
		local mo = V1a6_CachotHeroSingleGroupModel.instance:getById(i)
		local equipMo = curGroupMO:getPosEquips(i - 1)
		local equipId = tonumber(equipMo.equipUid[1])

		if equipId and equipId > 0 then
			local playerEquipMo = EquipModel.instance:getEquip(equipMo.equipUid[1])

			if playerEquipMo then
				table.insert(allEquips, equipId)
			else
				equipMo.equipUid[1] = "0"
				equipId = 0
			end
		end

		local heroMO = HeroModel.instance:getById(mo.heroUid)

		if heroMO then
			if not heroMO.heroId then
				local heroId = 0

				table.insert(heroList, heroId)
				table.insert(equips, equipMo)

				if heroId > 0 then
					table.insert(allHeros, heroId)
				end
			end
		end
	end

	group.heroList = heroList
	group.equips = equips

	return group
end

function V1a6_CachotTeamView:_hasSelectedHero()
	for i = 1, V1a6_CachotEnum.InitTeamMaxHeroCountInGroup do
		local mo = V1a6_CachotHeroSingleGroupModel.instance:getById(i)
		local heroMO = HeroModel.instance:getById(mo.heroUid)

		if heroMO then
			if not heroMO.heroId then
				local heroId = 0

				if heroId > 0 then
					return true
				end
			end
		end
	end
end

function V1a6_CachotTeamView:_updateStatus()
	local hasSelectedHero = self:_hasSelectedHero()

	gohelper.setActive(self._gostartlight, hasSelectedHero)
	gohelper.setActive(self._gopoin1light, hasSelectedHero)

	self._imagepoint1.enabled = not hasSelectedHero
end

function V1a6_CachotTeamView:onOpen()
	if self.viewParam then
		gohelper.setActive(self._gostart, self.viewParam)
		self:_updateStatus()
		self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnReceiveEnterRogueReply, self._onReceiveEnterRogueReply, self)
		self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)
		NavigateMgr.instance:addEscape(ViewName.V1a6_CachotTeamView, self._btncloseOnClick, self)
	end
end

function V1a6_CachotTeamView:_modifyHeroGroup()
	self:_updateStatus()
end

function V1a6_CachotTeamView:_onReceiveEnterRogueReply()
	ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotDifficultyView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotTeamView)
	V1a6_CachotController.instance:openRoom()
end

function V1a6_CachotTeamView:onClose()
	return
end

function V1a6_CachotTeamView:onDestroyView()
	return
end

return V1a6_CachotTeamView
