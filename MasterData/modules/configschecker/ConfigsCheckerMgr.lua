-- chunkname: @modules/configschecker/ConfigsCheckerMgr.lua

module("modules.configschecker.ConfigsCheckerMgr", package.seeall)

local ConfigsCheckerMgr = class("ConfigsCheckerMgr")

function ConfigsCheckerMgr:ctor()
	self._strBufListIndex = 0
	self._strBufList = {}
end

function ConfigsCheckerMgr.checkConfigAll()
	ConfigsCheckerMgr.checkVoiceEndTime()
	ConfigsCheckerMgr.checkCachotConfig()
end

function ConfigsCheckerMgr.checkVoiceEndTime()
	print("===开始检查检查语音文本是否配置了结束时间===")

	for i, v in ipairs(lua_character_voice.configList) do
		local t = {}

		SpineVoiceText:_initContent(t, v.content)

		for _, content in ipairs(t) do
			if content[1] and not content[2] then
				logError("没有配置时间 audio:" .. v.audio .. " " .. content[1])
			end
		end

		t = {}

		SpineVoiceText:_initContent(t, v.encontent)

		for _, content in ipairs(t) do
			if content[1] and not content[2] then
				logError("没有配置时间 audio:" .. v.audio .. " " .. content[1])
			end
		end
	end

	print("===结束检查检查语音文本是否配置了结束时间===")
end

function ConfigsCheckerMgr.checkCachotConfig()
	print("===开始检查肉鸽配置了结束时间===")

	for _, co in ipairs(lua_rogue_event.configList) do
		if co.type == V1a6_CachotEnum.EventType.Battle then
			local fightCo = lua_rogue_event_fight.configDict[co.eventId]

			if not fightCo then
				logError("没有配置战斗事件:" .. co.id .. " >>> " .. co.eventId)
			end
		elseif co.type == V1a6_CachotEnum.EventType.ChoiceSelect then
			local choiceCo = lua_rogue_event_drama_choice.configDict[co.eventId]

			if not choiceCo then
				logError("没有配置选项事件:" .. co.id .. " >>> " .. co.eventId)
			end
		elseif co.type == V1a6_CachotEnum.EventType.Store then
			local shopCo = lua_rogue_shop.configDict[co.eventId]

			if not shopCo then
				logError("没有配置商店事件:" .. co.id .. " >>> " .. co.eventId)
			end
		elseif co.type == V1a6_CachotEnum.EventType.CharacterCure then
			local cureCo = lua_rogue_event_life.configDict[co.eventId]

			if not cureCo then
				logError("没有配置回血事件:" .. co.id .. " >>> " .. co.eventId)
			end
		elseif co.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			local reviveCo = lua_rogue_event_revive.configDict[co.eventId]

			if not reviveCo then
				logError("没有配置复活事件:" .. co.id .. " >>> " .. co.eventId)
			end
		elseif co.type == V1a6_CachotEnum.EventType.Tip then
			local tipCo = lua_rogue_event_tips.configDict[co.eventId]

			if not tipCo then
				logError("没有配置提示事件:" .. co.id .. " >>> " .. co.eventId)
			end
		end

		local index = 1

		while co["event" .. index] do
			local eventId = tonumber(co["event" .. index])

			if eventId and eventId > 0 and not lua_rogue_event.configDict[eventId] then
				logError("掉落的事件配置不存在" .. co.id .. " >> " .. index .. " >> " .. co["event" .. index])
			end

			index = index + 1
		end
	end

	local all = {}

	for i, co in ipairs(lua_rogue_event_drama_choice.configList) do
		if co.type ~= 1 and co.type ~= 2 then
			logError("选项类型错误" .. co.id .. " >> " .. co.type)
		end

		if co.group == 0 then
			logError("选项没有配置组" .. co.id)
		else
			all[co.group] = all[co.group] or {}
			all[co.group][co.id] = co

			local dialogCo = lua_rogue_dialog.configDict[co.dialogId]

			if not dialogCo then
				logError("选项事件对话id 不存在 " .. co.id .. " >>> " .. co.dialogId)
			elseif dialogCo and co.type == 1 and (not dialogCo[1] or dialogCo[1].type ~= 1) then
				logError("选项事件对话id 配置错误 第一步应该是type1 " .. co.id .. " >>> " .. co.dialogId)
			end
		end
	end

	for group, dict in pairs(all) do
		local type1Count = 0
		local type2Count = 0

		for k, co in pairs(dict) do
			if co.type == 1 then
				type1Count = type1Count + 1
			end

			if co.type == 2 then
				type2Count = type2Count + 1
			end
		end

		if type1Count ~= 1 then
			logError("选项配置组错误 组id" .. group .. " type = 1:" .. type1Count)
		end

		if type2Count > 3 or type2Count <= 0 then
			logError("选项配置组错误 组id" .. group .. " type = 2:" .. type2Count)
		end
	end

	local groupNums = {}

	setmetatable(groupNums, {
		__index = function()
			return 0
		end
	})

	for id, co in pairs(lua_rogue_goods.configDict) do
		if co.creator > 0 then
			if not lua_rogue_collection.configDict[co.creator] then
				logError("商品配置的藏品不存在" .. co.id .. " >>> " .. co.creator)
			end
		elseif co.event > 0 then
			if not lua_rogue_event.configDict[co.event] then
				logError("商品配置的事件不存在" .. co.id .. " >>> " .. co.event)
			end
		else
			logError("商品配置错误" .. co.id)
		end

		groupNums[co.goodsGroup] = groupNums[co.goodsGroup] + 1
	end

	for id, co in pairs(lua_rogue_shop.configDict) do
		local needGroupNumDict = {}

		setmetatable(needGroupNumDict, {
			__index = function()
				return 0
			end
		})

		local index = 1

		while co["pos" .. index] do
			needGroupNumDict[co["pos" .. index]] = needGroupNumDict[co["pos" .. index]] + 1
			index = index + 1
		end

		for groupId, num in pairs(needGroupNumDict) do
			if groupId ~= 0 and num > groupNums[groupId] then
				logError("商店配置的事件组数量不足" .. co.id .. " >>> " .. groupId)
			end
		end
	end

	print("===结束检查肉鸽配置了结束时间===")
end

function ConfigsCheckerMgr:createStrBuf(source)
	local index = self._strBufListIndex + 1
	local strBuf = ConfigsCheckerStrBuf.New(source)

	self._strBufList[index] = strBuf
	self._strBufListIndex = index

	return strBuf, index
end

function ConfigsCheckerMgr:getStrBuf(index)
	return self._strBufList[index]
end

ConfigsCheckerMgr.instance = ConfigsCheckerMgr.New()

return ConfigsCheckerMgr
