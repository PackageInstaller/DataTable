-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsAnchorBreakComp.lua

module("logic.extensions.tooltips.component.ToolTipsAnchorBreakComp", package.seeall)

local M = class("ToolTipsAnchorBreakComp", ViewComponent)

function M:buildUI()
	self._goSkillRoot = self:getGo("skill_detail_tips_copy_-584147505")
	self._goName = goutil.findChild(self._goSkillRoot, "nameContent")
	self._goTypeNormal = goutil.findChild(self._goSkillRoot, "stateSkill")
	self._goTypeTalent = goutil.findChild(self._goSkillRoot, "stateHeartAnchors")
	self._goTypeEquip = goutil.findChild(self._goSkillRoot, "stateEquip")
	self._goTypeEcho = goutil.findChild(self._goSkillRoot, "stateEcho")
	self._goTypeThought = goutil.findChild(self._goSkillRoot, "stateThought")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvasGroup = goutil.findChild(self.mainGO, "skill_tips"):GetComponent(ComponentType.CanvasGroup)
	self._textName = self:getText("skill_detail_tips_copy_1418630815")
	self._textContent = goutil.findChildComponent(self:getGo("skill_detail_tips_copy_-1741863685"), "label_descript_item/txtContent", UIComponentType.TextMeshProUGUI)

	goutil.setActive(self._goName, true)
	goutil.setActive(self._goTypeNormal, false)
	goutil.setActive(self._goTypeTalent, false)
	goutil.setActive(self._goTypeEquip, false)
	goutil.setActive(self._goTypeEcho, false)
	goutil.setActive(self._goTypeThought, false)
end

function M:destroyUI()
	return
end

function M:onEnter()
	local info = self:getFirstParam()

	self._textName.text = info.title
	self._textContent.text = info.content

	if info.hasDispatch then
		GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, true, self._viewPresentor:getViewName())
	end

	self._guiAnimation:PlayAniByName("open1")

	self._canvasGroup.alpha = 0
end

function M:onExit()
	return
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, false, self._viewPresentor:getViewName())
end

return M
