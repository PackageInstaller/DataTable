-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/selectpop/OracleselectpopView.lua

module("logic.extensions.formation.view.selectpop.OracleselectpopView", package.seeall)

local OracleselectpopView = class("OracleselectpopView", ViewComponent)

function OracleselectpopView:buildUI()
	OracleselectpopView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tableviewLeft = self:getGo("left/tableview")
	self._tableviewRight = self:getGo("right/tableview")
	self._cell = self:getGo("item")
	self._skillIcon = self:getGo("right/info/skillIcon")
	self._txtSkillName = self:getTxt("right/info/txtName")
	self._txtSkillDesc = self:getTxt("right/info/txtDesc")
	self._rightEmpty = self:getGo("right/empty")
	self._leftScrollList = ScrollerList.create(self._tableviewLeft, self._cell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._rightScrollList = ScrollerList.create(self._tableviewRight, self._cell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
end

function OracleselectpopView:bindEvents()
	OracleselectpopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function OracleselectpopView:unbindEvents()
	OracleselectpopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function OracleselectpopView:onEnter()
	OracleselectpopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petMoList = params[1]
	self._allPetList = params[2]

	if #self._petMoList == 0 or #self._petMoList == 0 then
		self:close()

		return
	end

	self._selectLeftIdx = 1
	self._selectPetId = 0

	self:_updateLeftList()
end

function OracleselectpopView:onExit()
	OracleselectpopView.super.onExit(self)
	self:_removeIcons()
end

function OracleselectpopView:_onClickClose()
	self:close()
end

function OracleselectpopView:_onClickSure()
	local petMo = self._petMoList[self._selectLeftIdx]

	if petMo then
		if self._selectPetId > 0 then
			if petMo.oraclePetId ~= self._selectPetId then
				PetAgent.instance:sendPM_OracleLinkReq(petMo.petId, self._selectPetId)
			end
		elseif checknumber(petMo.oraclePetId) > 0 then
			PetAgent.instance:sendPM_CancelOracleLinkReq(petMo.petId, petMo.oraclePetId)
		end
	end

	self:_onClickClose()
end

function OracleselectpopView:_updateLeftCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btnClick:AddClickListener(function()
		self:_onClickLeftBtn(data, cell.data)
	end)

	local petMo = self._petMoList[self._selectLeftIdx]

	if petMo then
		local proxy = MaterialMgr.setCellByMo(petMo, node)
	end

	goSelect:SetActive(cell.data == self._selectLeftIdx)
end

function OracleselectpopView:_clearLeftCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function OracleselectpopView:_updateRightCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passed = goutil.findChild(cell, "passed")

	btnClick:AddClickListener(function()
		self:_onClickRightBtn(data)
	end)

	local proxy = MaterialMgr.setCellByMo(data, node)

	goSelect:SetActive(data.petId == self._selectPetId)
end

function OracleselectpopView:_clearRightCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function OracleselectpopView:_updateLeftList()
	self._leftScrollList:reloadData(self._petMoList)
	self:_updateRightList()
end

function OracleselectpopView:_updateRightList()
	self._txtSkillName.text = "神使技"
	self._txtSkillDesc.text = "--"

	local list = {}

	self._selectPetId = 0

	local petMo = self._petMoList[self._selectLeftIdx]

	if petMo then
		for i, mo in ipairs(self._allPetList) do
			if ContractConfig.instance:getOracleByRaceId(petMo.raceId, mo.raceId) then
				table.insert(list, mo)
			end
		end

		self._selectPetId = petMo.oraclePetId

		self:_updateSkillShow(petMo.curFaceId)
	end

	self._rightScrollList:reloadData(list)
	GameUtil.SetActive(self._rightEmpty, #list == 0)
end

function OracleselectpopView:_onClickLeftBtn(petMo, index)
	if index == self._selectLeftIdx then
		return
	end

	self._selectLeftIdx = index

	self._leftScrollList:refresh()
	self:_updateRightList()
end

function OracleselectpopView:_onClickRightBtn(data)
	self._selectPetId = self._selectPetId == data.petId and 0 or data.petId

	self._rightScrollList:refresh()
end

function OracleselectpopView:_updateRightSelect(newSelectIndex)
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

function OracleselectpopView:_updateSkillShow(raceId)
	MaterialMgr.clearIcon(self._skillIcon)

	if checknumber(raceId) > 0 then
		local petCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

		if checknumber(petCfg.oracleSkillId) > 0 then
			MaterialMgr.setCell(MatType.Skill, petCfg.oracleSkillId, self._skillIcon)

			local cfg = BattleConfig.instance:getSkillCo(petCfg.oracleSkillId, raceId)

			if cfg then
				self._txtSkillName.text = cfg.name
				self._txtSkillDesc.text = cfg.desc
			end
		end
	end
end

function OracleselectpopView:_removeIcons()
	MaterialMgr.resetAll(self._skillIcon)
end

return OracleselectpopView
