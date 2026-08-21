-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomMainSpAtmosFragmentItemCell.lua

module("logic.extensions.housemain.cell.RoomMainSpAtmosFragmentItemCell", package.seeall)

local M = class("RoomMainSpAtmosFragmentItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	self._imgAtmosIcon = goutil.findChildImageComponent(self.mainGO, "icon")
	self._txtAtmosName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._txtAtmosLevel = goutil.findChildTextComponent(self.mainGO, "txtName/txtLv")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "txtProgress")
	self._imgProgress = goutil.findChildImageComponent(self.mainGO, "fillDi/fill")
	self._goScroll = goutil.findChild(self.mainGO, "facilityScroll").gameObject
	self._loopList = LoopListHelper.New(self._goScroll)

	self._loopList:InitListView(0, self._updateCell, self)

	self._dragTrigger = Astral.UIDragTrigger.Get(self._goScroll)
	self._goEmpty = goutil.findChild(self.mainGO, "empty")
end

function M:destroyUI()
	self._handler = nil
	self.mainGO = nil
	self._imgAtmosIcon = nil
	self._txtAtmosName = nil
	self._txtAtmosLevel = nil
	self._txtProgress = nil
	self._imgProgress = nil
	self._goScroll = nil

	self._loopList:Dispose()

	self._loopList = nil
	self._dragTrigger = nil
	self._goEmpty = nil
end

function M:bindEvents()
	self._dragTrigger:AddBeginDragListener(self.onBeginDrag, self)
	self._dragTrigger:AddDragListener(self.onDrag, self)
	self._dragTrigger:AddEndDragListener(self.onEndDrag, self)
end

function M:unbindEvents()
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveDragListener()
	self._dragTrigger:RemoveEndDragListener()
end

function M:onEnter()
	return
end

function M:onExit()
	self._handler = nil
	self._orgPosY = nil

	self._loopList:ClearCells()

	self._atmosTyp = nil
	self._zoneMoLst = nil
	self._hasSetListCount = nil
end

function M:onBeginDrag(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	self._orgPosY = position.y

	if self._handler then
		-- block empty
	end
end

function M:onDrag(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if self._handler then
		local offsetVal = 0
		local deltaY = position.y - self._orgPosY

		self._handler:moveParentScrollContent(deltaY)
	end
end

function M:onEndDrag()
	if self._handler then
		-- block empty
	end
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setData(atmosTyp, atmosVal, zoneMoLst)
	self._atmosTyp = atmosTyp
	self._zoneMoLst = zoneMoLst

	local count = self._zoneMoLst and #self._zoneMoLst or 0

	self:refreshBasedData(atmosVal, count)

	if self._hasSetListCount and self._hasSetListCount == count then
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:SetListItemCount(count, true)
	end

	self._hasSetListCount = count

	goutil.setActive(self._goEmpty, count <= 0)
	goutil.setActive(self._goScroll, count > 0)
end

function M:refreshBasedData(atmosVal, zoneCount)
	local atmosTyp = self._atmosTyp
	local atmosLevel = HouseMainUtil.getSpAtmosphereLv(atmosTyp, atmosVal)

	self._txtAtmosName.text = lang(HouseMainEnum.AtmosphereName[atmosTyp])

	HouseMainUtil.changAtmosphereIcon(self._imgAtmosIcon, atmosTyp)

	self._txtAtmosLevel.text = string.format("Lv.%d", atmosLevel)

	self:_setProcess(atmosVal, atmosLevel)
end

function M:_setProcess(atmosVal, curLv)
	local cfgTypAtmosLst = HouseMainRoomModel.instance:getSpAtmosLevelCfg(self._atmosTyp)
	local atmosCurMaxVal = cfgTypAtmosLst[curLv + 1]

	atmosCurMaxVal = atmosCurMaxVal or cfgTypAtmosLst[curLv]
	self._txtProgress.text = string.format("<color=#d1d1d1>%d</color>/%d", atmosVal, atmosCurMaxVal)

	self:_setProcessFill(math.floor(atmosVal / atmosCurMaxVal * 100) / 100)
end

function M:_setProcessFill(process)
	process = process < 0 and 0 or process
	process = process > 1 and 1 or process
	self._imgProgress.fillAmount = process
end

function M:_updateCell(curIndex)
	curIndex = curIndex + 1

	local zoneMo = self._zoneMoLst[curIndex]
	local itemClass = RoomMainSpAtmosFragmentSubItemCell
	local item = self._loopList:NewListViewItem("facility_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, itemClass)

	shower:onEnter()
	shower:setData(self._atmosTyp, zoneMo)

	return item
end

return M
