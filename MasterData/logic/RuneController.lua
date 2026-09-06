-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/controller/RuneController.lua

module("logic.extensions.rune.controller.RuneController", package.seeall)

local RuneController = class("RuneController", BaseController)

function RuneController:ctor()
	return
end

function RuneController:onInit()
	self:onReset()
	RuneAgent.instance:addHandler(RuneAgent.PM_notifyRuneChangedRes, self.onRuneChange, self)
	RuneAgent.instance:addHandler(RuneAgent.PM_notifyRuneSuitChangedRes, self.onRuneSuitChange, self)
end

function RuneController:onReset()
	self.curViewType = -1
	self.curViewRuneIdx = -1

	removetimer(self.getSuitInfo, self)
end

function RuneController:stopShowCI(changeSetId, type)
	changeSetId = checknumber(changeSetId)
	self.ciList = self.ciList or {}

	if changeSetId > 0 then
		table.insert(self.ciList, changeSetId)

		type = type or ItemGetController.TITLE_PRIZE

		ItemGetController.instance:setTitleType(changeSetId, type)
		MaterialController.instance:saveChangeSetToTemp(changeSetId)
	end
end

function RuneController:showRuneCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function RuneController:getSuitInfo(callBack)
	if RuneModel.instance.suitInfo then
		GameUtil.callBack(callBack)
	else
		RuneAgent.instance:sendPM_RuneSuitInfoReq(function(msg)
			RuneModel.instance:changeInfo(msg)
			RuneModel.instance:initSuitData(msg.suits)
			BagPetsController.instance:calcAllPetRuneAttr()
			GameUtil.callBack(callBack)
		end)
	end
end

function RuneController:initAllInfo(callBack)
	self.callBackList = self.callBackList or {}

	table.insert(self.callBackList, callBack)
	self:getSuitInfo(function()
		for k, v in pairs(self.callBackList) do
			GameUtil.callBack(v)
		end

		self.callBackList = nil
	end)
end

function RuneController:onRuneChange(msg, status)
	RuneModel.instance:changeInfo(msg)
	BagPetsController.instance:calcAllPetRuneAttr()
end

function RuneController:onRuneSuitChange(msg, status)
	RuneModel.instance:initSuitData(msg.runeSuitInfos)
	BagPetsController.instance:calcAllPetRuneAttr()
end

function RuneController:putonSuit(petMo, suitMo)
	UIStateManager.instance:push(ViewName.RuneselectView, function(data)
		RuneAgent.instance:sendPM_RunePetEquipSuitReq(petMo.petId, data.suitId, function(msg)
			return
		end)
	end, suitMo)
end

function RuneController:openMainView(suitId, tabIdx)
	suitId = suitId or -1

	RuneModel.instance:setCurrSuitId(suitId)

	if not ViewMgr.instance:isOpen(ViewName.RuneeditView) then
		self:getPackInfo(function()
			UIStateManager.instance:push(ViewName.RuneeditView, tabIdx)
		end)
	end
end

function RuneController:openPutonTipsView(runeMo)
	if runeMo then
		self.totalCount = 1
		self.openingCout = 1

		CommonTipsMgr.instance:_openOneView(ViewName.RuneputonView, runeMo)

		if RuneModel.instance.currSelectRune then
			self.openingCout = 2
			self.totalCount = 2

			if not ViewMgr.instance:isOpen(ViewName.RunetakeoffView) then
				CommonTipsMgr.instance:_openOneView(ViewName.RunetakeoffView)
			end
		end
	end
end

function RuneController:openTakeOffTipsView()
	if RuneModel.instance.currSelectRune then
		self.openingCout = 1
		self.totalCount = 1

		CommonTipsMgr.instance:_openOneView(ViewName.RunetakeoffView)
	end
end

function RuneController:openLockTipsView(runeMo)
	self.totalCount = 1
	self.openingCout = 1

	CommonTipsMgr.instance:_openOneView(ViewName.RuneputonView, runeMo)
end

function RuneController:openLvlTipsView(runeMo, suitId)
	self.totalCount = 1
	self.openingCout = 1

	CommonTipsMgr.instance:_openOneView(ViewName.RunetakeoffView, runeMo, suitId)
end

function RuneController:closePutonView(deal)
	self.openingCout = self.openingCout - deal
	self.openingCout = math.min(self.openingCout, self.totalCount)

	print(">>>>>>>>>>>>>>>>>>rune close ", self.openingCout, deal)

	if self.openingCout <= 0 then
		self:closeAllTips()
	end
end

function RuneController:closeAllTips()
	self.openingCout = 0

	CommonTipsMgr.instance:closeAllTips()
end

