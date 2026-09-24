-- chunkname: @modules/logic/matchgame/fight/view/MatchGameMemberInfoView.lua

module("modules.logic.matchgame.fight.view.MatchGameMemberInfoView", package.seeall)

local MatchGameMemberInfoView = class("MatchGameMemberInfoView", BaseView)

function MatchGameMemberInfoView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "fightinfocontainer/#btn_close")
	self._gochess = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_chess")
	self._gohero = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_chess/#go_hero")
	self._goheroMesh = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_chess/#go_hero/go_hero/#go_heroMesh")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "fightinfocontainer/#go_chess/#go_hero/go_hero/#simage_hero")
	self._imagehero = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_chess/#go_hero/go_hero/#simage_hero")
	self._txtheroHp = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_chess/#go_hero/go_hp/#txt_heroHp")
	self._imagehp = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_chess/#go_hero/go_hp/#image_hp")
	self._goenemy = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_chess/#go_enemy")
	self._goenemyMesh = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_chess/#go_enemy/go_enemy/#go_enemyMesh")
	self._simageenemy = gohelper.findChildSingleImage(self.viewGO, "fightinfocontainer/#go_chess/#go_enemy/go_enemy/#simage_enemy")
	self._imageenemy = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_chess/#go_enemy/go_enemy/#simage_enemy")
	self._txtenemyHp = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_chess/#go_enemy/go_hp/#txt_enemyHp")
	self._imageenemyHp = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_chess/#go_enemy/go_hp/#image_enemyHp")
	self._imageenemyCareer = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_chess/#go_enemy/go_hp/#image_enemyCareer")
	self._goinfoView = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_infoView/#image_career")
	self._txtname = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_infoView/#txt_name")
	self._goheroSkillEnergy = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/#go_heroSkillEnergy")
	self._txtskillEnergy = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_infoView/#go_heroSkillEnergy/#txt_skillEnergy")
	self._imageskillEnergyBar = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_infoView/#go_heroSkillEnergy/#image_skillEnergyBar")
	self._scrollSkill = gohelper.findChildScrollRect(self.viewGO, "fightinfocontainer/#go_infoView/#scroll_Skill")
	self._goskillContent = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/#scroll_Skill/Viewport/#go_skillContent")
	self._goskillItem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/#scroll_Skill/Viewport/#go_skillContent/#go_skillItem")
	self._scrollmember = gohelper.findChildScrollRect(self.viewGO, "fightinfocontainer/#scroll_member")
	self._gomemberContent = gohelper.findChild(self.viewGO, "fightinfocontainer/#scroll_member/Viewport/#go_memberContent")
	self._gomemberItem = gohelper.findChild(self.viewGO, "fightinfocontainer/#scroll_member/Viewport/#go_memberContent/#go_memberItem")
	self._goswitch = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_switch")
	self._btnheroTag = gohelper.findChildButtonWithAudio(self.viewGO, "fightinfocontainer/#go_switch/#btn_heroTag")
	self._goselectHero = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_switch/#btn_heroTag/#go_selectHero")
	self._btnenemyTag = gohelper.findChildButtonWithAudio(self.viewGO, "fightinfocontainer/#go_switch/#btn_enemyTag")
	self._goselectEnemy = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_switch/#btn_enemyTag/#go_selectEnemy")
	self._gofeverBar = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_feverBar")
	self._imagefeverBar = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_feverBar/#image_feverBar")
	self._gofeverNormal = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_feverBar/#go_feverNormal")
	self._gofeverFull = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_feverBar/#go_feverFull")
	self._txtfeverNum = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_feverBar/#txt_feverNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameMemberInfoView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnheroTag:AddClickListener(self._btnheroTagOnClick, self)
	self._btnenemyTag:AddClickListener(self._btnenemyTagOnClick, self)
end

function MatchGameMemberInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnheroTag:RemoveClickListener()
	self._btnenemyTag:RemoveClickListener()
end

function MatchGameMemberInfoView:_btncloseOnClick()
	self:closeThis()
end

function MatchGameMemberInfoView:_btnheroTagOnClick()
	if self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Hero then
		return
	end

	self.curMemberTag = MatchGameFightEnum.MemberInfoTag.Hero
	self.curMemberIndex = 1

	self:refreshMemberList()
	self:refreshUI()
end

function MatchGameMemberInfoView:_btnenemyTagOnClick()
	if self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Enemy then
		return
	end

	self.curMemberTag = MatchGameFightEnum.MemberInfoTag.Enemy
	self.curMemberIndex = 1

	self:refreshMemberList()
	self:refreshUI()
