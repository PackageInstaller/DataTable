-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameBaseBlockItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameBaseBlockItem", package.seeall)

local DianJiShiGameBaseBlockItem = class("DianJiShiGameBaseBlockItem", LuaCompBase)

function DianJiShiGameBaseBlockItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DianJiShiGameBaseBlockItem)
end

function DianJiShiGameBaseBlockItem:init(go)
	self.go = go
	self._goCubeArea = gohelper.findChild(self.go, "go_CubeArea")
	self._goCubeItem = gohelper.findChild(self.go, "go_CubeArea/go_CubeItem")
	self._goTag = gohelper.findChild(self.go, "go_Tag")
	self._goValue = gohelper.findChild(self.go, "go_Tag/go_Value")
	self._txtValue = gohelper.findChildText(self.go, "go_Tag/go_Value/txt_Value")
	self._tranTag = self._goTag.transform

	gohelper.setActive(self.go, true)
end

function DianJiShiGameBaseBlockItem:addEventListeners()
	return
end

function DianJiShiGameBaseBlockItem:removeEventListeners()
	return
end

function DianJiShiGameBaseBlockItem:onUpdateMO(blockInfo, putAnim)
	self._blockInfo = blockInfo
	self._blockCo = self._blockInfo and self._blockInfo.config

	if self._blockInfo then
		self._cubeList = self._blockInfo.cubeList or {}
	end

	self._putAnim = putAnim

	self:_calcBlockSize()
	self:refreshUI()
end

function DianJiShiGameBaseBlockItem:refreshUI()
	if self._blockCo then
		self._txtValue.text = self._blockCo.value or 0
	end

	gohelper.CreateObjList(self, self._refreshCubeItem, self._cubeList, self._goCubeArea, self._goCubeItem, DianJiShiGameBaseCubeItem)
end

function DianJiShiGameBaseBlockItem:_refreshCubeItem(cubeItem, cubeInfo, index)
	cubeItem:onUpdateMO(cubeInfo, index, self._blockInfo.id, self._isKeepVisible, self._putAnim)
end

function DianJiShiGameBaseBlockItem:_calcBlockSize()
	self._minCubeXIndex, self._minCubeYIndex = 100, 100
	self._maxCubeXIndex, self._maxCubeYIndex = -100, -100

	if not self._cubeList then
		return
	end

	for _, cubeInfo in ipairs(self._cubeList) do
		local cubeXIndex = cubeInfo[1]
		local cubeYIndex = cubeInfo[2]

		self._minCubeXIndex, self._maxCubeXIndex = DianJiShiGameController.instance:calcMinAndMaxValue(cubeXIndex, self._minCubeXIndex, self._maxCubeXIndex)
		self._minCubeYIndex, self._maxCubeYIndex = DianJiShiGameController.instance:calcMinAndMaxValue(cubeYIndex, self._minCubeYIndex, self._maxCubeYIndex)
	end

	self._blockWidth = self._maxCubeXIndex - self._minCubeXIndex + 1
	self._blockHight = self._maxCubeYIndex - self._minCubeYIndex + 1
	self._blockWidth = math.max(self._blockWidth, self._blockWidth, 1)
	self._blockHight = math.max(self._blockHight, self._blockHight, 1)
end

function DianJiShiGameBaseBlockItem:getBlockSize()
	return self._blockWidth, self._blockHight
end

function DianJiShiGameBaseBlockItem:keepFrontIconVisible(isVisible)
	self._isKeepVisible = isVisible
end

function DianJiShiGameBaseBlockItem:setTagScale(scaleX, scaleY)
	transformhelper.setLocalScale(self._tranTag, scaleX or 1, scaleY or 1, 1)
end

return DianJiShiGameBaseBlockItem
