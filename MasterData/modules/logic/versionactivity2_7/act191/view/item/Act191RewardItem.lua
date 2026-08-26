-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191RewardItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191RewardItem", package.seeall)

local Act191RewardItem = class("Act191RewardItem", LuaCompBase)

function Act191RewardItem:init(go)
	self.go = go
	self.bg = gohelper.findChildImage(go, "bg")
	self.rare = gohelper.findChildImage(go, "rare")
	self.icon = gohelper.findChildImage(go, "icon")
	self.num = gohelper.findChildText(go, "num")
	self.click = gohelper.findChildButtonWithAudio(go, "clickArea")
	self.effAutoFight = gohelper.findChild(go, "eff_AutoFight")
end

function Act191RewardItem:addEventListeners()
	self.addClickCb(self, self.click, self.onClick, self)
end

function Act191RewardItem:setData(id, count)
	self.config = lua_activity191_item.configDict[id]
	self.num.text = count

	if self.config then
		UISpriteSetMgr.instance:setAct174Sprite(self.icon, self.config.icon)

		if self.config.rare ~= 0 then
			UISpriteSetMgr.instance:setAct174Sprite(self.rare, "act174_roleframe_" .. self.config.rare)
		end

		gohelper.setActive(self.rare, self.config.rare ~= 0)
	end
end

function Act191RewardItem:onClick()
	if self.param then
		Act191StatController.instance:statButtonClick(self.param.fromView, string.format("clickArea_%s_%s", self.param.index, self.config.name))
	end

	if self.config then
		Activity191Controller.instance:openItemView(self.config)
	end
end

function Act191RewardItem:setClickEnable(bool)
	gohelper.setActive(self.click, bool)
end

function Act191RewardItem:setExtraParam(param)
	self.param = param
end

function Act191RewardItem:showAutoEff(bool)
	gohelper.setActive(self.effAutoFight, bool)
end

return Act191RewardItem
