-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossDetailView.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossDetailView", package.seeall)

local TowerAssistBossDetailView = class("TowerAssistBossDetailView", BaseView)

function TowerAssistBossDetailView:onInitView()
	self.txtLev = gohelper.findChildTextMesh(self.viewGO, "root/left/boss/lev")
	self.imgCareer = gohelper.findChildImage(self.viewGO, "root/right/info/career")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "root/right/info/name")
	self.btnTalent = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/btnTalent")
	self.btnBossTower = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/btnBossTower")
	self.simageBoss = gohelper.findChildSingleImage(self.viewGO, "root/left/boss/icon")
	self.txtPassiveName = gohelper.findChildTextMesh(self.viewGO, "root/right/info/passiveskill/bg/#txt_passivename")
	self.passiveSkillItems = {}

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, string.format("root/right/info/passiveskill/#go_passiveskills/passiveskill%s", i))
		item.goOff = gohelper.findChild(item.go, "off")
		item.goOn = gohelper.findChild(item.go, "on")
		self.passiveSkillItems[i] = item
	end

	self.goTeachSkills = gohelper.findChild(self.viewGO, "root/right/info/passiveskill/#go_teachskills")
	self.canvasGroupTeachSkills = self.goTeachSkills:GetComponent(gohelper.Type_CanvasGroup)
	self.btnSkill = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon")
	self.skillIcon = gohelper.findChildSingleImage(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/imgIcon")
	self.skillTagIcon = gohelper.findChildSingleImage(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	self.goTagIcon = gohelper.findChild(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	self.txtNum = gohelper.findChildTextMesh(self.viewGO, "root/right/btnTalent/#txt_num")
	self.goCanLight = gohelper.findChild(self.viewGO, "root/right/tag")
	self.btnPassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/info/passiveskill/#btn_passiveskill")
	self.btnBase = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/info/base/#btn_base")
	self.goTagItem = gohelper.findChild(self.viewGO, "root/right/info/base/scroll_tag/Viewport/Content/#txt_tag")
	self.tagItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossDetailView:addEvents()
	self.addClickCb(self, self.btnSkill, self.onBtnActiveSkillClick, self)
	self.addClickCb(self, self.btnBase, self.onBtnBaseClick, self)
	self.addClickCb(self, self.btnTalent, self.onBtnTalentClick, self)
	self.addClickCb(self, self.btnBossTower, self.onBtnBossTowerClick, self)
	self.addClickCb(self, self.btnPassiveskill, self.onBtnPassiveskillClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self._onTowerUpdate, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshTalent, self)
end

function TowerAssistBossDetailView:removeEvents()
	self:removeClickCb(self.btnSkill)
	self:removeClickCb(self.btnBase)
	self:removeClickCb(self.btnTalent)
	self:removeClickCb(self.btnBossTower)
	self:removeClickCb(self.btnPassiveskill)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self._onTowerUpdate, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshTalent, self)
end

function TowerAssistBossDetailView:_editableInitView()
	return
end

function TowerAssistBossDetailView:onBtnActiveSkillClick()
	if not self.skillIdList then
		return
	end

	local param = {}

	param.skillIdList = self.skillIdList
	param.monsterName = self.config.name
	param.super = true

	ViewMgr.instance:openView(ViewName.TowerSkillTipView, param)
end

function TowerAssistBossDetailView:onBtnBaseClick()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossAttributeTipsView, {
		bossId = self.bossId,
		isFromHeroGroup = self.isFromHeroGroup
	})
end

function TowerAssistBossDetailView:onBtnPassiveskillClick()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = self.bossId
	})
end

function TowerAssistBossDetailView:onBtnTalentClick()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentView, {
		bossId = self.bossId,
		isFromHeroGroup = self.isFromHeroGroup
	})
end

function TowerAssistBossDetailView:onBtnBossTowerClick()
	TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, self.config.towerId)
end

function TowerAssistBossDetailView:_onTowerUpdate()
	self:refreshView()
end

function TowerAssistBossDetailView:_onResetTalent(talentId)
	self:refreshTalent()
end

function TowerAssistBossDetailView:_onActiveTalent(talentId)
	self:refreshTalent()
end

function TowerAssistBossDetailView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossDetailView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossDetailView:refreshParam()
	self.bossId = self.viewParam.bossId
	self.bossMo = TowerAssistBossModel.instance:getById(self.bossId)
	self.config = TowerConfig.instance:getAssistBossConfig(self.bossId)
	self.isFromHeroGroup = not not self.viewParam.isFromHeroGroup

	local curTowerType = TowerModel.instance:getCurTowerType()
	local limitedTrialLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

	self.isBlanced = curTowerType == TowerEnum.TowerType.Limited and limitedTrialLevel > self.bossMo.level

	if self.isFromHeroGroup then
		local param = TowerModel.instance:getRecordFightParam()

		if tabletool.len(param) > 0 then
			self.isTeach = param.towerType == TowerEnum.TowerType.Boss and param.layerId == 0

			if self.isTeach then
				local curLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TeachBossLevel))
				local teachConfig = TowerConfig.instance:getBossTeachConfig(param.towerId, param.difficulty)

				self.bossMo:setTrialInfo(curLevel, teachConfig.planId)
				self.bossMo:refreshTalent()
			elseif self.isBlanced then
				TowerAssistBossModel.instance:setLimitedTrialBossInfo(self.bossMo)
			else
				self.bossMo:setTrialInfo(0, 0)
				self.bossMo:refreshTalent()
			end
		end
	elseif curTowerType and curTowerType == TowerEnum.TowerType.Limited and self.isBlanced then
		TowerAssistBossModel.instance:setLimitedTrialBossInfo(self.bossMo)
	else
		self.bossMo:setTrialInfo(0, 0)
		self.bossMo:refreshTalent()
	end
