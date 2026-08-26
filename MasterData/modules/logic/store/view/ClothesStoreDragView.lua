-- chunkname: @modules/logic/store/view/ClothesStoreDragView.lua

module("modules.logic.store.view.ClothesStoreDragView", package.seeall)

local ClothesStoreDragView = class("ClothesStoreDragView", BaseView)

function ClothesStoreDragView:onInitView()
	self._goskincontainer = gohelper.findChild(self.viewGO, "#go_has/character/bg/characterSpine/#go_skincontainer")
	self._skincontainerCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_has/character/bg/characterSpine/#go_skincontainer", typeof(UnityEngine.CanvasGroup))

	local goDrag = gohelper.findChild(self.viewGO, "#go_has/drag")

	gohelper.setActive(goDrag, true)

	self._drag = SLFramework.UGUI.UIDragListener.Get(goDrag)

	self._drag:AddDragBeginListener(self._onViewDragBegin, self)
	self._drag:AddDragListener(self._onViewDrag, self)
	self._drag:AddDragEndListener(self._onViewDragEnd, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ClothesStoreDragView:addEvents()
	return
end

function ClothesStoreDragView:removeEvents()
	return
end

function ClothesStoreDragView:_onViewDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x

	self._animator:Play("switchout", 0, 0)
	self:setShaderKeyWord(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function ClothesStoreDragView:_onViewDrag(param, pointerEventData)
	local curPos = pointerEventData.position.x
	local moveSmooth = 1
	local curSpineRootPosX = recthelper.getAnchorX(self._goskincontainer.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * moveSmooth

	recthelper.setAnchorX(self._goskincontainer.transform, curSpineRootPosX)

	local alphaSmooth = 0.007

	self._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(self._startPos - curPos) * alphaSmooth
end

function ClothesStoreDragView:_onViewDragEnd(param, pointerEventData)
	local curSkinIndex = StoreClothesGoodsItemListModel.instance:getSelectIndex()
	local skinCount = StoreClothesGoodsItemListModel.instance:getCount()
	local endPos = pointerEventData.position.x
	local newSelectSkinIndex

	if endPos > self._startPos and endPos - self._startPos >= 100 then
		newSelectSkinIndex = curSkinIndex - 1

		if curSkinIndex - 1 == 0 then
			newSelectSkinIndex = skinCount
		end
	elseif endPos < self._startPos and self._startPos - endPos >= 100 then
		newSelectSkinIndex = curSkinIndex + 1

		if skinCount < curSkinIndex + 1 then
			newSelectSkinIndex = 1
		end
	end

	self._skincontainerCanvasGroup.alpha = 1

	self:setShaderKeyWord(true)
	TaskDispatcher.cancelTask(self.disAbleShader, self)
	TaskDispatcher.runDelay(self.disAbleShader, self, 0.33)

	if newSelectSkinIndex and newSelectSkinIndex ~= curSkinIndex then
		StoreClothesGoodsItemListModel.instance:setSelectIndex(newSelectSkinIndex, true)
	else
		recthelper.setAnchor(self._goskincontainer.transform, 0, 0)
		self._animator:Play("switchin", 0, 0)
	end
end

function ClothesStoreDragView:onOpen()
	return
end

function ClothesStoreDragView:setShaderKeyWord(enable)
	if enable then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function ClothesStoreDragView:disAbleShader()
	self:setShaderKeyWord(false)
end

function ClothesStoreDragView:onClose()
	TaskDispatcher.cancelTask(self.disAbleShader, self)
end

function ClothesStoreDragView:onDestroyView()
	TaskDispatcher.cancelTask(self.disAbleShader, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
		self._drag:RemoveDragListener()
	end
end

return ClothesStoreDragView
