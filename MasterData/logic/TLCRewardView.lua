-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TLCRewardView.lua

module("logic.extensions.timelimitedchallenge.view.TLCRewardView", package.seeall)

local TLCRewardView = class("TLCRewardView", TableViewComponent)

function TLCRewardView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function TLCRewardView:unbindEvents()
	TLCRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function TLCRewardView:bindEvents()
	TLCRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function TLCRewardView:onExit()
	TLCRewardView.super.onExit(self)

	self._info = nil

	for _, v in ipairs(self._materials) do
		MaterialMgr.resetAll(v)
	end

	self._materials = nil
end

function TLCRewardView:buildUI()
	TLCRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._txtTotalDamage = goutil.findChildTextComponent(self.mainGO, "txtTotalDamge")
end

function TLCRewardView:onEnter()
	TLCRewardView.super.onEnter(self)

	self._materials = {}
	self._info = self:getFirstParam()
	self._totalDamage = self._info.totalDamage
	self._maxDamage = self._info.maxProgress
	self._challengeId = self._info.challengeId
	self._curViewDatas = TimeLimitedConfig.instance:getAccumulateProgressCfgs(self._challengeId)

	self:reloadData()

	self._txtTip.text = "活动期间累积总伤害不会重置，每次挑战结束后自动发放对应奖励。"
	self._txtTotalDamage.text = "当前累积总伤害：" .. self._totalDamage
end

function TLCRewardView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local items = goutil.findChild(go, "items")
	local btnGet = Framework.ButtonAdapter.GetFrom(go, "btnGet")
	local imgGet = goutil.findChild(go, "imgGet")
	local txtGet = goutil.findChildTextComponent(imgGet, "Text")
	local imgColorChange = imgGet:GetComponent(typeof(UIImageColorChange))
	local damage = data.progressPercent / 10000 * self._maxDamage

	txtTitle.text = string.format("总伤害达到\n<color=#EB4642FF>%s</color>", damage)

	local matArray = string.split(data.prize, "#")

	GameUtil.updateCells(items, matArray, function(go, str)
		MaterialMgr.setCellByCfg(str, go)
		table.insert(self._materials, go)
	end, nil, true)

	local isReached = damage <= self._totalDamage

	btnGet.gameObject:SetActive(false)

	if not isReached then
		txtGet.text = "未达成"

		imgColorChange:SetState(0)
	else
		txtGet.text = "已达成"

		imgColorChange:SetState(1)
	end
end

function TLCRewardView:_onClickGet(data)
	return
end

function TLCRewardView:_onClickClose()
	self:close()
end

return TLCRewardView
