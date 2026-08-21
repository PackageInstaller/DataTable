-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/CharacterRetrieveAuthorityCell.lua

module("logic.extensions.retrieve.view.CharacterRetrieveAuthorityCell", package.seeall)

local M = class("CharacterRetrieveAuthorityCell")
local LockAlpha = 0.2
local LockColor = "#858585"
local UnloclColor = "#FFFFFF"

function M:ctor(container)
	self._go = container.gameObject
	self._heroId = nil
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
	self._textName = goutil.findChildTextComponent(self._go, "top/txtName")
	self._textContent = goutil.findChildComponent(self._go, "txtContent", UIComponentType.TextMeshProUGUI)
	self._imgIcon = goutil.findChildImageComponent(self._go, "top/skill_item_1/imgIcon")
	self._goLine = goutil.findChild(self._go, "imgLine")
	self._goTips = goutil.findChild(self._go, "tipsGo") or self._go
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "click"))
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_onClick()
	if self._skillEnhanceMO then
		ToolTipsMgr.showSkillBuffTagSideTips(self._skillEnhanceMO, self._goTips, true)
	end
end

function M:_refreshView()
	if self._skillCOWrapper then
		self._textName.text = self._skillCOWrapper:getName()

		local desc = self._skillCOWrapper:getDescription()

		self._textContent.text = self._unlock and desc or string.gsub(desc, UnloclColor, LockColor)
		self._textName.color = parsecolor(self._unlock and UnloclColor or LockColor)
		self._textContent.color = parsecolor(self._unlock and UnloclColor or LockColor)

		local skillCO = self._skillCOWrapper:getSkillCO()

		IconLoader.setSprite(self._imgIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))
	end

	self:setActive(self._skillCOWrapper ~= nil)
end

function M:setActive(active)
	goutil.setActive(self._go, active)
end

function M:setLineActive(active)
	goutil.setActive(self._goLine, active)
end

function M:setData(skillNodeCo, heroId, unlock)
	self._heroId = heroId
	self._unlock = unlock

	local skillEnhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._heroId, skillNodeCo and skillNodeCo.skillId or 0)
	local skillCOWrapper = skillEnhanceMO and skillEnhanceMO:getSkillCOWrapper() or nil

	self._skillCOWrapper = skillCOWrapper
	self._skillEnhanceMO = skillEnhanceMO

	self:_refreshView()
end

return M
