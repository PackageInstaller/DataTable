-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathFmtExView.lua

module("logic.extensions.elfkingpath.view.ElfKingPathFmtExView", package.seeall)

local ElfKingPathFmtExView = class("ElfKingPathFmtExView", ViewComponent)

function ElfKingPathFmtExView:ctor()
	ElfKingPathFmtExView.super.ctor(self)
end

function ElfKingPathFmtExView:unbindEvents()
	ElfKingPathFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnrule)
end

function ElfKingPathFmtExView:bindEvents()
	ElfKingPathFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnrule, self._onClickRule, self)
end

function ElfKingPathFmtExView:buildUI()
	ElfKingPathFmtExView.super.buildUI(self)

	self._btnrule = self:getGo("btnrule")
end

function ElfKingPathFmtExView:onExit()
	ElfKingPathFmtExView.super.onExit(self)
	GuideController.instance:setViewVar("elf_king_path", nil)
	ElfKingPathController.instance:processGuideData(self.guideId, false)
end

function ElfKingPathFmtExView:onEnter()
	ElfKingPathFmtExView.super.onEnter(self)
	GuideController.instance:setViewVar("elf_king_path", nil)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self.stageId = self.customFmtMo.stageId
	self.sonStageId = self.customFmtMo.sonStageId
	self.sonStageCfg = ElfKingPathConfig.instance:getSonStageCfg(self.stageId, self.sonStageId)
	self.picRuleKey = self.sonStageCfg.picRuleKey or ""
	self.guideId = self.sonStageCfg.guideId or 0

	ElfKingPathController.instance:processGuideData(self.guideId, true)

	if not GameUtil.isEmptyString(self.picRuleKey) then
		goutil.setActive(self._btnrule, true)

		local key = "elf_king_path_rule_" .. self.stageId .. "_" .. self.sonStageId

		local function firstTimeCallback()
			TipsFacade.instance:openImageRuleViewByKey(self.picRuleKey, "游戏规则", function()
				self:startGuide()
			end)
		end

		local function nextTimeCallback()
			self:startGuide()
		end

		GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nextTimeCallback)
	else
		goutil.setActive(self._btnrule, false)
		self:startGuide()
	end
end

function ElfKingPathFmtExView:startGuide()
	if self.guideId and self.guideId > 0 then
		GuideController.instance:setViewVar("elf_king_path", self.guideId)
	end
end

function ElfKingPathFmtExView:_onClickRule()
	local key = self.picRuleKey

	TipsFacade.instance:openImageRuleViewByKey(key, "游戏规则")
end

return ElfKingPathFmtExView
