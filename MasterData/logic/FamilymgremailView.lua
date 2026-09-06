-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymgremailView.lua

module("logic.extensions.family.view.FamilymgremailView", package.seeall)

local FamilymgremailView = class("FamilymgremailView", ViewComponent)

function FamilymgremailView:ctor()
	FamilymgremailView.super.ctor(self)

	self._contentValueStr = ""
	self._titleValueStr = ""
end

function FamilymgremailView:unbindEvents()
	FamilymgremailView.super.unbindEvents(self)
	self._btnSend:RemoveClickListener()
	self._contentInputField:RemoveOnValueChanged()
	self._titleInputField:RemoveOnValueChanged()
end

function FamilymgremailView:bindEvents()
	FamilymgremailView.super.bindEvents(self)
	self._btnSend:AddClickListener(self._onClickbtnSend, self)
	self._contentInputField:AddOnValueChanged(self._onContentValueChanged, self)
	self._titleInputField:AddOnValueChanged(self._onTitleValueChanged, self)
end

function FamilymgremailView:buildUI()
	FamilymgremailView.super.buildUI(self)

	self._txtContentLimit = self:getTxt("txtContentLimit")
	self._txtCost = self:getTxt("txtCost")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._txtTitleLimit = self:getTxt("txtTitleLimit")
	self._btnSend = self:getBtn("btnSend")
	self._maskGo = self:getGo("mask")
	self._contentInputField = self:getInput("contentInputField")
	self._titleInputField = self:getInput("titleInputField")
	self._txtCd = self:getTxt("btnSend/txt")
	self._imgCostGo = self:getGo("imgCost")
end

function FamilymgremailView:onExit()
	FamilymgremailView.super.onExit(self)
	removetimer(self._tickCd, self)
	MaterialMgr.resetAll(self._imgCostGo)
end

function FamilymgremailView:onEnter()
	FamilymgremailView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GetFamilyManagePanelInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.SendAllMemberMailRes, self._updateUI, self)

	self._titleLimitNum = FamilyConfig.instance:getCommonValue("ALL_MEMBER_MAIL_TITLE_LENGTH_LIMIT", true)
	self._contentLimitNum = FamilyConfig.instance:getCommonValue("ALL_MEMBER_MAIL_CONTENT_LENGTH_LIMIT", true)
	self._targetTime = 0
	self._isChief = FamilyModel.instance:isFamilyChief()

	self:_updateUI()
	MaterialMgr.setIcon(self._imgCostGo, 8, 41)
end

function FamilymgremailView:_onClickbtnSend()
	if not self._isChief then
		FloatWordMgr.instance:show("族长或副族长才可操作")

		return
	end

	if self._targetTime > 0 and self._targetTime - ServerTime.now() > 0 then
		FloatWordMgr.instance:show("冷却中")

		return
	end

	local curr = FamilyModel.instance:getMoney()

	if curr < self._sendCost then
		FloatWordMgr.instance:show("资金不足")

		return
	end

	if self._sendLeftTime <= 0 then
		FloatWordMgr.instance:show("发送邮件次数不足")

		return
	end

	if string.nilorempty(self._titleValueStr) then
		FloatWordMgr.instance:show("请写邮件标题")

		return
	end

	if string.nilorempty(self._contentValueStr) then
		FloatWordMgr.instance:show("请写邮件内容")

		return
	end

	local text = string.format("是否消耗%s家族资金向家族全员发送邮件？", self._sendCost)

	TipsFacade.instance:openPopupWindow("提示", text, function()
		FamilyAgent.instance:sendSendAllMemberMailReq(self._titleValueStr, self._contentValueStr)
	end)
end

function FamilymgremailView:_updateUI()
	self:_init()
	self:_setBlock()
	self:_updateCost()
	self:_updateLeftTime()
	self:_updateCD()
end

function FamilymgremailView:_init()
	local maxSendTime = FamilyConfig.instance:getCommonValue("SEND_ALL_MEMBER_WEEK_TIMES", true)

	self._info = FamilyModel.instance:getManagePanelInfo()
	self._sendCost = FamilyConfig.instance:getCommonValue("SEND_ALL_MEMBER_MAIL_COST", true)
	self._contentLimitNum = FamilyConfig.instance:getCommonValue("ALL_MEMBER_MAIL_CONTENT_LENGTH_LIMIT", true)
	self._sendLeftTime = maxSendTime - checknumber(self._info and self._info.allMemberMailTimes)

	self._contentInputField:SetText("")
	self._titleInputField:SetText("")
	self._titleInputField:SetCharacterLimit(self._titleLimitNum)
	self._contentInputField:SetCharacterLimit(self._contentLimitNum)
	self:_updateTitileLimit()
	self:_updateContentLimit()
end

function FamilymgremailView:_setBlock()
	goutil.setActive(self._maskGo, not self._isChief)
end

function FamilymgremailView:_onContentValueChanged(str)
	if str == self._contentValueStr then
		return
	end

	self._contentValueStr = str

	self:_updateContentLimit()
end

function FamilymgremailView:_onTitleValueChanged(str)
	if str == self._titleValueStr then
		return
	end

	self._titleValueStr = str

	self:_updateTitileLimit()
end

function FamilymgremailView:_updateTitileLimit()
	self._txtTitleLimit.text = string.format("%s/%s", string.utf8len(self._titleValueStr), self._titleLimitNum)
end

function FamilymgremailView:_updateContentLimit()
	self._txtContentLimit.text = string.format("%s/%s", string.utf8len(self._contentValueStr), self._contentLimitNum)
end

function FamilymgremailView:_updateCost()
	local curr = FamilyModel.instance:getMoney()

	if curr >= self._sendCost then
		if not GameEnum.ColorConst.Green then
			local color = GameEnum.ColorConst.Red

			self._txtCost.text = string.format("<color=%s>%s</color>/%s", color, curr, self._sendCost)
		end
	end
end

function FamilymgremailView:_updateLeftTime()
	self._txtLeftTime.text = string.format("本周剩余次数：%s", self._sendLeftTime)
end

function FamilymgremailView:_updateCD()
	self._targetTime = checknumber(self._info and self._info.allMemberMailCdMillis) / 1000
	self._targetTime = math.ceil(self._targetTime)

	removetimer(self._tickCd, self)

	self._txtCd.text = "发送"

	if self._targetTime > ServerTime.now() then
		settimer(1, self._tickCd, self)
		self:_tickCd()
	end
end

function FamilymgremailView:_tickCd()
	local leftTime = self._targetTime - ServerTime.now()

	if leftTime > 0 then
		self._txtCd.text = string.format("发送 %s:%02d", math.floor(leftTime / 60), leftTime % 60)
	else
		self:_updateCD()
	end
end

return FamilymgremailView
