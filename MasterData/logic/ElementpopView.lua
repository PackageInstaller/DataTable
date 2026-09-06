-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/element/ElementpopView.lua

module("logic.extensions.formation.view.element.ElementpopView", package.seeall)

local ElementpopView = class("ElementpopView", ViewComponent)

function ElementpopView:buildUI()
	ElementpopView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._emptyLeft = self:getGo("left/empty")
	self._tableviewLeft = self:getGo("left/tableview")
	self._tableviewRight = self:getGo("right/tableview2")
	self._emptyRight = self:getGo("right/empty")
	self._cell = self:getGo("item")
	self._summonSkillGo = self:getGo("right/summonSkill")
	self._summonSkillIcon = self:getGo("right/summonSkill/skillIcon")
	self._summonTxtName = self:getTxt("right/summonSkill/txtName")
	self._summonTxtDesc = self:getTxt("right/summonSkill/txtDesc")
	self._goContractSkill = self:getGo("right/contractSkill")
	self._attrIcon = self:getGo("right/contractSkill/Nego_Attr/Img_attr")
	self._leftScrollList = ScrollerList.create(self._tableviewLeft, self._cell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._rightScrollList = ScrollerList.create(self._tableviewRight, self._cell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
end

function ElementpopView:bindEvents()
	ElementpopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ElementpopView:unbindEvents()
	ElementpopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ElementpopView:onEnter()
	ElementpopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._formationMo = params[1]
	self._getPetCallBack = params[2]

	if not self._formationMo then
		self:close()

		return
	end

	self._curMasterId = self._formationMo:GetElementalMasterId()
	self._curTargetId = self._formationMo:GetElementalTargetId()
	self._rcdMasterId = self._curMasterId
	self._rcdTargetId = self._curTargetId

	self:_updateLeftList()
	self:_updateRightList()
end

function ElementpopView:onExit()
	ElementpopView.super.onExit(self)

	self._formationMo = nil

	self:_removeIcons()
	GlobalDispatcher:dispatch(GlobalNotify.FormationHeroSkillChanged)
end

function ElementpopView:_onClickClose()
	self:close()
end

function ElementpopView:_onClickSure()
	if self._formationMo then
		if self._curMasterId ~= self._rcdMasterId then
			self._formationMo:SetElementalMasterId(self._curMasterId)
		end

		if self._curTargetId ~= self._rcdTargetId then
			self._formationMo:SetElementalTargetId(self._curTargetId)
		end
	end

	self:close()
end

function ElementpopView:_updateLeftCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = goutil.findChild(cell, "btn")
	local passed = goutil.findChild(cell, "passed")

	GameUtil.SetActive(passed, false)

	local proxy = MaterialMgr.setCellByMo(data, node)

	goSelect:SetActive(data.petId == self._curMasterId)
	GameUtil.addClickHandler(btnClick, GameUtil.handler(self._onClickLeftBtn, self, data))

	cell.gameObject.name = string.format("elementMasterCell_%s", data.raceId)
end

function ElementpopView:_clearLeftCell(cell)
	local node = goutil.findChild(cell, "node")
	local btnClick = goutil.findChild(cell, "btn")

	MaterialMgr.resetAll(node)
	GameUtil.rmClickHandler(btnClick)

	cell.gameObject.name = "elementMasterCell"
end

function ElementpopView:_updateRightCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = goutil.findChild(cell, "btn")
	local passed = goutil.findChild(cell, "passed")

	GameUtil.addClickHandler(btnClick, GameUtil.handler(self._onClickRightBtn, self, data))

	local proxy = MaterialMgr.setCellByMo(data, node)

	passed:SetActive(data.petId == self._rcdTargetId)
	goSelect:SetActive(data.petId == self._curTargetId)

	cell.gameObject.name = string.format("elementTargetCell_%s", data.raceId)
end

function ElementpopView:_clearRightCell(cell)
	local node = goutil.findChild(cell, "node")
	local btnClick = goutil.findChild(cell, "btn")

	MaterialMgr.resetAll(node)
	GameUtil.rmClickHandler(btnClick)

	cell.gameObject.name = "elementTargetCell"
end

function ElementpopView:_updateLeftList()
	local list = {}
	local limitLv = 0
	local positions = self._formationMo:GetPositions()

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self._formationMo:_getPet(v)

			if petMo and limitLv <= petMo.level and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Element) then
				table.insert(list, petMo)
			end
		end
	end

	self._leftScrollList:reloadData(list)
	GameUtil.SetActive(self._emptyLeft, #list == 0)
end

function ElementpopView:_updateRightList()
	local list = {}
	local limitLv = 0
	local leftList = self._leftScrollList:getData()

	if #leftList > 0 and self._curMasterId > 0 then
		local positions = self._formationMo:GetPositions()

		for i, v in ipairs(positions) do
			if v > 0 then
				local petMo = self._formationMo:_getPet(v)

				if petMo and limitLv <= petMo.level and petMo.petId ~= self._curMasterId then
					table.insert(list, petMo)
				end
			end
		end
	end

	self._rightScrollList:reloadData(list)
	GameUtil.SetActive(self._emptyRight, #list == 0)
	self:updateElementSkill()
end

function ElementpopView:_onClickLeftBtn(data)
	if data.petId == self._curMasterId then
		-- block empty
	else
		self._curMasterId = data.petId
	end

	self._leftScrollList:refresh()
	self:_updateRightList()
end

function ElementpopView:_onClickRightBtn(data)
	self._curTargetId = data.petId == self._curTargetId and 0 or data.petId

	self._rightScrollList:refresh()
end

function ElementpopView:updateElementSkill()
	GameUtil.SetActive(self._summonSkillGo, false)
	GameUtil.SetActive(self._goContractSkill, false)

	if checknumber(self._curMasterId) > 0 then
		local petMo = self._formationMo:_getPet(self._curMasterId)

		if petMo then
			GameUtil.SetActive(self._summonSkillGo, true)
			GameUtil.SetActive(self._goContractSkill, true)

			local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

			race = math.fmod(race, 10)

			local targetValue = race - 1

			GameUtil.setUIImageSpriteIdx(self._attrIcon, targetValue)

			local petCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

			if checknumber(petCfg.elementSkillId) > 0 then
				MaterialMgr.setCell(MatType.Skill, petCfg.elementSkillId, self._summonSkillIcon)

				local cfg = BattleConfig.instance:getSkillCo(petCfg.elementSkillId, petMo.curFaceId)

				if cfg then
					self._summonTxtName.text = cfg.name
					self._summonTxtDesc.text = cfg.desc
				end
			end
		end
	end
end

function ElementpopView:_removeIcons()
	MaterialMgr.resetAll(self._summonSkillIcon)
end

return ElementpopView
