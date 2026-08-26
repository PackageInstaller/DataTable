-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameShadowItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameShadowItem", package.seeall)

local DianJiShiGameShadowItem = class("DianJiShiGameShadowItem", LuaCompBase)

function DianJiShiGameShadowItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._imageShadow = gohelper.findChildImage(self.go, "image_Shadow")
end

function DianJiShiGameShadowItem:addEventListeners()
	return
end

function DianJiShiGameShadowItem:removeEventListeners()
	return
end

function DianJiShiGameShadowItem:onUpdateMO(shadowInfo, index)
	self._shadowInfo = shadowInfo
	self._index = index

	self:refreshUI()
end

function DianJiShiGameShadowItem:refreshUI()
	if self._shadowInfo then
		local posXIndex = self._shadowInfo.posXIndex

		if self._shadowInfo then
			local posYIndex = self._shadowInfo.posYIndex
			local posX, posY = DianJiShiGameController.instance:posIndex2Pos(posXIndex, posYIndex, true)

			recthelper.setAnchor(self._tran, posX, posY)

			if self._shadowInfo then
				local shadowType = self._shadowInfo.type
				local iconName = DianJiShiGameEnum.ShadowIcon[shadowType]

				UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageShadow, iconName, true)
			end
		end
	end
end

return DianJiShiGameShadowItem
