-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsGetWayView.lua

module("logic.extensions.tooltips.component.ToolTipsGetWayView", package.seeall)

local normalColor = "#2C2C2CFF"
local grayColor = "#474747FF"
local M = class("ToolTipsGetWayView")
local SystemOpenState = CommEnum.SystemOpenState
local DisableView = {
	ViewName.GainItemView,
	ViewName.BattleCalculateNew,
	ViewName.ItemConvert
}

function M:ctor(container)
	self._go = container.gameObject
	self._elementsRegistry = ViewElementsRegistry.New(container)
	self._getWayDesc = self._elementsRegistry:findUIElement("path_get_item_-283171413", UIComponentType.Text)
	self._btnGetJump = UIComponentType.ButtonAdapter(self._elementsRegistry:findUIElement("path_get_item_1317333162"))

	self._btnGetJump:AddClickListener(self._dealJump, self)

	self._canvasGroup = goutil.addComponentOnce(self._go, ComponentType.CanvasGroup)
	self._goSign = goutil.findChild(self._go, "com_label")
	self._goSign1 = self._elementsRegistry:findUIElement("0&com_label_787295976")
	self._txtSign1 = self._elementsRegistry:findUIElement("0&com_label_-1513538352", UIComponentType.Text)
	self._goSign2 = self._elementsRegistry:findUIElement("0&com_label_1181881388")
	self._txtSign2 = self._elementsRegistry:findUIElement("0&com_label_1979641530", UIComponentType.Text)
end

function M:_dealJump()
	if self._state == SystemOpenState.OpenState then
		local jumpInfo = SystemJumpConfig.instance:getJumpInfo(self._jumpId)

		if jumpInfo and jumpInfo.viewName == ViewName.CharacterMainSystemViewNew then
			local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
			local moList = _tmpHeroList:getMoList()
			local herodata = moList[1]

			HeroDepotModel.instance:setViewPageMo({
				index = 1,
				hero = herodata,
				list = {
					herodata
				}
			})
		end

		local paramsTable = self._jumpParamsTable or {}

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._jumpId, unpack(paramsTable))
	else
		FloatWordMgr.instance:show("暂不支持跳转")
	end
end

function M:setDisable()
	self._canvasGroup.alpha = 0.2
	self._canvasGroup.blocksRaycasts = false
end

function M:updateData(data)
	local jumpInfo = data.jumpInfo

	if jumpInfo then
		self._state = data.state

		local isOpen = SystemOpenState.OpenState == self._state

		self._canvasGroup.alpha = isOpen and 1 or 0.2
		self._canvasGroup.blocksRaycasts = isOpen

		local color

		if isOpen then
			color = normalColor
		else
			color = grayColor
			self._getWayDesc.text = SystemOpenState.NotOpenState == self._state and "未开启" or "已过期"
		end

		self._jumpId = jumpInfo.jumpId

		self:setGetWayDesc(not string.nilorempty(jumpInfo.jumpDesc) and jumpInfo.jumpDesc or "暂无常规获取途径")
		self:_updateProbability(data.getTips)
		self:_handleTreasureWays(jumpInfo)
	else
		self:setGetWayDesc("暂无常规获取途径")

		self._canvasGroup.alpha = 0.2
		self._canvasGroup.blocksRaycasts = false
	end

	self:setActive(true)

	if not self._notCheckDisableView then
		for _, view in pairs(DisableView) do
			if ViewMgr.instance:isOpen(view) then
				self:setDisable()
			end
		end
	end
end

function M:setNotCheckDisableView(value)
	self._notCheckDisableView = value
end

function M:setJumpParamsTable(paramsTable)
	self._jumpParamsTable = paramsTable
end

function M:setGetWayDesc(str)
	self._getWayDesc.text = str
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:destroy()
	self._elementsRegistry = nil
	self._commColorNode = nil

	self._btnGetJump:RemoveClickListener()
end

function M:getColorTextStr(str, color)
	if color then
		return string.format("<color=%s>%s</color>", color, str)
	else
		return str
	end
end

function M:setGetLineVisible(visible)
	return
end

function M:_updateProbability(getTips)
	local data = BackpackOtherConfig.instance:getTipsById(getTips)

	goutil.setActive(self._goSign, data ~= nil)
	goutil.setActive(self._goSign1, data ~= nil)

	if data ~= nil and self._txtSign1 then
		self._txtSign1.text = data.tips
	end
end

function M:_handleTreasureWays(jumpInfo)
	if jumpInfo.viewName ~= ViewName.TreasureChooseViewNew then
		return
	end

	local itemId = checknumber(jumpInfo.extValue1)
	local count = ItemModel.instance:getItemCountByItemId(itemId)

	if count < 1 then
		self:setDisable()
	end
end

return M
