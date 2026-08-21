-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackItemDetailView.lua

module("logic.extensions.housebackpack.view.RoomBackpackItemDetailView", package.seeall)

local M = class("RoomBackpackItemDetailView")
local SystemOpenState = CommEnum.SystemOpenState

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._imgIconShadow = self._registry:getImage("furniture_detail_tips_-1690409959")
	self._imgIcon = self._registry:getImage("furniture_detail_tips_-1703132492")
	self._txtName = self._registry:getText("furniture_detail_tips_1363962286")
	self._txtOwnNum = self._registry:getText("furniture_detail_tips_-942455136")
	self._txtDesc1 = self._registry:getText("furniture_detail_tips_968107641")
	self._useDesc = self._registry:getText("furniture_detail_tips_-899174080")
	self._detailDesc = self._registry:getText("furniture_detail_tips_-943489013")
	self._imgQuality = self._registry:getImage("furniture_detail_tips_-785600464")
	self._cateGo = self._registry:getGo("furniture_detail_tips_-1181347158")
	self._imgCateIcon = goutil.findChildImageComponent(self._mainGo, "content2/cate/cateIcon")
	self._txtCateName = self._registry:getText("furniture_detail_tips_-914730740")
	self._txtCateValue = self._registry:getText("furniture_detail_tips_-543656671")
	self._atmosphereGo = self._registry:getGo("furniture_detail_tips_667309825")
	self._imgAtmosphereIcon = goutil.findChildImageComponent(self._mainGo, "content2/atmosphere/atmosphereIcon")
	self._txtAtmosphereValue = self._registry:getText("furniture_detail_tips_-244834212")
	self._wayViewList = {}
	self._getWayGo = self._registry:getGo("furniture_detail_tips_405091784")
	self._goNoneGetWay = self._registry:getGo("furniture_detail_tips_-1534252744")
	self._goPathGetItem = self._registry:getGo("2&path_get_item_1317333162")
	self._btnNotGain = self._registry:getBtn("furniture_detail_tips_1273413430")
	self._btnUsing = self._registry:getBtn("furniture_detail_tips_-973703470")
	self._btnRecycle = self._registry:getBtn("furniture_detail_tips_1854868282")

	self._txtDesc1.gameObject:SetActive(false)
	self._cateGo:SetActive(false)
	self._atmosphereGo:SetActive(false)
	self._goPathGetItem:SetActive(false)
	self._btnNotGain.gameObject:SetActive(false)
	self._btnUsing.gameObject:SetActive(false)
	self._btnRecycle.gameObject:SetActive(false)
end

function M:_bindEvents()
	self._btnNotGain:AddClickListener(self._onClickNotGainBtn, self)
	self._btnUsing:AddClickListener(self._onClickUsingBtn, self)
	self._btnRecycle:AddClickListener(self._onClickRecycleBtn, self)
end

function M:_unbindEvents()
	self._btnNotGain:RemoveClickListener()
	self._btnUsing:RemoveClickListener()
	self._btnRecycle:RemoveClickListener()
end

function M:onEnter()
	self:_bindEvents()
end

function M:onExit()
	self:_unbindEvents()
end

function M:refreshView()
	if not self._itemData then
		return
	end

	local itemData = self._itemData

	self._txtName.text = itemData:getName()
	self._useDesc.text = StringUtil.randomReplaceBlackBlock(itemData:getItemUseDesc())
	self._detailDesc.text = StringUtil.randomReplaceBlackBlock(itemData:getItemDesc())
	self._txtOwnNum.text = string.format("%s", itemData:getCount())

	goutil.setActive(self._txtOwnNum.gameObject, itemData:getCount() > 0)
	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterSystem, GameUrl.getEquipQualityUrl(itemData:getQuality()))

	local getWayView = false
	local itemGo = false
	local count = 0

	for k, v in pairs(self._wayViewList) do
		v:setActive(false)
	end

	local getWaysInfo = SystemJumpModel.instance:getJumpData(itemData:getGetWays())

	for k, v in ipairs(getWaysInfo or {}) do
		getWayView = self._wayViewList[k]

		if not getWayView then
			itemGo = goutil.clone(self._goPathGetItem)

			itemGo:SetActive(true)

			getWayView = ToolTipsGetWayView.New(itemGo)
			self._wayViewList[k] = getWayView

			goutil.addChildToParent(itemGo, self._getWayGo)
		end

		self:_adjustOpenState(v)
		getWayView:updateData(v)
		getWayView:setJumpParamsTable(self:_getJumpParamsTable(v.jumpId))

		count = count + 1
	end

	goutil.setActive(self._goNoneGetWay, count == 0)
end

function M:_getJumpParamsTable(jumpId)
	local itemData = self._itemData

	if jumpId == 20060000 then
		return {
			itemData:getItemId()
		}
	end

	return {}
end

function M:_adjustOpenState(data)
	local itemData = self._itemData
	local jumpId = data.jumpId

	if jumpId == 20060000 and data.state == SystemOpenState.OpenState and not self:_hasFurniturePaper(itemData:getItemId()) then
		data.state = SystemOpenState.NotOpenState
	end
end

function M:_hasFurniturePaper(furnitureId)
	local hasPaper = false
	local paperId = HouseSceneUtil.getPaperIdByFurniture(furnitureId)

	if paperId then
		local itemList = ItemModel.instance:getItemsByItemId(paperId)
		local itemData = itemList[1]
		local itemUUId = itemData and checknumber(itemData:getUuid()) or 0

		if itemUUId > 0 then
			hasPaper = true
		end
	end

	return hasPaper
end

function M:setItemData(itemData)
	self._itemData = itemData

	self:refreshView()
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	for k, v in pairs(self._wayViewList or {}) do
		v:destroy()
	end

	self._wayViewList = nil
	self._getWayGo = nil
end

function M:_onClickNotGainBtn()
	return
end

function M:_onClickUsingBtn()
	return
end

function M:_onClickRecycleBtn()
	return
end

return M
