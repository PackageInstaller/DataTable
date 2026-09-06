-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdleTipsView.lua

module("logic.extensions.idlegame.view.IdleTipsView", package.seeall)

local IdleTipsView = class("IdleTipsView", TipsViewBase)

function IdleTipsView:buildUI()
	self._go = self:getGo("tips")
	self._customInput = UICustomInput.Get(self._go)
	self._btnTotalMoney = self:getBtn("righttop/btnTotalMoney")
	self._btnBin = self:getBtn("leftbom/btnBin")
	self._btnSpeed = self:getBtn("righttop/btnSpeed")
	self._btnCapacity = self:getBtn("righttop/btnCapacity")

	self._btnBin:AddClickListener(function()
		self:_onClickBin(1, self._btnBin)
	end, self)
	self._btnTotalMoney:AddClickListener(function()
		self:_onClickBin(2, self._btnTotalMoney)
	end, self)
	self._btnSpeed:AddClickListener(function()
		self:_onClickBin(3, self._btnSpeed)
	end, self)
	self._btnCapacity:AddClickListener(function()
		self:_onClickBin(4, self._btnCapacity)
	end, self)

	self._imgTips = goutil.findChildComponent(self._go, "img", "RectTransform")
	self._txtTips = goutil.findChildComponent(self._go, "txtTips", "Text")
end

function IdleTipsView:destroyUI()
	self._customInput = nil
end

function IdleTipsView:onEnter()
	self._go:SetActive(false)
	self._customInput:AddListener(self._onCustomInputCallback, self)

	if TipsViewBase.tipsPosition then
		self._go.transform.localPosition = TipsViewBase.tipsPosition
		TipsViewBase.tipsPosition = nil
	end
end

function IdleTipsView:_onCustomInputCallback(hover)
	if not hover then
		self._go:SetActive(false)
	end
end

local textTips = {
	"将小诺拖动到此处可售出小诺获得少许萌值",
	"当前拥有萌值",
	"所有放置在空地上的小诺每秒产出的萌值数量\n（功能打开时收益翻倍；离线收益最多累积12个小时）",
	"最多可同时放置12只小诺"
}

function IdleTipsView:_onClickBin(index, btn)
	self._txtTips.text = textTips[index]

	self._go:SetActive(true)

	local rectGo = self._go:GetComponent("RectTransform")

	rectGo.pivot = index == 1 and Vector2.New(0, 0) or Vector2.New(1, 1)

	local scale = index == 1 and -1 or 1

	Framework.TransformUtil.SetLocalScale(self._imgTips.transform, scale, scale, 1)

	local x, y, z = Framework.TransformUtil.GetPos(btn.transform, 0, 0, 0)
	local rect = btn.gameObject:GetComponent("RectTransform")

	Framework.TransformUtil.SetPos(self._go.transform, x, y, z)

	x, y, z = Framework.TransformUtil.GetLocalPos(self._go.transform, 0, 0, 0)

	if index == 1 then
		y = y + rect.sizeDelta.y * 0.5
		x = x - rect.sizeDelta.x * 0.5
	else
		y = y - rect.sizeDelta.y * 0.5
		x = x + rect.sizeDelta.x * 0.5
	end

	print(self._imgTips.rect.xMin, self._imgTips.rect.xMax, self._imgTips.rect.yMin, self._imgTips.rect.yMax)
	Framework.TransformUtil.SetLocalPos(self._go.transform, x, y, z)
end

return IdleTipsView
