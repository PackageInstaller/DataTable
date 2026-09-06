-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mopup/model/SweepMainPlotMo.lua

module("logic.extensions.mopup.model.SweepMainPlotMo", package.seeall)

local SweepMainPlotMo = class("SweepMainPlotMo", SweepBaseMo)

function SweepMainPlotMo:_initSweepType()
	return MopupModel.MainPlot
end

return SweepMainPlotMo
