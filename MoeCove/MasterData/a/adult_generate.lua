---@class Adult_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class Adult_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class Adult_Generate_maskImg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class Adult_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public maskImg Adult_Generate_maskImg
---@field public titleTxt Adult_Generate_titleTxt
---@field public closeBtn Adult_Generate_closeBtn
local Adult = class("Adult", require("WndBase"))

function Adult:ctor(data)
end

---@private
function Adult:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("Adult")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function Adult:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function Adult:InitGenerate__2(Root, data)
--[[
	maskImg
--]]
	local tmp = Root:Find("maskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskImg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("Adult_maskImg")
			if self.maskImg_Button_onClick then
				self:maskImg_Button_onClick(self.maskImg)
			end
		end)


end

---@private
function Adult:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleTxt
--]]
	local tmp = Root:Find("BoxBg/TitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function Adult:InitGenerate__4(Root, data)
--[[
	BoxBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("Adult_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function Adult:SetLocalizedText(Root)

    local locObj_Adult_desc = Root:Find("BoxBg/Scroll View/Viewport/Content/desc")
    if locObj_Adult_desc then
        locObj_Adult_desc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.Adult_desc
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return Adult