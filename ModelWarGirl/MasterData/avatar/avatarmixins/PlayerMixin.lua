-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\PlayerMixin.lua

local ResItem = require("ClientData/ResItem")
local UIManager = UIManager
local EventCenter = EventCenter
local Hero = require("Common/Object/Hero")
local EventConst = require("EventConst")
local ResPowerMisc = require("ClientData/ResPowerMisc")
local ResPower = require("ClientData/ResPower")
local ResBagMisc = require("ClientData/ResBagMisc")
local ResRoleAttr = require("ClientData/ResRoleAttr")
local ResClientNotice = require("ClientData/ResClientNotice")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResStageMisc = require("ClientData/ResStageMisc")
local Analytics = require("SDK/Analytics")
local VersionUtils = require("System/VersionUtils")
local SDKConst = require("SDK/SDKConst")
local ResponseCode = SDKConst.ResponseCode
local UserData = require("Helper/UserData")
local DeviceHelper = require("Helper/DeviceHelper")
local PlayerMixin = {}

function PlayerMixin:initBasePlayerMixin(baseData)
	self.cachedActivityBonusFunc = {}
	self.mPlayerMoney = {}

	if baseData.necessary.misc.test_type then
		-- block empty
	end

	self:initOweData(baseData.necessary.owe_item)
	self:initGeneralAttrData(baseData.attr)
	self:initCounterData(baseData.necessary.counter)
end

function PlayerMixin:postinitPlayerMixin(baseData, syncData)
	self:initPowerData(baseData.necessary.misc.power_refresh)
	self:initStageEnergyData(baseData.necessary.misc.energy_refresh)

	self.isGs = baseData.necessary.misc.is_gs == 1
end

function PlayerMixin:onGagGSInfoNotify(isgs)
	self.isGs = isgs == 1
end

function PlayerMixin:onGagGSSetGagResp(status, end_time)
	if status == 1 then
		if end_time == 0 then
			MsgManager.notice(Lang.get(1879))
		else
			local t = end_time - ClientUtils.getServerTime()

			if t > 0 then
				MsgManager.notice(string.format(Lang.get(1874), utils.calcTimeTxt(t)))
			else
				MsgManager.notice(Lang.get(1880))
			end
		end
	end
end

local COMMON_NOTICE_TYPE_DICT = {
	[Const.LISTATTR_USETYPE_ACHIEVE] = true,
	[Const.LISTATTR_USETYPE_TASK] = true,
	[Const.LISTATTR_USETYPE_BP] = true,
	[Const.LISTATTR_USETYPE_FIRST_RECHARGE] = true,
	[Const.LISTATTR_USETYPE_OPACT_ACHIEVE] = true,
	[Const.LISTATTR_USETYPE_OPACT] = true,
	[Const.LISTATTR_USETYPE_BOSSTOWER_SWEEP] = true,
	[Const.LISTATTR_USETYPE_SEASONTOWER_ACHIEVE] = true,
	[Const.LISTATTR_USETYPE_QQ_BLUE] = true,
	[Const.LISTATTR_USETYPE_CLAN_CLEAR] = true,
	[Const.LISTATTR_USETYPE_REBACK] = true,
	[Const.LISTATTR_USETYPE_COMMON] = true,
	[Const.LISTATTR_USETYPE_MASTER_APPRENTICE] = true
}
local COMMON_RESULT_UI_DICT = {
	[Const.LISTATTR_USETYPE_FUND] = "fundResultBox",
	[Const.LISTATTR_USETYPE_BP] = "bpResultBox"
}
local COMMON_RESULT_NORMAL = {
	[Const.LISTATTR_USETYPE_OPACT_WISHSIGNIN] = true,
	[Const.LISTATTR_USETYPE_RECHARGE_MULITY_GETAWARD] = true,
	[Const.LISTATTR_USETYPE_ADVANCE_TASK] = true
}
local COMMON_RESULT_UI_NOCOMMON = {
	"activityAchievePubDlg",
	"activityLotteryGetCodeDlg"
}
local COMMON_ACTIVITY_TYPE_DICT = {
	[Const.LISTATTR_USETYPE_SHOP] = true,
	[Const.LISTATTR_USETYPE_OPACT_ACHIEVE] = true
}

function PlayerMixin:preHandleList(notifyType, attrs, items, heros, equip, artifact, special, param, relic, info)
	if special and #special > 0 then
		local newItems = {}

		for _, idNum in ipairs(items) do
			table.insert(newItems, idNum)
		end

		for _, idNum in ipairs(special) do
			if ResItem[idNum.id] then
				table.insert(newItems, idNum)
			end
		end

		return newItems
	else
		return items
	end
end

