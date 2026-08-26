-- chunkname: @modules/logic/tips/view/FightFocusTowerView.lua

module("modules.logic.tips.view.FightFocusTowerView", package.seeall)

local FightFocusTowerView = class("FightFocusTowerView", BaseRoleStoryView)

function FightFocusTowerView:onInit()
	self.resPathList = {
		mainRes = "ui/viewres/fight/fightfocustowerview.prefab"
	}
end

function FightFocusTowerView:onInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.txtLev = gohelper.findChildTextMesh(self.viewGO, "root/left/boss/lev")
	self.imgCareer = gohelper.findChildImage(self.viewGO, "root/right/info/career")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "root/right/info/name")
	self.btnTalent = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/btnTalent")
	self.txtPassiveName = gohelper.findChildTextMesh(self.viewGO, "root/right/info/passiveskill/bg/#txt_passivename")
	self.passiveSkillItems = {}

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, string.format("root/right/info/passiveskill/#go_passiveskills/passiveskill%s", i))
		item.goOff = gohelper.findChild(item.go, "off")
		item.goOn = gohelper.findChild(item.go, "on")
		self.passiveSkillItems[i] = item
	end

	self.btnSkill = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon")
	self.skillIcon = gohelper.findChildSingleImage(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/imgIcon")
	self.skillTagIcon = gohelper.findChildSingleImage(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	self.goTagIcon = gohelper.findChild(self.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	self.btnPassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/info/passiveskill/#btn_passiveskill")
	self.goTagItem = gohelper.findChild(self.viewGO, "root/right/info/base/scroll_tag/Viewport/Content/#txt_tag")
	self.tagItems = {}
end

function FightFocusTowerView:addEvents()
	self.addClickCb(self, self.btnSkill, self.onBtnActiveSkillClick, self)
	self.addClickCb(self, self.btnTalent, self.onBtnTalentClick, self)
	self.addClickCb(self, self.btnPassiveskill, self.onBtnPassiveskillClick, self)
end

function FightFocusTowerView:removeEvents()
	self:removeClickCb(self.btnSkill)
	self:removeClickCb(self.btnTalent)
	self:removeClickCb(self.btnPassiveskill)
end

function FightFocusTowerView:onBtnActiveSkillClick()
	if not self.skillIdList then
		return
	end

	local param = {}

	param.skillIdList = self.skillIdList
	param.monsterName = self.config.name
	param.super = true

	ViewMgr.instance:openView(ViewName.TowerSkillTipView, param)
end

function FightFocusTowerView:onBtnPassiveskillClick()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = self.bossId
	})
end

function FightFocusTowerView:onBtnTalentClick()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentTallView, {
		bossId = self.bossId
	})
end

function FightFocusTowerView:onShow()
	self.bossMo = TowerAssistBossModel.instance:getById(self.bossId)
	self.config = TowerConfig.instance:getAssistBossConfig(self.bossId)

	self:refreshView()
end

function FightFocusTowerView:refreshView()
	if self.bossMo and self.bossMo.trialLevel > 0 then
		local var_9_0 = self.bossMo.trialLevel

		if not self.bossMo.trialLevel then
			if self.bossMo and self.bossMo.level > 0 then
				var_9_0 = self.bossMo.level

				if not self.bossMo.level then
					local bossLev = 1

					self.txtLev.text = tostring(bossLev)
					self.txtName.text = self.config.name

					UISpriteSetMgr.instance:setCommonSprite(self.imgCareer, string.format("lssx_%s", self.config.career))

					local list = TowerConfig.instance:getHeroGroupAddAttr(self.bossId, 0, bossLev)

					gohelper.setActive(self.btnBase, #list > 0)
					self:refreshPassiveSkill()
					self:refreshActiveSkill()
					self:refreshTags()
				end
			end
		end
	end
end

function FightFocusTowerView:refreshPassiveSkill()
	local skillsList = TowerConfig.instance:getPassiveSKills(self.bossId)

	self.txtPassiveName.text = self.config.passiveSkillName

	if self.bossMo and self.bossMo.trialLevel > 0 then
		local var_10_0 = self.bossMo.trialLevel

		if not self.bossMo.trialLevel then
			if self.bossMo and self.bossMo.level > 0 then
				var_10_0 = self.bossMo.level

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

function FightFocusTowerView:refreshActiveSkill()
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

function FightFocusTowerView:refreshTags()
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

function FightFocusTowerView:onHide()
	return
end

function FightFocusTowerView:show(force)
	if self.isShow and not force then
		return
	end

	self.isShow = true

	if not self.viewGO then
		self:_loadPrefab()

		return
	end

	gohelper.setActive(self.viewGO, true)

	if force then
		self.anim:Play("open")
	else
		self.anim:Play("switch")
	end

	self:onShow()
end

function FightFocusTowerView:hide(force)
	if not self.isShow and not force then
		return
	end

	self.isShow = false

	if not self.viewGO then
		return
	end

	if force then
		self.anim:Play("close")
	else
		gohelper.setActive(self.viewGO, false)
	end

	self:onHide()
end

function FightFocusTowerView:onDestroyView()
	self.skillIcon:UnLoadImage()
	self.skillTagIcon:UnLoadImage()
end

return FightFocusTowerView
