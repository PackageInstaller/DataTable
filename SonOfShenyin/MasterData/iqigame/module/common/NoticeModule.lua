-- chunkname: @IQIGame\\Module\\Common\\NoticeModule.lua

NoticeModule = {
	isShowOpenFuncAnim = false,
	funcQueue = Queue.New()
}
NoticeModule.__IgnoredList = {}
NoticeModule.__FloatNoticeDatas = {}
NoticeModule.__FloatNoticeTimer = nil

local this = NoticeModule

function NoticeModule.ShowNotice(noticeCid, confirmCallback, cancelCallback, from, ...)
	local cfgNoticeData = CfgNoticeTable[noticeCid]

	if cfgNoticeData == nil then
		warning("cfgNoticeData is nul. noticeId : " .. noticeCid)

		return
	end

	if cfgNoticeData.Type == Constant.NoticeType.FloatTips then
		NoticeModule.__ShowFloatNotice(noticeCid, ...)
	elseif cfgNoticeData.Type == Constant.NoticeType.RightFloatTips then
		NoticeModule.__ShowRightFloatNotice(noticeCid, ...)
	elseif cfgNoticeData.Type == Constant.NoticeType.BoxSingleButton or cfgNoticeData.Type == Constant.NoticeType.BoxDoubleButton or cfgNoticeData.Type == 7 or cfgNoticeData.Type == 8 or cfgNoticeData.Type == 9 then
		NoticeModule.__ShowAlert(noticeCid, confirmCallback, cancelCallback, from, ...)
	end
end

function NoticeModule.ShowNoticeNoCallback(noticeCid, ...)
	NoticeModule.ShowNotice(noticeCid, nil, nil, nil, ...)
end

function NoticeModule.ShowNoticeByType(type, content, confirmCallback, cancelCallback, from)
	if type == Constant.NoticeType.FloatTips then
		NoticeModule.__ShowFloatNotice(21040005, content)
	elseif type == Constant.NoticeType.BoxSingleButton then
		NoticeModule.__ShowAlert(21040007, confirmCallback, cancelCallback, from, content)
	elseif type == Constant.NoticeType.BoxDoubleButton then
		NoticeModule.__ShowAlert(21040008, confirmCallback, cancelCallback, from, content)
	elseif type == Constant.NoticeType.AchievementNotice then
		NoticeModule._ShowAchievementNotice(content)
	elseif type == Constant.NoticeType.RightFloatTips then
		NoticeModule.__ShowRightFloatNotice(21040005, content)
	end
end

function NoticeModule.ShowGetItems(tipID, items, openType, callback, ...)
	if items == nil or table.len(items) <= 0 then
		if callback ~= nil then
			callback()
		end

		return
	end

	local args = {
		...
	}
	local skinCidList = {}
	local itemsShow = {}

	itemsShow.items = {}
	itemsShow.openType = openType
	itemsShow.callback = callback
	itemsShow.args = args

	ForPairs(items, function(_, _data)
		local itemConfig

		if _data.srcId ~= 0 and _data.srcId ~= nil then
			itemConfig = CfgItemTable[_data.srcId]
		else
			itemConfig = CfgItemTable[_data.cid]
		end

		local isSkinItem, _skinCid = SkinModule.IsSkinItemByItemCfg(itemConfig)

		if isSkinItem then
			table.insert(skinCidList, {
				skinCid = _skinCid,
				itemPod = _data
			})
		else
			if itemConfig.IsHide == 1 then
				return
			end

			table.insert(itemsShow.items, _data)
		end
	end)
	ForArray(skinCidList, function(k, v)
		UIModule.Open(Constant.UIControllerName.GetSkinShowUI, Constant.UILayer.UI, v, true)
	end)

	if #itemsShow.items > 0 then
		table.insert(NoticeModule.getItemShowsQueue, itemsShow)
	elseif callback ~= nil then
		callback()
	end

	this.ShowNextGetItems()
end

function NoticeModule.ShowNextGetItems()
	if not this.isGetPanelUIShow and #this.getItemShowsQueue > 0 then
		local itemsShow = this.getItemShowsQueue[1].items
		local openType = this.getItemShowsQueue[1].openType
		local callback = this.getItemShowsQueue[1].callback
		local args = this.getItemShowsQueue[1].args

		table.remove(this.getItemShowsQueue, 1)

		if openType == Constant.GetPanelType.Story then
			UIModule.Open(Constant.UIControllerName.StoryGetPanelUI, Constant.UILayer.Mid, {
				items = itemsShow
			})
		elseif openType == Constant.GetPanelType.Maze then
			UIModule.Open(Constant.UIControllerName.MazeGetPanelUI, Constant.UILayer.Mid, {
				items = itemsShow,
				callback = callback,
				args = args
			})
		elseif openType == Constant.GetPanelType.ReturnMaterials then
			UIModule.Open(Constant.UIControllerName.ReturnMaterialsPanelUI, Constant.UILayer.Mid, {
				items = itemsShow,
				callback = callback,
				args = args
			})
		else
			UIModule.Open(Constant.UIControllerName.GetPanelUI, Constant.UILayer.UI, {
				items = itemsShow,
				callback = callback
			})
		end
	end
end

