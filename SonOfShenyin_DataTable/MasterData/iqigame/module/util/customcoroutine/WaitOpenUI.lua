-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitOpenUI.lua

WaitOpenUI = class({
	waitType = "WaitOpenUI"
}, CustomWait)

function WaitOpenUI:ctor(uiName, layer, userdata)
	OpenUIUtility.OpenUI(uiName, layer, function(openUIName)
		print("加载UI" .. openUIName .. "完成")

		self.isComplete = true
	end, userdata)
end
