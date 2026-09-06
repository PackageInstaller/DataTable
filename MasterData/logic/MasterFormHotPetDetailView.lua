-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormHotPetDetailView.lua

module("logic.extensions.masterform.view.MasterFormHotPetDetailView", package.seeall)

local MasterFormHotPetDetailView = class("MasterFormHotPetDetailView", ViewComponent)

function MasterFormHotPetDetailView:ctor()
	MasterFormHotPetDetailView.super.ctor(self)
end

function MasterFormHotPetDetailView:unbindEvents()
	MasterFormHotPetDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._maskGo)
	GameUtil.rmClickHandler(self._btnSource)
end

function MasterFormHotPetDetailView:bindEvents()
	MasterFormHotPetDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._maskGo, self.close, self)
	GameUtil.addClickHandler(self._btnSource, self._onClickSource, self)
end

function MasterFormHotPetDetailView:buildUI()
	MasterFormHotPetDetailView.super.buildUI(self)

	self._maskGo = self:getGo("mask")
	self._btnSource = self:getGo("content/top/btnSource")
	self._petItem = self:getGo("content/top/item")
	self._txtName = self:getTxt("content/top/txtName")
	self._txtInfo = self:getTxt("content/top/txt")
	self._cutePetInfoGo = self:getGo("content/info/tableview/viewport/content/cutePet")
	self._cutePetCon = self:getGo("content/info/tableview/viewport/content/cutePet/petCon")
	self._cutePetName = self:getTxt("content/info/tableview/viewport/content/cutePet/txtName")
	self._cutePetStars = {}

	for i = 1, 6 do
		self._cutePetStars[i] = {
			go = self:getGo("content/info/tableview/viewport/content/cutePet/starLv/star_" .. i),
			change = goutil.findChildComponent(self.mainGO, "content/info/tableview/viewport/content/cutePet/starLv/star_" .. i, "UIImageSpriteChange")
		}
	end

	self._equipInfoGo = self:getGo("content/info/tableview/viewport/content/equip")
	self._equipCells = {}

	for i = 1, 6 do
		self._equipCells[i] = self:getGo("content/info/tableview/viewport/content/equip/equips/equip_" .. i)
	end

	self._starGodInfoGo = self:getGo("content/info/tableview/viewport/content/starGod/starGods")
	self._starGodCells = {}

	for i = 1, 5 do
		local path = "content/info/tableview/viewport/content/starGod/starGods/starGods_" .. i
		local go = self:getGo(path)

		self._starGodCells[i] = {
			go = go,
			btn = goutil.findChild(go, "btn"),
			icon = goutil.findChild(go, "icon"),
			txtLevel = goutil.findChildTextComponent(go, "txt")
		}
	end

	self._skillView = self:getGo("content/info/tableview/viewport/content/skill/tableview/viewport/Nego_Skill")
	self._skillCell = self:getGo("content/info/tableview/viewport/content/skill/cell")
	self._holyStripeInfoGo = self:getGo("content/info/tableview/viewport/content/holyStripe")
	self._holyStripeView = self:getGo("content/info/tableview/viewport/content/holyStripe/tableview/viewport/Nego_Skill")
	self._holyStripeCell = self:getGo("content/info/tableview/viewport/content/holyStripe/cell")
end

function MasterFormHotPetDetailView:onExit()
	MasterFormHotPetDetailView.super.onExit(self)
	self:_clearMaterialCells()
	GameUtil.clearCells(self._skillView, self._clearSkillCell, self)
	GameUtil.clearCells(self._holyStripeView, self._clearHolyStripeCell, self)

	self._raceId = nil
	self._hotPetCfg = nil
end

function MasterFormHotPetDetailView:onEnter()
	MasterFormHotPetDetailView.super.onEnter(self)

	self._raceId = checknumber(self:getFirstParam())
	self._hotPetCfg = MasterFormConfig.instance:getHotPetCfg(self._raceId)

	if self._raceId <= 0 or not self._hotPetCfg then
		printError("MasterFormHotPetDetailView invalid raceId:", self._raceId)

		return
	end

	self:_refreshView()
end

function MasterFormHotPetDetailView:_refreshView()
	self:_refreshPetInfo()
	self:_refreshCutePet()
	self:_refreshEquips()
	self:_refreshStarGods()
	self:_refreshSkills()
	self:_refreshHolyStripes()
end

function MasterFormHotPetDetailView:_refreshPetInfo()
	MaterialMgr.resetAll(self._petItem)

	local proxy = MaterialMgr.setCell(MatType.Pet, self._raceId, self._petItem)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId) or ""
	self._txtInfo.text = FightingPowerFormula.instance:getPetMaxFightingPower(self._raceId)
end

