-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsCurrencyViewComp.lua

module("logic.extensions.tooltips.component.ToolTipsCurrencyViewComp", package.seeall)

local M = class("ToolTipsCurrencyViewComp", ViewComponent)

function M:buildUI()
	self._topCurrencyGo = self:getGo("0&top_currency_1050779625")
	self._gridLayoutGroup = self._topCurrencyGo:GetComponent(UIComponentType.HorizontalOrVerticalLayoutGroup)
	self._moneyItemList = {}
end

function M:unbindEvents()
	return
end

function M:destroyUI()
	return
end

function M:onEnter()
	local info = self:getFirstParam()

	if info then
		if info.anchoredPos then
			Astral.TransformUtil.SetAnchoredPos(self._topCurrencyGo.transform, info.anchoredPos.x, info.anchoredPos.y)
		end

		if info.padding then
			self._gridLayoutGroup.padding.left = info.padding.left
			self._gridLayoutGroup.padding.right = info.padding.right
			self._gridLayoutGroup.padding.top = info.padding.top
			self._gridLayoutGroup.padding.bottom = info.padding.bottom
		end

		if info.width then
			goutil.setWidth(self._topCurrencyGo.transform, info.width)
		end

		if info.heigh then
			goutil.setHeight(self._topCurrencyGo.transform, info.heigh)
		end

		local showTypeInfo = MoneyUtil.getMoneyInfoByShowType(info.moneyShowType)

		for k, v in ipairs(showTypeInfo.moneyCodes) do
			local currencyGo = self:getResInstance(CommonResPath.Url_Currency_Item)

			if currencyGo then
				local isSelectItem = info.baseData:getItemId() == v.code
				local itemView = MoneyBaseItem.New(currencyGo, v.code)

				itemView:setMoneyIconPath(v.src)
				itemView:setAddBtnVisible(v.addBtn)
				table.insert(self._moneyItemList, itemView)
				goutil.addChildToParent(currencyGo, self._topCurrencyGo)
				itemView:setEnable(isSelectItem)
				itemView:onEnter()
				itemView:updateData()
			end
		end
	end
end

function M:onExit()
	for index, itemView in ipairs(self._moneyItemList) do
		itemView:onExit()
	end

	table.clear(self._moneyItemList)
	goutil.clearChildren(self._topCurrencyGo)
end

return M
