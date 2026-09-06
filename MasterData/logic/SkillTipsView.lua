-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/SkillTipsView.lua

module("logic.extensions.common.instruction.view.SkillTipsView", package.seeall)

local SkillTipsView = class("SkillTipsView", ViewComponent)

function SkillTipsView:ctor()
	SkillTipsView.super.ctor(self)
end

function SkillTipsView:destroyUI()
	SkillTipsView.super.destroyUI(self)
end

function SkillTipsView:onExitFinished()
	SkillTipsView.super.onExitFinished(self)
end

function SkillTipsView:onEnterFinished()
	SkillTipsView.super.onEnterFinished(self)
end

function SkillTipsView:unbindEvents()
	SkillTipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function SkillTipsView:bindEvents()
	SkillTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function SkillTipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function SkillTipsView:onExit()
	SkillTipsView.super.onExit(self)
	MaterialMgr.resetAll(self._imgIcon)
	removetimer(self._checkDescHeight, self)
end

function SkillTipsView:buildUI()
	SkillTipsView.super.buildUI(self)

	self.content = self:getGo("Nego_Content")

	local top = goutil.findChild(self.content, "Nego_Top")
	local bottom = goutil.findChild(self.content, "Nego_Bottom")

	self._imgIcon = goutil.findChild(top, "ImgC_Con")
	self._txtName = goutil.findChildTextComponent(top, "TxtC_Name")
	self._txtLevel = goutil.findChildTextComponent(top, "TxtC_Type/TxtC_level")
	self._txtType = goutil.findChildTextComponent(top, "TxtC_Type")
	self._txtDesc = goutil.findChildTextComponent(bottom, "TxtC_Desc")
	self.labelGroup = self:getGo("Nego_Content/Nego_Top/labelGroup")
	self.label = self:getGo("Nego_Content/Nego_Top/label")
	self.TxtC_VigourGo = self:getGo("Nego_Content/Nego_Top/TxtC_Vigour")
	self.TxtC_Vigour = self:getTxt("Nego_Content/Nego_Top/TxtC_Vigour/txt")
	self._descTitle2 = goutil.findChild(bottom, "descTitle2")
	self._customInput = UICustomInput.Get(self.content)
	self._adjustPosition = self.content:GetComponent("UIAdjustPosition")
	self._contentSizeImmediate = self.content:GetComponent("ContentSizeImmediate")
	self._scrollView = goutil.findChild(bottom, "SrollView"):GetComponent("ScrollRect")
	self._txtScrollDesc = self:getTxt("Nego_Content/Nego_Bottom/SrollView/Viewport/Content/TxtC_Desc")
end

