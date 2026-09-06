-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/SendflowerView.lua

module("logic.extensions.sendflower.view.SendflowerView", package.seeall)

local SendflowerView = class("SendflowerView", ViewComponent)

function SendflowerView:ctor()
	SendflowerView.super.ctor(self)
end

function SendflowerView:buildUI()
	SendflowerView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnFinishEff = self:getGo("btnFinishEff")
	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableView")
	self._tableview = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnLessTen = self:getGo("chooseCount/btnLessTen")
	self._btnLess = self:getGo("chooseCount/btnLess")
	self._btnAdd = self:getGo("chooseCount/btnAdd")
	self._btnAddTen = self:getGo("chooseCount/btnAddTen")
	self._btnMax = self:getGo("chooseCount/btnMax")
	self._inputField = self:getInput("chooseCount/InputField")
	self._txtRemain = self:getTxt("chooseCount/txtRemain")
	self._btnSure = self:getGo("btnSure")
	self._btnRank = self:getGo("btnRank")
	self._btnSendFlower = self:getGo("btnSendFlower")
end

function SendflowerView:bindEvents()
	SendflowerView.super.bindEvents(self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFinishEff, self.close, self)
	GameUtil.addClickHandler(self._btnLessTen, function()
		self:_changeNumText(-10)
	end)
	GameUtil.addClickHandler(self._btnLess, function()
		self:_changeNumText(-1)
	end)
	GameUtil.addClickHandler(self._btnAdd, function()
		self:_changeNumText(1)
	end)
	GameUtil.addClickHandler(self._btnAddTen, function()
		self:_changeNumText(10)
	end)
	GameUtil.addClickHandler(self._btnMax, function()
		self:_changeNumText(self._curMaxValue)
	end)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnSendFlower, self._onClickSendFlower, self)
end

function SendflowerView:unbindEvents()
	SendflowerView.super.unbindEvents(self)
	self._inputField:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFinishEff)
	GameUtil.rmClickHandler(self._btnLessTen)
	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnAddTen)
	GameUtil.rmClickHandler(self._btnMax)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnSendFlower)
end

function SendflowerView:destroyUI()
	SendflowerView.super.destroyUI(self)
end

function SendflowerView:onEnter()
	SendflowerView.super.onEnter(self)

	self._selectData = nil

	self:_selectFlower()

	self._headInfo = self:getFirstParam()
	self._targetUserId = self._headInfo.userId

	if checkint(self._targetUserId) == 0 then
		TipsFacade.instance:openCommonTips("该用户不存在")
		self:close()
	end

	local isAble = SendFlowerController.instance:isTimeAbleToSendFlower()

	if isAble then
		self._sendFlowerCfg = self:_getFlowerCfg(SendFlowerConfig.instance:getFlowerCfg())

		table.sort(self._sendFlowerCfg, function(a, b)
			return a.sort < b.sort
		end)
		self._tableview:reloadData(self._sendFlowerCfg)
	else
		TipsFacade.instance:openCommonTips("进入每日结算时间，暂停送花功能")
		self:close()
	end

	goutil.setActive(self._btnFinishEff.gameObject, false)
end

function SendflowerView:onEnterFinished()
	SendflowerView.super.onEnterFinished(self)
end

function SendflowerView:onExit()
	SendflowerView.super.onExit(self)
	removetimer(self.close, self)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function SendflowerView:onExitFinished()
	SendflowerView.super.onExitFinished(self)
end

function SendflowerView:_changeNumText(delta)
	local num = checkint(self._curNum) + delta

	self:_chargeNum(num)
end

function SendflowerView:_onValueChanged(strNum)
	local num = checkint(strNum)

	self:_chargeNum(num)
end

function SendflowerView:_chargeNum(inputNum)
	local newNum = checkint(inputNum)

	newNum = Mathf.Clamp(newNum, 0, self._curMaxValue)
	self._curNum = newNum

	self._inputField:SetText(tostring(self._curNum))
end

function SendflowerView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(cell.go)

	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtHaveCount = goutil.findChildTextComponent(cell.go, "txtHaveCount")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.mark = goutil.findChild(cell.go, "mark")
	cell.txtCharm = goutil.findChildTextComponent(cell.go, "txtCharm")
	cell.txtCharm.text = langPara("魅力值：1")
	cell.tag = goutil.findChild(cell.go, "tag")

	GameUtil.rmClickHandler(cell.tag)

	return cell
