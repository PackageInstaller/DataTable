-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettip/view/PetTipsSimpleView.lua

module("logic.extensions.pettip.view.PetTipsSimpleView", package.seeall)

local PetTipsSimpleView = class("PetTipsSimpleView", ViewComponent)

PetTipsSimpleView.openDebugAttr = false

local hideLevelSkillType = {
	[GameEnum.SkillRaceType.Hero] = true,
	[GameEnum.SkillRaceType.Combine] = true,
	[GameEnum.SkillRaceType.Summon] = true,
	[GameEnum.SkillRaceType.Contract] = true,
	[GameEnum.SkillRaceType.Domain] = true,
	[GameEnum.SkillRaceType.PsychicSkill] = true,
	[GameEnum.SkillRaceType.Element] = true,
	[GameEnum.SkillRaceType.ShenYaoSkill] = true,
	[GameEnum.SkillRaceType.BenyuanSkill] = true,
	[GameEnum.SkillRaceType.TianjueSkill] = true,
	[GameEnum.SkillRaceType.AwakenSkill] = true,
	[GameEnum.SkillRaceType.JuanYouSkill] = true,
	[GameEnum.SkillRaceType.SourceTraceSkill] = true,
	[GameEnum.SkillRaceType.BookSpiritSkill] = true,
	[GameEnum.SkillRaceType.SpiritInvocationSkill] = true
}
local ZERO_POS = Vector3.New(0, 0, 0)

function PetTipsSimpleView:unbindEvents()
	PetTipsSimpleView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._btnGoGet:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnBag)
end

function PetTipsSimpleView:bindEvents()
	PetTipsSimpleView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnGoGet:AddClickListener(self._onClickBtnGoGet, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBag, self)
end

function PetTipsSimpleView:onExit()
	PetTipsSimpleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleBuffDamage, self._onBattleBuffDamage, self)
	MaterialMgr.resetAll(self._ImgC_Con)

	self._canJumpOut = nil
end

function PetTipsSimpleView:buildUI()
	PetTipsSimpleView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._customInput = UICustomInput.Get(self._Nego_Content)

	local _Nego_Top = self:getGo("Nego_Content/Nego_Top")

	self._TxtC_Name = goutil.findChild(_Nego_Top, "TxtC_Name"):GetComponent("Text")
	self._TxtC_Name_Ori = self:getTxt("Nego_Content/Nego_Top/TxtC_Name_Ori")
	self._TxtC_Level = goutil.findChild(_Nego_Top, "TxtC_Level"):GetComponent(goutil.Type_UIText)
	self._TxtC_Count = goutil.findChild(_Nego_Top, "TxtC_Count"):GetComponent("Text")
	self._ImgC_Con = goutil.findChild(_Nego_Top, "ImgC_Con")
	self.ImgC_TxtBg = goutil.findChild(_Nego_Top, "ImgC_TxtBg"):GetComponent("UIChangeGroup")
	self._attrIcon = self:getGo("Nego_Content/Nego_Top/Nego_Attr/Img_attr"):GetComponent("UIImageSpriteChange")
	self._ImgC_Job = self:getGo("Nego_Content/Nego_Top/Nego_Job/ImgC_Job"):GetComponent("UIImageSpriteChange")
	self._Nego_Job1 = self:getGo("Nego_Content/Nego_Top/Nego_Job1")
	self._ImgC_Job1 = self:getGo("Nego_Content/Nego_Top/Nego_Job1/ImgC_Job"):GetComponent("UIImageSpriteChange")
	self.Nego_Ext = self:getGo("Nego_Content/Nego_Ext")
	self.Ext_con = self:getGo("Nego_Content/Nego_Ext/itemCon")
	self.Ext_item = self:getGo("Nego_Content/Nego_Ext/item")
	self._btnBag = self:getGo("Nego_Content/Nego_Top/btnBag")

	GameUtil.SetActive(self.Nego_Ext, false)

	self._btnGoGet = self:getBtn("Nego_Content/Nego_Top/btnGoGet")
	self._goMaxPowerTip = goutil.findChild(_Nego_Top, "powerTip")
	self.awake = self:getGo("Nego_Content/Nego_Top/awake")
	self.btnAwake = self:getGo("Nego_Content/Nego_Top/awake/btnAwake")
	self.imgAwake = self:getGo("Nego_Content/Nego_Top/awake/btnAwake/imgLv")
	self.Nego_Bar = self:getGo("Nego_Content/Nego_Bar")
	self._hpProgress = self:getGo("Nego_Content/Nego_Bar/hpProgress/progress"):GetComponent(typeof(ProgressBar))
	self._mpProgress = self:getGo("Nego_Content/Nego_Bar/mpProgress/progress"):GetComponent(typeof(ProgressBar))
	self._hpTxt = self:getTxt("Nego_Content/Nego_Bar/hpProgress/txtValue")
	self._mpTxt = self:getTxt("Nego_Content/Nego_Bar/mpProgress/txtValue")
	self.buffDesc = self:getTxt("Nego_Content/Nego_Buff/Nego_desc/ScrollView/Viewport/txtBuff")
	self._scroll2 = self:getGo("Nego_Content/Nego_Buff/Nego_desc/ScrollView"):GetComponent("ScrollRect")

	self:_buildSkillsView()
