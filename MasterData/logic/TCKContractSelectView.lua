-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKContractSelectView.lua

module("logic.extensions.teenchampionking.view.TCKContractSelectView", package.seeall)

local TCKContractSelectView = class("TCKContractSelectView", ViewComponent)

function TCKContractSelectView:ctor()
	TCKContractSelectView.super.ctor(self)
end

local localDataKey = "CustomSummonPopSelectView_filter_key"

function TCKContractSelectView:unbindEvents()
	TCKContractSelectView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	GameUtil.rmClickHandler(self._btnFilter)
end

function TCKContractSelectView:bindEvents()
	TCKContractSelectView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
end

function TCKContractSelectView:buildUI()
	TCKContractSelectView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tableviewLeft = self:getGo("left/tableview")
	self._tableviewRight = self:getGo("right/tableview")
	self._cell = self:getGo("item")
	self._summonSkillIcon = self:getGo("right/summonSkill/skillIcon")
	self._summonTxtName = self:getTxt("right/summonSkill/txtName")
	self._summonTxtDesc = self:getTxt("right/summonSkill/txtDesc")
	self._goContractSkill = self:getGo("right/contractSkill")
	self._contractSkillIcon = self:getGo("right/contractSkill/skillIcon")
	self._contractTxtName = self:getTxt("right/contractSkill/txtName")
	self._contractTxtDesc = self:getTxt("right/contractSkill/txtDesc")
	self._leftScrollList = ScrollerList.create(self._tableviewLeft, self._cell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._rightScrollList = ScrollerList.create(self._tableviewRight, self._cell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._txtSure = self:getTxt("btnSure/Text")
	self._btnFilter = self:getGo("right/btnFilter")
	self._imgSelect = self:getGo("right/btnFilter/imgSelect")

	GameUtil.SetActive(self._btnFilter, true)
end

function TCKContractSelectView:onExit()
	TCKContractSelectView.super.onExit(self)
	self:_removeIcons()
end

function TCKContractSelectView:onEnter()
	TCKContractSelectView.super.onEnter(self)

	local params = self:getOpenParam()

	self.masterPetMoList = params[1]
	self.allPetList = params[2]
	self._curSummonMasterMo = params[3]
	self.limitLv = params[4] or 0
	self._currFmtSummonPetId = checknumber(params[5])
	self._isChanged = false
	self._curSummonedPetMo = nil
	self._curSummonedPetId = self._currFmtSummonPetId
	self._currFmtMasterPetId = 0

	if self._curSummonMasterMo then
		self._currFmtMasterPetId = self._curSummonMasterMo.petId
	end

	self._isFilter = GameUtil.getUserData(localDataKey) or false

	goutil.setActive(self._imgSelect, self._isFilter)

	if self._curSummonMasterMo then
		self:_setSummonMasterPetMo(self._curSummonMasterMo)
	elseif self.masterPetMoList then
		self:_setSummonMasterPetMo(self.masterPetMoList[1])
	end

	self:_setContractSkill(nil)
	self:_updateLeftList()
end

function TCKContractSelectView:_onClickClose()
	self:close()
end

function TCKContractSelectView:_onClickSure()
	if self._isChanged then
		GlobalDispatcher:dispatch(GlobalNotify.PM_TCKChangeConract, self._curSummonerMasterId, self._curSummonedPetId)
		self:_onClickClose()
	else
		self:_onClickClose()
	end
end

function TCKContractSelectView:_onClickFilter()
	self._isFilter = not self._isFilter

	GameUtil.saveUserData(localDataKey, self._isFilter)
	goutil.setActive(self._imgSelect, self._isFilter)
	self:_updateRightList(self._curSummonerMasterId)
end

function TCKContractSelectView:_updateLeftCell(view, cell, petMo)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btnClick:AddClickListener(function()
		self:_onClickLeftBtn(petMo)
	end)

	local proxy = MaterialMgr.setCellByMo(petMo, node)

	goSelect:SetActive(petMo.petId == self._curSummonerMasterId)
end

function TCKContractSelectView:_clearLeftCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function TCKContractSelectView:_updateRightCell(view, cell, bagPetMo)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passed = goutil.findChild(cell, "passed")

	btnClick:AddClickListener(function()
		if self._curSummonedPetMo == bagPetMo then
			self:_setSummonedPetId(nil)
		else
			self:_setSummonedPetId(bagPetMo)
		end

		self._rightScrollList:refresh()

		self._isChanged = self._currFmtSummonPetId ~= self._curSummonedPetId

		self:_refreshTxt()
	end)

	local proxy = MaterialMgr.setCellByMo(bagPetMo, node)
	local isContract = bagPetMo.petId == self._currFmtSummonPetId

	passed:SetActive(isContract)

	local select = bagPetMo.petId == self._curSummonedPetId

	goSelect:SetActive(select)
end

function TCKContractSelectView:_clearRightCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function TCKContractSelectView:_updateLeftList()
	self._leftScrollList:reloadData(self.masterPetMoList)
	self:_updateRightList(self._curSummonerMasterId)
end

function TCKContractSelectView:_updateRightList(summonerId)
	self:_setContractSkill(nil)

	local list = {}
	local masterPetMo = self._curSummonMasterMo

	if self._curSummonMasterMo.isMyPackPet then
		local cfgList = {}

		if masterPetMo then
			cfgList = ContractConfig.instance:getSummonBySummonMasterId(masterPetMo.raceId)
		end

		if #cfgList > 0 then
			local map = {}

			for i, v in ipairs(cfgList) do
				map[v.summonRaceId] = true
			end

			local petList = {}

			for i, v in ipairs(self.allPetList or {}) do
				table.insert(petList, v)
			end

			ArraySort.sortOn(petList, {
				"raceId",
				function(x)
					return (x:getFightingPower())
				end,
				"petId"
			}, {
				ArraySort.NUMERIC,
				ArraySort.DESCENDING,
				ArraySort.NUMERIC
			})

			local bagPetMos = petList

			if self._isFilter then
				bagPetMos = {}

				local tem = {}

				for i, v in ipairs(petList) do
					if tem[v.raceId] == nil then
						tem[v.raceId] = true

						table.insert(bagPetMos, v)
					end
				end
			end

			for k, mo in pairs(bagPetMos) do
				if map[mo.raceId] and mo.level >= self.limitLv and mo.isMyPackPet then
					table.insert(list, mo)

					if mo.petId == self._curSummonedPetId then
						self:_setSummonedPetId(mo)
					end
				end
			end
		end
	elseif not self.allPetList then
		local bagPetMos = {}

		for k, mo in pairs(bagPetMos) do
			if mo.petId == checknumber(masterPetMo.summonedPetId) or masterPetMo.petId == checknumber(mo.summonMasterId) then
				table.insert(list, mo)

				if mo.petId == self._curSummonedPetId then
					self:_setSummonedPetId(mo)
				end
			end
		end
	end

	self._rightScrollList:reloadData(list)
	self:_refreshTxt()
end

function TCKContractSelectView:_onClickLeftBtn(petMo)
	if petMo.petId == self._curSummonerMasterId then
		return
	end

	self:_setSummonMasterPetMo(petMo)
	self._leftScrollList:refresh()
	self:_updateRightList(petMo.petId)
end

function TCKContractSelectView:_setSummonSkill(raceId)
	local petCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

	if petCfg and checknumber(petCfg.summonSkillId) > 0 then
		MaterialMgr.setCell(MatType.Skill, petCfg.summonSkillId, self._summonSkillIcon)

		local cfg = BattleConfig.instance:getSkillCo(petCfg.summonSkillId, raceId)

		if cfg then
			self._summonTxtName.text = cfg.name
			self._summonTxtDesc.text = cfg.desc
		end
	end
end

function TCKContractSelectView:_setContractSkill(petMo)
	self._contractTxtName.text = ""
	self._contractTxtDesc.text = ""

	MaterialMgr.resetAll(self._contractSkillIcon)
	GameUtil.SetActive(self._goContractSkill, false)

	local skillId = 0

	if petMo then
		skillId = petMo.contractSkillId

		if petMo.contractSkillId > 0 then
			GameUtil.SetActive(self._goContractSkill, true)
			MaterialMgr.setCell(MatType.Skill, skillId, self._contractSkillIcon)

			local cfg = BattleConfig.instance:getSkillCo(skillId, petMo.curFaceId)

			if cfg then
				self._contractTxtName.text = cfg.name
				self._contractTxtDesc.text = cfg.desc
			end
		end
	end
end

function TCKContractSelectView:_removeIcons()
	MaterialMgr.resetAll(self._summonSkillIcon)
	MaterialMgr.resetAll(self._contractSkillIcon)
end

function TCKContractSelectView:_setSummonMasterPetMo(petMo)
	self._curSummonMasterMo = petMo
	self._curSummonerMasterId = 0

	if petMo then
		self._curSummonerMasterId = petMo.petId

		self:_setSummonSkill(petMo.curFaceId)
	end
end

function TCKContractSelectView:_setSummonedPetId(petMo)
	self._curSummonedPetId = 0

	if petMo then
		self._curSummonedPetId = petMo.petId
	end

	self._curSummonedPetMo = petMo

	self:_setContractSkill(petMo)
end

function TCKContractSelectView:_refreshTxt()
	self._txtSure.text = "确认选择"

	if self._isChanged then
		if self._curSummonerMasterId > 0 and self._curSummonedPetId > 0 then
			self._txtSure.text = "确认切换"
		elseif self._currFmtMasterPetId > 0 then
			self._txtSure.text = "解除契约"
		end
	end
end

return TCKContractSelectView
