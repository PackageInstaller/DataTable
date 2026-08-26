-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonMapSelectView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonMapSelectView", package.seeall)

local AtomicDungeonMapSelectView = class("AtomicDungeonMapSelectView", BaseView)

function AtomicDungeonMapSelectView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._screenClick = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)
	self._gomapSelectRoot = gohelper.findChild(self.viewGO, "root/#go_mapSelectRoot")
	self._gomapInfoItem = gohelper.findChild(self.viewGO, "root/#go_mapSelectRoot/#go_mapInfoItem")

	gohelper.setActive(self._gomapInfoItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonMapSelectView:addEvents()
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnUpdateElementPush, self.refreshUI, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnMapUpdate, self.refreshUI, self)
end

function AtomicDungeonMapSelectView:removeEvents()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnUpdateElementPush, self.refreshUI, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnMapUpdate, self.refreshUI, self)
	self._screenClick:RemoveClickUpListener()
end

AtomicDungeonMapSelectView.ItemFocusOffsetPos = Vector3(-1, 0, 0)

function AtomicDungeonMapSelectView:onMapItemClick(mapItem)
	local canClick = AtomicDungeonModel.instance:getCanClickElementState()

	if not canClick then
		return
	end

	if not mapItem.mapComp.mapMo then
		GameFacade.showToastString(mapItem.config.unlockDesc)

		return
	end

	local isDraggingMap = AtomicDungeonModel.instance:getDraggingMapState()

	if isDraggingMap or not mapItem then
		return
	end

	local sceneView = self.viewContainer:getDungeonSceneView()

	if sceneView then
		sceneView:enterDungeonMap(mapItem.config.id)
	end
end

function AtomicDungeonMapSelectView:_editableInitView()
	self.mapInfoItemTab = self:getUserDataTb_()
	self.mainCamera = CameraMgr.instance:getMainCamera()
end

function AtomicDungeonMapSelectView:onOpen()
	self.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	gohelper.setActive(self._gomapSelectRoot, self.isInMapSelectState)
	self:refreshUI()
end

function AtomicDungeonMapSelectView:refreshUI()
	local allDungeonMapInfoCoList = AtomicDungeonConfig.instance:getAllDungeonMapInfoCoList()

	for _, mapInfoConfig in ipairs(allDungeonMapInfoCoList) do
		local mapInfoItem = self.mapInfoItemTab[mapInfoConfig.id]

		if not mapInfoItem then
			mapInfoItem = {
				config = mapInfoConfig,
				root = gohelper.findChild(self._gomapSelectRoot, "#go_map" .. mapInfoConfig.id)
			}
			mapInfoItem.pos = gohelper.findChild(mapInfoItem.root, "pos")
			mapInfoItem.btnClick = gohelper.findChildButtonWithAudio(mapInfoItem.root, "btn_click")
			mapInfoItem.go = gohelper.clone(self._gomapInfoItem, mapInfoItem.pos, "mapInfoItem")
			mapInfoItem.mapComp = MonoHelper.addLuaComOnceToGo(mapInfoItem.go, AtomicDungeonMapSelectItem, {
				mapInfoConfig,
				self
			})

			mapInfoItem.btnClick:AddClickListener(self.onMapItemClick, self, mapInfoItem)

			self.mapInfoItemTab[mapInfoConfig.id] = mapInfoItem
		end

		gohelper.setActive(mapInfoItem.go, true)
		mapInfoItem.mapComp:updateInfo()
	end
end

function AtomicDungeonMapSelectView:onDisposeOldMap()
	return
end

function AtomicDungeonMapSelectView:onClose()
	self:onDisposeOldMap()

	for _, mapInfoItem in pairs(self.mapInfoItemTab) do
		mapInfoItem.btnClick:RemoveClickListener()
	end
end

function AtomicDungeonMapSelectView:onDestroyView()
	return
end

return AtomicDungeonMapSelectView
