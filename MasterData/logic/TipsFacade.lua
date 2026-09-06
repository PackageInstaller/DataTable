-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/facade/TipsFacade.lua

module("logic.extensions.tips.facade.TipsFacade", package.seeall)

local TipsFacade = class("TipsFacade", BaseFacade)
local POPUP_WIN_ID = 0

TipsFacade.popupWindowSource = nil
TipsFacade.disableOpenPopupWindow = nil
TipsFacade.STATE_OK = 1
TipsFacade.STATE_CANCEL = 2
TipsFacade.STATE_SUCCESS = 3
TipsFacade.STATE_FAIL = 4
TipsFacade.STATE_NUM_CHANGE = 5

function TipsFacade:openFlyTips(text)
	local mgr = ViewMgr.instance
	local viewName = ViewName.Tipsfly

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	mgr:open(viewName, text)
end

function TipsFacade:openCommonTips(text)
	FloatWordMgr.instance:show(text)
end

function TipsFacade:openMulButton(mulButtonConfig)
	TipsViewBase.tipsPosition = mulButtonConfig.pos

	ViewMgr.instance:open(ViewName.tipMulBtnView, mulButtonConfig)
end

function TipsFacade:openSearchView(inputFieldConfig, searchConfig)
	TipsViewBase.tipsPosition = searchConfig.pos

	local mgr = ViewMgr.instance
	local viewName = "search"

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	mgr:open(viewName, inputFieldConfig, searchConfig)
end

function TipsFacade:closeSearchView()
	local mgr = ViewMgr.instance
	local viewName = "search"

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end
end

function TipsFacade:openPopupMenu(popupConfig)
	TipsViewBase.tipsPosition = popupConfig.pos

	local mgr = ViewMgr.instance
	local viewName = "popupmenu"

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	mgr:open(viewName, popupConfig)
end

function TipsFacade:closePopupMenu()
	local mgr = ViewMgr.instance
	local viewName = "popupmenu"

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end
end

function TipsFacade.checkFuncType(...)
	local arr = {
		...
	}

	for i, v in pairs(arr) do
		if type(v) ~= "function" then
			if enableDebug then
				error("仅仅电脑编辑器上，强制报错。通知前端 ， TipsFacade 传错参数了  不是function")

				break
			end

			printError(" TipsFacade 传错参数了 不是function ")

			break
		end
	end
end

