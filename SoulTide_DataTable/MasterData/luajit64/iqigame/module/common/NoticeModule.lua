-- chunkname: @IQIGame\\Module\\Common\\NoticeModule.lua

NoticeModule = {
	TYPE_QUEUE_UNLOCK_SKILL = 6,
	TYPE_QUEUE_QUEUE_TIP = 5,
	__ShowingBigFloatNoticeNum = 0,
	TYPE_QUEUE_EFFECT = 4,
	TYPE_QUEUE_UNLOCK_EVENT = 2,
	TYPE_QUEUE_TASK_ACCOMPLISHED = 3,
	__NeedResumeNotice = false,
	TYPE_QUEUE_GET_KEY_ITEM = 1,
	BigFloatNoticeType = {
		UnlockSkill = 4,
		KeyItem = 1,
		Unlock = 2,
		TaskAccomplished = 3
	},
	__BigFloatNoticeUINames = {
		Constant.UIControllerName.KeyItemNoticeUI,
		Constant.UIControllerName.UnlockNoticeUI,
		Constant.UIControllerName.TaskAccomplishedNoticeUI,
		Constant.UIControllerName.UnlockSkillNoticeUI
	},
	__IgnoredList = {},
	__RollingNoticeList = {},
	__RollingNoticeParamList = {},
	__FloatNoticeDatas = {},
	__PauseNotice = {},
	__PauseNoticeList = {},
	__BigFloatNoticeDatas = {},
	__CustomIgnoreList = {}
}

function NoticeModule.ShowNotice(noticeCid, confirmCallback, cancelCallback, from, ...)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	if cfgNoticeData == nil then
		return
	end

	if cfgNoticeData.Type == 1 then
		NoticeModule.__ShowFloatNotice(noticeCid, ...)
	elseif cfgNoticeData.Type == 2 then
		NoticeModule.__ShowRollingNotice(noticeCid, ...)
	elseif cfgNoticeData.Type == 3 then
		NoticeModule.__ShowChatNotice(noticeCid, ...)
	elseif cfgNoticeData.Type == 4 or cfgNoticeData.Type == 5 or cfgNoticeData.Type == 7 or cfgNoticeData.Type == 8 or cfgNoticeData.Type == 9 then
		NoticeModule.__ShowAlert(noticeCid, confirmCallback, cancelCallback, from, ...)
	end
end

function NoticeModule.ShowNoticeNoCallback(noticeCid, ...)
	NoticeModule.ShowNotice(noticeCid, nil, nil, nil, ...)
end

function NoticeModule.ShowNoticeByType(type, content, confirmCallback, cancelCallback, from)
	if type == 1 then
		NoticeModule.__ShowFloatNotice(21040005, content)
	elseif type == 2 then
		NoticeModule.__ShowRollingNotice(21040006, content)
	elseif type == 3 then
		NoticeModule.__ShowChatNotice(21040073, content)
	elseif type == 4 then
		NoticeModule.__ShowAlert(21040007, confirmCallback, cancelCallback, from, content)
	elseif type == 5 then
		NoticeModule.__ShowAlert(21040008, confirmCallback, cancelCallback, from, content)
	elseif type == 6 then
		-- block empty
	end
end

