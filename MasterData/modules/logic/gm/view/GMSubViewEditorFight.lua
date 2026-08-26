-- chunkname: @modules/logic/gm/view/GMSubViewEditorFight.lua

module("modules.logic.gm.view.GMSubViewEditorFight", package.seeall)

local GMSubViewEditorFight = class("GMSubViewEditorFight", GMSubViewBase)

function GMSubViewEditorFight:ctor()
	self.tabName = "技能编辑器"
end

function GMSubViewEditorFight:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewEditorFight:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewEditorFight:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 0

	self:addLineIndex()

	self.hideBuffLayerToggle = self.addToggle(self, self:getLineGroup(), "隐藏buff层数回合数", self.onHideBuffLayerToggleValueChange, self)
	self.hideBuffLayerToggle.isOn = not not GMController.instance.hideBuffLayer
	self.hideFloatToggle = self.addToggle(self, self:getLineGroup(), "隐藏飘字", self.onHideFloatToggleValueChange, self)
	self.hideFloatToggle.isOn = not not GMController.instance.hideFloat
end

function GMSubViewEditorFight:onHideBuffLayerToggleValueChange()
	GMController.instance.hideBuffLayer = self.hideBuffLayerToggle.isOn

	FightController.instance:dispatchEvent(FightEvent.SkillHideBuffLayer)
end

function GMSubViewEditorFight:onHideFloatToggleValueChange()
	GMController.instance.hideFloat = self.hideFloatToggle.isOn
end

return GMSubViewEditorFight