function NoticeModule.CheckItemCanBeShow(itemCid)
	local isSkinItem, _ = SkinModule.IsSkinItemByItemCid(itemCid)

	if isSkinItem then
		return false
	end

	local cfgItem = CfgUtil.GetItemCfgDataWithID(itemCid)

	if cfgItem.IsHide == 1 then
		return false
	end

	return true
end

function NoticeModule.ShowServerError(errorCode)
	log("ErrorCode:" .. errorCode)

	if errorCode == 54001 then
		return
	end

	NoticeModule.ShowNoticeByType(1, getErrorMsg(errorCode))
end

function NoticeModule.__ShowFloatNotice(noticeCid, ...)
	NoticeModule.__TryOpenFloatUpdateAndPlay({
		uiName = Constant.UIControllerName.FloatNoticeUI,
		param = {
			cid = noticeCid,
			args = {
				...
			}
		}
	})
end

function NoticeModule.__ShowRightFloatNotice(noticeCid, ...)
	NoticeModule.__TryOpenFloatUpdateAndPlay({
		uiName = Constant.UIControllerName.RightFloatNoticeUI,
		param = {
			cid = noticeCid,
			args = {
				...
			}
		}
	})
end

function NoticeModule.__TryOpenFloatUpdateAndPlay(floatNoticeData)
	if #NoticeModule.__FloatNoticeDatas > 1 then
		return
	end

	table.insert(NoticeModule.__FloatNoticeDatas, floatNoticeData)

	if NoticeModule.__FloatNoticeTimer == nil then
		NoticeModule.__FloatNoticeTimer = Timer.New(NoticeModule.__UpdateFloatNotice, 1.5, -1)

		NoticeModule.__FloatNoticeTimer:Start()
		NoticeModule.__UpdateFloatNotice()
	end
end

function NoticeModule.__UpdateFloatNotice()
	if #NoticeModule.__FloatNoticeDatas > 0 then
		local floatNoticeData = table.remove(NoticeModule.__FloatNoticeDatas, 1)

		UIModule.Open(floatNoticeData.uiName, Constant.UILayer.Top, floatNoticeData.param, true)
	else
		NoticeModule.__FloatNoticeTimer:Stop()

		NoticeModule.__FloatNoticeTimer = nil
	end
end

function NoticeModule.__ShowAlert(noticeCid, confirmCallback, cancelCallback, from, ...)
	if NoticeModule.__IgnoredList[noticeCid] ~= nil then
		if confirmCallback ~= nil then
			confirmCallback(from)
		end

		return
	end

	UIModule.Open(Constant.UIControllerName.ConfirmationUI, Constant.UILayer.AboveAll, {
		cid = noticeCid,
		confirm = confirmCallback,
		cancel = cancelCallback,
		from = from,
		args = {
			...
		}
	}, true)
end

function NoticeModule._ShowAchievementNotice(content)
	table.insert(NoticeModule.achievementNoticeQueue, content)

	if NoticeModule.achievementNoticeTimer == nil then
		NoticeModule.achievementNoticeTimer = Timer.New(NoticeModule._UpdateAchievementNotice, 1.8, -1)

		NoticeModule.achievementNoticeTimer:Start()
		NoticeModule._UpdateAchievementNotice()
	end
end

function NoticeModule._UpdateAchievementNotice()
	if getCfgTableLength(NoticeModule.achievementNoticeQueue) > 0 then
		local achievementNameString = table.remove(NoticeModule.achievementNoticeQueue, 1)

		if UIModule.HasUI(Constant.UIControllerName.AchievementNoticeUI) then
			EventDispatcher.Dispatch(EventID.AchievementNoticeUIRefresh, achievementNameString)
		else
			UIModule.Open(Constant.UIControllerName.AchievementNoticeUI, Constant.UILayer.Top, {
				content = achievementNameString
			})
		end
	else
		UIModule.Close(Constant.UIControllerName.AchievementNoticeUI)
		NoticeModule.achievementNoticeTimer:Stop()

		NoticeModule.achievementNoticeTimer = nil
	end
end

function NoticeModule._ShowStrengthEffectNotcie(type)
	return
end

function NoticeModule.AddIgnoreID(noticeCid)
	NoticeModule.__IgnoredList[noticeCid] = noticeCid
end

function NoticeModule.AddEventListeners()
	return
end

function NoticeModule.RemoveEventListeners()
	return
end

function NoticeModule.Shutdown()
	NoticeModule.InitMembers()
	NoticeModule.RemoveEventListeners()
end

function NoticeModule.Init()
	NoticeModule.InitMembers()
	NoticeModule.AddEventListeners()
end

function NoticeModule.InitMembers()
	NoticeModule.achievementNoticeQueue = {}
	NoticeModule.getItemShowsQueue = {}
	NoticeModule.isGetPanelUIShow = false
end

function NoticeModule.ShowCurrencyNotEnoughTips(CurrencyItemID)
	local noticeID = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.CurrencyNotEnough, CurrencyItemID)

	if noticeID then
		NoticeModule.ShowNotice(noticeID)
	else
		NoticeModule.ShowNotice(CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.CurrencyNotEnoughNormal))
	end
end

function NoticeModule.OnNoticeGetItem(itemAwards)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAwards)
end
