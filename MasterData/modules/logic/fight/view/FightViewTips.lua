-- chunkname: @modules/logic/fight/view/FightViewTips.lua

module("modules.logic.fight.view.FightViewTips", package.seeall)

local FightViewTips = class("FightViewTips", BaseViewExtended)

function FightViewTips:onInitView()
	self._tipsRoot = gohelper.findChild(self.viewGO, "root/tips")
	self._goglobalClick = gohelper.findChild(self.viewGO, "root/tips/#go_globalClick")
	self._gobufftip = gohelper.findChild(self.viewGO, "root/tips/#go_bufftip")
	self._passiveSkillPrefab = gohelper.findChild(self.viewGO, "root/tips/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	self._goskilltip = gohelper.findChild(self.viewGO, "root/tips/#go_skilltip")
	self._goHeatTips = gohelper.findChild(self.viewGO, "root/tips/#go_skilltip/#go_heat")
	self._txtskillname = gohelper.findChildText(self.viewGO, "root/tips/#go_skilltip/skillbg/container/#txt_skillname")
	self._txtskilltype = gohelper.findChildText(self.viewGO, "root/tips/#go_skilltip/skillbg/container/bg/#txt_skilltype")
	self._txtskilldesc = gohelper.findChildText(self.viewGO, "root/tips/#go_skilltip/skillbg/#txt_skilldesc")
	self._skillTipsGO = self._txtskilldesc.gameObject
	self._goattrbg = gohelper.findChild(self.viewGO, "root/tips/#go_skilltip/#go_attrbg")
	self._gobuffinfocontainer = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer")

	gohelper.setActive(self._gobuffinfocontainer, false)

	self._gobuffinfowrapper = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/buff")
	self._gobuffitem = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	self._scrollbuff = gohelper.findChildScrollRect(self.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	self._btnclosebuffinfocontainer = gohelper.findChildButton(self.viewGO, "root/#go_buffinfocontainer/#btn_click")
	self._gofightspecialtip = gohelper.findChild(self.viewGO, "root/tips/#go_fightspecialtip")
	self._promptImage = gohelper.findChildImage(self.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg")
	self._promptText = gohelper.findChildText(self.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg/#txt_specialtipdesc")
	self._prompAni = gohelper.findChildComponent(self.viewGO, "root/tips/#go_fightspecialtip", typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end

	self._passiveSkillGOs = self:getUserDataTb_()
	self._passiveSkillImgs = self:getUserDataTb_()
end

function FightViewTips:addEvents()
	self._btnclosebuffinfocontainer:AddClickListener(self._onCloseBuffInfoContainer, self)
	self.addEventCb(self, FightController.instance, FightEvent.ShowFightPrompt, self._onShowFightPrompt, self)
	self.addEventCb(self, FightController.instance, FightEvent.ShowSeasonGuardIntro, self._onShowSeasonGuardIntro, self)

	self._loader = self._loader or FightLoaderComponent.New()
end

function FightViewTips:removeEvents()
	self._btnclosebuffinfocontainer:RemoveClickListener()

	if not gohelper.isNil(self._touchEventMgr) then
		TouchEventMgrHepler.remove(self._touchEventMgr)
	end

	TaskDispatcher.cancelTask(self._delayCheckHideTips, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	if self._loader then
		self._loader:disposeSelf()

		self._loader = nil
	end
end

FightViewTips.enemyBuffTipPosY = 80
FightViewTips.OnKeyTipsPosY = 380
FightViewTips.OnKeyTipsUniquePosY = 436

function FightViewTips:_editableInitView()
	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._goglobalClick)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnlyTouch(true)
	self._touchEventMgr:SetOnTouchDownCb(self._onGlobalTouch, self)

	self._originSkillPosX, self._originSkillPosY = recthelper.getAnchor(self._goskilltip.transform)

	gohelper.setActive(self._gobuffitem, false)

	self._buffItemList = {}
	self.rectTrScrollBuff = self._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	self.rectTrBuffContent = gohelper.findChildComponent(self.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(self._goattrbg, false)
	gohelper.addUIClickAudio(self._btnclosebuffinfocontainer.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
	gohelper.setActive(self._txtskilltype.gameObject, false)
	gohelper.setActive(self._gofightspecialtip, false)

	self.buffTipClick = gohelper.getClickWithDefaultAudio(self._gobufftip)

	self.buffTipClick:AddClickListener(self.onClickBuffTip, self)
	gohelper.setActive(self._gobufftip, false)
end

function FightViewTips:onClickBuffTip()
	gohelper.setActive(self._gobufftip, false)
end

function FightViewTips:_onGlobalTouch()
	if self._guardTipsRoot then
		gohelper.setActive(self._guardTipsRoot, false)
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidCloseSkilltip) then
		return
	end

	if GuideViewMgr.instance:isGuidingGO(self._skillTipsGO) then
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.TouchFightViewScreen)

	self._showingSkillTip = not gohelper.isNil(self._goskilltip) and self._goskilltip.activeInHierarchy

	if self._showingSkillTip then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
		TaskDispatcher.runDelay(self._delayCheckHideTips, self, (ViewMgr.instance:isOpen(ViewName.GuideView) or nil) and GuideBlockMgr.BlockTime)
	end
end

function FightViewTips:_onCloseView(viewName)
	if viewName == ViewName.GuideView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
		self:_hideTips()
	end
end

function FightViewTips:_delayCheckHideTips()
	if self._showingSkillTip then
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
	end

	if self._showingSkillTip then
		self:_hideTips()
	end
end

function FightViewTips:_onCloseBuffInfoContainer()
	gohelper.setActive(self._gobuffinfocontainer, false)
	ViewMgr.instance:closeView(ViewName.CommonBuffTipView)
	ViewMgr.instance:closeView(ViewName.FightBuffTipsView)
end

function FightViewTips:onOpen()
	gohelper.setActive(gohelper.findChild(self.viewGO, "root/tips"), true)
	self:_hideTips()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffClick, self._onBuffClick, self)
	self.addEventCb(self, FightController.instance, FightEvent.ShowCardSkillTips, self._showCardSkillTips, self)
	self.addEventCb(self, FightController.instance, FightEvent.HideCardSkillTips, self._hideCardSkillTips, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onCloseBuffInfoContainer, self)
	self.addEventCb(self, FightController.instance, FightEvent.EnterOperateState, self._onEnterOperateState, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
end

function FightViewTips:onStageChanged(stage)
	if stage == FightStageMgr.StageType.Play then
		self:_hideTips()

		if self._guardTipsRoot then
			gohelper.setActive(self._guardTipsRoot, false)
		end
	end
end

function FightViewTips:_onEnterOperateState(operateState)
	if operateState == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(self._gobuffinfocontainer, false)
		self:_hideTips()
	end
end

function FightViewTips:_setPassiveSkillTip(skillgo, skillInfo, entityId)
	local name = gohelper.findChildText(skillgo, "title/txt_name")
	local desc = gohelper.findChildText(skillgo, "txt_desc")
	local skillCO = lua_skill.configDict[skillInfo.skillId]

	name.text = skillCO.name

	local desctxt = FightConfig.instance:getEntitySkillDesc(entityId, skillCO)

	desctxt = HeroSkillModel.instance:skillDesToSpot(desctxt, "#CC492F", "#485E92")
	desc.text = desctxt
end

function FightViewTips.sortShouTaoListById(item1, item2)
	return item1.id > item2.id
end

function FightViewTips.sortShouTaoDesList(item1, item2)
	return item1.descType < item2.descType
end

function FightViewTips:_setSkillTip(skillId, entityId, cardInfoMO)
	gohelper.setActive(self._goskilltip, true)

	local skillCO = lua_skill.configDict[skillId]

	self._txtskillname.text = skillCO.name
	self._txtskilltype.text = self:_formatSkillType(skillCO)

	local desc = FightConfig.instance:getEntitySkillDesc(entityId, skillCO)
	local shouTaoCustomData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.ShowTaoFuBen]

	if shouTaoCustomData then
		local dic = shouTaoCustomData.skillId2NodeIds

		if dic then
			local list = dic[tostring(skillId)]

			if list then
				local configDic = {}

				for i = 1, #list do
					local nodeId = list[i]
					local config = lua_atomic_talent.configDict[nodeId]

					if config then
						local descType = config.descType

						configDic[descType] = configDic[descType] or {}

						table.insert(configDic[descType], config)
					end
				end

				local desList = {}

				for k, v in pairs(configDic) do
					if k ~= 0 then
						table.sort(v, FightViewTips.sortShouTaoListById)
						table.insert(desList, v[1])
					end
				end

				table.sort(desList, FightViewTips.sortShouTaoDesList)

				desc = ""

				for i = 1, #desList do
					desc = desc .. desList[i].skillDesc .. "\n"
				end
			end
		end
	end

	if FightHelper.isHeDuoNieSkill(skillId) then
		local entityMo = FightDataHelper.entityMgr:getById(entityId)
		local curCount = entityMo and entityMo:getHeDuoNieBuffData() or 0

		desc = GameUtil.getSubPlaceholderLuaLangOneParam(desc, curCount)
	end

	local linkSkillDesc = self:_buildLinkTag(desc)

	self._txtskilldesc.text = HeroSkillModel.instance:skillDesToSpot(linkSkillDesc, "#c56131", "#7c93ad")

	gohelper.setActive(self._goHeatTips, false)

	if cardInfoMO and cardInfoMO.heatId ~= 0 then
		gohelper.setActive(self._goHeatTips, true)

		self._heatId = cardInfoMO.heatId

		local config = lua_card_heat.configDict[self._heatId]

		if config then
			if self._heatTitle then
				self:_refreshCardHeat()
			elseif not self._loadHeatTips then
				self._loadHeatTips = true

				self._loader:loadAsset("ui/viewres/fight/fightheattipsview.prefab", self._onHeatTipsLoadFinish, self)
			end
		end
	end
end

function FightViewTips:_refreshCardHeat()
	local heatId = self._heatId
	local config = lua_card_heat.configDict[heatId]

	if not config then
		return
	end

	local teamData = FightDataHelper.teamDataMgr.myData
	local data = teamData.cardHeat.values[heatId]

	if data then
		if not FightDataHelper.teamDataMgr.myCardHeatOffset[heatId] then
			local paraList = {}

			if not string.nilorempty(config.descParam) then
				local arr = string.split(config.descParam, "#")

				for i, v in ipairs(arr) do
					if v == "curValue" then
						table.insert(paraList, data.value + FightDataHelper.teamDataMgr.myCardHeatOffset[heatId])
					elseif v == "upperLimit" then
						table.insert(paraList, data.upperLimit)
					elseif v == "lowerLimit" then
						table.insert(paraList, data.lowerLimit)
					elseif v == "changeValue" then
						table.insert(paraList, data.changeValue)
					end
				end
			end

			self._heatTitle.text = ""
			self._heatDesc.text = GameUtil.getSubPlaceholderLuaLang(config.desc, paraList)
		end
	end
end

function FightViewTips:_onHeatTipsLoadFinish(success, loader)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, self._goHeatTips)

	self._heatTitle = gohelper.findChildText(obj, "tips/heatbg/#txt_heatname")
	self._heatDesc = gohelper.findChildText(obj, "tips/heatbg/#txt_heatdesc")

	self:_refreshCardHeat()
end

function FightViewTips:_buildLinkTag(desc)
	local result = string.gsub(desc, "%[(.-)%]", "<link=\"%1\">[%1]</link>")

	result = string.gsub(result, "%【(.-)%】", "<link=\"%1\">【%1】</link>")

	return result
end

function FightViewTips:_updateBuffs(entityMo)
	gohelper.setActive(self._gobuffinfocontainer, false)
end

function FightViewTips:_hideTips()
	gohelper.setActive(self._goskilltip, false)
end

function FightViewTips:onClose()
	TaskDispatcher.cancelTask(self._correctPos, self)
	TaskDispatcher.cancelTask(self._hidePrompt, self)
	TaskDispatcher.cancelTask(self._playPromptCloseAnim, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnBuffClick, self._onBuffClick, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnPassiveSkillClick, self._onPassiveSkillClick, self)
	self.removeEventCb(self, FightController.instance, FightEvent.ShowCardSkillTips, self._showCardSkillTips, self)
	self.removeEventCb(self, FightController.instance, FightEvent.HideCardSkillTips, self._hideCardSkillTips, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onCloseBuffInfoContainer, self)
end

function FightViewTips:_showCardSkillTips(skillId, entityId, cardInfoMO)
	self:_hideTips()
	self:_setSkillTip(skillId, entityId, cardInfoMO)

	local skillTipTr = self._goskilltip.transform

	if PCInputController.instance:getIsUse() and PlayerPrefsHelper.getNumber("keyTips", 0) ~= 0 then
		if FightCardDataHelper.isBigSkill(skillId) then
			recthelper.setAnchor(skillTipTr, self._originSkillPosX, FightViewTips.OnKeyTipsUniquePosY)
		else
			recthelper.setAnchor(skillTipTr, self._originSkillPosX, FightViewTips.OnKeyTipsPosY)
		end
	else
		recthelper.setAnchor(skillTipTr, self._originSkillPosX, self._originSkillPosY)
	end
end

function FightViewTips:_hideCardSkillTips()
	self:_hideTips()
end

function FightViewTips:_onPassiveSkillClick(bossSkillInfos, skillIconTransform, offsetX, offsetY, entityId)
	if bossSkillInfos then
		for i, skillInfo in ipairs(bossSkillInfos) do
			local passiveSkillGO = self._passiveSkillGOs[i]

			if not passiveSkillGO then
				passiveSkillGO = gohelper.cloneInPlace(self._passiveSkillPrefab, "item" .. i)

				table.insert(self._passiveSkillGOs, passiveSkillGO)

				local img = gohelper.findChildImage(passiveSkillGO, "title/simage_icon")

				table.insert(self._passiveSkillImgs, img)
				self:_setPassiveSkillTip(passiveSkillGO, skillInfo, entityId)
				UISpriteSetMgr.instance:setFightPassiveSprite(img, skillInfo.icon)
			end

			local line = gohelper.findChild(self._passiveSkillGOs[#bossSkillInfos], "txt_desc/image_line")

			gohelper.setActive(line, false)
			gohelper.setActive(passiveSkillGO, true)
		end

		for i = #bossSkillInfos + 1, #self._passiveSkillGOs do
			gohelper.setActive(self._passiveSkillGOs[i], false)
		end

		gohelper.setActive(self._gobufftip, true)
	end
end

function FightViewTips:_onBuffClick(entityId, buffIconTransform, offsetX, offsetY)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		logError("get EntityMo fail, entityId : " .. tostring(entityId))

		return
	end

	if isDebugBuild then
		local tempList = {}

		for _, buffMO in pairs(entityMO:getBuffDic()) do
			local buffCO = lua_skill_buff.configDict[buffMO.buffId]
			local noShow = buffCO.isNoShow == 0 and "show" or "noShow"
			local goodOrBad = buffCO.isGoodBuff == 1 and "good" or "bad"
			local id = buffMO.buffId
			local name = buffCO.name
			local count = buffMO.count
			local duration = buffMO.duration
			local desc = buffCO.desc
			local s = string.format("id=%d count=%d duration=%d name=%s desc=%s %s %s", id, count, duration, name, desc, goodOrBad, noShow)

			table.insert(tempList, s)
		end

		logNormal(string.format("buff list %d :\n%s", #tempList, table.concat(tempList, "\n")))
	end

	local noShowBuff = true
	local buffDic = entityMO:getBuffDic()

	for _, buffMO in pairs(buffDic) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO and buffCO.isNoShow == 0 then
			noShowBuff = false

			break
		end
	end

	if noShowBuff then
		return
	end

	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = entityId,
		iconPos = buffIconTransform.position,
		offsetX = offsetX,
		offsetY = offsetY,
		viewname = self.viewName
	})
	self:_hideTips()

	local buffinfoWrapperTr = self._gobuffinfowrapper.transform
	local anchorPos = recthelper.rectToRelativeAnchorPos(buffIconTransform.position, buffinfoWrapperTr.parent)

	if entityMO.side == FightEnum.EntitySide.MySide then
		recthelper.setAnchor(buffinfoWrapperTr, anchorPos.x - offsetX + 100, anchorPos.y + offsetY)
	else
		recthelper.setAnchor(buffinfoWrapperTr, anchorPos.x + offsetX, FightViewTips.enemyBuffTipPosY)
	end

	self._buffinfoWrapperTr = buffinfoWrapperTr
	gohelper.onceAddComponent(self._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 0

	TaskDispatcher.runDelay(self._correctPos, self, 0.01)
end

function FightViewTips:_correctPos()
	local corrected = gohelper.fitScreenOffset(self._buffinfoWrapperTr)

	if corrected then
		recthelper.setAnchor(self._buffinfoWrapperTr, 0, 0)
	end

	gohelper.onceAddComponent(self._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 1
end

function FightViewTips:_formatSkillType(skillCO)
	if skillCO.effectTag == FightEnum.EffectTag.CounterSpell and FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell] then
		return FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell]
	end

	if not FightEnum.LogicTargetDesc[skillCO.logicTarget] then
		local prefix = luaLang("logic_target_single")

		if not FightEnum.EffectTagDesc[skillCO.effectTag] then
			local suffix = ""

			return prefix .. suffix
		end
	end
end

function FightViewTips:_formatSkillDesc(desc)
	return string.gsub(desc, "(%d+%%*)", "<color=#DC6262><size=26>%1</size></color>")
end

function FightViewTips:_formatPassiveSkillDesc(desc)
	return
end

function FightViewTips:_onShowFightPrompt(id, delay)
	TaskDispatcher.cancelTask(self._hidePrompt, self)
	TaskDispatcher.cancelTask(self._playPromptCloseAnim, self)

	local config = lua_fight_prompt.configDict[id]

	gohelper.setActive(self._gofightspecialtip, true)

	self._promptText.text = config.content

	UISpriteSetMgr.instance:setFightSprite(self._promptImage, "img_tsk_" .. config.color)
	self._prompAni:Play("open", 0, 0)

	if delay then
		TaskDispatcher.runDelay(self._playPromptCloseAnim, self, delay / 1000)
	end
end

function FightViewTips:_playPromptCloseAnim()
	self._prompAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._hidePrompt, self, 0.0005)
end

function FightViewTips:_hidePrompt()
	gohelper.setActive(self._gofightspecialtip, false)
end

function FightViewTips:_onShowSeasonGuardIntro(entityId, rectPos1X, rectPos1Y)
	self._guardTipsRoot = self._guardTipsRoot

	if not self._guardTipsRoot then
		self._guardTipsRoot = gohelper.create2d(self._tipsRoot, "guardTips")

		self._loader:loadAsset("ui/viewres/fight/fightseasonguardtipsview.prefab", self._onGuardTipsLoadFinish, self)

		self._guardTipsTran = self._guardTipsRoot.transform
	end

	gohelper.setActive(self._guardTipsRoot, true)

	rectPos1X = rectPos1X + 307

	recthelper.setAnchor(self._guardTipsTran, rectPos1X, rectPos1Y)
end

function FightViewTips:_onGuardTipsLoadFinish(success, loader)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, self._guardTipsRoot)
	local title = gohelper.findChildText(obj, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_title")
	local des = gohelper.findChildText(obj, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_dec")
	local config = lua_activity166_const_global.configDict[109]

	if config then
		title.text = config.value2 or ""
	end

	config = lua_activity166_const_global.configDict[110]

	if lua_activity166_const_global.configDict[110] then
		des.text = config.value2 or ""
	end
end

function FightViewTips:onDestroyView()
	self.buffTipClick:RemoveClickListener()

	self.buffTipClick = nil
end

return FightViewTips
