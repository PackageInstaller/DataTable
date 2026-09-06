-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TROpPlayerMo.lua

module("logic.extensions.treasureraider.model.mo.TROpPlayerMo", package.seeall)

local TROpPlayerMo = class("TROpPlayerMo", TRPlayerMo)

function TROpPlayerMo:ctor()
	TROpPlayerMo.super.ctor(self)

	self.playerInfo = nil
end

function TROpPlayerMo:updateByServerData(params)
	self.playerInfo = params.headInfo
	self.userName = params.headInfo.userName
	self.userId = params.headInfo.userId
	self.zdl = params.targetZDL

	self:updateMainCampData(params)
end

return TROpPlayerMo
