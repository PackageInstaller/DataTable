-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191FetterItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191FetterItem", package.seeall)

local Act191FetterItem = class("Act191FetterItem", LuaCompBase)

function Act191FetterItem:init(go)
	self.go = go
	self.imageRare = gohelper.findChildImage(go, "bg")
	self.goEffect2 = gohelper.findChild(go, "effect2")
	self.goEffect3 = gohelper.findChild(go, "effect3")
	self.goEffect4 = gohelper.findChild(go, "effect4")
	self.goEffect5 = gohelper.findChild(go, "effect5")
	self.imageIcon = gohelper.findChildImage(go, "icon")
	self.txtCnt = gohelper.findChildText(go, "count")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "clickArea")
	self.goGreenDeer = gohelper.findChild(go, "go_GreenDeer")
end

function Act191FetterItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function Act191FetterItem:setData(config, count)
	self.config = config

	local maxCo = Activity191Config.instance:getRelationMaxCo(self.config.tag)

	self.txtCnt.text = string.format("%d/%d", count, maxCo.activeNum)

	UISpriteSetMgr.instance:setAct174Sprite(self.imageRare, "act174_shop_tag_" .. self.config.tagBg)

	for i = 2, 5 do
		gohelper.setActive(self["goEffect" .. i], i == self.config.tagBg)
	end

	ZProj.UGUIHelper.SetGrayscale(self.imageIcon.gameObject, config.level == 0)

	local color = self.imageIcon.color

	color.a = config.level == 0 and 0.5 or 1
	self.imageIcon.color = color

	Activity191Helper.setFetterIcon(self.imageIcon, self.config.icon)
	gohelper.setActive(self.goGreenDeer, self.config.tag == Activity191Enum.GreenDeer)
end

function Act191FetterItem:onClick()
	if self.param then
		Act191StatController.instance:statButtonClick(self.param.fromView, string.format("clickArea_%s_%s", self.param.index, self.config.name))
	end

	local param = {
		tag = self.config.tag,
		isEnemy = self.isEnemy
	}

	Activity191Controller.instance:openFetterTipView(param)
end

function Act191FetterItem:setEnemyView()
	self.isEnemy = true
end

function Act191FetterItem:setClickEnable(bool)
	gohelper.setActive(self.btnClick, bool)
end

function Act191FetterItem:setExtraParam(param)
	self.param = param
end

return Act191FetterItem