function RuneController:sendOneKeyRune(suitId, callBack)
	local list = RuneModel.instance:getAllItems()

	if #list == 0 then
		TipsFacade.instance:openCommonTips(lang("你的背包没有可用星辉"))
	else
		RuneAgent.instance:sendPM_RuneOneKeyInstallReq(suitId, function(msg)
			GameUtil.callBack(callBack)

			local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, suitId)
			local colorName = ""

			if cfg and cfg.qualityLimit then
				local qualityLimit = cfg.qualityLimit

				colorName = GameUtil.HtmlColorTxt(ConstString.Quality[qualityLimit] .. lang("品质"), GameUtil.GetGoodsColor(qualityLimit - 1))
				colorName = colorName .. lang("及以下")
				colorName = langPara("%s可镶嵌%s星辉", cfg.name, colorName)
			end

			if msg.noNeed then
				TipsFacade.instance:openCommonTips(langPara("一键装备结束\n%s没有变化,%s", cfg.name, colorName))
			else
				TipsFacade.instance:openCommonTips(langPara("一键装备完成\n%s", colorName))
			end
		end)
	end
end

function RuneController:installRuneInSuit(suitId, runeId, posId, callBack)
	RuneAgent.instance:sendPM_RuneInstallReq(suitId, runeId, posId - 1, function(msg)
		GameUtil.callBack(callBack)
	end)
end

