-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonMapSelectView.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonMapSelectView", package.seeall)

local OdysseyDungeonMapSelectView = class("OdysseyDungeonMapSelectView", BaseView)

function OdysseyDungeonMapSelectView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._screenClick = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonMapSelectView:addEvents()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	end

	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnInitMapSelect, self.onInitMapSelect, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, self.refreshUI, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.DailyRefresh, self.refreshUI, self)
end

function OdysseyDungeonMapSelectView:removeEvents()
	self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnInitMapSelect, self.onInitMapSelect, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, self.refreshUI, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.DailyRefresh, self.refreshUI, self)
	self._screenClick:RemoveClickUpListener()
end

OdysseyDungeonMapSelectView.ItemFocusOffsetPos = Vector3(-1, 0, 0)

function OdysseyDungeonMapSelectView:onMapItemClickDown(mapItem)
	self.curClickMapItem = mapItem
end

function OdysseyDungeonMapSelectView:onScreenClickUp()
	local isDraggingMap = OdysseyDungeonModel.instance:getDraggingMapState()

	if isDraggingMap then
		return
	end

	self:setIconSelectState()

	if not self.curClickMapItem then
		ViewMgr.instance:closeView(ViewName.OdysseyDungeonMapSelectInfoView)

		return
	end

	local curMapItem = self.mapSelectItemTab[self.curClickMapItem.config.id]
	local mapItemRootPos = self:getMapItemRootPos(curMapItem.pos) + OdysseyDungeonMapSelectView.ItemFocusOffsetPos

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusMapSelectItem, mapItemRootPos, true)
	OdysseyDungeonController.instance:openDungeonMapSelectInfoView(self.curClickMapItem.config.id)
	self:saveMapItemNewUnlockData(self.curClickMapItem.config.id)
	self:refreshMapItemReddot()

	self.curClickMapItem = nil
end

function OdysseyDungeonMapSelectView:onGamepadKeyDown(key)
	if key ~= GamepadEnum.KeyCode.A then
		return
	end

	local screenPos = GamepadController.instance:getScreenPos()
	local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(screenPos)
	local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
	local maxIndex = allRaycastHit.Length - 1

	for i = 0, maxIndex do
		local hitInfo = allRaycastHit[i]
		local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, OdysseyDungeonMapSelectItem)

		if comp then
			comp:onClickDown()
		end
	end
end

function OdysseyDungeonMapSelectView:_editableInitView()
	self.mapSelectItemTab = self:getUserDataTb_()
	self.mapIconItemTab = self:getUserDataTb_()
	self.mainCamera = CameraMgr.instance:getMainCamera()

	self:saveMapItemNewUnlockData(1)
end

function OdysseyDungeonMapSelectView:onInitMapSelect(mapSelectRootGO)
	self._screenClick:AddClickUpListener(self.onScreenClickUp, self)

	self.mapSelectRootGO = mapSelectRootGO
	self.rootGO = gohelper.findChild(self.mapSelectRootGO, "root")
	self.rootScale = transformhelper.getLocalScale(self.rootGO.transform)

	self:refreshUI()

	local needFocusMainMapSelectItem = OdysseyDungeonModel.instance:getNeedFocusMainMapSelectItem()

	if not needFocusMainMapSelectItem then
		local mapSelectPosCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MapSelectPos)
		local posParam = string.splitToNumber(mapSelectPosCo.value, "#")

		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusMapSelectItem, Vector3(posParam[1], posParam[2], 0), false)
	else
		self:onFocusMainMapSelectItem(false)
	end
end

function OdysseyDungeonMapSelectView:onFocusMainMapSelectItem(tween)
	local mainTaskMapCo, mainTaskElementCo = OdysseyDungeonModel.instance:getCurMainElement()

	if mainTaskElementCo and mainTaskElementCo.mapId then
		local mainMapItem = self.mapSelectItemTab[mainTaskElementCo.mapId]
		local mainMapItemPos = self:getMapItemRootPos(mainMapItem.pos)

		mainMapItem.mapComp:playMainTaskEffect()
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusMapSelectItem, mainMapItemPos, tween)
	end

	OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(false)
end

function OdysseyDungeonMapSelectView:getMapItemRootPos(posGO)
	local mapItemPos = self.mapSelectRootGO.transform:InverseTransformPoint(posGO.transform.position)

	if not -mapItemPos.x then
		if not -mapItemPos.y then
			local mapPosY = 0
			local tempScenePos = Vector3()

			tempScenePos:Set(-mapItemPos.x, mapPosY, 0)

			return tempScenePos
		end
	end
