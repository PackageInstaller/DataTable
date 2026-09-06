-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessFlowerView.lua

module("logic.extensions.goddess.view.GoddessFlowerView", package.seeall)

local GoddessFlowerView = class("GoddessFlowerView", ViewComponent)

function GoddessFlowerView:buildUI()
	GoddessFlowerView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnFinishEff = self:getBtn("btnFinishEff")
	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableView")
	self._tableview = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnLessTen = self:getBtn("chooseCount/btnLessTen")
	self._btnLess = self:getBtn("chooseCount/btnLess")
	self._btnAdd = self:getBtn("chooseCount/btnAdd")
	self._btnAddTen = self:getBtn("chooseCount/btnAddTen")
	self._btnMax = self:getBtn("chooseCount/btnMax")
	self._inputField = self:getInput("chooseCount/InputField")
	self._txtRemain = self:getTxt("chooseCount/txtRemain")
	self._btnSure = self:getBtn("btnSure")
	self._curSlider = self:getSlider("curSlider")
	self._addSlider = self:getSlider("curSlider/addSlider")
	self._txtFeeling = self:getTxt("curSlider/txt")
end

function GoddessFlowerView:onEnter()
	GoddessFlowerView.super.onEnter(self)

	self._curInfo = GoddessModel.instance:getCurGoddessInfo()
	self._selectData = nil

	self:_selectFlower()

	self._flowerCfgs = GoddessConfig.instance:getFlowerCfgsByActId(GoddessModel.instance:getActId()) or {}

	self._tableview:reloadData(self._flowerCfgs)
	goutil.setActive(self._btnFinishEff.gameObject, false)
	GoddessModel.instance:resetGoodFeelingChangeValue()

	self._isSendFlower = false
end

function GoddessFlowerView:onExit()
	GoddessFlowerView.super.onExit(self)
	removetimer(self.close, self)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	GoddessModel.instance:showCI()

	local addValue, isLvUp = GoddessModel.instance:getGoodFeelingChangeValue()

	if addValue > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GoddessAddFeelingAni)
	end

	if self._isSendFlower then
		GlobalDispatcher:dispatch(GlobalNotify.GoddessPlayBubble, self._curInfo.raceCfg.bubbleFowler)
	end
end

function GoddessFlowerView:bindEvents()
	GoddessFlowerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnFinishEff:AddClickListener(self.close, self)
	self._btnLessTen:AddClickListener(function()
		self:_changeNumText(-10)
	end)
	self._btnLess:AddClickListener(function()
		self:_changeNumText(-1)
	end)
	self._btnAdd:AddClickListener(function()
		self:_changeNumText(1)
	end)
	self._btnAddTen:AddClickListener(function()
		self:_changeNumText(10)
	end)
	self._btnMax:AddClickListener(function()
		local curMax = self._curMaxValue

		self:_changeNumText(curMax)
	end)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function GoddessFlowerView:unbindEvents()
	GoddessFlowerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnFinishEff:RemoveClickListener()
	self._btnLessTen:RemoveClickListener()
	self._btnLess:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnAddTen:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
end

function GoddessFlowerView:_changeNumText(delta)
	local num = checkint(self._curNum) + delta

	self:_chargeNum(num)
end

function GoddessFlowerView:_onValueChanged(strNum)
	local num = checkint(strNum)

	self:_chargeNum(num)
end

function GoddessFlowerView:_chargeNum(inputNum)
	local newNum = checkint(inputNum)

	newNum = Mathf.Clamp(newNum, 0, self._curMaxValue)
	self._curNum = newNum

	self._inputField:SetText(tostring(self._curNum))
	self:_updateSlider()
end

function GoddessFlowerView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(cell.go)

	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtHaveCount = goutil.findChildTextComponent(cell.go, "txtHaveCount")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.mark = goutil.findChild(cell.go, "mark")

	return cell
end

function GoddessFlowerView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local matStr = data.cost

	MaterialMgr.setCellByCfg(matStr, cell.item)

	local matType, id, matNum = MaterialMgr.getMatParams(matStr)
	local curOwnNum = MaterialMgr.getMatCount(matStr)
	local curMax = math.floor(curOwnNum / matNum)

	if not self._selectData and curMax > 0 then
		self:_selectFlower(data)
	end

	cell.txtName.text = MaterialMgr.getMaterialsName(matType, id)
	cell.txtHaveCount.text = langPara("已拥有：%s", curMax)

	goutil.setActive(cell.mark, self._selectData == data)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickCell, self, data))
end

function GoddessFlowerView:_onClickCell(data)
	self:_selectFlower(data)
	self._tableview:reloadData(self._flowerCfgs)
end

function GoddessFlowerView:_selectFlower(data)
	if data then
		local str = data.cost

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

function GoddessFlowerView:_onClickSure()
	if not self._selectData then
		TipsFacade.instance:openCommonTips("未选中赠花")

		return
	end

	if self._curNum == 0 then
		TipsFacade.instance:openCommonTips("赠花数目不可为0")

		return
	end

	self:_playEff(self._selectData.effPath)
	GoddessController.instance:sendFlower(self._curInfo.raceId, self._selectData.id, self._curNum)

	self._isSendFlower = true
end

function GoddessFlowerView:_playEff(path)
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

function GoddessFlowerView:_updateSlider()
	local curDailyFeeling = GoddessModel.instance:getDailyFeeling()
	local totalFeeling = GoddessConfig.instance:getDailyAddGoodFeelingLimit()

	self._curSlider:SetValue(checknumber(curDailyFeeling) / totalFeeling)

	if self._curNum > 0 then
		local addValue = self._selectData.feeling * self._curNum

		addValue = Mathf.Min(addValue, totalFeeling - curDailyFeeling)

		self._addSlider:SetValue(checknumber(curDailyFeeling + addValue) / totalFeeling)

		self._txtFeeling.text = langPara("%s<color=FFF578FF>+%s</color>/%s", curDailyFeeling, addValue, totalFeeling)
	else
		self._addSlider:SetValue(0)

		self._txtFeeling.text = langPara("%s/%s", curDailyFeeling, totalFeeling)
	end
end

return GoddessFlowerView
