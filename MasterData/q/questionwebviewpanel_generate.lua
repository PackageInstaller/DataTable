---@class QuestionWebViewPanel_Generate_webArea
---@field public gameObject UnityEngine.GameObject
---@field public uniWebView UniWebView

---@class QuestionWebViewPanel_Generate_closeWebBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class QuestionWebViewPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public closeWebBtn QuestionWebViewPanel_Generate_closeWebBtn
---@field public webArea QuestionWebViewPanel_Generate_webArea
local QuestionWebViewPanel = class("QuestionWebViewPanel", require("WndBase"))

function QuestionWebViewPanel:ctor(data)
end

---@private
function QuestionWebViewPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("QuestionWebViewPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function QuestionWebViewPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function QuestionWebViewPanel:InitGenerate__2(Root, data)
--[[
	downBackRt/closeWebBtn
--]]
	local tmp = Root:Find("downBackRt/closeWebBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeWebBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("QuestionWebViewPanel_closeWebBtn")
			if self.closeWebBtn_ScaleButton_onClick then
				self:closeWebBtn_ScaleButton_onClick(self.closeWebBtn)
			end
		end)


end

---@private
function QuestionWebViewPanel:InitGenerate__3(Root, data)
--[[
	WebArea
--]]
	local tmp = Root:Find("WebArea").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.webArea = tmp

	tmp.uniWebView = tmp:GetComponent(TypeInfo.UniWebView)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function QuestionWebViewPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return QuestionWebViewPanel