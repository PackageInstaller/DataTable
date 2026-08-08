---@class ItemExchagnePanel_Generate_disableBuyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ItemExchagnePanel_Generate_buyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ItemExchagnePanel_Generate_cancleBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ItemExchagnePanel_Generate_setNumView_numSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class ItemExchagnePanel_Generate_setNumView_maxText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ItemExchagnePanel_Generate_setNumView_minText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ItemExchagnePanel_Generate_setNumView_maxBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ItemExchagnePanel_Generate_setNumView_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ItemExchagnePanel_Generate_setNumView_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ItemExchagnePanel_Generate_setNumView_curNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ItemExchagnePanel_Generate_setNumView_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ItemExchagnePanel_Generate_setNumView
---@field public gameObject UnityEngine.GameObject
---@field public titleText ItemExchagnePanel_Generate_setNumView_titleText
---@field public curNumText ItemExchagnePanel_Generate_setNumView_curNumText
---@field public minusBtn ItemExchagnePanel_Generate_setNumView_minusBtn
---@field public plusBtn ItemExchagnePanel_Generate_setNumView_plusBtn
---@field public maxBtn ItemExchagnePanel_Generate_setNumView_maxBtn
---@field public minText ItemExchagnePanel_Generate_setNumView_minText
---@field public maxText ItemExchagnePanel_Generate_setNumView_maxText
---@field public numSlider ItemExchagnePanel_Generate_setNumView_numSlider

---@class ItemExchagnePanel_Generate_itemNameText_2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ItemExchagnePanel_Generate_customBox_2
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ItemExchagnePanel_Generate_itemNameText_1
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ItemExchagnePanel_Generate_customBox_1
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ItemExchagnePanel_Generate_goodsDescribeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ItemExchagnePanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ItemExchagnePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ItemExchagnePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask ItemExchagnePanel_Generate_mask
---@field public closeBtn ItemExchagnePanel_Generate_closeBtn
---@field public goodsDescribeText ItemExchagnePanel_Generate_goodsDescribeText
---@field public customBox_1 ItemExchagnePanel_Generate_customBox_1
---@field public itemNameText_1 ItemExchagnePanel_Generate_itemNameText_1
---@field public customBox_2 ItemExchagnePanel_Generate_customBox_2
---@field public itemNameText_2 ItemExchagnePanel_Generate_itemNameText_2
---@field public setNumView ItemExchagnePanel_Generate_setNumView
---@field public cancleBtn ItemExchagnePanel_Generate_cancleBtn
---@field public buyBtn ItemExchagnePanel_Generate_buyBtn
---@field public disableBuyBtn ItemExchagnePanel_Generate_disableBuyBtn
local ItemExchagnePanel = class("ItemExchagnePanel", require("WndBase"))

function ItemExchagnePanel:ctor(data)
end

