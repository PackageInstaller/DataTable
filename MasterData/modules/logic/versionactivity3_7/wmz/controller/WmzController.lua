-- chunkname: @modules/logic/versionactivity3_7/wmz/controller/WmzController.lua

module("modules.logic.versionactivity3_7.wmz.controller.WmzController", package.seeall)

local WmzController = class("WmzController", Activity220SimpleBaseController)

function WmzController:ctor(...)
	WmzController.super.ctor(self, ...)
end

function WmzController:reInit()
	WmzController.super.reInit(self)
	self:_internal_set_system(WmzSysModel.instance)
	self:_internal_set_battle(WmzBattleModel.instance)
	self.setOnPostHookRestartGame(self, self._cbOnPostHookRestartGame, self)
end

function WmzController:enterLevelViewImpl()
	ViewMgr.instance:openView(ViewName.V3a7_Wmz_LevelView)
end

function WmzController:_cbOnPostHookRestartGame(refFlow)
	refFlow:addWork(GaoSiNiaoWork_OpenView.s_create(ViewName.V3a7_Wmz_GameView))
end

function WmzController:onTrackPassImpl(bFirst)
	self._battle:track_act_WMZ_operation(WmzEnum.OperationType.Pass)
end

WmzController.instance = WmzController.New()

return WmzController
