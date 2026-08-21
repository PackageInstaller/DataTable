-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingSkillItemView.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingSkillItemView", package.seeall)

local M = class("ThinkingSkillItemView")

function M:ctor(compContainer)
	self._mainGo = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)
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
	self._canvasGroup = goutil.addComponentOnce(self._mainGo, ComponentType.CanvasGroup)
	self._thoughtSkillIcon = self._registry:getImage("thought_skill_item_-713472976")
	self._selectGo = self._registry:getGo("thought_skill_item_-2004923903")
	self._lockGo = self._registry:getGo("thought_skill_item_-733926651")
	self._animationLock = self._registry:getUIComponent("thought_skill_item_-733926651", ComponentType.Animation)
	self._goAtPresent = self._registry:getGo("thought_skill_item_-227169389")
	self._levelGo = self._registry:getGo("thought_skill_item_-178901478")
	self._txtLevel = self._registry:getText("thought_skill_item_1723031627")

	goutil.setActive(self._txtLevel.gameObject, true)

	self._txtName = self._registry:getText("thought_skill_item_1284247924")
	self._btnClick = self._registry:getBtn("thought_skill_item_-49632651")
end

function M:destroyUI()
	self:setClickCallback(nil, nil)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:getSkillId()
	return self._skillId
end

function M:getMainGo()
	return self._mainGo
end

function M:refreshView(skillId, level, isLock, lockStateChange, isMaxLevel)
	if lockStateChange and not isLock then
		self:playUnLockAnim()
	else
		self._animationLock:Stop()
		self:setLock(isLock)
	end

	local levelStr = ""

	if isLock then
		levelStr = lang("tip_thinking_skill_lock")
	else
		levelStr = isMaxLevel and string.format("Lv.%s max", level) or string.format("Lv.%s", level)
	end

	self._level = level
	self._txtLevel.text = levelStr

	if self._skillId and self._skillId == skillId then
		return
	end

	self._skillId = skillId

	local skillName = ""
	local skillIcon = ""
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if skillCOWrapper then
		local skillCO = skillCOWrapper:getSkillCO()

		skillIcon = ActiveSkillCOUtil.getSkillIcon(skillCO)
		skillName = skillCO.name
	end

	self._txtName.text = skillName

	if not string.nilorempty(skillIcon) then
		IconLoader.setSprite(self._thoughtSkillIcon, IconType.SkillIcon, skillIcon)
	end
end

function M:_onClick()
	if self._clickCallbackFunc then
		local skillId = self:getSkillId()

		if self._clickCallbackHandler then
			self._clickCallbackFunc(self._clickCallbackHandler, skillId)
		else
			self._clickCallbackFunc(skillId)
		end
	end
end

function M:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function M:setSelected(isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

function M:setClickCallback(clickCallbackFunc, clickCallBackHandler)
	self._clickCallbackFunc = clickCallbackFunc
	self._clickCallbackHandler = clickCallBackHandler
end

function M:setLock(visible)
	goutil.setActive(self._lockGo, visible)
end

function M:playUnLockAnim()
	self._animationLock:Stop()
	self._animationLock:Play("thought_skill_item_lock_open")
end

function M:setSkillIconVisible(visible)
	self._thoughtSkillIcon.gameObject:SetActive(visible)
end

function M:setAtPresentVisible(visible)
	goutil.setActive(self._goAtPresent, visible)
end

function M:setLevelRootVisible(visible)
	goutil.setActive(self._levelGo, visible)
end

return M
