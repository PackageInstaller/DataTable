-- chunkname: @modules/logic/rouge/common/comp/RougeCollectionComp.lua

module("modules.logic.rouge.common.comp.RougeCollectionComp", package.seeall)

local RougeCollectionComp = class("RougeCollectionComp", RougeLuaCompBase)

function RougeCollectionComp.Get(go)
	local comp = RougeCollectionComp.New()

	comp:init(go)

	return comp
end

function RougeCollectionComp:init(go)
	self:__onInit()
	RougeCollectionComp.super.init(self, go)

	self.go = go
	self._gostate1 = gohelper.findChild(self.go, "Root/#go_state1")
	self._gostate2 = gohelper.findChild(self.go, "Root/#go_state2")
	self._goicon = gohelper.findChild(self.go, "Root/#go_state1/#go_icon")
	self._gostate2Normal = gohelper.findChild(self.go, "Root/#go_state2/#go_Normal")
	self._gostate2Light = gohelper.findChild(self.go, "Root/#go_state2/#go_Light")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "Root/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionComp:_editableInitView()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)

	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._slotComp = RougeCollectionSlotComp.Get(self._goicon, RougeCollectionHelper.BagEntrySlotParam)

	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, self.placeCollection2SlotArea, self)
end

function RougeCollectionComp:_btnclickOnClick()
	RougeController.instance:openRougeCollectionChessView()
end

function RougeCollectionComp:onOpen(state)
	local slotCollections = RougeCollectionModel.instance:getSlotAreaCollection()
	local slotSize = RougeCollectionModel.instance:getCurSlotAreaSize()
	local col = slotSize.col
	local row = slotSize.row

	self._slotComp:onUpdateMO(col, row, slotCollections)
	self:switchEntryState(state)
	self:tickUpdateDLCs()
end

function RougeCollectionComp:onClose()
	return
end

function RougeCollectionComp:switchEntryState(newState)
	newState = newState or RougeEnum.CollectionEntryState.Grid

	if self._curState == newState then
		return
	end

	self._curState = newState

	if newState == RougeEnum.CollectionEntryState.Icon then
		self:onSwitch2IconState()
	elseif newState == RougeEnum.CollectionEntryState.Grid then
		self:onSwitch2GridState()
	end
end

function RougeCollectionComp:onSwitch2IconState()
	self:setState2IconLight(false)
	self._animator:Play("swicth_state2", 0, 0)
end

function RougeCollectionComp:onSwitch2GridState()
	self._animator:Play("swicth_state1", 0, 0)
end

function RougeCollectionComp:setState2IconLight(isLight)
	gohelper.setActive(self._gostate2Normal, not isLight)
	gohelper.setActive(self._gostate2Light, isLight)
end

function RougeCollectionComp:placeCollection2SlotArea(collectionMO, reason)
	local isNewGetCollection = RougeCollectionHelper.isNewGetCollection(reason)

	if collectionMO and isNewGetCollection and self._curState == RougeEnum.CollectionEntryState.Icon then
		self:setState2IconLight(true)
	end
end

function RougeCollectionComp:destroy()
	self._btnclick:RemoveClickListener()

	if self._slotComp then
		self._slotComp:destroy()
	end

	self:__onDispose()
end

return RougeCollectionComp
