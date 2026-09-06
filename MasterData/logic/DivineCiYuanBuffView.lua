-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanBuffView.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanBuffView", package.seeall)

local DivineCiYuanBuffView = class("DivineCiYuanBuffView", ViewComponent)

function DivineCiYuanBuffView:ctor()
	DivineCiYuanBuffView.super.ctor(self)
end

function DivineCiYuanBuffView:unbindEvents()
	DivineCiYuanBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSelect)
end

function DivineCiYuanBuffView:bindEvents()
	DivineCiYuanBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSelectBuff, self)
end

function DivineCiYuanBuffView:buildUI()
	DivineCiYuanBuffView.super.buildUI(self)

	self._empty = self:getGo("empty")
	self._tableViewGo = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._skill = self:getGo("skill")
	self._skillIcon = self:getGo("skill/skillIcon")
	self._txtName = self:getTxt("skill/txtName")
	self._txtDesc = self:getTxt("skill/txtDesc")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._tableview = ScrollerList.create(self._tableViewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSelect = self:getBtn("btnSelect")
end

function DivineCiYuanBuffView:onExit()
	DivineCiYuanBuffView.super.onExit(self)
	self._tableview:dispose()
end

function DivineCiYuanBuffView:onEnter()
	DivineCiYuanBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanGainSelectBuffRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanGetInfoRes, self._refresh, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabId = checknumber(params[2])

	if self._activityId <= 0 or self._tabId <= 0 then
		printError("DivineCiYuanBuffView 缺少 activityId 或 tabId")
		self:close()

		return
	end

	local tabCfg = DivineCiYuanConfig.instance:getTabCfgById(self._activityId, self._tabId)

	self._buffCfg = DivineCiYuanConfig.instance:getBuffPlaneCfg(tabCfg.buffPlanId)

	local isEmpty = TableUtil.isTableEmpty(self._buffCfg)

	GameUtil.SetActive(self._empty, isEmpty)
	GameUtil.SetActive(self._tableViewGo, not isEmpty)

	self._buffId = 1
	self._buffRemoteId = 0

	if not isEmpty then
		self._tableview:reloadData(self._buffCfg)

		local isSelectBuff = DivineCiYuanController.instance:isSelectBuff(self._tabId)

		if isSelectBuff then
			self._buffId = DivineCiYuanModel.instance:getSelectBuffId(self._tabId)
		end
	end

	self:_refresh()
end

function DivineCiYuanBuffView:_sendGetInfoReq()
	DivineCiYuanController.instance:sendPM_DivineCiYuanGetInfoReq(self._activityId)
end

function DivineCiYuanBuffView:_refresh()
	self._tableview:refresh()

	local selectBuffId = DivineCiYuanModel.instance:getSelectBuffId(self._tabId)

	GameUtil.SetActive(self._skill, selectBuffId > 0)

	if selectBuffId > 0 then
		self._buffRemoteId = selectBuffId

		local cfg = DivineCiYuanConfig.instance:getBuffCfg(selectBuffId)

		uGuiUtil.setSpriteToImage(self._skillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))

		self._txtName.text = cfg.name
		self._txtDesc.text = cfg.desc
	end
end

function DivineCiYuanBuffView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "skillIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local select = goutil.findChild(cell, "select")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.icon))

	txtName.text = data.name
	txtDesc.text = data.desc

	GameUtil.SetActive(tag, data.unLockStageId > 0)
	GameUtil.SetActive(select, data.buffId == self._buffId)

	txtTag.text = "第" .. data.unLockStageId .. "解锁"

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickBuff, self, data.buffId))
end

function DivineCiYuanBuffView:_clearCell(cell)
	local icon = goutil.findChild(cell, "skillIcon")

	uGuiUtil.clearImage(icon)
end

function DivineCiYuanBuffView:_onClickTip()
	local key = DivineCiYuanConfig.instance:getActRuleKey(self._activityId, "ruleKeyBuff")

	TipsFacade.instance:openRulesView(key)
end

function DivineCiYuanBuffView:_onClickBuff(buffId)
	if self._buffRemoteId == buffId then
		FloatWordMgr.instance:show("已成功选择该增益效果")

		return
	end

	self._buffId = buffId

	self:_refresh()
end

function DivineCiYuanBuffView:_onClickSelectBuff()
	if self._buffId == self._buffRemoteId then
		FloatWordMgr.instance:show("已成功选择该增益效果")

		return
	end

	local tips = lang("divineciyuan_buff_tip")

	local function sureChange()
		DivineCiYuanController.instance:sendPM_DivineCiYuanGainSelectBuffReq(self._activityId, self._tabId, self._buffId)
	end

	TipsFacade.instance:openTipWindow(lang("text_tong_tips"), tips, sureChange, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

return DivineCiYuanBuffView
