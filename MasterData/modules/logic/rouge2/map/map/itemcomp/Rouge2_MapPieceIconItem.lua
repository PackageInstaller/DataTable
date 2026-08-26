-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapPieceIconItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapPieceIconItem", package.seeall)

local Rouge2_MapPieceIconItem = class("Rouge2_MapPieceIconItem", LuaCompBase)

function Rouge2_MapPieceIconItem:ctor(tranHeadContainer)
	self._tranHeadContainer = tranHeadContainer
end

function Rouge2_MapPieceIconItem:init(go)
	self.go = go
	self.tran = self.go.transform
	self._goRoot = gohelper.findChild(self.go, "#go_Root")
	self._imageIconBg = gohelper.findChildImage(self.go, "#go_Root/#image_iconbg")
	self._imageIcon = gohelper.findChildImage(self.go, "#go_Root/#image_icon")

	gohelper.setActive(self.go, false)

	self._mapPos = Vector3()
	self._iconPos = Vector3()
	self._mainCamera = CameraMgr.instance:getMainCamera()

	self:setVisible(false)
end

function Rouge2_MapPieceIconItem:show(pieceCo, pieceItem)
	self:setVisible(true)

	local bgName = Rouge2_MapEnum.PieceIconBg[pieceCo.entrustType]
	local iconName = Rouge2_MapEnum.PieceIcon[pieceCo.entrustType]

	if not string.nilorempty(bgName) and not string.nilorempty(iconName) then
		UISpriteSetMgr.instance:setRouge6Sprite(self._imageIconBg, bgName, true)
		UISpriteSetMgr.instance:setRouge6Sprite(self._imageIcon, iconName, true)
	else
		logError(string.format("棋子图标配置不存在 pieceId = %s, entrustType = %s", pieceCo.id, pieceCo.entrustType))
	end

	local x, y, z = pieceItem:getMapPos()

	self._mapPos:Set(x, y, z)
	self._iconPos:Set(x + Rouge2_MapEnum.PieceIconOffset.x, y + Rouge2_MapEnum.PieceIconOffset.y, z)

	local posX, posY = recthelper.worldPosToAnchorPos2(self._iconPos, self._tranHeadContainer, self._mainCamera, self._mainCamera)

	recthelper.setAnchor(self.tran, posX, posY)
end

function Rouge2_MapPieceIconItem:setVisible(isVisible)
	gohelper.setActive(self.go, isVisible)
end

return Rouge2_MapPieceIconItem