end

function TowerAssistBossDetailView:refreshView()
	if self.bossMo and self.bossMo.trialLevel > 0 then
		local var_16_0 = self.bossMo.trialLevel

		if not self.bossMo.trialLevel then
			if self.bossMo and self.bossMo.level > 0 then
				var_16_0 = self.bossMo.level

				if not self.bossMo.level then
					local bossLev = 1

					self.txtLev.text = tostring(bossLev)
					self.txtName.text = self.config.name

					UISpriteSetMgr.instance:setCommonSprite(self.imgCareer, string.format("lssx_%s", self.config.career))
					self.simageBoss:LoadImage(self.config.bossPic)

					local openInfo = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Boss, self.config.towerId)
					local isTowerOpen = openInfo ~= nil

					gohelper.setActive(self.btnBossTower, isTowerOpen and not self.isFromHeroGroup)

					local list = TowerConfig.instance:getHeroGroupAddAttr(self.bossId, 0, bossLev)

					gohelper.setActive(self.btnBase, #list > 0)
					self:refreshPassiveSkill()
					self:refreshActiveSkill()
					self:refreshTeachSkill()
					self:refreshTalent()
					self:refreshTags()
				end
			end
		end
	end
end

function TowerAssistBossDetailView:refreshTalent()
	if self.bossMo then
		local param1, param2 = self.bossMo:getTalentActiveCount()

		self.txtNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towertalent_already_light"), param1, param1 + param2)

		gohelper.setActive(self.goCanLight, self.bossMo:hasTalentCanActive() and not self.isBlanced and not self.isTeach)
	else
		self.txtNum.text = ""

		gohelper.setActive(self.goCanLight, false)
	end
end

function TowerAssistBossDetailView:refreshPassiveSkill()
	local skillsList = TowerConfig.instance:getPassiveSKills(self.bossId)

	self.txtPassiveName.text = self.config.passiveSkillName

	if self.bossMo and self.bossMo.trialLevel > 0 then
		local var_18_0 = self.bossMo.trialLevel

		if not self.bossMo.trialLevel then
			if self.bossMo then
				var_18_0 = self.bossMo.level

				if not self.bossMo.level then
					local bossLev = 1

					for i, v in ipairs(self.passiveSkillItems) do
						local skills = skillsList[i]

						if skills then
							gohelper.setActive(v.go, true)
							gohelper.setActive(v.goOn, TowerConfig.instance:isSkillActive(self.bossId, skills[1], bossLev))
						else
							gohelper.setActive(v.go, false)
						end
					end
				end
			end
		end
	end
end

function TowerAssistBossDetailView:refreshActiveSkill()
	local skills = GameUtil.splitString2(self.config.activeSkills, true) or {}
	local firstSkill = skills[1]

	self.skillIdList = {}

	for i, v in ipairs(skills) do
		table.insert(self.skillIdList, v[1])
	end

	local firstSkillConfig = lua_skill.configDict[firstSkill[1]]

	if not firstSkillConfig then
		return
	end

	self.skillIcon:LoadImage(ResUrl.getSkillIcon(firstSkillConfig.icon))
	self.skillTagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. firstSkillConfig.showTag))
	gohelper.setActive(self.goTagIcon, false)
end

function TowerAssistBossDetailView:refreshTags()
	local tags = string.split(self.config.tag, "#") or {}
	local tagCount = #tags
	local count = math.max(#self.tagItems, tagCount)

	for i = 1, count do
		local item = self.tagItems[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goTagItem)
			item.txt = item.go:GetComponent(gohelper.Type_TextMesh)
			self.tagItems[i] = item
		end

		if tags[i] then
			item.txt.text = tags[i]
		end

		gohelper.setActive(item.go, tags[i] ~= nil)
	end
end

function TowerAssistBossDetailView:refreshTeachSkill()
	local teachSkillList = string.splitToNumber(self.config.teachSkills, "#") or {}

	gohelper.setActive(self.goTeachSkills, #teachSkillList > 0)

	local isAllEpisodeFinish = TowerBossTeachModel.instance:isAllEpisodeFinish(self.bossId)

	self.canvasGroupTeachSkills.alpha = isAllEpisodeFinish and 1 or 0.5
end

function TowerAssistBossDetailView:onClose()
	return
end

function TowerAssistBossDetailView:onDestroyView()
	self.skillIcon:UnLoadImage()
	self.skillTagIcon:UnLoadImage()
	self.simageBoss:UnLoadImage()
end

return TowerAssistBossDetailView