end

function PetTipsSimpleView:_buildSkillsView()
	self._skills = {}
	self._skills[1] = {}
	self._skills[2] = {}
	self._skills[1].go = self:getGo("Nego_Content/Nego_Skill")
	self._skills[1].negoCon = self:getGo("Nego_Content/Nego_Skill/scrollview/viewport/Nego_Con")
	self._skills[1].skillBtn = self:getGo("Nego_Content/Nego_Skill/skillBtn")
	self._skills[1].txtBattleSkillType = self:getTxt("Nego_Content/Nego_Skill/BattleSkillType/Text")
	self._skills[2].go = self:getGo("Nego_Content/Nego_PsychicSkill")
	self._skills[2].negoCon = self:getGo("Nego_Content/Nego_PsychicSkill/Nego_Con")
	self._skills[2].skillBtn = self:getGo("Nego_Content/Nego_PsychicSkill/skillBtn")
	self._skills[2].txtBattleSkillType = self:getTxt("Nego_Content/Nego_PsychicSkill/BattleSkillType/Text")
	self.skillDesc = self:getTxt("Nego_Content/Nego_desc/ScrollView/Viewport/txtDesc")
	self.skillType = self:getTxt("Nego_Content/Nego_desc/txtType")
	self.skillName = self:getTxt("Nego_Content/Nego_desc/txtName")
	self._scroll = self:getGo("Nego_Content/Nego_desc/ScrollView"):GetComponent("ScrollRect")
	self.labelGroup = self:getGo("Nego_Content/Nego_desc/labelGroup")
	self.label = self:getGo("Nego_Content/Nego_desc/label")
end

function PetTipsSimpleView:onEnter()
	PetTipsSimpleView.super.onEnter(self)

	local params = self:getOpenParam()

	self._info = params[1]
	self._canJumpOut = params[3]
	self._hasCarriedPetId = false
	self._entity = nil
	self.rcdPos = nil
	self.isHidePetZdl = params[2]
	self.adjustPos = nil
	self.clickPos = nil

	GameUtil.SetActive(self.Nego_Bar, false)
	self:_initPetTip()
	Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)

	local rect = self.mainGO.transform.rect
	local pos = UGUIToolHelper.GetTouchPosition()

	GameUtil.AdjustWithSize(self._Nego_Content, pos, 111, 111, rect.width, rect.height, false)
end

function PetTipsSimpleView:initExtInfo()
	goutil.clearChildren(self.Ext_con)
end

function PetTipsSimpleView:addExtItem(str)
	local item = goutil.clone(self.Ext_item)

	GameUtil.SetActive(item, true)

	local txt = goutil.findChildTextComponent(item, "txt")

	txt.text = str

	goutil.addChildToParent(item, self.Ext_con)
end