function TipsFacade:openPopupWindow(title, text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
	TipsFacade.checkFuncType(okFunc, cencelFunc)

	return self:_openPopWindowWithName(ViewName.Popupwindow, 2, title, text, false, false, alignment, {
		okFunc,
		okFuncText
	}, {
		cencelFunc,
		cancelFuncText
	})
end

function TipsFacade:openPopupWindowWithX(title, text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
	TipsFacade.checkFuncType(okFunc, cencelFunc)

	return self:_openPopWindowWithName(ViewName.Popupwindow, 2, title, text, true, false, alignment, {
		okFunc,
		okFuncText
	}, {
		cencelFunc,
		cancelFuncText
	})
end

function TipsFacade:openPopupWindowWithTog(title, text, func1, func2, funcTog, btnText1, btnText2, togText, alignment)
	TipsFacade.checkFuncType(func1, func2, funcTog)

	return self:_openPopWindowWithName(ViewName.Popupwindow, 2, title, text, true, true, alignment, {
		func1,
		btnText1
	}, {
		func2,
		btnText2
	}, {
		funcTog,
		togText
	})
end

function TipsFacade:openPopupWindowNoCancelWithTog(title, text, func1, funcTog, btnText1, togText, alignment, uiFlyTweenParam)
	TipsFacade.checkFuncType(func1, funcTog)

	return self:_openPopWindowWithName(ViewName.Popupwindow, 1, title, text, true, true, alignment, {
		func1,
		btnText1
	}, {
		funcTog,
		togText
	}, uiFlyTweenParam)
end

function TipsFacade:openPopupWindowWithTogByDayKey(title, text, func1, func2, key, btnText1, btnText2, alignment)
	TipsFacade.checkFuncType(func1)

	if checknumber(GameUtil.getUserDayData(key)) > 0 then
		GameUtil.callBack(func1)
	else
		local togText = lang("今日不再提示")

		local function funcTog()
			GameUtil.saveUserDayData(key, 1)
		end

		self:openPopupWindowWithTog(title, text, func1, func2, funcTog, btnText1, btnText2, togText, alignment)
	end
end

function TipsFacade:openPopupWindowNoCancelWithTogByDayKey(title, text, func1, btnText1, key, alignment, uiFlyTweenParam)
	TipsFacade.checkFuncType(func1)

	if checknumber(GameUtil.getUserDayData(key)) > 0 then
		GameUtil.callBack(func1)
	else
		local togText = lang("今日不再提示")

		local function funcTog()
			GameUtil.saveUserDayData(key, 1)
		end

		return self:openPopupWindowNoCancelWithTog(title, text, func1, funcTog, btnText1, togText, alignment, uiFlyTweenParam)
	end
end

function TipsFacade:openTipWindow(title, text, func, btnText, alignment)
	TipsFacade.checkFuncType(func)

	return self:_openPopWindowWithName(ViewName.Popupwindow, 1, title, text, true, false, alignment, {
		func,
		btnText
	})
end

function TipsFacade:openTipWindowNoX(title, text, func, btnText, alignment)
	TipsFacade.checkFuncType(func)

	return self:_openPopWindowWithName(ViewName.Popupwindow, 1, title, text, false, false, alignment, {
		func,
		btnText
	})
end

function TipsFacade:openTipWindowValidX(title, text, func, btnText, alignment)
	TipsFacade.checkFuncType(func)

	return self:_openPopWindowWithName(ViewName.Popupwindow, 1, title, text, true, false, alignment, {
		func,
		btnText,
		true
	})
end

function TipsFacade:openTipWindowNoGuide(title, text, func, btnText, alignment)
	TipsFacade.checkFuncType(func)

	return self:_openPopWindowWithName(ViewName.PopupwindowNoGuide, 1, title, text, true, false, alignment, {
		func,
		btnText
	})
end

function TipsFacade:openSeasonPopupWindow(title, text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
	TipsFacade.checkFuncType(okFunc, cencelFunc)

	return self:_openPopWindowWithName(ViewName.SeasonPopupWindowView, 2, title, text, false, false, alignment, {
		okFunc,
		okFuncText
	}, {
		cencelFunc,
		cancelFuncText
	})
end

function TipsFacade:openSeasonPopupWindowNoCancelWithTog(title, text, func1, funcTog, btnText1, togText, alignment, uiFlyTweenParam)
	TipsFacade.checkFuncType(func1, funcTog)

	return self:_openPopWindowWithName(ViewName.SeasonPopupWindowView, 1, title, text, true, true, alignment, {
		func1,
		btnText1
	}, {
		funcTog,
		togText
	}, uiFlyTweenParam)
end

function TipsFacade:openPopupWindowBig(title, text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
	TipsFacade.checkFuncType(okFunc, cencelFunc)

	return self:_openPopWindowWithName(ViewName.PopupwindowbigView, 2, title, text, false, false, alignment, {
		okFunc,
		okFuncText
	}, {
		cencelFunc,
		cancelFuncText
	})
end

function TipsFacade:openTipWindowNoXBig(title, text, func, btnText, alignment)
	TipsFacade.checkFuncType(func)

	return self:_openPopWindowWithName(ViewName.PopupwindowbigView, 1, title, text, false, false, alignment, {
		func,
		btnText
	})
end

function TipsFacade:_openPopWindowWithName(viewName, numBtn, title, text, showX, shotTog, alignment, ...)
	if TipsFacade.disableOpenPopupWindow then
		return
	end

	local mgr = ViewMgr.instance

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	TipsFacade.popupWindowSource = nil

	local windCfg = {}

	windCfg.numBtn = numBtn
	windCfg.title = title
	windCfg.text = text
	windCfg.showX = showX
	windCfg.showTog = shotTog
	windCfg.alignment = alignment
	windCfg.params = {
		...
	}

	local presentor = mgr:open(viewName, windCfg)

	presentor.ID = self:getPopUpID()

	return presentor
end

function TipsFacade:getPopUpID()
	POPUP_WIN_ID = POPUP_WIN_ID + 1

	return POPUP_WIN_ID
end

function TipsFacade:openTipWindowNoXExt(title, text, func, btnText, alignment)
	TipsFacade.checkFuncType(func)

	return self:_openWindowExt(1, title, text, false, false, func, alignment, {
		function()
			return
		end,
		btnText
	})
end

function TipsFacade:_openWindowExt(numBtn, title, text, showX, shotTog, exitCallback, alignment, ...)
	if TipsFacade.disableOpenPopupWindow then
		return
	end

	local mgr = ViewMgr.instance
	local viewName = ViewName.Popupwindow

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	TipsFacade.popupWindowSource = nil

	local windCfg = {}

	windCfg.numBtn = numBtn
	windCfg.title = title
	windCfg.text = text
	windCfg.showX = showX
	windCfg.showTog = shotTog
	windCfg.onExitCallBack = exitCallback
	windCfg.alignment = alignment
	windCfg.params = {
		...
	}

	return mgr:open(viewName, windCfg)
end

function TipsFacade:showGetPetEggTips()
	local hasDoIt = UnityEngine.PlayerPrefs.GetString("getpeteggtips_" .. LoginModel.instance.userId)

	if not hasDoIt or #hasDoIt == 0 then
		UnityEngine.PlayerPrefs.SetString("getpeteggtips_" .. LoginModel.instance.userId, "1")
		self:openTipWindow(lang("tip"), lang("petegg_goto_hatch_tips"), function()
			UIStateManager.instance:push(ViewName.petegg)
		end, lang("petegg_goto_hatch"))
	end
end

function TipsFacade:openTipsMaterial(type, id)
	ViewMgr.instance:open(ViewName.tipsMaterial, type, id)
end

function TipsFacade:openPopupCostDiamondView(costNum, content, sureFunc, togFunc, togTxt, alignment, cancelFunc)
	self:openPopupCostMatViewNew(MatType.Diamond, MatType.Diamond_Binding, costNum, content, sureFunc, togFunc, togTxt, alignment, cancelFunc)
end

function TipsFacade:openPopupCostCoinView(costNum, content, sureFunc, togFunc, togTxt)
	self:openPopupCostMatViewNew(MatType.Coin, MatType.Coin_Gold, costNum, content, sureFunc, togFunc, togTxt)
end

function TipsFacade:openPopupCostManyView(targetMat, costMat, maxBuyNum, maxBuyNumTxt, content, sureFunc)
	TipsFacade.checkFuncType(sureFunc)

	local mgr = ViewMgr.instance
	local viewName = ViewName.PopupCostMatMany

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	local param = {}

	param.targetMat = targetMat
	param.costMat = costMat
	param.maxBuyNum = maxBuyNum
	param.maxBuyNumTxt = maxBuyNumTxt
	param.content = content
	param.sureFunc = sureFunc

	mgr:open(viewName, param)
end

function TipsFacade:openPopupCostAdjustView(matType, matId, matNum, content, successCallBack, maxNum, alignment, otherCallBack, autoOpenSource)
	TipsFacade.checkFuncType(successCallBack, otherCallBack)

	local mgr = ViewMgr.instance
	local viewName = ViewName.PopupCostMatAdjustView

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	local param = {}

	param.matType = matType
	param.matId = matId
	param.matNum = matNum
	param.content = content
	param.successCallBack = successCallBack
	param.alignment = alignment
	param.otherCallBack = otherCallBack
	param.autoOpenSource = autoOpenSource
	param.maxNum = maxNum

	mgr:open(viewName, param)
end

function TipsFacade:openPopupCostAdjustBySingleNumView(matType, matId, matNum, dufalutNum, content, successCallBack, maxNum, alignment, otherCallBack, costCallBack, autoOpenSource)
	TipsFacade.checkFuncType(successCallBack, otherCallBack)

	local mgr = ViewMgr.instance
	local viewName = ViewName.PopupCostMatAdjustSingleView

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	local param = {}

	param.matType = matType
	param.matId = matId
	param.matNum = matNum
	param.dufalutNum = dufalutNum
	param.content = content
	param.successCallBack = successCallBack
	param.alignment = alignment
	param.otherCallBack = otherCallBack
	param.costCallBack = costCallBack
	param.autoOpenSource = autoOpenSource
	param.maxNum = maxNum

	mgr:open(viewName, param)
end

function TipsFacade:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
	TipsFacade.checkFuncType(successCallBack, toggleFunc, otherCallBack)

	local mgr = ViewMgr.instance
	local viewName = ViewName.PopupCostMat

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	local param = {}

	param.matType = matType
	param.matId = matId
	param.matNum = matNum
	param.content = content
	param.successCallBack = successCallBack
	param.toggleFunc = toggleFunc
	param.togTxt = togTxt
	param.alignment = alignment
	param.otherCallBack = otherCallBack
	param.autoOpenSource = autoOpenSource

	mgr:open(viewName, param)
end

function TipsFacade:openPopupCostMatViewWithToggleKey(matType, matId, matNum, content, successCallBack, toggleKey, togTxt, alignment, otherCallBack, autoOpenSource)
	if not string.nilorempty(toggleKey) and matNum <= MaterialModel.instance:getMaterialsNumber(matType, matId) then
		togTxt = togTxt or lang("今日不再提示")

		local data = GameUtil.getUserDayData(toggleKey)

		if checknumber(data) == 1 then
			if successCallBack then
				successCallBack()
			end
		else
			self:openPopupCostMatViewNew(matType, matId, matNum, content, function()
				if successCallBack then
					successCallBack()
				end
			end, function(isOn)
				if not isOn then
					GameUtil.saveUserDayData(toggleKey, 1)
				else
					GameUtil.saveUserDayData(toggleKey, 0)
				end
			end, togTxt, alignment, function(key)
				if key == TipsFacade.STATE_CANCEL then
					GameUtil.saveUserDayData(toggleKey, 0)
				end

				if otherCallBack then
					otherCallBack(key)
				end
			end, autoOpenSource)
		end
	else
		self:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, nil, nil, alignment, otherCallBack, autoOpenSource)
	end
end

TipsFacade.magicLockType = {
	"挑战",
	"任务",
	"场景",
	"功能"
}

function TipsFacade:openLockTips(lv, lockType, name)
	local tips = langPara("人物等级达到<color=#ffdd3c>%s级</color>后解锁%s<color=#ffa92e>%s</color>", lv, TipsFacade.magicLockType[lockType] or "", name)

	FloatWordMgr.instance:show(tips)
end

function TipsFacade:openPopupWithIconWindow(title, text, okFunc, cancelFunc, okBtnText, cancelBtnText, toggleFunc)
	local mgr = ViewMgr.instance
	local viewName = ViewName.TextWithIconView

	if mgr:isOpen(viewName) then
		mgr:close(viewName)
	end

	local param = {
		title = title,
		text = text,
		okFunc = okFunc,
		cancelFunc = cancelFunc,
		okBtnText = okBtnText,
		cancelBtnText = cancelBtnText,
		toggleFunc = toggleFunc
	}

	mgr:open(viewName, param)
end

function TipsFacade:getContentMatStr(itemStr, size, ofy, isIcon)
	return MaterialMgr.getContentMatStr(itemStr, size, ofy, isIcon)
end

function TipsFacade:openRulesView(key)
	UIStateManager.instance:push(ViewName.RulesView, key)
end

function TipsFacade:openItemSourceView(data, jumpCallBack)
	local matType = 0
	local matId = 0

	if type(data) == "string" then
		MaterialMgr.openGetSourceByStr(data, jumpCallBack)
	elseif type(data) == "table" then
		matType = checknumber(data.type)
		matId = checknumber(data.id)

		if matId > 0 then
			MaterialMgr.openGetSource(matType, matId, jumpCallBack)
		end
	end
end

function TipsFacade:openImageRuleView(list, titleName, closeCallBack)
	local isPure = true

	for k, v in pairs(list) do
		if not string.nilorempty(v.desc) then
			isPure = false

			break
		end
	end

	if isPure then
		UIStateManager.instance:push(ViewName.DivineMiYaClgImgRuleView, list, titleName, closeCallBack)
	else
		UIStateManager.instance:push(ViewName.PopupImageRuleView, list, titleName, closeCallBack)
	end
end

function TipsFacade:openImageRuleViewByKey(key, titleName, closeCallBack)
	local cfg = RulesConfig.instance:getRuleImgCfg(key) or {}

	if cfg == nil then
		if enableDebug then
			self:openCommonTips("-- config from export_图文说明  in  s说明规则.xlsx 缺少【" .. key .. "】配置")
			printError("-- config from export_图文说明  in  s说明规则.xlsx 缺少【" .. key .. "】配置")
		end
	else
		self:openImageRuleView(cfg, titleName, closeCallBack)
	end
end

function TipsFacade:openImageTipsView(title, desc, imagePath)
	UIStateManager.instance:push(ViewName.ImageTipsView, title, desc, imagePath)
end

function TipsFacade:openInstructionView(instructionMo)
	UIStateManager.instance:push(ViewName.ShenJiInstructionView, instructionMo)
end

function TipsFacade:openPopupCommonCostPopView(coinNum, exchangeRate, titleTxt, sureTxt, cancelTxt, descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack, isOnlyCanClose)
	TipsFacade.checkFuncType(sureCallBack, otherCallBack)

	local viewName = ViewName.CommonCostPopView

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:close(viewName)
	end

	local param = {}

	param.coinNum = coinNum
	param.exchangeRate = exchangeRate
	param.titleTxt = titleTxt
	param.sureTxt = sureTxt
	param.cancelTxt = cancelTxt
	param.descTxt = descTxt
	param.sureCallBack = sureCallBack
	param.cancelCallBack = cancelCallBack
	param.otherCallBack = otherCallBack
	param.updateCoinTxtCallBack = updateCoinTxtCallBack
	param.updateDescTxtCallBack = updateDescTxtCallBack
	param.isOnlyCanClose = isOnlyCanClose

	ViewMgr.instance:open(viewName, param)
end

TipsFacade.instance = TipsFacade.New()

return TipsFacade
