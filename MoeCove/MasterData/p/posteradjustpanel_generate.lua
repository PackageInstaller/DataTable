---@class PosterAdjustPanel_Generate_sizeSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class PosterAdjustPanel_Generate_cancelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PosterAdjustPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PosterAdjustPanel_Generate_resetBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PosterAdjustPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public resetBtn PosterAdjustPanel_Generate_resetBtn
---@field public okBtn PosterAdjustPanel_Generate_okBtn
---@field public cancelBtn PosterAdjustPanel_Generate_cancelBtn
---@field public sizeSlider PosterAdjustPanel_Generate_sizeSlider
local PosterAdjustPanel = class("PosterAdjustPanel", require("WndBase"))

function PosterAdjustPanel:ctor(data)
end

---@private
function PosterAdjustPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("PosterAdjustPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function PosterAdjustPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function PosterAdjustPanel:InitGenerate__2(Root, data)
--[[
	RoleListBg/ResetBtn
--]]
	local tmp = Root:Find("RoleListBg/ResetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PosterAdjustPanel_resetBtn")
			if self.resetBtn_ScaleButton_onClick then
				self:resetBtn_ScaleButton_onClick(self.resetBtn)
			end
		end)


end

---@private
function PosterAdjustPanel:InitGenerate__3(Root, data)
--[[
	RoleListBg/OkBtn
--]]
	local tmp = Root:Find("RoleListBg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PosterAdjustPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function PosterAdjustPanel:InitGenerate__4(Root, data)
--[[
	RoleListBg/CancelBtn
--]]
	local tmp = Root:Find("RoleListBg/CancelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PosterAdjustPanel_cancelBtn")
			if self.cancelBtn_ScaleButton_onClick then
				self:cancelBtn_ScaleButton_onClick(self.cancelBtn)
			end
		end)


end

---@private
function PosterAdjustPanel:InitGenerate__5(Root, data)
--[[
	RoleListBg/SizeSlider
--]]
	local tmp = Root:Find("RoleListBg/SizeSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sizeSlider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.sizeSlider_Slider_onValueChanged then
				self:sizeSlider_Slider_onValueChanged(self.sizeSlider,value)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function PosterAdjustPanel:SetLocalizedText(Root)

    local locObj_PosterAdjustPanel_txt = Root:Find("RoleListBg/ResetBtn/adjustBg/txt")
    if locObj_PosterAdjustPanel_txt then
        locObj_PosterAdjustPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PosterAdjustPanel_txt
    end

    local locObj_PosterAdjustPanel_On_txt = Root:Find("RoleListBg/OkBtn/txt")
    if locObj_PosterAdjustPanel_On_txt then
        locObj_PosterAdjustPanel_On_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PosterAdjustPanel_On_txt
    end

    local locObj_PosterAdjustPanel_Cn_txt = Root:Find("RoleListBg/CancelBtn/txt")
    if locObj_PosterAdjustPanel_Cn_txt then
        locObj_PosterAdjustPanel_Cn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PosterAdjustPanel_Cn_txt
    end

    local locObj_PosterAdjustPanel_Tg_txt = Root:Find("TipImg/txt")
    if locObj_PosterAdjustPanel_Tg_txt then
        locObj_PosterAdjustPanel_Tg_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PosterAdjustPanel_Tg_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return PosterAdjustPanel