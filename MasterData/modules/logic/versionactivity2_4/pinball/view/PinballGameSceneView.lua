-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballGameSceneView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballGameSceneView", package.seeall)

local PinballGameSceneView = class("PinballGameSceneView", BaseView)

function PinballGameSceneView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "mask/#go_root")
	self._goitem = gohelper.findChild(self.viewGO, "mask/#go_root/item")
	self._gotopitem = gohelper.findChild(self.viewGO, "#go_root_top/item")
	self._gonumitem = gohelper.findChild(self.viewGO, "#go_root_num/item")
end

function PinballGameSceneView:onOpen()
	PinballStatHelper.instance:resetGameDt()
	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._gotopitem, false)
	gohelper.setActive(self._gonumitem, false)

	self._layers = self:getUserDataTb_()

	for layer in ipairs(PinballEnum.UnitLayers) do
		self._layers[layer] = gohelper.create2d(self._goroot, "Layer" .. layer)
	end

	PinballEntityMgr.instance:setRoot(self._goitem, self._gotopitem, self._gonumitem, self._layers)
end

function PinballGameSceneView:onClose()
	PinballEntityMgr.instance:clear()
end

return PinballGameSceneView
