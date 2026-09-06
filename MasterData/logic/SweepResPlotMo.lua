-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mopup/model/SweepResPlotMo.lua

module("logic.extensions.mopup.model.SweepResPlotMo", package.seeall)

local SweepResPlotMo = class("SweepResPlotMo", SweepBaseMo)

function SweepResPlotMo:_initSweepType()
	return MopupModel.ResPlot
end

return SweepResPlotMo