end

function OdysseyDungeonMapSelectView:refreshUI()
	local isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if not isInMapSelectState then
		return
	end

	local mapConfigList = OdysseyConfig.instance:getAllDungeonMapCoList()
	local mapItemGO = gohelper.findChild(self.rootGO, "#go_mapItem")
	local mapIconItemGO = gohelper.findChild(self.rootGO, "#go_mapIconItem")

	gohelper.setActive(mapItemGO, false)
	gohelper.setActive(mapIconItemGO, false)

	for _, mapConfig in ipairs(mapConfigList) do
		local mapItem = self.mapSelectItemTab[mapConfig.id]

		if not mapItem then
			mapItem = {
				config = mapConfig,
				pos = gohelper.findChild(self.rootGO, "#go_map" .. mapConfig.id)
			}
			mapItem.go = gohelper.clone(mapItemGO, mapItem.pos, "mapItem")
			mapItem.mapComp = MonoHelper.addLuaComOnceToGo(mapItem.go, OdysseyDungeonMapSelectItem, {
				mapConfig,
				self
			})
			self.mapSelectItemTab[mapConfig.id] = mapItem
		end

		gohelper.setActive(mapItem.go, true)
		mapItem.mapComp:updateInfo()

		local mapIconItem = self.mapIconItemTab[mapConfig.id]

		if not mapIconItem then
			mapIconItem = {
				config = mapConfig,
				iconPos = gohelper.findChild(self.rootGO, "#go_mapIcon" .. mapConfig.id)
			}
			mapIconItem.go = gohelper.clone(mapIconItemGO, mapIconItem.iconPos, "mapIconItem")
			mapIconItem.simageLockIcon = gohelper.findChildSingleImage(mapIconItem.go, "simage_lockIcon")
			mapIconItem.simageSelect = gohelper.findChildSingleImage(mapIconItem.go, "simage_select")
			self.mapIconItemTab[mapConfig.id] = mapIconItem
		end

		gohelper.setActive(mapIconItem.go, true)

		local mapIconRes = string.format("map/odyssey_bigmap_map_%s_0", mapIconItem.config.id)
		local mapIconSelectRes = string.format("map/odyssey_bigmap_map_%s_1", mapIconItem.config.id)

		mapIconItem.simageLockIcon:LoadImage(ResUrl.getSp01OdysseySingleBg(mapIconRes))
		mapIconItem.simageSelect:LoadImage(ResUrl.getSp01OdysseySingleBg(mapIconSelectRes))

		local mapInfoMo = OdysseyDungeonModel.instance:getMapInfo(mapIconItem.config.id)

		gohelper.setActive(mapIconItem.simageLockIcon.gameObject, not mapInfoMo)
	end

	self:setIconSelectState()
	self:refreshMapItemReddot()
end

function OdysseyDungeonMapSelectView:setIconSelectState()
	for _, mapItem in ipairs(self.mapSelectItemTab) do
		mapItem.mapComp:setSelectState(self.curClickMapItem and mapItem.config.id == self.curClickMapItem.config.id)
	end

	for index, iconItem in pairs(self.mapIconItemTab) do
		gohelper.setActive(iconItem.simageSelect.gameObject, self.curClickMapItem and self.curClickMapItem.config.id == iconItem.config.id)
	end
end

function OdysseyDungeonMapSelectView:saveMapItemNewUnlockData(mapId)
	local mapInfoMo = OdysseyDungeonModel.instance:getMapInfo(mapId)

	if mapInfoMo then
		OdysseyDungeonModel.instance:saveLocalCurNewLock(OdysseyEnum.LocalSaveKey.MapNew, {
			mapId
		})
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function OdysseyDungeonMapSelectView:refreshMapItemReddot()
	for mapId, mapItem in pairs(self.mapSelectItemTab) do
		mapItem.mapComp:refreshReddotShowState()
	end
end

function OdysseyDungeonMapSelectView:onDisposeOldMap()
	for index, item in pairs(self.mapSelectItemTab) do
		gohelper.destroy(item.go)
	end

	for index, iconItem in pairs(self.mapIconItemTab) do
		iconItem.simageLockIcon:UnLoadImage()
		iconItem.simageSelect:UnLoadImage()
		gohelper.destroy(iconItem.go)
	end

	self.mapSelectItemTab = {}
	self.mapIconItemTab = {}
end

function OdysseyDungeonMapSelectView:onClose()
	self:onDisposeOldMap()
end

function OdysseyDungeonMapSelectView:onDestroyView()
	return
end

return OdysseyDungeonMapSelectView
