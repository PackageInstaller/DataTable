---@class AgeTips_Generate_agreeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AgeTips_Generate_disagreeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AgeTips_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AgeTips_Generate_closeBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AgeTips_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public closeBg AgeTips_Generate_closeBg
---@field public titleTxt AgeTips_Generate_titleTxt
---@field public disagreeBtn AgeTips_Generate_disagreeBtn
---@field public agreeBtn AgeTips_Generate_agreeBtn
local AgeTips = class("AgeTips", require("WndBase"))

function AgeTips:ctor(data)
end

---@private
function AgeTips:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AgeTips")

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
function AgeTips:InitGenerate__1(Root, data)
--[[
	closeBg
--]]
	local tmp = Root:Find("closeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AgeTips_closeBg")
			if self.closeBg_Button_onClick then
				self:closeBg_Button_onClick(self.closeBg)
			end
		end)


end

---@private
function AgeTips:InitGenerate__2(Root, data)
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
function AgeTips:InitGenerate__3(Root, data)
--[[
	BoxBg/BtnList/disagreeBtn
--]]
	local tmp = Root:Find("BoxBg/BtnList/disagreeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disagreeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AgeTips_disagreeBtn")
			if self.disagreeBtn_ScaleButton_onClick then
				self:disagreeBtn_ScaleButton_onClick(self.disagreeBtn)
			end
		end)


end

---@private
function AgeTips:InitGenerate__4(Root, data)
--[[
	BoxBg/BtnList/agreeBtn
--]]
	local tmp = Root:Find("BoxBg/BtnList/agreeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.agreeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AgeTips_agreeBtn")
			if self.agreeBtn_ScaleButton_onClick then
				self:agreeBtn_ScaleButton_onClick(self.agreeBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function AgeTips:SetLocalizedText(Root)

    local locObj_AgeTips_desc = Root:Find("BoxBg/Scroll View/Viewport/Content/desc")
    if locObj_AgeTips_desc then
        locObj_AgeTips_desc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AgeTips_desc
    end

    local locObj_AgeTips_txt = Root:Find("BoxBg/BtnList/disagreeBtn/txt")
    if locObj_AgeTips_txt then
        locObj_AgeTips_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AgeTips_txt
    end

    local locObj_AgeTips_an_txt = Root:Find("BoxBg/BtnList/agreeBtn/txt")
    if locObj_AgeTips_an_txt then
        locObj_AgeTips_an_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AgeTips_an_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return AgeTips