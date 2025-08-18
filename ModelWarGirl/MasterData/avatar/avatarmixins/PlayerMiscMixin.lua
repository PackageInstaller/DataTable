-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\PlayerMiscMixin.lua

local WebView = require("SDK/Plugin/WebView")
local UserData = require("Helper/UserData")
local ResMall = require("ClientData/ResMall")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local DragPlane = require("UI/Control/Com/DragPlane")
local ResHero = require("ClientData/ResHero")
local ResHeroJumpWay = require("ClientData/ResHeroJumpWay")
local ResJumpGuide = require("ClientData/ResJumpGuide")
local ResGameAssistantPush = require("ClientData/ResGameAssistantPush")
local BattleConst = require("Common/FrameBattle/BattleConst")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local SDKAppUtils = require("SDK/SDKAppUtils")
local PlayerMiscMixin = {}

function PlayerMiscMixin:initPlayerMiscMixin(baseData, syncData)
	self.newDataCache = {}
	self.pushAssistDataCache = {}
	self.pushAssistNoticeCache = {}
end

function PlayerMiscMixin:postinitPlayerMiscMixin(baseData, syncData)
	self:initUserData()
end

function PlayerMiscMixin:jumpToShowActivity(actId, extraStateArgs)
	actId = tonumber(actId)

	local actObj = self:getActivityObj(actId)

	if not actObj or not actObj.clientTemplateData then
		MsgManager.notice(Lang.get(44008))

		return
	end

	local jumpNotice = actObj:checkJumpNotice()

	if jumpNotice then
		MsgManager.notice(jumpNotice)

		return
	end

	local templateConfig = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[actObj.clientTemplateData.template_type]

	if templateConfig then
		actObj:checkWindowReplace()

		if templateConfig[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW then
			local windowUI = UIManager.getUI(templateConfig[1], true)

			windowUI:onShowActivity({
				actObj.clientTemplateData,
				actObj
			})

			if extraStateArgs and windowUI.activityStateShow then
				windowUI:activityStateShow(actObj, extraStateArgs)
			end
		else
			local activityMainDlg = UIManager.getUI("activityMainDlg", true)

			activityMainDlg:openActivity(actId)

			if extraStateArgs then
				activityMainDlg:activityStateShow(actObj, extraStateArgs)
			end
		end
	end
end

function PlayerMiscMixin:jumpToOpenWebUrl(webUrl)
	if not webUrl then
		return
	end

	if ChannelUtil.isQQGame() then
		local forbids = {
			"tb.cn",
			"tmall",
			"taobao",
			"weibo"
		}

		for _, forbid in ipairs(forbids) do
			if string.find(webUrl, forbid) then
				MsgManager.notice(Lang.get(37177))

				return
			end
		end
	end

	WebView.unityOpenUrl(webUrl)
end

function PlayerMiscMixin:openNativeWebView(webUrl)
	if not webUrl then
		return
	end

	WebView.openWebView(webUrl, nil, string.find(webUrl, "?"))
end

Const.NEW_DATA_CACHE_PLOT = 1
Const.NEW_DATA_CACHE_SEASON_TOWER = 2

function PlayerMiscMixin:addNewDataCache(newDataKey, value)
	self.newDataCache[newDataKey] = value
end

function PlayerMiscMixin:getNewDataCache(newDataKey, noDelete)
	local newValue = self.newDataCache[newDataKey]

	if not noDelete then
		self.newDataCache[newDataKey] = nil
	end

	return newValue
end

function PlayerMiscMixin:jumpToInfoNotice(sysId)
	sysId = tonumber(sysId)

	if sysId then
		UIManager.getUI("infoNotice", true):showSystemInfo(sysId)
	end
end

function PlayerMiscMixin:canRefreshHomeRedDot()
	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		local curTime = os.time()

		if curTime - (self.lastRefreshRedDotTime or 0) > 295 then
			self.lastRefreshRedDotTime = curTime

			return true
		else
			return false
		end
	else
		return false
	end
end

function PlayerMiscMixin:jumpToShowItem(itemId, fromUI, ...)
	local itemType = BaseObject.GetObjectType(itemId)

	if itemType == Const.ITEM_TYPE_HERO then
		self:_jumpToHero(itemId, fromUI, ...)
	elseif itemType == Const.ITEM_TYPE_ARTIFACT then
		self:_jumpToArtifact(itemId, fromUI, ...)
	elseif itemType == Const.ITEM_TYPE_RELIC then
		self:_jumpToRelic(itemId, fromUI, ...)
	elseif itemType == Const.ITEM_TYPE_SKIN then
		self:_jumpToSkin(itemId, fromUI, ...)
	elseif itemType == Const.ITEM_TYPE_EQUIP then
		-- block empty
	elseif itemType == Const.ITEM_TYPE_EQUIP_TEMPLETE then
		-- block empty
	elseif itemType == Const.ITEM_TYPE_ITEM then
		self:_jumpToItem(itemId, fromUI, ...)
	end
end

function PlayerMiscMixin:_jumpToHero(heroId, fromUI, proficient)
	if proficient == 1 then
		if ResHeroJumpWay[heroId] then
			local jumpData = ResHeroJumpWay[heroId]

			for _, jumpId in ipairs(jumpData.jump_ids or {}) do
				if JumpGuideManager.canJump(jumpId) then
					JumpGuideManager.jump(jumpId)

					return
				end
			end

			MsgManager.notice(jumpData.notice_desc or "")
		else
			UIManager.getUI("drawCardMainDlg", true):selectDefaultPool()
		end
	elseif proficient <= 11 then
		UIManager.getUI("heroStarUpDlg", true)
	else
		local maxStarHero = self:getHeroMaxPaintHero(heroId)

		if maxStarHero then
			local heroPaintingDlg = UIManager.getUI("heroPaintingDlg", true)

			heroPaintingDlg:setHero(maxStarHero)
		else
			MsgManager.notice(Lang.get(56968))
		end
	end
end

function PlayerMiscMixin:_jumpToArtifact(resId, fromUI, needLevel)
	local artifact = self:getArtifactById(resId)

	if artifact then
		self:openUpgradeEquipDlg(Const.UPGRADE_TYPE_ARTIFACT, artifact)
	else
		UIManager.getUI("handBookArtifactDlg", true)
	end
end

function PlayerMiscMixin:_jumpToRelic(resId, fromUI, needLevel)
	JumpGuideManager.jump(166)
end

function PlayerMiscMixin:_jumpToSkin(resId, fromUI)
	BaseObject.ShowObjectTips(resId, 1, fromUI, {
		noPreview = 1,
		CloseSrcWindow = 1
	})
end

function PlayerMiscMixin:_jumpToItem(resId, fromUI)
	BaseObject.ShowObjectTips(resId, 1, fromUI, {
		CloseSrcWindow = 1,
		AutoOpenGuide = 1
	})
end

Const.USER_KEY_MALL_NEW = "MallNew"
Const.USER_KEY_SEAON_TOWER_BUFF = "STBuff"
Const.USER_KEY_NEW_YEAR_DINNER = "NYDinner"
Const.USER_KEY_ACTIVITY_SHOW = "ActivityShow"
Const.USER_KEY_ACTIVITY_ARTIFACT_SHOW = "ArtifactShow"
Const.USER_KEY_ACTIVITY_ENTER_SHOW = "ActivityEnterShow"
Const.USER_KEY_FUND_DATA = "FundData"
Const.USER_KEY_ACTIVITY_DATA = "ActivityData"
Const.USER_KEY_SECOND_UNLOCK = "SecondUnlock"
Const.USER_KEY_SEA_BBS_NEW = "SeaBBSNewTick"
Const.USER_KEY_ACTIVITY_CHANGED_NEW = "ActivityChangedNew"
Const.USER_KEY_SEASON_PLAY_NEW_OPEN = "ActivitySeasonPlayNewOpen"

function PlayerMiscMixin:initUserData()
	UserData.initClientData(self.uid)
end

function PlayerMiscMixin:getClientUserData(key)
	return UserData.getClientData(key) or {}
end

function PlayerMiscMixin:setClientUserData(key, value)
	UserData.setClientData(key, value)
end

function PlayerMiscMixin:getClientActivityCachedData(actId)
	local actData = UserData.getClientData(Const.USER_KEY_ACTIVITY_DATA) or {}

	return actData[actId] or {}
end

function PlayerMiscMixin:saveClientActivityCachedData(actId, data)
	local actData = UserData.getClientData(Const.USER_KEY_ACTIVITY_DATA) or {}

	actData[actId] = data

	UserData.setClientData(Const.USER_KEY_ACTIVITY_DATA, actData)
end

function PlayerMiscMixin:_checkMallLocked(subTabId, isNewLockCheck)
	local configData = ResMallSubPanelConfig[subTabId]

	if configData then
		if configData.limit_package_name then
			local packageName = SDKAppUtils.getPackageName()

			if packageName == configData.limit_package_name then
				return true
			end
		end

		local inLock = configData.unlockCondition and ConditionLimitManager.inLimitState(configData.unlockCondition)

		if inLock and configData.unlockCondition2 and not ConditionLimitManager.inLimitState(configData.unlockCondition2) then
			inLock = false
		end

		if (GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_TMALL) == 1 or VersionUtils.IsReviewVersion()) and (configData.pageType == Const.MALL_TYPE_JUMP_TMALL or configData.pageType == Const.MALL_TYPE_MULTI_TMALL) then
			return true
		end

		if not inLock then
			if configData.limitTypeExtra then
				if configData.limitTypeExtra == 1 or configData.limitTypeExtra == 3 then
					local actId = configData.limitConditionExtra
					local actObj = self:getActivityObj(actId)

					if actObj and actObj:isValid() then
						return false
					end
				elseif configData.limitTypeExtra == 2 then
					return false
				end
			elseif configData.pageType == Const.MALL_TYPE_GIFT_RECOMMEND then
				return next(self:getValidRechargeGuideData()) == nil
			elseif not self.welfareHide[configData.pageType] then
				if configData.pageType == Const.WELFARETYPE_FUND and isNewLockCheck then
					local cruFundStep = self.fundSvrData.season

					if configData.value1 == cruFundStep then
						return false
					end
				else
					return false
				end
			end
		end
	end

	return true
