-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/_HeadLua\\HeadInit.lua

local LuaToolkit = Framework.Tools.LuaToolkit

IS_PUBLISH_VERSION = IS_PUBLISH_VERSION or LuaToolkit.IsPublishVersion()
SP_MARK = LuaToolkit.GetPatchSPMark()
IS_EDITOR = LuaToolkit.IsEditor()
IS_VERIFY_VERSION = false
HeadInit = {}

local self = HeadInit
local json = require("cjson")

function HeadInit.OnLuaInit()
	self._done = false

	local pv = LuaToolkit.GetPkgPatchVersion()
	local engineVersion = pv and pv.engineRvn

	if type(engineVersion) == "number" and engineVersion < 351000 then
		Framework.Plugin.NativeUtils.ShowPromptBoxMainThread(HeadInit.onSelect, "Update Notification", "Please delete the game application and re-download it in application store.", "Update", "Web")
	else
		self._done = true
	end
end

function HeadInit.onSelect(yesOrNo)
	local url

	self._selected = yesOrNo

	if self._selected then
		local platform = Framework.Settings.GameSettingHelper.GetPlatformName()

		LuaToolkit.LogEx(platform)

		if platform == "Android" then
			local platformDataString = Framework.SDK.U3DOceanSDK.GetPlatformData()

			LuaToolkit.LogEx(platformDataString)

			local platformData = HeadInit.string2Table(platformDataString)
			local channel_id = platformData.channel_id

			if channel_id == "bilisea" then
				url = "https://play.google.com/store/apps/details?id=com.komoe.fsgp"
			elseif channel_id == "kr" then
				local app_id = platformData.app_id

				if app_id == "7166" then
					url = "https://m.onestore.co.kr/mobilepoc/apps/appsDetail.omp?prodId=0000758891"
				elseif app_id == "6099" then
					url = "https://play.google.com/store/apps/details?id=com.biligamekr.figuregp"
				end
			end
		else
			LuaToolkit.LogEx("not Android")

			local packageName = UnityEngine.Application.identifier

			LuaToolkit.LogEx(packageName)

			if packageName == "com.komoe.fsios" then
				url = "itms-apps://itunes.apple.com/app/id1581721115"
			elseif packageName == "com.biligamekr.figureios" then
				url = "itms-apps://itunes.apple.com/app/id1562971012"
			end
		end
	else
		url = "https://figure.games-flow.com/?open_in_browser=true"
	end

	if url then
		LuaToolkit.LogEx(url)
		LuaToolkit.UnityOpenURL(url)
	else
		LuaToolkit.LogEx("empty url")
	end
end

function HeadInit.IsHeadDone()
	return self._done
end

function HeadInit._onTick()
	self._done = true
end

function HeadInit.string2Table(stringData)
	local tableData = {}

	if type(stringData) ~= "string" then
		-- block empty
	else
		local succ, t = pcall(json.decode, stringData)

		if succ and type(t) == "table" then
			HeadInit.stripUserData(t)

			tableData = t
		end
	end

	return tableData
end

function HeadInit.stripUserData(tableData, stripped)
	if stripped == nil then
		stripped = {}
	end

	if type(tableData) == "table" then
		for k, v in pairs(tableData) do
			local valueType = type(v)

			if valueType == "userdata" then
				tableData[k] = nil
			elseif valueType == "table" and not stripped[v] then
				stripped[v] = true

				HeadInit.stripUserData(v, stripped)
			end
		end
	end
end

return HeadInit