function PetTipsSimpleView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function PetTipsSimpleView:_initPetTip()
	self._TxtC_Name.text = ""
	self._TxtC_Name_Ori.text = ""

	GameUtil.SetActive(self._goMaxPowerTip, false)
	GameUtil.SetActive(self.awake, false)
	GameUtil.SetActive(self._btnBag, false)

	if self._info then
		if PetTipsSimpleView.openDebugAttr and Framework.OSDef.isEditor and self._info.printAttrs then
			self._info:printAttrs()
			self._info:calcAssistAttr(true)
		end

		local skinId = self._info.raceId

		if checknumber(self._info.curFaceId) > 0 then
			skinId = checknumber(self._info.curFaceId)
		end

		local cfg = CharacterConfig.instance:getPetCo(self._info.raceId)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(cfg.faceIds))

		self.petId = self._info.petId

		local petInfo = CharacterConfig.instance:getPetInfoCo(self._info.raceId)

		self._skills[1].txtBattleSkillType.text = ""
		self._skills[2].txtBattleSkillType.text = ""

		local ackType = ""

		if petInfo then
			local jobId = PetSkinConfig.instance:getFirstJobIdx(skinId)

			if jobId then
				local jobCo = CharacterConfig.instance:getJobCo(jobId)

				if jobCo then
					if jobCo.attackType == 1 then
						ackType = lang("类型：<color='#eb4642'>【物理】</color>")
					elseif jobCo.attackType == 2 then
						ackType = lang("类型：<color='#1cc2ff'>【魔法】</color>")
					end

					ackType = ackType .. GameUtil.HtmlColorTxt(langPara("【%s】", ConstString.BestPosition[petInfo.bestPosition]), ConstString.BestPositionColor[petInfo.bestPosition])
					self._skills[1].txtBattleSkillType.text = ackType
					self._skills[2].txtBattleSkillType.text = ackType
				end
			end
		end

		self._TxtC_Name.text = cfg.name

		local rare = CharacterConfig.instance:getInitRare(self._info.raceId)
		local proxy = MaterialMgr.setCell(MatType.Pet, self._info.raceId, self._ImgC_Con)

		if proxy then
			proxy:setAutoTips(false)

			if checknumber(self._info.curFaceId) > 0 then
				local ccc = PetSkinConfig.instance:getPetSkinName(checknumber(self._info.curFaceId))

				if ccc and ccc ~= "" then
					self._TxtC_Name.text = ccc
				end

				proxy.binder:setSkin(self._info.curFaceId)
			end
		end

		if not string.nilorempty(self._info.otherName) then
			self._TxtC_Name.text = self._info.otherName
			self._TxtC_Name_Ori.text = self._info.name
		elseif self._info.name then
			self._TxtC_Name.text = self._info.name
		end

		local zdl = 0
		local curLv = ""

		if self._info.__cname == "BagPetMo" or self._info.__cname == "FightingPowerPetMo" or self._info.__cname == "BorrowPetMo" then
			zdl = self._info:getFightingPower()
			curLv = "Lv." .. self._info:getPetLv()

			local awakenLv = checknumber(self._info.awakenLv)

			self._hasCarriedPetId = checknumber(self._info.carriedPetId) > 0

			proxy.binder:setStars(awakenLv)

			rare = CharacterConfig.instance:getRareByAwakenLv(awakenLv, self._info.raceId)
			self._TxtC_Name.text = self._info:getName()

			GameUtil.SetActive(self.awake, false)
			GameUtil.setUIImageSpriteIdx(self.imgAwake, awakenLv)

			if not string.nilorempty(self._info.skinOtherName) then
				self._TxtC_Name_Ori.text = self._TxtC_Name.text
				self._TxtC_Name.text = self._info.skinOtherName
			end

			local petId = self._info.petId

			if BagPetsController.instance:getPet(petId) then
				GameUtil.SetActive(self._btnBag, true)
			end
		else
			zdl = self._info._curZdl
			curLv = self._info.level and "Lv." .. self._info.level or ""

			if self._info.awakenLv then
				proxy.binder:setStars(self._info.awakenLv)

				rare = CharacterConfig.instance:getRareByAwakenLv(self._info.awakenLv, self._info.raceId)

				GameUtil.SetActive(self.awake, false)
				GameUtil.setUIImageSpriteIdx(self.imgAwake, self._info.awakenLv)
			end
		end

		self.ImgC_TxtBg:SetState(rare + 1)

		self._TxtC_Count.text = zdl

		if self._info.hideZdl or self.isHidePetZdl then
			self._TxtC_Count.text = "？？？"
		end

		self._TxtC_Level.text = ""

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

		race = math.fmod(race, 10)

		local targetValue = race - 1

		self._attrIcon:SetState(targetValue)

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

		self._ImgC_Job:SetState(firstJobIdx - 1)
		self._Nego_Job1.gameObject:SetActive(false)

		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx()

		if secondJobIdx > 20 then
			self._ImgC_Job1:SetState(secondJobIdx - 1 - 20)
		end

		self._entity = self._info.unit

		self:_refreshSkill(self._info, skinId)
	end

	self._btnGoGet.gameObject:SetActive(self._info._isPetExist == false)
end

