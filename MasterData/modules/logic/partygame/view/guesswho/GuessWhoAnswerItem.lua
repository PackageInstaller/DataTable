-- chunkname: @modules/logic/partygame/view/guesswho/GuessWhoAnswerItem.lua

module("modules.logic.partygame.view.guesswho.GuessWhoAnswerItem", package.seeall)

local GuessWhoAnswerItem = class("GuessWhoAnswerItem", LuaCompBase)

function GuessWhoAnswerItem:init(go)
	self.go = go
	self.simageAnswer = gohelper.findChildSingleImage(go, "simage_Answer")
	self.goSelect = gohelper.findChild(go, "go_Select")
	self.goCorrect = gohelper.findChild(go, "go_Correct")
	self.goError = gohelper.findChild(go, "go_Error")
	self.goHeadRoot = gohelper.findChild(go, "go_HeadRoot")

	local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

	self.addClickCb(self, btnClick, self.onClick, self)

	self.headItemMap = {}

	gohelper.setActive(self.simageAnswer, false)
end

function GuessWhoAnswerItem:setCallback(callback, callbackObj, param)
	self.callback = callback
	self.callbackObj = callbackObj
	self.clickParam = param
end

function GuessWhoAnswerItem:onClick()
	if self.callback then
		self.callback(self.callbackObj, self.clickParam)
	end
end

function GuessWhoAnswerItem:addHeadItem(go)
	gohelper.setParent(go, self.goHeadRoot)
	gohelper.setActive(go, true)
end

function GuessWhoAnswerItem:setIcon(icon)
	self.simageAnswer:LoadImage(ResUrl.getPropItemIcon(icon))
	gohelper.setActive(self.simageAnswer, true)
end

function GuessWhoAnswerItem:setSelect(isSelect)
	gohelper.setActive(self.goSelect, isSelect)
end

function GuessWhoAnswerItem:setCorrect(isActive)
	gohelper.setActive(self.goCorrect, isActive)
end

function GuessWhoAnswerItem:setError(isActive)
	gohelper.setActive(self.goError, isActive)
end

return GuessWhoAnswerItem
