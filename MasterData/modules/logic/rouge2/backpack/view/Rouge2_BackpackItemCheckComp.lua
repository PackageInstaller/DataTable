-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackItemCheckComp.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackItemCheckComp", package.seeall)

local Rouge2_BackpackItemCheckComp = class("Rouge2_BackpackItemCheckComp", LuaCompBase)

function Rouge2_BackpackItemCheckComp.Get(goCheck, goScroll)
	local checkComp = MonoHelper.addNoUpdateLuaComOnceToGo(goCheck, Rouge2_BackpackItemCheckComp)

	checkComp.goScroll = goScroll
	checkComp.tranScroll = goScroll.transform

	return checkComp
end

function Rouge2_BackpackItemCheckComp:init(go)
	self.go = go
	self.tran = go.transform
	self._uiCamera = CameraMgr.instance:getUICamera()
end

function Rouge2_BackpackItemCheckComp:check()
	local isFullInView = self:checkIsItemFullInView()

	if isFullInView then
		self:onItemFullInView()
	else
		self:onItemNotFullInView()
	end

	return isFullInView
end

function Rouge2_BackpackItemCheckComp:checkIsItemFullInView()
	ZProj.UGUIHelper.RebuildLayout(self.tran)

	local worldcorners = self.tran:GetWorldCorners()
	local posTL = worldcorners[1]
	local posBR = worldcorners[3]

	return self:checkOnePointInView(posTL) and self:checkOnePointInView(posBR)
end

function Rouge2_BackpackItemCheckComp:checkOnePointInView(cornerPos)
	local screenPosX, screenPosY = recthelper.worldPosToScreenPoint(self._uiCamera, cornerPos.x, cornerPos.y, cornerPos.z)

	return recthelper.screenPosInRect(self.tranScroll, self._uiCamera, screenPosX, screenPosY)
end

function Rouge2_BackpackItemCheckComp:onItemFullInView()
	return
end

function Rouge2_BackpackItemCheckComp:onItemNotFullInView()
	return
end

return Rouge2_BackpackItemCheckComp
