-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petintroduction/view/PetIntroductionView.lua

module("logic.extensions.petintroduction.view.PetIntroductionView", package.seeall)

local PetIntroductionView = class("PetIntroductionView", ViewComponent)

function PetIntroductionView:buildUI()
	PetIntroductionView.super.buildUI(self)
	self:_initRoleInfos()
	self:_initSkillNode()
	self:_initAnimations()
	self:_initToggle()
end

function PetIntroductionView:_initRoleInfos()
	local canvas = self:getGo("Canvas")

	self._conNode = self:getGo("Canvas/Part1/con")
	self._name = self:getTxt("Canvas/Part1/Name")
	self._txtCV = self:getTxt("Canvas/Part1/txtCV")
	self._roleParent = self:getGo("Canvas/RoleParent").transform
	self._attrBtn = self:getBtn("Canvas/Part1/Info/attr")
	self._imgAttr = goutil.findChildComponent(self.mainGO, "Canvas/Part1/Info/attr/icon", "UIImageSpriteChange")
	self._jobBtn = self:getBtn("Canvas/Part1/Info/job")
	self._job1Btn = self:getBtn("Canvas/Part1/Info/job1")
	self._jobIcon = goutil.findChildComponent(self.mainGO, "Canvas/Part1/Info/job/icon", "UIImageSpriteChange")
	self._job1Icon = goutil.findChildComponent(self.mainGO, "Canvas/Part1/Info/job1/icon", "UIImageSpriteChange")
	self._txtDesc = self:getTxt("Canvas/Part1/Info/Desc")
	self._clickMask = Framework.UIClickTrigger.Get(self:getGo("ClickMask"))
	self._txtSlogan = self:getTxt("Canvas/Part1/Info/txtSlogan")

	GameUtil.expandRectTransform(canvas.transform)
	self:_initOutlines()
end

function PetIntroductionView:_initOutlines()
	local tOutline = typeof(OutlineEx)

	self._nameOutline = self._name:GetComponent(tOutline)
	self._txtDescOutline = self._txtDesc:GetComponent(tOutline)
	self._txtCVOutline = self._txtCV:GetComponent(tOutline)
	self._toggleNameOutline = self:getGo("Canvas/toggle/name"):GetComponent(tOutline)
	self._toggleLabelOutline = self:getGo("Canvas/toggle/name/Label"):GetComponent(tOutline)
end

function PetIntroductionView:_initSkillNode()
	self._skillIcons = self:getGo("Canvas/Skill/View/Viewport/Content/Icons"):GetComponent(ComponentType.UILayoutSingleLine)
	self._skillViewContent = self:getGo("Canvas/Skill/View/Viewport/Content").transform
end

function PetIntroductionView:_initAnimations()
	local canvasGroup = typeof(UnityEngine.CanvasGroup)

	self._bg = self:getGo("Bg")
	self._part1Root = self:getGo("Canvas/Part1")
	self._skillRoot = self:getGo("Canvas/Skill")
	self._clickContinue = self:getGo("Canvas/ClickContinue")
	self._bgCanvasGroup = self._bg:GetComponent(canvasGroup)
	self._part1CanvasGroup = self._part1Root:GetComponent(canvasGroup)
	self._skillCanvasGroup = self._skillRoot:GetComponent(canvasGroup)
	self._clickCanvasGroup = self._clickContinue:GetComponent(canvasGroup)
	self._toggleCanvasGroup = self:getGo("Canvas/toggle"):GetComponent(canvasGroup)
end

function PetIntroductionView:_initToggle()
	self._toggle = self:getToggle("Canvas/toggle")
	self._txtTogName = self:getTxt("Canvas/toggle/name")

	local clickToggle = self:getGo("Canvas/toggle/toggleBtn")

	self._clickToggle = Framework.UIClickTrigger.Get(clickToggle)
end

function PetIntroductionView:unbindEvents()
	self._attrBtn:RemoveClickListener()
	self._jobBtn:RemoveClickListener()
	self._job1Btn:RemoveClickListener()
	self._clickMask:RemoveClickListener()
	self._clickToggle:RemoveClickListener()
end

function PetIntroductionView:onEnter()
	self._saveTimeScale = UnityEngine.Time.timeScale
	UnityEngine.Time.timeScale = 1
	self._raceId = self:getFirstParam()

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._conNode)
	self:_updateRoleInfos()
	self._clickMask:AddClickListener(self._onClickMask, self)
	self:_setToggle()
	self:_resetEnterAnim()
	AudioPlayerEx.instance:playEffect(30226)
	Framework.TransformUtil.SetAnchoredPos(self._skillViewContent, 0, 0)
