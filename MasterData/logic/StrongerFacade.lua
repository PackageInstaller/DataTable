-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stronger/facade/StrongerFacade.lua

module("logic.extensions.stronger.facade.StrongerFacade", package.seeall)

local StrongerFacade = class("StrongerFacade")
local strongerFuncId = 26

function StrongerFacade:ctor()
	return
end

function StrongerFacade:openStrongerView(tabIdx, ingoreTips)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(strongerFuncId)

	if cfg and not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		if not ingoreTips then
			FloatWordMgr.instance:show(cfg.lockedTips)
		end

		return
	end

	UIStateManager.instance:push(ViewName.StrongerTabMainView, 4, tabIdx)
end

StrongerFacade.instance = StrongerFacade.New()

return StrongerFacade
