-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingMapView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingMapView", package.seeall)

local AssassinBuildingMapView = class("AssassinBuildingMapView", BaseViewExtended)

function AssassinBuildingMapView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "root/#go_container")
	self._gobuildingicon = gohelper.findChild(self.viewGO, "root/#go_container/#go_buildingicon")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_task", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gotaskreddot = gohelper.findChild(self.viewGO, "root/right/#btn_task/#go_taskreddot")
	self._btndevelop = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_develop", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._txtcurrencynum = gohelper.findChildText(self.viewGO, "root/#go_topright/go_costitem/#txt_currencynum")
	self._gotopright = gohelper.findChild(self.viewGO, "root/#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinBuildingMapView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btndevelop:AddClickListener(self._btndevelopOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.FocusBuilding, self._onFocusBuilding, self)
end

function AssassinBuildingMapView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btndevelop:RemoveClickListener()
end

function AssassinBuildingMapView:_btntaskOnClick()
	AssassinController.instance:openAssassinTaskView()
end

function AssassinBuildingMapView:_btndevelopOnClick()
	AssassinController.instance:openAssassinHeroView()
end

function AssassinBuildingMapView:_editableInitView()
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.AssassinOutsideTask)
	gohelper.setActive(self._gobuildingicon, false)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function AssassinBuildingMapView:onOpen()
	self:openSubView(AssassinCurrencyToolView, nil, self._gotopright)
	self:initAllBuildings()
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_unlockNewEpisode)
end

function AssassinBuildingMapView:initAllBuildings()
	if self.viewParam then
		for _, buildingType in pairs(AssassinEnum.BuildingType) do
			local goparent = gohelper.findChild(self._gocontainer, "go_pos" .. buildingType)

			if not gohelper.isNil(goparent) then
				local goIconPosFlag = gohelper.findChild(goparent, "go_posBuilding")
				local goIconClickAreaFlag = gohelper.findChild(goparent, "go_buildingclickarea")
				local goBuildingIcon = gohelper.clone(self._gobuildingicon, goparent, "building_" .. buildingType)
				local buildingItemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(goBuildingIcon, AssassinBuildingItemIcon)

				buildingItemIcon:updateIconPosition(goIconPosFlag)
				buildingItemIcon:updateIconClickArea(goIconClickAreaFlag)
				buildingItemIcon:setBuildingType(buildingType)

				if self.viewParam and self.viewParam == buildingType then
					buildingItemIcon:_btnclickOnClick()
				end
			else
				logError(string.format("建筑入口缺少挂点 buildingType = %s", buildingType))
			end
		end
	end
end

function AssassinBuildingMapView:_onFocusBuilding(buildingType, isFocus)
	if not self._animator then
		return
	end

	self._animator:Play(isFocus and string.format("building%02d", buildingType) or string.format("back%02d", buildingType), 0, 0)
end

function AssassinBuildingMapView:onClose()
	return
end

function AssassinBuildingMapView:onDestroyView()
	return
end

return AssassinBuildingMapView
