-- chunkname: @modules/logic/survival/view/rewardinherit/SurvivalRewardInheritNpcItem.lua

module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritNpcItem", package.seeall)

local SurvivalRewardInheritNpcItem = class("SurvivalRewardInheritNpcItem", LuaCompBase)

function SurvivalRewardInheritNpcItem:ctor()
	return
end

function SurvivalRewardInheritNpcItem:init(viewGO)
	self.viewGO = viewGO
	self.go_Container = gohelper.findChild(self.viewGO, "#go_Container")
	self.go_image_Line = gohelper.findChild(self.viewGO, "#go_image_Line")
	self.customItems = {}
end

function SurvivalRewardInheritNpcItem:getItemAnimators()
	local t = {}

	for i, v in ipairs(self.customItems) do
		table.insert(t, v.animGo)
	end

	return t
end

function SurvivalRewardInheritNpcItem:onStart()
	return
end

function SurvivalRewardInheritNpcItem:addEventListeners()
	return
end

function SurvivalRewardInheritNpcItem:removeEventListeners()
	return
end

function SurvivalRewardInheritNpcItem:onDestroy()
	return
end

function SurvivalRewardInheritNpcItem:updateMo(lineData, selectHandbookMo, callBack, callObj)
	local listData = lineData.listData

	self.selectHandbookMo = selectHandbookMo

	local isShowLine = lineData.isShowLine

	self.viewContainer = lineData.viewContainer
	self.lineYOffset = lineData.lineYOffset or 0

	gohelper.setActive(self.go_image_Line, isShowLine)
	recthelper.setAnchorY(self.go_image_Line.transform, self.lineYOffset)

	local resPath = self.viewContainer:getSetting().otherRes.survivalhandbooknpcitem
	local customItemAmount = #self.customItems
	local listLength = #listData

	for i = 1, listLength do
		local survivalHandbookMo = listData[i].survivalHandbookMo
		local isSelect = listData[i].isSelect

		if customItemAmount < i then
			local obj = self.viewContainer:getResInst(resPath, self.go_Container)

			self.customItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalHandbookNpcItem)
		end

		self.customItems[i]:updateMo(survivalHandbookMo)

		if survivalHandbookMo.isUnlock and lineData.isShowCost then
			self.customItems[i]:showExtendCost()
		end

		self.customItems[i]:setClickCallback(callBack, callObj)
		self.customItems[i]:setRewardInherit(isSelect)
		self.customItems[i]:setSelect(self.selectHandbookMo and self:getInheritId(self.selectHandbookMo) == self:getInheritId(survivalHandbookMo))
	end

	for i = listLength + 1, customItemAmount do
		self.customItems[i]:updateMo(nil)
	end
end

function SurvivalRewardInheritNpcItem:getInheritId(survivalHandbookMo)
	return SurvivalRewardInheritModel.instance:getInheritId(survivalHandbookMo)
end

return SurvivalRewardInheritNpcItem
