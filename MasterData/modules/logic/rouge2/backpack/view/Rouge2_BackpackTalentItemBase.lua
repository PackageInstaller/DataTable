-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentItemBase.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentItemBase", package.seeall)

local Rouge2_BackpackTalentItemBase = class("Rouge2_BackpackTalentItemBase", LuaCompBase)

function Rouge2_BackpackTalentItemBase:ctor(parentView)
	Rouge2_BackpackTalentItemBase.super.ctor(self)

	self._parentView = parentView
end

function Rouge2_BackpackTalentItemBase:init(go)
	self.go = go
	self._tran = self.go:GetComponent(gohelper.Type_RectTransform)
	self._tranParent = self._tran.parent
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._goConnectPoint = gohelper.create2d(self.go, "go_ConnectPoint")
	self._tranConnectPoint = self._goConnectPoint:GetComponent(gohelper.Type_RectTransform)
	self._lineItemTab = self:getUserDataTb_()
	self._connectPos = Vector2()
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click", AudioEnum.Rouge2.ClickTalenet)
	self._goClick = self._btnClick.gameObject
end

function Rouge2_BackpackTalentItemBase:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectSkillTalent, self._onSelectSkillTalent, self)
end

function Rouge2_BackpackTalentItemBase:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BackpackTalentItemBase:_btnClickOnClick()
	return
end

function Rouge2_BackpackTalentItemBase:onUpdateMO(talentCo)
	self:refreshInfo(talentCo)
	self:refreshPos()
	self:connect()
	self:refreshStatus()
end

function Rouge2_BackpackTalentItemBase:hide()
	gohelper.setActive(self.go, false)
end

function Rouge2_BackpackTalentItemBase:show()
	self:onSelect(false)
	gohelper.setActive(self.go, true)
end

function Rouge2_BackpackTalentItemBase:refreshInfo(talentCo)
	self._talentCo = talentCo
	self._talentId = self._talentCo.talentId
	self._keys = self._talentCo.keys
	self._talentName = self._talentCo.name
	self._position = string.splitToNumber(self._talentCo.position, "#")

	if self._position then
		self._positionNum = #self._position or 0
	end

	self.go.name = string.format("talent_%s", self._talentId)
end

function Rouge2_BackpackTalentItemBase:refreshStatus()
	local status = Rouge2_BackpackModel.instance:getTalentStatus(self._talentId)

	self._preStatus = self._status or status
	self._status = status

	self:refreshUI()
	self:playAnim()
end

function Rouge2_BackpackTalentItemBase:refreshUI()
	return
end

function Rouge2_BackpackTalentItemBase:refreshPos()
	if self._positionNum < 2 then
		logError(string.format("肉鸽天赋点坐标配置格式错误 position = %s", self._talentCo.position))
	end

	recthelper.setAnchor(self._tran, self._position[1] or 0, self._position[2] or 0)
end

function Rouge2_BackpackTalentItemBase:connect()
	self:recycleAllLines()

	if string.nilorempty(self._keys) then
		return
	end

	local keyIdList = string.splitToNumber(self._keys, "#")

	for _, keyId in ipairs(keyIdList) do
		local preTalentItem = self._parentView:getTalentItemById(keyId)

		if preTalentItem then
			local lineItem = self._parentView:getLineItem()

			lineItem:connect(preTalentItem, self)
		end
	end
end

function Rouge2_BackpackTalentItemBase:getConnectTran()
	return self._tranConnectPoint
end

function Rouge2_BackpackTalentItemBase:getItemPos()
	return recthelper.getAnchor(self._tran)
end

function Rouge2_BackpackTalentItemBase:getConnectPos()
	local posX, posY = recthelper.rectToRelativeAnchorPos2(self._tran.position, self._tranParent)

	self._connectPos:Set(posX, posY)

	return self._connectPos
end

function Rouge2_BackpackTalentItemBase:recycleAllLines()
	if self._lineItemTab then
		if not #self._lineItemTab then
			local lineNum = 0

			for i = lineNum, 1, -1 do
				local lineItem = self._lineItemTab[i]

				self._parentView:recycleLineItem(lineItem)
				table.remove(self._lineItemTab, i)
			end
		end
	end
end

function Rouge2_BackpackTalentItemBase:getTalentId()
	return self._talentId
end

function Rouge2_BackpackTalentItemBase:getViewGO()
	return self._goClick
end

function Rouge2_BackpackTalentItemBase:_onSelectSkillTalent(talentId)
	self:onSelect(self._talentId == talentId)
end

function Rouge2_BackpackTalentItemBase:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_BackpackTalentItemBase:_onUpdateRougeInfo()
	self:refreshStatus()
end

function Rouge2_BackpackTalentItemBase:playAnim()
	if self._preStatus == self._status then
		return
	end

	if self._status == Rouge2_Enum.BagTalentStatus.Lock then
		self:playLockAnim()
	elseif self._status == Rouge2_Enum.BagTalentStatus.UnlockNotActive then
		if self._preStatus ~= Rouge2_Enum.BagTalentStatus.UnlockCanActive then
			self:playUnlockCanActiveAnim()
		end
	elseif self._status == Rouge2_Enum.BagTalentStatus.UnlockCanActive then
		if self._preStatus ~= Rouge2_Enum.BagTalentStatus.UnlockNotActive then
			self:playUnlockNotActiveAnim()
		end
	elseif self._status == Rouge2_Enum.BagTalentStatus.Active then
		self:playActiveAnim()
	end
end

function Rouge2_BackpackTalentItemBase:playLockAnim()
	return
end

function Rouge2_BackpackTalentItemBase:playUnlockNotActiveAnim()
	return
end

function Rouge2_BackpackTalentItemBase:playUnlockCanActiveAnim()
	return
end

function Rouge2_BackpackTalentItemBase:playActiveAnim()
	return
end

function Rouge2_BackpackTalentItemBase:tryOpenDetailView()
	if self._isSelect then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectSkillTalent, self._talentId)
	ViewMgr.instance:openView(ViewName.Rouge2_BackpackTalentDetailView, {
		talentId = self._talentId
	})
end

function Rouge2_BackpackTalentItemBase:getClickGO()
	return self._goClick
end

return Rouge2_BackpackTalentItemBase