end

function PetIntroductionView:_updateRoleModel(petCo)
	local displayBagOffset = CharactorFacade.instance:getPetIntrodModelUIPosAndScale(tonumber(petCo.faceIds))
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._raceId, self._roleParent, scale, function(go)
		self:_updateSpineMat(go)
		self:_playEnterAnim()
	end, true, x, y)
end

function PetIntroductionView:_updateSpineMat(go)
	local r = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

	self._spineRenderer = r
	self._saveMaterial = r.material
	self._tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
	self._tempMat.mainTexture = r.material.mainTexture
	r.material = self._tempMat
end

function PetIntroductionView:_updateRoleInfos()
	local petCo = CharacterConfig.instance:getPetCo(self._raceId)
	local petInfo = CharacterConfig.instance:getPetInfoCo(self._raceId)

	self._txtDesc.text = string.gsub(petInfo.stragegy, "\n", "，")

	local cvName = PetSkinConfig.instance:getSkinCvName(self._raceId)

	self._name.text = petCo.name
	self._txtCV.text = string.nilorempty(cvName) and cvName or "CV." .. cvName

	self:_updateSkillCv()
	self:_updateJob(petCo)
	self:_updateRoleModel(petCo)
	self:_updateSkill(petCo)
end

function PetIntroductionView:_updateSkillCv()
	local cfgs = CharacterConfig.instance:getPetCvCfg(self._raceId)
	local cvCfg

	if cfgs then
		for _, v in pairs(cfgs) do
			if v.isPetIntrod == 1 then
				cvCfg = v

				break
			end
		end
	end

	if not cvCfg then
		for _, v in pairs(cfgs) do
			if v.isDefault == 1 then
				cvCfg = v

				break
			end
		end
	end

	if cvCfg then
		self._txtSlogan.text = cvCfg.word

		local audioId = cvCfg.audioId

		if audioId > 0 then
			AudioPlayerEx.instance:playVoice(audioId)
		end
	else
		self._txtSlogan.text = ""
	end
end

function PetIntroductionView:_updateJob(cfg)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(cfg.raceId)
	local targetValue = race - 1

	pcall(self._imgAttr.SetState, self._imgAttr, targetValue)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

	pcall(self._jobIcon.SetState, self._jobIcon, firstJobIdx - 1)
	goutil.setActive(self._job1Icon.transform.parent.gameObject, false)
	goutil.setActive(self._jobIcon.transform.parent.gameObject, true)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(cfg.raceId)

	if secondJobIdx > 20 then
		goutil.setActive(self._job1Icon.transform.parent.gameObject, true)
		self._job1Icon:SetState(secondJobIdx - 1 - 20)
		self._job1Btn:AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(self._job1Btn, MatType.Job, secondJobIdx)
		end)
	end

	self._attrBtn:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._attrBtn, MatType.Race, race)
	end)
	self._jobBtn:AddClickListener(function()
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

		CommonTipsMgr.instance:openMaterialTips(self._jobBtn, MatType.Job, firstJobIdx)
	end)
end

function PetIntroductionView:_updateSkill(cfg)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(cfg.raceId)
	local skillIds = {}
	local sortedKeys = MaterialMgr.getAllSkillsSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.getSkillKeyNameByType(skillType)
		local skillId = petCo[v]

		if skillId ~= 0 then
			table.insert(skillIds, skillId)
		end
	end

	local cnt = #skillIds
	local transform = self._skillIcons.transform
	local childCount = transform.childCount

	while childCount < cnt do
		childCount = childCount + 1

		local child = transform:GetChild(0).gameObject

		UGUIToolHelper.AddChild(transform.gameObject, child)
	end

	for i = 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local icon = goutil.findChild(go, "icon")
		local txtSkillType = goutil.findChildTextComponent(go, "TxtC_Type")

		txtSkillType.text = MaterialMgr.getSkillTypeName(skillIds[i])

		local btn = Framework.ButtonAdapter.Get(go)

		MaterialMgr.setSkillByFaceId(skillIds[i], cfg.raceId, icon)

		txtSkillType.text = MaterialMgr.getSkillTypeName(skillIds[i])

		btn:RemoveClickListener()
		btn:AddClickListener(function()
			if self._closable then
				CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillIds[i], cfg.raceId)
			end
		end)
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._skillIcons:Layout()

	local sizeDelta = self._skillViewContent.sizeDelta

	sizeDelta.x = cnt * 90
	self._skillViewContent.sizeDelta = sizeDelta
