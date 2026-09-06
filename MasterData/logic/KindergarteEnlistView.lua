-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteEnlistView.lua

module("logic.extensions.kindergarten.view.KindergarteEnlistView", package.seeall)

local KindergarteEnlistView = class("KindergarteEnlistView", ViewComponent)

function KindergarteEnlistView:buildUI()
	KindergarteEnlistView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._itemView = goutil.findChild(self.mainGO, "itemView")
	self._itemCell = goutil.findChild(self.mainGO, "itemCell")
end

function KindergarteEnlistView:bindEvents()
	KindergarteEnlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KindergarteEnlistView:unbindEvents()
	KindergarteEnlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function KindergarteEnlistView:onEnter()
	KindergarteEnlistView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self._enlistCfg = KindergartenConfig.instance:getEnlistCfg(self._activityId)

	self.addGEvent(self, GlobalNotify.KindergartenGetInfoRes, self._onUpdateUI, self)
	self:_onUpdateUI()
end

function KindergarteEnlistView:onExit()
	KindergarteEnlistView.super.onExit(self)
	self:_onClearUI()
end

function KindergarteEnlistView:_onUpdateUI()
	GameUtil.updateCellsList(self._itemView, self._itemCell, self._enlistCfg, self._updateItemCell, self)
end

function KindergarteEnlistView:_onClearUI()
	GameUtil.clearCells(self._itemView, self._clearItemCell, self)
end

function KindergarteEnlistView:_updateItemCell(mainGo, data, index)
	local matStr = data.cost
	local matType, matId, matCost = MaterialMgr.getMatParams(matStr)
	local matNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local imgItem1 = goutil.findChild(mainGo, "imgItem_1")
	local imgItem2 = goutil.findChild(mainGo, "imgItem_2")
	local btnEnlist = goutil.findChild(mainGo, "btnEnlist")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtCount.text = string.format("当前拥有：<color=#A4413BFF>%s</color>", matNum)

	GameUtil.addClickHandler(btnEnlist, GameUtil.handler(self._onClickBtnEnlist, self, data.enlistId))
	GameUtil.SetActive(imgItem1, false)
	GameUtil.SetActive(imgItem2, false)

	if data.enlistId == 1 then
		txtDesc.text = lang("可招募普通学生，有1%的概率招募到天才学生")

		GameUtil.SetActive(imgItem1, true)
	else
		txtDesc.text = lang("100%招募天才学生")

		GameUtil.SetActive(imgItem2, true)
	end
end

function KindergarteEnlistView:_clearItemCell(mainGo)
	local imgItem = goutil.findChild(mainGo, "imgItem")
	local btnEnlist = goutil.findChild(mainGo, "btnEnlist")

	GameUtil.rmClickHandler(btnEnlist)
end

function KindergarteEnlistView:_onClickBtnEnlist(enlistId)
	local info = KindergartenModel.instance:getInfo(self._activityId)

	if info.isAuto == true then
		FloatWordMgr.instance:show(lang("自动上课中无法招募学生"))

		return
	end

	UIStateManager.instance:push(ViewName.KindergarteEnlistCostView, self._activityId, enlistId)
end

return KindergarteEnlistView