function PetTipsSimpleView:_refreshSkill(info, skinId)
	if self._entity then
		GameUtil.SetActive(self.Nego_Bar, true)
		self:_showHpAndMp()
		GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
		GlobalDispatcher:addListener(GlobalNotify.BattleBuffDamage, self._onBattleBuffDamage, self)

		local psychicSkills = self:getPsychicSkillsByUnit(self._entity)
		local hasPsychicSkills = psychicSkills and #psychicSkills > 0

		self._skills[2].go:SetActive(hasPsychicSkills)

		if hasPsychicSkills then
			self:setSkills(psychicSkills, info, skinId, self._skills[2])
		end

		if self._entity.isPsychicTransform then
			self._skills[1].go:SetActive(false)
		else
			self._skills[1].go:SetActive(true)

			local skills = self:getSkillsByUnit(self._entity)

			self:setSkills(skills, info, skinId, self._skills[1])
		end
	else
		local psychicSkills = BagModel.instance:getPetPsychicSkills(info)
		local hasPsychicSkills = psychicSkills and #psychicSkills > 0

		self._skills[2].go:SetActive(hasPsychicSkills)

		if hasPsychicSkills then
			self:setSkills(psychicSkills, info, skinId, self._skills[2])
		end

		self._skills[1].go:SetActive(true)

		local skills = BagModel.instance:getPetSkills(info)

		self:setSkills(skills, info, skinId, self._skills[1])
	end
end

function PetTipsSimpleView:getSkillsByUnit(unit)
	local skills = {}
	local skillList = unit.skillList
	local list = skillList:getSoloTypeSkills()
	local tem = {}

	for k, v in pairs(list or {}) do
		local skco = v.skillCo

		if skco and skco.type ~= GameEnum.SkillType.PsychicSkill and skco.type ~= GameEnum.SkillType.PsychicSkillNormal and skco.type ~= GameEnum.SkillType.PsychicSkillUtl and not v.isPsychicedNormalSkill and not v.isPsychicedUltimateSkill and not v.isPsychicSkill then
			table.insert(tem, v)
		end
	end

	ArraySort.sortOn(tem, function(v)
		local skco = v.skillCo

		return GameEnum.SkillNameToType[skco.type]
	end)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(unit.modelId)

	for i, v in ipairs(tem) do
		if v.skillCo.type == GameEnum.SkillType.Hero then
			if secondJobIdx == GameEnum.CareerType.Yingxiong then
				table.insert(skills, v.skillCo.id)
			end
		else
			table.insert(skills, v.skillCo.id)
		end
	end

	local playerView = BattleModel.instance:getCharactorById(unit.teamId, unit.id)

	if playerView then
		self._hasCarriedPetId = playerView.isCarriedMaster
	end

	return skills
end

function PetTipsSimpleView:getPsychicSkillsByUnit(unit)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(unit.modelId)

	if secondJobIdx ~= GameEnum.CareerType.Psychic then
		return
	end

	local skills = {}
	local skillList = unit.skillList
	local list = skillList:getSoloTypeSkills()
	local tem = {}

	for k, v in pairs(list or {}) do
		local skco = v.skillCo

		if skco and (skco.type == GameEnum.SkillType.PsychicSkill or skco.type == GameEnum.SkillType.PsychicSkillNormal or skco.type == GameEnum.SkillType.PsychicSkillUtl) or v.isPsychicedNormalSkill or v.isPsychicedUltimateSkill or v.isPsychicSkill then
			table.insert(tem, v)
		end
	end

	ArraySort.sortOn(tem, function(v)
		local skco = v.skillCo

		return GameEnum.SkillNameToType[skco.type]
	end)

	for i, v in ipairs(tem) do
		table.insert(skills, v.skillCo.id)
	end

	return skills
end

