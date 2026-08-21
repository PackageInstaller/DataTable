-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/cell/Character3DSkillCell.lua

module("logic.extensions.charactersystem.view.cell.Character3DSkillCell", package.seeall)

local M = class("Character3DSkillCell")
local LockColor = "#858585"
local UnloclColor = "#FFFFFF"
local AttrType = {
	Shoot = 3,
	Range = 4,
	CD = 2,
	AtkTyp = 1
}

function M:ctor(container)
	self._go = container.gameObject
	self._registry = ViewElementsRegistry.New(container)
	self._enhanceCodes = nil
	self._authorityLockGos = {}
	self._authorityUnlockGos = {}
end

function M:Awake()
	self:_buildUI()
end

function M:OnEnable()
	self:_bindEvents()
end

function M:OnDisable()
	self:_unbindEvents()
end

function M:onDestroy()
	self:_unbindEvents()
end

function M:_buildUI()
	local reg = self._registry

	self._textSkillName = goutil.findChildTextComponent(self._go, "top/txtName")
	self._textSkillDesc = goutil.findChildComponent(self._go, "middle/txtContent", UIComponentType.TextMeshProUGUI)
	self._textSkillSanityDesc = goutil.findChildComponent(self._go, "down/txtContent", UIComponentType.TextMeshProUGUI)
	self._imgSign = goutil.findChildImageComponent(self._go, "top/skill_item_1/passivitySign")
	self._imgIcon = goutil.findChildImageComponent(self._go, "top/skill_item_1/imgIcon")
	self._goTips = goutil.findChild(self._go, "tipsGo") or self._go
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "click"))
	self._goLock = reg:getGo("role_model_preview_skill_-763504168")
	self._goUnlock = reg:getGo("role_model_preview_skill_-1718721775")

	table.insert(self._authorityLockGos, self._goLock)
	table.insert(self._authorityUnlockGos, self._goUnlock)

	self._infoGroup = {
		[AttrType.AtkTyp] = {
			txt = goutil.findChildTextComponent(self._go, "top/stateSkill/skillEffect_1/txtKind"),
			goNone = goutil.findChild(self._go, "top/stateSkill/skillEffect_1/txtKindNone")
		},
		[AttrType.CD] = {
			txt = goutil.findChildTextComponent(self._go, "top/stateSkill/skillEffect_2/txtRound"),
			goNone = goutil.findChild(self._go, "top/stateSkill/skillEffect_2/txtRoundNone")
		},
		[AttrType.Shoot] = {
			txt = goutil.findChildTextComponent(self._go, "top/stateSkill/skillEffect_3/txtShoot"),
			goNone = goutil.findChild(self._go, "top/stateSkill/skillEffect_3/txtShootNone")
		},
		[AttrType.Range] = {
			txt = goutil.findChildTextComponent(self._go, "top/stateSkill/skillEffect_4/txtRange"),
			goNone = goutil.findChild(self._go, "top/stateSkill/skillEffect_4/txtRangeNone")
		}
	}
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_onClick()
	if not self._skillCOWrapper then
		return
	end

	local skillCO = self._skillCOWrapper:getSkillCO()
	local skillEnhanceMO = SkillEnhanceMO.New(skillCO.code)
	local skillDesc = ""

	if skillEnhanceMO then
		skillDesc = skillEnhanceMO:getOriginDesc()
	end

	local sanityDesc = skillCO.godlikeConfig.desc
	local skillWordData = WordUtil.parse(skillDesc) or WordData.New()
	local sanityWordData = WordUtil.parse(sanityDesc) or WordData.New()
	local wordData = WordData.New()

	for _, word in ipairs(skillWordData:getWords()) do
		wordData:addWord(word)
	end

	for _, word in ipairs(sanityWordData:getWords()) do
		wordData:addWord(word)
	end

	if wordData:hasWords() then
		local info = {}

		info.wordData = wordData
		info.bindGo = self._goTips

		ViewMgr.instance:open(ViewName.WordView, info)
	end
end

