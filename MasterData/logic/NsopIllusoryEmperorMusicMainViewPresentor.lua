-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/illusoryemperor/NsopIllusoryEmperorMusicMainViewPresentor.lua

module("logic.extensions.newsummonpetobtain.view.illusoryemperor.NsopIllusoryEmperorMusicMainViewPresentor", package.seeall)

local NsopIllusoryEmperorMusicMainViewPresentor = class("NsopIllusoryEmperorMusicMainViewPresentor", NsopPlayMusicMainViewPresentor)

function NsopIllusoryEmperorMusicMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newsummonpetobtain/nsopplaymusicmainview.prefab"
	}
end

function NsopIllusoryEmperorMusicMainViewPresentor:buildViews()
	return {
		NsopIllusoryEmperorMusicMainView.New()
	}
end

return NsopIllusoryEmperorMusicMainViewPresentor