function PlayerMixin:onListAttrNotify(notifyType, attrs, items, heros, equip, artifact, special, param, relic, info, pets, petAmulets, petGems)
	items = self:preHandleList(notifyType, attrs, items, heros, equip, artifact, special, param, relic, info)

	if notifyType == Const.LISTATTR_USETYPE_OPACT_ACHIEVE or notifyType == Const.LISTATTR_USETYPE_OPACT then
		self:onNotifyActBonus(attrs, items)

		if self.cachedActivityBonusFunc[param] then
			self.cachedActivityBonusFunc[param]({
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic
			})

			return
		end
	end

	self:onNotifyBattleBonus(notifyType, attrs, items, heros, equip, artifact, relic, param, petGems)

	if info and info.relic_gift ~= 0 then
		self:_showRelicPkgResult(items, relic, info.relic_gift)
	elseif notifyType == Const.LISTATTR_USETYPE_PVETOWER_SWEEP then
		local sweepMainDlg = UIManager.getUI("sweepMainDlg", nil, false)

		if sweepMainDlg then
			sweepMainDlg:onShow(notifyType, attrs, items, heros, equip, artifact)
		else
			self:onGetBonusNotice("commonBonusDlg", "onShow", {
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic,
				Lang.get(1747)
			})
			CurAvatar:refreshHeroDetail()
		end
	elseif notifyType == Const.LISTATTR_USETYPE_EQUIP_RECYCLE then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(1815)
		})
	elseif notifyType == Const.LISTATTR_USETYPE_BOSS_EXPAND_SWEEP then
		local sweepMainDlg = UIManager.getUI("sweepMainDlg", nil, false)

		if sweepMainDlg then
			sweepMainDlg:onShow(notifyType, attrs, items, heros, equip, artifact)
		else
			local heroShowRoomGrowUpDlg = UIManager.getUI("heroShowRoomGrowUpDlg", nil, false)

			if heroShowRoomGrowUpDlg then
				self:onGetBonusNotice("commonBonusDlg", "onShow", {
					notifyType,
					attrs,
					items,
					heros,
					equip,
					artifact,
					relic,
					Lang.get(1747)
				})
			end
		end
	elseif notifyType == Const.LISTATTR_USETYPE_EQUIPTOWER_SWEEP then
		UIManager.getUI("sweepMainDlg", true):onShow(notifyType, attrs, items, heros, equip, artifact)
	elseif notifyType == Const.LISTATTR_USETYPE_SEASONTOWER_SWEEP then
		UIManager.getUI("activitySeasonTowerSweepDlg", true):onShow(attrs, items, heros, equip, artifact, relic)
	elseif notifyType == Const.LISTATTR_USETYPE_BOSSTOWER_AWARD then
		UIManager.getUI("mailResultDlg", true):onShow(attrs, items, heros, equip, artifact)
	elseif notifyType == Const.LISTATTR_USETYPE_MAIL then
		self:receiveAttachments(attrs, items, heros, equip, artifact)
		self:_showListAttrHeros(heros)
	elseif notifyType == Const.LISTATTR_USETYPE_MONTH_CARD then
		self.cacherecharge = self.cacherecharge or {}

		local atttab = {}

		atttab.attr = attrs
		atttab.item = items
		atttab.equip = equip
		atttab.artifact = artifact

		table.insert(self.cacherecharge, atttab)
	elseif notifyType == Const.LISTATTR_USETYPE_WEEKLYTASK then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(1881)
		})
	elseif COMMON_ACTIVITY_TYPE_DICT[notifyType] then
		self:onGetActivityBonus(param, {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(1714)
		})
		self:_showListAttrHeros(heros)
	elseif notifyType == Const.LISTATTR_USETYPE_DRAW then
		self:_receiveDrawHeroData(attrs, items, heros, equip, artifact)
	elseif notifyType == Const.LISTATTR_USETYPE_OPACT_DRAW then
		self:_receiveOpDrawAward(attrs, items, heros, equip, artifact)
	elseif notifyType == Const.LISTATTR_USETYPE_RECYCLE then
		self:_receiveRecycleHeroData(attrs, items)
	elseif notifyType == Const.LISTATTR_USETYPE_ASYNC_PVP_SWEEP then
		if #attrs > 0 then
			self.pvpSweepAward = attrs
		end
	elseif notifyType == Const.LISTATTR_USETYPE_ITEMUSE then
		if self.showHighBonusDlg then
			self.showHighBonusDlg = nil

			self:onGetBonusNotice("commonBonusHigherDlg", "onShow", {
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic
			})
		else
			local checkHaveData = false

			checkHaveData = utils.getTableElemCount(attrs) > 0 or utils.getTableElemCount(items) > 0 or utils.getTableElemCount(heros) > 0 or utils.getTableElemCount(equip) > 0 or utils.getTableElemCount(artifact) > 0 or utils.getTableElemCount(relic) > 0

			if checkHaveData then
				self:onGetBonusNotice("commonBonusDlg", "onShow", {
					notifyType,
					attrs,
					items,
					heros,
					equip,
					artifact,
					relic,
					Lang.get(1881)
				})
			end
		end
	elseif notifyType == Const.LISTATTR_USETYPE_REAR_HOUSE_UNLOCK then
		self.rearHouseState.unlock_award = 1
	elseif notifyType == Const.LISTATTR_USETYPE_ITEM_COMPOUND then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(1882)
		})
	elseif notifyType == Const.LISTATTR_USETYPE_COMFORT_AWARD then
		if self.showComfortAwardPanel == true then
			self:onGetBonusNotice("commonBonusDlg", "onShow", {
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic,
				Lang.get(1881),
				Slot(self._refreshComfortData, self)
			})
		end
	elseif notifyType == Const.LISTATTR_USETYPE_VIP then
		self:_showListAttrHeros(heros)
		UIManager.getUI("vipAwardDlg", true):onShow(param, attrs, items, heros, equip, artifact, relic)
	elseif notifyType == Const.LISTATTR_USETYPE_MAZE_SWEAP then
		local itemObjs = ClientUtils.getAllClientItems(attrs, items, heros, equip, artifact, relic)

		self:checkShowMazeSweapAward(itemObjs)
	elseif notifyType == Const.LISTATTR_USETYPE_SNEAK_BATTLE then
		self:onGetBonusNotice("commonBonusHigherDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		})
	elseif notifyType == Const.LISTATTR_USETYPE_OPACT_SHARE then
		self:onGetBonusNotice("commonBonusHigherDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		})
	elseif notifyType == Const.LISTATTR_USETYPE_RENT_BATTLE then
		self.rentBattleResultCache = {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		}
	elseif COMMON_RESULT_UI_DICT[notifyType] then
		if items and #items > 0 or equip and #equip > 0 or artifact and #artifact > 0 or relic and #relic > 0 then
			UIManager.getUI(COMMON_RESULT_UI_DICT[notifyType], true):onShow(attrs, items, heros, equip, artifact, nil, nil, relic)
		else
			self:_showNoticeBonus(attrs, items, heros, equip, artifact, relic)
		end

		self:_showListAttrHeros(heros)
	elseif COMMON_RESULT_NORMAL[notifyType] then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		})
	elseif notifyType == Const.LISTATTR_USETYPE_HERO_EQUIP then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(49697)
		})
	elseif notifyType == Const.LISTATTR_USETYPE_OPACT and self:hookActivityBonus(param, attrs, items, heros, equip, artifact, relic) then
		-- block empty
	elseif notifyType == Const.LISTATTR_USETYPE_COLLECT_WORDS then
		if self:hookActivityBonus(param, attrs, items, heros, equip, artifact, relic, notifyType) then
			-- block empty
		elseif param == 27 then
			local function onClose()
				local mainDlg = UIManager.tryGetUI("activityCollectWordsDlg")

				if mainDlg then
					mainDlg:checkMergeWords()
				end
			end

			self:onGetBonusNotice("commonBonusCollectWordsDlg", "onShow", {
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic,
				Lang.get(338),
				onClose
			})
		else
			self:onGetBonusNotice("commonBonusCollectWordsDlg", "onShow", {
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic
			})
		end
	elseif COMMON_NOTICE_TYPE_DICT[notifyType] then
		if notifyType == Const.LISTATTR_USETYPE_ACHIEVE then
			local achieveId = param

			if self:isShareAchieve(achieveId) then
				self:onGetBonusNotice("commonBonusHigherDlg", "onShow", {
					notifyType,
					attrs,
					items,
					heros,
					equip,
					artifact,
					relic
				})

				return
			end

			if self.trunkAchieveChangeStage then
				local function showBonusCB()
					local dlg = UIManager.getUI("achieveMainDlg", nil, false)

					if dlg and dlg:curPageIsAchieve() then
						local achievPage = dlg:getCurPage()

						if achievPage then
							achievPage:showChangeStage()
						end
					end
				end

				self:showCommonBonus(notifyType, attrs, items, heros, equip, artifact, relic, nil, showBonusCB)

				self.trunkAchieveChangeStage = nil

				return
			end
		end

		local defaultFuncOver = false

		for i, uitemp in ipairs(COMMON_RESULT_UI_NOCOMMON) do
			local ui = UIManager.tryGetUI(uitemp)

			if ui then
				if ui:getSpecialBonus(notifyType, attrs, items, heros, equip, artifact, relic) then
					defaultFuncOver = true
				end

				break
			end
		end

		if not defaultFuncOver then
			self:showCommonBonus(notifyType, attrs, items, heros, equip, artifact, relic)
		end

		self:_showListAttrHeros(heros)
	elseif notifyType == Const.LISTATTR_USETYPE_DUPID_CONVERT then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(62977)
		})
	elseif notifyType == Const.LISTATTR_USETYPE_PET_RECYCLE then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(80640)
		})
	elseif notifyType == Const.LISTATTR_USETYPE_MINI_GAME then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(1881)
		})
		self:_showListAttrHeros(heros)
	elseif notifyType == Const.LISTATTR_USETYPE_FIRST_SUBSCRIBE then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic,
			Lang.get(338)
		})
	elseif notifyType == Const.LISTATTR_USETYPE_SEASON_DRAW_SKIN then
		if special and special[1] then
			local ui = UIManager.tryGetUI("seasonPlaySkinPoolDlg")

			if ui and ui:getVisible() then
				ui:onGetSkin(special[1].id)
			end
		end

		if items and items[1] then
			local item = BaseObject.GetObject(items[1].id)

			if item.subType == Const.ITEM_STYPE_UPGRADE_SKIN then
				self:onGetBonusNotice("commonBonusDlg", "onShow", {
					notifyType,
					attrs,
					items,
					heros,
					equip,
					artifact,
					relic,
					Lang.get(338)
				})
			end
		end
	end
