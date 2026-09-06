-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopTabItem.lua

module("logic.extensions.pay.view.PayShopTabItem", package.seeall)

local PayShopTabItem = class("PayShopTabItem")

function PayShopTabItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:onEnter()
end

function PayShopTabItem:OnDestroy()
	self:onExit()
end

function PayShopTabItem:buildUI()
	local imgBg = goutil.findChild(self.mainGO, "imgBg")
	local imgsmallBg = goutil.findChild(self.mainGO, "imgSmallBg")

	self.okBtn = GameUtil.asBtn(imgBg)
	self.smallOkBtn = GameUtil.asBtn(imgsmallBg)
	self.imgChange = imgBg:GetComponent(ComponentType.UIImageSpriteChange)
	self.imgSmallChange = imgsmallBg:GetComponent(ComponentType.UIImageSpriteChange)

	local txtGo = goutil.findChild(self.mainGO, "text")

	self._txtColorChange = txtGo:GetComponent(ComponentType.UITextColorChange)
	self.nameText = txtGo:GetComponent(goutil.Type_UIText)
	self.dot = goutil.findChild(self.mainGO, "dot")
	self.line = goutil.findChild(self.mainGO, "line")
end

function PayShopTabItem:onEnter()
	self.okBtn:AddClickListener(self.onClickBtn, self)
	self.smallOkBtn:AddClickListener(self.onClickBtn, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdatePayShopRedDot, self._updateRedDot, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedDot, self)
	GlobalDispatcher:addListener(PayShopModel.GetAllPayShopBuyTimesRes, self.checkRedDot, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self.checkRedDot, self)
end

function PayShopTabItem:onExit()
	self.okBtn:RemoveClickListener()
	self.smallOkBtn:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.UpdatePayShopRedDot, self._updateRedDot, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedDot, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self.checkRedDot, self)
	GlobalDispatcher:removeListener(PayShopModel.GetAllPayShopBuyTimesRes, self.checkRedDot, self)
end

function PayShopTabItem:setData(firTabId, cfg, selected, cliclCall, refTarget, isRoot)
	self.firTabId = firTabId
	self._cfg = cfg
	self.selected = selected
	self.cliclCall = cliclCall
	self.refTarget = refTarget
	self._isRoot = isRoot

	self:initView()
end

function PayShopTabItem:initView()
	local state = self.selected and 1 or 0

	self.imgChange:SetState(state)
	self.imgSmallChange:SetState(state)

	if not self._isRoot then
		self._txtColorChange:SetState(self.selected and 3 or 2)
	else
		self._txtColorChange:SetState(self.selected and 1 or 0)
	end

	self.nameText.fontSize = self._isRoot and 26 or 24
	self.nameText.text = self._cfg.name

	GameUtil.SetActive(self.okBtn, self._isRoot)
	GameUtil.SetActive(self.smallOkBtn, not self._isRoot)
	self:checkRedDot()
end

function PayShopTabItem:onClickBtn()
	if self.cliclCall then
		if self.refTarget then
			self.cliclCall(self.refTarget)
		else
			self.cliclCall()
		end
	end
end

function PayShopTabItem:checkRedDot()
	local dot = false

	if self._cfg.redPointIds then
		for i, rid in ipairs(self._cfg.redPointIds) do
			dot = RedPointModel.instance:isActive(rid)

			if self._isRoot then
				local tabCfgs = PayShopModel.instance:getLevel3TabCfgs(self._cfg.type, self._cfg.id)

				for k, v in pairs(tabCfgs) do
					dot = PayShopModel.instance:chechkFreeGoodsRedDotByShowType(checknumber(v.param))

					if dot then
						break
					end
				end
			elseif dot and checknumber(rid) == RedPointModel.ID_PAYSHOPMIBAO then
				dot = PayShopModel.instance:chechkFreeGoodsRedDotByShowType(checknumber(self._cfg.param))
			end

			if dot then
				break
			end
		end
	end

	goutil.setActive(self.dot, dot)
end

function PayShopTabItem:_updateRedDot(firTabId)
	if not firTabId or self.firTabId == firTabId then
		self:checkRedDot()
	end
end

return PayShopTabItem
