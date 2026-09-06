-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/MiracleHeroAttrCellMO.lua

module("logic.extensions.miraclehero.model.MiracleHeroAttrCellMO", package.seeall)

local MiracleHeroAttrCellMO = class("MiracleHeroAttrCellMO")

function MiracleHeroAttrCellMO:ctor()
	self.type = 0
	self.x = 0
	self.y = 0
end

function MiracleHeroAttrCellMO:checkSamePos(mo)
	return self.x == mo.x and self.y == mo.y
end

return MiracleHeroAttrCellMO
