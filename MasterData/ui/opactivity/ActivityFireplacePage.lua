-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityFireplacePage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityFirePlaceRewardPool = require("ClientData/ResOpActivityFirePlaceRewardPool")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local FireplaceCell = Class("FireplaceCell", UIControls.Panel)

function FireplaceCell:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onBtnClick)

	self.imgNew = UIControls.Panel(self, self.mPath .. "/RedNode")
	self.txtDesc = UIControls.Label(self, self.mPath .. "/TextDes")
	self.txtProgress = UIControls.Label(self, self.mPath .. "/TextDes/TextNub")
	self.imgSel = UIControls.Image(self, self.mPath .. "/Background/Checkmark")

	if UIControls.checkControlFunc(self, self.mPath .. "/ItemNode") then
		self.itemNode = UIControls.Button(self, self.mPath .. "/ItemNode")

		self.itemNode:addEventClick(self.onitemClick)

		self.txtNum = UIControls.Label(self, self.mPath .. "/ItemNode/Text")
	end
end

function FireplaceCell:setData(data, state, roleData)
	self.data = data
	self.index = data.index
	self.state = state

	self.imgNew:setVisible(state == 1)

	local gotTime = roleData and roleData.times or 0
	local canGetTime = data.get_limit

	self.txtDesc:setText(data.desc)
	self.txtProgress:setText(string.format("(%d/%d)", gotTime, canGetTime))

	if canGetTime <= gotTime then
		self.txtProgress:setFontColor(ResColor.RED)
	end

	if self.itemNode then
		local point = roleData and roleData.point or 0

		if not self.item then
			local obj = BaseObject.GetObject(data.concern_item, 1)

			self.item = UIControls.getGridAwardContainer(self, self.mPath .. "/ItemNode")

			self.item:setObj(obj)
			self.item:setVisible(true)
		end

		if canGetTime <= point / data.get_need_point + gotTime then
			self.txtNum:setText(Lang.get(30614))
		else
			self.txtNum:setText(string.format(Lang.get(30615), data.get_need_point - point % data.get_need_point))
		end
	end
end

function FireplaceCell:onSelected(isSel)
	self.imgSel:setVisible(isSel)
end

function FireplaceCell:onBtnClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

function FireplaceCell:onitemClick()
	if self.item then
		self.item.grid:openTipsPanel()
	end
end

local fpAward = Class("fpAward", UIControls.Child)

function fpAward:ctor()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onClick)

	self.imgSel = UIControls.Panel(self, "Checkmark")
	self.imgGot = UIControls.Panel(self, "AwardCheck")
	self.imgMask = UIControls.Panel(self, "Img")
	self.item = nil
end

function fpAward:setData(index, id, state, awardState)
	self.index = index

	if self.item then
		self.item:destroy()

		self.item = nil
	end

	local awardData = ResRandClient[id]
	local obj = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

	self.item = UIControls.getGridAwardContainer(self, "ItemNode")
	self.item.mDisableWays = true

	self.item:setObj(obj)
	self.item:setVisible(true)
	self.imgGot:setVisible(awardState == 1)

	local btnEnable = awardState ~= 1 and state == 1

	self.imgMask:setVisible(btnEnable)
	self.btn:setEnable(btnEnable)
end

function fpAward:setSel(isSel)
	self.imgSel:setVisible(isSel)
	self.imgMask:setVisible(not isSel)
	self.btn:setEnable(not isSel)
end

function fpAward:onClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local FireplaceAwardPanel = Class("FireplaceAwardPanel", UIControls.Panel)

function FireplaceAwardPanel:ctor()
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnConfirm")
	self.btnNew = UIControls.Panel(self, self.mPath .. "/BtnConfirm/IconNew")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.items = {}
end

function FireplaceAwardPanel:setData(sender)
	local state = sender.state
	local poolId = sender.data.reward_pool
	local awards = ResOpActivityFirePlaceRewardPool[poolId]

	if self.curSelIndex then
		self.items[self.curSelIndex]:setSel(false)

		self.curSelIndex = nil
	end

	self.btnConfirm:setEnable(state == 1)
	self.btnNew:setVisible(state == 1)
	self:setItems(sender.data, state, awards)

	if state == 1 and #awards == 1 then
		self:onItemClick(self.items[1])
	end
end

