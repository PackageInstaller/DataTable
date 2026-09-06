-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/ItemBuryUnit.lua

module("logic.extensions.burygame.view.ItemBuryUnit", package.seeall)

local ItemBuryUnit = class("ItemBuryUnit")

function ItemBuryUnit:ctor()
	self._sg = nil
end

function ItemBuryUnit:onPause()
	if self._sg then
		self._sg.timeScale = 0
	end
end

function ItemBuryUnit:onResume()
	if self._sg then
		self._sg.timeScale = 1
	end
end

return ItemBuryUnit