end

function MatchGameMemberInfoView:_btnmemberItemClick(memberItem)
	if self.curMemberIndex == memberItem.index then
		return
	end

	self.curMemberIndex = memberItem.index

	self:refreshUI()
end

function MatchGameMemberInfoView:_editableInitView()
	self.memberItemList = self:getUserDataTb_()
	self.skillItemList = self:getUserDataTb_()

	gohelper.setActive(self._gomemberItem, false)
	gohelper.setActive(self._goskillItem, false)

	self.heroMeshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goheroMesh, MatchGameFightRoleMesh)
	self.enemyMeshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goenemyMesh, MatchGameFightRoleMesh)
end

function MatchGameMemberInfoView:onUpdateParam()
	return
end

function MatchGameMemberInfoView:onOpen()
	if self.viewParam then
		self.fightData = self.viewParam.fightData or {}
	end

	self.isInFight = self.fightData and next(self.fightData)

	if self.viewParam then
		self.matchLevelId = self.viewParam.matchLevelId or MatchGameFightEnum.TestLevelId
	end

	if self.viewParam then
		self.curMemberTag = self.viewParam.memberTag or MatchGameFightEnum.MemberInfoTag.Enemy
	end

	if self.viewParam then
		self.curMemberIndex = self.viewParam.curMemberIndex or 1
	end

	self.matchLevelConfig = MatchGameConfig.instance:getLevelConfig(self.matchLevelId)

	local roleMaterial = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes[1])

	self.heroMat = UnityEngine.GameObject.Instantiate(roleMaterial)
	self.enemyMat = UnityEngine.GameObject.Instantiate(roleMaterial)

	self:refreshMemberList()
	self:refreshUI()
	gohelper.setActive(self._goswitch, self.isInFight)
end

function MatchGameMemberInfoView:refreshUI()
	self:refreshSelectState()
	self:refreshMemberInfo()
	self:refreshTagUI()
	self:refreshSkillInfo()
end

function MatchGameMemberInfoView:refreshMemberList()
	if self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Enemy then
		self:refreshEnemyMemberList()
	else
		self:refreshHeroMemberList()
	end
end

function MatchGameMemberInfoView:refreshEnemyMemberList()
	local monsterIdList = string.splitToNumber(self.matchLevelConfig.monsterId, "#")

	if self.isInFight then
		local enemyId = self.fightData.enemyInfoMo.id

		monsterIdList = {
			enemyId
		}
	end

	for index, monsterId in ipairs(monsterIdList) do
		local monsterConfig = MatchGameFightConfig.instance:getMonsterConfig(monsterId)
		local memberItem = self:getMemberItem(index)

		memberItem.monterConfig = monsterConfig

		gohelper.setActive(memberItem.go, true)
		gohelper.setActive(memberItem.goEnemy, true)
		gohelper.setActive(memberItem.goHero, false)
		gohelper.setActive(memberItem.enemyItemUI.goEnergyBar, false)
		UISpriteSetMgr.instance:setMatchGameSprite(memberItem.enemyItemUI.imageCareer, "icon_career" .. monsterConfig.career)

		local careerBgColor = MatchGameFightEnum.CareerColor[monsterConfig.career]

		SLFramework.UGUI.GuiHelper.SetColor(memberItem.enemyItemUI.imageCareerBg, careerBgColor)
		memberItem.enemyItemUI.simageIcon:LoadImage(ResUrl.monsterHeadIcon(monsterConfig.icon))
	end

	for index = #monsterIdList + 1, #self.memberItemList do
		gohelper.setActive(self.memberItemList[index].go, false)
	end
end

