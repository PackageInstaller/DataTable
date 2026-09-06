-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchdirectView.lua

module("logic.extensions.petsearch.view.PetsearchdirectView", package.seeall)

local PetsearchdirectView = class("PetsearchdirectView", ViewComponent)

function PetsearchdirectView:ctor()
	PetsearchdirectView.super.ctor(self)
end

function PetsearchdirectView:buildUI()
	PetsearchdirectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._txtCost = self:getTxt("txtCost")
	self._cell = self:getGo("cell")
	self._table = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._table, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PetsearchdirectView:bindEvents()
	PetsearchdirectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickBtnSure, self)
end

function PetsearchdirectView:unbindEvents()
	PetsearchdirectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function PetsearchdirectView:destroyUI()
	PetsearchdirectView.super.destroyUI(self)
end

function PetsearchdirectView:onEnter()
	PetsearchdirectView.super.onEnter(self)

	local bossId = PetsearchModel.instance:getCurBossId()

	self._curSelectBossId = nil
	self._curCycleId = PetsearchConfig.instance:getCurCycleIdAndEndTimeByBossId(bossId)

	local cfgs = PetsearchConfig.instance:getSearchPetCfgsPerCycle(self._curCycleId)

	self._tableView:reloadData(cfgs)

	self._curRreshCost = PetsearchConfig.instance:getParamValueByKey("DIRECTIONAL_SEEK_COST")
	self._costType, self._costId, self._curMatNum = MaterialMgr.getMatParams(self._curRreshCost)
	self._txtCost.text = self._curMatNum
end

function PetsearchdirectView:onEnterFinished()
	PetsearchdirectView.super.onEnterFinished(self)
end

function PetsearchdirectView:onExit()
	PetsearchdirectView.super.onExit(self)
end

function PetsearchdirectView:onExitFinished()
	PetsearchdirectView.super.onExitFinished(self)
end

function PetsearchdirectView:_updateCell(view, cell, data)
	if data then
		self:_clearCell(cell)

		local selected = goutil.findChild(cell, "selected")
		local txtName = goutil.findChildTextComponent(cell, "name/txtName")
		local item = goutil.findChild(cell, "item")

		GameUtil.addClickHandler(cell, GameUtil.handler(self._onSelectPet, self, data))
		goutil.setActive(selected, data.bossId == self._curSelectBossId)

		local teamCfg = PetsearchConfig.instance:getTeamCfg(data.creepsMasterId)
		local petRaceId = teamCfg.introdRaceId
		local petMatStr = string.format("%s:%s:0:1", MatType.Pet, petRaceId)

		MaterialMgr.setCellByCfg(petMatStr, item)

		local petCo = CharacterConfig.instance:getPetCo(petRaceId)

		txtName.text = petCo.name

		if data.bossId == self._curSelectBossId then
			self._selectBossName = petCo.name
		end
	end
end

function PetsearchdirectView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local btn = GameUtil.asBtn(cell)

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(cell)
end

function PetsearchdirectView:_onSelectPet(cfg)
	if cfg then
		self._curSelectBossId = cfg.bossId

		self._tableView:refresh()
	end
end

function PetsearchdirectView:_onClickBtnSure()
	if not self._curSelectBossId then
		FloatWordMgr.instance:show("请先指定寻觅精灵")

		return
	end

	local content = langPara("是否花费<color=#ebad32>%s%s</color>指定寻觅精灵%s？", self._curMatNum, MaterialMgr.getMaterialsName(self._costType, self._costId), self._selectBossName)

	TipsFacade.instance:openPopupCostMatViewNew(self._costType, self._costId, self._curMatNum, content, function()
		PetsearchController.instance:sendSeekPetDirectly(self._curSelectBossId)
	end)
end

return PetsearchdirectView
