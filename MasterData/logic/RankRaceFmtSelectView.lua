-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceFmtSelectView.lua

module("logic.extensions.rankrace.view.RankRaceFmtSelectView", package.seeall)

local RankRaceFmtSelectView = class("RankRaceFmtSelectView", ViewComponent)

function RankRaceFmtSelectView:buildUI()
	self:_initNegoSelect()
	self:_initTeamInfo()
	self:_initSeats()

	self._txtTips = self:getGo("TxtTip"):GetComponent(goutil.Type_UIText)
	self._btnDefault = self:getBtn("BtnDefault")
	self._btnGotoFormation = self:getBtn("BtnFormation")
	self._btnClose = self:getBtn("BtnClose")
end

function RankRaceFmtSelectView:_initTeamInfo()
	local negoTeamInfo = self:getGo("NegoLeft/NegoTeamInfo")

	self._txtPower = goutil.findChild(negoTeamInfo, "NegoTeamPower/TxtTeamPower"):GetComponent(goutil.Type_UIText)
	self._txtSpeed = goutil.findChild(negoTeamInfo, "NegoTeamSpeed/TxtTeamSpeed"):GetComponent(goutil.Type_UIText)
	self._powerBtn = Framework.ButtonAdapter.GetFrom(negoTeamInfo, "NegoTeamPower")
	self._speedBtn = Framework.ButtonAdapter.GetFrom(negoTeamInfo, "NegoTeamSpeed/BtnSpeed")
end

function RankRaceFmtSelectView:_initNegoSelect()
	self._btnFormation = self:getGo("NegoLeft/NegoSelect/BtnFormation")
	self._txtFormation = goutil.findChild(self._btnFormation, "TxtFormation"):GetComponent(goutil.Type_UIText)
	self._popupFormation = goutil.findChild(self._btnFormation, "NegoPopupMenu")

	local heroSkill = self:getGo("NegoLeft/NegoSelect/BtnHeroSkill")

	self._imgHeroSkill = heroSkill:GetComponent(typeof(UIImageSpriteChange))
	self._heroSkillIcon = goutil.findChild(heroSkill, "Icon")
	self._popupHeroSkill = goutil.findChild(heroSkill, "NegoPopupMenu")
	self._btnBuffForm = self:getBtn("NegoLeft/NegoSelect/Btn_BuffForm")
	self._TxtC_BuffForm = goutil.findChildTextComponent(self._btnBuffForm.gameObject, "text")
end

function RankRaceFmtSelectView:_initSeats()
	local negoSeats = self:getGo("NegoLeft/NegoSeats")
	local startOrder = self:getGo("NegoLeft/startOrder")

	self._seats = {}
	self._startOrderGos = {}
	self._startOrderTxts = {}

	for i = 1, 9 do
		local go = goutil.findChild(negoSeats, string.format("Item_Seat_%d", i))
		local startOrderGo = goutil.findChild(startOrder, string.format("item%d", i))

		self._seats[i] = go
		self._startOrderGos[i] = startOrderGo
		self._startOrderTxts[i] = goutil.findChild(startOrderGo, "bg/Text"):GetComponent(goutil.Type_UIText)
	end
end

