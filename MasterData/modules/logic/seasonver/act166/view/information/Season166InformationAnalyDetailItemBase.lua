-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationAnalyDetailItemBase.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyDetailItemBase", package.seeall)

local Season166InformationAnalyDetailItemBase = class("Season166InformationAnalyDetailItemBase", LuaCompBase)

function Season166InformationAnalyDetailItemBase:ctor(itemType)
	self.itemType = itemType
end

function Season166InformationAnalyDetailItemBase:init(go)
	self:__onInit()

	self.go = go

	self:onInit()
end

function Season166InformationAnalyDetailItemBase:onInit()
	return
end

function Season166InformationAnalyDetailItemBase:setData(data)
	self.data = data

	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)
	gohelper.setAsLastSibling(self.go)
	gohelper.setActive(self.goLine, not data.isEnd)
	self:onUpdate()
end

function Season166InformationAnalyDetailItemBase:onUpdate()
	return
end

function Season166InformationAnalyDetailItemBase:playTxtFadeInByStage(stage)
	if not self.data then
		return
	end

	local config = self.data.config

	if config and config.stage == stage then
		self:playFadeIn()
	end
end

function Season166InformationAnalyDetailItemBase:playFadeIn()
	return
end

function Season166InformationAnalyDetailItemBase:getPosY()
	return recthelper.getAnchorY(self.go.transform)
end

function Season166InformationAnalyDetailItemBase:onRecycle()
	gohelper.setActive(self.go, false)
end

function Season166InformationAnalyDetailItemBase:onDestroy()
	self:__onDispose()
end

return Season166InformationAnalyDetailItemBase