end

function PlayerMixin:showCommonBonus(notifyType, attrs, items, heros, equip, artifact, relic, title, closeCb, openCb)
	if items and #items > 0 or equip and #equip > 0 or artifact and #artifact > 0 or relic and #relic > 0 then
		if openCb then
			self:onGetBonusNotice("commonBonusDlg", "onShow", {
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic,
				title,
				closeCb,
				openCb
			})
		else
			self:onGetBonusNotice("commonBonusDlg", "onShow", {
				notifyType,
				attrs,
				items,
				heros,
				equip,
				artifact,
				relic,
				title,
				closeCb
			})
		end
	else
		self:_showNoticeBonus(attrs, items, heros, equip, artifact, relic)

		if closeCb then
			closeCb()
		end
	end
end

function PlayerMixin:setCacheActivityBonus(opId, cb)
	self.cachedActivityBonusFunc[opId] = cb
end

function PlayerMixin:_refreshComfortData(...)
	local ui = UIManager.getUI("rearHouseComfortableDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function PlayerMixin:onGetBonusNotice(uiName, funcName, args)
	UIManager.onGetBonusNotice(uiName, funcName, args)
end

function PlayerMixin:_showListAttrHeros(heros)
	if #heros > 0 then
		local showHeros = {}

		for _, heroInfo in ipairs(heros) do
			local newHero = Hero(heroInfo)

			table.insert(showHeros, newHero)
		end

		self:showLimitStarHeroForGetNewDlg(showHeros)
	end
end

function PlayerMixin:_showRelicPkgResult(items, relic, packId)
	local relicPackOpenDlg = UIManager.getUI("relicPackOpenDlg", true)

	relicPackOpenDlg:setRelicPkgResult(items, relic, packId)

	local activityMallUI = UIManager.getUI("activityMallDlg", nil, false)

	if activityMallUI and activityMallUI.subPanels[Const.WELFARETYPE_RELICSHOP] then
		activityMallUI.subPanels[Const.WELFARETYPE_RELICSHOP]:_refreshAllItems(true)
	end
end

function PlayerMixin:_showNoticeBonus(attrs, items, heros, equip, artifact, relic)
	local itemObjs = ClientUtils.getAllClientItems(attrs, items, heros, equip, artifact, relic)

	for _, itemObj in ipairs(itemObjs) do
		MsgManager.notice(utils.format(Lang.get(1876), itemObj.num, itemObj.name or ""))
	end
end

local GENRERAL_ATTR_UPDATE_MAP = {
	[Const.MONEY_TYPE_LEVEL] = "onLevelChanged",
	[Const.MONEY_TYPE_EXP] = "onExpChanged",
	[Const.MONEY_TYPE_GOLD] = "onGoldChanged"
}
local UPDATE_UI_MAP = {
	[Const.MONEY_TYPE_LEVEL] = {
		"mainMenu"
	},
	[Const.MONEY_TYPE_GOLD] = {
		"mallDlg"
	},
	[Const.MONEY_TYPE_DIAMOND] = {
		"mallDlg"
	},
	[Const.MONEY_TYPE_DIAMOND_BUY] = {
		"mallDlg"
	},
	[Const.MONEY_TYPE_POWER] = {
		"mallDlg"
	},
	[Const.MONEY_TYPE_PVP_SCORE] = {
		"pvpMainDlg"
	}
}

function PlayerMixin:initOweData(data)
	self.mPlayerMoneyOwe = {}

	for _, info in ipairs(data.item) do
		self.mPlayerMoneyOwe[info.id] = info.num
	end
end

function PlayerMixin:initGeneralAttrData(data, reFreshUI)
	local updateUIs = {}

	for _, attrUnit in ipairs(data) do
		local moneyType = attrUnit.type
		local moneyValue = attrUnit.value
		local oldValue = self.mPlayerMoney[moneyType]

		if oldValue == nil or oldValue ~= moneyValue then
			self.mPlayerMoney[moneyType] = moneyValue

			local updateFuncName = GENRERAL_ATTR_UPDATE_MAP[moneyType]

			if updateFuncName and self[updateFuncName] then
				self[updateFuncName](self, oldValue)
			end

			local uiNames = UPDATE_UI_MAP[moneyType]

			if uiNames ~= nil then
				for inx, uiName in ipairs(uiNames) do
					updateUIs[uiName] = true
				end
			end
		end

		if moneyType == Const.MONEY_TYPE_POWER then
			self.realPowerNum = self.mPlayerMoney[Const.MONEY_TYPE_POWER]
		elseif moneyType == Const.MONEY_TYPE_ENERGY then
			self.realEnergyNum = self.mPlayerMoney[Const.MONEY_TYPE_ENERGY]
		elseif moneyType == Const.MONEY_TYPE_VIP then
			if not self.lastVIPExperienceNum then
				self.lastVIPExperienceNum = self:getMoneyByType(Const.MONEY_TYPE_VIP)
			end

			self:sendLogFirstPay(attrUnit)
		end

		if reFreshUI and Const.MONEY_TYPE2ID[moneyType] then
			if moneyType == Const.MONEY_TYPE_DIAMOND or moneyType == Const.MONEY_TYPE_DIAMOND_BUY then
				self:onItemUpdateMoneyNotify(moneyType, self:getDiamondShowNum())
			else
				self:onItemUpdateMoneyNotify(moneyType, moneyValue)
			end
		end
	end

	if reFreshUI then
		self:timerPowerResumeFunc()

		for uiName, _ in pairs(updateUIs) do
			local ui = UIManager.getUI(uiName, nil, false)

			if ui and ui.onUpdateAttrChanged then
				ui:onUpdateAttrChanged()
			end
		end
	end
end

function PlayerMixin:sendLogFirstPay(attrUnit)
	if tonumber(self.lastVIPExperienceNum) == 0 and attrUnit and attrUnit.value and tonumber(attrUnit.value) > 0 then
		self.lastVIPExperienceNum = self:getMoneyByType(Const.MONEY_TYPE_VIP)

		if RegionUtils.isSEA() then
			local data = Analytics.getBiliSeaSendLogPubParameter()

			data.payamount = self.lastVIPExperienceNum

			ChannelUtil.doAnyFunction("appsflyerTrackEventKey", {
				eventName = "af_first_purchase",
				eventValue = ClientUtils.table2String(data)
			})
			ChannelUtil.doAnyFunction("firebaseTrackEventKey", {
				eventName = "G_first_purchase",
				eventValue = ClientUtils.table2String(data)
			})
		else
			SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.FIRST_PAY, nil)
		end
	end
