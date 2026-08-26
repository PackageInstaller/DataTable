-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotGuideDragTip.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotGuideDragTip", package.seeall)

local V1a6_CachotGuideDragTip = class("V1a6_CachotGuideDragTip", BaseView)

function V1a6_CachotGuideDragTip:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotGuideDragTip:_editableInitView()
	local goGuide = gohelper.findChild(self.viewGO, "#guide")

	self._gohand = gohelper.findChild(goGuide, "shou")
	self._guideAnimator = goGuide:GetComponent("Animator")
	self._guideblock = gohelper.findChild(self.viewGO, "guideblock")

	gohelper.setActive(self._guideblock, false)
end

function V1a6_CachotGuideDragTip:onOpen()
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.GuideDragTip, self._guideDragTip, self)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.PlayerMove, self._playerMove, self)
end

function V1a6_CachotGuideDragTip:_playerMove()
	return
end

function V1a6_CachotGuideDragTip:_guideDragTip(param)
	local value = tonumber(param)

	if value == V1a6_CachotEnum.GuideDragTipType.Left then
		gohelper.setActive(self._guideAnimator.gameObject, true)
		gohelper.setActive(self._guideblock, true)
		self._guideAnimator:Play("left")
	elseif value == V1a6_CachotEnum.GuideDragTipType.Right then
		gohelper.setActive(self._guideAnimator.gameObject, true)
		gohelper.setActive(self._guideblock, true)
		self._guideAnimator:Play("right")
	else
		gohelper.setActive(self._guideAnimator.gameObject, false)
		gohelper.setActive(self._guideblock, false)
	end
end

function V1a6_CachotGuideDragTip:isShowDragTip()
	return self._guideblock.activeSelf
end

function V1a6_CachotGuideDragTip:onClose()
	return
end

function V1a6_CachotGuideDragTip:onDestroyView()
	return
end

return V1a6_CachotGuideDragTip
