-- chunkname: @modules/logic/room/view/topright/RoomViewTopRight.lua

module("modules.logic.room.view.topright.RoomViewTopRight", package.seeall)

local RoomViewTopRight = class("RoomViewTopRight", BaseView)

function RoomViewTopRight:ctor(path, resPath, param)
	RoomViewTopRight.super.ctor(self)

	self._path = path
	self._resPath = resPath
	self._param = param
end

function RoomViewTopRight:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewTopRight:_editableInitView()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, self._refreshShow, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._refreshShow, self)
	self.addEventCb(self, RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, self._refreshShow, self)

	self._resourceItemList = {}

	if string.nilorempty(self._path) or string.nilorempty(self._resPath) or not LuaUtil.tableNotEmpty(self._param) then
		return
	end

	local containerGO = gohelper.findChild(self.viewGO, self._path)

	self._topRight = self.viewContainer:getResInst(self._resPath, containerGO, "topright")
	self._goflyitem = gohelper.findChild(self._topRight, "go_flyitem")
	self._goresource = gohelper.findChild(self._topRight, "container/resource")

	gohelper.setActive(self._goflyitem, false)

	for i = 1, 6 do
		local resourceGO = gohelper.cloneInPlace(self._goresource, "resource" .. i)

		gohelper.setActive(resourceGO, false)

		local param = self._param[i]

		if param then
			param.parent = self
			param.index = i

			local resourceGO = gohelper.findChild(self._topRight, "container/resource" .. i)
			local classDefine = param.classDefine
			local resourceItem = MonoHelper.addNoUpdateLuaComOnceToGo(resourceGO, classDefine, param)
		end
	end

	gohelper.setActive(self._goresource, false)

	self._flyItemPoolList = self:getUserDataTb_()
end

function RoomViewTopRight:onDestroyView()
	return
end

function RoomViewTopRight:_onOpenView(viewName)
	self:_refreshShow()
end

function RoomViewTopRight:_onCloseView(viewName)
	self:_refreshShow()
end

function RoomViewTopRight:_refreshShow()
	local topViewName = self:_getTopView()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()
	local isInDialogInteraction = RoomCharacterHelper.isInDialogInteraction()
	local isShowSkinList = RoomSkinModel.instance:getIsShowRoomSkinList()
	local isTransportPath = RoomTransportController.instance:isTransportPathShow()

	gohelper.setActive(self._topRight, topViewName == self.viewName and not isInDialogInteraction and not isWaterReform and not isShowSkinList and not isTransportPath)
end

function RoomViewTopRight:_getTopView()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	openViewNameList = NavigateMgr.sortOpenViewNameList(openViewNameList)

	for i = #openViewNameList, 1, -1 do
		local viewName = openViewNameList[i]
		local viewContainer = ViewMgr.instance:getContainer(viewName)

		if viewContainer and viewContainer._views then
			for j = #viewContainer._views, 1, -1 do
				local view = viewContainer._views[j]

				if view.__cname == self.__cname then
					return viewName
				end
			end
		end
	end
end

function RoomViewTopRight:getFlyGO()
	local flyGO = self._flyItemPoolList[#self._flyItemPoolList]

	if flyGO then
		table.remove(self._flyItemPoolList, #self._flyItemPoolList)
	else
		flyGO = gohelper.cloneInPlace(self._goflyitem, "flyEffect")
	end

	gohelper.setActive(flyGO, false)
	gohelper.setActive(flyGO, true)

	return flyGO
end

function RoomViewTopRight:returnFlyGO(flyGO)
	gohelper.setActive(flyGO, false)
	table.insert(self._flyItemPoolList, flyGO)
end

return RoomViewTopRight
