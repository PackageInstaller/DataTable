-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/new/CharacterHeartAnchorBreakSubViewCourse.lua

module("logic.extensions.characteranchor.new.CharacterHeartAnchorBreakSubViewCourse", package.seeall)

local M = class("CharacterHeartAnchorBreakSubViewCourse")

M.AnchorType = {
	Sublimed = 2,
	Normal = 1
}

function M:ctor(mainGo)
	self.mainGO = mainGo.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))

	self._guiAnimation:AddListener(self._animationDoneListener, self)
	goutil.setActive(registry:findUIElement("heart_anchor_course_view_1444864395"), false)
	goutil.setActive(registry:findUIElement("heart_anchor_course_view_200126150"), false)
	goutil.setActive(registry:findUIElement("heart_anchor_course_view_-1470557795"), false)
	goutil.setActive(registry:findUIElement("heart_anchor_course_view_-1199070992"), false)
	goutil.setActive(registry:findUIElement("heart_anchor_course_view_340821016"), false)
	goutil.setActive(registry:findUIElement("heart_anchor_course_view_-254867788"), false)

	local goBtnToSublimed = goutil.findChild(mainGO, "btnSublimed").gameObject

	goutil.setActive(goBtnToSublimed, false)

	local goResonanceTips = registry:findUIElement("heart_anchor_course_view_-1810263046")

	goutil.setActive(goResonanceTips, true)

	self._scrollResonanceTips = goutil.findChildComponent(goResonanceTips, "detailScroll", UIComponentType.ScrollRect)
	self._txtAnchorName = registry:findUIElement("heart_anchor_course_view_-117214732", UIComponentType.Text)
	self._descRootTrs = registry:findUIElement("heart_anchor_course_view_-1378071993", UIComponentType.RectTransform)
	self._btnAnchorContent = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_course_view_-1426968021"))
	self._cellItemForBreak = self:_buildCostItemCell(goutil.findChild(goResonanceTips, "backpack_item").gameObject)
	self._btnConfirm = UIComponentType.ButtonAdapter(goutil.findChild(goResonanceTips, "btnUpgrade"))
	self._breakContentGo = goutil.findChild(goResonanceTips, "breakContent")
	self._notBreakGo = goutil.findChild(goResonanceTips, "breakContent/txtNotBreak")
	self._imgCurrLv = goutil.findChildImageComponent(goResonanceTips, "breakContent/imgNum1")
	self._imgBreakLv = goutil.findChildImageComponent(goResonanceTips, "breakContent/imgNum2")
	self._txtBreakLv = goutil.findChildTextComponent(goResonanceTips, "breakContent/imgNum2/Text2")
	self._point1Go = goutil.findChild(goResonanceTips, "breakContent/point1")
	self._point2Go = goutil.findChild(goResonanceTips, "breakContent/point2")
	self._goCannotBreak = registry:findUIElement("heart_anchor_course_view_922399774")
	self._txtCannotBreak = registry:findUIElement("heart_anchor_course_view_-435690", UIComponentType.Text)
	self._rootUpgradeDetail = registry:findUIElement("heart_anchor_course_view_1760015635", UIComponentType.RectTransform)

	goutil.setActive(self._rootUpgradeDetail.gameObject, true)

	self._upgradeCellLst = {}

	for i = 0, self._rootUpgradeDetail.childCount - 1 do
		local _go = self._rootUpgradeDetail:GetChild(i).gameObject

		self._upgradeCellLst[i + 1] = self:_buildUpgradeContentCell(_go, i + 1)
	end

	self._rectTrHeartItem = registry:findUIElement("heart_anchor_course_view_1142996776", UIComponentType.RectTransform)
	self._heartAnchor = {
		[M.AnchorType.Normal] = {
			rectTr = registry:findUIElement("heart_anchor_course_view_-1642935123", UIComponentType.RectTransform),
			icon = registry:findUIElement("heart_anchor_course_view_936979527", UIComponentType.Image)
		},
		[M.AnchorType.Sublimed] = {
			rectTr = registry:findUIElement("heart_anchor_course_view_1832232280", UIComponentType.RectTransform),
			icon = registry:findUIElement("heart_anchor_course_view_-351815129", UIComponentType.Image)
		}
	}

	local txtShapedBefore = goutil.findChildComponent(registry:findUIElement("heart_anchor_course_view_-1642935123"), "not_reshaped/Text1", UIComponentType.Text)

	txtShapedBefore.text = lang("tip_tacit_state_before")

	local txtShapedAfter = goutil.findChildComponent(registry:findUIElement("heart_anchor_course_view_1832232280"), "reshaped/Text1", UIComponentType.Text)

	txtShapedAfter.text = lang("tip_tacit_state_after")

	local rectTrPos = registry:findUIElement("heart_anchor_course_view_1344199467", UIComponentType.RectTransform)
	local anchoredX, anchoredY = Astral.TransformUtil.GetAnchoredPos(rectTrPos, 0, 0)
	local scaleX, scaleY = RectTransformUtils.GetScale(rectTrPos, 1, 1)

	for _, comps in pairs(self._heartAnchor) do
		Astral.TransformUtil.SetAnchoredPos(self._rectTrHeartItem, anchoredX, anchoredY)
		RectTransformUtils.SetScale(self._rectTrHeartItem, scaleX, scaleY, 1)
	end
