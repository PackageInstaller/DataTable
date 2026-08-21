-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopPathArrow.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopPathArrow", package.seeall)

local M = class("AirWorkShopPathArrow", IAirWorkShopFlowComp)

function M:onInit()
	self._unitSign = false
	self._blockRedCollection = AirWorkGameObjectCollection.New(BattleResourceName.SkillAreaRedSign)
end

function M:onStart()
	self._boardMgr = self.flow.boardMgr or false
	self._resMgr = self.flow.resMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._unitOperator = self.flow.unitOperator
	self._blockSignList = {}
end

function M:onResourceLoaded()
	self:_buildSigns()
end

function M:onClear()
	self:_destroySigns()
	self:_clearBlockCells()

	self._boardMgr = false
	self._resMgr = false
	self._boardModel = false
	self._currentFocusType = false
	self._currentFocusUnit = false
end

function M:_showFocusSign(unionIndex)
	self:_showSign(self._unitSign, unionIndex)
end

function M:removeCurrentFocus()
	self._currentFocusUnit = false
	self._currentFocusType = false

	self:_hideSign(self._unitSign)
end

function M:_hideFocusSign(focusType)
	self:_hideSign(self._unitSign)
end

function M:showFocusSign(unionIndex)
	self:_showFocusSign(unionIndex, BattleEnum.FocusSignType.Focus)
end

function M:hideFocusSign()
	self:_hideFocusSign(BattleEnum.FocusSignType.Operatable)
	self:_hideFocusSign(BattleEnum.FocusSignType.Focus)
end

function M:_showSign(sign, unionIndex)
	goutil.setActive(sign.gameObject, true)

	local position = self._boardMgr:getCellPosition(unionIndex)

	Astral.TransformUtil.SetPos(sign.transform, position.x, BattleConst.YOffsetSign, position.z)
end

function M:_hideSign(sign)
	goutil.setActive(sign.gameObject, false)
end

function M:_buildSigns()
	self._unitSign = self:_createSign(BattleResourceName.UnitSign)

	self:_hideSign(self._unitSign)
	self:hideFocusSign()
end

function M:_destroySigns()
	if self._unitSign then
		goutil.destroy(self._unitSign.gameObject)

		self._unitSign = false
	end

	BattleTableUtil.clearTable(self._blockSignList)
end

function M:_createSign(resPath)
	local resMgr = self._resMgr
	local goSign = resMgr:getInst(resPath)

	BattleGameObjectRootUtil.addToSignsRoot(goSign)

	local boardMO = self._boardModel:getActiveBoardMO()
	local position = boardMO:getInitPosition()

	Astral.TransformUtil.SetPos(goSign.transform, position.x, BattleConst.YOffsetSign, position.z)

	return SpaceX.FocusSign.Get(goSign)
end

function M:_showBlockCell(unionIndex)
	local signsRoot = BattleGameObjectRootUtil.signsRoot
	local position = self._boardMgr:getCellPosition(unionIndex)
	local goSign = self._blockRedCollection:createInstance(signsRoot)
	local effectControl = EffectControl.Get(goSign)

	effectControl:SetPlaySpeed(BattleTime.timeScale)
	Astral.TransformUtil.SetLocalPos(goSign.transform, position.x, position.y + BattleConst.YOffsetSign, position.z)

	self._blockSignList[unionIndex] = goSign
end

function M:_clearBlockCells()
	self._blockRedCollection:clear()
end

function M:hideBlockCells()
	self:_hideBlockCells()
end

function M:_hideBlockCells()
	for i, goSign in pairs(self._blockSignList) do
		self._blockRedCollection:releaseInstance(goSign)
	end

	BattleTableUtil.clearTable(self._blockSignList)
end

function M:updateBlockCells()
	self:_hideBlockCells()

	local tab2UnionIndexEntityIdList = self._boardModel:getAllEntity()

	for tabType, unionIndex2EntityIdList in ipairs(tab2UnionIndexEntityIdList) do
		local isShow = AirWorkShopDefSceneModel.instance:getPreviewSelect(tabType)

		if not isShow and tabType ~= AirWorkShopEnum.TabEnum.Message then
			for unionIndex, entityId in pairs(unionIndex2EntityIdList) do
				self:_showBlockCell(unionIndex)
			end
		end
	end
end

return M
