-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackItemDetailView.lua

module("logic.extensions.backpack.view.BackpackItemDetailView", package.seeall)

local M = class("BackpackItemDetailView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._iconImg = self._registry:getImage("backpack_item_detail_tips_-703036041")
	self._itemName = self._registry:getText("backpack_item_detail_tips_-766328664")
	self._itemCount = self._registry:getText("backpack_item_detail_tips_-482901642")
	self._useDesc = self._registry:getText("backpack_item_detail_tips_-137403632")
	self._txtUse = self._registry:getText("1&btn_middle_1478048452")
	self._detailDesc = self._registry:getUIComponent("backpack_item_detail_tips_-1713553180", UIComponentType.TMPText)
	self._txtExpireTime = self._registry:getText("backpack_item_detail_tips_897287490")
	self._txtUseTips = self._registry:getText("backpack_item_detail_tips_copy_-605734065")
	self._timeGo = self._registry:getGo("backpack_item_detail_tips_-40362305")
	self._scroll = self._registry:getGo("backpack_item_detail_tips_-1350407798")
	self._wayViewList = {}
	self._getWayGo = self._registry:getGo("backpack_item_detail_tips_-2127041853")
	self._goNoneGetWay = self._registry:getGo("backpack_item_detail_tips_-743689353")
	self._goPathGetItem = goutil.findChild(self._getWayGo, "get_path_item").gameObject

	self._goPathGetItem:SetActive(false)

	self._btnUse = self._registry:getBtn("1&btn_middle_-31477526")

	self._btnUse.gameObject:SetActive(false)
end

function M:_bindEvents()
	self._btnUse:AddClickListener(self._onClickUseBtn, self)
end

function M:_unbindEvents()
	self._btnUse:RemoveClickListener()
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

	self._itemName.text = itemData:getName()
	self._useDesc.text = StringUtil.randomReplaceBlackBlock(itemData:getItemUseDesc())
	self._detailDesc.text = StringUtil.randomReplaceBlackBlock(itemData:getItemDesc())
	self._itemCount.text = string.format("%s", itemData:getCount())
	self._txtExpireTime.text = self:getExpiredTimeStr(itemData:getExpireTime())

	goutil.setActive(self._itemCount.gameObject, itemData:getCount() > 0)
	IconLoader.setSpriteByItemType(self._iconImg, itemData:getType(), itemData:getIcon(), nil, nil, itemData:getSubType())

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

		getWayView:setNotCheckDisableView(true)
		getWayView:updateData(v)
		getWayView:setGetLineVisible(k ~= #getWaysInfo)

		count = count + 1
	end

	goutil.setActive(self._goNoneGetWay, count == 0)
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

function M:getExpiredTimeStr(expiredTime)
	expiredTime = expiredTime or 0
	expiredTime = tonumber(expiredTime)

	goutil.setActive(self._timeGo, expiredTime ~= 0)

	if expiredTime == 0 then
		return ""
	end

	local curTime = ServerTime.now() * 1000

	if expiredTime < curTime then
		return lang("tip_overdue")
	end

	local offset = expiredTime - curTime
	local timeStr = TextFormatter.formatExpireTime(offset / 1000)

	return timeStr
end

function M:_onClickComplexBtn()
	return
end

function M:_onClickUseBtn()
	return
end

function M:setScrollSize(hasBtn)
	return
end

return M
