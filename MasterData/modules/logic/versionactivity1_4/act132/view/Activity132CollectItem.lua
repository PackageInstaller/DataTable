-- chunkname: @modules/logic/versionactivity1_4/act132/view/Activity132CollectItem.lua

module("modules.logic.versionactivity1_4.act132.view.Activity132CollectItem", package.seeall)

local Activity132CollectItem = class("Activity132CollectItem", UserDataDispose)

function Activity132CollectItem:ctor(go)
	self:__onInit()

	self._viewGO = go
	self._goSelect = gohelper.findChild(go, "beselected")
	self._goUnSelected = gohelper.findChild(go, "unselected")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "btnclick")
	self._selectNameTxt = gohelper.findChildTextMesh(self._goSelect, "chapternamecn")
	self._selectNameEnTxt = gohelper.findChildTextMesh(self._goSelect, "chapternameen")
	self._unselectNameTxt = gohelper.findChildTextMesh(self._goUnSelected, "chapternamecn")
	self._unselectNameEnTxt = gohelper.findChildTextMesh(self._goUnSelected, "chapternameen")
	self.goRedDot = gohelper.findChild(go, "#go_reddot")

	self.addClickCb(self, self._btnclick, self.onClickBtn, self)
end

function Activity132CollectItem:onClickBtn()
	if not self.data or self.isSelect then
		return
	end

	Activity132Model.instance:setSelectCollectId(self.data.activityId, self.data.collectId)
end

function Activity132CollectItem:setData(data, selectId)
	self.data = data

	if not data then
		gohelper.setActive(self._viewGO, false)

		if self._redDot then
			self._redDot:setId()
			self._redDot:refreshDot()
		end

		return
	end

	gohelper.setActive(self._viewGO, true)

	local name = data.name
	local first = GameUtil.utf8sub(name, 1, 1)
	local nameLen = GameUtil.utf8len(name)
	local rename = string.format("<size=46>%s</size>%s", first, (nameLen >= 2 or nil) and GameUtil.utf8sub(name, 2, nameLen - 1))

	self._selectNameTxt.text = rename
	self._selectNameEnTxt.text = data.nameEn
	self._unselectNameTxt.text = rename
	self._unselectNameEnTxt.text = data.nameEn

	self:setSelectId(selectId)

	if not self._redDot then
		self._redDot = RedDotController.instance:addRedDot(self.goRedDot, 1081, data.collectId)
	else
		self._redDot:setId(1081, data.collectId)
		self._redDot:refreshDot()
	end
end

function Activity132CollectItem:setSelectId(selectId)
	if not self.data then
		return
	end

	local isSelect = selectId == self.data.collectId

	self.isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
	gohelper.setActive(self._goUnSelected, not isSelect)
end

function Activity132CollectItem:destroy()
	self:__onDispose()
end

return Activity132CollectItem
