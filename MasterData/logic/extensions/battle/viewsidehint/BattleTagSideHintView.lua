-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleTagSideHintView.lua

module("logic.extensions.battle.viewsidehint.BattleTagSideHintView", package.seeall)

local M = class("BattleTagSideHintView", ViewComponent)
local kLocalSettingKey = "BattleTagSideHintView"
local kXnIndex = 4

function M:buildUI()
	self._tagItemList = {
		BattleTagSideHintItem.New(goutil.findChild(self.mainGO, "x1_hint")),
		BattleTagSideHintItem.New(goutil.findChild(self.mainGO, "x2_hint")),
		BattleTagSideHintItem.New(goutil.findChild(self.mainGO, "xn_hint")),
		(BattleTagSideHintItem.New(goutil.findChild(self.mainGO, "xn+1_hint")))
	}
	self._tagItemAnimNameList = {
		"x1",
		"x2",
		"x3",
		"xn"
	}
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))

	self._guiAnimation:AddListener(self._onAnimationEvent, self)

	self._isExecuting = false
	self._continuousIndex = false

	self:_hideAllItem()
end

function M:destroyUI()
	self._canvasGroup = false
	self._guiAnimation = false

	self:_destroyItems()
end

function M:onEnter()
	BattleSideHintViewFacade.instance:registerTagView(self)
end

function M:onExit()
	BattleSideHintViewFacade.instance:unregisterTagView()

	self._isExecuting = false
end

function M:showHint(tagId, continuousIndex)
	if not self._isExecuting then
		self._isExecuting = true
		self._continuousIndex = false

		self:_onTagEffectBegin()
	end

	self:_showTagEffect(tagId, continuousIndex)
end

function M:hideTagHint()
	self._isExecuting = false
	self._continuousIndex = false

	self:_onTagEffectFinish()
	self:_hideAllItem()
end

function M:_onTagEffectBegin()
	self._canvasGroup:DOKill(false)

	self._canvasGroup.alpha = 1

	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Main, false, kLocalSettingKey)
end

function M:_onTagEffectFinish()
	self._canvasGroup:DOFade(0, 0.2)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Main, true, kLocalSettingKey)
end

function M:_onAnimationEvent(tagName, reason)
	if tagName == "xn" then
		local item = self._tagItemList[kXnIndex - 1]

		item:setContinuousIndex(self._continuousIndex)
	end
end

function M:_showTagEffect(tagId, continuousIndex)
	for index, item in pairs(self._tagItemList) do
		item:setVisible(false)
	end

	self._continuousIndex = continuousIndex

	if continuousIndex < kXnIndex then
		local index = Mathf.Clamp(continuousIndex, 1, 3)

		self:_setupTagItem(index, tagId, continuousIndex)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(self._tagItemAnimNameList[index])
	else
		self:_setupTagItem(kXnIndex, tagId, continuousIndex)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(self._tagItemAnimNameList[kXnIndex])
	end
end

function M:_setupTagItem(itemIndex, tagId, continuousIndex)
	local preItem = self._tagItemList[itemIndex - 1]

	if preItem then
		preItem:setTagIdAndCount(tagId, continuousIndex - 1)
	end

	local item = self._tagItemList[itemIndex]

	item:setVisible(true)
	item:setTagIdAndCount(tagId, continuousIndex)
end

function M:_hideAllItem()
	for _, item in pairs(self._tagItemList) do
		item:setVisible(false)
	end
end

function M:_destroyItems()
	for _, item in pairs(self._tagItemList) do
		item:destroy()
	end

	self._tagItemList = nil
end

return M
