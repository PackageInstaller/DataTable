-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodGameCopyViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodGameCopyViewPresentor", package.seeall)

local XiuNuoBrotherhoodGameCopyViewPresentor = class("XiuNuoBrotherhoodGameCopyViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodGameCopyViewPresentor:ctor()
	XiuNuoBrotherhoodGameCopyViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodGameCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuNuoBrotherhoodGameCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/xiunuobrotherhoodgamecopyview.prefab",
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

function XiuNuoBrotherhoodGameCopyViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodGameCopyView.New()
	}
end

function XiuNuoBrotherhoodGameCopyViewPresentor:getResInstance(path)
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

return XiuNuoBrotherhoodGameCopyViewPresentor