function MatchGameMemberInfoView:refreshHeroMemberList()
	local heroFightInfoMap = MatchGameFightModel.instance:getHeroFightInfoMap()
	local heroFightMoList = {}

	for index, heroFightInfo in pairs(heroFightInfoMap) do
		if heroFightInfo.id > 0 then
			table.insert(heroFightMoList, heroFightInfo)
		end
	end

	table.sort(heroFightMoList, function(a, b)
		return a.posIndex < b.posIndex
	end)

	for index, heroFightMo in ipairs(heroFightMoList) do
		local memberItem = self:getMemberItem(index)

		gohelper.setActive(memberItem.go, true)
		gohelper.setActive(memberItem.goHero, true)
		gohelper.setActive(memberItem.heroItemUI.goEnergyBar, true)
		gohelper.setActive(memberItem.goEnemy, false)

		memberItem.heroFightMo = heroFightMo

		local energyFillAmount = Mathf.Min(heroFightMo.energy, heroFightMo.maxEnergy) / heroFightMo.maxEnergy

		memberItem.heroItemUI.imageEnergy.fillAmount = Mathf.Lerp(MatchGameFightEnum.MinEnergyFillAmount, MatchGameFightEnum.MaxEnergyFillAmount, energyFillAmount)

		UISpriteSetMgr.instance:setMatchGameSprite(memberItem.heroItemUI.imageCareer, "icon_career" .. heroFightMo.career)

		local careerBgColor = MatchGameFightEnum.CareerColor[heroFightMo.career]

		SLFramework.UGUI.GuiHelper.SetColor(memberItem.heroItemUI.imageCareerBg, careerBgColor)

		local barResName = string.format("matchgamefight_skill_bar%s_%s", heroFightMo.career, heroFightMo.energy >= heroFightMo.maxEnergy and 2 or 1)

		UISpriteSetMgr.instance:setMatchGameSprite(memberItem.heroItemUI.imageEnergy, barResName)
		memberItem.heroItemUI.simageIcon:LoadImage(ResUrl.getHeadIconSmall(heroFightMo.config.icon))
	end

	for index = #heroFightMoList + 1, #self.memberItemList do
		gohelper.setActive(self.memberItemList[index].go, false)
	end
end

function MatchGameMemberInfoView:getMemberItem(index)
	local memberItem = self.memberItemList[index]

	if not memberItem then
		memberItem = {
			go = gohelper.clone(self._gomemberItem, self._gomemberContent, "go_memberItem_" .. index)
		}
		memberItem.goHero = gohelper.findChild(memberItem.go, "go_hero")
		memberItem.goEnemy = gohelper.findChild(memberItem.go, "go_enemy")
		memberItem.heroItemUI = self:getCommonMemberItemUI(memberItem.goHero)
		memberItem.enemyItemUI = self:getCommonMemberItemUI(memberItem.goEnemy)
		memberItem.btnClick = gohelper.findChildButtonWithAudio(memberItem.go, "btn_click")

		memberItem.btnClick:AddClickListener(self._btnmemberItemClick, self, memberItem)

		memberItem.index = index
		self.memberItemList[index] = memberItem
	end

	return memberItem
end

function MatchGameMemberInfoView:getCommonMemberItemUI(rootGO)
	local itemUI = {}

	itemUI.goSelect = gohelper.findChild(rootGO, "go_select")
	itemUI.goEnergyBar = gohelper.findChild(rootGO, "skillBar")
	itemUI.imageEnergy = gohelper.findChildImage(rootGO, "skillBar/image_skillBar")
	itemUI.simageIcon = gohelper.findChildSingleImage(rootGO, "HeadMask/simage_icon")
	itemUI.imageCareer = gohelper.findChildImage(rootGO, "image_career")
	itemUI.imageCareerBg = gohelper.findChildImage(rootGO, "image_careerBg")
	itemUI.goSelect = gohelper.findChild(rootGO, "go_select")

	return itemUI
end

function MatchGameMemberInfoView:refreshSelectState()
	for index, memberItem in ipairs(self.memberItemList) do
		if self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Hero then
			gohelper.setActive(memberItem.heroItemUI.goSelect, memberItem.index == self.curMemberIndex)
		else
			gohelper.setActive(memberItem.enemyItemUI.goSelect, memberItem.index == self.curMemberIndex)
		end
	end
end

