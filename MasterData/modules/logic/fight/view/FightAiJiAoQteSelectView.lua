-- chunkname: @modules/logic/fight/view/FightAiJiAoQteSelectView.lua

module("modules.logic.fight.view.FightAiJiAoQteSelectView", package.seeall)

local FightAiJiAoQteSelectView = class("FightAiJiAoQteSelectView", FightBaseView)

function FightAiJiAoQteSelectView:onInitView()
	self.root = gohelper.findChild(self.viewGO, "root")
	self.itemRoot = gohelper.findChild(self.viewGO, "root/selectTarget/#scroll_enemy/viewport/content")
	self.objItem = gohelper.findChild(self.viewGO, "root/selectTarget/#scroll_enemy/viewport/content/go_enemyItem")
	self.roleImg = gohelper.findChildSingleImage(self.viewGO, "root/BG/simage_role/loop/simage_role")
	self.confirmClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/#btn_confirm/clickarea")
	self.exSkillIcon = gohelper.findChildSingleImage(self.viewGO, "root/selectTarget/lv4/imgIcon")
	self.txtWave = gohelper.findChildText(self.viewGO, "root/topLeftContent/imgRound/txtWave")
	self.txtRound = gohelper.findChildText(self.viewGO, "root/topLeftContent/imgRound/txtRound")
	self.btnInfo = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/topLeftContent/enemyinfo/#btn_enemyinfo/clickarea")
	self.go_skillTips = gohelper.findChild(self.viewGO, "root/selectTarget/#go_skilltip")
	self.skillNameText = gohelper.findChildText(self.viewGO, "root/selectTarget/#go_skilltip/skillbg/container/#txt_skillname")
	self.skillDescText = gohelper.findChildText(self.viewGO, "root/selectTarget/#go_skilltip/skillbg/#txt_skilldesc")
	self.btnSkillTips = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/selectTarget/btn_skillClick")
	self.skillTipsMaskClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "tipsMask")
end

function FightAiJiAoQteSelectView:addEvents()
	self:com_registClick(self.confirmClick, self.onConfirmClick)
	self:com_registClick(self.btnInfo, self.onBtnInfoClick)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.DestroyViewFinish, self.onDestroyViewFinish)
	self:com_registClick(self.btnSkillTips, self.onBtnSkillTipsClick)
	self:com_registClick(self.skillTipsMaskClick, self.onSkillTipsMaskClick)
end

function FightAiJiAoQteSelectView:onBtnSkillTipsClick()
	gohelper.setActive(self.go_skillTips, true)
	gohelper.setActive(self.skillTipsMaskClick.gameObject, true)
end

function FightAiJiAoQteSelectView:onSkillTipsMaskClick()
	gohelper.setActive(self.go_skillTips, false)
	gohelper.setActive(self.skillTipsMaskClick.gameObject, false)
end

function FightAiJiAoQteSelectView:onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		gohelper.setActive(self.viewGO, false)
	end
end

function FightAiJiAoQteSelectView:onDestroyViewFinish(viewName)
	if viewName == ViewName.FightFocusView then
		gohelper.setActive(self.viewGO, true)
	end
end

function FightAiJiAoQteSelectView:onBtnInfoClick()
	FightViewContainer.openFightFocusView()
end

function FightAiJiAoQteSelectView:onConfirmClick()
	if not self.selectId then
		return
	end

	if self.clicked then
		return
	end

	self.clicked = true

	AudioMgr.instance:trigger(20305034)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkPlayAnimator, self.viewGO, "close")
	flow:registWork(FightWorkFunction, self.afterCloseAni, self)
	flow:start()
end

function FightAiJiAoQteSelectView:afterCloseAni()
	FightDataHelper.tempMgr.aiJiAoSelectTargetView = nil

	self.callback(self.handle, self.selectId)
	self:closeThis()
end

function FightAiJiAoQteSelectView:onConstructor()
	return
end

function FightAiJiAoQteSelectView:_onBtnEsc()
	return
end