function RankRaceFmtSelectView:bindEvents()
	self._powerBtn:AddClickListener(self._onClickPower, self)
	self._speedBtn:AddClickListener(self._onClickSpeed, self)
	self._btnDefault:AddClickListener(self._onClickUseDefault, self)
	self._btnGotoFormation:AddClickListener(self._onClickGotoFormation, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBuffForm:AddClickListener(self._onClickBuffForm, self)
end

function RankRaceFmtSelectView:unbindEvents()
	self._powerBtn:RemoveClickListener()
	self._speedBtn:RemoveClickListener()
	self._btnDefault:RemoveClickListener()
	self._btnGotoFormation:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuffForm:RemoveClickListener()
end

function RankRaceFmtSelectView:onEnter()
	local teamId = self:_getCurrTeamId()

	self._matchType = self:getFirstParam()

	self:_setHeroSkill(self:_getHeroSkillId())
	self:_setFormationName(teamId)
	self:_setPowerAndSpeed()
	self:_refeshSeats()
	self:_setSummonContractSkillEffect()
	self.registerNotify(self, GlobalNotify.RankAutoSetDefenseForm, self._onRankAutoSetDefenseForm, self)
	GlobalDispatcher:addListener(GlobalNotify.BuffFormSelect, self._onSelectBuffForm, self)
end

function RankRaceFmtSelectView:onEnterFinished()
	self:_updateStartOrder()
end

function RankRaceFmtSelectView:onExit()
	self:_removeSummonContractSkillEffect()
	self.unregisterNotify(self, GlobalNotify.RankAutoSetDefenseForm, self._onRankAutoSetDefenseForm, self)
	GlobalDispatcher:removeListener(GlobalNotify.BuffFormSelect, self._onSelectBuffForm, self)
end

function RankRaceFmtSelectView:onExitFinished()
	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		itemSeat:onExit()
	end

	self._matchType = nil
end

function RankRaceFmtSelectView:_onClickPower()
	FloatWordMgr.instance:show(langPara("全员战斗力:%s", self._power))
end

function RankRaceFmtSelectView:_onClickSpeed()
	FloatWordMgr.instance:show(langPara("全员速度:%s", self._txtSpeed.text))
end

function RankRaceFmtSelectView:_onClickClose()
	RankingMatchAgent.instance:sendRM_AutoSetDefenseFormReq(self._matchType)
end

function RankRaceFmtSelectView:_onClickUseDefault()
	RankingMatchAgent.instance:sendRM_AutoSetDefenseFormReq(self._matchType)
end

function RankRaceFmtSelectView:_onClickGotoFormation()
	local _type = self._matchType

	self:close()
	RankRaceFmtController.instance:enterDefenseForm(_type, true)
end

function RankRaceFmtSelectView:_setFormationName(teamId)
	local team = FormationNewModel.instance:GetTeam(teamId)

	self._txtFormation.text = team:getTabName()
end

function RankRaceFmtSelectView:_setHeroSkill(skillId)
	skillId = checknumber(skillId)

	if skillId == 0 then
		local hero_skill = self:_getHeroSkillId()
		local skills = self:_getPetsHeroSkills()

		if TableUtil.isHad(skills, hero_skill) then
			skillId = hero_skill
		elseif table.getn(skills) > 0 then
			skillId = skills[1]
		end
	end

	self._heroSkillIcon:SetActive(true)
	self._imgHeroSkill:ChangeStateNow(0)

	if skillId > 0 then
		self:_setSkillIcon(skillId)
	else
		self._heroSkillIcon:SetActive(false)
		self._imgHeroSkill:ChangeStateNow(1)
	end
end

function RankRaceFmtSelectView:_setSkillIcon(id)
	local skillCo = BattleConfig.instance:getSkillCo(id)

	if skillCo == nil then
		printInfo("id:" .. id)

		return
	end

	self._heroSkillIcon:SetActive(id > 0)
	BagPetsFacade.setHeadIconByRaceId(self._heroSkillIcon, math.fmod(id, 100000))
end

function RankRaceFmtSelectView:_getPowerAndSpeed()
	local _matchType = RankRaceController.instance:getCurViewType()
	local formation = self:_getCurFormation()
	local heroSkillId = self:_getHeroSkillId()
	local fid = 0
	local flvl = 0
	local info = formation:GetFormStrengthInfo()

	if self._CurFormId then
		fid = self._CurFormId
	elseif info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
	end

	local power, speed = 0, 0

	if _matchType == RankRaceController.MatchTypeClassics then
		local team = {}

		info = FormationNewModel.instance:getFormStrengthInfo(fid)

		if info then
			flvl = info.formStrengthLv
		end

		for _, v in ipairs(formation:GetPositions()) do
			if v > 0 then
				local pet = self:_getPet(v)

				if pet then
					local fightingPowerMo = pet:toFightingPowerPetMo()

					table.insert(team, fightingPowerMo)

					if pet.summonMasterId <= 0 then
						speed = speed + pet._speed
					end
				end
			end
		end

		local eleMap = formation:getCurElementRelationMap()
		local cutePetRaceId, cutePetQuality = formation:getCutePetInfo()
		local masterId = formation:GetSummonMasterPetId()
		local summonId = formation:GetSummonPetId()

		power = FightingPowerFormula.instance:getTeamFightingPower(team, heroSkillId, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId)
	else
		flvl = BattleConfig.instance:getFormStrengthMaxLv(fid)
		power, speed = RankRaceController.instance:calMaxFightPowerAnfSpeed(formation, heroSkillId, fid, flvl)
	end

	return power, speed
end

function RankRaceFmtSelectView:_setPowerAndSpeed()
	local power, speed = self:_getPowerAndSpeed()

	self._power = power
	self._txtPower.text = power
	self._txtSpeed.text = speed
end

function RankRaceFmtSelectView:_refeshSeats()
	local positions = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(positions) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])
		local petMo = self:_getPet(petId)

		itemSeat:SetSeatInfo(i, petMo, self:_getCurElementMap())
		itemSeat:SetSelect(false)
		itemSeat:SetRestrain("", false)
	end

	self:_updateStartOrder()