function MatchGameMemberInfoView:refreshMemberInfo()
	if self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Enemy then
		gohelper.setActive(self._gohero, false)
		gohelper.setActive(self._gofeverBar, false)
		gohelper.setActive(self._goenemy, true)
		gohelper.setActive(self._goheroSkillEnergy, false)

		if self.isInFight then
			self._txtenemyHp.text = string.format("%s/%s", self.fightData.enemyInfoMo.hp, self.fightData.enemyInfoMo.maxHp)
			self._imageenemyHp.fillAmount = self.fightData.enemyInfoMo.hp / self.fightData.enemyInfoMo.maxHp

			self._simageenemy:LoadImage(self.fightData.enemyInfoMo.enemyCoData.config.image, self.setEnemyImageSize, self)

			self._imageenemy.material = self.enemyMat

			self.enemyMeshComp:refreshMesh(self.fightData.enemyInfoMo.enemyCoData.config, true)

			self._txtname.text = self.fightData.enemyInfoMo.name

			UISpriteSetMgr.instance:setMatchGameSprite(self._imagecareer, "icon_career" .. self.fightData.enemyInfoMo.career)
			UISpriteSetMgr.instance:setMatchGameSprite(self._imageenemyCareer, "icon_career" .. self.fightData.enemyInfoMo.career)
		else
			local memberItem = self.memberItemList[self.curMemberIndex]

			if memberItem.monterConfig then
				local attrConfig = MatchGameFightConfig.instance:getMonsterAttrConfig(memberItem.monterConfig.template)

				self._txtenemyHp.text = string.format("%s/%s", attrConfig.hp, attrConfig.hp)
				self._imageenemyHp.fillAmount = 1
			end

			self._simageenemy:LoadImage(memberItem.monterConfig.image, self.setEnemyImageSize, self)

			self._imageenemy.material = self.enemyMat

			self.enemyMeshComp:refreshMesh(memberItem.monterConfig, true)

			self._txtname.text = memberItem.monterConfig.name

			UISpriteSetMgr.instance:setMatchGameSprite(self._imagecareer, "icon_career" .. memberItem.monterConfig.career)
			UISpriteSetMgr.instance:setMatchGameSprite(self._imageenemyCareer, "icon_career" .. memberItem.monterConfig.career)
		end
	else
		gohelper.setActive(self._gohero, true)
		gohelper.setActive(self._gofeverBar, true)
		gohelper.setActive(self._goheroSkillEnergy, true)
		gohelper.setActive(self._goenemy, false)

		self._txtheroHp.text = string.format("%s/%s", self.fightData.curHeroTotalHp, self.fightData.maxHeroTotalHp)
		self._imagehp.fillAmount = self.fightData.curHeroTotalHp / self.fightData.maxHeroTotalHp

		local memberItem = self.memberItemList[self.curMemberIndex]
		local heroFightMo = memberItem.heroFightMo

		self._txtname.text = heroFightMo.config.name

		self._simagehero:LoadImage(heroFightMo.config.image, self.setHeroImageSize, self)

		self._imagehero.material = self.heroMat

		self.heroMeshComp:refreshMesh(heroFightMo.config, false)
		UISpriteSetMgr.instance:setMatchGameSprite(self._imagecareer, "icon_career" .. heroFightMo.career)

		self._txtfeverNum.text = string.format("%s/%s", self.fightData.curFeverNum, self.fightData.maxFeverNum)

		local isFeverState = MatchGameFightModel.instance:getisFeverState()

		self._imagefeverBar.fillAmount = self.fightData.curFeverNum / self.fightData.maxFeverNum

		UISpriteSetMgr.instance:setMatchGameSprite(self._imagefeverBar, isFeverState and "matchgamefight_fever_bar2" or "matchgamefight_fever_bar1")
		gohelper.setActive(self._gofeverNormal, not isFeverState)
		gohelper.setActive(self._gofeverFull, isFeverState)

		self._txtskillEnergy.text = string.format("%s/%s", heroFightMo.energy, heroFightMo.maxEnergy)
		self._imageskillEnergyBar.fillAmount = heroFightMo.energy / heroFightMo.maxEnergy
	end
end

function MatchGameMemberInfoView:setEnemyImageSize()
	ZProj.UGUIHelper.SetImageSize(self._simageenemy.gameObject)
end

function MatchGameMemberInfoView:setHeroImageSize()
	ZProj.UGUIHelper.SetImageSize(self._simagehero.gameObject)
end

