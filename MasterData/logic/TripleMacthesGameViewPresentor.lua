-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesGameViewPresentor.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesGameViewPresentor", package.seeall)

local TripleMacthesGameViewPresentor = class("TripleMacthesGameViewPresentor", ViewPresentor)

function TripleMacthesGameViewPresentor:ctor()
	TripleMacthesGameViewPresentor.super.ctor(self)
end

function TripleMacthesGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TripleMacthesGameViewPresentor:dependWhatResources()
	return {
		"ui/views/triplemacthesgame/triplemacthesgameview.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_amazing.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_combo.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_zhadan.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian_shu.prefab"
	}
end

function TripleMacthesGameViewPresentor:buildViews()
	return {
		TripleMacthesGameView.New(),
		TripleMacthesGameFramkView.New()
	}
end

function TripleMacthesGameViewPresentor:getResInstance(path)
	local res = self._resDict[path]

	if res then
		local prefab = res:GetMainAsset()

		if prefab then
			local root = ViewMgr.instance:getRoot(self:attachToWhichRoot())

			if root ~= nil then
				return goutil.cloneAndSetParent(prefab, root.transform)
			else
				return goutil.clone(prefab)
			end
		end
	end

	return nil
end

return TripleMacthesGameViewPresentor