end

function RankRaceFmtSelectView:_getCurElementMap()
	return self:_getCurFormation():getCurElementRelationMap()
end

function RankRaceFmtSelectView:_updateStartOrder()
	local fmtPoses = self:_getCurFormation():GetPositions()
	local startOrderIndex = 1

	for i, petId in ipairs(fmtPoses) do
		if petId > 0 then
			local txt = string.format("%d手", startOrderIndex)

			self._startOrderTxts[i].text = string.format("%d手", startOrderIndex)
			startOrderIndex = startOrderIndex + 1
		end
	end
end

function RankRaceFmtSelectView:_onRankAutoSetDefenseForm()
	self:close()
end

function RankRaceFmtSelectView:_onClickBuffForm()
	local infos = FormationNewModel.instance:getAllFormStrengthInfo()
	local formId = FormationNewModel.instance:getCurrBuffFormId(self._matchType)

	UIStateManager.instance:push(ViewName.NineplacebuffselectView, infos, formId, "closeUp")
end

function RankRaceFmtSelectView:_getCurrTeamId()
	return FormationNewModel.instance:GetCurTeamId()
end

function RankRaceFmtSelectView:_getCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function RankRaceFmtSelectView:_getPetsHeroSkills()
	return FormationNewModel.instance:GetCurTeam():GetFormPetsHeroSkills()
end

function RankRaceFmtSelectView:_getHeroSkillId()
	return self:_getCurFormation():GetHeroSkillId()
end

function RankRaceFmtSelectView:_getPet(id)
	return BagPetsController.instance:getPet(id)
end

function RankRaceFmtSelectView:_getItemSeatCls()
	if self._matchType == RankRaceController.MatchTypeClassics then
		return ItemSeat
	elseif self._matchType == RankRaceController.MatchTypeLimit then
		return RankRaceItemSeat
	end
end

function RankRaceFmtSelectView:_onSelectBuffForm(formId)
	RankRaceFmtModel.instance:setCurrBuffFormId(formId, RankRaceController.instance:getCurViewType())

	self._CurFormId = formId

	self:_setPowerAndSpeed()

	if formId then
		local cfg = NinePlaceConfig.instance:getStageCfgById(formId)

		if cfg then
			local tempList = {}

			for i, v in ipairs(cfg.lights) do
				tempList[v] = true
			end

			self._TxtC_BuffForm.text = cfg.name

			return
		end
	end

	for i, v in ipairs(self.buffPlaceList) do
		v:SetState(0)
	end

	self._TxtC_BuffForm.text = "选择阵型"
end

function RankRaceFmtSelectView:_getContractSkillEffectPath(summonId, summonMasterId)
	return "common/buff/fx_buff_zhaohuanshou"
end

function RankRaceFmtSelectView:_setSummonContractSkillEffect()
	self:_removeSummonContractSkillEffect()

	local fmtMo = self:_getCurFormation()
	local summonId = fmtMo:GetSummonPetId()
	local masterId = fmtMo:GetSummonMasterPetId()

	if summonId > 0 then
		local effectPath = self:_getContractSkillEffectPath(summonId, masterId)

		if not string.nilorempty(effectPath) then
			local curPos = -1
			local poisitions = self:_getCurFormation():GetPositions()

			for i, v in ipairs(poisitions) do
				if v == summonId then
					curPos = i

					break
				end
			end

			if curPos > 0 then
				local ItemSeatCls = self:_getItemSeatCls()
				local itemSeat = ItemSeatCls.AddOnce(self._seats[curPos])

				itemSeat:playContractSkillEffect(self, effectPath)
			end
		end
	end
end

function RankRaceFmtSelectView:_removeSummonContractSkillEffect()
	local ItemSeatCls = self:_getItemSeatCls()

	for pos = 1, 9 do
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		itemSeat:removeContractSkillEffect()
	end
end

return RankRaceFmtSelectView