function MatchGameMemberInfoView:refreshSkillInfo()
	local skillDataList = {}

	if self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Enemy then
		local monsterConfig = MatchGameFightConfig.instance:getMonsterConfig((self.isInFight or nil) and self.fightData.enemyInfoMo.id)
		local skillTemplateConfig = MatchGameFightConfig.instance:getMonsterSkillTemplateConfig(monsterConfig.skillTemplate)
		local enemyActiveSkillList = not string.nilorempty(skillTemplateConfig.activeSkill) and string.splitToNumber(skillTemplateConfig.activeSkill, "#") or {}

		for index, skillId in ipairs(enemyActiveSkillList) do
			local skillData = {}

			skillData.activeType = MatchGameFightEnum.SkillActiveType.Active
			skillData.skillId = skillId
			skillData.skillConfig = MatchGameFightConfig.instance:getMonsterSkillConfig(skillId)

			table.insert(skillDataList, skillData)
		end

		local enemyPassiveSkillList = not string.nilorempty(skillTemplateConfig.passiveSkill) and string.splitToNumber(skillTemplateConfig.passiveSkill, "#") or {}

		for index, skillId in ipairs(enemyPassiveSkillList) do
			local skillData = {}

			skillData.activeType = MatchGameFightEnum.SkillActiveType.Passive
			skillData.skillId = skillId
			skillData.skillConfig = MatchGameFightConfig.instance:getMonsterSkillConfig(skillId)

			table.insert(skillDataList, skillData)
		end
	else
		local memberItem = self.memberItemList[self.curMemberIndex]
		local heroFightMo = memberItem.heroFightMo
		local heroActiveSkillList = heroFightMo and not string.nilorempty(heroFightMo.config.activeSkillId) and string.splitToNumber(heroFightMo.config.activeSkillId, "#") or {}

		for index, skillId in ipairs(heroActiveSkillList) do
			local skillData = {}

			skillData.activeType = MatchGameFightEnum.SkillActiveType.None
			skillData.skillId = skillId
			skillData.skillConfig = MatchGameConfig.instance:getHeroSkillConfig(skillId)

			table.insert(skillDataList, skillData)
		end
	end

	self:refreshSkillInfoUI(skillDataList)
end

function MatchGameMemberInfoView:refreshSkillInfoUI(skillDataList)
	for index, skillData in ipairs(skillDataList) do
		local skillItem = self.skillItemList[index]

		if not skillItem then
			skillItem = {
				go = gohelper.clone(self._goskillItem, self._goskillContent, "skillItem_" .. index)
			}
			skillItem.txtName = gohelper.findChildText(skillItem.go, "namebg/txt_Name")
			skillItem.goTypeTag = gohelper.findChild(skillItem.go, "namebg/txt_Name/go_typeTag")
			skillItem.txtTypeTag = gohelper.findChildText(skillItem.go, "namebg/txt_Name/go_typeTag/txt_type")
			skillItem.goTagList = gohelper.findChild(skillItem.go, "go_TagList")
			skillItem.goTagItem = gohelper.findChild(skillItem.go, "go_TagList/go_TagItem")
			skillItem.txtDesc = gohelper.findChildText(skillItem.go, "txt_Desc")

			SkillHelper.addHyperLinkClick(skillItem.txtDesc)

			self.skillItemList[index] = skillItem
		end

		gohelper.setActive(skillItem.go, true)

		skillItem.txtName.text = skillData.skillConfig.name
		skillItem.txtDesc.text = SkillHelper.buildDesc(skillData.skillConfig.desc)

		if self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Enemy then
			gohelper.setActive(skillItem.goTagList, false)
			gohelper.setActive(skillItem.goTypeTag, true)

			skillItem.txtTypeTag.text = skillData.skillConfig.skillTag
		else
			gohelper.setActive(skillItem.goTagList, true)
			gohelper.setActive(skillItem.goTypeTag, false)

			local tagList = skillData.skillConfig.skillTag and not string.nilorempty(skillData.skillConfig.skillTag) and string.split(skillData.skillConfig.skillTag, "|") or {}

			gohelper.CreateObjList(self, self.onSkillTagShow, tagList, skillItem.goTagList, skillItem.goTagItem)
		end
	end

	for index = #skillDataList + 1, #self.skillItemList do
		local skillItem = self.skillItemList[index]

		gohelper.setActive(skillItem.go, false)
	end
end

function MatchGameMemberInfoView:onSkillTagShow(goItem, tag, index)
	local txtTagName = gohelper.findChildText(goItem, "txt_TagName")

	txtTagName.text = tag
end

function MatchGameMemberInfoView:refreshTagUI()
	gohelper.setActive(self._goselectHero, self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Hero)
	gohelper.setActive(self._goselectEnemy, self.curMemberTag == MatchGameFightEnum.MemberInfoTag.Enemy)
end

function MatchGameMemberInfoView:onClose()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.ContinueGame)
end

function MatchGameMemberInfoView:onDestroyView()
	for index, memberItem in ipairs(self.memberItemList) do
		memberItem.btnClick:RemoveClickListener()
		memberItem.heroItemUI.simageIcon:UnLoadImage()
		memberItem.enemyItemUI.simageIcon:UnLoadImage()
	end

	self._simageenemy:UnLoadImage()
	self._simagehero:UnLoadImage()

	if self.heroMat then
		UnityEngine.Object.Destroy(self.heroMat)
	end

	if self.enemyMat then
		UnityEngine.Object.Destroy(self.enemyMat)
	end
end

return MatchGameMemberInfoView