end

function PlayerMiscMixin:_checkMallSubTabNew(subTabId)
	local configData = ResMallSubPanelConfig[subTabId]

	if configData and configData.needNoticeNew == 1 and not self:_checkMallLocked(subTabId, true) then
		local mallNew = UserData.getClientData(Const.USER_KEY_MALL_NEW) or {}

		if not mallNew[subTabId] then
			return true
		end
	end
end

function PlayerMiscMixin:checkUserDataMallNew()
	for tabId, tabInfo in pairs(ResMall) do
		for _, subId in ipairs(tabInfo.contents or {}) do
			local hId = UIConst.RD_MALL_NEW_SUB_TAB[subId]

			if hId then
				if self:_checkMallSubTabNew(subId) then
					RedDotManager.setKeyState(hId, true)
				else
					RedDotManager.setKeyState(hId, false)
				end
			end
		end
	end
end

function PlayerMiscMixin:setUserDataMallNew(subId)
	local hId = UIConst.RD_MALL_NEW_SUB_TAB[subId]

	if hId then
		local mallNew = UserData.getClientData(Const.USER_KEY_MALL_NEW) or {}

		if not mallNew[subId] then
			mallNew[subId] = 1

			UserData.setClientData(Const.USER_KEY_MALL_NEW, mallNew)
		end

		RedDotManager.setKeyState(hId, false)
	end
