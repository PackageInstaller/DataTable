-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyApplyView.lua

module("logic.extensions.family.view.FamilyApplyView", package.seeall)

local FamilyApplyView = class("FamilyApplyView", TableViewComponent)

function FamilyApplyView:ctor()
	FamilyApplyView.super.ctor(self)
end

function FamilyApplyView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilyApplyView:destroyUI()
	FamilyApplyView.super.destroyUI(self)
end

function FamilyApplyView:onExitFinished()
	FamilyApplyView.super.onExitFinished(self)
end

function FamilyApplyView:onEnterFinished()
	FamilyApplyView.super.onEnterFinished(self)
end

function FamilyApplyView:unbindEvents()
	FamilyApplyView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnOkAll:RemoveClickListener()
	self._btnCancleAll:RemoveClickListener()
end

function FamilyApplyView:bindEvents()
	FamilyApplyView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnOkAll:AddClickListener(function()
		self:_batchHandleApply(true)
	end)
	self._btnCancleAll:AddClickListener(function()
		self:_batchHandleApply(false)
	end)
end

function FamilyApplyView:onExit()
	FamilyApplyView.super.onExit(self)
end

function FamilyApplyView:buildUI()
	FamilyApplyView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btn_close")
	self._btnOkAll = self:getBtn("bomleft/btnOkAll")
	self._btnCancleAll = self:getBtn("bomleft/btnCancleAll")
	self._tipsNull = self:getGo("tipsNull")
	self._txtTipJoin = goutil.findChildTextComponent(self.mainGO, "txtTipJoin")
end

function FamilyApplyView:onEnter()
	FamilyApplyView.super.onEnter(self)
	FamilyController.instance:getFamilyApplyListReq(self._updateUI, self)
end

function FamilyApplyView:_updateUI()
	self._curViewDatas = FamilyModel.instance:getApplyList()

	table.sort(self._curViewDatas, function(a, b)
		return checknumber(a.applyTime) < checknumber(b.applyTime)
	end)
	self:reloadData()
	goutil.setActive(self._tipsNull, #self._curViewDatas == 0)

	local dailyJoinCount = FamilyModel.instance:getDailyJoinCount()
	local joinLimit = FamilyConfig.instance:getCommonValue("DAILY_JOIN_LIMIT", true)
	local canJoin = joinLimit > 0 and joinLimit <= dailyJoinCount
	local color = canJoin and "eb4642" or "11A568"

	self._txtTipJoin.text = string.format("今日新增成员：<color=#%s>%s</color>/%s", color, dailyJoinCount, joinLimit)

	goutil.setActive(self._txtTipJoin.gameObject, joinLimit > 0)
end

function FamilyApplyView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local imgHeadChange = goutil.findChildComponent(container, "img_head", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(container, "txtName")
	local txtPower = goutil.findChildTextComponent(container, "txtPower")
	local txtTime = goutil.findChildTextComponent(container, "txtTime")
	local btnOk = Framework.ButtonAdapter.GetFrom(container, "btnOk")
	local btnCancle = Framework.ButtonAdapter.GetFrom(container, "btnCancle")
	local simpleInfo = data.simpleInfo

	txtName.text = simpleInfo.userName
	txtPower.text = data.maxZdl
	txtTime.text = TimeUtil.getLeftTime(data.applyTime)

	btnOk:AddClickListener(function()
		self:_handleApply(data, true)
	end)
	btnCancle:AddClickListener(function()
		self:_handleApply(data, false)
	end)
end

function FamilyApplyView:_handleApply(data, isAgree)
	FamilyController.instance:handleFamilyApplyReq(data.simpleInfo.userId, isAgree, function(extFailState)
		self:_onHandleApplySuccess(data, isAgree, extFailState)
	end)
end

function FamilyApplyView:_onHandleApplySuccess(data, isAgree, extFailState)
	print("extFailState = " .. extFailState)

	if extFailState == 2 then
		FloatWordMgr.instance:show("对方已加入别的家族")
	elseif extFailState == 3 then
		FloatWordMgr.instance:show("申请过期")
	elseif isAgree then
		local content = string.format("已同意[%s]的申请！", data.simpleInfo.userName)

		FloatWordMgr.instance:show(content)
	else
		FloatWordMgr.instance:show("已拒绝！")
	end

	self:_updateUI()
end

function FamilyApplyView:_onClickClose()
	self:close()
end

function FamilyApplyView:_batchHandleApply(isAgree)
	local userIds = {}

	for _, v in ipairs(self._curViewDatas) do
		table.insert(userIds, v.simpleInfo.userId)
	end

	if #userIds == 0 then
		FloatWordMgr.instance:show("申请列表为空")
	else
		FamilyController.instance:batchHandleFamilyApplyReq(userIds, isAgree, function()
			self:_onBatchHandleSuccess(isAgree)
		end)
	end
end

function FamilyApplyView:_onBatchHandleSuccess(isAgree)
	print("_onBatchHandleSuccess = " .. tostring(isAgree))

	if isAgree then
		FloatWordMgr.instance:show("批量同意成功")
	else
		FloatWordMgr.instance:show("已拒绝！")
	end

	self:_updateUI()
end

return FamilyApplyView