end

function PetIntroductionView:_adjustSkillBg(cnt)
	local sizeDelta = self._skillBg.sizeDelta

	if cnt == 2 then
		Framework.TransformUtil.SetLocalPos(self._skillBg, -374, -122, 0)

		sizeDelta.x = 306
	elseif cnt == 3 then
		Framework.TransformUtil.SetLocalPos(self._skillBg, -300, -112, 0)

		sizeDelta.x = 456
	elseif cnt == 4 then
		Framework.TransformUtil.SetLocalPos(self._skillBg, -228, -102, 0)

		sizeDelta.x = 604
	end

	self._skillBg.sizeDelta = sizeDelta
end

function PetIntroductionView:_playEnterAnim()
	self:_playEffects()
	UnityTweens.UITweenFadeIn.StartTween(self._bg, 0.2, UnityTweens.EaseType.easeOutSine)
	UnityTweens.UITweenFadeIn.StartTween(self._roleParent.gameObject, 0.2, UnityTweens.EaseType.linear, 0.2)
	UnityTweens.UITweenFadeIn.StartTween(self._part1Root, 0.2, UnityTweens.EaseType.linear, 0.2)
	UnityTweens.TweenPosition.StartTween(self._skillRoot, Vector3.New(0, 30, 0), Vector3.New(0, 0, 0), 0.2, UnityTweens.EaseType.easeOutSine, 0.4)
	UnityTweens.UITweenFadeIn.StartTween(self._skillRoot, 0.2, UnityTweens.EaseType.easeInSine, 0.4)
	UnityTweens.UITweenFadeIn.StartTween(self._toggle.gameObject, 0.2, UnityTweens.EaseType.easeInSine, 0.6)
	UnityTweens.UITweenFadeIn.StartTween(self._clickContinue, 0.2, UnityTweens.EaseType.easeInSine, 0.6):AddListener(function()
		self:_onTweenInFinish()
	end)
	self:_tweenIn1Outlines()
end

function PetIntroductionView:_onTweenInFinish()
	self._loopEvent = AudioPlayerEx.instance:playEffect(30227)
	self._closable = true

	self:_setPart1OutlineAlpha(1)
	self:_setToggleOutlineAlpha(1)
	self:_setSkillIconsOutlineAlpha(1)
	removetimer(self._tweenPart1OutlineIn, self)
	removetimer(self._tweenToggleOutlineIn, self)
	removetimer(self._tweenSkillsOutlineIn, self)
end

function PetIntroductionView:_tweenIn1Outlines()
	self._part1OutlineTime = 0
	self._toggleOutlineTime = 0
	self._skillsOutlineTime = 0

	settimer(0, self._tweenPart1OutlineIn, self)
	settimer(0, self._tweenToggleOutlineIn, self)
	settimer(0, self._tweenSkillsOutlineIn, self)
end

function PetIntroductionView:_tweenSkillsOutlineIn()
	self._skillsOutlineTime = self._skillsOutlineTime + UnityEngine.Time.deltaTime

	local time = self._skillsOutlineTime - 0.5

	if time > 0 then
		local alpha = time / 0.1

		self:_setSkillIconsOutlineAlpha(alpha)

		if alpha >= 1 then
			removetimer(self._tweenSkillsOutlineIn, self)
		end
	end
end

function PetIntroductionView:_tweenPart1OutlineIn()
	self._part1OutlineTime = self._part1OutlineTime + UnityEngine.Time.deltaTime

	local alpha = self._part1OutlineTime / 0.2

	self:_setPart1OutlineAlpha(alpha)

	if alpha >= 1 then
		removetimer(self._tweenPart1OutlineIn, self)
	end
end

function PetIntroductionView:_tweenToggleOutlineIn()
	self._toggleOutlineTime = self._toggleOutlineTime + UnityEngine.Time.deltaTime

	local time = self._toggleOutlineTime - 0.6

	if time > 0 then
		local alpha = time / 0.2

		self:_setToggleOutlineAlpha(alpha)

		if alpha >= 1 then
			removetimer(self._tweenToggleOutlineIn, self)
		end
	end
end

function PetIntroductionView:_setPart1OutlineAlpha(a)
	self._nameOutline:SetColorRGBA(0, 0, 0, a)
	self._txtDescOutline:SetColorRGBA(0, 0, 0, a)
	self._txtCVOutline:SetColorRGBA(0, 0, 0, a)