---@private
function ItemExchagnePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ItemExchagnePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ItemExchagnePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ItemExchagnePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("ItemExchagnePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function ItemExchagnePanel:InitGenerate__3(Root, data)
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
		UIMgr:SendUiUseMessage("ItemExchagnePanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function ItemExchagnePanel:InitGenerate__4(Root, data)
--[[
	BoxBg/exchangeInfo/goodsDescribeText
--]]
	local tmp = Root:Find("BoxBg/exchangeInfo/goodsDescribeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goodsDescribeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ItemExchagnePanel:InitGenerate__5(Root, data)
--[[
	BoxBg/exchangeInfo/CustomBox_1
--]]
	local tmp = Root:Find("BoxBg/exchangeInfo/CustomBox_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox_1 = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ItemExchagnePanel:InitGenerate__6(Root, data)
--[[
	BoxBg/exchangeInfo/itemNameText_1
--]]
	local tmp = Root:Find("BoxBg/exchangeInfo/itemNameText_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemNameText_1 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ItemExchagnePanel:InitGenerate__7(Root, data)
--[[
	BoxBg/exchangeInfo/CustomBox_2
--]]
	local tmp = Root:Find("BoxBg/exchangeInfo/CustomBox_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox_2 = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ItemExchagnePanel:InitGenerate__8(Root, data)
--[[
	BoxBg/exchangeInfo/itemNameText_2
--]]
	local tmp = Root:Find("BoxBg/exchangeInfo/itemNameText_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemNameText_2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ItemExchagnePanel:InitGenerate__9(Root, data)
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
function ItemExchagnePanel:InitGenerate__10(Root, data)
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
function ItemExchagnePanel:InitGenerate__11(Root, data)
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
function ItemExchagnePanel:InitGenerate__12(Root, data)
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
		UIMgr:SendUiUseMessage("ItemExchagnePanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.setNumView.minusBtn)
			end
		end)


end

---@private
function ItemExchagnePanel:InitGenerate__13(Root, data)
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
		UIMgr:SendUiUseMessage("ItemExchagnePanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.setNumView.plusBtn)
			end
		end)


end

---@private
function ItemExchagnePanel:InitGenerate__14(Root, data)
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
		UIMgr:SendUiUseMessage("ItemExchagnePanel_maxBtn")
			if self.maxBtn_ScaleButton_onClick then
				self:maxBtn_ScaleButton_onClick(self.setNumView.maxBtn)
			end
		end)


end

---@private
function ItemExchagnePanel:InitGenerate__15(Root, data)
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
function ItemExchagnePanel:InitGenerate__16(Root, data)
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
function ItemExchagnePanel:InitGenerate__17(Root, data)
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
function ItemExchagnePanel:InitGenerate__18(Root, data)
--[[
	BoxBg/buyInfo/cancleBtn
--]]
	local tmp = Root:Find("BoxBg/buyInfo/cancleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancleBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ItemExchagnePanel_cancleBtn")
			if self.cancleBtn_ScaleButton_onClick then
				self:cancleBtn_ScaleButton_onClick(self.cancleBtn)
			end
		end)


end

---@private
function ItemExchagnePanel:InitGenerate__19(Root, data)
--[[
	BoxBg/buyInfo/buyBtn
--]]
	local tmp = Root:Find("BoxBg/buyInfo/buyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ItemExchagnePanel_buyBtn")
			if self.buyBtn_ScaleButton_onClick then
				self:buyBtn_ScaleButton_onClick(self.buyBtn)
			end
		end)


end

---@private
function ItemExchagnePanel:InitGenerate__20(Root, data)
--[[
	BoxBg/buyInfo/disableBuyBtn
--]]
	local tmp = Root:Find("BoxBg/buyInfo/disableBuyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disableBuyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ItemExchagnePanel_disableBuyBtn")
			if self.disableBuyBtn_ScaleButton_onClick then
				self:disableBuyBtn_ScaleButton_onClick(self.disableBuyBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ItemExchagnePanel:SetLocalizedText(Root)

    local locObj_ItemExchagnePanel_titleNameText = Root:Find("BoxBg/titleInfo/titleNameText")
    if locObj_ItemExchagnePanel_titleNameText then
        locObj_ItemExchagnePanel_titleNameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ItemExchagnePanel_titleNameText
    end

    local locObj_ItemExchagnePanel_cn_TextTMP = Root:Find("BoxBg/buyInfo/cancleBtn/Text (TMP)")
    if locObj_ItemExchagnePanel_cn_TextTMP then
        locObj_ItemExchagnePanel_cn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ItemExchagnePanel_cn_TextTMP
    end

    local locObj_ItemExchagnePanel_bn_TextTMP = Root:Find("BoxBg/buyInfo/buyBtn/Text (TMP)")
    if locObj_ItemExchagnePanel_bn_TextTMP then
        locObj_ItemExchagnePanel_bn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ItemExchagnePanel_bn_TextTMP
    end

    local locObj_ItemExchagnePanel_dn_TextTMP = Root:Find("BoxBg/buyInfo/disableBuyBtn/Text (TMP)")
    if locObj_ItemExchagnePanel_dn_TextTMP then
        locObj_ItemExchagnePanel_dn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ItemExchagnePanel_dn_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ItemExchagnePanel