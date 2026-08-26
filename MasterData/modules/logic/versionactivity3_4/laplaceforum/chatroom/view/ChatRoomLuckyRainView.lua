-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomLuckyRainView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomLuckyRainView", package.seeall)

local ChatRoomLuckyRainView = class("ChatRoomLuckyRainView", BaseView)

function ChatRoomLuckyRainView:onInitView()
	self._gonodelucyrain = gohelper.findChild(self.viewGO, "node_lucyrain")
	self._gorainitem = gohelper.findChild(self.viewGO, "node_lucyrain/#go_lucyrain")
	self._gostartroot = gohelper.findChild(self.viewGO, "root")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txtcount1 = gohelper.findChildText(self.viewGO, "#go_time/#go_TimeBG1/#txt_num_countdown")
	self._txtcount2 = gohelper.findChildText(self.viewGO, "#go_time/#go_TimeBG2/#txt_num_countdown")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomLuckyRainView:addEvents()
	return
end

function ChatRoomLuckyRainView:removeEvents()
	return
end

function ChatRoomLuckyRainView:_editableInitView()
	self._creatTimes = 0
	self._rainCount = 0
	self._getCount = 0
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	self._rainItems = self:getUserDataTb_()
	self._timeAnim = self._gotime:GetComponent(typeof(UnityEngine.Animator))
	self._noderainAni = self._gonodelucyrain:GetComponent(typeof(UnityEngine.Animation))
	self._limitTime = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.LuckyRainLastTime, true)

	gohelper.setActive(self._gorainitem, false)
	gohelper.setActive(self._gotime, false)
	NavigateMgr.instance:addEscape(self.viewName, self._btnCloseOnClick, self)
	TaskDispatcher.runDelay(self._startLuckyRain, self, 6)
end

function ChatRoomLuckyRainView:_btnCloseOnClick()
	return
end

function ChatRoomLuckyRainView:_startLuckyRain()
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_creatRainItem()
	gohelper.setActive(self._gotime, true)
	gohelper.setActive(self._gostartroot, false)

	local interverTime = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.LuckyRainInterverTime, true)

	TaskDispatcher.runRepeat(self._creatRainItem, self, interverTime)
end

local rainPos = {
	-800,
	-400,
	0,
	400,
	800
}

function ChatRoomLuckyRainView:_creatRainItem()
	self._creatTimes = self._creatTimes + 1

	local rainCount = self:_getRainTimesCount(self._creatTimes)
	local randomList = ChatRoomLuckyRainView.getRandomList(1, 4, rainCount)

	for i = 1, rainCount do
		self._rainCount = self._rainCount + 1

		if not self._rainItems[self._rainCount] then
			self._rainItems[self._rainCount] = ChatRoomLuckyRainItem.New()

			local go = gohelper.cloneInPlace(self._gorainitem, self._rainCount)

			self._rainItems[self._rainCount]:init(go)
		end

		local randomIndex = randomList[i]
		local posX = math.random(rainPos[randomIndex] + 80, rainPos[randomIndex + 1] - 80)

		self._rainItems[self._rainCount]:setPosX(posX)
		self._rainItems[self._rainCount]:setSelectCallback(self._onItemSelected, self, self._rainCount)
		self._rainItems[self._rainCount]:setFinishCallback(self._onItemFinished, self, self._rainCount)
	end
end

function ChatRoomLuckyRainView.getRandomList(startIndex, endIndex, count)
	local numbers = {}

	for i = startIndex, endIndex do
		table.insert(numbers, i)
	end

	local result = {}

	for i = 1, count do
		local index = math.random(#numbers)

		table.insert(result, table.remove(numbers, index))
	end

	return result
end

function ChatRoomLuckyRainView:_onItemSelected(index)
	self._getCount = self._getCount + 1

	if self._rainItems[index] then
		self._rainItems[index]:playSelect()
	end
end

function ChatRoomLuckyRainView:_onItemFinished(index)
	if self._rainItems[index] then
		self._rainItems[index]:destroy()

		self._rainItems[index] = nil
	end
end

function ChatRoomLuckyRainView:_getRainTimesCount(times)
	local rainStr = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.LuckyRainBatchCount, true)
	local rainCos = string.split(rainStr, "|")

	for i = 1, #rainCos do
		local batchs = string.splitToNumber(rainCos[i], "#")

		if times >= batchs[1] and times <= batchs[2] then
			local index = math.random(batchs[3], batchs[4])
			local value = batchs[3] + (index - batchs[3]) / (batchs[4] - batchs[3])

			return math.floor(value + 0.5)
		end
	end

	return 1
end

function ChatRoomLuckyRainView:_refreshTimeTick()
	self._txtcount1.text = string.format("00:%02d", self._limitTime)
	self._txtcount2.text = string.format("00:%02d", self._limitTime)

	if self._limitTime < 10 then
		self._timeAnim:Play("switch")
	end

	if self._limitTime <= 5 and not self._hasPlayed then
		AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.play_ui_bulaochun_yy_hb543)

		self._hasPlayed = true
	end

	if self._limitTime <= 0 then
		Activity225Rpc.instance:sendAct225RedEnvelopeRainSettleRequest(self._actId, self._getCount)
		TaskDispatcher.cancelTask(self._refreshTimeTick, self)
		self:closeThis()

		return
	end

	self._limitTime = self._limitTime - 1
end

function ChatRoomLuckyRainView:onUpdateParam()
	return
end

function ChatRoomLuckyRainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_4.LaplaceChatRoom.play_ui_bulaochun_yy_hb321)
end

function ChatRoomLuckyRainView:onClose()
	return
end

function ChatRoomLuckyRainView:onDestroyView()
	UIBlockMgr.instance:endBlock("waitrainopen")
	TaskDispatcher.cancelTask(self._startLuckyRain, self)
	TaskDispatcher.cancelTask(self._creatRainItem, self)
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)

	if self._rainItems then
		for _, item in pairs(self._rainItems) do
			item:destroy()
		end

		self._rainItems = nil
	end
end

return ChatRoomLuckyRainView