end

function M:destroyUI()
	self:setEvent(false)
	self:setHandler(nil)
	self._guiAnimation:RemoveListener()
	self._cellItemForBreak.btnClick:RemoveClickListener()

	self._cellItemForBreak = nil
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()
	end

	self._registry = nil

	for _, cell in pairs(self._upgradeCellLst or {}) do
		if cell.btnContent then
			cell.btnContent:RemoveClickListener()
		end
	end

	self._upgradeCellLst = nil
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter(isNormal)
	self:setEvent(true)
	self:_setAnchorSkillIcon()
	self:refreshInfo(false)
	self:playGuiAni("open_break", isNormal)
end

function M:onExit(isNormal)
	self:setEvent(false)

	for i, v in ipairs(self._btnList or {}) do
		v:RemoveClickListener()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CONTRACT_BREAKUP, self._handleContractBreakUp, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CONTRACT_BREAKUP, self._handleContractBreakUp, self)
	end
end

function M:_handleContractBreakUp()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_gongmingshengji, nil, nil, nil)
	self:refreshInfo(true)

	local heroData = self:getCurHeroData()

	ToolTipsMgr.showCharacterHeartAnchorBreakResultTips(heroData:getId(), heroData:getSkinId(), heroData:getBreakLv())
end

function M:playGuiAni(name, isNormal)
	self._guiAnimation:RemoveListener()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:SetAniTime(0)
	self._guiAnimation:AddListener(self._animationDoneListener, self)

	if string.nilorempty(name) then
		return
	end

	local __isNormal = true

	if isNormal ~= nil then
		__isNormal = isNormal
	end

	local mainGO = self:getMainGo()

	if mainGO.activeSelf and not string.nilorempty(name) then
		local timeLineMode = __isNormal and Astral.GUITimeLineMode.TimeToStart or Astral.GUITimeLineMode.TimeToEnd

		self._guiAnimation:PlayAniByName(name, timeLineMode)
	end
end

function M:_animationDoneListener(tagName, reason)
	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:StopTimelineAni()

	if tagName == "open" then
		-- block empty
	elseif tagName == "course1" then
		-- block empty
	elseif tagName == "course2" then
		-- block empty
	elseif tagName == "course3" then
		-- block empty
	elseif tagName == "course4" then
		-- block empty
	end
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		return nil
	end

	local data = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

	return data
end

function M:_onClickConfirm()
	local heroData = self:getCurHeroData()

	if not heroData then
		return
	end

	local curLevel = heroData:getBreakLv()
	local maxLevel = #HeroBreakConfig.instance:getAllHeroBreak()

	if curLevel == maxLevel then
		return
	end

	if not self._cellItemForBreak.getItemEnough() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	ContractAgent.instance:sendHeroBreakUpRequest(heroData:getId(), false)
end

function M:_onClickAnchorContent()
	local skillEnhanceMO
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local characterCO = heroData:getCharacterCo()
	local talentSkills = characterCO.battleTalent
	local skillId = talentSkills[1]

	skillEnhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(heroId, skillId)

	if skillEnhanceMO then
		skillEnhanceMO:rebuild()

		local desc = skillEnhanceMO:getDescription()
		local bindGo = self._btnAnchorContent.gameObject
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
	end
