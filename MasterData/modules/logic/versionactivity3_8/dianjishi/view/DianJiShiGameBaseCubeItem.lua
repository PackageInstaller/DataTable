-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameBaseCubeItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameBaseCubeItem", package.seeall)

local DianJiShiGameBaseCubeItem = class("DianJiShiGameBaseCubeItem", LuaCompBase)

function DianJiShiGameBaseCubeItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DianJiShiGameBaseCubeItem)
end

function DianJiShiGameBaseCubeItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._imageIcon = gohelper.findChildImage(self.go, "image_Icon")
	self._imageFront = gohelper.findChildImage(self.go, "image_Icon/image_Front")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function DianJiShiGameBaseCubeItem:addEventListeners()
	return
end

function DianJiShiGameBaseCubeItem:removeEventListeners()
	return
end

function DianJiShiGameBaseCubeItem:onUpdateMO(cubeInfo, index, blockId, isKeepFrontVisible, putAnim)
	self._cubeInfo = cubeInfo
	self._posIndex = cubeInfo
	self._index = index
	self._blockId = blockId
	self._isKeepVisible = isKeepFrontVisible

	if putAnim then
		self._animator:Play("put", 0, 0)
	end

	self:refreshUI()
end

function DianJiShiGameBaseCubeItem:refreshUI()
	DianJiShiGameController.instance:setCubeIcon(self._blockId, self._posIndex, self._imageIcon, self._imageFront, self._isKeepVisible)
	self:refreshPos()
end

function DianJiShiGameBaseCubeItem:refreshPos()
	if self._posIndex then
		if not self._posIndex[1] then
			local posXIndex = 0

			if self._posIndex then
				if not self._posIndex[2] then
					local posYIndex = 0
					local posX, posY = DianJiShiGameController.instance:posIndex2Pos(posXIndex, posYIndex)

					recthelper.setAnchor(self._tran, posX, posY)
				end
			end
		end
	end
end

return DianJiShiGameBaseCubeItem
