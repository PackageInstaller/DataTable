-- chunkname: @modules/logic/partygame/view/pedalingplaid/PedalingPlaidGameView.lua

module("modules.logic.partygame.view.pedalingplaid.PedalingPlaidGameView", package.seeall)

local PedalingPlaidGameView = class("PedalingPlaidGameView", SceneGameCommonView)

function PedalingPlaidGameView:onInitView()
	self._sceneUi = gohelper.findChild(self.viewGO, "sceneui")

	gohelper.setActive(self._sceneUi, false)
	PedalingPlaidGameView.super.onInitView(self)
end

function PedalingPlaidGameView:viewUpdate()
	if not self._pedalingPlaidSceneUIComp then
		gohelper.setActive(self._sceneUi, true)

		self._pedalingPlaidSceneUIComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._sceneUi, PedalingPlaidSceneUIComp)

		self._pedalingPlaidSceneUIComp:initView()
	end

	self._pedalingPlaidSceneUIComp:updateView()
end

return PedalingPlaidGameView