end

function PlayerMixin:onLevelChanged(oldValue)
	if oldValue ~= nil then
		self.preActLevel = oldValue

		local newLevel = self:getLevel()

		SvrListManager.changedLvOrHeadId(newLevel, nil)
		ConditionLimitManager.triggerLevelCondition(newLevel)
		SDKAgent.onRoleLevelUp()
		EventCenter.sendEvent(EventConst.LEVEL_CHANGE, newLevel)
		self:onActLevlEffect()
		self:refreshPlayerInfoUI()
	end
end

function PlayerMixin:onActLevlEffect()
	if not GameFsm.isInState(Const.STATE_MAIN) then
		return
	end

	if self.preActLevel then
		UIManager.getUI("levelUpDlg", true):onLevelUp(self.preActLevel, self:getLevel())

		self.preActLevel = nil
	end
end

function PlayerMixin:showCachedClientAct()
	self:onActLevlEffect()
end

function PlayerMixin:destroyPlayerMixin()
	if self.timerPowerResume then
		self.timerPowerResume:Stop()

		self.timerPowerResume = nil
	end

	if self.timerPowerResumeInit then
		self.timerPowerResumeInit:Stop()

		self.timerPowerResumeInit = nil
	end

	if self.timerStageEnergyResume then
		self.timerStageEnergyResume:Stop()

		self.timerStageEnergyResume = nil
	end
end

function PlayerMixin:onExpChanged(oldValue)
	if oldValue then
		self:refreshPlayerInfoUI()
	end
end

function PlayerMixin:onGoldChanged(oldValue)
	return
end

function PlayerMixin:onPowerChanged(oldValue)
	return
end

function PlayerMixin:getMoneyByType(moneyType)
	return (self.mPlayerMoney[moneyType] or 0) - self:getOweMoneyByType(moneyType)
end

function PlayerMixin:getOweMoneyByType(moneyType)
	local id = Const.MONEY_TYPE2ID[moneyType]

	if id then
		return self.mPlayerMoneyOwe[id] or 0
	end

	return 0
end

function PlayerMixin:getDiamondShowNum(...)
	if RegionUtils.isKR() then
		if self:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY) < 0 then
			return self:getMoneyByType(Const.MONEY_TYPE_DIAMOND)
		else
			return self:getMoneyByType(Const.MONEY_TYPE_DIAMOND) + self:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY)
		end
	else
		return self:getMoneyByType(Const.MONEY_TYPE_DIAMOND) + self:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY)
	end
end

function PlayerMixin:getLevel()
	local level = self:getMoneyByType(Const.MONEY_TYPE_LEVEL)

	level = level > Const.PLAYER_MAX_LEVEL and Const.PLAYER_MAX_LEVEL or level

	return level
end

function PlayerMixin:getExp()
	return self:getMoneyByType(Const.MONEY_TYPE_EXP)
end

function PlayerMixin:getPvpScore()
	return self:getMoneyByType(Const.MONEY_TYPE_PVP_SCORE)
