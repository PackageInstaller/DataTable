-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/StoryEditor.lua

StoryEditor = class("StoryEditor", DebugViewTemplate, _M)

StoryEditor:has("_eventDispatcher", {
	is = "rw"
}):injectWith("legs_sharedEventDispatcher")
StoryEditor:has("_gameContext", {
	is = "rw"
}):injectWith("GameContext")

function StoryEditor:initialize()
	self._opType = 171
	self._viewConfig = {}
end

function StoryEditor:onClick(data)
	local curVersion = app:getAssetsManager():getLatestVersion()

	if not curVersion or curVersion == 0 then
		curVersion = "dev"
	end

	self:vmsRequest((app.pkgConfig and app.pkgConfig.captainUrl and app.pkgConfig.captainUrl ~= "" or nil) and app.pkgConfig.captainUrl, curVersion, function(vmsErrorCode, vmsResponse)
		local cjson = require("cjson.safe")
		local vmsData = cjson.decode(vmsResponse)

		if vmsErrorCode == 200 and vmsData.data.storyUpdateUrl ~= nil then
			self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "storyEditorScene", nil, {
				storyUpdateUrl = vmsData.data.storyUpdateUrl
			}))
		else
			dump("申请vms错误")
		end
	end)
end

function StoryEditor:vmsRequest(url, version, callback)
	local data = url .. string.format("?version=%s", tostring(version))
	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	xhr:open("GET", data)

	local function httpResponse()
		if callback then
			callback(xhr.status, xhr.response)
		end
	end

	xhr:registerScriptHandler(httpResponse)
	xhr:send()
end

StorySaveClear = class("StorySaveClear", DebugViewTemplate, _M)

function StorySaveClear:initialize()
	self._viewConfig = {}
end

function StorySaveClear:onClick(data)
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

	customDataSystem:clearValuesByType(PrefixType.kStory)
end

ClearPrologue = class("ClearPrologue", DebugViewTemplate, _M)

function ClearPrologue:initialize()
	self._viewConfig = {}
end

function ClearPrologue:onClick(data)
	cc.UserDefault:getInstance():setBoolForKey("prologue", false)
end