end

function M:_onClickUpgradeContent(cell)
	local index = cell.index
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local skillEnhanceMO
	local cfgBreakAttrCO = HeroBreakConfig.instance:getAttrCO(heroId, index)

	if cfgBreakAttrCO then
		local targetSkillId = cfgBreakAttrCO.skillId
		local targetEnhanceId = cfgBreakAttrCO.skillEnhanceId

		if targetSkillId > 0 then
			skillEnhanceMO = SkillEnhanceMO.New(targetSkillId)

			for i = 1, index do
				local cfg = HeroBreakConfig.instance:getAttrCO(heroId, i)

				if not cfg or cfg.attrGrowEnhance > 0 then
					-- block empty
				elseif cfg.skillId == targetSkillId and cfg.skillEnhanceId > 0 then
					skillEnhanceMO:addSkillEnhanceCode(cfg.skillEnhanceId)
				end
			end
		end
	else
		printWarn(string.format("角色[%s]没有配置合约,level[%s]", heroId, index))
	end

	if skillEnhanceMO then
		skillEnhanceMO:rebuild()

		local _desc = skillEnhanceMO:getDescription()
		local bindGo = cell.go
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
	end
end

function M:setBg(path)
	return
end

function M:_setAnchorSkillIcon()
	local heroData = self:getCurHeroData()
	local wakeUp = heroData:getAwakeTalent()
	local characterCO = heroData:getCharacterCo()
	local talentSkills = characterCO.battleTalent
	local skillId = talentSkills[1]

	if #talentSkills >= 3 then
		skillId = wakeUp and talentSkills[3] or talentSkills[2]
	end

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId or 0)
	local iconPath = ActiveSkillCOUtil.getSkillIcon(skillCOWrapper:getSkillCO())

	if not string.nilorempty(iconPath) then
		local anchorType = wakeUp and M.AnchorType.Sublimed or M.AnchorType.Normal
		local skillIconImg = self._heartAnchor[anchorType].icon

		IconLoader.setSprite(skillIconImg, IconType.SkillIcon, iconPath, function()
			skillIconImg:SetNativeSize()
		end, self)
	end
end

function M:refreshItemCost()
	local heroData = self:getCurHeroData()
	local curLevel = heroData:getBreakLv()
	local maxLevel = #HeroBreakConfig.instance:getAllHeroBreak()

	if curLevel ~= maxLevel then
		local count, itemData = ItemModel.instance:getItemByHeroId(heroData:getId(), CommEnum.HeroItemSubType.HeroHeartAnchor)

		if not itemData then
			local allHeroItem = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.HeroItemType, 1)

			for _, v in pairs(allHeroItem) do
				if v.heroId == heroData:getId() then
					itemData = ItemData.New({
						count = 0,
						itemId = v.id
					})

					break
				end
			end
		end

		local heroBreakCO = HeroBreakConfig.instance:getInfo(curLevel + 1)
		local needHeartAnchor = heroBreakCO and heroBreakCO.needNum or 1

		self._cellItemForBreak.updateData(itemData:getItemId(), needHeartAnchor)
		IconLoader.setSprite(self._imgCurrLv, IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor, GameUrl.getHeroBreakLvImage(curLevel))
		IconLoader.setSprite(self._imgBreakLv, IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor, GameUrl.getHeroBreakLvImage(curLevel + 1))

		for i = 1, self._point1Go.transform.childCount do
			local childGo = goutil.findChild(self._point1Go, "contract_break_point/done/sign" .. i)

			goutil.setActive(childGo, i <= curLevel)
		end

		for i = 1, self._point2Go.transform.childCount do
			local childGo = goutil.findChild(self._point2Go, "contract_break_point/done/sign" .. i)

			goutil.setActive(childGo, i <= curLevel)
		end

		for i = 1, self._point2Go.transform.childCount do
			local childGo = goutil.findChild(self._point2Go, "Image" .. i)

			goutil.setActive(childGo, i == curLevel + 1)
		end

		self._imgBreakLv.color = Astral.ColorUtil.ParseColor("#FFFFFF")
		self._txtBreakLv.color = parsecolor("#FFFFFF")

		if self._cellItemForBreak.getItemEnough() then
			self._imgBreakLv.color = Astral.ColorUtil.ParseColor("#86D0E8")
			self._txtBreakLv.color = parsecolor("#86D0E8")
		end

		goutil.setActive(goutil.findChild(self._point1Go, "contract_break_point/done"), curLevel ~= 0)
		goutil.setActive(goutil.findChild(self._point2Go, "contract_break_point/done"), curLevel ~= 0)
		goutil.setActive(self._imgCurrLv.gameObject, curLevel ~= 0)
		goutil.setActive(self._notBreakGo, curLevel == 0)
	end

	self._cellItemForBreak.setVisible(curLevel ~= maxLevel)
	goutil.setActive(self._goCannotBreak, curLevel == maxLevel)
	goutil.setActive(self._btnConfirm.gameObject, curLevel ~= maxLevel)
	goutil.setActive(self._breakContentGo, curLevel ~= maxLevel)