function FightAiJiAoQteSelectView:onOpen()
	FightDataHelper.tempMgr.aiJiAoSelectTargetView = true
	FightDataHelper.tempMgr.hideNameUIByTimeline = true

	local entityList = FightHelper.getAllEntitys()

	for _, entity in ipairs(entityList) do
		if entity.nameUI then
			entity.nameUI:setActive(false)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)

	self.callback = self.viewParam.callback
	self.handle = self.viewParam.handle

	local fromId = self.viewParam.fromId
	local entityData = FightDataHelper.entityMgr:getById(fromId)
	local targetLimit = self.viewParam.targetLimit

	self.itemList = {}

	for i, toId in ipairs(targetLimit) do
		local obj = gohelper.cloneInPlace(self.objItem)

		table.insert(self.itemList, self:com_openSubView(FightAiJiAoQteSelectItemView, obj, nil, fromId, toId))
	end

	self.selectId = targetLimit[1]

	gohelper.setActive(self.objItem, false)

	local skillConfig = lua_skill.configDict[entityData.exSkill]

	if skillConfig then
		local targetIconUrl = ResUrl.getSkillIcon(skillConfig.icon)

		self.exSkillIcon:LoadImage(targetIconUrl)
	end

	local maxWave = FightModel.instance.maxWave
	local curWaveId = FightModel.instance:getCurWaveId()

	curWaveId = math.min(curWaveId, maxWave)
	self.txtWave.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_wave_lang"), curWaveId, maxWave)

	local maxRound = FightModel.instance:getMaxRound()
	local curRound = FightModel.instance:getCurRoundId()

	curRound = math.min(curRound, maxRound)
	self.txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), curRound, maxRound)

	local roleUrl = entityData.skin == 312301 and "singlebg/fight/azio/fight_azio_role_1.png" or "singlebg/fight/azio/fight_azio_role_2.png"

	self.roleImg:LoadImage(roleUrl)

	local openFlow = self:com_registFlowSequence()

	openFlow:registWork(FightWorkPlayAnimator, self.viewGO, "open")
	openFlow:registWork(FightWorkFunction, self.onOpenAnimatorFinish, self, targetLimit)
	openFlow:start()

	self.skillNameText.text = skillConfig.name
	self.skillDescText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getSkillEffectDesc(nil, skillConfig))
end

function FightAiJiAoQteSelectView:onOpenAnimatorFinish(targetLimit)
	if self.selected then
		return
	end

	local curSelectEntityId = FightDataHelper.operationDataMgr.curSelectEntityId

	curSelectEntityId = curSelectEntityId and curSelectEntityId ~= 0 and curSelectEntityId

	for i, v in ipairs(targetLimit) do
		if v == curSelectEntityId then
			self.itemList[i]:onClick()

			break
		end
	end

	if not curSelectEntityId then
		curSelectEntityId = targetLimit[1]

		self.itemList[1]:onClick()
	end
end

function FightAiJiAoQteSelectView.getTargetLimit(skillId, fromId)
	local targetLimit = {}
	local temp = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, skillId, fromId)

	for i, entityId in ipairs(temp) do
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if entityMO.entityType == 3 then
			-- block empty
		elseif entityMO:hasBuffFeature(FightEnum.BuffType_CantSelect) or entityMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			-- block empty
		else
			local curChapterId = DungeonModel.instance.curSendChapterId

			if curChapterId ~= DungeonEnum.ChapterId.RoleDuDuGu or entityMO.originSkin ~= CharacterEnum.DefaultSkinId.DuDuGu then
				table.insert(targetLimit, entityId)
			end
		end
	end

	table.sort(targetLimit, FightAiJiAoQteSelectView.sortByPosX)

	return targetLimit
end

function FightAiJiAoQteSelectView:onSelectItem(toId)
	AudioMgr.instance:trigger(20305033)

	self.selected = true
	self.selectId = toId

	for i, item in ipairs(self.itemList) do
		item:showSelect(toId)
	end
end

function FightAiJiAoQteSelectView.sortByPosX(item1, item2)
	local entity1 = FightHelper.getEntity(item1)
	local go1 = entity1 and entity1.go
	local entity2 = FightHelper.getEntity(item2)
	local go2 = entity2 and entity2.go

	if go1 and go2 then
		local posX1 = transformhelper.getLocalPos(go1.transform)
		local posX2 = transformhelper.getLocalPos(go2.transform)

		return posX1 < posX2
	else
		return false
	end
end

function FightAiJiAoQteSelectView:onClose()
	return
end

function FightAiJiAoQteSelectView:onDestroyView()
	return
end

return FightAiJiAoQteSelectView