end

function SendflowerView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local matStr = data.content

	MaterialMgr.setCellByCfg(matStr, cell.item)

	local matType, id, matNum = MaterialMgr.getMatParams(matStr)
	local curOwnNum = MaterialMgr.getMatCount(matStr)
	local curMax = math.floor(curOwnNum / matNum)

	if not self._selectData and curMax > 0 then
		self:_selectFlower(data)
	end

	cell.txtName.text = MaterialMgr.getMaterialsName(matType, id)
	cell.txtHaveCount.text = langPara("已拥有：%s", curMax)
	cell.txtCharm.text = langPara("魅力值：%s", data.value)

	goutil.setActive(cell.mark, self._selectData == data)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickCell, self, data))
	GameUtil.addClickHandler(cell.tag, GameUtil.handler(self._onClickTag, self, data))
end

function SendflowerView:_onClickCell(data)
	self:_selectFlower(data)
	self._tableview:reloadData(self._sendFlowerCfg)
end

function SendflowerView:_onClickTag(data)
	MaterialMgr.openGetSourceByStr(data.content)
end

function SendflowerView:_selectFlower(data)
	if data then
		local str = data.content

		if not GameUtil.isEmptyString(str) then
			self._selectData = data

			local matType, id, matNum = MaterialMgr.getMatParams(str)

			self._curOwnValue = MaterialMgr.getMatCount(str)
			self._curMaxValue = math.floor(self._curOwnValue / matNum)
			self._txtRemain.text = langPara("剩余：%s", self._curMaxValue)

			self:_chargeNum(1)
		end
	else
		self._selectData = nil
		self._curOwnValue = 0
		self._curMaxValue = 0
		self._txtRemain.text = langPara("剩余：%s", 0)

		self:_chargeNum(1)
	end
end

function SendflowerView:_onClickSure()
	if not SendFlowerController.instance:isTimeAbleToSendFlower() then
		TipsFacade.instance:openCommonTips("进入每日结算时间，暂停送花功能")
		self:close()

		return
	end

	if checkint(self._targetUserId) == 0 then
		TipsFacade.instance:openCommonTips("赠花对象不存在")
		self:close()

		return
	end

	if not self._selectData then
		TipsFacade.instance:openCommonTips("未选中赠花")

		return
	end

	if self._curNum == 0 then
		TipsFacade.instance:openCommonTips("赠花数目不可为0")

		return
	end

	local flowerCfg = SendFlowerConfig.instance:getFlowerCfg(self._selectData.id)
	local checkIsBuddy = FriendModel.instance:getGroupTypeById(self._targetUserId) == GameEnum.FriendGroup.Friend

	if checkIsBuddy then
		TipsFacade.instance:openCommonTips(langPara("增加了%s，%s点魅力值,双方共同增加%s点羁绊值", self._headInfo.userName, flowerCfg.value * self._curNum, flowerCfg.fetters * self._curNum))
	else
		TipsFacade.instance:openCommonTips(langPara("增加了%s，%s点魅力值", self._headInfo.userName, flowerCfg.value * self._curNum))
	end

	SendFlowerAgent.instance:sendPM_SendFlowerReq(self._targetUserId, self._selectData.id, self._curNum)
	self:_playEff(flowerCfg.effPath)
end

function SendflowerView:_onClickRank()
	if ViewMgr.instance:isOpen(ViewName.Rank) then
		UIStateManager.instance:popByName(ViewName.Rank)
	end

	FuncOpenController.instance:openFunc(34, "SENDFLOWER_RANK", 1)
	self:close()
end

function SendflowerView:_onClickSendFlower()
	RoleController.instance:openMyInfoCard(function()
		self.curMo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

		SendFlowerController.instance:openCharmValueView(self.curMo)
	end)
	self:close()
end

function SendflowerView:_playEff(path)
	goutil.setActive(self._btnFinishEff.gameObject, true)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	local effPath = path .. ".prefab"

	self._eff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self._btnFinishEff.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)

	removetimer(self.close, self)
	settimer(5, self.close, self, false)
end

function SendflowerView:_getFlowerCfg(cfg)
	local list = {}

	for i, v in ipairs(cfg) do
		list[i] = v
	end

	return list
end

return SendflowerView
