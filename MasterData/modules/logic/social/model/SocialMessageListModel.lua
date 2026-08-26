-- chunkname: @modules/logic/social/model/SocialMessageListModel.lua

module("modules.logic.social.model.SocialMessageListModel", package.seeall)

local SocialMessageListModel = class("SocialMessageListModel", MixScrollModel)

function SocialMessageListModel:setMessageList(messageList)
	self._moList = {}

	local preSendTime = 0
	local nowTime = ServerTime.now()

	if messageList then
		for _, messageMO in pairs(messageList) do
			local sendTime = tonumber(messageMO.sendTime) / 1000

			if TimeUtil.getDiffDay(nowTime, sendTime) >= 1 then
				if preSendTime == 0 or TimeUtil.getDiffDay(preSendTime, sendTime) >= 1 then
					local mo = {}

					mo.chattime = TimeUtil.timestampToString2(sendTime)

					table.insert(self._moList, mo)

					preSendTime = sendTime
				end
			elseif sendTime - preSendTime >= 300 or preSendTime == 0 or TimeUtil.getDiffDay(preSendTime, sendTime) >= 1 then
				local mo = {}

				mo.chattime = TimeUtil.timestampToString4(sendTime)

				table.insert(self._moList, mo)

				preSendTime = sendTime
			end

			table.insert(self._moList, messageMO)

			if SocialConfig.instance:isMsgViolation(messageMO.content) then
				local mo = {}

				mo.showWarm = 1

				table.insert(self._moList, mo)
			end
		end
	end

	self:setList(self._moList)
end

function SocialMessageListModel._sortFunction(x, y)
	return x.sendTime < y.sendTime
end

function SocialMessageListModel:getInfoList(scrollGO)
	local moList = self:getList()

	if not moList or #moList <= 0 then
		return {}
	end

	local textCompSelf = gohelper.findChildText(scrollGO, "#txt_contentself")
	local textCompOthers = gohelper.findChildText(scrollGO, "#txt_contentothers")
	local textwarm = gohelper.findChildText(scrollGO, "#txt_warm")
	local warmHeigh
	local mixCellInfos = {}

	for i, mo in ipairs(moList) do
		local type = 1
		local lineWidth = 0

		if mo.chattime then
			lineWidth = 48
		elseif mo.showWarm then
			if not warmHeigh and textwarm then
				textwarm.text = luaLang("socialmessageitem_warningtips")
				warmHeigh = 62.9 + textwarm.preferredHeight
				textwarm.text = ""
			end

			lineWidth = warmHeigh or 0
		else
			local myUserId = PlayerModel.instance:getMyUserId()
			local subtract = 0
			local nextMO = moList[i + 1]

			if nextMO then
				if nextMO.senderId == myUserId and mo.senderId ~= myUserId then
					subtract = 13
				elseif nextMO.senderId ~= myUserId and mo.senderId == myUserId then
					subtract = 13
				end
			end

			local height = myUserId == mo.senderId and GameUtil.getTextHeightByLine(textCompSelf, mo.content, 37.1) or GameUtil.getTextHeightByLine(textCompOthers, mo.content, 37.1)

			if mo:isHasOp() then
				height = height + 40
			end

			lineWidth = math.max(height + 82.9, 120) - subtract
		end

		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(type, lineWidth, nil)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

SocialMessageListModel.instance = SocialMessageListModel.New()

return SocialMessageListModel