function NoticeModule.ShowGetItems(tipID, items, ...)
	local itemCidNumMap = {}
	local placeGameEquip = {}

	for index, rawItemData in pairs(items) do
		local isPlaceGameEquip = false

		for key, value in pairs(rawItemData) do
			if key == "placeGameEquipPOD" then
				table.insert(placeGameEquip, rawItemData)

				isPlaceGameEquip = true
			end
		end

		if not isPlaceGameEquip then
			local cfgItemData = CfgItemTable[rawItemData.cid]

			if cfgItemData.IsRewardShow then
				local num = itemCidNumMap[rawItemData.cid]

				num = num or 0
				num = num + rawItemData.num
				itemCidNumMap[rawItemData.cid] = num
			end
		end
	end

	local showItems = {}

	for cid, num in pairs(itemCidNumMap) do
		table.insert(showItems, {
			cid = cid,
			num = num
		})
	end

	for i, v in pairs(placeGameEquip) do
		table.insert(showItems, {
			cid = v.cid,
			num = v.num,
			placeGameEquipPOD = v.placeGameEquipPOD
		})
	end

	if #showItems > 0 then
		UIModule.Open(Constant.UIControllerName.GetPanelUI, Constant.UILayer.Tooltip, {
			cid = tipID,
			items = showItems,
			args = {
				...
			}
		})
	end

	local souls = {}

	for index, rawItemData in pairs(items) do
		local cfgItemData = CfgItemTable[rawItemData.cid]
		local isSoulItem, soulCid = ItemModule.IsSoulItem(cfgItemData)

		if isSoulItem then
			table.insert(souls, soulCid)
		end
	end

	if #souls > 0 then
		UIModule.Open(Constant.UIControllerName.SoulUnlockUI, Constant.UILayer.Tooltip, {
			[UIParam.soulUnlockUI.soulIds] = souls,
			[UIParam.soulUnlockUI.type] = 2
		})
	end
end

function NoticeModule.ShowNoticeBuyConfirm(noticeCid, confirmCallback, cancelCallback, from, itemCids, itemNums, ...)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	if cfgNoticeData == nil then
		return
	end

	if (cfgNoticeData.Type == 7 or cfgNoticeData.Type == 8) and NoticeModule.__IgnoredList[noticeCid] ~= nil then
		if confirmCallback ~= nil then
			confirmCallback(from)
		end

		return
	end

	if cfgNoticeData.Type == 7 then
		UIModule.Open(Constant.UIControllerName.BuyMultiConfirmUI, Constant.UILayer.Tooltip, {
			cid = noticeCid,
			confirm = confirmCallback,
			cancel = cancelCallback,
			from = from,
			itemCids = itemCids,
			itemNums = itemNums,
			args = {
				...
			}
		}, true)
	elseif cfgNoticeData.Type == 8 then
		UIModule.Open(Constant.UIControllerName.BuySingleConfirmUI, Constant.UILayer.Tooltip, {
			cid = noticeCid,
			confirm = confirmCallback,
			cancel = cancelCallback,
			from = from,
			itemCid = itemCids[1],
			itemNum = itemNums[1],
			args = {
				...
			}
		}, true)
	end
end

function NoticeModule.ShowBatchBuyConfirm(noticeCid, confirmCallback, cancelCallback, from, count, costList, nowCount, dynamicCountArgIndex, extraConditionFunc, ...)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	if cfgNoticeData == nil then
		return
	end

	if cfgNoticeData.Type == 10 and NoticeModule.__IgnoredList[noticeCid] ~= nil then
		if confirmCallback ~= nil then
			confirmCallback(from)
		end

		return
	end

	if cfgNoticeData.Type == 10 then
		UIModule.Open(Constant.UIControllerName.BuySingleBatchConfirmUI, Constant.UILayer.Tooltip, {
			cid = noticeCid,
			confirm = confirmCallback,
			cancel = cancelCallback,
			from = from,
			count = count,
			costList = costList,
			nowCount = nowCount,
			dynamicCountArgIndex = dynamicCountArgIndex,
			extraConditionFunc = extraConditionFunc,
			args = {
				...
			}
		})
	end
end

function NoticeModule.ShowFloatGetItem(itemCid, itemNum)
	NoticeModule.__TryOpenFloatUpdateAndPlay({
		type = Constant.Notice.FloatTypeGetItem,
		param = {
			itemCid = itemCid,
			itemNum = itemNum
		}
	})
end

function NoticeModule.ShowServerError(errorCode)
	NoticeModule.ShowNoticeByType(1, errorCode .. " : " .. getErrorMsg(errorCode))
end