function MasterFormHotPetDetailView:_refreshCutePet()
	local cutePetId = checknumber(self._hotPetCfg.cutePetId)
	local cutePetCfg = CutePetConfig.instance:getCutePetById(cutePetId)

	if cutePetCfg then
		GameUtil.SetActive(self._cutePetInfoGo, true)
	else
		GameUtil.SetActive(self._cutePetInfoGo, false)

		return
	end

	local qualityCfgs = CutePetConfig.instance:getQualityUpPlan(cutePetCfg.qualityUpPlan)

	MaterialMgr.resetAll(self._cutePetCon)

	local proxy = MaterialMgr.setCell(MatType.CutePet, cutePetId, self._cutePetCon)

	if proxy then
		proxy.binder:setQuality(#qualityCfgs)
	end

	self._cutePetName.text = MaterialMgr.getMaterialsName(MatType.CutePet, cutePetId) or ""

	for _, star in ipairs(self._cutePetStars) do
		GameUtil.SetActive(star.go, true)
		star.change:SetState(0)
	end
end

function MasterFormHotPetDetailView:_refreshEquips()
	if not self._hotPetCfg.equipDefineId then
		local equipIds = {}

		GameUtil.SetActive(self._equipInfoGo, #equipIds > 0)

		for i, cell in ipairs(self._equipCells) do
			MaterialMgr.resetAll(cell)
			GameUtil.rmClickHandler(cell)

			local equipId = checknumber(equipIds[i])

			GameUtil.SetActive(cell, equipId > 0)

			if equipId > 0 then
				MaterialMgr.setCell(MatType.Equipment, equipId, cell)
				GameUtil.addClickHandler(cell, GameUtil.handler(self._openMaterialTips, self, cell, MatType.Equipment, equipId, 1))
			end
		end
	end
end

function MasterFormHotPetDetailView:_refreshStarGods()
	if not self._hotPetCfg.starGodsId then
		local starGodIds = {}

		GameUtil.SetActive(self._starGodInfoGo, #starGodIds > 0)

		for i, cell in ipairs(self._starGodCells) do
			MaterialMgr.resetAll(cell.icon)
			GameUtil.rmClickHandler(cell.go)

			local starGodId = checknumber(starGodIds[i])

			GameUtil.SetActive(cell.go, starGodId > 0)

			if starGodId > 0 then
				MaterialMgr.setIcon(cell.icon, MatType.StarGodPlus, starGodId)

				cell.txtLevel.text = "Lv.50"

				GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._openMaterialTips, self, cell.go, MatType.StarGodPlus, starGodId, 50))
			end
		end
	end
end

function MasterFormHotPetDetailView:_refreshSkills()
	local petCfg = PetSkinConfig.instance:getPetSkinCfg(self._raceId)
	local skillIds = {}

	if petCfg then
		for _, skillType in ipairs(MaterialMgr.getAllSkillsSortedKeys()) do
			local skillKey = MaterialMgr.getSkillKeyNameByType(skillType)
			local skillId = checknumber(petCfg[skillKey])

			if skillId > 0 then
				table.insert(skillIds, skillId)
			end
		end
	end

	GameUtil.updateCellsList(self._skillView, self._skillCell, skillIds, self._updateSkillCell, self)
end

function MasterFormHotPetDetailView:_updateSkillCell(cell, skillId)
	local icon = goutil.findChild(cell, "icon")
	local txtSkillType = goutil.findChildTextComponent(cell, "txtSkillType")
	local skillCfg = BattleConfig.instance:getSkillCo(skillId)

	MaterialMgr.resetAll(icon)
	MaterialMgr.setSkillByFaceId(skillId, self._raceId, icon)
	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._openMaterialTips, self, cell, MatType.Skill, skillId, self._raceId))

	txtSkillType.text = skillCfg.type
end

function MasterFormHotPetDetailView:_clearSkillCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell, "icon"))
	GameUtil.rmClickHandler(cell)
end

function MasterFormHotPetDetailView:_refreshHolyStripes()
	if not self._hotPetCfg.holyStripeId then
		local holyStripeIds = {}

		GameUtil.SetActive(self._holyStripeInfoGo, #holyStripeIds > 0)
		GameUtil.updateCellsList(self._holyStripeView, self._holyStripeCell, holyStripeIds, self._updateHolyStripeCell, self)
	end
end

function MasterFormHotPetDetailView:_updateHolyStripeCell(cell, holyStripeId)
	local con = goutil.findChild(cell, "con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local id = checknumber(holyStripeId)
	local holyStripeCfg = HolyStripeConfig.instance:getHolyStripeCfg(id)

	GameUtil.rmClickHandler(cell)
	MaterialMgr.resetAll(con)

	txtName.text = ""

	if holyStripeCfg then
		txtName.text = holyStripeCfg.name

		MaterialMgr.setCell(MatType.HolyStripe, id, con)
		GameUtil.addClickHandler(cell, GameUtil.handler(self._openMaterialTips, self, cell, MatType.HolyStripe, id))
	end
end

function MasterFormHotPetDetailView:_clearHolyStripeCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell, "con"))
	GameUtil.rmClickHandler(cell)
end

function MasterFormHotPetDetailView:_clearMaterialCells()
	MaterialMgr.resetAll(self._petItem)
	MaterialMgr.resetAll(self._cutePetCon)

	for _, cell in ipairs(self._equipCells or {}) do
		MaterialMgr.resetAll(cell)
		GameUtil.rmClickHandler(cell)
	end

	for _, cell in ipairs(self._starGodCells or {}) do
		MaterialMgr.resetAll(cell.icon)
		GameUtil.rmClickHandler(cell.go)
	end
end

function MasterFormHotPetDetailView:_openMaterialTips(anchor, matType, id, extData1)
	CommonTipsMgr.instance:openMaterialTips(anchor, matType, id, extData1)
end

function MasterFormHotPetDetailView:_onClickSource()
	UIStateManager.instance:push(ViewName.PetSource, self._raceId)
end

return MasterFormHotPetDetailView
