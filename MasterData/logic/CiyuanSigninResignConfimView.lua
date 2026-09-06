-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/view/CiyuanSigninResignConfimView.lua

module("logic.extensions.ciyuansignin.view.CiyuanSigninResignConfimView", package.seeall)

local CiyuanSigninResignConfimView = class("CiyuanSigninResignConfimView", ViewComponent)

function CiyuanSigninResignConfimView:buildUI()
	CiyuanSigninResignConfimView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._content = MaterialMgr.findGraphicText(self.mainGO, "content")
	self._iconCurOwn = self:getGo("curOwn/icon")
	self._txtNumCurOwn = self:getTxt("curOwn/txtNum")
	self._iconCurCost = self:getGo("curCost/icon")
	self._txtNumCurCost = self:getTxt("curCost/txtNum")
	self._inputNum = self:getInput("inputNum")
	self._btnAdd = self:getGo("adjust/BtnAdd")
	self._btnMs = self:getGo("adjust/BtnMs")
	self._btnA10 = self:getGo("adjust/BtnA10")
	self._btnM10 = self:getGo("adjust/BtnM10")
	self._goToggle = self:getGo("toggle")
	self._btnToggle = goutil.findChild(self._goToggle, "btnToggle")
	self._txtToggle = goutil.findChildTextComponent(self._goToggle, "txtToggle", "Text")
	self._imgGou = goutil.findChild(self._btnToggle, "imgGou")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateTableCell, self), GameUtil.handler(self._clearTableCell, self))

	self._tableList:setCenterMode(true)
end

function CiyuanSigninResignConfimView:bindEvents()
	CiyuanSigninResignConfimView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnAdd, GameUtil.handler(self._changeNumText, self, 1))
	GameUtil.addClickHandler(self._btnMs, GameUtil.handler(self._changeNumText, self, -1))
	GameUtil.addClickHandler(self._btnA10, GameUtil.handler(self._changeNumText, self, 10))
	GameUtil.addClickHandler(self._btnM10, GameUtil.handler(self._changeNumText, self, -10))
	self._inputNum:AddOnValueChanged(self._onValueChanged, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickToggle, self)
end

function CiyuanSigninResignConfimView:unbindEvents()
	CiyuanSigninResignConfimView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMs)
	GameUtil.rmClickHandler(self._btnA10)
	GameUtil.rmClickHandler(self._btnM10)
	GameUtil.rmClickHandler(self._btnToggle)
	self._inputNum:RemoveOnValueChanged()
end

function CiyuanSigninResignConfimView:onEnter()
	CiyuanSigninResignConfimView.super.onEnter(self)

	local param = self._viewPresentor:getFirstParam() or {}
	local matType = checknumber(param.matType)
	local matId = checknumber(param.matId)
	local matNum = math.max(checknumber(param.matNum), 1)
	local count = 0

	self._numMax = math.max(checknumber(param.maxNum), 1)
	self.selectNum = Mathf.Clamp(checknumber(param.defaultNum), 1, self._numMax)
	self.matType = matType
	self.matId = matId
	self.costNum = matNum
	self._successCallBack = param.successCallBack
	self._beforeSureCallBack = param.beforeSureCallBack
	self._otherCallBack = param.otherCallBack
	self._costCallBack = param.costCallBack
	self._contentCallBack = param.contentCallBack
	self._rewardCallBack = param.rewardCallBack
	self._autoOpenSource = param.autoOpenSource ~= false
	self._toggleCall = param.toggleFunc
	count = (matType == MatType.Diamond or matType == MatType.PayDiamond) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond() or MaterialModel.instance:getMaterialsNumber(matType, matId)
	self._numMax = math.min(self._numMax, math.max(math.floor(count / self.costNum), 1))

	MaterialMgr.setIcon(self._iconCurOwn, matType, matId)
	MaterialMgr.setIcon(self._iconCurCost, matType, matId)

	self._txtNumCurOwn.text = count

	goutil.setActive(self._goToggle, self._toggleCall ~= nil)
	goutil.setActive(self._imgGou, false)
	self:_refreshSelectInfo()
end

function CiyuanSigninResignConfimView:onExit()
	CiyuanSigninResignConfimView.super.onExit(self)

	self._successCallBack = nil
	self._beforeSureCallBack = nil
	self._otherCallBack = nil
	self._costCallBack = nil
	self._contentCallBack = nil
	self._rewardCallBack = nil
	self._toggleCall = nil

	MaterialMgr.resetAll(self._iconCurOwn)
	MaterialMgr.resetAll(self._iconCurCost)
end

function CiyuanSigninResignConfimView:destroyUI()
	CiyuanSigninResignConfimView.super.destroyUI(self)

	if self._tableList then
		self._tableList:dispose()

		self._tableList = nil
	end
end

function CiyuanSigninResignConfimView:_onClickClose()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_CANCEL)
	self:close()
end

function CiyuanSigninResignConfimView:_onClickSure()
	local totalCost = self.costNum * self.selectNum

	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_OK)

	if GameUtil.callBack(self._beforeSureCallBack, self.selectNum, self) == false then
		return
	end

	if not MaterialFacade.instance:checkMatEnough(self.matType, self.matId, totalCost, nil, self._autoOpenSource) then
		self:close()
		GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_FAIL)

		return
	end

	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_SUCCESS)
	GameUtil.callBack(self._successCallBack, self.selectNum, self)
	self:close()
end

function CiyuanSigninResignConfimView:_changeNumText(delta)
	local oldNum = self.selectNum
	local newNum = Mathf.Clamp(oldNum + delta, 1, self._numMax)

	if delta > 0 and newNum == oldNum then
		TipsFacade.instance:openCommonTips("已为最大可补签天数")
	end

	self.selectNum = newNum

	self:_refreshSelectInfo()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_NUM_CHANGE, self.selectNum)
end

function CiyuanSigninResignConfimView:_onValueChanged(strNum)
	self.selectNum = Mathf.Clamp(checknumber(strNum), 1, self._numMax)

	self:_refreshSelectInfo()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_NUM_CHANGE, self.selectNum)
end

function CiyuanSigninResignConfimView:_onClickToggle()
	goutil.setActive(self._imgGou, not self._imgGou.activeSelf)
	GameUtil.callBack(self._toggleCall, not self._imgGou.activeSelf)
end

function CiyuanSigninResignConfimView:_refreshSelectInfo()
	local costNum = self.costNum * self.selectNum
	local content = GameUtil.callBack(self._contentCallBack, self.selectNum)
	local rewardList = GameUtil.callBack(self._rewardCallBack, self.selectNum) or {}

	self._inputNum:SetText(tostring(self.selectNum))

	self._txtNumCurCost.text = self._costCallBack and tostring(GameUtil.callBack(self._costCallBack, self.selectNum)) or tostring(costNum)

	if content then
		self._content.text = content
	end

	self._tableList:reloadData(rewardList)
end

function CiyuanSigninResignConfimView:_updateTableCell(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
	MaterialMgr.setCellByCfg((string.nilorempty(data.showPrize) or nil) and (data.prize or data.showPrize), icon)
end

function CiyuanSigninResignConfimView:_clearTableCell(cell)
	local icon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(icon)
end

return CiyuanSigninResignConfimView
