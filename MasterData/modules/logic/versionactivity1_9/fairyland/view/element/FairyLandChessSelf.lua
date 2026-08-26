-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandChessSelf.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandChessSelf", package.seeall)

local FairyLandChessSelf = class("FairyLandChessSelf", FairyLandElementBase)

function FairyLandChessSelf:getElementId()
	return 0
end

function FairyLandChessSelf:onInitView()
	self.rootGo = gohelper.findChild(self._go, "root")
	self.imgChess = gohelper.findChildImage(self.rootGo, "image_Chess")
	self.goChess = gohelper.findChild(self.rootGo, "image_Chess")
	self.imgChessRoot = gohelper.findChild(self.rootGo, "chessRoot")
	self.animationEvent = self.rootGo:GetComponent(gohelper.Type_AnimationEventWrap)
	self.animator = self.rootGo:GetComponent(typeof(UnityEngine.Animator))

	self.animationEvent:AddEventListener("stair", self._onStairCallback, self)
	self.animationEvent:AddEventListener("finish", self._onMoveFinishCallback, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function FairyLandChessSelf:_onStairCallback()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_role_move)

	self._config.pos = self._config.pos + 1

	FairyLandController.instance:dispatchEvent(FairyLandEvent.DoStairAnim, self._config.pos)
end

function FairyLandChessSelf:_onMoveFinishCallback()
	self._config.pos = FairyLandModel.instance:getStairPos()

	self:updatePos()

	self.animator.enabled = false

	recthelper.setAnchor(self.goChess.transform, 0, -107)

	self._moveing = false

	if FairyLandModel.instance:isFinishFairyLand() then
		StoryController.instance:playStory(100718, nil, FairyLandController.endFairyLandStory)
	end
end

function FairyLandChessSelf:_onOpenView(viewName)
	if viewName == ViewName.StoryFrontView and FairyLandModel.instance:isFinishFairyLand() then
		ViewMgr.instance:closeView(ViewName.FairyLandView)
	end
end

function FairyLandChessSelf:move()
	self.animator.enabled = true

	self.animator:Play("click", 0, 0)

	self._moveing = true
end

function FairyLandChessSelf:isMoveing()
	return self._moveing
end

function FairyLandChessSelf:onFinish()
	return
end

function FairyLandChessSelf:onDestroyElement()
	self.animationEvent:RemoveEventListener("stair")
	self.animationEvent:RemoveEventListener("finish")
end

function FairyLandChessSelf:getClickGO()
	return self.goChess
end

function FairyLandChessSelf:playDialog()
	self.animator.enabled = true

	self.animator:Play("jump", 0, 0)
end

return FairyLandChessSelf
