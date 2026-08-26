-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingMapEntrance.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingMapEntrance", package.seeall)

local AssassinBuildingMapEntrance = class("AssassinBuildingMapEntrance", BaseViewExtended)

function AssassinBuildingMapEntrance:onInitView()
	self._golevelup = gohelper.findChild(self.viewGO, "go_levelup")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinBuildingMapEntrance:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateBuildingInfo, self.refresh, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateCoinNum, self.refresh, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, self.refresh, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UnlockBuildings, self.refresh, self)
end

function AssassinBuildingMapEntrance:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AssassinBuildingMapEntrance:_btnclickOnClick(buildingType)
	local mapMo = AssassinOutsideModel.instance:getBuildingMapMo()

	if mapMo then
		AssassinController.instance:openAssassinBuildingMapView({
			buildingType = buildingType
		})
	end
end

function AssassinBuildingMapEntrance:_editableInitView()
	return
end

function AssassinBuildingMapEntrance:onOpen()
	self:refresh()

	local viewParam = self.viewContainer.viewParam

	if viewParam and viewParam.openBuildingMap then
		self:_btnclickOnClick(viewParam.buildingType)
	end
end

function AssassinBuildingMapEntrance:refresh()
	self:refreshCanLevelUp()
end

function AssassinBuildingMapEntrance:refreshCanLevelUp()
	local mapMo = AssassinOutsideModel.instance:getBuildingMapMo()
	local canLevelUp = mapMo and mapMo:isAnyBuildingLevelUp2NextLv()

	gohelper.setActive(self._golevelup, canLevelUp)
end

function AssassinBuildingMapEntrance:onClose()
	return
end

function AssassinBuildingMapEntrance:onDestroyView()
	return
end

return AssassinBuildingMapEntrance
