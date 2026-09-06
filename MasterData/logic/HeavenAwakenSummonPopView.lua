-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/heavenswakensummon/HeavenAwakenSummonPopView.lua

module("logic.extensions.formation.view.heavenswakensummon.HeavenAwakenSummonPopView", package.seeall)

local HeavenAwakenSummonPopView = class("HeavenAwakenSummonPopView", ViewComponent)

function HeavenAwakenSummonPopView:buildUI()
	HeavenAwakenSummonPopView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tableviewLeft = self:getGo("left/tableview")
	self._tableviewRight = self:getGo("right/tableview")
	self._cell = self:getGo("item")
	self._summonSkillIcon = self:getGo("right/summonSkill/skillIcon")
	self._summonTxtName = self:getTxt("right/summonSkill/txtName")
	self._summonTxtDesc = self:getTxt("right/summonSkill/txtDesc")
	self._leftScrollList = ScrollerList.create(self._tableviewLeft, self._cell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._rightScrollList = ScrollerList.create(self._tableviewRight, self._cell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._emptyGo = self:getGo("right/empty")
end

function HeavenAwakenSummonPopView:bindEvents()
	HeavenAwakenSummonPopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function HeavenAwakenSummonPopView:unbindEvents()
	HeavenAwakenSummonPopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function HeavenAwakenSummonPopView:onEnter()
	HeavenAwakenSummonPopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._formationMo = params[1]
	self._bagPetMos = params[2]
	self._getPetCallBack = params[3]
	self._getPetListCallBack = params[4]

	if not self._formationMo then
		printError("没传阵型啊")

		return
	end

	self._curSummonerMasterId = self._formationMo:GetHeavenAwakenMasterId()
	self._curSummonedPetId = self._formationMo:GetHeavenAwakenSummonPetId()

	self:_updateLeftList()
end

function HeavenAwakenSummonPopView:onExit()
	HeavenAwakenSummonPopView.super.onExit(self)

	self._formationMo = nil

	self:_removeIcons()
end

function HeavenAwakenSummonPopView:_onClickClose()
	self:close()
end

function HeavenAwakenSummonPopView:_onClickSure()
	if self._curSummonerMasterId > 0 and self._curSummonedPetId > 0 and self._formationMo:SetHeavenAwakenSummonPetId(self._curSummonedPetId) or self._formationMo:SetHeavenAwakenSummonPetId(0) then
		GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
	end

	self:_onClickClose()
end

function HeavenAwakenSummonPopView:_onMakeContractRes()
	GlobalDispatcher:dispatch(GlobalNotify.PM_MakeContractRes, self._curSummonerMasterId, self._curSummonedPetId)
	self:_onClickClose()
end

function HeavenAwakenSummonPopView:_updateLeftCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btnClick:AddClickListener(function()
		self:_onClickLeftBtn(data)
	end)

	local petMo = self:_getPetMo(data.summonerId)

	if petMo then
		local proxy = MaterialMgr.setCellByMo(petMo, node)

		if data.isSelect then
			self:_setSummonSkill(petMo.curFaceId)
		end
	end

	goSelect:SetActive(data.summonerId == self._curSummonerMasterId)
end

function HeavenAwakenSummonPopView:_clearLeftCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function HeavenAwakenSummonPopView:_updateRightCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passed = goutil.findChild(cell, "passed")

	btnClick:AddClickListener(function()
		self:_onClickRightBtn(data)
	end)

	local proxy = MaterialMgr.setCellByMo(data.bagPetMo, node)

	passed:SetActive(data.isContract)

	local select = data.bagPetMo:getPetId() == self._curSummonedPetId

	goSelect:SetActive(select)
end

function HeavenAwakenSummonPopView:_clearRightCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function HeavenAwakenSummonPopView:_getPetMo(petId)
	if self._getPetCallBack then
		return GameUtil.callBack(self._getPetCallBack, petId)
	else
		return self._formationMo:_getPet(petId)
	end
end

function HeavenAwakenSummonPopView:_getPetList()
	local bagPetMos = BagPetsController.instance:getFightBagPet()

	return self._getPetListCallBack and GameUtil.callBack(self._getPetListCallBack) or self._bagPetMos
end

function HeavenAwakenSummonPopView:_updateLeftList()
	local list = {}
	local positions = self._formationMo:GetPositions()
	local selectIndex = 1
	local count = 0

	self:_setSummonerId(0)

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self._formationMo:_getPet(v)

			if petMo and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Tianjue) then
				count = count + 1

				local element = {}

				element.index = count
				element.summonerId = v
				element.isSelect = false

				if count == 1 then
					self:_setSummonerId(v)
				end

				if self._formationMo:GetHeavenAwakenSummonPetId() == petMo.petId then
					selectIndex = count

					self:_setSummonerId(v)
				end

				table.insert(list, element)
			end
		end
	end

	if selectIndex <= #list then
		list[selectIndex].isSelect = true
	end

	self._leftScrollList:reloadData(list)
	self:_updateRightList()
end

function HeavenAwakenSummonPopView:_updateRightList()
	local list = {}
	local bagPetMos = self:_getPetList()
	local summonPetRaceIdKv

	if self._curSummonerMasterId > 0 then
		local petMo = self:_getPetMo(self._curSummonerMasterId)

		summonPetRaceIdKv = ContractConfig.instance:getHeavenAwakenSummonCfgs(petMo.raceId)
	end

	if summonPetRaceIdKv and #bagPetMos > 0 then
		for i, v in ipairs(bagPetMos) do
			if summonPetRaceIdKv[v.raceId] and v.isMyPackPet then
				local selectIndex = 1
				local count = 0

				count = count + 1

				local element = {}

				element.index = count
				element.bagPetMo = v
				element.isSelect = false
				element.isContract = false

				if self._curSummonedPetId == v:getPetId() then
					selectIndex = count
					element.isContract = true
					element.isSelect = true
				end

				table.insert(list, element)
			end
		end
	end

	self._rightScrollList:reloadData(list)
	goutil.setActive(self._emptyGo, #list <= 0)
end

function HeavenAwakenSummonPopView:_onClickLeftBtn(data)
	if data.isSelect then
		return
	end

	self:_setSummonerId(data.summonerId)
	self:_updateLeftSelect(data.index)
	self:_updateRightList(data.summonerId)
end

function HeavenAwakenSummonPopView:_updateLeftSelect(newSelectIndex)
	for i, v in ipairs(self._leftScrollList:getData()) do
		if v.isSelect and v.index ~= newSelectIndex then
			v.isSelect = false

			self._leftScrollList:getView():UpdateCellAtIndex(i - 1)
		end

		if v.index == newSelectIndex then
			v.isSelect = true

			self._leftScrollList:getView():UpdateCellAtIndex(i - 1)
		end
	end
end

function HeavenAwakenSummonPopView:_onClickRightBtn(data)
	if data.bagPetMo:getPetId() == self._curSummonedPetId then
		self:_setSummonedPetId(0)

		for i, v in ipairs(self._rightScrollList:getData()) do
			if v.isSelect then
				v.isSelect = false

				self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
			end
		end
	else
		self:_setSummonedPetId(data.bagPetMo:getPetId())
		self:_updateRightSelect(data.index)
	end
end

function HeavenAwakenSummonPopView:_updateRightSelect(newSelectIndex)
	for i, v in ipairs(self._rightScrollList:getData()) do
		if v.isSelect and v.index ~= newSelectIndex then
			v.isSelect = false

			self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
		end

		if v.index == newSelectIndex then
			v.isSelect = true

			self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
		end
	end
end

function HeavenAwakenSummonPopView:_setSummonSkill(raceId)
	local petCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

	if checknumber(petCfg.heavenAwakenSkillId) > 0 then
		MaterialMgr.setCell(MatType.Skill, petCfg.heavenAwakenSkillId, self._summonSkillIcon)

		local cfg = BattleConfig.instance:getSkillCo(petCfg.heavenAwakenSkillId, raceId)

		if cfg then
			self._summonTxtName.text = cfg.name
			self._summonTxtDesc.text = cfg.desc
		end
	end
end

function HeavenAwakenSummonPopView:_removeIcons()
	MaterialMgr.resetAll(self._summonSkillIcon)
end

function HeavenAwakenSummonPopView:_setSummonerId(id)
	self._curSummonerMasterId = id

	self._formationMo:SetHeavenAwakenMasterId(id)
end

function HeavenAwakenSummonPopView:_setSummonedPetId(id)
	self._curSummonedPetId = id
end

return HeavenAwakenSummonPopView