end

function PetIntroductionView:_setSkillIconsOutlineAlpha(a)
	return
end

function PetIntroductionView:_setToggleOutlineAlpha(a)
	self._toggleNameOutline:SetColorRGBA(0, 0, 0, a)
	self._toggleLabelOutline:SetColorRGBA(0, 0, 0, a)
end

function PetIntroductionView:_playEffects()
	self:_stopEffects()

	self._appearEff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_chuchang/fx_ui_chuchang.prefab", self.mainGO.transform, true)

	self._appearEff:setParent(self.mainGO.transform)
	self._appearEff:setSortingOrder(240)
	self._appearEff:setScale(1)

	self._appearEff.hideEffWhileNotOnTop = nil
	self._bgEffect = UIEffectManager.instance:playEffectBrief(self, "fx_ui_chuchang/fx_ui_chuchuang_daiji_hou.prefab", self.mainGO.transform, true)

	self._bgEffect:setParent(self.mainGO.transform)
	self._bgEffect:setScale(1)

	self._bgEffect.hideEffWhileNotOnTop = nil
	self._effect = UIEffectManager.instance:playEffectBrief(self, "fx_ui_chuchang/fx_ui_chuchuang_daiji_qian.prefab", self.mainGO.transform, true)

	self._effect:setParent(self.mainGO.transform)
	self._effect:setScale(1)
	self._effect:setSortingOrder(240)

	self._effect.hideEffWhileNotOnTop = nil
end

function PetIntroductionView:_stopEffects()
	if self._appearEff then
		UIEffectManager.instance:stopEffect(self._appearEff)

		self._appearEff = nil
	end

	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

function PetIntroductionView:_resetEnterAnim()
	self._closable = nil
	self._bgCanvasGroup.alpha = 0
	self._part1CanvasGroup.alpha = 0
	self._skillCanvasGroup.alpha = 0
	self._clickCanvasGroup.alpha = 0
	self._toggleCanvasGroup.alpha = 0

	self:_setPart1OutlineAlpha(0)
	self:_setToggleOutlineAlpha(0)
	self:_setSkillIconsOutlineAlpha(0)
end

function PetIntroductionView:_playExitAnim()
	ViewMgr.instance:close(ViewName.CommonJobTipsView)
	UnityTweens.UITweenFadeOut.StartTween(self._clickContinue, 0.2, UnityTweens.EaseType.easeOutSine)
	UnityTweens.UITweenFadeOut.StartTween(self._toggle.gameObject, 0.2, UnityTweens.EaseType.easeOutSine)
	UnityTweens.TweenPosition.StartTween(self._skillRoot, Vector3.New(0, 0, 0), Vector3.New(0, 30, 0), 0.2, UnityTweens.EaseType.easeOutSine, 0.2):AddListener(function()
		self:_stopEffects()
	end)
	UnityTweens.UITweenFadeOut.StartTween(self._skillRoot, 0.2, UnityTweens.EaseType.easeOutSine, 0.2)
	UnityTweens.UITweenFadeOut.StartTween(self._bg, 0.2, UnityTweens.EaseType.easeOutSine, 0.4)
	UnityTweens.UITweenFadeOut.StartTween(self._roleParent.gameObject, 0.2, UnityTweens.EaseType.easeOutSine, 0.4)
	UnityTweens.UITweenFadeOut.StartTween(self._part1Root, 0.2, UnityTweens.EaseType.easeOutSine, 0.4)

	local grayMaskGo = ViewMgr.instance._grayMaskGO

	UnityTweens.UITweenFadeTo.StartTween(grayMaskGo, 0, 0.2, UnityTweens.EaseType.easeOutSine, 0.4)
	UnityTweens.TweenEmpty.StartTween(self.mainGO, 0.6, function()
		self:close()
	end)
	self:_stopLoopingEffects()
	self:_tweenOut1Outlines()
end

function PetIntroductionView:_stopLoopingEffects()
	if self._loopEvent then
		AudioPlayerEx.instance:stopEvent(self._loopEvent)

		self._loopEvent = nil
	end
end

function PetIntroductionView:_tweenOut1Outlines()
	self._part1OutlineTime = 0
	self._toggleOutlineTime = 0
	self._skillsOutlineTime = 0

	settimer(0, self._tweenPart1OutlineOut, self)
	settimer(0, self._tweenToggleOutlineOut, self)
	settimer(0, self._tweenSkillsOutlineOut, self)
end

