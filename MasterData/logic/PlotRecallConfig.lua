-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotrecall/config/PlotRecallConfig.lua

module("logic.extensions.plotcopy.config.PlotRecallConfig", package.seeall)

local PlotRecallConfig = class("PlotRecallConfig", BaseConfig)

function PlotRecallConfig:onInit()
	self._plot_recall = {}
end

function PlotRecallConfig:getNames()
	return {
		"plot_recall"
	}
end

function PlotRecallConfig:handleConfig(name, content)
	if name == "plot_recall" then
		self._plot_recall = content
	end
end

function PlotRecallConfig:getAllCG(progressId, index)
	return self._plot_recall.dataList
end

function PlotRecallConfig:getMobyFuncId(funcId)
	return self._plot_recall[funcId]
end

PlotRecallConfig.instance = PlotRecallConfig.New()

return PlotRecallConfig