end

function PlayerMiscMixin:checkActEnterAVG(actObj)
	if actObj and actObj.clientTemplateData and actObj.clientTemplateData.act_enter_avg then
		local hasShowTable = UserData.getClientData(Const.USER_KEY_ACTIVITY_ENTER_SHOW) or {}

		if not hasShowTable[actObj.actId] then
			CueManager.stopVocal()

			local avgId = tonumber(actObj.clientTemplateData.act_enter_avg)

			if avgId then
				UIManager.playAVG(avgId)
			else
				UIManager.getUI("sequenceFramePlayer", true):playVideo(actObj.clientTemplateData.act_enter_avg, nil, nil, true, true)
			end

			hasShowTable[actObj.actId] = 1

			UserData.setClientData(Const.USER_KEY_ACTIVITY_ENTER_SHOW, hasShowTable)
		end
	end
end

function PlayerMiscMixin:clickDragMonster(pos)
	local pos = tonumber(pos)

	if pos and DragPlane.fieldObjs[pos] then
		DragPlane.onDragClick(DragPlane.fieldObjs[pos], pos)
	end
end

function PlayerMiscMixin:beginnerCheckRebackGroup()
	if self.unchooseRebackGroup then
		UIManager.getUI("returnConfirmDlg", true)
	end
end

function PlayerMiscMixin:_countJPH5ActivityClick(url)
	if RegionUtils.isJP() and (ResJumpGuide[184].param_2 == url or ResJumpGuide[185].param_2 == url) then
		local h5ActivityClickJP = UserData.loadCommonData("h5ActivityClickJP" .. CurAvatar.uid)
		local index = 0

		if h5ActivityClickJP ~= nil and h5ActivityClickJP ~= "" then
			index = tonumber(h5ActivityClickJP)
		end

		index = index + 1

		UserData.saveCommonData("h5ActivityClickJP" .. CurAvatar.uid, index)

		local commonData = Analytics.getByteSendLogPubParameter()

		commonData.click_time = index

		Analytics.sendLogByted("h5ActivityClickJP", ClientUtils.table2String(commonData))
	end
