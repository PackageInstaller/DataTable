-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageThreeExView.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageThreeExView", package.seeall)

local DivineMiMengLiClgStageThreeExView = class("DivineMiMengLiClgStageThreeExView", ViewComponent)

function DivineMiMengLiClgStageThreeExView:ctor()
	DivineMiMengLiClgStageThreeExView.super.ctor(self)
end

function DivineMiMengLiClgStageThreeExView:unbindEvents()
	DivineMiMengLiClgStageThreeExView.super.unbindEvents(self)
end

function DivineMiMengLiClgStageThreeExView:bindEvents()
	DivineMiMengLiClgStageThreeExView.super.bindEvents(self)
end

function DivineMiMengLiClgStageThreeExView:buildUI()
	DivineMiMengLiClgStageThreeExView.super.buildUI(self)

	self._txtRule = self:getTxt("rule/txt")
	self._imgYes = self:getGo("rule/txt/imgYes")
	self._imgNo = self:getGo("rule/txt/imgNo")
end

function DivineMiMengLiClgStageThreeExView:onExit()
	DivineMiMengLiClgStageThreeExView.super.onExit(self)
end

function DivineMiMengLiClgStageThreeExView:onEnter()
	DivineMiMengLiClgStageThreeExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.DivineMiMengLiClgStageThreeSupportPetCheck, self._onUpdate, self)
end

function DivineMiMengLiClgStageThreeExView:_onUpdate()
	local petMo = self.customFmtMo:getSupportPetMo()
	local name = petMo:getName()

	self._txtRule.text = string.format("必须上阵挑战援助%s", name)

	local isSupportPetMoHasFmt = self.customFmtMo:isSupportPetMoHasFmt()

	GameUtil.SetActive(self._imgYes, isSupportPetMoHasFmt)
	GameUtil.SetActive(self._imgNo, not isSupportPetMoHasFmt)
end

return DivineMiMengLiClgStageThreeExView
