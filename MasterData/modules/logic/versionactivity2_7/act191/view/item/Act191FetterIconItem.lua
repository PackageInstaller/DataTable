-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191FetterIconItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191FetterIconItem", package.seeall)

local Act191FetterIconItem = class("Act191FetterIconItem", LuaCompBase)

function Act191FetterIconItem:init(go)
	self.go = go
	self.imageFetter = gohelper.findChildImage(go, "image_Fetter")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
end

function Act191FetterIconItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function Act191FetterIconItem:setData(tag)
	self.relationCo = Activity191Config.instance:getRelationCo(tag)

	Activity191Helper.setFetterIcon(self.imageFetter, self.relationCo.icon)
end

function Act191FetterIconItem:onClick()
	if self.param then
		Act191StatController.instance:statButtonClick(self.param.fromView, string.format("Fetter_%s", self.relationCo.name))
	end

	local param = {
		tag = self.relationCo.tag,
		isEnemy = self.isEnemy,
		isPreview = self.preview
	}

	Activity191Controller.instance:openFetterTipView(param)
end

function Act191FetterIconItem:setEnemyView()
	self.isEnemy = true
end

function Act191FetterIconItem:setPreview()
	self.preview = true
end

function Act191FetterIconItem:setExtraParam(param)
	self.param = param
end

return Act191FetterIconItem
