-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackFurnitureDetailView.lua

module("logic.extensions.housebackpack.view.RoomBackpackFurnitureDetailView", package.seeall)

local M = class("RoomBackpackFurnitureDetailView", RoomBackpackItemDetailView)

function M:refreshView()
	M.super.refreshView(self)

	local itemData = self._itemData

	self._txtDesc1.gameObject:SetActive(true)
	self._txtOwnNum.gameObject:SetActive(true)
	self._atmosphereGo:SetActive(true)

	local subType = itemData:getSubType()
	local firstIndex = math.floor(subType / 100)
	local secondIndex = subType % 100

	self._txtOwnNum.text = HouseEnum.FurnitureSubTypeName[firstIndex][secondIndex] or lang("tip_undefined_type")

	local zoneTypes = self._itemData:getZoneTypes()
	local str = lang("tip_apply")

	for index, _type in ipairs(zoneTypes) do
		local livingFacilitiesCo = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, _type)

		str = str .. livingFacilitiesCo.name

		if index ~= #zoneTypes then
			str = str .. "、"
		end
	end

	if #zoneTypes == 0 or zoneTypes[1] == 0 then
		str = lang("tip_universal")
	end

	self._txtDesc1.text = str

	local spAtmosVal, spAtmosTyp = itemData:getCfgSpAtmosValAndTyp()
	local hasSpAtmosphere = spAtmosVal > 0

	if hasSpAtmosphere then
		self._txtCateName.text = lang(HouseMainEnum.AtmosphereName[spAtmosTyp]) or ""
		self._txtCateValue.text = spAtmosVal

		HouseMainUtil.changAtmosphereIcon(self._imgCateIcon, spAtmosTyp)
	end

	self._cateGo:SetActive(hasSpAtmosphere)

	self._txtAtmosphereValue.text = itemData:getAtmosphere()

	HouseMainUtil.changAtmosphereIcon(self._imgAtmosphereIcon, HouseExtension_pb.Atmosphere.NORMAL)
	IconLoader.setSprite(self._imgIconShadow, IconType.Furniture, itemData:getIcon())
	IconLoader.setSprite(self._imgIcon, IconType.Furniture, itemData:getIcon())

	local isInUse = HouseFurnitureModel.instance:getIsFurnitureInUse(itemData:getUuid())

	goutil.setActive(self._btnRecycle.gameObject, not isInUse)
end

function M:_onClickRecycleBtn()
	if RoomBackpackModel.instance:isInRecycling() then
		return
	end

	local isStackItem = RoomBackpackModel.instance:isStackItem(CommEnum.RoomBackpackShowType.FurnitureShowType)
	local uuids = {}

	if isStackItem then
		TableUtil.addRange(uuids, self._itemData:getAllUuid())
	else
		table.insert(uuids, self._itemData:getUuid())
	end

	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_ask_recycle_furniture"))

	dialog:setConfirmListener(function()
		HouseAgent.instance:sendDecomposeFurnituresRequest(uuids)
	end, self)
end

return M
