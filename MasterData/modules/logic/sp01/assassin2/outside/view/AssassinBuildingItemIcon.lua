-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingItemIcon.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingItemIcon", package.seeall)

local AssassinBuildingItemIcon = class("AssassinBuildingItemIcon", LuaCompBase)

function AssassinBuildingItemIcon:init(go)
	self.go = go
	self._simageicon = gohelper.findChildSingleImage(self.go, "simage_icon")
	self._gounlock = gohelper.findChild(self.go, "go_unlock")
	self._simageiconline = gohelper.findChildSingleImage(self.go, "go_unlock/simage_icon_line")
	self._simageiconline2 = gohelper.findChildSingleImage(self.go, "go_unlock/simage_icon_line/glow")
	self._txtname = gohelper.findChildText(self.go, "go_unlock/txt_name")
	self._txtlv = gohelper.findChildText(self.go, "go_unlock/txt_lv")
	self._golevelup = gohelper.findChild(self.go, "go_unlock/go_levelup")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gobuildingclickarea = gohelper.findChild(self.go, "btn_click/go_buildingclickarea")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function AssassinBuildingItemIcon:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateBuildingInfo, self._onUpdateBuildingInfo, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UnlockBuildings, self._onUnlockBuildings, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.FocusBuilding, self._onFocusBuilding, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateCoinNum, self._onUpdateCoinNum, self)
end

function AssassinBuildingItemIcon:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinBuildingItemIcon:_btnclickOnClick()
	if not self._isUnlocked then
		return
	end

	AssassinController.instance:dispatchEvent(AssassinEvent.FocusBuilding, self._type, true)
	AssassinController.instance:openAssassinBuildingLevelUpView(self._type)
end

function AssassinBuildingItemIcon:setBuildingType(type)
	self._type = type

	self:refresh()
end

function AssassinBuildingItemIcon:updateIconPosition(goIconPosTemplate)
	if gohelper.isNil(goIconPosTemplate) then
		return
	end

	local posX, posY = recthelper.getAnchor(goIconPosTemplate.transform)

	recthelper.setAnchor(self._simageicon.transform, posX or 0, posY or 0)
	recthelper.setAnchor(self._simageiconline.transform, posX or 0, posY or 0)
end

function AssassinBuildingItemIcon:updateIconClickArea(goClickAreaTemplate)
	if gohelper.isNil(goClickAreaTemplate) then
		return
	end

	local tranClickAreaTemplate = goClickAreaTemplate.transform
	local posX, posY = recthelper.getAnchor(tranClickAreaTemplate)
	local width = recthelper.getWidth(tranClickAreaTemplate)
	local height = recthelper.getHeight(tranClickAreaTemplate)

	recthelper.setAnchor(self._gobuildingclickarea.transform, posX, posY)
	recthelper.setSize(self._gobuildingclickarea.transform, width, height)
end

function AssassinBuildingItemIcon:refresh()
	self._mapMo = AssassinOutsideModel.instance:getBuildingMapMo()
	self._isUnlocked = self._mapMo and self._mapMo:isBuildingTypeUnlocked(self._type)

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._gounlock, self._isUnlocked)

	if not self._isUnlocked then
		local buildingCo = AssassinConfig.instance:getBuildingLvCo(self._type, 1)

		self._simageicon:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. buildingCo.lockBuildingIcon))

		return
	end

	local buildingMo = self._mapMo:getBuildingMo(self._type)
	local buildingCo = buildingMo and buildingMo:getConfig()

	self._lv = buildingMo and buildingMo:getLv()

	if buildingCo then
		self._txtname.text = buildingCo.title or ""
	end

	self._txtlv.text = AssassinHelper.formatLv(self._lv)

	local canLevelUp = self._mapMo:isBuildingLevelUp2NextLv(self._type)

	gohelper.setActive(self._golevelup, canLevelUp)
	self._simageicon:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. buildingCo.buildingIcon))
	self._simageiconline:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. buildingCo.buildingBgIcon))
	self._simageiconline2:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. buildingCo.buildingBgIcon))
end

function AssassinBuildingItemIcon:_onUpdateBuildingInfo(buildingType)
	if self._type ~= buildingType then
		return
	end

	self:refresh()
end

function AssassinBuildingItemIcon:_onUnlockBuildings()
	self:refresh()
end

function AssassinBuildingItemIcon:_onFocusBuilding(buildingType, isFocus)
	local stateName = isFocus and "switch" or "bake"

	self._animator:Play(stateName, 0, 0)
end

function AssassinBuildingItemIcon:_onUpdateCoinNum()
	self:refresh()
end

function AssassinBuildingItemIcon:onDestroy()
	self._simageicon:UnLoadImage()
	self._simageiconline:UnLoadImage()
	self._simageiconline2:UnLoadImage()
end

return AssassinBuildingItemIcon
