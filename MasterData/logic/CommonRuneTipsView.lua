-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonRuneTipsView.lua

module("logic.extensions.common.instruction.view.CommonRuneTipsView", package.seeall)

local CommonRuneTipsView = class("CommonRuneTipsView", ViewComponent)

function CommonRuneTipsView:ctor()
	CommonRuneTipsView.super.ctor(self)
end

function CommonRuneTipsView:destroyUI()
	CommonRuneTipsView.super.destroyUI(self)
end

function CommonRuneTipsView:onExitFinished()
	CommonRuneTipsView.super.onExitFinished(self)
end

function CommonRuneTipsView:onEnterFinished()
	CommonRuneTipsView.super.onEnterFinished(self)
end

function CommonRuneTipsView:unbindEvents()
	CommonRuneTipsView.super.unbindEvents(self)
	self._btnLock:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
end

function CommonRuneTipsView:bindEvents()
	CommonRuneTipsView.super.bindEvents(self)
	self._btnLock:AddClickListener(function()
		self:_onClickLock(true)
	end)
	self._btnUnlock:AddClickListener(function()
		self:_onClickLock(false)
	end)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CommonRuneTipsView:onExit()
	CommonRuneTipsView.super.onExit(self)
end

function CommonRuneTipsView:buildUI()
	CommonRuneTipsView.super.buildUI(self)

	self._Nego_Content = self:getGo("Nego_Content")
	self._customInput = UICustomInput.Get(self._Nego_Content)

	local Nego_Top = goutil.findChild(self._Nego_Content, "Nego_Top")

	self._runeCell = RuneBaseCell.New(Nego_Top)
	self._btnLock = Framework.ButtonAdapter.GetFrom(Nego_Top, "btnLock")
	self._btnUnlock = Framework.ButtonAdapter.GetFrom(Nego_Top, "btnUnlock")
	self._btns = {}

	for i = 1, 2 do
		local btn = {}
		local go = goutil.findChild(self._Nego_Content, "Nego_Bottom/btns/" .. i)

		btn.mainGO = go
		btn.button = Framework.ButtonAdapter.Get(go)

		btn.button:AddClickListener(function()
			self:_onClickButton(i)
		end)

		btn.txt = goutil.findChildTextComponent(go, "Text")

		table.insert(self._btns, btn)
	end

	local Nego_Middle = goutil.findChild(self._Nego_Content, "Nego_Middle")
	local attrItem = goutil.findChild(Nego_Middle, "item_attr_1")

	self._attrs = ItemGroup.New(Nego_Middle, attrItem)
end

function CommonRuneTipsView:onEnter()
	CommonRuneTipsView.super.onEnter(self)

	local params = self:getOpenParam()
	local pos = params[2]

	self._callbacks = params[3] or {}
	self._mo = params[1]

	Framework.TransformUtil.SetPos(self._Nego_Content.transform, pos[1], pos[2], pos[3])
	self:_onClickLock(self._mo.isLocked == true)

	for i = 1, 2 do
		local btn = self._btns[i]

		goutil.setActive(btn.mainGO, i <= #self._callbacks)

		if i <= #self._callbacks then
			btn.txt.text = self._callbacks[i].btnText
		end
	end

	self._runeCell:onSetMo(self._mo.runeDefineId, self._mo.level)

	local attrs = RuneConfig.instance:getRuneAttrs(self._mo.runeDefineId, self._mo.level)

	print("attrs == nil" .. tostring(attrs == nil))
	self._attrs:updateWithMoMap(attrs, function(item, key, value)
		local txtName = goutil.findChildComponent(item.mainGO, "txtName", "Text")
		local txtDesc = goutil.findChildComponent(item.mainGO, "txtDesc", "Text")

		txtName.text = ConstString.langAttr(key)

		if string.find(key, "率") then
			value = checknumber(value) * 100 .. "%"
		end

		txtDesc.text = "+" .. value
	end)
end

function CommonRuneTipsView:_onClickLock(isLock)
	goutil.setActive(self._btnLock.gameObject, not isLock)
	goutil.setActive(self._btnUnlock.gameObject, isLock)
end

function CommonRuneTipsView:_onClickButton(i)
	if i <= #self._callbacks then
		self._callbacks[i].btnCall()
	end
end

function CommonRuneTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return CommonRuneTipsView