end

function PlayerMixin:onRoleOweItemNotify(item)
	self.mPlayerMoneyOwe = {}

	for _, info in ipairs(item.item) do
		self.mPlayerMoneyOwe[info.id] = info.num
	end

	self:onItemUpdateMoneyNotify(Const.MONEY_TYPE_DIAMOND_BUY, self:getDiamondShowNum())
end

function PlayerMixin:onGeneralAttrNotify(attr32, attr64)
	self:initGeneralAttrData(attr32, true)
	self:checkCanStepUpInTeamHeros()
	self:refreshBPSrvData(true)
end

function PlayerMixin:onPowerUpdateNotify(time)
	self:initPowerData(time)
end

function PlayerMixin:initPowerData(power_refresh)
	self.powerResumeTime = power_refresh

	self:timerPowerResumeFunc()

	local initDelay = self:getPowerResumeSeconds() - (ClientUtils.getServerTime() - self.powerResumeTime) % self:getPowerResumeSeconds()

	if self.timerPowerResumeInit then
		self.timerPowerResumeInit:Stop()

		self.timerPowerResumeInit = nil
	end

	self.timerPowerResumeInit = Timer.New(Slot(self.timerPowerResumeInitFunc, self), initDelay, 1)

	self.timerPowerResumeInit:Start()
end

function PlayerMixin:timerPowerResumeInitFunc()
	self:timerPowerResumeFunc()

	if self.timerPowerResume then
		self.timerPowerResume:Stop()

		self.timerPowerResume = nil
	end

	self.timerPowerResume = Timer.New(Slot(self.timerPowerResumeFunc, self), self:getPowerResumeSeconds(), -1)

	self.timerPowerResume:Start()
end

local POWER_RESUME_TOLERANCE = 1

function PlayerMixin:timerPowerResumeFunc()
	local oldValue = self:getMoneyByType(Const.MONEY_TYPE_POWER)
	local level = self:getLevel()

	if ResPowerMisc[1].recover_max then
		local recover_max = self:getPowerResumeMax()

		if recover_max > (self.realPowerNum or oldValue) then
			local newValue = oldValue + math.floor((ClientUtils.getServerTime() + POWER_RESUME_TOLERANCE - self.powerResumeTime) / self:getPowerResumeSeconds())

			if newValue ~= self.realPowerNum then
				self.realPowerNum = newValue <= recover_max and newValue or recover_max

				self:onPowerChanged(oldValue)
				self:onItemUpdateMoneyNotify(Const.MONEY_TYPE_POWER, self.realPowerNum)

				if self.crystalSlotDic then
					self:checkCanSweepStepInTeamHeros()
				end
			end
		end
	else
		self.realPowerNum = oldValue
	end
end

function PlayerMixin:getPowerResumeSeconds()
	return self:getPrivilegeValue(Const.PRIVITY_KEY_POWER_RECOVERY, ResPowerMisc[1].recover_time)
end

function PlayerMixin:getPowerResumeMax()
	return self:getPrivilegeValue(Const.PRIVITY_KEY_POWER_LIMIT, ResPowerMisc[1].recover_max)
end

Const.ENERGY_RECOVERY_TIME = ResStageMisc[1].recover_time * 60
Const.ENERGY_MAX = ResStageMisc[1].energy_max
Const.ENERGY_ADD_NUM = ResStageMisc[1].recover_add

function PlayerMixin:initStageEnergyData(preTime)
	self.energyResumeTime = preTime

	self:checkStageEnergyValue()

	if self.timerStageEnergyResume then
		self.timerStageEnergyResume:Stop()

		self.timerStageEnergyResume = nil
	end

	local initDelay = Const.ENERGY_RECOVERY_TIME - (ClientUtils.getServerTime() - preTime) % Const.ENERGY_RECOVERY_TIME

	self.timerStageEnergyResume = Timer.New(Slot(self.timerStageEnergyInitFunc, self), initDelay, 1)

	self.timerStageEnergyResume:Start()
end

function PlayerMixin:checkStageEnergyValue()
	local newValue = self:getMoneyByType(Const.MONEY_TYPE_ENERGY) + Const.ENERGY_ADD_NUM * math.floor((ClientUtils.getServerTime() + POWER_RESUME_TOLERANCE - self.energyResumeTime) / Const.ENERGY_RECOVERY_TIME)

	if ClientUtils.getServerTime() < self.energyResumeTime then
		newValue = self:getMoneyByType(Const.MONEY_TYPE_ENERGY)
	end

	newValue = math.min(Const.ENERGY_MAX, newValue)

	if newValue ~= self.realEnergyNum then
		self.realEnergyNum = newValue

		self:onItemUpdateMoneyNotify(Const.MONEY_TYPE_ENERGY, self.realEnergyNum)
	end
end

function PlayerMixin:timerStageEnergyInitFunc()
	self:checkStageEnergyValue()

	if self.timerStageEnergyResume then
		self.timerStageEnergyResume:Stop()

		self.timerStageEnergyResume = nil
	end

	self.timerStageEnergyResume = Timer.New(Slot(self.checkStageEnergyValue, self), Const.ENERGY_RECOVERY_TIME, -1)

	self.timerStageEnergyResume:Start()
end

function PlayerMixin:onEnergyUpdateNotify(time)
	self:initStageEnergyData(time)
end

function PlayerMixin:onNewDayNotify(curtick, todayCampType)
	UIManager.newDayEnter()
	self:newDayBossTower()
	self:newDayFriendData()
	self:newDayMaze()
	self:newDayOtherBattle()
	self:newDayCircle()
	self:newDayDrawGroup(todayCampType)
	self:onNewDayLogin()
	self:checkNewDayUIRefresh()
	self:onNewDayRearHouse()
	self:onNewDayMall()
	self:onNewDayWorldBoss()
	self:newDayActivity()
	self:onNewDayRent()
	self:onNewDayWindows()
	self:newDayRedPacket()
	self:newDayRoleInfo()
	self:newDayRelation()
	EventCenter.sendEvent(EventConst.NEW_DAY)
end

function PlayerMixin:newDayRelation()
	self:checkRelationHeroNewHint()
end

