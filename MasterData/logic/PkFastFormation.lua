-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkFastFormation.lua

module("logic.extensions.pk.view.PkFastFormation", package.seeall)

local PkFastFormation = class("PkFastFormation", FastFormation)

function PkFastFormation:_getCurFormation()
	return TraincampqiecuoModel.instance:getMyFormation()
end

PkFastFormation.instance = PkFastFormation.New()

return PkFastFormation
