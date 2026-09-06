-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TRPlayerMo.lua

module("logic.extensions.treasureraider.model.mo.TRPlayerMo", package.seeall)

local TRPlayerMo = class("TRPlayerMo")

function TRPlayerMo:ctor()
	self.userName = ""
	self.userId = 1
	self.mainCampLevel = 0
	self.mainCampExp = 0
end

function TRPlayerMo:updateByServerData(params)
	return
end

function TRPlayerMo:getBirthPos()
	return 1, 1
end

function TRPlayerMo:updateMainCampData(params)
	self.mainCampLevel = params.level
	self.mainCampExp = params.exp
end

return TRPlayerMo
