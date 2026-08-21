-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualMainItem.lua

module("logic.extensions.controlaction.view.manual.ManualMainItem", package.seeall)

local M = class("ManualMainItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._imgIcon = goutil.findChildImageComponent(self._mainGo, "normal/icon")
	self._txtName = goutil.findChildTextComponent(self._mainGo, "txtNumber")
	self._lockGo = goutil.findChild(self._mainGo, "lock")
	self._btnClick = Astral.ButtonAdapter.Get(self._mainGo)

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
	IconLoader.clearSprite(self._imgIcon)
end

function M:_onClick()
	printWarn("=====_onClick=======")

	if not self._mo.data then
		FloatWordMgr.instance:show(lang("tip_controlaction_manual_notopen"))

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MANUAL_ITEMCLICK, self._mo)
end

function M:refresh(mo)
	self._mo = mo
	self._manualCo = mo.co
	self._txtName.text = self._manualCo.name

	goutil.setActive(self._lockGo, mo.data == false)

	if mo.data then
		IconLoader.setSprite(self._imgIcon, IconType.ControlActionManual, self._manualCo.icon)
	end
end

function M:clickItem(id)
	if self._mo.data and self._mo.data:getId() == id then
		self:_onClick()
	end
end

return M
