-- chunkname: @IQIGame\\UIExternalApi\\MazeChapterTipUIApi.lua

MazeChapterTipUIApi = BaseLangApi:Extend()

function MazeChapterTipUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function MazeChapterTipUIApi:GetTitleText(aliasName, name)
	return aliasName .. "·" .. name
end

MazeChapterTipUIApi:Init()
