-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/game/EmptyFloorCell.lua

module("logic.extensions.jumpfloor.view.game.EmptyFloorCell", package.seeall)

local EmptyFloorCell = class("EmptyFloorCell", FloorCell)

function EmptyFloorCell:ctor(luaComponentContainer)
	self._mainGo = luaComponentContainer.gameObject
	self._rootRect = self._mainGo:GetComponent(goutil.Type_RectTransform)
end

function EmptyFloorCell:init(data)
	self._anchoredPosition = self:_getPosByColAndRow(data.col, data.row)
	self._rootRect.anchoredPosition = self._anchoredPosition
end

return EmptyFloorCell
