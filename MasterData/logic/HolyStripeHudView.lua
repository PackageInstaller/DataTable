-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripehud/view/HolyStripeHudView.lua

module("logic.extensions.holystripehud.view.HolyStripeHudView", package.seeall)

local HolyStripeHudView = class("HolyStripeHudView", ViewComponent)

HolyStripeHudView.ReadFlag = "HolyStripeHudView.ReadFlag"

function HolyStripeHudView:ctor()
	HolyStripeHudView.super.ctor(self)

	self.skinId = nil
end

function HolyStripeHudView:buildUI()
	HolyStripeHudView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTips = self:getBtn("btnTip")
	self._btnRule = self:getBtn("btnRule")
	self._btnSkill = self:getBtn("btnSkill")
	self._btnInfo = self:getBtn("btnInfo")
	self._txtTime = self:getTxt("time/txt")

	self:_buildHudItem()
end

function HolyStripeHudView:_buildHudItem()
	self._hudItems = {}

	for i = 1, 5 do
		local go = self:getGo("cell" .. i)

		self._hudItems[i] = {
			go = go,
			itemcon1 = goutil.findChild(go, "item_1"),
			itemcon2 = goutil.findChild(go, "item_2"),
			btn = Framework.ButtonAdapter.Get(go),
			txtName = goutil.findChildTextComponent(go, "txtName"),
			txtDesc = goutil.findChildTextComponent(go, "txtDesc"),
			redpointGo = goutil.findChild(go, "redpoint")
		}
	end
end

function HolyStripeHudView:bindEvents()
	HolyStripeHudView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTips:AddClickListener(self._onClickTips, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)

	for i, v in ipairs(self._hudItems) do
		v.btn:AddClickListener(function()
			self:_onClickHudItem(i)
		end)
	end
end

function HolyStripeHudView:unbindEvents()
	HolyStripeHudView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTips:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()

	for i, v in ipairs(self._hudItems) do
		v.btn:RemoveClickListener()
	end
end

function HolyStripeHudView:onEnter()
	HolyStripeHudView.super.onEnter(self)

	if not GameUtil.getUserData(HolyStripeHudView.ReadFlag) then
		UIStateManager.instance:push(ViewName.HolyStripeHudTipView)
		GameUtil.saveUserData(HolyStripeHudView.ReadFlag, true)
	end

	self.skinId = 17001

	self:_onSetHudItemsData()
end

function HolyStripeHudView:onExit()
	HolyStripeHudView.super.onExit(self)

	self.skinId = nil

	for i, item in ipairs(self._hudItems) do
		RedPointController.instance:unregRedPoint(item.redpointGo)
		MaterialMgr.resetAll(item.itemcon1)
		MaterialMgr.resetAll(item.itemcon2)
	end
end

function HolyStripeHudView:_onClickClose()
	self:close()
end

function HolyStripeHudView:_onClickTips()
	UIStateManager.instance:push(ViewName.HolyStripeHudTipView)
end

function HolyStripeHudView:_onClickRule(...)
	UIStateManager.instance:push(ViewName.RulesView, "holystripe_rule")
end

function HolyStripeHudView:_onClickSkill(...)
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, self.skinId)
		end
	end
end

function HolyStripeHudView:_onClickInfo()
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:openPetinfoView(raceId)
		end
	end
end

function HolyStripeHudView:_onClickHudItem(index)
	if self._hudCfgs and self._hudCfgs[index] then
		local cfg = self._hudCfgs[index]

		if cfg.reportBehavior > 0 then
			SurveyController.instance:reportBehavior(cfg.reportBehavior)
		end

		if cfg.jumpFuncId > 0 and FuncOpenModel.instance:getFuncIsOpen(cfg.jumpFuncId) then
			GotoMgr.gotoByString(cfg.jumpFuncIdTo)
		else
			GotoMgr.gotoByString(cfg.jumpTo)
		end
	end
end

function HolyStripeHudView:_onSetHudItemsData()
	self._hudCfgs = HolyStripeConfig.instance:getHudCfgs()

	for i, v in ipairs(self._hudCfgs) do
		local item = self._hudItems[i]

		item.txtName.text = v.name
		item.txtDesc.text = v.desc

		local arr = string.split(v.content, "#")

		MaterialMgr.setCellByCfg(arr[1], item.itemcon1)
		MaterialMgr.setCellByCfg(arr[2], item.itemcon2)
		goutil.setActive(item.redpointGo, false)

		if not string.nilorempty(v.redpointIds) then
			local redIds = string.split(v.redpointIds, "#")

			RedPointController.instance:regRedPoint(item.redpointGo, unpack(redIds))
		else
			RedPointController.instance:unregRedPoint(item.redpointGo)
		end
	end
end

return HolyStripeHudView