function FireplaceAwardPanel:setItems(data, state, awards)
	local awarded = self.mParent.actData.awards[data.index]

	for i = #self.items + 1, #awards do
		self.items[i] = fpAward(self, self.mPath, "System/Activity/ActivityChristmas/ChristmasAwaedItem")
		self.items[i].mEventClick = Slot(self.onItemClick, self)
	end

	for j = 1, #self.items do
		if awards[j] then
			local awardState = 0

			if awarded and awarded[j] then
				awardState = 1
			end

			self.items[j]:setVisible(true)
			self.items[j]:setData(j, awards[j].reward_id, state, awardState)
		else
			self.items[j]:setVisible(false)
		end
	end
end

function FireplaceAwardPanel:onConfirmClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

function FireplaceAwardPanel:onItemClick(sender)
	if self.curSelIndex then
		self.items[self.curSelIndex]:setSel(false)
	end

	self.curSelIndex = sender.index

	sender:setSel(true)
end

local strClassName = "ActivityFireplacePage"
local ActivityFireplacePage = Class(strClassName, UIControls.Child)

MixinClass(ActivityFireplacePage, ActivityPanelMixin)

local ANI_UP = "ChristmasPanel01Open"
local ANI_DOEN = "ChristmasPanel01Close"
local ANI_REFRESH = "ChristmasPanel01Award"

function ActivityFireplacePage:ctor()
	self.cells = {}
	self.isOnAwardOpen = false
end

function ActivityFireplacePage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textRule = UIControls.Label(self, "Bg/BgImage/TipsText")
	self.awardPanel = FireplaceAwardPanel(self, "AwardNode")
	self.awardPanel.mEventClick = Slot(self.onConfirmClick, self)
	self.uiAni = UIControls.UIAni(self, "")

	if not (#self.cells > 0) then
		for i = 1, 3 do
			self.cells[i] = FireplaceCell(self, "Bg/SockNode/CardList0" .. i)
			self.cells[i].mEventClick = Slot(self.onCellClick, self)
		end
	end
end

function ActivityFireplacePage:_setData()
	self.actData = self.actObj.actData

	local clientData = self.actData.detailData

	for i, cell in ipairs(self.cells) do
		if clientData[i] then
			local state = self.actData:getState(i)

			cell:setData(clientData[i], state, self.actData.roleData[i])
		end
	end

	if self.curSelIndex then
		self.cells[self.curSelIndex]:onSelected(false)
		self.uiAni:startAni(ANI_DOEN)

		self.curSelIndex = nil
	end

	if self.isOnAwardOpen then
		self.awardPanel:setVisible(false)

		self.isOnAwardOpen = false
	end
end

function ActivityFireplacePage:onCellClick(sender)
	if self.curSelIndex then
		self.cells[self.curSelIndex]:onSelected(false)

		if self.curSelIndex == sender.index then
			self.awardPanel:setVisible(false)

			self.isOnAwardOpen = false

			self.uiAni:startAni(ANI_DOEN)

			self.curSelIndex = nil

			return
		end

		self.curSelIndex = nil
	end

	sender:onSelected(true)

	if self.isOnAwardOpen then
		self.uiAni:startAni(ANI_REFRESH)
	else
		self.uiAni:startAni(ANI_UP)
	end

	self.awardPanel:setVisible(true)

	self.isOnAwardOpen = true

	self.awardPanel:setData(sender)

	self.curSelIndex = sender.index
end

function ActivityFireplacePage:onConfirmClick(sender)
	if not sender.curSelIndex then
		MsgManager.notice(Lang.get(30616))
	else
		CurAvatar:activityRPC(Functor(RPC.opactFirePlaceGetAward, self.actObj.opId, self.curSelIndex, sender.curSelIndex), self.actObj.opId)
		self.awardPanel:setVisible(false)

		self.isOnAwardOpen = false
	end
end

function ActivityFireplacePage:onActivityDataRefresh(actObj)
	self:_setData()
end

function ActivityFireplacePage:_onShow(isOnPageShow)
	self:_setData()
end

function ActivityFireplacePage:_onLeavePage()
	if self.curSelIndex then
		self.cells[self.curSelIndex]:onSelected(false)

		self.curSelIndex = nil

		self.awardPanel:setVisible(false)

		self.isOnAwardOpen = false

		self.uiAni:startAni(ANI_DOEN)
	end
end

return ActivityFireplacePage
