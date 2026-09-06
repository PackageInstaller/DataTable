-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/view/DivineteshamuclgresultView.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgresultView", package.seeall)

local DivineteshamuclgresultView = class("DivineteshamuclgresultView", ViewComponent)

function DivineteshamuclgresultView:ctor()
	DivineteshamuclgresultView.super.ctor(self)
end

function DivineteshamuclgresultView:unbindEvents()
	DivineteshamuclgresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function DivineteshamuclgresultView:bindEvents()
	DivineteshamuclgresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function DivineteshamuclgresultView:buildUI()
	DivineteshamuclgresultView.super.buildUI(self)

	self._txtHp = self:getTxt("txtHp")
	self._txtNum = self:getTxt("txtNum")
	self._txtAliveDesc = self:getTxt("txtAliveDesc")
	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("empty")
end

function DivineteshamuclgresultView:onExit()
	DivineteshamuclgresultView.super.onExit(self)
	self._scrollerList:dispose()
	DivineTeshamuAgent.instance:sendPM_DivineTeshamuInfoReq(self._activityId)
end

function DivineteshamuclgresultView:onEnter()
	DivineteshamuclgresultView.super.onEnter(self)

	self._msg = self:getFirstParam()
	self._activityId = self._msg.activityId
	self._floorId = self._msg.res.floorId

	self:_updateUI()
end

function DivineteshamuclgresultView:_onClickbtnSure()
	DivineTeshamuAgent.instance:sendPM_DivineTeshamuSaveReq(self._activityId)
	BattleFacade.instance:endBattle()
end

function DivineteshamuclgresultView:_onClickbtnCancel()
	BattleFacade.instance:endBattle()
end

function DivineteshamuclgresultView:_insertPetDatas(petIds, resultList, isAlive)
	for i, petId in ipairs(petIds) do
		local cfg = DivineteshamuclgConfig.instance:getSupportPetCfg(self._activityId, petId)

		if cfg then
			local fPowerPet = FightingPowerPetMo.New()

			fPowerPet:fromChallengeCreepCo(cfg)

			local petMo = fPowerPet:toBaseBagPetMo()

			table.insert(resultList, {
				isAlive = isAlive,
				petMo = petMo
			})
		else
			local petMo = BagPetsController.instance:getPet(petId)

			if petMo then
				table.insert(resultList, {
					isAlive = isAlive,
					petMo = petMo
				})
			end
		end
	end
end

function DivineteshamuclgresultView:_updateUI()
	local petDataList = {}
	local count = DivineteshamuclgModel.instance:getSoldierCount(self._activityId, self._floorId)
	local cfg = DivineteshamuclgConfig.instance:getActCfg(self._activityId)

	self:_insertPetDatas(self._msg.res.alivePetIds, petDataList, true)
	self:_insertPetDatas(self._msg.res.deadPetIds, petDataList, false)
	self:_insertSupportPet(petDataList)
	self._scrollerList:reloadData(petDataList)

	self._txtHp.text = string.format("%s<color=#20b376>%%</color>", 100 - #self._msg.res.deadPetIds * cfg.decBloodPercent)
	self._txtNum.text = string.format("%s<color=#20b376>+%s</color>", count, self._msg.res.gainSoldierNum)
	self._txtAliveDesc.text = string.format("本局特莎姆%s", self._msg.res.isDivineTeshamuDead and "阵亡" or "存活")

	goutil.setActive(self._emptyGo, #petDataList <= 0)
end

function DivineteshamuclgresultView:_updateCell(view, cell, data, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goTag = goutil.findChild(cell.gameObject, "tag")

	goutil.setActive(goTag, not data.isAlive)
	MaterialMgr.setCellByData(MatType.Pet, data.petMo, goCon)
end

function DivineteshamuclgresultView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

function DivineteshamuclgresultView:_insertSupportPet(resultList)
	local stageCfg = DivineteshamuclgConfig.instance:getStageCfg(self._activityId, self._floorId, self._msg.res.stageId)
	local petId = stageCfg.supportPetCreepsId
	local cfg = DivineteshamuclgConfig.instance:getSupportPetCfg(self._activityId, petId)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(cfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	table.insert(resultList, 1, {
		isAlive = not self._msg.res.isDivineTeshamuDead,
		petMo = petMo
	})
end

return DivineteshamuclgresultView
