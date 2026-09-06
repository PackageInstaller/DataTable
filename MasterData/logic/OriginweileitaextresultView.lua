-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitaextresultView.lua

module("logic.extensions.originweileita.view.OriginweileitaextresultView", package.seeall)

local OriginweileitaextresultView = class("OriginweileitaextresultView", ViewComponent)

OriginweileitaextresultView.PassType = {
	Kill = 1,
	Buff2 = 3,
	Buff1 = 2
}

function OriginweileitaextresultView:ctor()
	OriginweileitaextresultView.super.ctor(self)
end

function OriginweileitaextresultView:unbindEvents()
	OriginweileitaextresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginweileitaextresultView:bindEvents()
	OriginweileitaextresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginweileitaextresultView:buildUI()
	OriginweileitaextresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewleftGo = self:getGo("tableviewleft")
	self._tableviewrightGo = self:getGo("tableviewright")
	self._scrollerListLeft = ScrollerList.create(self._tableviewleftGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerListLeft:setCenterMode(true)

	self._scrollerListRight = ScrollerList.create(self._tableviewrightGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerListRight:setCenterMode(true)

	self._txtTitle = self:getTxt("txtTitle")
	self._tableviewpassGo = self:getGo("tableviewpass")
	self._tablecellpassGo = self:getGo("tablecellpass")
	self._scrollerListPass = ScrollerList.create(self._tableviewpassGo, self._tablecellpassGo, GameUtil.handler(self._updatePassCell, self), GameUtil.handler(self._clearPassCell, self))
end

function OriginweileitaextresultView:onExit()
	OriginweileitaextresultView.super.onExit(self)
	self._scrollerListLeft:dispose()
	self._scrollerListRight:dispose()
	self._scrollerListPass:dispose()
end

function OriginweileitaextresultView:onEnter()
	OriginweileitaextresultView.super.onEnter(self)

	local params = self:getFirstParam()

	self._lockRaceIds = params.lockRaceIds or {}
	self._txtTitle.text = params.stagePass and "挑战成功" or "挑战失败"
	self._activityId = params.activityId
	self._stageId = params.stageId
	self._petRes = params.petRes or {}
	self._leftPetList = {}
	self._rithtPetList = {}

	for i, v in ipairs(self._petRes) do
		if v.signId == 1 then
			table.insert(self._leftPetList, v)
		else
			table.insert(self._rithtPetList, v)
		end
	end

	self._scrollerListLeft:reloadData(self._leftPetList)
	self._scrollerListRight:reloadData(self._rithtPetList)

	local list = {
		{
			pt = OriginweileitaextresultView.PassType.Kill
		},
		{
			pt = OriginweileitaextresultView.PassType.Buff1
		},
		{
			pt = OriginweileitaextresultView.PassType.Buff2
		}
	}

	self._scrollerListPass:reloadData(list)
end

function OriginweileitaextresultView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

function OriginweileitaextresultView:_updateCell(view, cell, petData, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goDead = goutil.findChild(cell.gameObject, "dead")
	local goActive = goutil.findChild(cell.gameObject, "active")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local stageCfg = OriginWeiLeiTaConfig.instance:getExtStageCfg(self._activityId, self._stageId)
	local petMo = BagPetsController.instance:getPet(petData.petId)
	local needScore = stageCfg.winScoreRequirements[petData.signId]

	MaterialMgr.setCell(MatType.Pet, petMo.raceId, goCon)
	goutil.setActive(goDead, petData.dead)
	goutil.setActive(goActive, not petData.dead and petData.score >= stageCfg.winScoreRequirements[petData.signId])

	local preStr = petData.signId == 1 and "超杀" or "击杀"

	txtDesc.text = string.format("%s:<color=%s>%s</color>/%s", preStr, needScore <= petData.score and "green" or "red", petData.score, needScore)
end

function OriginweileitaextresultView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

function OriginweileitaextresultView:_updatePassCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local change = goutil.findChild(cell.gameObject, "change"):GetComponent(ComponentType.UIImageSpriteChange)

	if data.pt == OriginweileitaextresultView.PassType.Kill then
		local enemys = BattleModel.instance:getEnemyUnits()
		local totalNum = 0
		local curNum = 0

		for k, v in pairs(enemys) do
			if not v.attrs:isFakePet() and not v.attrs:isHaveBeenTJSummoned() then
				totalNum = totalNum + 1

				if v.attrs:getCurHp() <= 0 then
					curNum = curNum + 1
				end
			end
		end

		txtDesc.text = string.format("击败敌阵所有精灵(<color=#%s>%s</color>/%s)", totalNum <= curNum and "466887" or "EB4642", curNum, totalNum)

		local pass = totalNum <= curNum

		change:SetState(pass and 0 or 1)
	elseif data.pt == OriginweileitaextresultView.PassType.Buff1 then
		local signId = 1
		local pass, desc = self:_getBuffSignDesc(signId)

		txtDesc.text = desc

		change:SetState(pass and 0 or 1)
	elseif data.pt == OriginweileitaextresultView.PassType.Buff2 then
		local signId = 2
		local pass, desc = self:_getBuffSignDesc(signId)

		txtDesc.text = desc

		change:SetState(pass and 0 or 1)
	end
end

function OriginweileitaextresultView:_clearPassCell(cell)
	return
end

function OriginweileitaextresultView:_getBuffSignDesc(signId)
	local signCfg = OriginWeiLeiTaConfig.instance:getSignCfg(self._activityId, signId)
	local stageCfg = OriginWeiLeiTaConfig.instance:getExtStageCfg(self._activityId, self._stageId)
	local totalNum = 0
	local curNum = 0
	local needScore = stageCfg.winScoreRequirements[signId]

	for i, v in ipairs(self._petRes) do
		if v.signId == signId then
			if not v.dead and needScore <= v.score then
				curNum = curNum + 1
			end

			totalNum = totalNum + 1
		end
	end

	return totalNum <= curNum, string.format("激活%s标记(<color=#%s>%s</color>/%s)", signCfg.name, totalNum <= curNum and "466887" or "EB4642", curNum, totalNum)
end

return OriginweileitaextresultView
