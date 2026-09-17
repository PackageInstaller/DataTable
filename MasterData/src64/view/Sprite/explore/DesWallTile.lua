local TileSprite = require("view.Sprite.explore.TileSprite")
local DesWallTile = class("DesWallTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)

function DesWallTile:create(arg_2_1)
	local var_2_0 = DesWallTile.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function DesWallTile:triggerEvent(arg_3_1)
	if self.tileInfo.trigger_des_host == 1 then
		self:popTalkSp(self.tileInfo.trigger_des)
	else
		self.parent:popTalkSp(self.tileInfo.trigger_des)
	end

	self.parent.root.touchLock = false
end

return DesWallTile
