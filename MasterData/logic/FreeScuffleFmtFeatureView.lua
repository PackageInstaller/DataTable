-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleFmtFeatureView.lua

module("logic.extensions.freescuffle.view.FreeScuffleFmtFeatureView", package.seeall)

local FreeScuffleFmtFeatureView = class("FreeScuffleFmtFeatureView", ViewComponent)

function FreeScuffleFmtFeatureView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self.heroskillCell = self:getGo("heroSkill/heroskillCell")
	self.heroSkillTableview = self:getGo("heroSkill/tableview")
	self._txtHeroSkillTip = self:getGo("heroSkill/txtHeroSkillTip")
	self.bondCell = self:getGo("bond/bondCell")
	self.bondTableview = self:getGo("bond/tableview")
	self._txtBondTip = self:getGo("bond/txtBondTip")
	self.fusionskillCell = self:getGo("fusionSkill/fusionskillCell")
	self.fusionskillTableView = self:getGo("fusionSkill/tableview")
	self._txtFusionSkillTip = self:getGo("fusionSkill/txtFusionSkillTip")
	self.heroScrollList = ScrollerList.create(self.heroSkillTableview, self.heroskillCell, GameUtil.handler(self._updateHeroCell, self), GameUtil.handler(self.clearHeroCell, self))
	self.bondScrollList = ScrollerList.create(self.bondTableview, self.bondCell, GameUtil.handler(self._updateBondCell, self), GameUtil.handler(self.clearBondCell, self))
	self.fusionScrollList = ScrollerList.create(self.fusionskillTableView, self.fusionskillCell, GameUtil.handler(self._updateFusionCell, self), GameUtil.handler(self.clearFusionCell, self))
end

function FreeScuffleFmtFeatureView:onExit()
	self.heroScrollList:dispose()
	self.bondScrollList:dispose()
	self.fusionScrollList:dispose()
	GlobalDispatcher:dispatch(GlobalNotify.FormationHeroSkillChanged, self._curHeroSkillId, self._curHeroPetId)

	self._curHeroSkillId = nil
end