function PetTipsSimpleView:setSkills(skillIds, info, skinId, skillCfg)
	skillCfg.items = skillCfg.items or {}

	for i = 1, #skillCfg.items do
		local view = skillCfg.items[i]

		goutil.destroy(view)
	end

	skillCfg.items = {}

	local count = 0

	goutil.clearChildren(skillCfg.negoCon)

	for k, skillId in ipairs(skillIds) do
		local item = goutil.clone(skillCfg.skillBtn, "item" .. k)

		goutil.addChildToParent(item, skillCfg.negoCon)
		GameUtil.SetActive(item, true)
		table.insert(skillCfg.items, item)

		count = count + 1

		local con = goutil.findChild(item, "con")

		GameUtil.addClickHandler(item, GameUtil.handler(self.onClickSkillIdx, self, skillId, count, skinId, skillCfg))

		if count == 1 then
			self:onClickSkillIdx(skillId, count, skinId, skillCfg)
		end

		local proxy = MaterialMgr.setSkillByFaceId(skillId, skinId, con)

		if proxy then
			proxy.binder:showSkillName(false)
			proxy:setAutoTips(false)
			proxy.binder:SetGray(false)

			local skillCo = BattleConfig.instance:getSkillCo(skillId, skinId)
			local type = GameEnum.SkillNameToType[skillCo.type]

			if type == GameEnum.SkillRaceType.JuanYouSkill then
				if not self._hasCarriedPetId then
					proxy.binder:SetGray(true)
				end
			elseif type == GameEnum.SkillRaceType.ShenShiSkill then
				if self._info.__cname == "BagPetMo" or self._info.__cname == "FightingPowerPetMo" then
					if self._info.oraclePetRaceId and self._info.oraclePetRaceId > 0 then
						proxy.binder:SetRaceIdIcon(self._info.oraclePetRaceId)
					end
				elseif self._entity then
					local playerView = BattleModel.instance:getCharactorById(self._entity.teamId, self._entity.id)

					if playerView and playerView.oraclePetId > 0 then
						local playerView2 = BattleModel.instance:getCharactorById(self._entity.teamId, playerView.oraclePetId)

						proxy.binder:SetRaceIdIcon(playerView2.curFaceId)
					end
				end
			end
		end
	end

	if self.adjustPos ~= nil then
		self.adjustPos:AdjustScreenPosition(self.clickPos)
	end
end

function PetTipsSimpleView:onClickSkillIdx(skillId, idx, skinId, skillCfg)
	for i, v in ipairs(skillCfg.items) do
		local select = goutil.findChild(v, "selected")

		GameUtil.SetActive(select, i == idx)
	end

	for i = 1, #self._skills do
		if self._skills[i] ~= skillCfg and self._skills[i].items then
			for j, v in ipairs(self._skills[i].items) do
				local select = goutil.findChild(v, "selected")

				GameUtil.SetActive(select, false)
			end
		end
	end

	self.skillType.text = MaterialMgr.getSkillTypeName(skillId, skinId)

	local desc
	local skillCo = BattleConfig.instance:getSkillCo(skillId, skinId)

	if skillCo then
		local type = GameEnum.SkillNameToType[skillCo.type]
		local skllLvl = checknumber(skillId) % 10
		local lvStr = ""

		if self._info.isMyPackPet then
			if type == GameEnum.SkillRaceType.Ult and self._info.ultimateSkillLv then
				skllLvl = self._info.ultimateSkillLv
			elseif type == GameEnum.SkillRaceType.Normal and self._info.normalSkillLv then
				skllLvl = self._info.normalSkillLv
			elseif type == GameEnum.SkillRaceType.Passive and self._info.passiveSkillLv then
				skllLvl = self._info.passiveSkillLv
			elseif type == GameEnum.SkillRaceType.PsychicSkillNormal and self._info.psychicedNormalSkillLv then
				skllLvl = self._info.psychicedNormalSkillLv
			elseif type == GameEnum.SkillRaceType.PsychicSkillUtl and self._info.psychicedUltimateSkillLv then
				skllLvl = self._info.psychicedUltimateSkillLv
			end
		end

		if not hideLevelSkillType[type] then
			lvStr = " Lv." .. skllLvl
		end

		goutil.clearChildren(self.labelGroup)

		if not skillCo.labelIds then
			local labelIds = {}

			for i, lbId in ipairs(labelIds) do
				local lbCfg = BattleConfig.instance:getSkillLabel(lbId)

				if lbCfg then
					local go = goutil.clone(self.label, "lable_" .. lbCfg.labelId)

					goutil.addChildToParent(go, self.labelGroup)
					GameUtil.SetActive(go, true)

					local comp = go:GetComponent("Image")

					Framework.ColorUtil.SetImageColor(comp, lbCfg.labelColor)

					local txt = goutil.findChildTextComponent(go, "txt")

					txt.text = lbCfg.labelName

					if not string.nilorempty(lbCfg.outlineColor) then
						local color = parsecolor(lbCfg.outlineColor)
						local outline = goutil.findChild(go, "txt"):GetComponent("Outline")

						if outline then
							outline.effectColor = color
						end
					end
				end
			end

			self.skillName.text = skillCo.name .. lvStr
			self.skillDesc.text = type == GameEnum.SkillRaceType.SourceTraceSkill and self._info.sourceTraces and self:_getSourceSkillDesc() or skillCo.desc
		end
	end

	self._scroll.verticalNormalizedPosition = 1