function M:_refreshUI()
	local hasSkillCo = self._skillCOWrapper ~= nil

	self:setActive(hasSkillCo)

	if not hasSkillCo then
		return
	end

	local skillStatus = BattleEnum.SkillStatus.Normal
	local skillCO = self._skillCOWrapper:getSkillCO()
	local skillId = skillCO.code
	local skillSignInfo = ActiveSkillCOUtil.getSkillSignInfo(skillId, skillStatus)
	local isActiveSkill = ActiveSkillCOUtil.isActiveSkill(self._skillCOWrapper, skillStatus)
	local skillEnhanceMO = SkillEnhanceMO.getSharedMO(skillId)

	self._textSkillName.text = self._skillCOWrapper:getName()
	self._textSkillDesc.text = self._skillCOWrapper:getDescription()
	self._textSkillSanityDesc.text = skillEnhanceMO:getStrengthenDescription()

	self._imgSign:SetSprite(skillSignInfo.spriteName)
	goutil.setActive(self._imgSign.gameObject, skillSignInfo.isSign)
	IconLoader.setSprite(self._imgIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))
	self:_refreshAuthority()

	self._infoGroup[AttrType.AtkTyp].txt.text = ActiveSkillCOUtil.getCategoryLabel(self._skillCOWrapper, skillStatus)

	local cd = skillCO.cd

	self._infoGroup[AttrType.CD].txt.text = langF("tip_skill_round_num", cd)

	goutil.setActive(self._infoGroup[AttrType.CD].txt.gameObject, cd > 0)
	goutil.setActive(self._infoGroup[AttrType.CD].goNone, cd <= 0)

	self._infoGroup[AttrType.Shoot].txt.text = skillEnhanceMO:getReleaseDistanceLabel(skillStatus)

	goutil.setActive(self._infoGroup[AttrType.Shoot].txt.gameObject, isActiveSkill)
	goutil.setActive(self._infoGroup[AttrType.Shoot].goNone, not isActiveSkill)

	self._infoGroup[AttrType.Range].txt.text = ActiveSkillCOUtil.getRangeLabel(self._skillCOWrapper, isActiveSkill, skillStatus)

	goutil.setActive(self._infoGroup[AttrType.Range].txt.gameObject, isActiveSkill)
	goutil.setActive(self._infoGroup[AttrType.Range].goNone, not isActiveSkill)
	SkillEnhanceMO.releaseSharedMO(skillEnhanceMO)
end

function M:_refreshAuthority()
	for _, go in ipairs(self._authorityLockGos) do
		goutil.setActive(go, false)
	end

	for _, go in ipairs(self._authorityUnlockGos) do
		goutil.setActive(go, false)
	end

	for i, node in ipairs(self._nodes or {}) do
		local unlock = self._allUnlock or CharacterAuthorityUtil.isNodeUnlock(self._heroData, node.co.code)
		local goList = unlock and self._authorityUnlockGos or self._authorityLockGos
		local go = goList[i]

		if go == nil then
			go = goutil.cloneAndSetParent(unlock and self._goUnlock or self._goLock, self._go.transform)

			table.insert(goList, go)
		end

		local skillId = node.skill_enhance
		local skillCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(skillId)
		local desc = skillCOWrapper:getDescription()
		local textAuthorTitle = goutil.findChildTextComponent(go, "txtName")
		local textAuthorDesc = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI)

		textAuthorTitle.text = langF("authority_enhance_skill", node.co.simpleName)
		textAuthorDesc.text = unlock and desc or string.gsub(desc, UnloclColor, LockColor)

		goutil.setActive(go, true)
	end
end

function M:setActive(active)
	goutil.setActive(self._go, active)
end

function M:setAuthorityEnhanceSkill(heroData, nodes, allUnlock)
	self._heroData = heroData
	self._nodes = nodes
	self._allUnlock = allUnlock
end

function M:setEnhanceCodes(enhanceCodes)
	self._enhanceCodes = enhanceCodes
end

function M:addEnhanceCodes(enhanceCodes)
	self._enhanceCodes = self._enhanceCodes or {}

	table.insertto(self._enhanceCodes, enhanceCodes)
end

function M:setData(skillCOWrapper, heroId)
	self._skillCOWrapper = skillCOWrapper or nil
	self._heroId = heroId

	self:_refreshUI()
end

return M
