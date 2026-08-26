-- chunkname: @modules/logic/gm/controller/asset/AssetItemStatMgr.lua

module("modules.logic.gm.controller.asset.AssetItemStatMgr", package.seeall)

local AssetItemStatMgr = class("AssetItemStatMgr", BaseController)
local resMgr = SLFramework.ResMgr.Instance

function AssetItemStatMgr:start()
	return
end

function AssetItemStatMgr.initReflection()
	if AssetItemStatMgr.initedRef then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type = tolua.findtype("SLFramework.ResMgr")
end

AssetItemStatMgr.instance = AssetItemStatMgr.New()

return AssetItemStatMgr
