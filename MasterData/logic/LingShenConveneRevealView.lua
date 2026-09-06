-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/view/LingShenConveneRevealView.lua

module("logic.extensions.lingshenconvene.view.LingShenConveneRevealView", package.seeall)

local LingShenConveneRevealView = class("LingShenConveneRevealView", ViewComponent)

function LingShenConveneRevealView:ctor()
	LingShenConveneRevealView.super.ctor(self)
end

function LingShenConveneRevealView:unbindEvents()
	LingShenConveneRevealView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LingShenConveneRevealView:bindEvents()
	LingShenConveneRevealView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function LingShenConveneRevealView:buildUI()
	LingShenConveneRevealView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGoTab = self:getGo("tabCol/cell")
	local tabGoTab = self:getGo("tabCol/tableview")

	self._tableviewTab = ScrollerList.create(tabGoTab, cellGoTab, GameUtil.handler(self._updateCellTab, self), GameUtil.handler(self._clearCellTab, self))
	self._prizeCom = self:getGo("prizeCom")
	self._showDetail = self:getGo("showDetail")
	self._iconShow = self:getGo("showDetail/icon")
	self._txtDesc = self:getTxt("showDetail/txtDesc")
	self._txtName = self:getTxt("showDetail/txtName")
	self._txtTips = self:getTxt("txtTips")
end

function LingShenConveneRevealView:onExit()
	LingShenConveneRevealView.super.onExit(self)
	self._tableviewTab:dispose()
	MaterialMgr.resetAll(self._prizeCom)
	uGuiUtil.clearImage(self._iconShow)

	if self._cellEffects then
		for _, eff in pairs(self._cellEffects) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._cellEffects = {}
end

function LingShenConveneRevealView:onEnter()
	LingShenConveneRevealView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	local openTabId = checknumber(params[2])

	self:_updateUIByCfg()

	self._curTabId = nil

	self:_switchTab(openTabId)
	self.addGEvent(self, GlobalNotify.LingShenConveneeGainPrizeRes, self._updateUIByInfo, self)
end

function LingShenConveneRevealView:_updateUIByCfg()
	self._revealCfgs = LingShenConveneConfig.instance:getRevealCfgs(self._activityId)
	self._curProgress = LingShenConveneModel.instance:getUnlockProgress(self._activityId)

	self._tableviewTab:reloadData(self._revealCfgs or {})
end

function LingShenConveneRevealView:_switchTab(tabId)
	if self._curTabId ~= tabId then
		self._curTabId = tabId

		self:_updateUIByInfo()
	end
end

function LingShenConveneRevealView:_updateUIByInfo()
	self._tableviewTab:refresh()

	local showCfg = self._revealCfgs[self._curTabId]
	local isGainPrize = LingShenConveneModel.instance:getIsHasGainRevealPrize(self._activityId, self._curTabId)
	local isMatch = self._curProgress >= showCfg.unlockCount

	goutil.setActive(self._prizeCom, not isGainPrize)
	goutil.setActive(self._showDetail, isGainPrize)
	goutil.setActive(self._txtTips.gameObject, not isGainPrize)

	self._txtTips.text = langPara("累计激活%s个领神资料，可解锁本条揭秘内容，并且领取下列奖励", showCfg.unlockCount)

	if isGainPrize then
		uGuiUtil.clearImage(self._iconShow)

		if not GameUtil.isEmptyString(showCfg.iconPath) then
			local path = GameUrl.getItemIconUrl(showCfg.iconPath)

			uGuiUtil.setSpriteToImage(self._iconShow, uGuiUtil.SpriteType.BigBg, path)
		end

		self._txtDesc.text = showCfg.detailDesc
		self._txtName.text = showCfg.tabTips
	else
		if self._cellEffects then
			for _, eff in pairs(self._cellEffects) do
				UIEffectManager.instance:stopEffect(eff)
			end
		end

		self._cellEffects = {}

		MaterialMgr.resetAll(self._prizeCom)

		local proxyList = MaterialMgr.setCellListByCfg(showCfg.prize, self._prizeCom) or {}

		for _, proxy in ipairs(proxyList) do
			if proxy and isMatch then
				proxy.binder:setAutoTips(false)
				proxy.binder:setCallBack(function()
					LingShenConveneController.instance:sendPM_LingShenConveneGainPrizeReq(self._activityId, self._curTabId)
				end)

				local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
				local uiEffect = UIEffectManager.instance:playEffect(self, effPath, proxy.view.transform, 0, 0, true, false, nil, function(target, eff)
					eff:setClipping(self.mainGO.transform)
				end)

				uiEffect:setParent(proxy.view.transform)
				uiEffect:setLocalPos(0, 0, 0)
				uiEffect:setScaleXYZ(1, 1, 1)

				self._cellEffects = self._cellEffects or {}
				self._cellEffects[proxy.view] = uiEffect
			end
		end
	end
end

function LingShenConveneRevealView:_updateCellTab(view, cellGo, data)
	local cell = self:_clearCellTab(cellGo)

	cell.txtName.text = data.tabTips

	goutil.setActive(cell.redPoint, not LingShenConveneModel.instance:getIsHasGainRevealPrize(self._activityId, data.prizeId) and self._curProgress >= data.unlockCount)
	cell.changeGroup:SetState(data.prizeId == self._curTabId and 0 or 1)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._switchTab, self, data.prizeId))
end

function LingShenConveneRevealView:_clearCellTab(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.redPoint = goutil.findChild(cell.go, "redPoint")
	cell.changeGroup = cell.go:GetComponent("UIChangeGroup")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")

	GameUtil.rmClickHandler(cell.go)

	return cell
end

return LingShenConveneRevealView
