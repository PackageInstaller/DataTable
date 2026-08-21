-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingMainView.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingMainView", package.seeall)

local M = class("ThinkingMainView", ViewComponent)

function M:buildUI()
	self._thinkingItemViews = {}

	local rectThinkingRoot = self:getUIComponent("thought_main_view_1655839434", UIComponentType.RectTransform)

	for i = 0, rectThinkingRoot.childCount - 1 do
		local go = rectThinkingRoot:GetChild(i).gameObject
		local cell = Astral.SimpleLuaComponentContainer.Add(go, ThinkingItemView)

		table.insert(self._thinkingItemViews, cell)
	end
end

function M:destroyUI()
	self._thinkingItemViews = nil
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.THINKING_REFRESH, self._refreshView, self)

	for _, cell in pairs(self._thinkingItemViews) do
		cell:setClickCallback(self._onThinkingItemCellClick, self)
	end
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.THINKING_REFRESH, self._refreshView, self)

	for _, cell in pairs(self._thinkingItemViews) do
		cell:setClickCallback(nil, nil)
	end
end

function M:onEnter()
	self:setEvent(true)
	self:_refreshView()
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onThinkingItemCellClick(thinkingId)
	thinkingId = thinkingId or 0

	local online = ThinkingConfig.instance:getThinkingOnline(thinkingId)

	if not online then
		ToolTipsMgr.showCharacterTopToast(lang("tip_thought_or_skill_not_online"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	ViewMgr.instance:open(ViewName.ThinkingInfoView, {
		isFromTotalPreview = true,
		thinkingId = thinkingId
	})
end

function M:_refreshView()
	local thinkingMoLst = ThinkingModel.instance:getData()

	for index, cell in ipairs(self._thinkingItemViews) do
		local mo = thinkingMoLst[index]
		local thinkingId = mo and mo:getId() or nil
		local online = mo and mo:getIsOnline() or false

		cell:refreshView(thinkingId)
		cell:setLockVisible(not online)
		cell:setObjInfoVisible(true)
		cell:setIsUsing(false)
	end
end

return M
