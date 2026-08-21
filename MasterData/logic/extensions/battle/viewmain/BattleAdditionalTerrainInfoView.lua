-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleAdditionalTerrainInfoView.lua

module("logic.extensions.battle.viewmain.BattleAdditionalTerrainInfoView", package.seeall)

local M = class("BattleAdditionalTerrainInfoView", ViewComponent)

function M:buildUI()
	self.mainGO = self:getGoByPath("terrainInformation")
	self._invisibleAmount = SignalAmount.New()
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtTerrainName")
	self._txtRound = goutil.findChildTextComponent(self.mainGO, "txtRound")
	self._txtTimes = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._goTimes = goutil.findChild(self.mainGO, "time")
	self._goRound = goutil.findChild(self.mainGO, "txtRound")
	self._goItemContent = goutil.findChild(self.mainGO, "content")
	self._goItemTemplate = goutil.findChild(self.mainGO, "content/txt_item")
	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)

	goutil.setActive(self._goItemTemplate, false)

	self._itemPool = LocalReusableCollection.New(M.DescriptionItem)
	self._timeWaiter = TimeWaiter.New()
end

function M:destroyUI()
	self._itemPool:clearPool()

	self._itemPool = nil
	self._txtContent = nil
	self._txtRound = nil
	self._txtTimes = nil
	self._goTimes = nil
	self._goRound = nil
	self._goItemContent = nil
	self._goItemTemplate = nil
	self._animation = nil
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
	self._invisibleAmount:clear()
	self._timeWaiter:clear()
end

function M:setVisible(visible, key)
	if visible then
		self._invisibleAmount:remove(key)
	else
		self._invisibleAmount:addUnique(key)
	end

	local isEnable = self._invisibleAmount:isUnactive()

	goutil.setActive(self.mainGO, isEnable)
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnTerrainUpdate, self._onTerrainUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnTerrainRemove, self._onTerrainRemove, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnTerrainUpdate, self._onTerrainUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnTerrainRemove, self._onTerrainRemove, self)
	end
end

function M:_onTerrainUpdate()
	if self._unionIndex then
		self:_updateView(self._unionIndex)
	end
end

function M:_onTerrainRemove()
	if self._unionIndex then
		self:_updateView(self._unionIndex)
	end
end

function M:setUnionIndex(unionIndex)
	self._unionIndex = unionIndex

	if unionIndex then
		self:_updateView(unionIndex)
	end
end

function M:_doOpenAnimation()
	self._timeWaiter:clear()
	self._animation:Play("terraininformation_open")
end

function M:_doCloseAnimation()
	self._invisibleAmount:addUnique()
	self._timeWaiter:clear()
	self._timeWaiter:start(0.1, self._onWaitFinished, self)
	self._animation:Play("terraininformation_close")
end

function M:_onWaitFinished()
	local isEnable = self._invisibleAmount:isUnactive()

	goutil.setActive(self.mainGO, isEnable)
end

function M:_updateView(unionIndex)
	local boardModel = BattleMgr.instance:getBoardModel()
	local cellMO = boardModel:getBoardCellMO(unionIndex)

	if not cellMO:hasAdditionalTerrain() then
		self:_doCloseAnimation()

		return
	end

	self:setVisible(true)
	self:_doOpenAnimation()
	self._itemPool:clearAllInstance()

	local sb = StringBuffer.New()
	local additionalTerrainMO = cellMO:getAdditionalTerrainMO()
	local terrainCO = TerrainConfig.instance:getAdditionalTerrainCO(additionalTerrainMO:getCode())

	self._txtName.text = terrainCO.name

	if additionalTerrainMO:getRound() > 0 then
		self._txtRound.text = additionalTerrainMO:getRound()

		goutil.setActive(self._goRound, true)
	else
		goutil.setActive(self._goRound, false)
	end

	if additionalTerrainMO:getTriggered() > 0 then
		self._txtTimes.text = string.format("可触发%s次", additionalTerrainMO:getTriggered())

		goutil.setActive(self._goTimes, true)
	else
		goutil.setActive(self._goTimes, false)
	end

	local description = terrainCO.description

	if not string.nilorempty(description) then
		local desList = string.split(description, "\r\n")

		for _, des in ipairs(desList) do
			local item = self._itemPool:createInstance(self._goItemTemplate, self._goItemContent)

			item:setVisible(true)
			item:setContent(ActiveSkillCOUtil.replaceDescriptionSpecialColor(des))
		end
	elseif terrainCO.skillCode > 0 then
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(terrainCO.skillCode)
		local item = self._itemPool:createInstance(self._goItemTemplate, self._goItemContent)

		item:setVisible(true)
		item:setContent(skillCOWrapper:getDescription())
	end
end

M.DescriptionItem = class("ToolTipsBattleAdditionalTerrainView_DescriptionItem", UIReusableLuaBehavior)

function M.DescriptionItem:buildUI()
	self._txtDescription = goutil.addComponentOnce(self.mainGO, UIComponentType.Text)
end

function M.DescriptionItem:destroyUI()
	self._txtDescription = nil
end

function M.DescriptionItem:setContent(content)
	self._txtDescription.text = content
end

function M.DescriptionItem:setVisible(visible)
	goutil.setActive(self.mainGO, true)
end

return M