function RuneController:uninstallRune(suitId, posIdx, callBack)
	local mo = RuneModel.instance:getSuitMo(suitId)

	if mo then
		local curCfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, suitId)
		local runeMo = mo:getRuneMoByIdx(posIdx)

		if runeMo then
			local isCut, petStr = self:getIfChangePetNum(suitId, {
				runeMo
			})

			TipsFacade.instance:openPopupWindow(lang("tip"), isCut and langPara("是否确定要继续卸下星辉？\n将导致<color='#1177ce'> %s </color>总等级下降，\n已解锁的应用精灵位置会重新被锁上", curCfg.name) .. petStr or langPara("要将<color='#1177ce'> %s </color>中的<color='#1177ce'> %s </color>卸下吗?\n注意：卸下后影响所有装备<color='#1177ce'> %s </color>的精灵。", curCfg.name, runeMo:getName(), curCfg.name), function()
				RuneAgent.instance:sendPM_RuneUninstallReq(suitId, posIdx - 1, function(msg)
					GameUtil.callBack(callBack)
				end)
			end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
		end
	end
end

function RuneController:oneKeyUninstallAll(suitId, callBack)
	local mo = RuneModel.instance:getSuitMo(suitId)

	if mo then
		if mo:checkIsInstall() then
			local curCfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, suitId)
			local isCut, petStr = self:getIfChangePetNum(suitId, mo:getRuneMoList())

			TipsFacade.instance:openPopupWindow(lang("tip"), isCut and langPara("要将<color='#1177ce'> %s </color>中的星辉全部卸下吗?\n已解锁的应用精灵位置会重新被锁上", curCfg.name) .. petStr or langPara("要将<color='#1177ce'> %s </color>中的星辉全部卸下吗?\n注意：卸下后影响所有应用<color='#1177ce'> %s </color>的精灵。", curCfg.name, curCfg.name), function()
				RuneAgent.instance:sendPM_RuneOneKeyUninstallReq(suitId, function(msg)
					GameUtil.callBack(callBack)
				end)
			end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
		else
			TipsFacade.instance:openCommonTips(lang("当前星座没有镶嵌任何星辉"))
		end
	end
end

function RuneController:onInsertClick(currSuitId, currRuneIdx, runeMo, callback)
	if runeMo.suitId > 0 then
		local lastCfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, runeMo.suitId)
		local curCfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, currSuitId)
		local content = ""
		local isCut, petStr = self:getIfChangePetNum(runeMo.suitId, {
			runeMo
		})

		if isCut then
			content = langPara("是否要将<color='#1177ce'>%s</color>中的<color='#1177ce'>%s</color>替换到<color='#1177ce'>%s</color>中，\n<color='#1177ce'>%s</color>总等级将下降，\n已解锁的应用精灵位置会重新被锁上", lastCfg.name, runeMo:getName(), curCfg.name, lastCfg.name) .. petStr
		else
			local isCut, petStr = self:getIfChangePetNum(currSuitId, {
				runeMo
			})

			content = isCut and langPara("是否要将<color='#1177ce'>%s</color>中的<color='#1177ce'>%s</color>替换到<color='#1177ce'>%s</color>中，\n<color='#1177ce'>%s</color>总等级将下降，\n已解锁的应用精灵位置会重新被锁上", lastCfg.name, runeMo:getName(), curCfg.name, curCfg.name) .. petStr or langPara("是否要将<color='#1177ce'>%s</color>中的<color='#1177ce'>%s</color>替换到<color='#1177ce'>%s</color>中", lastCfg.name, runeMo:getName(), curCfg.name)
		end

		TipsFacade.instance:openPopupWindow(lang("替换确认"), content, function()
			self:installRuneInSuit(currSuitId, runeMo.runeId, currRuneIdx, callback)
		end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		local curCfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, currSuitId)
		local mo = RuneModel.instance:getSuitMo(currSuitId)
		local tmp = mo:getRuneMoByIdx(currRuneIdx)
		local isCut, petStr = self:getIfChangePetNum(currSuitId, {
			runeMo
		})

		if isCut and tmp then
			TipsFacade.instance:openPopupWindow(lang("替换确认"), langPara("是否要将<color='#1177ce'>%s</color>中的<color='#1177ce'>%s</color>替换成<color='#1177ce'>%s</color>，\n<color='#1177ce'>%s</color>总等级将下降，\n已解锁的应用精灵位置会重新被锁上", curCfg.name, tmp:getName(), runeMo:getName(), curCfg.name) .. petStr, function()
				self:installRuneInSuit(currSuitId, runeMo.runeId, currRuneIdx, callback)
			end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
		else
			self:installRuneInSuit(currSuitId, runeMo.runeId, currRuneIdx, callback)
		end
	end
end

function RuneController:getIfChangePetNum(suitId, runeMoList)
	local suitMo = RuneModel.instance:getSuitMo(suitId)
	local lastPetNum = suitMo:getSuitLimitPetCount()
	local totalStar = suitMo:getTotalStar()

	for i, rmo in pairs(runeMoList) do
		totalStar = totalStar - rmo.level
	end

	local toLvl = suitMo:getLvlByStatCount(totalStar)
	local curPetNum = RuneConfig.instance:getCurrCoutByStars(suitId, totalStar)

	if curPetNum < lastPetNum then
		local list = RuneModel.instance:findUseSuitPets(suitId)

		if curPetNum < #list then
			local content = lang("，\n且如下精灵将被自动取消应用：\n")

			for i, petMo in ipairs(list) do
				content = content .. MaterialMgr.getContentMatCfg(MatType.Pet, petMo.petId, 110, -10, MaterialMgr.ICON_TYPE_MATID) .. "   "
			end

			return true, content
		end

		return true, ""
	end

	return false, ""
end

function RuneController:setCurrLvlupMo(runeMo, suitId)
	RuneModel.instance:setCurrLvlupMo(runeMo)
	GlobalDispatcher:dispatch(GlobalNotify.RUNE_LVLUP_SELECT)

	if suitId then
		self:openMainView(suitId, RuneeditView.TAB_LVLUPVIEW)
	end
end

function RuneController:setLock(runeMo)
	if runeMo.isLocked then
		RuneAgent.instance:sendPM_RuneUnLockReq(runeMo.runeId, function()
			return
		end)
	else
		RuneAgent.instance:sendPM_RuneLockReq(runeMo.runeId, function()
			return
		end)
	end
end

function RuneController:addOrDelToDepart(runeMo, isAdd)
	RuneModel.instance:addOrDelToDepart(runeMo, isAdd)
	GlobalDispatcher:dispatch(GlobalNotify.RUNE_DEPART_UPDATE)
end

function RuneController:onekeyAddDepart()
	RuneModel.instance:onekeyAddDepart()
	GlobalDispatcher:dispatch(GlobalNotify.RUNE_DEPART_UPDATE)
end

function RuneController:sendDepart(arr, callBack)
	local ids = {}
	local hasBig = false

	if arr then
		for k, v in pairs(arr) do
			table.insert(ids, v.runeId)

			if v:getQuality() >= 4 then
				hasBig = true
			end
		end
	end

	if #ids == 0 then
		FloatWordMgr.instance:show(lang("请选择需要分解的星辉"))
	elseif hasBig then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("当前选中的星辉中，有<color='#744BBEFF'>紫色</color>及以上品质的星辉，是否继续分解？"), function()
			RuneAgent.instance:sendPM_RuneDecomposeReq(ids, function(msg)
				GameUtil.callBack(callBack)
				GlobalDispatcher:dispatch(GlobalNotify.RUNE_DEPART_UPDATE)
			end)
		end)
	else
		RuneAgent.instance:sendPM_RuneDecomposeReq(ids, function(msg)
			GameUtil.callBack(callBack)
			GlobalDispatcher:dispatch(GlobalNotify.RUNE_DEPART_UPDATE)
		end)
	end
end

function RuneController:createSuitMo(petMo)
	if petMo.runeSuit then
		local suitId = petMo.runeSuit.runeSuitId
		local isMyRuneSuit = petMo.isMyPackPet
		local suitMo

		if isMyRuneSuit then
			suitMo = RuneModel.instance:getSuitMo(suitId)
		else
			suitMo = RuneSuitMo.New()

			suitMo:initWithOtherData(petMo.runeSuit)
		end

		return suitMo
	end

	return nil
end

function RuneController:showGainViewByPetMo(petMo)
	local suitMo = self:createSuitMo(petMo)

	if suitMo then
		UIStateManager.instance:push(ViewName.RunegainView, suitMo, true)
	end
end

function RuneController:setViewCurType(type)
	self.curViewType = type
end

function RuneController:getViewCurType()
	return self.curViewType
end

function RuneController:setViewCurRuneIdx(idx)
	self.curViewRuneIdx = idx
end

function RuneController:getViewCurRuneIdx()
	return self.curViewRuneIdx
end

RuneController.instance = RuneController.New()

return RuneController