end

function PetTipsSimpleView:_onClickBtnGoGet()
	local raceId = self._info.raceId
	local lvNeed = ChallengeFacade.instance:getChallengeOpenMofangLv(raceId)
	local isOpen = lvNeed <= MofangModel.instance:getCurLv()

	if isOpen then
		UIStateManager.instance:clear(true)
	end

	if not isOpen and self._info and self._info._showSimpleNotOpenTip then
		TipsFacade.instance:openCommonTips(langPara("人物等级达到<color=#e58a29>%s</color>级时才开启哦", lvNeed))
	else
		self:close()
		PetsHandbookFacade.instance:getDefaultWays(raceId)
	end
end

function PetTipsSimpleView:_showHpAndMp()
	local curHp = self._entity.attrs:getCurTempHp()
	local maxHp = self._entity.attrs:getMaxHp()
	local curMp = self._entity.attrs:getCurVigour()
	local maxMp = self._entity.attrs:getMaxVigour()

	self._hpTxt.text = string.format("%d/%d", curHp, maxHp)
	self._mpTxt.text = string.format("%d/%d", curMp, maxMp)

	self._hpProgress:SetProgressPercent(curHp / maxHp)
	self._mpProgress:SetProgressPercent(curMp / maxMp)
	goutil.clearChildren(self.Ext_con)

	local count = 0

	self._buffs = self._entity.buffList:getServerBuffs()

	for i, buff in ipairs(self._buffs or {}) do
		local buffCo = buff.buffCo

		self:addExtItem(buffCo.name)

		count = count + 1
	end

	GameUtil.SetActive(self.Nego_Ext, count > 0)
end

function PetTipsSimpleView:_onBattleHurtData(hurtData)
	if hurtData.target == self._entity or hurtData.attacker == self._entity then
		self:_updateByEntity()
	end
end

function PetTipsSimpleView:_onBattleBuffDamage(target, damage)
	if target == self._entity then
		self:_updateByEntity()
	end
end

function PetTipsSimpleView:_updateByEntity()
	self:_showHpAndMp()
end

function PetTipsSimpleView:_getSourceSkillDesc()
	local effectDesc = ""
	local petCfg = CharacterConfig.instance:getPetCo(self._info.raceId)
	local sourceTraceId = petCfg.sourceTraceId
	local groupInfo = SourceTraceConfig.instance:getGroupInfoCfg(sourceTraceId)
	local activeEffectMap = {}

	if self._info.sourceTraces then
		for i, v in ipairs(self._info.sourceTraces) do
			activeEffectMap[v.effectId] = true
		end
	end

	local mutiNodeIndex = 1
	local nodesCfgs = SourceTraceConfig.instance:getSourceTraceNodeCfgs(sourceTraceId)

	for i, v in ipairs(nodesCfgs) do
		if #v.effectIds > 1 then
			local singleEffectDesc = langPara("源核%s：未激活", GameUtil.toRomanNumber(mutiNodeIndex))

			for j, effectId in ipairs(v.effectIds) do
				if activeEffectMap[effectId] then
					local effectCfg = SourceTraceConfig.instance:getEffectCfg(effectId)

					singleEffectDesc = langPara("源核%s：%s", effectCfg.name, effectCfg.desc)

					break
				end
			end

			if not string.nilorempty(effectDesc) then
				effectDesc = effectDesc .. "\n"
			end

			effectDesc = string.format("%s%s", effectDesc, singleEffectDesc)
			mutiNodeIndex = mutiNodeIndex + 1
		end
	end

	return (string.format("%s\n%s", (groupInfo or nil) and groupInfo.skillBaseDesc, effectDesc))
end

function PetTipsSimpleView:_onClickBag()
	if type(self._canJumpOut) == "function" and not self._canJumpOut() then
		return
	end

	if self._info.__cname == "BagPetMo" or self._info.__cname == "FightingPowerPetMo" or self._info.__cname == "BorrowPetMo" then
		local petId = self._info.petId

		if BagPetsController.instance:getPet(petId) then
			CommonTipsMgr.instance:doWillClose(self, false)
			BagPetsController.instance:openBagPetView(petId)
		end
	end
end

return PetTipsSimpleView
