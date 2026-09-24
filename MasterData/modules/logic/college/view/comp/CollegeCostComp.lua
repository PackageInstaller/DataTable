-- chunkname: @modules/logic/college/view/comp/CollegeCostComp.lua

module("modules.logic.college.view.comp.CollegeCostComp", package.seeall)

local CollegeCostComp = class("CollegeCostComp", LuaCompBase)

function CollegeCostComp:addEventListeners()
	CollegeController.instance:registerCallback(CollegeEvent.UpdateBag, self._refreshCost, self)
end

function CollegeCostComp:removeEventListeners()
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateBag, self._refreshCost, self)
end

function CollegeCostComp:setIconAndTxt(icon, txt)
	self._icon = icon
	self._txt = txt
end

function CollegeCostComp:setEnoughGo(enough, lack)
	self._goEnough = enough
	self._goLack = lack
end

function CollegeCostComp:setColor(normalColor, lackColor)
	self._normalColor = normalColor
	self._lackColor = lackColor
end

function CollegeCostComp:isShowCurNum(isShow)
	self._isShowCurNum = isShow
end

function CollegeCostComp:setCost(costStr)
	if not string.nilorempty(costStr) then
		local arr = string.splitToNumber(costStr, ":")

		self.itemCo = lua_college_item.configDict[arr[1]]
		self.needNum = arr[2]
	end

	if not self.itemCo then
		return
	end

	CollegeIconHelper.setItemIcon(self.itemCo.id, self._icon)
	self:_refreshCost()
end

function CollegeCostComp:_refreshCost()
	if not self.itemCo then
		return
	end

	local itemCount = CollegeModel.instance:getItemCount(self.itemCo.id)
	local color = itemCount >= self.needNum and self._normalColor or self._lackColor or "D97373"
	local costStr = ""

	costStr = color and string.format("<color=#%s>%d</color>", color, self.needNum) or self.needNum

	if self._isShowCurNum then
		costStr = string.format("%s/%s", itemCount, costStr)
	end

	self._txt.text = costStr

	gohelper.setActive(self._goEnough, itemCount >= self.needNum)
	gohelper.setActive(self._goLack, itemCount < self.needNum)
end

return CollegeCostComp
