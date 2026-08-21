---@class PassLevelBuyPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class PassLevelBuyPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class PassLevelBuyPanel_Generate_disableBuyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PassLevelBuyPanel_Generate_buyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PassLevelBuyPanel_Generate_cancleBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PassLevelBuyPanel_Generate_unitPriceText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassLevelBuyPanel_Generate_priceItemImg_1
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class PassLevelBuyPanel_Generate_setNumView_numSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class PassLevelBuyPanel_Generate_setNumView_maxText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassLevelBuyPanel_Generate_setNumView_minText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassLevelBuyPanel_Generate_setNumView_maxBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PassLevelBuyPanel_Generate_setNumView_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PassLevelBuyPanel_Generate_setNumView_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PassLevelBuyPanel_Generate_setNumView_curNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassLevelBuyPanel_Generate_setNumView_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassLevelBuyPanel_Generate_setNumView
---@field public gameObject UnityEngine.GameObject
---@field public titleText PassLevelBuyPanel_Generate_setNumView_titleText
---@field public curNumText PassLevelBuyPanel_Generate_setNumView_curNumText
---@field public minusBtn PassLevelBuyPanel_Generate_setNumView_minusBtn
---@field public plusBtn PassLevelBuyPanel_Generate_setNumView_plusBtn
---@field public maxBtn PassLevelBuyPanel_Generate_setNumView_maxBtn
---@field public minText PassLevelBuyPanel_Generate_setNumView_minText
---@field public maxText PassLevelBuyPanel_Generate_setNumView_maxText
---@field public numSlider PassLevelBuyPanel_Generate_setNumView_numSlider

---@class PassLevelBuyPanel_Generate_advRewardList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public loopGridView SuperScrollView.LoopGridView

---@class PassLevelBuyPanel_Generate_giftNameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassLevelBuyPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class PassLevelBuyPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class PassLevelBuyPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public mask PassLevelBuyPanel_Generate_mask
---@field public closeBtn PassLevelBuyPanel_Generate_closeBtn
---@field public giftSpecialInfo UnityEngine.GameObject
---@field public giftNameText PassLevelBuyPanel_Generate_giftNameText
---@field public advRewardList PassLevelBuyPanel_Generate_advRewardList
---@field public setNumView PassLevelBuyPanel_Generate_setNumView
---@field public priceItemImg_1 PassLevelBuyPanel_Generate_priceItemImg_1
---@field public unitPriceText PassLevelBuyPanel_Generate_unitPriceText
---@field public cancleBtn PassLevelBuyPanel_Generate_cancleBtn
---@field public buyBtn PassLevelBuyPanel_Generate_buyBtn
---@field public disableBuyBtn PassLevelBuyPanel_Generate_disableBuyBtn
---@field public customMsgPanel PassLevelBuyPanel_Generate_customMsgPanel
---@field public customBox PassLevelBuyPanel_Generate_customBox
local PassLevelBuyPanel = class("PassLevelBuyPanel", require("WndBase"))

function PassLevelBuyPanel:ctor(data)
end

