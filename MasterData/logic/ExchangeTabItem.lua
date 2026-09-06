-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/view/ExchangeTabItem.lua

module("logic.extensions.exchange.view.ExchangeTabItem", package.seeall)

local ExchangeTabItem = class("ExchangeTabItem")

function ExchangeTabItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:onEnter()
end

function ExchangeTabItem:OnDestroy()
	self:onExit()
end

function ExchangeTabItem:buildUI()
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

function ExchangeTabItem:onEnter()
	self.okBtn:AddClickListener(self.onClickBtn, self)
	self.smallOkBtn:AddClickListener(self.onClickBtn, self)
end

function ExchangeTabItem:onExit()
	self.okBtn:RemoveClickListener()
	self.smallOkBtn:RemoveClickListener()
end

function ExchangeTabItem:setData(firTabId, cfg, selected, cliclCall, refTarget, isRoot)
	self.firTabId = firTabId
	self._cfg = cfg
	self.selected = selected
	self.cliclCall = cliclCall
	self.refTarget = refTarget
	self._isRoot = isRoot

	self:_initView()
end

function ExchangeTabItem:_initView()
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

function ExchangeTabItem:onClickBtn()
	if self.cliclCall then
		if self.refTarget then
			self.cliclCall(self.refTarget)
		else
			self.cliclCall()
		end
	end
end

function ExchangeTabItem:checkRedDot()
	local dot = false

	if self._cfg.redPointIds then
		for i, rid in ipairs(self._cfg.redPointIds) do
			dot = RedPointModel.instance:isActive(rid)

			if dot then
				break
			end
		end
	end

	goutil.setActive(self.dot, dot)
end

return ExchangeTabItem