end

local BATTLE_FAIL_COMMON_HANDLE_DIC = {
	[BattleConst.BATTLE_TYPE_EQUIPTOWER] = true,
	[BattleConst.BATTLE_TYPE_BOSSTOWER] = true,
	[BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND] = true
}

function PlayerMiscMixin:checkGameAssistant(type, needData, showNoticeImmediately)
	if Const.GAME_ASSISTANT_OPEN then
		if type == Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail then
			for i, data in ipairs(ResGameAssistantPush) do
				if data.condition == Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail and needData.battleType == data.arg1[1] then
					if BATTLE_FAIL_COMMON_HANDLE_DIC[needData.battleType] then
						local tType = data.arg2[1]
						local layerPre = data.arg2[2]
						local layer = data.arg2[3]

						if tType and layer and layerPre then
							local myType, myLayer = self:getBattleSpecData(needData)

							if tonumber(tType) == myType and myLayer <= tonumber(layer) and myLayer >= tonumber(layerPre) then
								self:setAssistantUserData(type, data, showNoticeImmediately)

								break
							end
						else
							self:setAssistantUserData(type, data, showNoticeImmediately)

							break
						end
					elseif needData.battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
						local layerPre = data.arg2[1]
						local layer = data.arg2[2]

						if layer and layerPre then
							local myType, myLayer = self:getBattleSpecData(needData)

							if myLayer <= tonumber(layer) and myLayer >= tonumber(layerPre) then
								self:setAssistantUserData(type, data, showNoticeImmediately)

								break
							end
						else
							self:setAssistantUserData(type, data, showNoticeImmediately)

							break
						end
					elseif needData.battleType == BattleConst.BATTLE_TYPE_STAGE then
						if data.arg2 then
							local seasonPre = data.arg2[1]
							local chapterPre = data.arg2[2]
							local levelPre = data.arg2[3]
							local season = data.arg2[4]
							local chapter = data.arg2[5]
							local level = data.arg2[6]

							if seasonPre and chapterPre and levelPre and season and chapter and level then
								if self:mainStageStatePassed(tonumber(seasonPre), tonumber(chapterPre), tonumber(levelPre)) and not self:mainStageStatePassed(tonumber(season), tonumber(chapter), tonumber(level)) then
									self:setAssistantUserData(type, data, showNoticeImmediately)

									break
								end
							else
								self:setAssistantUserData(type, data, showNoticeImmediately)

								break
							end
						end
					else
						self:setAssistantUserData(type, data, showNoticeImmediately)

						break
					end
				end
			end
		elseif type == Const.GAME_ASSISTANT_TRIGGER_TYPE.PassMainStage then
			for i, data in ipairs(ResGameAssistantPush) do
				if data.condition == Const.GAME_ASSISTANT_TRIGGER_TYPE.PassMainStage then
					local season = data.arg1[1]
					local chapter = data.arg1[2]
					local level = data.arg1[3]

					if self.mainStageCur.season == season and self.mainStageCur.chapter == chapter and self.mainStageCur.level == level then
						self:setAssistantUserData(type, data, showNoticeImmediately)

						break
					end
				end
			end
		elseif type == Const.GAME_ASSISTANT_TRIGGER_TYPE.WorldBossChange or type == Const.GAME_ASSISTANT_TRIGGER_TYPE.ActOpen or type == Const.GAME_ASSISTANT_TRIGGER_TYPE.BeginnerFinish then
			for i, data in ipairs(ResGameAssistantPush) do
				if data.condition == type and data.arg1[1] and (needData.arg == data.arg1[1] or needData.arg == tonumber(data.arg1[1])) then
					self:setAssistantUserData(type, data, showNoticeImmediately)

					break
				end
			end
		end
	end
end

function PlayerMiscMixin:getBattleSpecData(battleData)
	if battleData.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		return battleData.specData.type or 1, battleData.specData.layer or 1
	elseif battleData.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		local layer, percent = self:getBossTowerBattleResult(battleData.specData.settle)

		return battleData.specData.type or 1, layer or 1
	elseif battleData.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		return battleData.specData.towerId or 1, battleData.specData.layer or 1
	elseif battleData.battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
		return nil, battleData.specData.layer or 1
	end
