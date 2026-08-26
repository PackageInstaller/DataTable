-- chunkname: @modules/logic/room/entity/comp/RoomDebugPackageUIComp.lua

module("modules.logic.room.entity.comp.RoomDebugPackageUIComp", package.seeall)

local RoomDebugPackageUIComp = class("RoomDebugPackageUIComp", RoomBaseUIComp)

function RoomDebugPackageUIComp:ctor(entity)
	RoomDebugPackageUIComp.super.ctor(self, entity)

	self._res = RoomScenePreloader.ResDebugPackageUI
end

function RoomDebugPackageUIComp:init(go)
	RoomDebugPackageUIComp.super.init(self, go)

	self._name = "debugpackageui_" .. self.go.name

	self:refreshUI()
end

function RoomDebugPackageUIComp:addEventListeners()
	RoomDebugPackageUIComp.super.addEventListeners(self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, self.refreshUI, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPlaceListShowChanged, self.refreshUI, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageListShowChanged, self.refreshUI, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageFilterChanged, self.refreshUI, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageOrderChanged, self.refreshUI, self)
end

function RoomDebugPackageUIComp:removeEventListeners()
	RoomDebugPackageUIComp.super.removeEventListeners(self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, self.refreshUI, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPlaceListShowChanged, self.refreshUI, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageListShowChanged, self.refreshUI, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageFilterChanged, self.refreshUI, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageOrderChanged, self.refreshUI, self)
end

function RoomDebugPackageUIComp:refreshUI()
	if not RoomDebugController.instance:isDebugPackageListShow() and not RoomDebugController.instance:isDebugPlaceListShow() then
		self:returnUI()

		return
	end

	if RoomDebugController.instance:isDebugPackageListShow() and not RoomDebugController.instance:isEditPackageOrder() then
		self:returnUI()

		return
	end

	local blockMO = self.entity:getMO()

	if RoomDebugController.instance:isDebugPackageListShow() then
		local selectPackageId = RoomDebugPackageListModel.instance:getFilterPackageId()

		if not selectPackageId or selectPackageId ~= blockMO.packageId or selectPackageId <= 0 then
			self:returnUI()

			return
		end

		local selectMainRes = RoomDebugPackageListModel.instance:getFilterMainRes()

		selectMainRes = selectMainRes or RoomResourceEnum.ResourceId.Empty

		if blockMO:getMainRes() ~= selectMainRes then
			self:returnUI()

			return
		end

		self:getUI()

		self._txtcount.text = blockMO.packageOrder

		self:refreshPosition()
	elseif RoomDebugController.instance:isDebugPlaceListShow() then
		self:getUI()

		local blockDefineConfig = blockMO:getBlockDefineCfg()

		self._txtcount.text = RoomHelper.getBlockPrefabName(blockDefineConfig.prefabPath)

		self:refreshPosition()
	end
end

function RoomDebugPackageUIComp:initUI()
	self._txtcount = gohelper.findChildText(self._gocontainer, "txt_count")
end

function RoomDebugPackageUIComp:destoryUI()
	self._txtcount = nil
end

function RoomDebugPackageUIComp:getUIWorldPos()
	local blockMO = self.entity:getMO()
	local position = HexMath.hexToPosition(blockMO.hexPoint, RoomBlockEnum.BlockSize)

	return (Vector3(position.x, 0.5, position.y))
end

function RoomDebugPackageUIComp:onClick()
	if not RoomDebugController.instance:isDebugPackageListShow() then
		return
	end

	local blockMO = self.entity:getMO()

	RoomDebugController.instance:debugSetPackageOrder(blockMO.id)
end

return RoomDebugPackageUIComp
