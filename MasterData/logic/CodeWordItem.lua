-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/codeword/view/CodeWordItem.lua

module("logic.extensions.codeword.view.CodeWordItem", package.seeall)

local CodeWordItem = class("CodeWordItem")

function CodeWordItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._txtTime = goutil.findChildTextComponent(go, "txtTime")
	self._txtContent = goutil.findChildTextComponent(go, "scrollView/Viewport/Content")
	self._txtNum = goutil.findChildTextComponent(go, "txtNum")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")
	self.cell = goutil.findChild(go, "item")
	self.tableview = goutil.findChild(go, "rewardList")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._btnClick:AddClickListener(self._onClick, self)
end

function CodeWordItem:init(data)
	self._data = data

	local cfgGroup = CodeWordConfig.instance:getWordGroupCfg(data.groupId)
	local cfgWord = CodeWordConfig.instance:getTextCfg(data.groupId, data.id)

	self._cfgGroup = cfgGroup
	self._cfgWord = cfgWord
	self._endTimestamp = 0
	self._rewardList = {}
	self._channelIds = nil

	if cfgGroup then
		self._endTimestamp = GameUtil.string2time(cfgGroup.endTime)
		self._rewardList = MaterialMgr.changeItemStrArr(cfgGroup.prize)
		self._channelIds = cfgGroup.channelIds
		self._txtName.text = cfgGroup.text
		self._txtContent.text = self:_getChannelText(cfgGroup.channelIds)

		if cfgGroup.type == "normal" then
			if not cfgGroup.totalPrizeTimes then
				do
					local maxTimes = cfgGroup.dailyPrizeTimes

					self._txtNum.text = self:_getRewardCountTxt(data.groupId, data.id, maxTimes)

					self:updateTime()
				end

				if cfgWord then
					self._txtContent.text = cfgWord.text
				end

				if cfgGroup and cfgWord then
					self._txtContent.text = cfgWord.text .. "\n" .. self:_getChannelText(cfgGroup.channelIds)
				end
			end
		end
	end

	self.scrollList:reloadData(self._rewardList)
end

function CodeWordItem:clear()
	self.scrollList:dispose()
end

function CodeWordItem:_onClick()
	if self._channelIds and self._cfgGroup then
		if self:_isLeftTimes(self._cfgGroup.groupId, self._cfgGroup.id, self._cfgGroup.dailyPrizeTimes) or self._cfgGroup.type == "normal" then
			local channelId = CodeWordController.instance:getChannelIdByPriority(string.split(self._channelIds, "#"))

			printInfo("test CodeWordItem:_onClick", CodeWordModel.instance:getChannelTxtName(channelId))
			GlobalDispatcher:dispatch(GlobalNotify.CodeWordSelectChannel, channelId, self._cfgWord.groupId, self._cfgWord.id, self._cfgWord.text)
		else
			FloatWordMgr.instance:show("次数用尽")
		end
	end
end

function CodeWordItem:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function CodeWordItem:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function CodeWordItem:updateTime()
	local curTime = ServerTime.now()
	local leftTime = self._endTimestamp - curTime

	leftTime = Mathf.Max(leftTime, 0)
	self._txtTime.text = "剩余：" .. self:_getTime(leftTime)
end

function CodeWordItem:_getTime(timer)
	local hour, min, sec = GameUtil.getTimeHHMMSS(timer)

	hour = hour + 1

	if hour >= 24 then
		return string.format("%s天 %d小时", math.floor(hour / 24), hour % 24)
	else
		return string.format("%d小时", hour)
	end
end

function CodeWordItem:_getChannelText(channelIds)
	local str = "生效频道："

	if string.nilorempty(channelIds) then
		return str
	end

	local list = string.split(channelIds, "#")
	local count = #list

	for i, id in ipairs(list) do
		str = str .. CodeWordModel.instance:getChannelTxtName(id)

		if i ~= count then
			str = str .. "、"
		end
	end

	return str
end

function CodeWordItem:_getRewardCountTxt(groupId, id, maxTimes)
	local curUseTimes = CodeWordModel.instance:getTotalPrizeTime(groupId, id)
	local leftTime = maxTimes - curUseTimes

	leftTime = Mathf.Max(leftTime, 0)

	return string.format("奖励次数：%d/%d", leftTime, maxTimes)
end

function CodeWordItem:_isLeftTimes(groupId, id, maxTimes)
	local curUseTimes = CodeWordModel.instance:getDailyTimes(groupId, id)
	local leftTime = maxTimes - curUseTimes

	return leftTime > 0
end

return CodeWordItem
