-- chunkname: @modules/logic/college/view/comp/CollegeResCostComp.lua

module("modules.logic.college.view.comp.CollegeResCostComp", package.seeall)

local CollegeResCostComp = class("CollegeResCostComp", LuaCompBase)

function CollegeResCostComp.Get(go, costColorType)
	local costComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, CollegeResCostComp)

	costComp:initColor(costColorType)

	return costComp
end

function CollegeResCostComp:init(go)
	self.go = go
	self._goCostItem = gohelper.findChild(self.go, "#go_Cost")
end

function CollegeResCostComp:initColor(colorType)
	self._colorType = colorType or CollegeEnum.ItemCostColorType.Light
	self._colorTab = CollegeEnum.ItemCostColor[self._colorType]
	self._enoughColor = self._colorTab and self._colorTab.Enough
	self._notEnoughColor = self._colorTab and self._colorTab.NotEnough
end

function CollegeResCostComp:addEventListeners()
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateBag, self.refreshUI, self)
end

function CollegeResCostComp:onUpdateMO(costTab, rateTb)
	self._costTab = costTab
	self._multRate = rateTb

	self:refreshUI()
end

function CollegeResCostComp:refreshUI()
	if self._costTab then
		local hasCost = #self._costTab > 0

		gohelper.setActive(self.go, hasCost)

		if not hasCost then
			return
		end

		gohelper.CreateObjList(self, self._refreshCostItem, self._costTab, self.go, self._goCostItem)
	end
end

function CollegeResCostComp:_refreshCostItem(goCostItem, costInfo, index)
	local itemId = costInfo[1]
	local itemNum = costInfo[2]

	if self._multRate then
		local total = 0

		for i = 1, #self._multRate do
			total = total + math.floor(itemNum * self._multRate[i])
		end

		itemNum = total
	end

	local imageIcon = gohelper.findChildImage(goCostItem, "#image_Currency")
	local txtCost = gohelper.findChildText(goCostItem, "#txt_Cost")

	txtCost.text = itemNum

	CollegeIconHelper.setItemIcon(itemId, imageIcon)

	local curItemNum = CollegeModel.instance:getItemCount(itemId)
	local isEnough = itemNum <= curItemNum

	if isEnough then
		if not self._enoughColor then
			local txtColor = self._notEnoughColor

			SLFramework.UGUI.GuiHelper.SetColor(txtCost, txtColor)
		end
	end
end

function CollegeResCostComp:hide()
	gohelper.setActive(self.go, false)
end

return CollegeResCostComp