function NoticeModule.__ShowFloatNotice(noticeCid, ...)
	NoticeModule.__TryOpenFloatUpdateAndPlay({
		type = Constant.Notice.FloatTypeNormal,
		param = {
			cid = noticeCid,
			args = {
				...
			}
		}
	})
end

function NoticeModule.__TryOpenFloatUpdateAndPlay(floatNoticeData)
	table.insert(NoticeModule.__FloatNoticeDatas, floatNoticeData)

	if not UIModule.HasUI(Constant.UIControllerName.FloatNoticeUI) and not UIModule.IsLoadingUI(Constant.UIControllerName.FloatNoticeUI) then
		UIModule.Open(Constant.UIControllerName.FloatNoticeUI, Constant.UILayer.Top, floatNoticeData.param)
	end
end

function NoticeModule.PopFloatNoticeData()
	if #NoticeModule.__FloatNoticeDatas == 0 then
		return nil
	end

	local floatNoticeData = NoticeModule.__FloatNoticeDatas[1]

	table.remove(NoticeModule.__FloatNoticeDatas, 1)

	return floatNoticeData
end

function NoticeModule.__ShowRollingNotice(noticeCid, ...)
	table.insert(NoticeModule.__RollingNoticeList, noticeCid)
	table.insert(NoticeModule.__RollingNoticeParamList, {
		...
	})

	if not UIModule.HasUI(Constant.UIControllerName.RollingNoticeUI) and not UIModule.IsLoadingUI(Constant.UIControllerName.RollingNoticeUI) then
		UIModule.Open(Constant.UIControllerName.RollingNoticeUI, Constant.UILayer.Top)
	end
end

function NoticeModule.__ShowChatNotice(noticeCid, ...)
	local cfgNoticeData = CfgNoticeTable[noticeCid]
	local content = string.format(cfgNoticeData.Describe, ...)

	ChatModule.ShowClientMessage(ChatModule.CHANNEL_SYSTEM, content)
end

function NoticeModule.__ShowAlert(noticeCid, confirmCallback, cancelCallback, from, ...)
	if NoticeModule.__IgnoredList[noticeCid] ~= nil then
		if confirmCallback ~= nil then
			confirmCallback(from)
		end

		return
	end

	UIModule.Open(Constant.UIControllerName.ConfirmationUI, Constant.UILayer.Tooltip, {
		cid = noticeCid,
		confirm = confirmCallback,
		cancel = cancelCallback,
		from = from,
		args = {
			...
		}
	}, true)
end

function NoticeModule.AddIgnoreID(noticeCid)
	NoticeModule.__IgnoredList[noticeCid] = noticeCid
end

function NoticeModule.AddCustomIgnoreType(type)
	NoticeModule.__CustomIgnoreList[type] = type
end

function NoticeModule.IsCustomIgnore(type)
	return NoticeModule.__CustomIgnoreList[type] ~= nil
end

function NoticeModule.GetRollingNotice()
	local noticeCid, args

	if #NoticeModule.__RollingNoticeList > 0 then
		noticeCid = table.remove(NoticeModule.__RollingNoticeList, 1)
	end

	if #NoticeModule.__RollingNoticeParamList > 0 then
		args = table.remove(NoticeModule.__RollingNoticeParamList, 1)
	end

	return noticeCid, args
end

function NoticeModule.ShowKeyItemNotice(itemCid)
	if NoticeModule.IsTypePaused(NoticeModule.TYPE_QUEUE_GET_KEY_ITEM) then
		table.insert(NoticeModule.__PauseNoticeList, {
			type = NoticeModule.TYPE_QUEUE_GET_KEY_ITEM,
			func = NoticeModule.ShowKeyItemNotice,
			param = {
				itemCid
			}
		})

		return
	end

	NoticeModule.__AddDataToBigFloatNoticeQueue({
		type = NoticeModule.BigFloatNoticeType.KeyItem,
		itemCid = itemCid
	})
	NoticeModule.__TryOpenBigFloatUpdateAndPlay()