end

function PlayerMiscMixin:getBossTowerBattleResult(settle)
	local percent = settle % 100000 / 100
	local layer = math.floor(settle / 100000)

	return layer, percent .. "%"
end

function PlayerMiscMixin:clearBattleAssistantUserData(battleType)
	local assistStr = UserData.loadCommonData("GameAssistant" .. self.uid)
	local assistTable = ClientUtils.string2Table(assistStr) or {}

	if assistTable[Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail] then
		for _, v in pairs(assistTable[Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail]) do
			if v.battleType and v.battleType == battleType then
				v.failTimes = 0

				break
			end
		end
	end

	UserData.saveCommonData("GameAssistant" .. self.uid, ClientUtils.table2String(assistTable))
end

function PlayerMiscMixin:setAssistantUserData(type, data, showNoticeImmediately)
	local assistStr = UserData.loadCommonData("GameAssistant" .. self.uid)
	local assistTable = ClientUtils.string2Table(assistStr) or {}

	if assistTable[type] == nil then
		assistTable[type] = {}
	end

	if type == Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail then
		local haveRecord = false
		local pushFailTimes = tonumber(data.arg1[2] or 3)

		for _, v in pairs(assistTable[type]) do
			if v.battleType and v.battleType == data.arg1[1] then
				v.failTimes = v.failTimes + 1
				haveRecord = true

				if pushFailTimes <= v.failTimes then
					v.failTimes = 0

					self:addPushAssistant(data, showNoticeImmediately)
				end

				break
			end
		end

		if not haveRecord then
			if pushFailTimes == 1 then
				self:addPushAssistant(data, showNoticeImmediately)
			else
				table.insert(assistTable[type], {
					failTimes = 1,
					battleType = data.arg1[1]
				})
			end
		end
	elseif type == Const.GAME_ASSISTANT_TRIGGER_TYPE.PassMainStage then
		if assistTable[type][data.id] == nil then
			assistTable[type][data.id] = true

			self:addPushAssistant(data, showNoticeImmediately)
		end
	elseif type == Const.GAME_ASSISTANT_TRIGGER_TYPE.WorldBossChange then
		if assistTable[type].bossId == nil or assistTable[type].bossId ~= tonumber(data.arg1[1]) then
			assistTable[type].bossId = tonumber(data.arg1[1])

			self:addPushAssistant(data, showNoticeImmediately)
		end
	elseif type == Const.GAME_ASSISTANT_TRIGGER_TYPE.ActOpen or type == Const.GAME_ASSISTANT_TRIGGER_TYPE.BeginnerFinish then
		local needPush = true

		for _, v in pairs(assistTable[type]) do
			if v == data.arg1[1] or v == tonumber(data.arg1[1]) then
				needPush = false

				break
			end
		end

		if needPush then
			table.insert(assistTable[type], data.arg1[1])
			self:addPushAssistant(data, showNoticeImmediately)
		end
	end

	UserData.saveCommonData("GameAssistant" .. self.uid, ClientUtils.table2String(assistTable))
end

function PlayerMiscMixin:addPushAssistant(data, showNoticeImmediately)
	table.insert(self.pushAssistDataCache, data)
	table.insert(self.pushAssistNoticeCache, data)
	RedDotManager.setKeyState(UIConst.RD_HINT_GAME_ASSISTANT, #self.pushAssistDataCache >= 1)

	local assistHistoryStr = UserData.loadCommonData("GameAssistantHistory" .. self.uid)
	local assistHistoryTable = ClientUtils.string2Table(assistHistoryStr) or {}

	if not utils.tableIsContainsElement(assistHistoryTable, data.assist_id) then
		table.insert(assistHistoryTable, data.assist_id)
	end

	UserData.saveCommonData("GameAssistantHistory" .. self.uid, ClientUtils.table2String(assistHistoryTable))

	if showNoticeImmediately then
		self:checkShowGameAssistNotice()
	end
end

function PlayerMiscMixin:checkShowGameAssistNotice()
	if #self.pushAssistNoticeCache >= 1 then
		local pushData = self.pushAssistNoticeCache[#self.pushAssistNoticeCache]
		local noticeDlg = UIManager.tryGetUI("gameAssistantNoticeDlg")

		noticeDlg = noticeDlg or UIManager.getUI("gameAssistantNoticeDlg", true)

		noticeDlg:setData(pushData)
		table.remove(self.pushAssistNoticeCache, #self.pushAssistNoticeCache)
	end
end

return PlayerMiscMixin
