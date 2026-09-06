-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationBufflView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationBufflView", package.seeall)

local ThreeEliminationBufflView = class("ThreeEliminationBufflView", ViewComponent)

function ThreeEliminationBufflView:ctor()
	ThreeEliminationBufflView.super.ctor(self)
end

function ThreeEliminationBufflView:unbindEvents()
	ThreeEliminationBufflView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ThreeEliminationBufflView:bindEvents()
	ThreeEliminationBufflView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function ThreeEliminationBufflView:buildUI()
	ThreeEliminationBufflView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnGet")
	self._tableView = self:getGo("tableview")
	self._tableCell = self:getGo("tablecell")
	self._txtSure = self:getTxt("btnGet/txt")
	self._cost = self:getGo("cost")
	self._costCon = self:getGo("cost/con")
	self._txtCost = self:getTxt("cost/txtNum")
end

function ThreeEliminationBufflView:onExit()
	ThreeEliminationBufflView.super.onExit(self)
	MaterialMgr.resetAll(self._costCon)
end

function ThreeEliminationBufflView:onEnter()
	ThreeEliminationBufflView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameUnLockBuffRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameSetBuffUsingRes, self._PM_ThreeEliminationGameSetBuffUsingRes, self)

	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()
	self._selectBuffId = ThreeEliminationOtherModel.instance:getBuffUsing()

	self:_refreshView()
end

function ThreeEliminationBufflView:_refreshView()
	local buffCfgs = ThreeEliminationConfig.instance:getBuffCfgs(self._activityId)

	self._tableList:reloadData(buffCfgs)

	if self._selectBuffId == 0 then
		GameUtil.SetActive(self._cost, false)

		self._txtSure.text = lang("确认")
	elseif not ThreeEliminationOtherModel.instance:isUnlockBuff(self._selectBuffId) then
		local selectBuffCfg = ThreeEliminationConfig.instance:getBuffCfg(self._activityId, self._selectBuffId)
		local matType, matId, matNum = MaterialMgr.getMatParams(selectBuffCfg.unlockCost)

		MaterialMgr.setIcon(self._costCon, matType, matId)

		self._txtCost.text = matNum

		GameUtil.SetActive(self._cost, true)

		self._txtSure.text = lang("解锁")
	elseif self._selectBuffId == ThreeEliminationOtherModel.instance:getBuffUsing() then
		GameUtil.SetActive(self._cost, false)

		self._txtSure.text = lang("确认")
	else
		GameUtil.SetActive(self._cost, false)

		self._txtSure.text = lang("使用")
	end
end

function ThreeEliminationBufflView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgSelect = goutil.findChild(go, "select")
	local con = goutil.findChild(go, "BuffIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local usingGo = goutil.findChild(go, "using")
	local unLockText = goutil.findChildTextComponent(go, "txt")
	local btnSelect = goutil.findChild(go, "btn")

	GameUtil.SetActive(usingGo, data.buffId == ThreeEliminationOtherModel.instance:getBuffUsing())
	GameUtil.SetActive(unLockGo, not ThreeEliminationOtherModel.instance:isUnlockBuff(data.buffId))
	GameUtil.SetActive(imgSelect, data.buffId == self._selectBuffId)

	unLockText.text = not ThreeEliminationOtherModel.instance:isUnlockBuff(data.buffId) and lang("<size=16>未解锁</size>") or lang("<size=24>All</size>")

	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSelect(data.buffId)
	end)

	local selectBuffCfg = ThreeEliminationConfig.instance:getBuffCfg(self._activityId, data.buffId)

	txtName.text = selectBuffCfg.name
	txtDesc.text = selectBuffCfg.desc

	uGuiUtil.setSpriteToImage(con, nil, selectBuffCfg.buffResName)
end

function ThreeEliminationBufflView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local btnSelect = goutil.findChild(go, "btnSelect")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(btnSelect)
end

function ThreeEliminationBufflView:_onClickSelect(buffId)
	self._selectBuffId = buffId

	self:_refreshView()
end

function ThreeEliminationBufflView:_onClickSure()
	if self._selectBuffId == 0 then
		self:close()
	elseif not ThreeEliminationOtherModel.instance:isUnlockBuff(self._selectBuffId) then
		local selectBuffCfg = ThreeEliminationConfig.instance:getBuffCfg(self._activityId, self._selectBuffId)
		local matType, matId, matNum = MaterialMgr.getMatParams(selectBuffCfg.unlockCost)

		if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
			ThreeEliminationGameAgent:sendPM_ThreeEliminationGameUnLockBuffReq(self._activityId, self._selectBuffId)
		else
			FloatWordMgr.instance:show(lang("材料不足"))
		end
	elseif self._selectBuffId == ThreeEliminationOtherModel.instance:getBuffUsing() then
		self:close()
	else
		ThreeEliminationGameAgent:sendPM_ThreeEliminationGameSetBuffUsingReq(self._activityId, self._selectBuffId)
	end
end

function ThreeEliminationBufflView:_PM_ThreeEliminationGameSetBuffUsingRes()
	if ThreeEliminationOtherModel.instance:getBuffUsing() ~= 0 then
		FloatWordMgr.instance:show(lang("使用成功"))
	else
		FloatWordMgr.instance:show(lang("取消成功"))
	end

	self:close()
end

return ThreeEliminationBufflView
