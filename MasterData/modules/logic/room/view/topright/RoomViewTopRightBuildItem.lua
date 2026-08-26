-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightBuildItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightBuildItem", package.seeall)

local RoomViewTopRightBuildItem = class("RoomViewTopRightBuildItem", RoomViewTopRightBaseItem)

function RoomViewTopRightBuildItem:ctor(param)
	RoomViewTopRightBuildItem.super.ctor(self, param)
end

function RoomViewTopRightBuildItem:_customOnInit()
	self._resourceItem.simageicon = gohelper.findChildImage(self._resourceItem.go, "icon")
	self._resourceItem.govxvitality = gohelper.findChild(self._resourceItem.go, "vx_vitality")

	UISpriteSetMgr.instance:setRoomSprite(self._resourceItem.simageicon, "jianshezhi")
	self:_setShow(true)
end

function RoomViewTopRightBuildItem:_onClick()
	if RoomController.instance:isVisitMode() then
		return
	end

	local buildDegree = RoomMapModel.instance:getAllBuildDegree()
	local characterAddLimit = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree)
	local bonus, nextLevelNeed, curLevel = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree)
	local desc = ""

	if nextLevelNeed > 0 then
		local nextCharacterAddLimit = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree + nextLevelNeed)
		local nextBonus = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree + nextLevelNeed)
		local tag = {
			curLevel,
			bonus / 10,
			characterAddLimit,
			buildDegree,
			buildDegree + nextLevelNeed,
			nextBonus / 10,
			nextCharacterAddLimit
		}

		desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_topright_build_next"), tag)
	else
		local tag = {
			curLevel,
			bonus / 10,
			characterAddLimit
		}

		desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_topright_build_desc"), tag)
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.BuildDegree
	})
end

function RoomViewTopRightBuildItem:addEventListeners()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmBackBlock, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmBlock, self._refreshUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.ConfirmBuilding, self._refreshUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.UnUseBuilding, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientPlaceBlock, self._refreshAddNumUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientCancelBlock, self._refreshAddNumUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.ClientPlaceBuilding, self._refreshAddNumUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.ClientCancelBuilding, self._refreshAddNumUI, self)
	self.addEventCb(self, RoomLayoutController.instance, RoomEvent.UISwitchLayoutPlanBuildDegree, self._onSwitchBuildDegree, self)
end

function RoomViewTopRightBuildItem:removeEventListeners()
	return
end

function RoomViewTopRightBuildItem:_onSwitchBuildDegree()
	TaskDispatcher.runDelay(self._onSwitchLayoutAnim, self, 1)
end

function RoomViewTopRightBuildItem:_onSwitchLayoutAnim()
	gohelper.setActive(self._resourceItem.govxvitality, false)
	gohelper.setActive(self._resourceItem.govxvitality, true)
end

function RoomViewTopRightBuildItem:_getPlaceDegree()
	if not RoomController.instance:isEditMode() then
		return 0
	end

	local degree = 0
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	if tempBlockMO then
		local packageConfig = RoomConfig.instance:getPackageConfigByBlockId(tempBlockMO.blockId)

		if packageConfig then
			if not packageConfig.blockBuildDegree then
				local blockDegree = 0

				degree = degree + blockDegree
			end
		end
	end

	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if tempBuildingMO and tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Temp then
		degree = degree + tempBuildingMO.config.buildDegree
	end

	return degree
end

function RoomViewTopRightBuildItem:_refreshUI()
	local buildDegree = RoomMapModel.instance:getAllBuildDegree()

	if not self._lastDegree then
		local lastDegree = buildDegree

		self._lastDegree = buildDegree
		self._resourceItem.txtquantity.text = GameUtil.numberDisplay(buildDegree)

		self:_refreshAddNumUI()

		if lastDegree < buildDegree then
			gohelper.setActive(self._resourceItem.goeffect, false)
			gohelper.setActive(self._resourceItem.goeffect, true)

			local lastBonus = RoomConfig.instance:getBuildBonusByBuildDegree(lastDegree)
			local bonus = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree)

			if lastBonus < bonus then
				local icon = ResUrl.getRoomImage("icon_ziyuan")

				GameFacade.showToastWithIcon(ToastEnum.RoomEditDegreeBonusTip, icon, bonus * 0.1)
			end
		end
	end
end

function RoomViewTopRightBuildItem:_refreshAddNumUI()
	local degree = self:_getPlaceDegree()

	if degree > 0 then
		self._resourceItem.txtaddNum.text = "+" .. degree
	end

	gohelper.setActive(self._resourceItem.txtaddNum, degree > 0)
end

function RoomViewTopRightBuildItem:_customOnDestory()
	TaskDispatcher.cancelTask(self._onSwitchLayoutAnim, self)
end

return RoomViewTopRightBuildItem