local NEW_DAY_CANVAS = {
	"drawCardMainDlg",
	"bossChooseDlg",
	"pvpMainDlg",
	"achieveMainDlg",
	"stepTowerDlg",
	"sweepMainDlg",
	"circleMainDlg"
}

function PlayerMixin:checkNewDayUIRefresh()
	if GameFsm.isInState(Const.STATE_MAIN) then
		local needRefresh = false

		for _, uiName in ipairs(NEW_DAY_CANVAS) do
			if UIManager.getUI(uiName, nil, false) then
				needRefresh = true

				break
			end
		end

		if needRefresh then
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[161].notice, UIManager.clearStateCanvas)
		end
	end
end

function PlayerMixin:initCounterData(counter)
	for _, tiCounter in ipairs(counter.dtic) do
		self:onDayTICounterNotify(tiCounter.tin.type, tiCounter.tin.id, tiCounter.tin.num)
	end

	self._timerCounterDict = {}
end

function PlayerMixin:dayDrawCountLimitOpen()
	return RegionUtils.isCN() and RegionUtils.isCurrentLanguage(RegionConst.LANGUAGE_CHTS) and Const.DayDrawCountLimitOpen == true
end

function PlayerMixin:onDayTICounterNotify(counterType, counterId, value)
	if counterType == Const.DayTICounterTypeDraw then
		self:_setDayTICounterDrawData(counterId, value)
	elseif counterType == Const.DayTICounterTypePvp then
		self:_setDayTICounterPvp(counterId, value)
	elseif counterType == Const.DayTICounterTypePower then
		self:_setDayTICounterPower(counterId, value)
	elseif counterType == Const.DayTICounterTypeMultiPVP then
		self:_setDayTICounterMultiPvp(counterId, value)
	end
end

function PlayerMixin:_setDayTICounterMultiPvp(counterId, counterValue)
	if not self.dayMultiPvpCounter then
		self.dayMultiPvpCounter = {}
	end

	self.dayMultiPvpCounter[counterId] = counterValue
end

function PlayerMixin:getMultiPvpCounter(counterId)
	if self.dayMultiPvpCounter and self.dayMultiPvpCounter[counterId] then
		return self.dayMultiPvpCounter[counterId]
	end

	return 0
end

function PlayerMixin:_setDayTICounterPvp(counterId, counterValue)
	if not self.dayPvpCounter then
		self.dayPvpCounter = {}
	end

	self.dayPvpCounter[counterId] = counterValue
end

function PlayerMixin:getPvpCounter(counterId)
	if self.dayPvpCounter and self.dayPvpCounter[counterId] then
		return self.dayPvpCounter[counterId]
	end

	return 0
end

function PlayerMixin:_setDayTICounterPower(counterId, counterValue)
	if not self.dayPowerCounter then
		self.dayPowerCounter = {}
	end

	self.dayPowerCounter[counterId] = counterValue
end

function PlayerMixin:getPowerCounter(counterId)
	if self.dayPowerCounter and self.dayPowerCounter[counterId] then
		return self.dayPowerCounter[counterId]
	end

	return 0
end

function PlayerMixin:getPowerBuyMaxCount()
	return self:getPrivilegeValue(Const.PRIVITY_KEY_POWER_BUY_COUNT, ResPowerMisc[1].buy_count)
end

function PlayerMixin:onPowerExchangeResp(power)
	local notifyType = Const.LISTATTR_USETYPE_ITEMUSE
	local attrs = {
		{
			type = Const.MONEY_TYPE_POWER,
			value = power
		}
	}

	self:onGetBonusNotice("commonBonusDlg", "onShow", {
		notifyType,
		attrs,
		{},
		{},
		{},
		{},
		{},
		Lang.get(1881)
	})

	local buyCapacityDlg = UIManager.getUI("buyCapacityDlg", nil, false)

	if buyCapacityDlg then
		buyCapacityDlg.panelUseDiamond:refreshUseDiamondPanel()
	end
end

function PlayerMixin:dayDrawTryHideOptDlg()
	local needTryHideName = {
		"drawCardOperateDlg",
		"drawCardOptLightDlg",
		"drawCardOptUpDlg",
		"drawNewbieOptDlg"
	}

	for _, name in pairs(needTryHideName) do
		UIManager.tryHideUI(name)
	end
end

function PlayerMixin:_setDayTICounterDrawData(counterId, counterValue)
	if not self.dayDrawCounter then
		self.dayDrawCounter = {}
	end

	self.dayDrawCounter[counterId] = counterValue
end

function PlayerMixin:getDrawDayCount(counterId, maxCount)
	if not self.dayDrawCounter or not self.dayDrawCounter[counterId] then
		return 0
	end

	return self.dayDrawCounter[counterId]
end

function PlayerMixin:onDayCounterResetNotify(dayend)
	for counterId, _ in pairs(self.dayDrawCounter or {}) do
		self.dayDrawCounter[counterId] = 0
	end

	for counterId, _ in pairs(self.dayPvpCounter or {}) do
		self.dayPvpCounter[counterId] = 0
	end

	for counterId, _ in pairs(self.dayPowerCounter or {}) do
		self.dayPowerCounter[counterId] = 0
	end

	for counterId, _ in pairs(self.dayMultiPvpCounter or {}) do
		self.dayMultiPvpCounter[counterId] = 0
	end

	self:_refreshDrawMainDlg()
end

function PlayerMixin:onTimeCounterNotify(_, counter)
	local tin = counter and counter.tin

	if tin then
		self:_setTimeCounter(tin.type, tin.id, counter.tick)
	end
end

function PlayerMixin:onWeekCounterResetNotify(weekend)
	return
end

function PlayerMixin:onMonthCounterResetNotify(monthend)
	return
end

function PlayerMixin:_setTimeCounter(counterType, id, tick)
	local dictByType = self._timerCounterDict[counterType]

	if dictByType == nil then
		dictByType = {}
		self._timerCounterDict[counterType] = dictByType
	end

	if dictByType[id] ~= tick then
		dictByType[id] = tick

		EventCenter.sendEvent(EventConst.TIME_COUNTER_UPDATE, counterType, id, tick)
	end
end

function PlayerMixin:getTimeCounter(counterType, id)
	local dictByType = self._timerCounterDict[counterType]

	return dictByType and dictByType[id]
end

