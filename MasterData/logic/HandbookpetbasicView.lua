-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetbasicView.lua

module("logic.extensions.handbook.view.HandbookpetbasicView", package.seeall)

local HandbookpetbasicView = class("HandbookpetbasicView", ViewComponent)

function HandbookpetbasicView:buildUI()
	HandbookpetbasicView.super.buildUI(self)

	local scrollPath = "scroll/Viewport/Content/"

	self._content = goutil.findChild(self.mainGO, scrollPath)
	self._txtStrategy = goutil.findChildTextComponent(self.mainGO, scrollPath .. "strategy/txtStrategy")
	self._txtBestPosition = goutil.findChildTextComponent(self.mainGO, scrollPath .. "strategy/txtBestPosition")
	self._bondCell = self:getGo("bondcell")
	self._contentSizeFitter = self._content:GetComponent("ContentSizeFitter")

	self:_buildSkillsNode(scrollPath)
	GameUtil.SetActive(self._bondCell, false)
end

function HandbookpetbasicView:_buildSkillsNode(scrollPath)
	local scrollPath = "scroll/Viewport/Content/"
	local skillNode = goutil.findChild(self.mainGO, scrollPath .. "skill")

	self._Nego_Skill = goutil.findChild(self.mainGO, scrollPath .. "skill/tableview/viewport/Nego_Skill")

	local skillCell = goutil.findChild(self.mainGO, scrollPath .. "skill/cell")

	self._Skills = {}

	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(self._Nego_Skill.transform, false)

		self._Skills[#self._Skills + 1] = go
	end

	self._psychicSkillNode = goutil.clone(skillNode)
	self._psychicSkillNode.name = "psychicSkills"

	self._psychicSkillNode.transform:SetParent(skillNode.transform.parent, false)

	local siblingIndex = skillNode.transform:GetSiblingIndex()

	self._psychicSkillNode.transform:SetSiblingIndex(siblingIndex + 1)

	self._psychicNegoSkill = goutil.findChild(self._psychicSkillNode, "tableview/viewport/Nego_Skill")

	local psychicSkillCell = goutil.findChild(self._psychicSkillNode, "cell")

	self._psychicSkills = {}

	local psychicSkillSortedKeys = MaterialMgr.getPsychicSkillSortedKeys()

	for index, skillType in ipairs(psychicSkillSortedKeys) do
		local go = goutil.clone(psychicSkillCell)

		go.transform:SetParent(self._psychicNegoSkill.transform, false)

		self._psychicSkills[#self._psychicSkills + 1] = go
	end

	local psychicText = goutil.findChildTextComponent(self._psychicSkillNode, "bg_skill/Text")

	psychicText.text = "通灵"
end

function HandbookpetbasicView:bindEvents()
	HandbookpetbasicView.super.bindEvents(self)
end

function HandbookpetbasicView:unbindEvents()
	HandbookpetbasicView.super.unbindEvents(self)
end

function HandbookpetbasicView:destroyUI()
	HandbookpetbasicView.super.destroyUI(self)
end

function HandbookpetbasicView:onEnter()
	HandbookpetbasicView.super.onEnter(self)
	self:refresh()
	GlobalDispatcher:addListener(GlobalNotify.HandBookPetSelect, self.refresh, self)
end

function HandbookpetbasicView:onEnterFinished()
	HandbookpetbasicView.super.onEnterFinished(self)
end

function HandbookpetbasicView:onExit()
	HandbookpetbasicView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookPetSelect, self.refresh, self)
	removetimer(self._refreshLayout, self)
	removetimer(self._finishLayout, self)

	for i = 1, #self._Skills do
		local go = self._Skills[i]
		local con = goutil.findChild(go, "icon")

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)
	end

	for i = 1, #self._psychicSkills do
		local go = self._psychicSkills[i]
		local con = goutil.findChild(go, "icon")

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)
	end

	for i = 1, #self._bondCells do
		self:_clearCell(self._bondCells[i])
	end
end

function HandbookpetbasicView:onExitFinished()
	HandbookpetbasicView.super.onExitFinished(self)
end