---@private
function PassLevelBuyPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("PassLevelBuyPanel")

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
	self:InitGenerate__20(Root,data)
	self:InitGenerate__21(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function PassLevelBuyPanel:InitGenerate__1(Root, data)
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
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__2(Root, data)
--[[
	content/titleInfo/closeBtn
--]]
	local tmp = Root:Find("content/titleInfo/closeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__3(Root, data)
--[[
	content/giftSpecialInfo
--]]
	local tmp = Root:Find("content/giftSpecialInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftSpecialInfo = tmp


end

---@private
function PassLevelBuyPanel:InitGenerate__4(Root, data)
--[[
	content/giftSpecialInfo/giftNameText
--]]
	local tmp = Root:Find("content/giftSpecialInfo/giftNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function PassLevelBuyPanel:InitGenerate__5(Root, data)
--[[
	content/giftSpecialInfo/advRewardList
--]]
	local tmp = Root:Find("content/giftSpecialInfo/advRewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.advRewardList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.loopGridView = tmp:GetComponent(TypeInfo.LoopGridView)


end

---@private
function PassLevelBuyPanel:InitGenerate__6(Root, data)
--[[
	content/SetNumView
--]]
	local tmp = Root:Find("content/SetNumView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView = tmp


end

---@private
function PassLevelBuyPanel:InitGenerate__7(Root, data)
--[[
	content/SetNumView/titleText
--]]
	local tmp = Root:Find("content/SetNumView/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function PassLevelBuyPanel:InitGenerate__8(Root, data)
--[[
	content/SetNumView/curNumInfo/curNumText
--]]
	local tmp = Root:Find("content/SetNumView/curNumInfo/curNumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.curNumText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function PassLevelBuyPanel:InitGenerate__9(Root, data)
--[[
	content/SetNumView/minusBtn
--]]
	local tmp = Root:Find("content/SetNumView/minusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.setNumView.minusBtn)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__10(Root, data)
--[[
	content/SetNumView/plusBtn
--]]
	local tmp = Root:Find("content/SetNumView/plusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.plusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.setNumView.plusBtn)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__11(Root, data)
--[[
	content/SetNumView/maxBtn
--]]
	local tmp = Root:Find("content/SetNumView/maxBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_maxBtn")
			if self.maxBtn_ScaleButton_onClick then
				self:maxBtn_ScaleButton_onClick(self.setNumView.maxBtn)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__12(Root, data)
--[[
	content/SetNumView/minText
--]]
	local tmp = Root:Find("content/SetNumView/minText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function PassLevelBuyPanel:InitGenerate__13(Root, data)
--[[
	content/SetNumView/maxText
--]]
	local tmp = Root:Find("content/SetNumView/maxText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function PassLevelBuyPanel:InitGenerate__14(Root, data)
--[[
	content/SetNumView/numSlider
--]]
	local tmp = Root:Find("content/SetNumView/numSlider").gameObject
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
function PassLevelBuyPanel:InitGenerate__15(Root, data)
--[[
	content/buyInfo/picInfo/priceItemImg_1
--]]
	local tmp = Root:Find("content/buyInfo/picInfo/priceItemImg_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.priceItemImg_1 = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function PassLevelBuyPanel:InitGenerate__16(Root, data)
--[[
	content/buyInfo/picInfo/unitPriceText
--]]
	local tmp = Root:Find("content/buyInfo/picInfo/unitPriceText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.unitPriceText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function PassLevelBuyPanel:InitGenerate__17(Root, data)
--[[
	content/buyInfo/cancleBtn
--]]
	local tmp = Root:Find("content/buyInfo/cancleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancleBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_cancleBtn")
			if self.cancleBtn_ScaleButton_onClick then
				self:cancleBtn_ScaleButton_onClick(self.cancleBtn)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__18(Root, data)
--[[
	content/buyInfo/buyBtn
--]]
	local tmp = Root:Find("content/buyInfo/buyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_buyBtn")
			if self.buyBtn_ScaleButton_onClick then
				self:buyBtn_ScaleButton_onClick(self.buyBtn)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__19(Root, data)
--[[
	content/buyInfo/disableBuyBtn
--]]
	local tmp = Root:Find("content/buyInfo/disableBuyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disableBuyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassLevelBuyPanel_disableBuyBtn")
			if self.disableBuyBtn_ScaleButton_onClick then
				self:disableBuyBtn_ScaleButton_onClick(self.disableBuyBtn)
			end
		end)


end

---@private
function PassLevelBuyPanel:InitGenerate__20(Root, data)
--[[
	CustomMsgPanel
--]]
	local tmp = Root:Find("CustomMsgPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customMsgPanel = tmp

	tmp.customMsgPanel = tmp:AddComponentLua("CustomMsgPanel", data)


end

---@private
function PassLevelBuyPanel:InitGenerate__21(Root, data)
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

function PassLevelBuyPanel:SetLocalizedText(Root)

    local locObj_PassLevelBuyPanel_titleNameText = Root:Find("content/titleInfo/titleNameText")
    if locObj_PassLevelBuyPanel_titleNameText then
        locObj_PassLevelBuyPanel_titleNameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PassLevelBuyPanel_titleNameText
    end

    local locObj_PassLevelBuyPanel_djText = Root:Find("content/buyInfo/picInfo/djText")
    if locObj_PassLevelBuyPanel_djText then
        locObj_PassLevelBuyPanel_djText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PassLevelBuyPanel_djText
    end

    local locObj_PassLevelBuyPanel_TextTMP = Root:Find("content/buyInfo/cancleBtn/Text (TMP)")
    if locObj_PassLevelBuyPanel_TextTMP then
        locObj_PassLevelBuyPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PassLevelBuyPanel_TextTMP
    end

    local locObj_PassLevelBuyPanel_bn_TextTMP = Root:Find("content/buyInfo/buyBtn/Text (TMP)")
    if locObj_PassLevelBuyPanel_bn_TextTMP then
        locObj_PassLevelBuyPanel_bn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PassLevelBuyPanel_bn_TextTMP
    end

    local locObj_PassLevelBuyPanel_dn_TextTMP = Root:Find("content/buyInfo/disableBuyBtn/Text (TMP)")
    if locObj_PassLevelBuyPanel_dn_TextTMP then
        locObj_PassLevelBuyPanel_dn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PassLevelBuyPanel_dn_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return PassLevelBuyPanel