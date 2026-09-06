-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemRelieveView.lua

module("logic.extensions.tutorsystem.view.TutorSystemRelieveView", package.seeall)

local TutorSystemRelieveView = class("TutorSystemRelieveView", ViewComponent)

function TutorSystemRelieveView:buildUI()
	TutorSystemRelieveView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._emptyGo = goutil.findChild(self.mainGO, "stuCol/emptyGo")

	local scrView = goutil.findChild(self.mainGO, "stuCol/scrView")
	local scrCell = goutil.findChild(self.mainGO, "stuCol/scrCell")

	self._stuScrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateStuCell, self), GameUtil.handler(self._clearStuCell, self))
end

function TutorSystemRelieveView:bindEvents()
	TutorSystemRelieveView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function TutorSystemRelieveView:unbindEvents()
	TutorSystemRelieveView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function TutorSystemRelieveView:onEnter()
	TutorSystemRelieveView.super.onEnter(self)

	self._curTabIdx = self._curTabIdx or 0

	self.addGEvent(self, GlobalNotify.TutorMainInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function TutorSystemRelieveView:onExit()
	TutorSystemRelieveView.super.onExit(self)
	self._stuScrollList:dispose()
end

function TutorSystemRelieveView:_onUpdate()
	self._stuInfoList = TutorSystemModel.instance:getStuInfoListAsTea() or {}

	self._stuScrollList:reloadData(self._stuInfoList)

	local info = self._stuInfoList[self._curTabIdx]

	GameUtil.SetGray(self._btnSure, info == nil)
	GameUtil.SetActive(self._emptyGo, #self._stuInfoList <= 0)
end

function TutorSystemRelieveView:_updateStuCell(view, cell, info, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local isSelected = self._curTabIdx == tabIdx
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")
	local tag = goutil.findChild(mainGo, "tag")
	local imgGou = goutil.findChild(mainGo, "tag/imgGou")
	local imgSelected = goutil.findChild(mainGo, "tag/imgSelected")

	GameUtil.SetActive(imgGou, isSelected)
	GameUtil.SetActive(imgSelected, isSelected)

	txtName.text = info.headInfo.headInfo.userName

	local cur = info.headInfo.maxZdl
	local max = TutorSystemConfig.instance:getMaxZdlInPrize()

	txtZdl.text = max <= cur and string.format("<color=#20b376>%s</color>/%s", cur, max) or string.format("<color=#eb4624>%s</color>/%s", cur, max)

	HeadItemController.instance:setHeadCellByInfo(headRoot, info.headInfo.headInfo, true)
	GameUtil.addClickHandler(mainGo, function()
		self._curTabIdx = tabIdx

		self:_onUpdate()
	end)
end

function TutorSystemRelieveView:_clearStuCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)
	GameUtil.rmClickHandler(mainGo)
end

function TutorSystemRelieveView:_onClickBtnCancel()
	self:close()
end

function TutorSystemRelieveView:_onClickBtnSure()
	local info = self._stuInfoList[self._curTabIdx]

	if info == nil then
		FloatWordMgr.instance:show("未选择学生")

		return
	end

	TutorSystemController.instance:goToRemoveRelationship(info.headInfo.headInfo.userId)
end

return TutorSystemRelieveView
