-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodGameViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodGameViewPresentor", package.seeall)

local XiuNuoBrotherhoodGameViewPresentor = class("XiuNuoBrotherhoodGameViewPresentor", ViewPresentor)

XiuNuoBrotherhoodGameViewPresentor.BaseResPaths = {
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

function XiuNuoBrotherhoodGameViewPresentor:ctor()
	XiuNuoBrotherhoodGameViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuNuoBrotherhoodGameViewPresentor:dependWhatResources()
	local resources = {
		"ui/views/xiunuobrotherhood/xiunuobrotherhoodgameview.prefab"
	}

	table.insertto(resources, XiuNuoBrotherhoodGameViewPresentor.BaseResPaths)

	return resources
end

function XiuNuoBrotherhoodGameViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodGameView.New()
	}
end

function XiuNuoBrotherhoodGameViewPresentor:getResInstance(path)
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

return XiuNuoBrotherhoodGameViewPresentor
