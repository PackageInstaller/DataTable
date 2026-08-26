-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmPuzzlePipePieceItem.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipePieceItem", package.seeall)

local ArmPuzzlePipePieceItem = class("ArmPuzzlePipePieceItem", LuaCompBase)

function ArmPuzzlePipePieceItem:init(go)
	self.viewGO = go
	self._gocontent = gohelper.findChild(self.viewGO, "go_content")
	self._imageicon = gohelper.findChildImage(self.viewGO, "go_content/image_icon")
	self._txtNum = gohelper.findChildText(self.viewGO, "go_content/image_NumBG/txt_Num")
	self._txtNumZero = gohelper.findChildText(self.viewGO, "go_content/image_NumBG/txt_NumZero")

	self:_editableInitView()
end

function ArmPuzzlePipePieceItem:addEventListeners()
	if self._btnUIdrag then
		self._btnUIdrag:AddDragBeginListener(self._onDragBegin, self)
		self._btnUIdrag:AddDragListener(self._onDragIng, self)
		self._btnUIdrag:AddDragEndListener(self._onDragEnd, self)
	end
end

function ArmPuzzlePipePieceItem:removeEventListeners()
	if self._btnUIdrag then
		self._btnUIdrag:RemoveDragBeginListener()
		self._btnUIdrag:RemoveDragListener()
		self._btnUIdrag:RemoveDragEndListener()
	end
end

function ArmPuzzlePipePieceItem:onStart()
	return
end

function ArmPuzzlePipePieceItem:onDestroy()
	return
end

function ArmPuzzlePipePieceItem:_editableInitView()
	self._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(self._gocontent)
end

function ArmPuzzlePipePieceItem:_onDragBegin(param, pointerEventData)
	self._isStarDrag = false

	if self:_getPlaceNum() > 0 then
		self._isStarDrag = true

		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragBegin, pointerEventData.position, self._typeId, ArmPuzzlePipeEnum.ruleConnect[self._typeId])
	end
end

function ArmPuzzlePipePieceItem:_onDragIng(param, pointerEventData)
	if self._isStarDrag then
		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragIng, pointerEventData.position)
	end
end

function ArmPuzzlePipePieceItem:_onDragEnd(param, pointerEventData)
	if self._isStarDrag then
		self._isStarDrag = false

		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragEnd, pointerEventData.position)
	end
end

function ArmPuzzlePipePieceItem:setTypeId(typeId)
	self._typeId = typeId
end

function ArmPuzzlePipePieceItem:initItem(mo)
	return
end

function ArmPuzzlePipePieceItem:_getPlaceNum()
	return ArmPuzzlePipeModel.instance:getPlaceNum(self._typeId)
end

function ArmPuzzlePipePieceItem:refreshUI()
	local num = self:_getPlaceNum()
	local isZero = num <= 0

	if not isZero then
		self._txtNum.text = num
	else
		self._txtNumZero.text = num
	end

	if isZero then
		if not ArmPuzzlePipeEnum.UIDragEmptyRes[self._typeId] then
			local resName = ArmPuzzlePipeEnum.UIDragRes[self._typeId]

			UISpriteSetMgr.instance:setArmPipeSprite(self._imageicon, resName, true)

			if self._isLastZero ~= isZero then
				self._isLastZero = isZero

				gohelper.setActive(self._txtNum, not isZero)
				gohelper.setActive(self._txtNumZero, isZero)
			end
		end
	end
end

return ArmPuzzlePipePieceItem
