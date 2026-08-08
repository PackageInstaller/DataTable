---@class ResLevelBox_Generate_rewardTxt2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ResLevelBox_Generate_rewardTxt1
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ResLevelBox_Generate_rewardCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ResLevelBox_Generate_stateTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ResLevelBox_Generate_confirmTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ResLevelBox_Generate_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ResLevelBox_Generate_cancelText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ResLevelBox_Generate_cancelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ResLevelBox_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ResLevelBox_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ResLevelBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskImg UnityEngine.GameObject
---@field public closeBtn ResLevelBox_Generate_closeBtn
---@field public titleText ResLevelBox_Generate_titleText
---@field public cancelBtn ResLevelBox_Generate_cancelBtn
---@field public cancelText ResLevelBox_Generate_cancelText
---@field public confirmBtn ResLevelBox_Generate_confirmBtn
---@field public confirmTxt ResLevelBox_Generate_confirmTxt
---@field public state UnityEngine.GameObject
---@field public stateTxt ResLevelBox_Generate_stateTxt
---@field public reward UnityEngine.GameObject
---@field public rewardCountTxt ResLevelBox_Generate_rewardCountTxt
---@field public rewardTxt1 ResLevelBox_Generate_rewardTxt1
---@field public rewardTxt2 ResLevelBox_Generate_rewardTxt2
---@field public arrowDown UnityEngine.GameObject
---@field public arrowUp UnityEngine.GameObject
---@field public tips UnityEngine.GameObject
local ResLevelBox = class("ResLevelBox", require("WndBase"))

function ResLevelBox:ctor(data)
end

---@private
function ResLevelBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ResLevelBox")

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
	self:InitGenerate__10(Root,data)
	self:InitGenerate__11(Root,data)
	self:InitGenerate__12(Root,data)
	self:InitGenerate__13(Root,data)
	self:InitGenerate__14(Root,data)
	self:InitGenerate__15(Root,data)
	self:InitGenerate__16(Root,data)
	self:InitGenerate__17(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ResLevelBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ResLevelBox:InitGenerate__2(Root, data)
--[[
	maskImg
--]]
	local tmp = Root:Find("maskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskImg = tmp


end

---@private
function ResLevelBox:InitGenerate__3(Root, data)
--[[
	PanelBg/Art/TitleBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/Art/TitleBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ResLevelBox_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function ResLevelBox:InitGenerate__4(Root, data)
--[[
	PanelBg/Art/TitleBg/TitleText
--]]
	local tmp = Root:Find("PanelBg/Art/TitleBg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ResLevelBox:InitGenerate__5(Root, data)
--[[
	PanelBg/BtnsGroup/CancelBtn
--]]
	local tmp = Root:Find("PanelBg/BtnsGroup/CancelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ResLevelBox_cancelBtn")
			if self.cancelBtn_ScaleButton_onClick then
				self:cancelBtn_ScaleButton_onClick(self.cancelBtn)
			end
		end)


end

---@private
function ResLevelBox:InitGenerate__6(Root, data)
--[[
	PanelBg/BtnsGroup/CancelBtn/CancelText
--]]
	local tmp = Root:Find("PanelBg/BtnsGroup/CancelBtn/CancelText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ResLevelBox:InitGenerate__7(Root, data)
--[[
	PanelBg/BtnsGroup/ConfirmBtn
--]]
	local tmp = Root:Find("PanelBg/BtnsGroup/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ResLevelBox_confirmBtn")
			if self.confirmBtn_ScaleButton_onClick then
				self:confirmBtn_ScaleButton_onClick(self.confirmBtn)
			end
		end)


end

---@private
function ResLevelBox:InitGenerate__8(Root, data)
--[[
	PanelBg/BtnsGroup/ConfirmBtn/ConfirmTxt
--]]
	local tmp = Root:Find("PanelBg/BtnsGroup/ConfirmBtn/ConfirmTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ResLevelBox:InitGenerate__9(Root, data)
--[[
	PanelBg/Group/State
--]]
	local tmp = Root:Find("PanelBg/Group/State").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.state = tmp


end

---@private
function ResLevelBox:InitGenerate__10(Root, data)
--[[
	PanelBg/Group/State/StateTxt
--]]
	local tmp = Root:Find("PanelBg/Group/State/StateTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.stateTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ResLevelBox:InitGenerate__11(Root, data)
--[[
	PanelBg/Group/Reward
--]]
	local tmp = Root:Find("PanelBg/Group/Reward").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.reward = tmp


end

---@private
function ResLevelBox:InitGenerate__12(Root, data)
--[[
	PanelBg/Group/Reward/RewardCountTxt
--]]
	local tmp = Root:Find("PanelBg/Group/Reward/RewardCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ResLevelBox:InitGenerate__13(Root, data)
--[[
	PanelBg/Group/Reward/RewardCountTxt/RewardTxt1
--]]
	local tmp = Root:Find("PanelBg/Group/Reward/RewardCountTxt/RewardTxt1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardTxt1 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ResLevelBox:InitGenerate__14(Root, data)
--[[
	PanelBg/Group/Reward/RewardCountTxt/RewardTxt2
--]]
	local tmp = Root:Find("PanelBg/Group/Reward/RewardCountTxt/RewardTxt2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardTxt2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ResLevelBox:InitGenerate__15(Root, data)
--[[
	PanelBg/Group/Reward/RewardCountTxt/RewardTxt2/ArrowDown
--]]
	local tmp = Root:Find("PanelBg/Group/Reward/RewardCountTxt/RewardTxt2/ArrowDown").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.arrowDown = tmp


end

---@private
function ResLevelBox:InitGenerate__16(Root, data)
--[[
	PanelBg/Group/Reward/RewardCountTxt/RewardTxt2/ArrowUp
--]]
	local tmp = Root:Find("PanelBg/Group/Reward/RewardCountTxt/RewardTxt2/ArrowUp").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.arrowUp = tmp


end

---@private
function ResLevelBox:InitGenerate__17(Root, data)
--[[
	PanelBg/Group/Tips
--]]
	local tmp = Root:Find("PanelBg/Group/Tips").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tips = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ResLevelBox:SetLocalizedText(Root)

    local locObj_ResLevelBox_txt1 = Root:Find("PanelBg/Group/State/StateBg/txt (1)")
    if locObj_ResLevelBox_txt1 then
        locObj_ResLevelBox_txt1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ResLevelBox_txt1
    end

    local locObj_ResLevelBox_Sg_txt1 = Root:Find("PanelBg/Group/Reward/StateBg/txt (1)")
    if locObj_ResLevelBox_Sg_txt1 then
        locObj_ResLevelBox_Sg_txt1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ResLevelBox_Sg_txt1
    end

    local locObj_ResLevelBox_TextTMP = Root:Find("PanelBg/Group/Tips/Image (1)/Text (TMP)")
    if locObj_ResLevelBox_TextTMP then
        locObj_ResLevelBox_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ResLevelBox_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ResLevelBox