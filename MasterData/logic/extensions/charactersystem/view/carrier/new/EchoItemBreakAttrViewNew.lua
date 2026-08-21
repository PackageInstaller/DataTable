-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemBreakAttrViewNew.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemBreakAttrViewNew", package.seeall)

local M = class("EchoItemBreakAttrViewNew")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._index = nil
	self._data = nil
end

function M:Awake()
	self:_buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:_destroyUI()
end

function M:_buildUI()
	self._canvasGroup = goutil.addComponentOnce(self._mainGo, ComponentType.CanvasGroup)
	self._txtAttr1 = goutil.findChildComponent(self._mainGo, "txtBreakAttribute_1", UIComponentType.TextMeshProUGUI)
	self._btnAttr1 = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "txtBreakAttribute_1/click").gameObject)

	local breakPointGo = goutil.findChild(self._mainGo, "break_point")

	self._breakPointView = Astral.LuaComponentContainer.Add(breakPointGo, EchoItemBreakPointView)
end

function M:_destroyUI()
	self._txtAttr1 = nil
end

function M:bindEvents()
	self._btnAttr1:AddClickListener(self._onClickAttr, self)
end

function M:unbindEvents()
	self._btnAttr1:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setData(data, echoMaxLv)
	self._data = data

	local showUnlockDynamic = false

	if data.itemData and data.showLevel then
		local unlockLevel = EchoItemConfig.instance:getUnlockDynamicEffectLevel(data.itemData:getQuality())

		showUnlockDynamic = unlockLevel == data.showLevel
	end

	if data.descSplit then
		self._txtAttr1.text = showUnlockDynamic and langF("tip_echo_unlock_dynamic", data.desc[1]) or data.desc[1]
	else
		self._txtAttr1.text = showUnlockDynamic and langF("tip_echo_unlock_dynamic", data.desc) or data.desc
	end

	local isBreak = data.level >= self._index

	self._breakPointView:setEchoItemLevel(self._index, echoMaxLv)
	self._breakPointView:setCanvasGroupAlpha(isBreak and 1 or 0.6)

	local _color = Astral.ColorUtil.ParseColor("#FFFFFF")

	self._txtAttr1.color = _color
	self._canvasGroup.alpha = isBreak and 1 or 0.1
end

function M:setIndex(index)
	self._index = index
end

function M:_onClickAttr()
	local skillEnhanceMo = EchoItemConfig.instance:getAttrSkillEnhanceMO(self._data.echoItemId, self._index)

	if skillEnhanceMo then
		local bindGo = self._btnAttr1.gameObject
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMo, bindGo, isPassEvent)
	end
end

return M
