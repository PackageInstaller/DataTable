-- chunkname: @modules/logic/room/view/manufacture/RoomTransportCritterInfo.lua

module("modules.logic.room.view.manufacture.RoomTransportCritterInfo", package.seeall)

local RoomTransportCritterInfo = class("RoomTransportCritterInfo", LuaCompBase)

function RoomTransportCritterInfo:init(go)
	self.go = go
	self._gohas = gohelper.findChild(self.go, "#go_has")
	self._gocrittericon = gohelper.findChild(self.go, "#go_has/#go_critterIcon")
	self._gonone = gohelper.findChild(self.go, "#go_none")
	self._goselected = gohelper.findChild(self.go, "#go_selected")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_click")
	self._goplaceEff = gohelper.findChild(self.go, "#add")
end

function RoomTransportCritterInfo:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, self._onChangeSelectedTransportPath, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.PlayAddCritterEff, self._onAddCritter, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function RoomTransportCritterInfo:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, self._onChangeSelectedTransportPath, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.PlayAddCritterEff, self._onAddCritter, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function RoomTransportCritterInfo:_onClick()
	ManufactureController.instance:clickTransportCritterSlotItem(self.pathId)
end

function RoomTransportCritterInfo:_onChangeSelectedTransportPath()
	self:refreshSelected()
end

function RoomTransportCritterInfo:_onAddCritter(playEffDict, isTransport)
	if not playEffDict or not isTransport then
		return
	end

	if playEffDict[self.pathId] then
		for _, critterUid in ipairs(playEffDict[self.pathId]) do
			if self.critterUid == critterUid then
				self:playPlaceCritterEff()

				break
			end
		end
	end
end

function RoomTransportCritterInfo:_onCloseView(viewName)
	if viewName == ViewName.RoomCritterOneKeyView and self._playEffWaitCloseView then
		self:playPlaceCritterEff()
	end
end

function RoomTransportCritterInfo:setData(critterUid, pathId)
	self.critterUid = critterUid
	self.pathId = pathId
	self._playEffWaitCloseView = false

	self:setCritter()
	self:refresh()
	gohelper.setActive(self.go, true)
end

function RoomTransportCritterInfo:setCritter()
	if self.critterUid then
		self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocrittericon)

		self.critterIcon:setMOValue(self.critterUid)
		self.critterIcon:showMood()
	end

	gohelper.setActive(self._gohas, self.critterUid)
	gohelper.setActive(self._gonone, not self.critterUid)
end

function RoomTransportCritterInfo:refresh()
	self:refreshSelected()
end

function RoomTransportCritterInfo:refreshSelected()
	local isSelected = false

	if self.pathId then
		local selectedPathId = ManufactureModel.instance:getSelectedTransportPath()

		if selectedPathId == self.pathId then
			isSelected = true
		end
	end

	gohelper.setActive(self._goselected, isSelected)
end

function RoomTransportCritterInfo:playPlaceCritterEff()
	local isOpenOneKeyView = ViewMgr.instance:isOpen(ViewName.RoomCritterOneKeyView)

	if isOpenOneKeyView then
		self._playEffWaitCloseView = true
	else
		gohelper.setActive(self._goplaceEff, false)
		gohelper.setActive(self._goplaceEff, true)

		self._playEffWaitCloseView = false
	end
end

function RoomTransportCritterInfo:onDestroy()
	return
end

return RoomTransportCritterInfo