function SkillTipsView:onEnter()
	SkillTipsView.super.onEnter(self)

	local params = self:getOpenParam()
	local data = params[1]
	local pos = params[2]
	local sizeDelta = params[3]
	local skillId = data.id
	local raceId = data.extData1
	local skillLv = checknumber(data.extData2)
	local petMo = data.extData3
	local curCfg = BattleConfig.instance:getSkillCo(skillId, raceId)
	local skillType = GameEnum.SkillNameToType[curCfg.type]

	self._txtName.text = curCfg.name
	self._txtDesc.text = curCfg.desc

	if skillType == GameEnum.SkillRaceType.SourceTraceSkill and petMo then
		self._txtDesc.text = self:_getSourceSkillDesc(petMo)
	end

	self._txtScrollDesc.text = self._txtDesc.text
	self._txtType.text = ConstString.SkillType[skillType]

	GameUtil.SetActive(self.TxtC_VigourGo, false)

	if checknumber(curCfg.needVigour) > 0 then
		GameUtil.SetActive(self.TxtC_VigourGo, true)

		self.TxtC_Vigour.text = curCfg.needVigour
	end

	goutil.clearChildren(self.labelGroup)

	if not curCfg.labelIds then
		for i, lbId in ipairs(curCfg.labelIds) do
			local lbCfg = BattleConfig.instance:getSkillLabel(lbId)

			if lbCfg then
				local go = goutil.clone(self.label, "lable_" .. lbCfg.labelId)

				goutil.addChildToParent(go, self.labelGroup)
				GameUtil.SetActive(go, true)

				local comp = go:GetComponent("Image")

				Framework.ColorUtil.SetImageColor(comp, lbCfg.labelColor)

				local txt = goutil.findChildTextComponent(go, "txt")

				txt.text = lbCfg.labelName

				if not string.nilorempty(lbCfg.outlineColor) then
					local color = parsecolor(lbCfg.outlineColor)
					local outline = goutil.findChild(go, "txt"):GetComponent("Outline")

					if outline then
						outline.effectColor = color
					end
				end
			end
		end

		MaterialMgr.setSkillByFaceId(skillId, raceId, self._imgIcon)

		self._txtLevel.text = ""

		if skillType ~= GameEnum.SkillRaceType.Hero and skillType ~= GameEnum.SkillRaceType.Combine and skillType ~= GameEnum.SkillRaceType.Summon and skillType ~= GameEnum.SkillRaceType.Domain and skillType ~= GameEnum.SkillRaceType.Contract and skillType ~= GameEnum.SkillRaceType.PsychicSkill and skillType ~= GameEnum.SkillRaceType.Element and skillType ~= GameEnum.SkillRaceType.JuanYouSkill and skillType ~= GameEnum.SkillRaceType.ShenYaoSkill and skillType ~= GameEnum.SkillRaceType.SourceTraceSkill and skillType ~= GameEnum.SkillRaceType.BookSpiritSkill then
			local level = skillLv

			if level == 0 then
				level = checknumber(skillId) % 10
			end

			self._txtLevel.text = " Lv." .. level
		end

		GameUtil.SetActive(self._txtDesc, true)
		GameUtil.SetActive(self._scrollView, false)
		settimer(0, self._checkDescHeight, self, false)

		if self._contentSizeImmediate then
			local size = self._contentSizeImmediate:GetPreferredSize()

			print("size w = " .. size.x .. " h = " .. size.y)
		end

		self._scrollView.verticalNormalizedPosition = 1

		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)

		if pos then
			local rect = self.mainGO.transform.rect

			GameUtil.AdjustWithSize(self.content, pos, sizeDelta[1], sizeDelta[2], rect.width, rect.height, false)
		end
	end
end

function SkillTipsView:_checkDescHeight()
	if self._scrollView and self._txtDesc then
		GameUtil.SetActive(self._txtDesc, GameUtil.getHeight(self._scrollView) > GameUtil.getHeight(self._txtDesc))
		GameUtil.SetActive(self._scrollView, GameUtil.getHeight(self._scrollView) < GameUtil.getHeight(self._txtDesc))
	end
end

function SkillTipsView:_getSourceSkillDesc(petMo)
	local effectDesc = ""
	local petCfg = CharacterConfig.instance:getPetCo(petMo.raceId)
	local sourceTraceId = petCfg.sourceTraceId
	local groupInfo = SourceTraceConfig.instance:getGroupInfoCfg(sourceTraceId)
	local activeEffectMap = {}

	for i, v in ipairs(petMo.sourceTraces) do
		activeEffectMap[v.effectId] = true
	end

	local mutiNodeIndex = 1
	local nodesCfgs = SourceTraceConfig.instance:getSourceTraceNodeCfgs(sourceTraceId)

	for i, v in ipairs(nodesCfgs) do
		if #v.effectIds > 1 then
			local singleEffectDesc = langPara("源核%s：未激活", GameUtil.toRomanNumber(mutiNodeIndex))

			for j, effectId in ipairs(v.effectIds) do
				if activeEffectMap[effectId] then
					local effectCfg = SourceTraceConfig.instance:getEffectCfg(effectId)

					singleEffectDesc = langPara("源核%s：%s", effectCfg.name, effectCfg.desc)

					break
				end
			end

			if not string.nilorempty(effectDesc) then
				effectDesc = effectDesc .. "\n"
			end

			effectDesc = string.format("%s%s", effectDesc, singleEffectDesc)
			mutiNodeIndex = mutiNodeIndex + 1
		end
	end

	return (string.format("%s\n%s", (groupInfo or nil) and groupInfo.skillBaseDesc, effectDesc))
end

return SkillTipsView
