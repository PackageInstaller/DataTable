-- chunkname: @modules/logic/gm/view/GMToolCommands.lua

local GMToolCommands = {}
local sIsCapture = false
local sInputLower = ""
local kCmdPrefixLowerCaseList = {
	"boxlang",
	"showui"
}

function GMToolCommands._callByPerfix(prefix, input)
	if not sInputLower:find(prefix) then
		return
	end

	local inputNoPrefix = tostring(input:sub(#prefix + 1))

	inputNoPrefix = string.trim(inputNoPrefix)

	GMToolCommands[prefix](inputNoPrefix)
end

function GMToolCommands.sendGM(input_)
	input_ = string.trim(input_)

	if string.nilorempty(input_) then
		return
	end

	GMCommandHistoryModel.instance:addCommandHistory(input_)

	sIsCapture = false
	sInputLower = string.lower(input_)

	for _, prefix in ipairs(kCmdPrefixLowerCaseList) do
		GMToolCommands._callByPerfix(prefix, input_)

		if sIsCapture then
			break
		end
	end

	return sIsCapture
end

function GMToolCommands.boxlang(inputNoPrefix)
	local idList = string.split(inputNoPrefix, " ")
	local msg = ""
	local consoleMsg = ""

	for _, id in ipairs(idList) do
		if not string.nilorempty(id) then
			local item = id:find("language_") and LangConfig.instance:getLangTxt(nil, id) or luaLang(id)

			if msg ~= "" then
				msg = msg .. "\n"
			end

			if consoleMsg ~= "" then
				consoleMsg = consoleMsg .. "\n"
			end

			msg = msg .. item
			consoleMsg = consoleMsg .. string.format("%s\n\t%s", id, item)
		end
	end

	if not string.nilorempty(msg) then
		consoleMsg = "\n" .. consoleMsg

		MessageBoxController.instance:showMsgBoxByStr(msg, MsgBoxEnum.BoxType.Yes, function()
			logNormal(consoleMsg)
		end, nil)

		sIsCapture = true
	end
end

local function _showui_SettingsModel_initResolutionRationDataList(ctx)
	function SettingsModel:initResolutionRationDataList()
		SettingsModel.instance:initRateAndSystemSize()

		local skipIndex = ctx.skipIndex

		self._resolutionRatioDataList = {}

		local resolution = UnityEngine.Screen.currentResolution
		local rWidth = resolution.width

		if self._resolutionRatioDataList and #self._resolutionRatioDataList >= 1 then
			local oldMaxWidth = self._resolutionRatioDataList[1]

			if oldMaxWidth == rWidth then
				return
			end
		end

		local fullScreenHeight = math.floor(rWidth / self._curRate)

		self:_appendResolutionData(rWidth, fullScreenHeight, true)

		for i, width in ipairs(SettingsModel.ResolutionRatioWidthList) do
			if skipIndex < i then
				local height = math.floor(width / self._curRate)

				self:_appendResolutionData(width, height, false)
			end
		end

		local _, isNotFound = self:getCurrentDropDownIndex()

		if isNotFound then
			local nowW, nowH, isFullScreen = self:getCurrentResolutionWHAndIsFull()

			self:_appendResolutionData(nowW, nowH, isFullScreen)
		end
	end
end

local function _showui_SettingsGraphicsView_editableInitView()
	function SettingsGraphicsView:_editableInitView()
		self:_refreshDropdownList()
		gohelper.setActive(self._drop.gameObject, true)
		gohelper.setActive(self._goscreen.gameObject, true)
		gohelper.setActive(self._goenergy.gameObject, false)

		if SDKNativeUtil.isShowShareButton() then
			gohelper.setActive(self._goscreenshot, true)
		else
			gohelper.setActive(self._goscreenshot, false)
		end

		gohelper.addUIClickAudio(self._btnframerateswitch.gameObject, AudioEnum.UI.UI_Mission_switch)
	end
end

function GMToolCommands.showui(inputNoPrefix)
	local isCustomOpenFunc = false
	local cmdList = string.split(inputNoPrefix, " ")
	local viewNameKey = cmdList[1]

	if not viewNameKey then
		return
	end

	local viewName = ViewName[viewNameKey]

	if not viewName then
		logNormal("no define ViewName." .. viewNameKey)

		return
	end

	local param

	if viewName == ViewName.SettingsPCSystemView or viewName == ViewName.SettingsView then
		local maxResoletion = cmdList[2]
		local skipIndex = 0

		if maxResoletion then
			maxResoletion = string.lower(maxResoletion)

			if maxResoletion == "8k" then
				skipIndex = 1
			elseif maxResoletion == "4k" then
				skipIndex = 2
			elseif maxResoletion == "2k" then
				skipIndex = 3
			elseif maxResoletion == "1k" then
				skipIndex = 4
			else
				logNormal("not support " .. maxResoletion)
			end
		end

		local ctx = {
			skipIndex = skipIndex
		}

		_showui_SettingsModel_initResolutionRationDataList(ctx)

		function SettingsModel.setResolutionRatio()
			return
		end
	end

	if viewName == ViewName.SettingsView then
		isCustomOpenFunc = true

		function BootNativeUtil.isWindows()
			return true
		end

		_showui_SettingsGraphicsView_editableInitView()
		SettingsController.instance:openView()
	end

	if not isCustomOpenFunc then
		ViewMgr.instance:openView(viewName, param)
	end

	sIsCapture = true
end

require("modules/logic/gm/GMTool")

return GMToolCommands
