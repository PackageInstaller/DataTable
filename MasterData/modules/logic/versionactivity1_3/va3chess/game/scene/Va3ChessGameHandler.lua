-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/scene/Va3ChessGameHandler.lua

module("modules.logic.versionactivity1_3.va3chess.game.scene.Va3ChessGameHandler", package.seeall)

local Va3ChessGameHandler = class("Va3ChessGameHandler", BaseView)

function Va3ChessGameHandler:init(viewObj)
	self._viewObj = viewObj
end

function Va3ChessGameHandler:drawBaseTile(x, y)
	local tileData = Va3ChessGameModel.instance:getBaseTile(x, y)
	local tileObj = self._viewObj:getBaseTile(x, y)

	if tileData == Va3ChessEnum.TileBaseType.Normal then
		gohelper.setActive(tileObj.imageTile.gameObject, true)
		UISpriteSetMgr.instance:setVa3ChessMapSprite(tileObj.imageTile, "img_di")
	else
		gohelper.setActive(tileObj.imageTile.gameObject, false)
	end
end

function Va3ChessGameHandler.sortBaseTile(baseTiles)
	local tileSortList = {}

	for _, tileList in pairs(baseTiles) do
		for _, tileObj in pairs(tileList) do
			table.insert(tileSortList, tileObj)
		end
	end

	table.sort(tileSortList, Va3ChessGameHandler.sortTile)

	for i, tileObj in ipairs(tileSortList) do
		tileObj.rect:SetSiblingIndex(i)
	end
end

function Va3ChessGameHandler.sortTile(a, b)
	return a.anchorY > b.anchorY
end

function Va3ChessGameHandler.sortInteractObjects(avatars)
	if not avatars then
		return
	end

	table.sort(avatars, Va3ChessGameHandler.sortObjects)

	for i, avatar in ipairs(avatars) do
		avatar.rect:SetSiblingIndex(i)
	end
end

function Va3ChessGameHandler.sortObjects(a, b)
	if not a.anchorY then
		if not b.anchorY then
			local bAnchorY = 9999999

			if a.anchorY ~= bAnchorY then
				return a.anchorY > b.anchorY
			else
				return (a.order or 0) < (b.order or 0)
			end
		end
	end
end

function Va3ChessGameHandler:dispose()
	self._viewObj = nil
end

return Va3ChessGameHandler
