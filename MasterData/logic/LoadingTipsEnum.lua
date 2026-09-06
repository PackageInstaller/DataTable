-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/config/LoadingTipsEnum.lua

module(..., package.seeall)

local LoadingTipsEnum = {}

LoadingTipsEnum.None = 0
LoadingTipsEnum.City = 1
LoadingTipsEnum.Battle = 2
LoadingTipsEnum.CreateRole = 3

function LoadingTipsEnum.isValid(tipsType)
	return tipsType > 0 and tipsType < 4
end

return LoadingTipsEnum
