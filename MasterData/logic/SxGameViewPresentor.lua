-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameViewPresentor.lua

module("logic.extensions.sxgame.view.SxGameViewPresentor", package.seeall)

local SxGameViewPresentor = class("SxGameViewPresentor", ViewPresentor)

function SxGameViewPresentor:ctor()
	SxGameViewPresentor.super.ctor(self)
end

function SxGameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SxGameViewPresentor:dependWhatResources()
	return {
		"ui/views/sxgame/sxgameview.prefab",
		"ui/views/sxgame/itemred.prefab",
		"ui/views/sxgame/itemyellow.prefab",
		"ui/views/sxgame/itemgreen.prefab",
		"ui/views/sxgame/itempurple.prefab",
		"ui/views/sxgame/itemflash.prefab",
		"ui/views/sxgame/itembloom.prefab",
		"ui/views/sxgame/itemshuflash.prefab",
		"ui/views/sxgame/itemblue.prefab",
		"ui/views/sxgame/itemforward.prefab",
		"ui/views/sxgame/itemback.prefab",
		"ui/views/sxgame/itemblock.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_amazing.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_combo.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_zhadan.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian_shu.prefab"
	}
end

function SxGameViewPresentor:buildViews()
	local views = {}
	local view = SxGameView.New()

	table.insert(views, view)

	return views
end

function SxGameViewPresentor:getResInstance(path)
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

return SxGameViewPresentor
