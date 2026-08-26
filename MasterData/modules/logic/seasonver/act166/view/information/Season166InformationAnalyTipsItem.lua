-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationAnalyTipsItem.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyTipsItem", package.seeall)

local Season166InformationAnalyTipsItem = class("Season166InformationAnalyTipsItem", Season166InformationAnalyDetailItemBase)

function Season166InformationAnalyTipsItem:onInit()
	self.goCanReveal = gohelper.findChild(self.go, "#go_CanReveal")
	self.goNoReveal = gohelper.findChild(self.go, "#go_NoReveal")
	self.goLine = gohelper.findChild(self.go, "image_Line")
end

function Season166InformationAnalyTipsItem:onUpdate()
	local stage = self.data.config.stage
	local curStage = self.data.info.stage
	local isNext = stage == curStage + 1

	gohelper.setActive(self.goCanReveal, isNext)
	gohelper.setActive(self.goNoReveal, not isNext)
end

return Season166InformationAnalyTipsItem