end

function NoticeModule.ShowUnlockEventNotice(eventCid)
	if NoticeModule.IsTypePaused(NoticeModule.TYPE_QUEUE_UNLOCK_EVENT) then
		table.insert(NoticeModule.__PauseNoticeList, {
			type = NoticeModule.TYPE_QUEUE_UNLOCK_EVENT,
			func = NoticeModule.ShowUnlockEventNotice,
			param = {
				eventCid
			}
		})

		return
	end

	local cfgEventData = CfgEventTable[eventCid]

	NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, cfgEventData.Name, cfgEventData.Describe)
end

function NoticeModule.__ShowUnlockNotice(bigFloatType, typeText, nameText, nameText1, titleText)
	NoticeModule.__AddDataToBigFloatNoticeQueue({
		type = bigFloatType,
		typeText = typeText,
		nameText = nameText,
		nameText1 = nameText1,
		TitleText = titleText
	})
	NoticeModule.__TryOpenBigFloatUpdateAndPlay()
end

function NoticeModule.ShowTaskAccomplishedNotice(taskCid)
	if NoticeModule.IsTypePaused(NoticeModule.TYPE_QUEUE_TASK_ACCOMPLISHED) then
		table.insert(NoticeModule.__PauseNoticeList, {
			type = NoticeModule.TYPE_QUEUE_TASK_ACCOMPLISHED,
			func = NoticeModule.ShowTaskAccomplishedNotice,
			param = {
				taskCid
			}
		})

		return
	end

	NoticeModule.__AddDataToBigFloatNoticeQueue({
		type = NoticeModule.BigFloatNoticeType.TaskAccomplished,
		taskCid = taskCid
	})
	NoticeModule.__TryOpenBigFloatUpdateAndPlay()
end

function NoticeModule.ShowSkillUnlockNotice(skillId, soulData)
	if NoticeModule.IsTypePaused(NoticeModule.TYPE_QUEUE_UNLOCK_SKILL) then
		table.insert(NoticeModule.__PauseNoticeList, {
			type = NoticeModule.TYPE_QUEUE_UNLOCK_SKILL,
			func = NoticeModule.ShowSkillUnlockNotice,
			param = {
				skillId,
				soulData
			}
		})

		return
	end

	NoticeModule.__AddDataToBigFloatNoticeQueue({
		type = NoticeModule.BigFloatNoticeType.UnlockSkill,
		skillId = skillId,
		soulData = soulData
	})
	NoticeModule.__TryOpenBigFloatUpdateAndPlay()
end

function NoticeModule.__TryOpenBigFloatUpdateAndPlay()
	NoticeModule.__ShowOneBigFloatNotice()
end

function NoticeModule.__CheckBigFloatNotice()
	if NoticeModule.__ShowingBigFloatNoticeNum == 0 then
		for i = 1, 3 do
			NoticeModule.__ShowOneBigFloatNotice()
		end
	end
end

