-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagebindView.lua

module("logic.extensions.originage.view.OriginagebindView", package.seeall)

local OriginagebindView = class("OriginagebindView", ViewComponent)

function OriginagebindView:ctor()
	OriginagebindView.super.ctor(self)
end

function OriginagebindView:unbindEvents()
	OriginagebindView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCopy)
	GameUtil.rmClickHandler(self._btnSend)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._canGet1)
	GameUtil.rmClickHandler(self._canGet2)
	GameUtil.rmClickHandler(self._btnClose)
	self._inputComp:RemoveOnValueChanged()
end

function OriginagebindView:bindEvents()
	OriginagebindView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickCopy, self)
	GameUtil.addClickHandler(self._btnSend, self._onClickSend, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSold, self)
	GameUtil.addClickHandler(self._canGet1, self._onClickGet1, self)
	GameUtil.addClickHandler(self._canGet2, self._onClickGet2, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
end

function OriginagebindView:buildUI()
	OriginagebindView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._rewardCell_2 = self:getGo("rewardCell_2")
	self._rewardCell_1 = self:getGo("rewardCell_1")
	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnSend = self:getGo("oldPlay/btnSend")
	self._btnCopy = self:getGo("oldPlay/btnCopy")

	GameUtil.SetActive(self._btnCopy, Clipboard._checkCanUse())

	self._inputComp = self:getInput("InputC_Search")
	self._item1 = self:getGo("rewardCell_1/item")
	self._received1 = self:getGo("rewardCell_1/received")
	self._canGet1 = self:getGo("rewardCell_1/canGet")
	self._effect1 = self:getGo("rewardCell_1/effect")
	self._item2 = self:getGo("rewardCell_2/item")
	self._received2 = self:getGo("rewardCell_2/received")
	self._canGet2 = self:getGo("rewardCell_2/canGet")
	self._effect2 = self:getGo("rewardCell_2/effect")
end

function OriginagebindView:onExit()
	OriginagebindView.super.onExit(self)
end

function OriginagebindView:onEnter()
	OriginagebindView.super.onEnter(self)

	self._lastInputTxt = ""
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginAgeController.instance:getDefaultActivityId()
	end

	local params = self:getOpenParam() or {}

	self._inviteStr = params[2] or ""

	self._inputComp:SetText(self._inviteStr)
	self.addGEvent(self, GlobalNotify.OriginAgeBindEnd, self._onBindEnd, self)
	self.addGEvent(self, GlobalNotify.OriginAgeInfoUpdate, self._onRefreshUI, self)
	OriginAgeController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function OriginagebindView:_onRefreshUI()
	self._info = OriginAgeModel.instance:getInfo(self._activityId) or {}
	self._actCfg = OriginAgeConfig.instance:getActivityCfgById(self._activityId) or {}

	local cfg = ChatConfig.instance:getSystemMsgT(self._actCfg.templateId)
	local content = ""

	if cfg and self._info.myInviteCode then
		local t = {
			inviteCode = self._info.myInviteCode
		}

		content = StringUtil.parseJsonParams(cfg.template, t)
	end

	self._txtDesc.text = content

	if not self._info.gainPrizeTypeList then
		local gainPrizeTypeList = {}
		local pcfg1 = OriginAgeConfig.instance:getPrizeyCfgById(self._activityId, "INVITE_OLD_PLAYER") or {}
		local pcfg2 = OriginAgeConfig.instance:getPrizeyCfgById(self._activityId, "BIND_CODE") or {}

		MaterialMgr.setCellByCfg(pcfg1.prize, self._item1)
		MaterialMgr.setCellByCfg(pcfg2.prize, self._item2)

		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		GameUtil.SetActive(self._received1, false)
		GameUtil.SetActive(self._canGet1, false)
		GameUtil.SetActive(self._effect1, false)
		self:stopViewEffectUniGo(self._effect1)

		if checkbool(self._info.inviteOldPlayer) then
			if table.indexof(gainPrizeTypeList, "INVITE_OLD_PLAYER") == false then
				GameUtil.SetActive(self._canGet1, true)
				GameUtil.SetActive(self._effect1, true)
				self:playViewEffectUniGo(effPath, self._effect1, nil, true)
			else
				GameUtil.SetActive(self._received1, true)
			end
		end

		GameUtil.SetActive(self._received2, false)
		GameUtil.SetActive(self._canGet2, false)
		GameUtil.SetActive(self._effect2, false)
		self:stopViewEffectUniGo(self._effect2)

		if checknumber(self._info.bindPlayerId) > 0 then
			if table.indexof(gainPrizeTypeList, "BIND_CODE") == false then
				GameUtil.SetActive(self._canGet2, true)
				GameUtil.SetActive(self._effect2, true)
				self:playViewEffectUniGo(effPath, self._effect2, nil, true)
			else
				GameUtil.SetActive(self._received2, true)
			end
		end
	end
end

function OriginagebindView:_inputValueChanged(text)
	local subStr = string.sub(text, 1, 550)

	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = subStr

	self._inputComp:SetText(subStr)
end

function OriginagebindView:_onBindEnd(msg)
	if msg.resultCode == 0 then
		self:_inputValueChanged("")
		self:_onRefreshUI()
	end
end

function OriginagebindView:_onClickCopy()
	local cfg = ChatConfig.instance:getSystemMsgT(self._actCfg.templateId)
	local content = ""

	if cfg and self._info.myInviteCode then
		local t = {
			inviteCode = self._info.myInviteCode
		}

		content = StringUtil.parseJsonParams(cfg.template, t)
	end

	if Framework.OSDef.isEditor then
		Game.TextUtil.CopyToClipBoard(content)
	else
		Clipboard.copy(content)
	end

	FloatWordMgr.instance:show("邀请码已复制")
end

function OriginagebindView:_onClickSend()
	OriginAgeController.instance:tryOpenFriendView(self._activityId, self._info.myInviteCode, self._actCfg.templateId)
end

function OriginagebindView:_onClickGet1()
	if not self._info.gainPrizeTypeList then
		if table.indexof(self._info.gainPrizeTypeList, "INVITE_OLD_PLAYER") == false then
			OriginAgeController.instance:sendGetPrize(self._activityId, "INVITE_OLD_PLAYER")
		end
	end
end

function OriginagebindView:_onClickGet2()
	if not self._info.gainPrizeTypeList then
		if table.indexof(self._info.gainPrizeTypeList, "BIND_CODE") == false then
			OriginAgeController.instance:sendGetPrize(self._activityId, "BIND_CODE")
		end
	end
end

function OriginagebindView:_onClickBtnSold()
	if checknumber(self._info.bindPlayerId) > 0 then
		FloatWordMgr.instance:show("已经绑定过邀请码了，不需要重新绑定")

		return
	end

	if string.nilorempty(self._lastInputTxt) then
		return
	end

	local result = string.match(self._lastInputTxt, "%【(.-)%】")

	if result then
		self._lastInputTxt = result
	end

	if string.nilorempty(self._lastInputTxt) then
		FloatWordMgr.instance:show("分享码不存在，再仔细检查下~")

		return
	end

	OriginAgeController.instance:sendBindCode(self._activityId, self._lastInputTxt)
end

return OriginagebindView
