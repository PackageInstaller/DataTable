-- chunkname: @IQIGame\\UIExternalApi\\MazeBuffTipsUIApi.lua

MazeBuffTipsUIApi = BaseLangApi:Extend()

function MazeBuffTipsUIApi:Init()
	self:RegisterApi("LeftCountText", self.GetLeftCountText)
end

function MazeBuffTipsUIApi:GetLeftCountText(leftCount)
	if leftCount == -1 then
		return ""
	else
		return tostring(leftCount)
	end
end

MazeBuffTipsUIApi:Init()
