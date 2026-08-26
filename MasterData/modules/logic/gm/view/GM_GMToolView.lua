-- chunkname: @modules/logic/gm/view/GM_GMToolView.lua

module("modules.logic.gm.view.GM_GMToolView", package.seeall)

local GM_GMToolView = class("GM_GMToolView", BaseView)

function GM_GMToolView.register()
	GM_GMToolView.GMToolView_register(GMToolView)
end

local function _skipPopUpFlow()
	if not MainController.instance then
		return
	end

	local flow = MainController.instance._popupFlow

	if not flow then
		return
	end

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Main then
		return
	end

	local workList = flow:getWorkList()
	local targetCls = MainThumbnailWork
	local ok = false

	for _, workObj in ipairs(workList) do
		if workObj.class == targetCls then
			ok = true

			break
		end
	end

	if not ok then
		return
	end

	PatFaceController.instance:_destroyPopupFlow()
	MainController.instance:_destroyPopupFlow()
	ViewMgr.instance:closeAllViews({
		ViewName.MainView,
		ViewName.GMToolView,
		ViewName.GMToolView2
	})
	MainController.instance:_onPopupFlowDone(true)
end

function GM_GMToolView.GMToolView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "onInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(T, "_sendGM")

	function T.onInitView(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "onInitView", ...)

		if not SettingsModel.instance:isOverseas() then
			return
		end

		local contentGo = gohelper.findChild(SelfObj.viewGO, "viewport/content")
		local srcGo = gohelper.findChild(contentGo, "item25")
		local afterThisGo = gohelper.findChild(contentGo, "item40")
		local dropLangChangeGo = gohelper.cloneInPlace(srcGo, "[GM_GMToolView]dropLangChangeGo")

		SelfObj._dropLangChange = gohelper.findChildDropdown(dropLangChangeGo, "Dropdown")

		local dropLangChangeText = gohelper.findChildText(dropLangChangeGo, "text")

		dropLangChangeText.text = luaLang("language")

		gohelper.setSiblingAfter(dropLangChangeGo, afterThisGo)

		local emptyGo = gohelper.create2d(contentGo, "[GM_GMToolView]empty")

		gohelper.setSiblingAfter(emptyGo, dropLangChangeGo)
	end

	function T.removeEvents(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "removeEvents", ...)

		if not SettingsModel.instance:isOverseas() then
			return
		end

		SelfObj._dropLangChange:RemoveOnValueChanged()
	end

	function T.onOpen(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "onOpen", ...)

		if not SettingsModel.instance:isOverseas() then
			return
		end

		SelfObj:_initLangChange()
		SelfObj._dropLangChange:AddOnValueChanged(SelfObj._onLangChange, SelfObj)
	end

	function T._sendGM(SelfObj, input)
		GameFacade.showToast(ToastEnum.IconId, input)
		GMCommandHistoryModel.instance:addCommandHistory(input)

		if input:find("bossrush") then
			BossRushController_Test.instance:_test(input)

			return
		end

		local tar = "小瑞安依"

		if string.sub(input, 1, #tar) == tar then
			TravelGoController.instance:exeGM(input)

			return
		end

		if string.find(input, "#") == 1 then
			local param = string.split(input, " ")

			SelfObj:_clientGM(param)

			return
		end

		if GMToolCommands.sendGM(input) then
			return
		end

		GMRpc.instance:sendGMRequest(input)
		SelfObj:_onServerGM(input)
	end

	function T._initLangChange(SelfObj)
		if not SettingsModel.instance:isOverseas() then
			return
		end

		local cSharpArr = GameConfig:GetSupportedLangs()
		local length = cSharpArr.Length

		SelfObj.supportLangs = {}

		for i = 0, length - 1 do
			table.insert(SelfObj.supportLangs, LangSettings.shortcutTab[cSharpArr[i]])
		end

		SelfObj._dropLangChange:ClearOptions()
		SelfObj._dropLangChange:AddOptions(SelfObj.supportLangs)

		local curLang = LangSettings.instance:getCurLangShortcut()

		for i = 1, #SelfObj.supportLangs do
			if SelfObj.supportLangs[i] == curLang then
				SelfObj._dropLangChange:SetValue(i - 1)

				break
			end
		end
	end

	function T._onLangChange(SelfObj, index)
		if not SettingsModel.instance:isOverseas() then
			return
		end

		local selectLang = SelfObj.supportLangs[index + 1]

		LangSettings.instance:SetCurLangType(selectLang)

		local lanIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(selectLang)

		GameLanguageMgr.instance:setLanguageTypeByStoryIndex(lanIndex)
		PlayerPrefsHelper.setNumber("StoryTxtLanType", lanIndex - 1)
		SettingsController.instance:changeLangTxt()
	end

	if SettingsModel.instance:isOverseas() then
		_skipPopUpFlow()
	end
end

return GM_GMToolView
