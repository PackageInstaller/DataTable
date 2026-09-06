-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/HexagramCell.lua

module("logic.extensions.yirenpozhen.view.HexagramCell", package.seeall)

local HexagramCell = class("HexagramCell")

function HexagramCell:ctor(componetContainer)
	local go = componetContainer

	self._img = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageColorChange)
	self._txt = goutil.findChildTextComponent(go, "Text")
end

function HexagramCell:initCell(cellData)
	self._cellData = cellData

	self._img:SetState(cellData.state - 1)

	self._txt.text = cellData.order
end

return HexagramCell
