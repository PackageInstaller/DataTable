-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummomGridRecordMO.lua

module("logic.extensions.summontower.model.SummomGridRecordMO", package.seeall)

local SummomGridRecordMO = class("SummomGridRecordMO")

function SummomGridRecordMO:ctor()
	self.gridId = 0
	self.currPets = 0
	self.isReliveSummonMaster = false
end

return SummomGridRecordMO
