-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/illusoryemperor/NsopIllusoryEmperorMusicMainView.lua

module("logic.extensions.newsummonpetobtain.view.illusoryemperor.NsopIllusoryEmperorMusicMainView", package.seeall)

local NsopIllusoryEmperorMusicMainView = class("NsopIllusoryEmperorMusicMainView", NsopPlayMusicMainView)

function NsopIllusoryEmperorMusicMainView:_getActivityId()
	return NewSummonPetObtainController.instance:getHuanHuangActivityId()
end

return NsopIllusoryEmperorMusicMainView
