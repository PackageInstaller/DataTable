local CheckUpdateWnd = class("CheckUpdateWnd", require("WndBase"))

function CheckUpdateWnd:ctor(data)
end

function CheckUpdateWnd:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CheckUpdateWnd")

	local Root = self.transform 
	local tmp

--[[
	BG/progressNode/Progress
--]]
	tmp = Root:Find("BG/progressNode/Progress").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.progress = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.progress_Slider_onValueChanged then
				self:progress_Slider_onValueChanged(self.progress,value)
			end
		end)


--[[
	BG/progressNode/content1
--]]
	tmp = Root:Find("BG/progressNode/content1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content1 = tmp


--[[
	BG/progressNode/content1/Text
--]]
	tmp = Root:Find("BG/progressNode/content1/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.progressText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


--[[
	BG/progressNode/content2
--]]
	tmp = Root:Find("BG/progressNode/content2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content2 = tmp


--[[
	BG/progressNode/content2/Text
--]]
	tmp = Root:Find("BG/progressNode/content2/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.checkState = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)



	self:InitLogic(data)

end

return CheckUpdateWnd