function PlayerMixin:initBeginnerData(newbieData)
	self.beginnerFinished = ClientUtils.getBitsDictFromByteString(newbieData.bitmem)
end

function PlayerMixin:isBeginnerFinished(beginnerId)
	if BeginnerManager.disable then
		return true
	else
		return self.beginnerFinished[beginnerId]
	end
end

function PlayerMixin:onNewbieReportResp(beginnerId)
	self.beginnerFinished[beginnerId] = true
end

local BEGINNER_STEP_DICT = {
	[Const.BEGINNER_STEP_MOVIE] = Lang.get(33275),
	[Const.BEGINNER_STEP_BATTLE] = Lang.get(699),
	[Const.BEGINNER_STEP_CLICK_BUTTON] = Lang.get(33276),
	[Const.BEGINNER_STEP_NOTICE] = Lang.get(33277),
	[Const.BEGINNER_STEP_FORMATION] = Lang.get(33278),
	[Const.BEGINNER_STEP_PLAY_AVG] = Lang.get(33279),
	[Const.BEGINNER_STEP_CHANGE_FORMATION] = Lang.get(33280),
	[Const.BEGINNER_STEP_FORCE_NOTICE] = Lang.get(33281),
	[Const.BEGINNER_STEP_HERO_OPERA] = Lang.get(33282),
	[Const.BEGINNER_STEP_CANVAS] = Lang.get(33283),
	[Const.BEGINNER_STEP_CANVAS_OPERA] = Lang.get(33284),
	[Const.BEGINNER_STEP_SHOW_GRAPHIC] = Lang.get(33285),
	[Const.BEGINNER_STEP_PLAY_AVG_FRONT] = Lang.get(33286),
	[Const.BEGINNER_STEP_SHOW_GRAPHIC_LIST] = Lang.get(33287),
	[Const.BEGINNER_STEP_MAZE_DRAG] = Lang.get(33288),
	[Const.BEGINNER_STEP_SHOW_GRAPHIC_LIST_MOVIE] = Lang.get(33289)
}

function PlayerMixin:sendBeginnerAnalytics(beginnerId, stepId, operateType, isEnd)
	Analytics.sendGuideFlow(beginnerId, stepId, operateType, BEGINNER_STEP_DICT[operateType] or "unknown", isEnd)
end

function PlayerMixin:setRoleCreatedCallback(endCallback)
	self.roleCreatedCallback = endCallback
end

function PlayerMixin:sendRoleInfo(name, gender, head)
	self.cachedName = name
	self.cachedGender = gender
	self.cachedHead = head

	RPC.roleInfo(name, gender, head)
end

local ROLECREATE_MSG_MAP = {
	[Const.CREATE_ROLE_NAMEDUPLICATE] = Lang.get(1883),
	[Const.CREATE_ROLE_INVALIDNAMELENGTH] = Lang.get(1884),
	[Const.CREATE_ROLE_DIRTYWORD] = Lang.get(1885),
	[Const.CREATE_ROLE_INVALIDUTF8] = Lang.get(1886),
	[Const.CREATE_ROLE_INVALIDRULE] = Lang.get(1887),
	[Const.CREATE_ROLE_INVALIDLANG] = Lang.get(1888)
}

if RegionUtils.isKR() then
	ROLECREATE_MSG_MAP[Const.CREATE_ROLE_INVALIDLANG] = Lang.get(49883)
end

function PlayerMixin:onRoleInfoResp(respCode, hint)
	if respCode == Const.CREATE_ROLE_NOERROR then
		self.name = self.cachedName
		self.gender = self.cachedGender
		self.head = self.cachedHead

		if self.serverFormatName then
			local nameList = utils.splitString(self.serverFormatName, "-")
			local serverID = nameList[1]

			self.serverFormatName = serverID .. "-" .. self.name
		end

		self:refreshNameUI()

		self.cachedName = nil
		self.cachedGender = nil
		self.cachedHead = nil

		self:onPlayerNameInited()
	else
		local createRoleDlg = UIManager.tryGetUI("createRoleDlg")

		if createRoleDlg then
			createRoleDlg.btnLockFlag = false

			if respCode == Const.CREATE_ROLE_DIRTYWORD and hint and #hint > 0 then
				createRoleDlg:markInputIllegal(hint)
			end
		end

		local hintMsg = ROLECREATE_MSG_MAP[respCode]

		if hintMsg ~= nil then
			MsgManager.notice(hintMsg)
		else
			MsgManager.notice(Lang.get(1889))
		end
	end
end

local PLAYER_NAME_FOCUS_UI = {
	mainMenu = "onUpdateAttrChanged",
	mainStageDlg = "onUpdateAttrChanged"
}

function PlayerMixin:refreshNameUI()
	for uiName, refreshFunc in pairs(PLAYER_NAME_FOCUS_UI) do
		local ui = UIManager.getUI(uiName, nil, false)

		if ui then
			ui[refreshFunc](ui)
		end
	end
end

function PlayerMixin:refreshPlayerInfoUI()
	self:refreshNameUI()
end

function PlayerMixin:onPlayerNameInited()
	local createRoleDlg = UIManager.getUI("createRoleDlg", nil, false)

	if createRoleDlg then
		createRoleDlg:setVisible(false)
	end

	if self.roleCreatedCallback then
		self.roleCreatedCallback()

		self.roleCreatedCallback = nil
	end

	UIManager.getUI("createRoleResultDlg", true)
	Analytics.onCreateName()
end

function PlayerMixin:onRoleRandNameResp(male, name)
	local createRoleDlg = UIManager.getUI("createRoleDlg", nil, false)

	if createRoleDlg then
		createRoleDlg:setRandomName(name)
	end
end

function PlayerMixin:getPowerBlankNum()
	return Const.PLAYER_MAX_POWER - self.realPowerNum
end

function PlayerMixin:getBagSize(bagType, ignorePrivilege)
	local totalMaxCount = self:getBagMaxSize(bagType, ignorePrivilege)

	if ignorePrivilege then
		return math.min(totalMaxCount, self.bagSize[bagType])
	else
		return math.min(totalMaxCount, self:getPrivilegeValue(Const.BAG_TYPE_PRIVATE[bagType], self.bagSize[bagType]))
	end
end

