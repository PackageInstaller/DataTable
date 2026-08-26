-- chunkname: @modules/logic/rouge/dlc/101/view/RougeResultReViewDLCComp.lua

module("modules.logic.rouge.dlc.101.view.RougeResultReViewDLCComp", package.seeall)

local RougeResultReViewDLCComp = class("RougeResultReViewDLCComp", RougeBaseDLCViewComp)

function RougeResultReViewDLCComp:getSeason()
	if self.viewParam then
		return self.viewParam and self.viewParam.season
	end
end

function RougeResultReViewDLCComp:getVersions()
	if self.viewParam then
		return self.viewParam and self.viewParam:getVersions()
	end
end

return RougeResultReViewDLCComp
