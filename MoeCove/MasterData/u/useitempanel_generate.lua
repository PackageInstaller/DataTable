---@class UseItemPanel_Generate_useBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseItemPanel_Generate_setNumView_numSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class UseItemPanel_Generate_setNumView_maxText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UseItemPanel_Generate_setNumView_minText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UseItemPanel_Generate_setNumView_maxBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseItemPanel_Generate_setNumView_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseItemPanel_Generate_setNumView_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseItemPanel_Generate_setNumView_curNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UseItemPanel_Generate_setNumView_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UseItemPanel_Generate_setNumView
---@field public gameObject UnityEngine.GameObject
---@field public titleText UseItemPanel_Generate_setNumView_titleText
---@field public curNumText UseItemPanel_Generate_setNumView_curNumText
---@field public minusBtn UseItemPanel_Generate_setNumView_minusBtn
---@field public plusBtn UseItemPanel_Generate_setNumView_plusBtn
---@field public maxBtn UseItemPanel_Generate_setNumView_maxBtn
---@field public minText UseItemPanel_Generate_setNumView_minText
---@field public maxText UseItemPanel_Generate_setNumView_maxText
---@field public numSlider UseItemPanel_Generate_setNumView_numSlider

---@class UseItemPanel_Generate_discribeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UseItemPanel_Generate_ownItemText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UseItemPanel_Generate_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UseItemPanel_Generate_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class UseItemPanel_Generate_qualityImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class UseItemPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UseItemPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class UseItemPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animOverCallBack AnimOverCallBack
---@field public animation UnityEngine.Animation
---@field public mask UseItemPanel_Generate_mask
---@field public closeBtn UseItemPanel_Generate_closeBtn
---@field public qualityImg UseItemPanel_Generate_qualityImg
---@field public iconImg UseItemPanel_Generate_iconImg
---@field public itemSpecialInfo UnityEngine.GameObject
---@field public nameText UseItemPanel_Generate_nameText
---@field public ownItemText UseItemPanel_Generate_ownItemText
---@field public discribeText UseItemPanel_Generate_discribeText
---@field public setNumView UseItemPanel_Generate_setNumView
---@field public useBtn UseItemPanel_Generate_useBtn
local UseItemPanel = class("UseItemPanel", require("WndBase"))

function UseItemPanel:ctor(data)
end

---@private
function UseItemPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("UseItemPanel")

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
	self:InitGenerate__18(Root,data)
	self:InitGenerate__19(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function UseItemPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)

	self.animation = Root:GetComponent(TypeInfo.Animation)


end

---@private
function UseItemPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("UseItemPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function UseItemPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/titleInfo/closeBtn
--]]
	local tmp = Root:Find("BoxBg/titleInfo/closeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseItemPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function UseItemPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/itemView/qualityImg
--]]
	local tmp = Root:Find("BoxBg/itemView/qualityImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.qualityImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UseItemPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/itemView/iconImg
--]]
	local tmp = Root:Find("BoxBg/itemView/iconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UseItemPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/itemSpecialInfo
--]]
	local tmp = Root:Find("BoxBg/itemSpecialInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemSpecialInfo = tmp


end

---@private
function UseItemPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/itemSpecialInfo/nameText
--]]
	local tmp = Root:Find("BoxBg/itemSpecialInfo/nameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UseItemPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/itemSpecialInfo/ownInfo/ownItemText
--]]
	local tmp = Root:Find("BoxBg/itemSpecialInfo/ownInfo/ownItemText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ownItemText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UseItemPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/itemSpecialInfo/discribeText
--]]
	local tmp = Root:Find("BoxBg/itemSpecialInfo/discribeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.discribeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UseItemPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/SetNumView
--]]
	local tmp = Root:Find("BoxBg/SetNumView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView = tmp


end

---@private
function UseItemPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/SetNumView/titleText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UseItemPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/SetNumView/curNumInfo/curNumText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/curNumInfo/curNumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.curNumText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UseItemPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/SetNumView/minusBtn
--]]
	local tmp = Root:Find("BoxBg/SetNumView/minusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseItemPanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.setNumView.minusBtn)
			end
		end)


end

---@private
function UseItemPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/SetNumView/plusBtn
--]]
	local tmp = Root:Find("BoxBg/SetNumView/plusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.plusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseItemPanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.setNumView.plusBtn)
			end
		end)


end

---@private
function UseItemPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/SetNumView/maxBtn
--]]
	local tmp = Root:Find("BoxBg/SetNumView/maxBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseItemPanel_maxBtn")
			if self.maxBtn_ScaleButton_onClick then
				self:maxBtn_ScaleButton_onClick(self.setNumView.maxBtn)
			end
		end)


end

---@private
function UseItemPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/SetNumView/minText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/minText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UseItemPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/SetNumView/maxText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/maxText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UseItemPanel:InitGenerate__18(Root, data)
--[[
	BoxBg/SetNumView/numSlider
--]]
	local tmp = Root:Find("BoxBg/SetNumView/numSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.numSlider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.numSlider_Slider_onValueChanged then
				self:numSlider_Slider_onValueChanged(self.setNumView.numSlider,value)
			end
		end)


end

---@private
function UseItemPanel:InitGenerate__19(Root, data)
--[[
	BoxBg/useBtn
--]]
	local tmp = Root:Find("BoxBg/useBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UseItemPanel_useBtn")
			if self.useBtn_ScaleButton_onClick then
				self:useBtn_ScaleButton_onClick(self.useBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function UseItemPanel:SetLocalizedText(Root)

    local locObj_UseItemPanel_titleNameText = Root:Find("BoxBg/titleInfo/titleNameText")
    if locObj_UseItemPanel_titleNameText then
        locObj_UseItemPanel_titleNameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UseItemPanel_titleNameText
    end

    local locObj_UseItemPanel_TextTMP = Root:Find("BoxBg/useBtn/Text (TMP)")
    if locObj_UseItemPanel_TextTMP then
        locObj_UseItemPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UseItemPanel_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return UseItemPanel