end

function M:refreshInfo(isDealingBreak)
	local heroData = self:getCurHeroData()
	local wakeUp = heroData:getAwakeTalent()
	local anchorType = wakeUp and M.AnchorType.Sublimed or M.AnchorType.Normal

	for _type, comps in pairs(self._heartAnchor) do
		goutil.setActive(comps.rectTr.gameObject, _type == anchorType)
	end

	local heroId = heroData:getId()
	local curLevel = heroData:getBreakLv()
	local anchorName, anchorDesc
	local characterCO = heroData:getCharacterCo()
	local anchorDescDetail = {}

	if characterCO then
		local awakeStatus = TacitModel.instance:isAwakeTalentSkill(heroId)
		local isAwake = awakeStatus == CommEnum.TalentSkillAwakeStatus.Unlock
		local skillId = characterCO.battleTalent[1]
		local additionalSkillId = characterCO.battleTalent[awakeStatus]
		local shared = SkillEnhanceMO.New(skillId)

		if shared then
			local cfgBreakAttrCO = HeroBreakConfig.instance:getAttrCO(heroId, 1)

			if cfgBreakAttrCO then
				for _breakLv, _cfg in pairs(HeroBreakConfig.instance:getBreakSkillEnhanceIds(heroId)) do
					if _breakLv <= curLevel and _cfg.skillId == skillId then
						shared:addSkillEnhanceCode(_cfg.skillEnhanceId)
					end
				end

				for i = 1, 5 do
					local cfg = HeroBreakConfig.instance:getAttrCO(heroId, i)
					local isGained = i <= curLevel
					local _desc = ""

					if cfg and cfg.attrGrowEnhance > 0 then
						local num = math.floor(cfg.attrGrowEnhance * 100)

						_desc = langF("tip_character_anchor_tip_2", num)
					elseif cfg and cfg.skillId > 0 then
						if cfg.skillEnhanceId > 0 then
							local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(cfg.skillEnhanceId)

							_desc = skillEnhanceCOWrapper:getDescription(isGained)
						else
							local _mo = SkillEnhanceMO.getSharedMO(cfg.skillId)

							_desc = _mo:getDescription()

							SkillEnhanceMO.releaseSharedMO(_mo)
						end
					end

					table.insert(anchorDescDetail, _desc)
				end
			else
				printWarn(string.format("角色[%s]没有在t_%s进行配置，读技能表模拟", heroId, ConfigName.HeroBreakAttr))

				local allEnhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillId)
				local myEnhanceCodes = shared:getAllSkillEnhanceCode()

				for index, enhanceCode in ipairs(allEnhanceCodes) do
					local isGained = table.indexof(myEnhanceCodes, enhanceCode)

					if isGained then
						shared:addSkillEnhanceCode(enhanceCode)
					end

					local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

					table.insert(anchorDescDetail, skillEnhanceCOWrapper:getDescription(isGained))
				end
			end

			shared:rebuild()

			local addSkillEnhanceMO = false

			if additionalSkillId then
				addSkillEnhanceMO = SkillEnhanceMO.New(additionalSkillId)

				addSkillEnhanceMO:rebuild()
			end

			if addSkillEnhanceMO then
				local addSkillCO = addSkillEnhanceMO:getSkillCO()

				anchorName = addSkillCO.name
				anchorDesc = shared:getDescription()
			else
				local skillCO = shared:getSkillCO()

				anchorName = skillCO.name
				anchorDesc = shared:getDescription()
			end

			if cfgBreakAttrCO then
				local _desc = {}
				local enhanceSkillPos = 1

				for i = 1, 5 do
					local cfg = HeroBreakConfig.instance:getAttrCO(heroId, i)
					local isGained = i <= curLevel
					local isPreGained = i == curLevel + 1

					if (cfg and isGained or isPreGained) and cfg.skillId > 0 then
						if cfg.skillEnhanceId > 0 then
							local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(cfg.skillEnhanceId)
							local str = skillEnhanceCOWrapper:getDescription(isGained)

							str = isPreGained and string.format("<color=#D4692D>%s</color>", str) or str

							table.insert(_desc, enhanceSkillPos, str)

							enhanceSkillPos = enhanceSkillPos + 1
						else
							local _mo = SkillEnhanceMO.New(cfg.skillId)
							local str = _mo:getDescription()

							SkillEnhanceMO.releaseSharedMO(_mo)

							str = isPreGained and string.format("<color=#D4692D>%s</color>", str) or str

							table.insert(_desc, str)
						end
					end
				end

				local curPercent = HeroBreakConfig.instance:getBreakAttGrowEnhance(heroId, curLevel)
				local nextPercent = curLevel == 5 and curPercent or HeroBreakConfig.instance:getBreakAttGrowEnhance(heroId, curLevel + 1)

				if curPercent > 0 or nextPercent > 0 then
					if nextPercent == curPercent then
						table.insert(_desc, langF("tip_character_anchor_tip_2", math.floor(curPercent * 100)))
					elseif curPercent == 0 then
						local str = langF("tip_character_anchor_tip_2", math.floor(nextPercent * 100))

						str = string.format("<color=#D4692D>%s</color>", str)

						table.insert(_desc, str)
					else
						local str = langF("tip_character_anchor_tip_2", math.floor(curPercent * 100))

						str = string.format("%s<color=#D4692D>(%s)</color>", str, math.floor(nextPercent * 100))

						table.insert(_desc, str)
					end
				end
			end

			SkillEnhanceMO.releaseSharedMO(shared)
			SkillEnhanceMO.releaseSharedMO(addSkillEnhanceMO)
		end
	end

	self._txtAnchorName.text = anchorName

	local lines = string.split(anchorDesc, "\n")

	if #lines > 0 then
		self._btnList = {}

		while self._descRootTrs.childCount - 1 < #lines do
			goutil.cloneAndSetParent(self._descRootTrs:GetChild(1).gameObject, self._descRootTrs)
		end

		for i = 1, self._descRootTrs.childCount - 1 do
			local go = self._descRootTrs:GetChild(i).gameObject
			local txtDesc = go:GetComponent(UIComponentType.TMPText)

			txtDesc.text = lines[i]

			local btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))

			btnClick:AddClickListener(function()
				self:_onClickAnchorContent()
			end, self)
			table.insert(self._btnList, btnClick)
			goutil.setActive(go, i <= #lines)
		end
	end

	self:refreshItemCost()

	for index, cell in ipairs(self._upgradeCellLst) do
		local isBreak = index <= curLevel

		cell.canvasGroup.alpha = (isBreak or not isBreak and index == curLevel + 1) and 1 or 0.4
		cell.canvasGroupTxt.alpha = isBreak and 1 or 0.4
		cell.canvasGroupPoint.alpha = (isBreak or not isBreak and index == curLevel + 1) and 1 or 0.4
		cell.imgNum.color = Astral.ColorUtil.ParseColor("#eeeeee")

		cell.imgNum:CrossFadeAlpha(isBreak and 1 or 0.4, 0, true)

		local colorDescDetail = anchorDescDetail[index]

		if self._cellItemForBreak.getItemEnough() and index == curLevel + 1 then
			cell.canvasGroup.alpha = 1
			cell.canvasGroupTxt.alpha = 1
			cell.imgNum.color = Astral.ColorUtil.ParseColor("#86D0E8")

			cell.imgNum:CrossFadeAlpha(1, 0, true)

			colorDescDetail = string.format("<color=#86D0E8>%s</color>", anchorDescDetail[index])
		end

		cell.txtContent.text = colorDescDetail

		for i, _go in ipairs(cell.breakPointNext) do
			local show = index == curLevel + 1 and i == curLevel + 1 and i <= index

			goutil.setActive(_go, show)

			if show then
				goutil.setActive(cell.breakPointDone[i], false)
			else
				goutil.setActive(cell.breakPointDone[i], i <= index)
			end
		end
	end

	settimer(0, function()
		local needScroll = RectTransformUtils.GetHeight(self._scrollResonanceTips.content) > RectTransformUtils.GetHeight(self._scrollResonanceTips.transform)

		self._scrollResonanceTips.enabled = needScroll
	end, self, false)
end

function M:_buildUpgradeContentCell(go, index)
	local breakPointRoot = goutil.findChildComponent(go, "point", UIComponentType.RectTransform)
	local breakPointRootDone = goutil.findChildComponent(go, "point/contract_break_point/done", UIComponentType.RectTransform)

	goutil.setActive(breakPointRootDone.gameObject, true)

	local cell = {}

	cell.go = go
	cell.index = index
	cell.imgNum = goutil.findChildImageComponent(go, "imgNum")
	cell.txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI)
	cell.canvasGroupTxt = goutil.addComponentOnce(cell.txtContent.gameObject, ComponentType.CanvasGroup)
	cell.btnContent = UIComponentType.ButtonAdapter(goutil.findChild(go, "txtContent/click").gameObject)
	cell.canvasGroup = goutil.findChildComponent(go, "", ComponentType.CanvasGroup)
	cell.canvasGroupPoint = goutil.addComponentOnce(breakPointRoot.gameObject, ComponentType.CanvasGroup)
	cell.breakPointNext = {
		breakPointRoot:GetChild(1).gameObject,
		breakPointRoot:GetChild(2).gameObject,
		breakPointRoot:GetChild(3).gameObject,
		breakPointRoot:GetChild(4).gameObject,
		breakPointRoot:GetChild(5).gameObject
	}
	cell.breakPointDone = {
		breakPointRootDone:GetChild(0).gameObject,
		breakPointRootDone:GetChild(1).gameObject,
		breakPointRootDone:GetChild(2).gameObject,
		breakPointRootDone:GetChild(3).gameObject,
		breakPointRootDone:GetChild(4).gameObject
	}

	cell.btnContent:AddClickListener(function()
		self:_onClickUpgradeContent(cell)
	end, self)

	return cell
