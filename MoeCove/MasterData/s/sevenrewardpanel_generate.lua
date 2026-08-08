---@class SevenRewardPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class SevenRewardPanel_Generate_cancelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SevenRewardPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SevenRewardPanel_Generate_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SevenRewardPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SevenRewardPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SevenRewardPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask SevenRewardPanel_Generate_mask
---@field public boxBg UnityEngine.GameObject
---@field public closeBtn SevenRewardPanel_Generate_closeBtn
---@field public msgTxt SevenRewardPanel_Generate_msgTxt
---@field public rewardList UnityEngine.GameObject
---@field public okBtn SevenRewardPanel_Generate_okBtn
---@field public cancelBtn SevenRewardPanel_Generate_cancelBtn
---@field public customBox SevenRewardPanel_Generate_customBox
local SevenRewardPanel = class("SevenRewardPanel", require("WndBase"))

function SevenRewardPanel:ctor(data)
end

---@private
function SevenRewardPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SevenRewardPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)
	self:InitGenerate__8(Root,data)
	self:InitGenerate__9(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SevenRewardPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SevenRewardPanel:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SevenRewardPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function SevenRewardPanel:InitGenerate__3(Root, data)
--[[
	BoxBg
--]]
	local tmp = Root:Find("BoxBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.boxBg = tmp


end

---@private
function SevenRewardPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/Bg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/Bg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SevenRewardPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function SevenRewardPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/MsgTxt
--]]
	local tmp = Root:Find("BoxBg/MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SevenRewardPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/Scroll View/Viewport/RewardList
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/RewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardList = tmp


end

---@private
function SevenRewardPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/OkBtn
--]]
	local tmp = Root:Find("BoxBg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SevenRewardPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function SevenRewardPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/CancelBtn
--]]
	local tmp = Root:Find("BoxBg/CancelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SevenRewardPanel_cancelBtn")
			if self.cancelBtn_ScaleButton_onClick then
				self:cancelBtn_ScaleButton_onClick(self.cancelBtn)
			end
		end)


end

---@private
function SevenRewardPanel:InitGenerate__9(Root, data)
--[[
	CustomBox
--]]
	local tmp = Root:Find("CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SevenRewardPanel:SetLocalizedText(Root)

    local locObj_SevenRewardPanel_TitleText = Root:Find("BoxBg/Bg/Titlebg/TitleText")
    if locObj_SevenRewardPanel_TitleText then
        locObj_SevenRewardPanel_TitleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SevenRewardPanel_TitleText
    end

    local locObj_SevenRewardPanel_txt = Root:Find("BoxBg/OkBtn/txt")
    if locObj_SevenRewardPanel_txt then
        locObj_SevenRewardPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SevenRewardPanel_txt
    end

    local locObj_SevenRewardPanel_Cn_txt = Root:Find("BoxBg/CancelBtn/txt")
    if locObj_SevenRewardPanel_Cn_txt then
        locObj_SevenRewardPanel_Cn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SevenRewardPanel_Cn_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SevenRewardPanel