function NoticeModule.__ShowOneBigFloatNotice()
	if NoticeModule.__ShowingBigFloatNoticeNum < 3 and #NoticeModule.__BigFloatNoticeDatas > 0 then
		local uiParam = NoticeModule.__BigFloatNoticeDatas[#NoticeModule.__BigFloatNoticeDatas]

		if uiParam.type == NoticeModule.BigFloatNoticeType.UnlockSkill and NoticeModule.__ShowingBigFloatNoticeNum > 0 then
			return
		end

		table.remove(NoticeModule.__BigFloatNoticeDatas, #NoticeModule.__BigFloatNoticeDatas)

		NoticeModule.__ShowingBigFloatNoticeNum = NoticeModule.__ShowingBigFloatNoticeNum + 1
		uiParam.index = NoticeModule.__ShowingBigFloatNoticeNum

		if uiParam.type == NoticeModule.BigFloatNoticeType.KeyItem then
			UIModule.Open(Constant.UIControllerName.KeyItemNoticeUI, Constant.UILayer.Top, uiParam, true)
		elseif uiParam.type == NoticeModule.BigFloatNoticeType.Unlock then
			UIModule.Open(Constant.UIControllerName.UnlockNoticeUI, Constant.UILayer.Top, uiParam, true)
		elseif uiParam.type == NoticeModule.BigFloatNoticeType.TaskAccomplished then
			UIModule.Open(Constant.UIControllerName.TaskAccomplishedNoticeUI, Constant.UILayer.Top, uiParam, true)
		elseif uiParam.type == NoticeModule.BigFloatNoticeType.UnlockSkill then
			UIModule.Open(Constant.UIControllerName.UnlockSkillNoticeUI, Constant.UILayer.Top, uiParam, true)
		end
	end
end

function NoticeModule.__AddDataToBigFloatNoticeQueue(uiParam)
	if uiParam.type ~= NoticeModule.BigFloatNoticeType.UnlockSkill then
		table.insert(NoticeModule.__BigFloatNoticeDatas, 1, uiParam)
	else
		table.insert(NoticeModule.__BigFloatNoticeDatas, #NoticeModule.__BigFloatNoticeDatas + 1, uiParam)
	end
end

function NoticeModule.AddEventListeners()
	GameEntry.LuaEvent:Subscribe(CloseUIFormCompleteEventArgs.EventId, NoticeModule.OnUIClosed)
end

function NoticeModule.RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(CloseUIFormCompleteEventArgs.EventId, NoticeModule.OnUIClosed)
end

function NoticeModule.Shutdown()
	NoticeModule.RemoveEventListeners()
end

function NoticeModule.Init()
	NoticeModule.AddEventListeners()
end

function NoticeModule.OnUIClosed(sender, args)
	for i, uiName in pairs(NoticeModule.__BigFloatNoticeUINames) do
		if args.UIFormAssetName == AssetPath.Get(GlobalKey.UIPrefabPath, NoticeModule.__BigFloatNoticeUINames[i]) then
			NoticeModule.__ShowingBigFloatNoticeNum = NoticeModule.__ShowingBigFloatNoticeNum - 1

			NoticeModule.__CheckBigFloatNotice()

			break
		end
	end
end

function NoticeModule.NotifyEffectNotice(effectType, effectParams, num)
	if NoticeModule.IsTypePaused(NoticeModule.TYPE_QUEUE_EFFECT) then
		table.insert(NoticeModule.__PauseNoticeList, {
			type = NoticeModule.TYPE_QUEUE_EFFECT,
			func = NoticeModule.NotifyEffectNotice,
			param = {
				effectType,
				effectParams,
				num
			}
		})

		return
	end

	if effectType == Constant.EffectTypeID.ID_DROP_1 then
		-- block empty
	elseif effectType == Constant.EffectTypeID.ID_GET_SOUL_1 then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_EVENT then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_GET_DRESS then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_QUEST then
		local content = CfgMainQuestTable[effectParams[1]].Name

		NoticeModule.ShowNoticeByType(1, string.format(CfgEffectTypeTable[effectType].Name, content))
	elseif effectType == Constant.EffectTypeID.TYPE_SOUL_FAVOR then
		local soulName = CfgSoulTable[effectParams[1]].Name
		local showNum = effectParams[2] * num

		NoticeModule.ShowNoticeByType(1, string.format(CfgEffectTypeTable[effectType].Name, soulName, showNum))
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_MANUFACTURE_ITEM then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = strArr[1]
		local typeText = string.format(strArr[2], CfgHomeLandManufactureItemTable[effectParams[1]].Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_COOK_COMBINATION then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = strArr[1]
		local typeText = string.format(strArr[2], CfgCookCombinationTable[effectParams[1]].Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText)
	elseif effectType == Constant.EffectTypeID.TYPE_ADD_EXP then
		NoticeModule.ShowNoticeByType(1, string.format(CfgEffectTypeTable[effectType].Name, effectParams[1] * num))
	elseif effectType == Constant.EffectTypeID.TYPE_ADD_VIP_EXP then
		NoticeModule.ShowNoticeByType(1, string.format(CfgEffectTypeTable[effectType].Name, effectParams[1] * num))
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_FORGE_CARDPACK then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_ADD_GLOBALBUFF then
		NoticeModule.ShowNoticeByType(1, string.format(CfgEffectTypeTable[effectType].Name, CfgGlobalBuffTable[effectParams[1]].Name))
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_QUEST_TYPE then
		NoticeModule.ShowNoticeByType(1, string.format(CfgEffectTypeTable[effectType].Name, effectParams[1] * num))
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_AVATAR_FRAME then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_HEAD_ICON then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_LOGIN_BACKGROUND then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_ADD_SOUL_MEMERY_DRESS_PROGRESS then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_SHOP then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_SOUL_NEW_STORY then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local cfgSoulNewStory = CfgSoulNewStoryTable[effectParams[1]]
		local bigFloatType = tostring(strArr[1])
		local typeText = string.format(strArr[2], CfgSoulTable[cfgSoulNewStory.SoulId].Name)
		local nameText = string.format(strArr[3], cfgSoulNewStory.Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_LOTTERY_PACK then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_SOUL_PLATE then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local cfgSoulBook = CfgSoulBookTable[effectParams[1]]
		local bigFloatType = tostring(strArr[1])
		local typeText, nameText

		if cfgSoulBook.BookType == 1 then
			typeText = string.format(strArr[2], CfgSoulTable[cfgSoulBook.SoulId].Name, SoulHandBookUIApi:GetString("TextTog1", 1))
			nameText = string.format(strArr[3], CfgCGTable[cfgSoulBook.CGCVId].CGName)
		elseif cfgSoulBook.BookType == 2 then
			typeText = string.format(strArr[2], CfgSoulTable[cfgSoulBook.SoulId].Name, UnlockNoticeUIApi:GetString("TextSound"))
			nameText = string.format(strArr[3], CfgSoulActionTable[cfgSoulBook.CGCVId].ActionName)
		elseif cfgSoulBook.BookType == 3 then
			typeText = string.format(strArr[2], CfgSoulTable[cfgSoulBook.SoulId].Name, UnlockNoticeUIApi:GetString("TextDialog"))
			nameText = string.format(strArr[3], cfgSoulBook.DialogName)
		elseif cfgSoulBook.BookType == 4 then
			typeText = string.format(strArr[2], CfgSoulTable[cfgSoulBook.SoulId].Name, SoulHandBookUIApi:GetString("TextTog1", 4))
			nameText = string.format(strArr[3], CfgCGTable[cfgSoulBook.CGCVId].CGName)
		end

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_OPEN_FUNCTIONTYPE then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_ADD_SOUL_EXP then
		NoticeModule.ShowNoticeByType(1, string.format(CfgSoulTable[effectType].Name, effectParams[1] * num))
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_FORMATION then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UP_SOUL_FAVOR_MAX_LV_LIMIT then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local titleText = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local soulID = effectParams[1]
		local startLv = effectParams[2]
		local endLv = effectParams[3]
		local beginStyle = effectParams[4]
		local endStyle = effectParams[5]
		local nameText = string.format(strArr[3], CfgSoulTable[soulID].Name)
		local nameText1 = string.format(strArr[4], NewMemoryUIApi:GetString("LoveUIStyleTitle", beginStyle), NewMemoryUIApi:GetString("LoveUIStyleTitle", endStyle))

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, typeText, nameText, nameText1, titleText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_TOWN_AREA_ENTRY then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_TOWN_NPC_ITEM_ENTRY then
		local TitleStr = {
			LibraryUIApi:GetString("NpcResName"),
			LibraryUIApi:GetString("NpcResOccupation"),
			LibraryUIApi:GetString("NpcResHeight"),
			LibraryUIApi:GetString("NpcResWeight"),
			LibraryUIApi:GetString("NpcResSpeciality"),
			LibraryUIApi:GetString("NpcResWeakness"),
			LibraryUIApi:GetString("NpcResLike"),
			LibraryUIApi:GetString("NpcResHate"),
			LibraryUIApi:GetString("NpcResLabel")
		}
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local cfgTownBookRes = CfgTownNpcBookResTable[effectParams[1]]
		local bigFloatType = tostring(strArr[1])
		local typeText = string.format(strArr[2], CfgTownNpcBookTable[cfgTownBookRes.NpcID].Name)
		local nameText = string.format(strArr[3], TitleStr[cfgTownBookRes.EntryId], cfgTownBookRes.Describe)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_TOWN_NEW_ENTRY then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local cfgTownNews = CfgTownNewsBookTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgTownNews.Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_TOWN_RUMOR_ENTRY then
		-- block empty
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_ALIEN_EVENT then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local cfgTownEvent = CfgTownAlienEventBookResTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgTownEvent.TitleDescribe)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_TOWN_STORY then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local cfgTownEvent = CfgTownStoryBookResTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgTownEvent.TitleDescribe)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_RUNE then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local cfgRune = CfgRuneTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgRune.Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_ATTRIBUTE_BONUS then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local soulID = effectParams[1]
		local ID = effectParams[2]
		local nameText = string.format(strArr[3], CfgSoulTable[soulID].Name, CfgPabilityTable[ID].Describe)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_HOMELAND_SUIT then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local cfgSuit = CfgHomeLandDecorateSuitTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgSuit.Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.EffectTypeID.TYPE_UNLOCK_WHISPER then
		local strArr = string.split(CfgEffectTypeTable[effectType].Name, "|")
		local bigFloatType = tostring(strArr[1])
		local typeText = tostring(strArr[2])
		local cfgSoulWhisper = CfgSoulWhisperListTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgSoulWhisper.Title)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	end
end

function NoticeModule.NotifyClientEffectNotice(effectType, effectParams, num)
	if NoticeModule.IsTypePaused(NoticeModule.TYPE_QUEUE_EFFECT) then
		table.insert(NoticeModule.__PauseNoticeList, {
			type = NoticeModule.TYPE_QUEUE_EFFECT,
			func = NoticeModule.NotifyEffectNotice,
			param = {
				effectType,
				effectParams,
				num
			}
		})

		return
	end

	local strArr = NoticeUIApi:GetString("TextUnlockCook", effectType)

	if effectType == Constant.ClientEffectTypeID.CUSTOM_TYPE_UNLOCK_COOK then
		local bigFloatType = string.format(strArr[1])
		local typeText = string.format(strArr[2])
		local cfgCookCombination = CfgCookCombinationTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgCookCombination.CookName)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.ClientEffectTypeID.TYPE_UNLOCK_FISH then
		local bigFloatType = string.format(strArr[1])
		local typeText = string.format(strArr[2])
		local cfgItem = CfgItemTable[CfgFishListTable[effectParams[1]].ItemID]
		local nameText = string.format(strArr[3], cfgItem.Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	elseif effectType == Constant.ClientEffectTypeID.FISHING_ACTIVITY_UNLOCK_FISH then
		local bigFloatType = string.format(strArr[1])
		local typeText = string.format(strArr[2])
		local cfgMainQuest = CfgMainQuestTable[effectParams[1]]
		local nameText = string.format(strArr[3], cfgMainQuest.Name)

		NoticeModule.__ShowUnlockNotice(NoticeModule.BigFloatNoticeType.Unlock, bigFloatType, typeText, nameText)
	end
end

function NoticeModule.IsTypePaused(type)
	return NoticeModule.__PauseNotice[type]
end

function NoticeModule.PauseNotice(types)
	if types == nil then
		types = {
			NoticeModule.TYPE_QUEUE_GET_KEY_ITEM,
			NoticeModule.TYPE_QUEUE_TASK_ACCOMPLISHED,
			NoticeModule.TYPE_QUEUE_UNLOCK_EVENT,
			NoticeModule.TYPE_QUEUE_EFFECT,
			NoticeModule.TYPE_QUEUE_QUEUE_TIP
		}
	end

	for i = 1, #types do
		NoticeModule.__PauseNotice[types[i]] = true
	end
end

function NoticeModule.ResumeNotice(types)
	if types == nil then
		for type, isPaused in pairs(NoticeModule.__PauseNotice) do
			NoticeModule.__PauseNotice[type] = nil
		end
	else
		for i = 1, #types do
			NoticeModule.__PauseNotice[types[i]] = nil
		end
	end

	for i = #NoticeModule.__PauseNoticeList, 1, -1 do
		local data = NoticeModule.__PauseNoticeList[i]

		if types == nil or table.indexOf(types, data.type) then
			if data.param ~= nil then
				data.func(unpack(data.param))
			else
				data.func()
			end

			table.remove(NoticeModule.__PauseNoticeList, i)
		end
	end
end

function NoticeModule.NeedResumeNoticeAfterChangeScene(types)
	NoticeModule.__NeedResumeNotice = true
	NoticeModule.__ToResumeTypes = types
end

function NoticeModule.CheckResumeNoticeAfterScene(isAddScene)
	if NoticeModule.__NeedResumeNotice then
		NoticeModule.ResumeNotice(NoticeModule.__ToResumeTypes)

		NoticeModule.__NeedResumeNotice = false
		NoticeModule.__ToResumeTypes = nil
	end
end

NoticeModule.QueueTip = {
	isShowing = false,
	tipQueue = {},
	tipData = {},
	tipTypeEnum = {
		UnlockSkill = 3,
		UnlockFunction = 2,
		Achievement = 1
	}
}

function NoticeModule.AddQueueTipData(userData, tipType)
	NoticeModule.QueueTip.tipQueue[#NoticeModule.QueueTip.tipQueue + 1] = {
		userData,
		tipType
	}

	table.sort(NoticeModule.QueueTip.tipQueue, function(a, b)
		return a[2] > b[2]
	end)
end

function NoticeModule.IsInQueue(funId)
	for i, v in pairs(NoticeModule.QueueTip.tipQueue) do
		if v[1] == funId then
			return true
		end
	end

	return false
end

function NoticeModule.CheckNeedShowQueueTip()
	if NoticeModule.IsTypePaused(NoticeModule.TYPE_QUEUE_QUEUE_TIP) then
		table.insert(NoticeModule.__PauseNoticeList, {
			type = NoticeModule.TYPE_QUEUE_QUEUE_TIP,
			func = NoticeModule.CheckNeedShowQueueTip
		})

		return
	end

	if #NoticeModule.QueueTip.tipQueue > 0 and NoticeModule.QueueTip.isShowing == false and PlayerModule.CurrSceneID == SceneID.MainCity then
		UIModule.Open(Constant.UIControllerName.QueueTipUI, Constant.UILayer.UI)
	end
end

function NoticeModule.ShowTimeChangeNotice(addValue)
	NoticeModule.__TryOpenFloatUpdateAndPlay({
		type = Constant.Notice.FloatTypeMazeLimitTimeChange,
		param = {
			addValue = addValue
		}
	})
end

function NoticeModule.MoneyDeficitTip(type, buyCount)
	if type == 1 then
		NoticeModule.ShowNotice(21061004, function()
			UIModule.Open(Constant.UIControllerName.BuyMallPanelUI, Constant.UILayer.UI, buyCount)
		end, nil, self, CfgItemTable[Constant.ItemID.TREASURE].Name)
	elseif type == 2 then
		NoticeModule.ShowNotice(21061005, function()
			JumpModule.Jump(10202004)
		end, nil, self, CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Name)
	end
end
