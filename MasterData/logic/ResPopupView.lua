-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResPopupView.lua

module("logic.extensions.materialchallenge.view.ResPopupView", package.seeall)

local ResPopupView = class("ResPopupView", ViewComponent)

function ResPopupView:ctor()
	ResPopupView.super.ctor(self)
end

function ResPopupView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnYes = self:getBtn("Nego_Main/Btns/Yes")
	self._btnNo = self:getBtn("Nego_Main/Btns/No")
	self._evaluate = self:getGo("Nego_Main/score/evaluate"):GetComponent("UIImageSpriteChange")
	self._tableview = self:getGo("Nego_Main/rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("Nego_Main/rewardList/item")

	self._tableCell:SetActive(false)
end

function ResPopupView:bindEvents()
	self._btnYes:AddClickListener(self._onClickYes, self)
	self._btnNo:AddClickListener(self._onClickNo, self)
end

function ResPopupView:unbindEvents()
	self._btnYes:RemoveClickListener()
	self._btnNo:RemoveClickListener()
end

function ResPopupView:onEnter()
	self._hasHandleRes = false

	GlobalDispatcher:addListener(GlobalNotify.MCLG_ChallengeBalanceRes, self._onChallengeBalanceRes, self)

	local param = self:getOpenParam()

	self._score = param[1]
	self._rewardStr = param[2]
	self._onRecieveRes = param[3]

	self._evaluate:SetState(self:_getIndex(self._score))
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	local str = string.split(self._rewardStr, "#")
	local rewardItems1 = {}
	local rewardItems2 = {}
	local temp = {}

	for i, v in ipairs(str) do
		local s = string.split(v, ":")

		if checknumber(s[1]) == 9 then
			table.insert(temp, v)
		elseif not string.nilorempty(v) then
			table.insert(rewardItems1, v)
		end
	end

	for i, v in ipairs(temp) do
		local s = MaterialMgr.changeItemStr(v)
		local items = string.split(s, "#")

		for i1, v1 in ipairs(items) do
			if not string.nilorempty(v1) then
				table.insert(rewardItems2, v1)
			end
		end
	end

	for i, v in ipairs(rewardItems2) do
		local element = {}

		element.rewardStr = v
		element.isProb = true

		table.insert(self._curViewDatas, element)
	end

	for i, v in ipairs(rewardItems1) do
		local element = {}

		element.rewardStr = v
		element.isProb = false

		table.insert(self._curViewDatas, element)
	end

	self._tableview:ReloadData()
end

function ResPopupView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_ChallengeBalanceRes, self._onChallengeBalanceRes, self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	self._tableview:UnRegisterAllCallbacks()
end

function ResPopupView:_onClickClose()
	self:close()
end

function ResPopupView:_onClickYes()
	if self._hasHandleRes then
		return
	end

	self._hasHandleRes = true

	MaterialChallengeAgent.instance:sendMCLG_ChallengeBalanceReq(true)
end

function ResPopupView:_onClickNo()
	if self._hasHandleRes then
		return
	end

	self._hasHandleRes = true

	MaterialChallengeAgent.instance:sendMCLG_ChallengeBalanceReq(false)
end

function ResPopupView:_onChallengeBalanceRes(isShow)
	self._onRecieveRes(isShow)
end

function ResPopupView:_getIndex(evaluate)
	if evaluate == GameEnum.Score.S then
		return 0
	elseif evaluate == GameEnum.Score.A then
		return 1
	elseif evaluate == GameEnum.Score.B then
		return 2
	elseif evaluate == GameEnum.Score.C then
		return 3
	else
		return 4
	end
end

function ResPopupView:_numInView()
	return #self._curViewDatas
end

function ResPopupView:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 110, 90
	end

	return 90, 90
end

function ResPopupView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function ResPopupView:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")
	local prob = goutil.findChild(cell.gameObject, "prob")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.9, 0.9, 0.9)

	local proxy = MaterialMgr.setCellByCfg(data.rewardStr, parentGo)

	goutil.setActive(prob, data.isProb)
end

function ResPopupView:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

return ResPopupView
