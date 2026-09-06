-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpBattleEventView.lua

module("logic.extensions.expedition.view.ExpBattleEventView", package.seeall)

local ExpBattleEventView = class("ExpBattleEventView", ViewComponent)

function ExpBattleEventView:ctor()
	ExpBattleEventView.super.ctor(self)
end

function ExpBattleEventView:buildUI()
	ExpBattleEventView.super.buildUI(self)

	self._bgMaskBtn = self:getBtn("bgMask")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._teamView = self:getGo("teamViews"):GetComponent("ScrollRect")
	self._teamViewContent = self:getGo("teamViews/Viewport/Content").transform
	self._teamVPSize = self:getGo("teamViews/Viewport").transform.rect.width
	self._teamNode = self:getGo("teamViews/Viewport/Content/team")
	self._teamPower = self:getGo("imgTeamPower"):GetComponent(ComponentType.UIImgNumeralText)
	self._awardsView = self:getGo("awardsView"):GetComponent("ScrollRect")
	self._awardsViewContent = self:getGo("awardsView/Viewport/Content").transform
	self._awardsVPSize = self:getGo("awardsView/Viewport").transform.rect.width
	self._itemNode = self:getGo("awardsView/Viewport/Content/ItemNode")
end

function ExpBattleEventView:destroyUI()
	ExpBattleEventView.super.destroyUI(self)
end

function ExpBattleEventView:onExitFinished()
	ExpBattleEventView.super.onExitFinished(self)
end

function ExpBattleEventView:onEnterFinished()
	ExpBattleEventView.super.onEnterFinished(self)
end

function ExpBattleEventView:unbindEvents()
	ExpBattleEventView.super.unbindEvents(self)
	self._bgMaskBtn:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function ExpBattleEventView:bindEvents()
	ExpBattleEventView.super.bindEvents(self)
	self._bgMaskBtn:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function ExpBattleEventView:onExit()
	ExpBattleEventView.super.onExit(self)

	self._gridData = nil

	local nodeCnt = self._teamNode.transform.childCount

	for i = 1, nodeCnt do
		local go = self._teamNode.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end

	nodeCnt = self._itemNode.transform.childCount

	for i = 1, self._itemNode.transform.childCount do
		local go = self._itemNode.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end
end

function ExpBattleEventView:onEnter()
	ExpBattleEventView.super.onEnter(self)

	self._gridData = self:getFirstParam()[1]

	self:_updateRecommentFightingPower()
	self:_updateEnemyTeam()
	self:_updateAwards()

	local canOpen = self:getOpenParam()[2]

	if canOpen then
		self._btnChallenge.gameObject:SetActive(true)
	else
		self._btnChallenge.gameObject:SetActive(false)
	end
end

function ExpBattleEventView:_updateRecommentFightingPower()
	local fightPower = ExpeditionFmtModel.instance:getFightingPowerOfFmt(self._gridData.eventInfo)

	self._teamPower:SetText(tostring(fightPower))
end

function ExpBattleEventView:_updateEnemyTeam()
	local creepCos = ExpeditionFmtModel.instance:getFightingMonsterMos(self._gridData.eventInfo)
	local formations = {}
	local map = {}
	local masterPetId = -1
	local summonPetId = -1

	for i, v in ipairs(creepCos) do
		local petMo = v.petMo
		local petId = petMo.petId

		formations[petId] = v

		if petMo:isSummonedPet() then
			masterPetId = petMo.summonMasterId
			summonPetId = petId
		end

		map[petMo.petId] = true
	end

	if masterPetId > 0 and not map[masterPetId] then
		formations[summonPetId] = nil
	end

	local creepCos = {}

	for k, v in pairs(formations) do
		table.insert(creepCos, v)
	end

	local childCount = self._teamNode.transform.childCount
	local petNum = #creepCos

	while childCount < petNum do
		local go = goutil.create("pet" .. childCount + 1)

		go.transform:SetParent(self._teamNode.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, childCount * 115, 0, 0)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		childCount = childCount + 1
	end

	for i = 1, petNum do
		local data = creepCos[i]
		local item = MatType.Pet .. ":" .. data.data.raceId .. ":" .. data.data.lv
		local go = self._teamNode.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)

		local proxy = MaterialMgr.setCellByCfg(item, go)

		if proxy then
			proxy.binder:setStars(data.data.awakenLv)
			proxy.binder:setSkin(data.data.faceId)
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				local petMo = {
					raceId = data.data.raceId,
					curFaceId = checknumber(data.data.faceId),
					level = data.data.lv,
					name = data.data.name,
					contractSkillId = data.data.contractSkillId,
					_curZdl = data.fightingPower,
					awakenLv = data.data.awakenLv
				}

				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		end
	end

	local contentSize = petNum * 115
	local sizeDelta = self._teamViewContent.sizeDelta

	sizeDelta.x = contentSize
	self._teamViewContent.sizeDelta = sizeDelta
	self._teamView.enabled = contentSize > self._teamVPSize
end

function ExpBattleEventView:_updateAwards()
	local multiply = 1
	local isInTime, desc, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Expedition)

	if isInTime and cfg then
		multiply = checknumber(cfg.featureParam)
	end

	local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

	multiply = multiply + newhandDoubleValue

	local info = ExpeditionModel.instance:getInfo()
	local stepCo = ExpeditionConfig.instance:getExpeditionMapStepCo(info.level + 1, info.nextXAixs)
	local prizeCos = ExpeditionConfig.instance:getFightPrize(stepCo.fightWinPrizePlanId)
	local prize
	local level = MofangModel.instance:getCurLv()

	if prizeCos then
		for i = 1, #prizeCos do
			if level >= prizeCos[i].playerLvRange[1] and level <= prizeCos[i].playerLvRange[2] then
				prize = prizeCos[i].prize
			end
		end
	end

	prize = MaterialMgr.changeItemStr(prize or "")

	local awards = string.split(prize, "#")
	local childCount = self._itemNode.transform.childCount
	local itemNum = #awards

	while childCount < itemNum do
		local go = goutil.create("prize" .. childCount + 1)

		go.transform:SetParent(self._itemNode.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, childCount * 115, 0, 0)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local data = awards[i]
		local go = self._itemNode.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)

		local list = string.split(data, ":")

		if #list >= 3 then
			local count = checknumber(table.remove(list)) * multiply

			table.insert(list, tostring(count))

			data = table.concat(list, ":")
		end

		MaterialMgr.setCellByCfg(data, go)
	end

	local sizeDelta = self._awardsViewContent.sizeDelta

	sizeDelta.x = itemNum * 115
	self._awardsViewContent.sizeDelta = sizeDelta
end

function ExpBattleEventView:_onClickClose()
	self:close()
end

function ExpBattleEventView:_onClickChallenge()
	local gridData = self._gridData

	self:close()
	ExpeditionAgent.instance:sendPM_ExpeditionGetFormReq(function(msg)
		ExpeditionFmtModel.instance:setFormation(msg.simpleForm)
		UIStateManager.instance:push(ViewName.ExpMission, gridData)
	end)
end

return ExpBattleEventView