function PetIntroductionView:_tweenPart1OutlineOut()
	self._part1OutlineTime = self._part1OutlineTime + UnityEngine.Time.deltaTime

	local time = self._part1OutlineTime - 0.4

	if time > 0 then
		local alpha = math.max(0, 1 - time / 0.1)

		self:_setPart1OutlineAlpha(alpha)

		if alpha <= 0 then
			removetimer(self._tweenPart1OutlineIn, self)
		end
	end
end

function PetIntroductionView:_tweenSkillsOutlineOut()
	self._skillsOutlineTime = self._skillsOutlineTime + UnityEngine.Time.deltaTime

	local time = self._skillsOutlineTime - 0.2

	if time > 0 then
		local alpha = math.max(0, 1 - time / 0.1)

		self:_setSkillIconsOutlineAlpha(alpha)

		if alpha <= 0 then
			removetimer(self._tweenSkillsOutlineOut, self)
		end
	end
end

function PetIntroductionView:_tweenToggleOutlineOut()
	self._toggleOutlineTime = self._toggleOutlineTime + UnityEngine.Time.deltaTime

	local alpha = math.max(0, 1 - self._toggleOutlineTime / 0.1)

	self:_setToggleOutlineAlpha(alpha)

	if alpha <= 0 then
		removetimer(self._tweenToggleOutlineOut, self)
	end
end

function PetIntroductionView:onExit()
	UnityTweens.TweenEmpty.StopTween(self.mainGO)
	self:_stopLoopingEffects()
	self:unbindEvents()
	self:_saveToggleSelect()
end

function PetIntroductionView:onExitFinished()
	AudioVoicePlayer.instance:stopVoice(true)
	self:_stopEffects()
	removetimer(self._tweenPart1OutlineIn, self)
	removetimer(self._tweenToggleOutlineIn, self)
	removetimer(self._tweenSkillsOutlineIn, self)
	removetimer(self._tweenPart1OutlineOut, self)
	removetimer(self._tweenToggleOutlineOut, self)
	removetimer(self._tweenSkillsOutlineOut, self)

	UnityEngine.Time.timeScale = self._saveTimeScale or 1
	self._saveTimeScale = nil
	self._raceId = nil

	MaterialMgr.resetAll(self._conNode)

	if self._spineRenderer then
		self._spineRenderer.material = self._saveMaterial
		self._saveMaterial = nil
		self._spineRenderer = nil
	end

	if self._tempMat then
		goutil.destroy(self._tempMat)

		self._tempMat = nil
	end

	RoleObjectPool.instance:removeRole(self._role)

	local sTransform = self._skillIcons.transform

	for i = 0, sTransform.childCount - 1 do
		local go = sTransform:GetChild(i).gameObject
		local icon = goutil.findChild(go, "icon")
		local btn = Framework.ButtonAdapter.Get(go)

		MaterialMgr.resetAll(icon)
		btn:RemoveClickListener()
	end

	local grayMaskGo = ViewMgr.instance._grayMaskGO
	local grayMashColor = ViewMgr.instance:getMaskColor()
	local img = goutil.addComponentOnce(grayMaskGo, typeof(UnityEngine.UI.Image))

	img.color = parsecolor(grayMashColor)
end

function PetIntroductionView:_onClickMask()
	if self._closable then
		UnityTweens.TweenEmpty.StopTween(self.mainGO)

		self._closable = nil

		self:_playExitAnim()
	end
end

function PetIntroductionView:_setToggle()
	self._toggle.gameObject:SetActive(false)

	local param = self:getOpenParam()

	if not param or not param[2] then
		return
	end

	local legendParam = param[2]

	if legendParam.battleType == MissionConst.BattleLegend then
		self._toggle.gameObject:SetActive(true)

		self._toggle.isOn = GameUtil.getUserDayData(MissionConst.BattleLegend .. legendParam.challengeId)
		self._txtTogName.text = legendParam.challengeName

		self._clickToggle:AddClickListener(self._onClickToggle, self)
	end
end

function PetIntroductionView:_onClickToggle()
	self._toggle.isOn = not self._toggle.isOn
end

function PetIntroductionView:_saveToggleSelect()
	local param = self:getOpenParam()

	if not param or not param[2] then
		return
	end

	local legendParam = param[2]

	if legendParam.battleType == MissionConst.BattleLegend then
		GameUtil.saveUserDayData(MissionConst.BattleLegend .. legendParam.challengeId, self._toggle.isOn)
	end
end

return PetIntroductionView