function HandbookpetbasicView:refresh()
	self._raceId = PetbookModel.instance:getSelectedPetRaceId()

	local detail_cfg = HandbookConfig.instance:getPetDetailsCfgById(self._raceId)
	local petInfo = CharacterConfig.instance:getPetInfoCo(self._raceId)

	self._txtBestPosition.text = string.format("推荐站位: <color=#4F569BFF>%s</color>", petInfo.bestPosition)
	self._txtStrategy.text = string.gsub(petInfo.stragegy, "\n", "，")

	self:_refreshSkills(MaterialMgr.getSkillSortedKeys(), self._Skills)
	self:_refreshSkills(MaterialMgr.getPsychicSkillSortedKeys(), self._psychicSkills)

	local hasPsychicSkills = false

	for i = 1, #self._psychicSkills do
		if self._psychicSkills[i].activeSelf then
			hasPsychicSkills = true
		end
	end

	self._psychicSkillNode:SetActive(hasPsychicSkills)

	local cfgsOnForm = CharacterConfig.instance:getBondCfgsOnForm(self._raceId) or {}
	local cfgsCollect = CharacterConfig.instance:getBondCfgsCollect(self._raceId) or {}

	self._bondCells = self._bondCells or {}

	for i = #self._bondCells, #cfgsOnForm + #cfgsCollect - 1 do
		table.insert(self._bondCells, goutil.cloneAndSetParent(self._bondCell, self._content.transform))
	end

	for i = #self._bondCells, #cfgsOnForm + #cfgsCollect + 1, -1 do
		self:_destroyCell(self._bondCells[i])
		table.remove(self._bondCells, i)
	end

	for i = 1, #cfgsOnForm do
		self:_setCell(self._bondCells[i], cfgsOnForm[i], true)
	end

	for i = 1, #cfgsCollect do
		self:_setCell(self._bondCells[i + #cfgsOnForm], cfgsCollect[i], false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._content.gameObject.transform)
end

function HandbookpetbasicView:_refreshSkills(sortedKeys, skillGoList)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(self._raceId)

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.getSkillKeyNameByType(skillType)
		local go = skillGoList[index]
		local con = goutil.findChild(go, "icon")
		local txtSkillName = goutil.findChildTextComponent(go, "txt_skillname")
		local skillId = petCo[v]
		local imgSkillType = goutil.findChild(go, "imgSkillType")
		local skillCfg = BattleConfig.instance:getSkillCo(skillId)

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)

		if skillId == 0 then
			go:SetActive(false)
		else
			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(skillId, self._raceId, con)

			if proxy then
				proxy:setAutoTips(false)
			end

			GameUtil.asBtn(go):AddClickListener(GameUtil.handler(self._OnClickSkill, self, skillType, skillId, go))

			local skicon = skillCfg.skillTagImg

			uGuiUtil.setSpriteToImage(imgSkillType.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))

			txtSkillName.text = skillCfg.name
		end

		if skillType == GameEnum.SkillRaceType.Summon then
			go:SetActive(false)
		end
	end
end