function FreeScuffleFmtFeatureView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function FreeScuffleFmtFeatureView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function FreeScuffleFmtFeatureView:onEnter()
	local params = self:getOpenParam()

	self._heroSkillIds = params[1] or {}
	self._curHeroPetId = params[2]
	self._restrainCfgs = params[3]
	self._formation = params[5]
	self._bagPetMoDic = params[4]

	local boundList = {}

	for name, cfg in pairs(self._restrainCfgs) do
		table.insert(boundList, cfg)
	end

	self.bondScrollList:reloadData(boundList)
	goutil.setActive(self._txtBondTip, #boundList == 0)

	if #self._heroSkillIds == 0 then
		self._curHeroSkillId = nil
		self._curHeroPetId = nil
	end

	local infoList = {}

	for _, v in ipairs(self._heroSkillIds) do
		local info = {}

		info.skillId = v.skillId
		info.petId = v.petId
		info.petMo = nil

		for _, petMo in pairs(self._formation) do
			if petMo:getPetId() == v.petId then
				info.petMo = petMo

				break
			end
		end

		table.insert(infoList, info)
	end

	self.heroScrollList:reloadData(infoList)
	goutil.setActive(self._txtHeroSkillTip, #infoList == 0)

	self._fusionSkillIds = FightingPowerFormula.instance:getCombinationValidSkills(self._formation) or {}

	self.fusionScrollList:reloadData(self._fusionSkillIds)
	goutil.setActive(self._txtFusionSkillTip, #self._fusionSkillIds == 0)
end

function FreeScuffleFmtFeatureView:_updateHeroCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "scroll/viewport/content/txtDesc")
	local headIcon = goutil.findChild(cell, "headIcon")
	local selectGo = goutil.findChild(cell, "select")
	local scrollRect = goutil.findChild(cell, "scroll"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	local pet = goutil.findChild(cell, "pet")
	local petIcon = goutil.findChild(cell, "pet/icon")
	local heroSkillId = data.skillId
	local petId = data.petId
	local petMo = data.petMo

	scrollRect.verticalNormalizedPosition = 1

	if petMo then
		if not petMo.curFaceId then
			local skinId = 0

			if skinId > 0 then
				MaterialMgr.setIcon(petIcon, MatType.Pet, skinId, nil, nil)
			else
				MaterialMgr.clearIcon(petIcon)
			end

			GameUtil.SetActive(pet, skinId > 0)
			GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickHeroSkillSelect, self, heroSkillId, petMo))
			GameUtil.addClickHandler(headIcon, GameUtil.handler(self._onClickHeroSkill, self, heroSkillId, headIcon))

			local isSelect = self._curHeroPetId == petId

			goutil.setActive(selectGo, isSelect)
			uGuiUtil.clearImage(headIcon)

			local cfg = BattleConfig.instance:getSkillCo(heroSkillId)

			if cfg then
				txtName.text = cfg.name
				txtDesc.text = cfg.desc

				uGuiUtil.setSpriteToImage(headIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl("skill_" .. heroSkillId))
			else
				txtName.text = heroSkillId
				txtDesc.text = ""
			end
		end
	end
end

function FreeScuffleFmtFeatureView:clearHeroCell(cell)
	local pet = goutil.findChild(cell, "pet")
	local headIcon = goutil.findChild(cell, "headIcon")

	uGuiUtil.clearImage(headIcon)
	GameUtil.SetActive(pet, false)
end

function FreeScuffleFmtFeatureView:_updateBondCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtSkillDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local petIcon1 = goutil.findChild(cell, "pet_1/con")
	local petIcon2 = goutil.findChild(cell, "pet_2/con")
	local raceId1 = data.raceId
	local raceId2 = data.relativeRaceIds[1]
	local bagPetMo1 = self._bagPetMoDic[raceId1]
	local bagPetMo2 = self._bagPetMoDic[raceId2]

	txtName.text = data.name

	if bagPetMo1 then
		MaterialMgr.setIcon(petIcon1, MatType.PET_SKIN, bagPetMo1.curFaceId)
	else
		MaterialMgr.setIcon(petIcon2, MatType.PET_SKIN, raceId1)
	end

	if bagPetMo2 then
		MaterialMgr.setIcon(petIcon2, MatType.PET_SKIN, bagPetMo2.curFaceId)
	else
		MaterialMgr.setIcon(petIcon2, MatType.PET_SKIN, raceId2)
	end

	txtSkillDesc.text = data.desc
end

function FreeScuffleFmtFeatureView:clearBondCell(cell)
	local petIcon1 = goutil.findChild(cell, "pet_1/con")
	local petIcon2 = goutil.findChild(cell, "pet_2/con")

	MaterialMgr.clearIcon(petIcon1)
	MaterialMgr.clearIcon(petIcon2)
end

function FreeScuffleFmtFeatureView:_updateFusionCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "scroll/viewport/content/txtDesc")
	local headIcon = goutil.findChild(cell, "headIcon")
	local selectGo = goutil.findChild(cell, "select")
	local heroSkillId = data

	GameUtil.addClickHandler(headIcon, GameUtil.handler(self._onClickHeroSkill, self, heroSkillId, cell))

	local isSelect = false

	goutil.setActive(selectGo, isSelect)
	uGuiUtil.clearImage(headIcon)

	local cfg = BattleConfig.instance:getSkillCo(heroSkillId)

	if cfg then
		txtName.text = cfg.name
		txtDesc.text = cfg.desc

		uGuiUtil.setSpriteToImage(headIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl("skill_" .. heroSkillId))
	else
		txtName.text = heroSkillId
		txtDesc.text = ""
	end
end

function FreeScuffleFmtFeatureView:clearFusionCell(cell)
	local headIcon = goutil.findChild(cell, "headIcon")

	uGuiUtil.clearImage(headIcon)
end

function FreeScuffleFmtFeatureView:_onClickClose()
	self:close()
end

function FreeScuffleFmtFeatureView:_onClickHeroSkill(heroSkillId, go)
	CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, heroSkillId)
end

function FreeScuffleFmtFeatureView:_onClickHeroSkillSelect(heroSkillId, petMo)
	self._curHeroSkillId = heroSkillId
	self._curHeroPetId = petMo:getPetId()

	self.heroScrollList:refresh()
end

return FreeScuffleFmtFeatureView
