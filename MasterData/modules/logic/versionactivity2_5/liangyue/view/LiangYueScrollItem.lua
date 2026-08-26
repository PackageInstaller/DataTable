-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueScrollItem.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueScrollItem", package.seeall)

local LiangYueScrollItem = class("LiangYueScrollItem", LuaCompBase)
local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function LiangYueScrollItem:init(go)
	self._go = go
	self._goTextBg = gohelper.findChild(go, "image_NumBG")
	self._txtNum = gohelper.findChildTextMesh(go, "image_NumBG/#txt_Num")
	self._simage_illustration = gohelper.findChildSingleImage(go, "#image_Piece")
	self._image_illustration = gohelper.findChildImage(go, "#image_Piece")
	self._image_illustrationBg = gohelper.findChildImage(go, "image_PieceBG")
	self._goTarget = gohelper.findChild(go, "TargetIcon")
	self._goLine = gohelper.findChild(go, "#go_Line")
	self._canvasGroup = gohelper.onceAddComponent(self._simage_illustration.gameObject, gohelper.Type_CanvasGroup)

	self:initComp()
end

function LiangYueScrollItem:initComp()
	self._dragListener = SLFramework.UGUI.UIDragListener.Get(self._image_illustrationBg.gameObject)

	self._dragListener:AddDragBeginListener(self._onItemBeginDrag, self)
	self._dragListener:AddDragListener(self._onItemDrag, self)
	self._dragListener:AddDragEndListener(self._onItemEndDrag, self)

	self._iconHeight = recthelper.getHeight(self._simage_illustration.transform)
	self._iconWidth = recthelper.getWidth(self._simage_illustration.transform)

	local comp = LiangYueAttributeItem.New()

	comp:init(self._goTarget)

	self._attributeComp = comp
	self._uiEffectComp = ZProj_UIEffectsCollection.Get(self._image_illustration.gameObject)

	self:setEnoughState(true)

	self._isDrag = false
end

function LiangYueScrollItem:setActive(active)
	gohelper.setActive(self._go, active)
end

function LiangYueScrollItem:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function LiangYueScrollItem:setEnoughState(enough)
	if enough then
		if not LiangYueEnum.ScrollItemColor.Enough then
			local color = LiangYueEnum.ScrollItemColor.NotEnought

			SLFramework.UGUI.GuiHelper.SetColor(self._image_illustration, color)
			self._uiEffectComp:SetGray(not enough)
		end
	end
end

function LiangYueScrollItem:setInfo(id, index, count, imageId, aspect, actId)
	self.id = id
	self.index = index
	self._txtNum.text = count > 0 and tostring(count) or LiangYueEnum.UnlimitedSign

	gohelper.setActive(self._goLine, index % 2 ~= 0)

	local iconName = string.format("v2a5_liangyue_game_piece%s", imageId)

	self._simage_illustration:LoadImage(ResUrl.getV2a5LiangYueImg(iconName))
	self:setAttributeInfo(actId, id)
end

function LiangYueScrollItem:setAttributeInfo(actId, id)
	local data = LiangYueConfig.instance:getIllustrationAttribute(actId, id)

	self._attributeComp:setInfo(data)
end

function LiangYueScrollItem:setParentView(view)
	self.view = view
end

function LiangYueScrollItem:setCount(count)
	self._txtNum.text = tostring(count)
end

function LiangYueScrollItem:_onItemBeginDrag(param, pointerEventData)
	if self._isDrag or self.view._isDrag then
		logNormal("拖动中")

		return
	end

	self._isDrag = true

	self.view:_onItemBeginDrag(param, pointerEventData, self.id)
end

function LiangYueScrollItem:_onItemDrag(param, pointerEventData)
	self.view:_onItemDrag(param, pointerEventData)
end

function LiangYueScrollItem:_onItemEndDrag(param, pointerEventData)
	self._isDrag = false

	self.view:_onItemEndDrag(param, pointerEventData)
end

function LiangYueScrollItem:onDestroy()
	self._dragListener:RemoveDragBeginListener()
	self._dragListener:RemoveDragListener()
	self._dragListener:RemoveDragEndListener()
end

return LiangYueScrollItem