function HandbookpetbasicView:_setCell(cell, cfg, isOnForm)
	self:_clearCell(cell)

	if not cfg then
		return
	end

	GameUtil.SetActive(cell.gameObject, true)

	local goOnForm = goutil.findChild(cell, "titleOnForm")
	local goCollect = goutil.findChild(cell, "titleCollect")

	GameUtil.SetActive(goOnForm, isOnForm)
	GameUtil.SetActive(goCollect, not isOnForm)

	local goTxt = goutil.findChild(cell, "bg/txtAcTip")
	local txtAcTip = goutil.findChildTextComponent(cell, "bg/txtAcTip")
	local txtDesc = goutil.findChildTextComponent(cell, "bg/txtDesc")
	local txtName = goutil.findChildTextComponent(cell, "bg/name/txt")
	local txtDescCha = goutil.findChildComponent(cell, "bg/txtDesc", "UITextColorChange")

	GameUtil.SetActive(goTxt, isOnForm)

	local petCellList = {}
	local pet = {}

	pet.go = goutil.findChild(cell, "bg/petListInBondExt/pet_" .. 1)
	pet.iconHead = goutil.findChild(pet.go, "iconHead")
	pet.btn = goutil.findChild(pet.go, "bg")
	pet.bg = goutil.findChildComponent(pet.go, "bg", "UIImageSpriteChange")
	petCellList[1] = pet

	for i = 2, 4 do
		local pet = {}

		pet.go = goutil.findChild(cell, "bg/petListInBondExt/other/pet_" .. i)
		pet.iconHead = goutil.findChild(pet.go, "iconHead")
		pet.btn = goutil.findChild(pet.go, "bg")
		pet.bg = goutil.findChildComponent(pet.go, "bg", "UIImageSpriteChange")
		petCellList[i] = pet
	end

	local petlist = {}
	local petlistInCfg = cfg.relativeRaceIds

	table.insert(petlist, 1, self._raceId)

	for i = 1, #petlistInCfg do
		table.insert(petlist, petlistInCfg[i])
	end

	for i = 1, #petlist do
		local raceId = petlist[i]
		local petCo = CharacterConfig.instance:getPetCo(raceId)
		local rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, petCo.raceId)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

		petCellList[i].bg:SetState(tonumber(rare + 1))

		local starGo = goutil.findChild(petCellList[i].go, "stars")

		GameUtil.SetActive(starGo, false)

		local starItem = PetStarItem.New(starGo, true)
		local curLv = petCo.initAwakenLv

		starItem:updateStar(curLv)
		uGuiUtil.setSpriteToImage(petCellList[i].iconHead, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		GameUtil.SetActive(petCellList[i].go, true)
		GameUtil.addClickHandler(petCellList[i].btn, GameUtil.handler(self._onClickPetCell, self, raceId, curLv))
	end

	txtName.text = cfg.name

	local isActive = true
	local showDesc, matchTime = string.gsub(cfg.desc, "%%s", "")

	if isActive then
		showDesc = cfg.desc

		if matchTime > 0 then
			for i = 1, matchTime - 1 do
				showDesc = i % 2 == 1 and string.gsub(showDesc, "%%s", "<color=red>", 1) or string.gsub(showDesc, "%%s", "</color>", 1)
			end

			showDesc = matchTime % 2 == 1 and string.gsub(showDesc, "%%s", "", 1) or string.gsub(showDesc, "%%s", "</color>", 1) or showDesc
		end
	end

	txtDesc.text = showDesc

	if isOnForm then
		local awakenName = CharacterConfig.instance:getAwakenName(cfg.activeNeedAwakenLv)

		txtAcTip.text = string.format(lang("handbookpetbasicview__tips"), "", awakenName, "")
	end
end

function HandbookpetbasicView:_destroyCell(cell)
	self:_clearCell(cell)
	goutil.destroy(cell)
end

function HandbookpetbasicView:_clearCell(cell)
	local petListInBond = goutil.findChild(cell, "bg/petListInBondExt")
	local pet = goutil.findChild(petListInBond, "pet_" .. 1)

	uGuiUtil.clearImage(goutil.findChild(pet, "iconHead"))
	GameUtil.rmClickHandler(goutil.findChild(pet, "bg"))
	GameUtil.SetActive(pet, false)

	for i = 2, 4 do
		local pet = goutil.findChild(petListInBond, "other/pet_" .. i)

		uGuiUtil.clearImage(goutil.findChild(pet, "iconHead"))
		GameUtil.rmClickHandler(goutil.findChild(pet, "bg"))
		GameUtil.SetActive(pet, false)
	end
end

function HandbookpetbasicView:_OnClickSkill(skillType, skillId, go)
	CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, self._raceId)
end

function HandbookpetbasicView:_refreshLayout()
	if self._bondCells then
		for _, v in ipairs(self._bondCells) do
			self:_refreshCellLayout(v)
		end
	end
end

function HandbookpetbasicView:_refreshCellLayout(cell)
	return
end

function HandbookpetbasicView:_finishLayout()
	if self._bondCells then
		for _, v in ipairs(self._bondCells) do
			self:_finishCellLayout(v)
		end
	end
end

function HandbookpetbasicView:_finishCellLayout(cell, isFirst)
	return
end

function HandbookpetbasicView:_onClickPetCell(raceId, curLv)
	CommonTipsMgr.instance:showMaxLvlPetTips(raceId, curLv)
end

return HandbookpetbasicView
