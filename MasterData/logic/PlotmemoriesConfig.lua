-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/config/PlotmemoriesConfig.lua

module("logic.extensions.plotmemories.config.PlotmemoriesConfig", package.seeall)

local PlotmemoriesConfig = class("PlotmemoriesConfig", BaseConfig)

function PlotmemoriesConfig:onInit()
	PlotmemoriesConfig.super.onInit(self)
end

function PlotmemoriesConfig:getNames()
	return {
		"plot_chapter",
		"plot_chapter_son",
		"plot_node",
		"plot_review_prize"
	}
end

function PlotmemoriesConfig:handleConfig(name, content)
	if name == "plot_chapter" then
		self._chapter = content
	elseif name == "plot_chapter_son" then
		self._chapterSon = content
	elseif name == "plot_node" then
		self._node = content
	elseif name == "plot_review_prize" then
		self._prize = content
	end
end

function PlotmemoriesConfig:getChapterById(id)
	return self._chapter[id]
end

function PlotmemoriesConfig:getChapter()
	return self._chapter
end

function PlotmemoriesConfig:getChapterSonById(id)
	return self._chapterSon[id]
end

function PlotmemoriesConfig:getChapterSon()
	return self._chapterSon
end

function PlotmemoriesConfig:getNodeById(id)
	return self._node[id]
end

function PlotmemoriesConfig:getNode()
	return self._node
end

function PlotmemoriesConfig:getPrizeById(id)
	return self._prize[id]
end

function PlotmemoriesConfig:getPrize()
	return self._prize
end

PlotmemoriesConfig.instance = PlotmemoriesConfig.New()

return PlotmemoriesConfig
