-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooFriendListView.lua

module("logic.extensions.zoo.view.ZooFriendListView", package.seeall)

local ZooFriendListView = class("ZooFriendListView", ViewComponent)
local absorbStateUnavailable = 1
local absorbStateAvailable = 2
local absorbStateContinuing = 3
local absorbStateCompelete = 4

function ZooFriendListView:buildUI()
	ZooFriendListView.super.buildUI(self)

	self._cell = self:getGo("cell")
	self._friendView = ScrollerList.create(self:getGo("friendList/view"), self._cell, GameUtil.handler(self._updateCell, self))
	self._closeBtn = self:getBtn("close")
	self._empty = self:getGo("friendList/empty")
	self._btnGetAbsordPrize = self:getBtn("btnGetAbsordPrize")
end

function ZooFriendListView:bindEvents()
	ZooFriendListView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._btnGetAbsordPrize:AddClickListener(self._onClickGetAbsordPrize, self)
end

function ZooFriendListView:unbindEvents()
	ZooFriendListView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._btnGetAbsordPrize:RemoveClickListener()
end

function ZooFriendListView:onEnter()
	ZooFriendListView.super.onEnter(self)

	self._friendList = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	self:_calculateAbsorbFlag()
	GlobalDispatcher:addListener(GlobalNotify.OnZooGainFriendAbsorbPrize, self._gainAbsorbDevice, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooFriendAbsorbStates, self._getBuddyAbsorbState, self)
	ZooAgent.instance:sendPM_ZooGetBuddyAbsorbStateReq()
end

function ZooFriendListView:onEnterFinished()
	ZooFriendListView.super.onEnterFinished(self)
end

function ZooFriendListView:onExit()
	ZooFriendListView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooGainFriendAbsorbPrize, self._gainAbsorbDevice, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooFriendAbsorbStates, self._getBuddyAbsorbState, self)
	self._friendView:dispose()
	removetimer(self._timer, self)
end

function ZooFriendListView:onExitFinished()
	self._friendView:getView():Travel(self._clearTableview, self)
	ZooFriendListView.super.onExitFinished(self)
end

function ZooFriendListView:_getBuddyAbsorbState(status, msg)
	if status ~= 0 then
		self._friendView:reloadData({})

		return
	end

	self._friendState = {}

	for i, v in ipairs(msg.buddyStates) do
		self._friendState[v.buddyId] = v.beAbsorbed
	end

	self:_refreshAbsorbStates(true)
end

function ZooFriendListView:_calculateAbsorbFlag()
	local myZoo = ZooModel.instance:getMyZoo()

	self._absorbDevice = myZoo:getAbsorbDevice()
	self._placeDeviceFlag = checknumber(self._absorbDevice.absorbBuddyId) > 0
	self._absorbStartTime = self._absorbDevice.absorbStartTime
	self._accumulateTime = self._absorbDevice.absorbAccumulateTime

	local time = ServerTime.now() - self._absorbStartTime + self._accumulateTime

	self._maxAbsorbTime = ZooConfig.instance:getMaxAbsorbTime()
	self._placeComplete = self._placeDeviceFlag and time >= self._maxAbsorbTime
end

function ZooFriendListView:_refreshAbsorbStates(checkTimer)
	local cellData = {}

	for i, friendMo in ipairs(self._friendList) do
		local data = {
			friendMo = friendMo
		}
		local friendId = friendMo:GetId()

		if self._placeDeviceFlag then
			if self._absorbDevice.absorbBuddyId == friendId then
				if self._placeComplete then
					data.state = absorbStateCompelete or absorbStateContinuing
				end
			else
				data.state = absorbStateUnavailable
			end
		elseif self._friendState[friendId] then
			data.state = absorbStateUnavailable or absorbStateAvailable
		end

		table.insert(cellData, data)
	end

	table.sort(cellData, function(a, b)
		return a.state > b.state
	end)
	goutil.setActive(self._empty, #cellData == 0)
	self._friendView:reloadData(cellData)
	removetimer(self._timer, self)

	if checkTimer then
		settimer(1, self._timer, self)
	end

	local myZoo = ZooModel.instance:getMyZoo()

	self._btnGetAbsordPrize.gameObject:SetActive(myZoo:getAbsorbDeviceStatus() == ZooMO.absorbDeviceState_AbaorbMax)
end

function ZooFriendListView:_gainAbsorbDevice(friendId)
	self:_calculateAbsorbFlag()
	self:_refreshAbsorbStates(false)
end

function ZooFriendListView:_updateCell(view, cell, data, tag)
	local friendMo = data.friendMo
	local friendId = friendMo:GetId()
	local name = goutil.findChildTextComponent(cell.gameObject, "name")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local btnText = goutil.findChildTextComponent(btn, "Text")
	local time = goutil.findChildTextComponent(cell.gameObject, "time")

	name.text = friendMo:getValue("name")

	btn:RemoveClickListener()
	HeadItemController.instance:setHeadCell(goutil.findChild(cell.gameObject, "head"), friendMo.headIconId, friendMo.headFrameId, friendMo.vipLv)
	uGuiUtil.setGoGrayState(btn.gameObject, data.state == absorbStateUnavailable)

	if data.state == absorbStateCompelete then
		time.text = lang("petzoo_absorb_compeleted")
		btnText.text = lang("mail_get")

		btn:AddClickListener(function()
			ZooController.instance:sendPM_ZooGainAbsorbDevicePrizeReq(friendId)
		end)
	elseif data.state == absorbStateContinuing then
		local absorbTime = math.min(self._maxAbsorbTime, ServerTime.now() - self._absorbStartTime + self._accumulateTime)

		time.text = string.format(lang("petzoo_absorb_absorbing"), GameUtil.FormatTimeSymbol(absorbTime))
		btnText.text = lang("goto")

		btn:AddClickListener(function()
			ZooSceneController.instance:enterFriendZoo(friendId)
			self:close()
		end)
	elseif data.state == absorbStateAvailable then
		time.text = ""
		btnText.text = lang("goto")

		btn:AddClickListener(function()
			ZooSceneController.instance:enterFriendZoo(friendId)
			self:close()
		end)
	elseif data.state == absorbStateUnavailable then
		time.text = lang("petzoo_absorb_cant")
		btnText.text = lang("goto")

		btn:AddClickListener(function()
			ZooSceneController.instance:enterFriendZoo(friendId)
			self:close()
		end)
	end
end

function ZooFriendListView:_timer()
	local view = self._friendView:getView()
	local cnt = view:GetVisibleCount()
	local viewDatas = self._friendView:getData()

	for i = 0, cnt - 1 do
		local cell = view:GetCellByIndex(i)
		local index = cell.index
		local data = viewDatas[index + 1]

		if data.state == absorbStateContinuing then
			local time = goutil.findChildTextComponent(cell.gameObject, "time")
			local absorbTime = ServerTime.now() - self._absorbStartTime + self._accumulateTime

			if absorbTime >= self._maxAbsorbTime then
				self:_calculateAbsorbFlag()
				self:_refreshAbsorbStates(false)

				break
			end

			time.text = string.format(lang("petzoo_absorb_absorbing"), GameUtil.FormatTimeSymbol(absorbTime))

			break
		end
	end
end

function ZooFriendListView:_clearTableview(cell)
	HeadItemController.instance:resetHeadCell(goutil.findChild(cell.gameObject, "head"))
end

function ZooFriendListView:_onClickGetAbsordPrize()
	ZooController.instance:sendPM_ZooGainAbsorbDevicePrizeReq(0)
end

return ZooFriendListView