function PlayerMixin:getBagMaxSize(bagType, ignorePrivilege)
	if ignorePrivilege then
		return ResBagMisc[Const.BAG_TYPE_ID[bagType]].bag_max_slot
	else
		return self:getPrivilegeValue(Const.BAG_TYPE_PRIVATE[bagType], ResBagMisc[Const.BAG_TYPE_ID[bagType]].bag_max_slot)
	end
end

function PlayerMixin:getEquipRemainBlankNum()
	local equipBagSize = self:getBagSize(Const.BAG_TYPE_EQUIP)

	return math.max(equipBagSize - self:getEquipCount(), 0)
end

function PlayerMixin:getHeroRemainBlankNum()
	local heroBagSize = self:getBagSize(Const.BAG_TYPE_HERO)

	return math.max(heroBagSize - self:getHeroCount(), 0)
end

function PlayerMixin:getArtifactRemainBlankNum()
	local artifactBagSize = self:getBagSize(Const.BAG_TYPE_ARTIFACT)

	return math.max(artifactBagSize - self:getArtifactCount(), 0)
end

function PlayerMixin:getPetGemRemainBlankNum()
	local petGemBagSize = self:getBagSize(Const.BAG_TYPE_PET_GEM)

	return math.max(petGemBagSize - self:getPetGemCount(), 0)
end

function PlayerMixin:getBagBlankByBagType(bagType)
	local blankNum = 999999

	if bagType then
		if bagType == Const.BAG_TYPE_HERO then
			blankNum = self:getHeroRemainBlankNum()
		elseif bagType == Const.BAG_TYPE_EQUIP then
			blankNum = self:getEquipRemainBlankNum()
		elseif bagType == Const.BAG_TYPE_ARTIFACT then
			blankNum = self:getArtifactRemainBlankNum()
		elseif bagType == Const.BAG_TYPE_PET_GEM then
			blankNum = self:getPetGemRemainBlankNum()
		end
	end

	return blankNum
end

function PlayerMixin:getBagFullNotice(bagType)
	local fullNotice = 0

	if bagType then
		if bagType == Const.BAG_TYPE_HERO then
			fullNotice = 385
		elseif bagType == Const.BAG_TYPE_EQUIP then
			fullNotice = 383
		elseif bagType == Const.BAG_TYPE_ARTIFACT then
			fullNotice = 384
		end
	end

	return fullNotice
end

function PlayerMixin:checkItemsFull(items, confirmCB, nums)
	nums = nums or {}

	local equipEnable = self:getEquipRemainBlankNum() > 0
	local artifactEnable = self:getArtifactRemainBlankNum() > 0
	local petGemEnable = self:getPetGemRemainBlankNum() > 0

	if not equipEnable or not artifactEnable or petGemEnable then
		for index, item in pairs(items) do
			if item:isEquip() then
				if not equipEnable then
					self:confirmBagAdd(Const.BAG_TYPE_EQUIP)

					return false
				end
			elseif item:isArtifact() then
				if not artifactEnable then
					self:confirmBagAdd(Const.BAG_TYPE_ARTIFACT)

					return false
				end
			elseif item:isPetGem() and not petGemEnable then
				self:confirmBagAdd(Const.BAG_TYPE_PET_GEM)

				return false
			end
		end
	end

	for index, item in pairs(items) do
		if item.id == Const.MONEY_ID_POWER then
			if self:getPowerBlankNum() == 0 and #items == 1 then
				local msg = string.format(Lang.get(1877), item.name)

				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", msg)

				return false
			elseif self:getPowerBlankNum() < item.num * (nums[index] or 1) then
				local msg = string.format(Lang.get(1878), item.name)

				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msg, confirmCB)

				return false
			end
		end
	end

	confirmCB()

	return true
end

function PlayerMixin:checkHeroHatEnhance(equipGid)
	local obj = self.bagEquips[equipGid]

	if obj and obj.canEnhance and obj.canEnhance == 1 then
		return true
	else
		return false
	end
end

function PlayerMixin:getAvgAutoState()
	if self.avgIsAuto == nil then
		self.avgIsAuto = false
	end

	return self.avgIsAuto
end

function PlayerMixin:setAvgAutoState(isAuto)
	self.avgIsAuto = isAuto
end

function PlayerMixin:getAvgBulletState()
	local flag = UserData.loadCommonData(CurAvatar.uid .. "AVGBulletConfig")

	if not flag or flag == "1" or flag == "" then
		return true
	else
		return false
	end
end

function PlayerMixin:setAvgBulletState(isOn)
	UserData.saveCommonData(CurAvatar.uid .. "AVGBulletConfig", isOn)
end

function PlayerMixin:sendNodeAnalyticsData(eventType, param1, param2, param3)
	local mainStageCur = CurAvatar.mainStageCur

	if mainStageCur.chapter == 1 and mainStageCur.level <= 5 then
		param1 = param1 or ""
		param2 = param2 or ""

		Analytics.sendOSSLog(eventType, param1, param2, param3)
	end
end

function PlayerMixin:tryOpenGameEvaluateDlg(position)
	return
end

function PlayerMixin:tryRefreshCustomerServiceRedDot()
	if not RegionUtils.isJP() then
		return
	end

	local function request()
		if not Framework.Tools.LuaToolkit.IsEditor() then
			local data = {}

			data.server_id = SvrListManager.getSelectedSvrID()
			data.aid = 4255
			data.open_id = SDKAgent.getUserID()
			data.role_id = CurAvatar.uid

			local url = ClientUtils.composeGetUrl("https://cs.bytegsdk.com/customer_service/cp/reddot/get", data)

			HttpHelper.get(url, Slot(self.requestCustomerService_JP, self))
		end
	end

	ClientTimerManager.startGlobalTimer("requestCustomerService_JP", 600 - math.random(-60, 60), request)
end

function PlayerMixin:requestCustomerService_JP(responseCode, dataString)
	if responseCode == ResponseCode.SUCC and dataString then
		local redDotData = ClientUtils.string2Table(dataString)
		local code = redDotData.code

		if code == 0 then
			local num = redDotData.data and redDotData.data.num

			if num > 0 then
				RedDotManager.setKeyState(UIConst.RD_HINT_CUSTOMER, true)
			end
		end
	end
end

return PlayerMixin
