-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomMainSpAtmosFragmentView.lua

module("logic.extensions.housemain.view.RoomMainSpAtmosFragmentView", package.seeall)

local M = class("RoomMainSpAtmosFragmentView", StaticFragmentView)

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	self._scroll = self._registry:getUIComponent("atmosphere_value_tips_-334000484", UIComponentType.ScrollRect)
	self._rectScrollContent = self._scroll.content.gameObject:GetComponent(UIComponentType.RectTransform)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._updateCell, self)
end

function M:destroyUI()
	self._cellItem = nil
	self._scroll = nil
	self._rectScrollContent = nil

	self._loopList:Dispose()

	self._loopList = nil
	self._cfgLiveRoomCache = nil
	self._atmospheres = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._enter = true
	self._cellItem = {}

	self:_refreshShow()
end

function M:onExit()
	self._enter = nil

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._loopList:ClearCells()

	self._atmosTypZoneMoLst = nil
	self._tmpVelocity = nil
end

function M:getAtmosphereVal(typ)
	return self._atmospheres[typ] or 0
end

function M:_refreshShow()
	local atmospheres = LivingFacilitiesZoneModel.instance:getAtmospheres()

	if not self._atmospheres then
		self._atmospheres = {}
	end

	for key, AtmosphereNO in ipairs(atmospheres or {}) do
		local typ = AtmosphereNO.atmosphereType
		local val = AtmosphereNO.value or 0

		self._atmospheres[typ] = val
	end

	self:duleAtmosTypeLivingZone()
	self._loopList:SetListItemCount(#HouseMainEnum.AtmosphereShowOrder, true)
end

function M:duleAtmosTypeLivingZone()
	if not self._cfgLiveRoomCache then
		self._cfgLiveRoomCache = {}
	end

	self._atmosTypZoneMoLst = {}

	local zoneLst = LivingFacilitiesZoneModel.instance:getZoneList()

	for _, zoneMo in pairs(zoneLst or {}) do
		local liveRoomTyp = zoneMo:getType() or 0

		if not self._cfgLiveRoomCache[liveRoomTyp] then
			local cfgLiveRoomTyp = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, liveRoomTyp)

			if cfgLiveRoomTyp then
				self._cfgLiveRoomCache[liveRoomTyp] = cfgLiveRoomTyp
			else
				printError(string.format("[%s]无法找到[%d]的配置", ConfigName.HouseLiveRoom, liveRoomTyp))
			end
		end

		if self._cfgLiveRoomCache[liveRoomTyp] then
			local zoneAtmosTyp = self._cfgLiveRoomCache[liveRoomTyp].atmosphere

			if not self._atmosTypZoneMoLst[zoneAtmosTyp] then
				self._atmosTypZoneMoLst[zoneAtmosTyp] = {}
			end

			table.insert(self._atmosTypZoneMoLst[zoneAtmosTyp], zoneMo)
		end
	end
end

function M:_updateCell(curIndex)
	curIndex = curIndex + 1

	local atmosTyp = HouseMainEnum.AtmosphereShowOrder[curIndex]
	local atmosVal = self:getAtmosphereVal(atmosTyp)
	local item = self._loopList:NewListViewItem("special_item")
	local itemClass = RoomMainSpAtmosFragmentItemCell
	local zoneMoLst = self._atmosTypZoneMoLst[atmosTyp] or {}
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, itemClass)

	shower:setHandler(self)
	shower:setData(atmosTyp, atmosVal, zoneMoLst)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:moveParentScrollContent(offsetVal)
	if not self._enter then
		return
	end

	if not self._tmpVelocity then
		self._tmpVelocity = Vector2.New()
	end

	self._tmpVelocity:Set(0, offsetVal * 10)

	self._scroll.velocity = self._tmpVelocity
end

return M