end

function M:_buildCostItemCell(go)
	local cell = {}

	cell.go = go
	cell.imgQuality = goutil.findChildImageComponent(go, "imgQuality")
	cell.imgIcon = goutil.findChildImageComponent(go, "imgIcon")
	cell.txtCount = goutil.findChildTextComponent(go, "txtDown")
	cell.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

	function cell.getItemEnough()
		local enough = false

		if cell.itemId and cell.itemId > 0 then
			local curNum = ItemModel.instance:getItemCountByItemId(cell.itemId)

			enough = curNum >= cell.itemCount
		end

		return enough
	end

	function cell.updateCount()
		local countStr

		if cell.itemId and cell.itemId > 0 then
			local curNum = ItemModel.instance:getItemCountByItemId(cell.itemId)

			countStr = curNum >= cell.itemCount and string.format("%s/%d", MathUtil.getCoinValue(curNum), cell.itemCount) or string.format("<color=#e05959>%s</color>/%d", MathUtil.getCoinValue(curNum), cell.itemCount)

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(cell.itemId)

			if itemCo then
				IconLoader.setSprite(cell.imgIcon, IconType.ItemIcon, itemCo.icon)
				IconLoader.setSprite(cell.imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[itemCo.quality])
			end
		end

		cell.txtCount.text = countStr
	end

	function cell.updateData(itemId, itemCount)
		cell.itemId = itemId
		cell.itemCount = itemCount

		cell.updateCount()
	end

	function cell.setVisible(show)
		goutil.setActive(cell.go, show)
	end

	cell.btnClick:AddClickListener(function()
		self:_onCostItemClick(cell.go, cell.itemId)
	end, self)

	return cell
end

function M:_onCostItemClick(itemGo, itemId)
	local count = ItemModel.instance:getItemCountByItemId(itemId)
	local itemData = ItemData.New({
		count = count,
		itemId = itemId
	})
	local data = ToolTipsUtil.createItemTipsData(itemData, itemGo)

	data.isPassEvent = false

	ToolTipsMgr.showTips(data.viewName, data)
end

return M
