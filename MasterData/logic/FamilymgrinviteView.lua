-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymgrinviteView.lua

module("logic.extensions.family.view.FamilymgrinviteView", package.seeall)

local FamilymgrinviteView = class("FamilymgrinviteView", ViewComponent)

function FamilymgrinviteView:ctor()
	FamilymgrinviteView.super.ctor(self)
end

function FamilymgrinviteView:unbindEvents()
	FamilymgrinviteView.super.unbindEvents(self)
	self._btnSend:RemoveClickListener()
	self._btnShow:RemoveClickListener()
end

function FamilymgrinviteView:bindEvents()
	FamilymgrinviteView.super.bindEvents(self)
	self._btnSend:AddClickListener(self._onClickbtnSend, self)
	self._btnShow:AddClickListener(self._onClickbtnShow, self)
end

function FamilymgrinviteView:buildUI()
	FamilymgrinviteView.super.buildUI(self)

	self._btnSend = self:getBtn("btnSend")
	self._txtCost = self:getTxt("txtCost")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._txtCd = self:getTxt("btnSend/txt")
	self._selectpanelGo = self:getGo("selectpanel")
	self._tablecellGo = self:getGo("selectpanel/tablecell")
	self._tableviewGo = self:getGo("selectpanel/tableview")
	self._btnShow = self:getBtn("btnShow")
	self._txtDesc = self:getTxt("txtDesc")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnShowTr = self._btnShow.transform
	self._imgCostGo = self:getGo("imgCost")
end

function FamilymgrinviteView:onExit()
	FamilymgrinviteView.super.onExit(self)
	removetimer(self._tickCd, self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._imgCostGo)
end

function FamilymgrinviteView:onEnter()
	FamilymgrinviteView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GetSendEnlistMsgRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.GetFamilyManagePanelInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.SendAllMemberMailRes, self._updateUI, self)

	self._isChief = FamilyModel.instance:isFamilyChief()
	self._targetTime = 0
	self._showItemPanel = false
	self._templateId = 69

	self:_updateUI()
	MaterialMgr.setIcon(self._imgCostGo, 8, 41)
end

function FamilymgrinviteView:_onClickbtnSend()
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

	local text = string.format("是否消耗%s家族资金在本服频道发送招募信息？", self._sendCost)

	TipsFacade.instance:openPopupWindow("提示", text, function()
		FamilyAgent.instance:sendGetSendEnlistMsgReq(self._templateId)
	end)
end

function FamilymgrinviteView:_onClickbtnShow()
	self._showItemPanel = not self._showItemPanel

	self:_updateItemPanelState()
end

function FamilymgrinviteView:_updateUI()
	self:_init()
	self:_updateCost()
	self:_updateCD()
	self:_updateDesc()
	self:_updateItems()
	self:_updateItemPanelState()
end

function FamilymgrinviteView:_init()
	self._info = FamilyModel.instance:getManagePanelInfo()
	self._sendCost = FamilyConfig.instance:getCommonValue("SEND_ENLIST_MSG_COST", true)

	local info = FamilyModel.instance:getMyFamilySettingInfo()

	if info then
		self._familyName = info.familyName or "暂无家族"
	end
end

function FamilymgrinviteView:_updateCost()
	local curr = FamilyModel.instance:getMoney()

	if curr >= self._sendCost then
		if not GameEnum.ColorConst.Green then
			local color = GameEnum.ColorConst.Red

			self._txtCost.text = string.format("<color=%s>%s</color>/%s", color, curr, self._sendCost)
		end
	end
end

function FamilymgrinviteView:_updateCD()
	self._targetTime = checknumber(self._info and self._info.sendEnlistCdEndMillis) / 1000
	self._targetTime = math.ceil(self._targetTime)

	removetimer(self._tickCd, self)

	self._txtCd.text = "发送"

	if self._targetTime > ServerTime.now() then
		settimer(1, self._tickCd, self)
		self:_tickCd()
	end
end

function FamilymgrinviteView:_tickCd()
	local leftTime = self._targetTime - ServerTime.now()

	if leftTime > 0 then
		self._txtCd.text = string.format("发送 %s:%02d", math.floor(leftTime / 60), leftTime % 60)
	else
		self:_updateCD()
	end
end

function FamilymgrinviteView:_updateCell(view, cell, templateId, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local cfg = ChatConfig.instance:getSystemMsgT(templateId)
	local content = ""

	if cfg then
		content = string.gsub(cfg.template, "{fn}", self._familyName)
		content = string.gsub(content, "前往申请>>!", "")
	end

	txtDesc.text = content

	btn:AddClickListener(function()
		self:_onClickTemplate(templateId)
	end)
end

function FamilymgrinviteView:_clearCell(cell)
	return
end

function FamilymgrinviteView:_updateDesc()
	local cfg = ChatConfig.instance:getSystemMsgT(self._templateId)
	local content = ""

	if cfg then
		content = string.gsub(cfg.template, "{fn}", self._familyName)
		content = string.gsub(content, "前往申请>>!", "")
	end

	self._txtDesc.text = content
end

function FamilymgrinviteView:_updateItems()
	local list = {
		69,
		70,
		71,
		72,
		73
	}

	self._scrollerList:reloadData(list)
end

function FamilymgrinviteView:_onClickTemplate(templateId)
	self._templateId = templateId

	self:_onClickbtnShow()
	self:_updateDesc()
	self:_updateItemPanelState()
end

function FamilymgrinviteView:_updateItemPanelState()
	local z = self._showItemPanel and 90 or -90

	Framework.TransformUtil.SetEuler(self._btnShowTr, 0, 0, z)
	goutil.setActive(self._selectpanelGo, self._showItemPanel)
end

return FamilymgrinviteView
