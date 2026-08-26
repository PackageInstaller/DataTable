-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/repairgame/VersionActivity1_8FactoryRepairPieceItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairPieceItem", package.seeall)

local VersionActivity1_8FactoryRepairPieceItem = class("VersionActivity1_8FactoryRepairPieceItem", LuaCompBase)

function VersionActivity1_8FactoryRepairPieceItem:init(go)
	self.viewGO = go
	self._gocontent = gohelper.findChild(self.viewGO, "go_content")
	self._btnContentDrag = SLFramework.UGUI.UIDragListener.Get(self._gocontent)
	self._imageicon = gohelper.findChildImage(self.viewGO, "go_content/image_icon")
	self._txtNum = gohelper.findChildText(self.viewGO, "go_content/image_NumBG/txt_Num")
	self._txtNumZero = gohelper.findChildText(self.viewGO, "go_content/image_NumBG/txt_NumZero")
end

function VersionActivity1_8FactoryRepairPieceItem:setTypeId(typeId)
	self._typeId = typeId
end

function VersionActivity1_8FactoryRepairPieceItem:addEventListeners()
	if self._btnContentDrag then
		self._btnContentDrag:AddDragBeginListener(self._onDragBegin, self)
		self._btnContentDrag:AddDragListener(self._onDragIng, self)
		self._btnContentDrag:AddDragEndListener(self._onDragEnd, self)
	end
end

function VersionActivity1_8FactoryRepairPieceItem:removeEventListeners()
	if self._btnContentDrag then
		self._btnContentDrag:RemoveDragBeginListener()
		self._btnContentDrag:RemoveDragListener()
		self._btnContentDrag:RemoveDragEndListener()
	end
end

function VersionActivity1_8FactoryRepairPieceItem:_onDragBegin(param, pointerEventData)
	self._isStarDrag = false

	local placeNum = self:_getPlaceNum()

	if placeNum > 0 then
		self._isStarDrag = true

		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragBegin, pointerEventData.position, self._typeId, ArmPuzzlePipeEnum.ruleConnect[self._typeId])
	end
end

function VersionActivity1_8FactoryRepairPieceItem:_onDragIng(param, pointerEventData)
	if self._isStarDrag then
		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragIng, pointerEventData.position)
	end
end

function VersionActivity1_8FactoryRepairPieceItem:_onDragEnd(param, pointerEventData)
	if self._isStarDrag then
		self._isStarDrag = false

		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragEnd, pointerEventData.position)
	end
end

function VersionActivity1_8FactoryRepairPieceItem:_getPlaceNum()
	return Activity157RepairGameModel.instance:getPlaceNum(self._typeId)
end

function VersionActivity1_8FactoryRepairPieceItem:refreshUI()
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

function VersionActivity1_8FactoryRepairPieceItem:onDestroy()
	return
end

return VersionActivity1_8FactoryRepairPieceItem
