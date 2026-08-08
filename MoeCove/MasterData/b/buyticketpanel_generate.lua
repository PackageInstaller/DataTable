---@class BuyTicketPanel_Generate_allTimeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_nextTimeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_cacelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BuyTicketPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BuyTicketPanel_Generate_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_setNumView_numSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class BuyTicketPanel_Generate_setNumView_maxText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_setNumView_minText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_setNumView_maxBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BuyTicketPanel_Generate_setNumView_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BuyTicketPanel_Generate_setNumView_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BuyTicketPanel_Generate_setNumView_curNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_setNumView_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_setNumView
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public titleText BuyTicketPanel_Generate_setNumView_titleText
---@field public curNumText BuyTicketPanel_Generate_setNumView_curNumText
---@field public minusBtn BuyTicketPanel_Generate_setNumView_minusBtn
---@field public plusBtn BuyTicketPanel_Generate_setNumView_plusBtn
---@field public maxBtn BuyTicketPanel_Generate_setNumView_maxBtn
---@field public minText BuyTicketPanel_Generate_setNumView_minText
---@field public maxText BuyTicketPanel_Generate_setNumView_maxText
---@field public numSlider BuyTicketPanel_Generate_setNumView_numSlider

---@class BuyTicketPanel_Generate_itemBox_buyMaxTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_itemBox_buyMaxTitleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_itemBox_itemCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_itemBox_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class BuyTicketPanel_Generate_itemBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public bg UnityEngine.GameObject
---@field public line UnityEngine.GameObject
---@field public isSelect UnityEngine.GameObject
---@field public nameTxt BuyTicketPanel_Generate_itemBox_nameTxt
---@field public itemCountTxt BuyTicketPanel_Generate_itemBox_itemCountTxt
---@field public maxBg UnityEngine.GameObject
---@field public buyMaxTitleTxt BuyTicketPanel_Generate_itemBox_buyMaxTitleTxt
---@field public buyMaxTxt BuyTicketPanel_Generate_itemBox_buyMaxTxt

---@class BuyTicketPanel_Generate_addCount
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_nowCount
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BuyTicketPanel_Generate_ticketIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class BuyTicketPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class BuyTicketPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask BuyTicketPanel_Generate_mask
---@field public ticketIcon BuyTicketPanel_Generate_ticketIcon
---@field public nowCount BuyTicketPanel_Generate_nowCount
---@field public addCount BuyTicketPanel_Generate_addCount
---@field public itemList UnityEngine.GameObject
---@field public itemBox BuyTicketPanel_Generate_itemBox
---@field public customBox BuyTicketPanel_Generate_customBox
---@field public setNumView BuyTicketPanel_Generate_setNumView
---@field public msgTxt BuyTicketPanel_Generate_msgTxt
---@field public okBtn BuyTicketPanel_Generate_okBtn
---@field public cacelBtn BuyTicketPanel_Generate_cacelBtn
---@field public recoveryTimeBox UnityEngine.GameObject
---@field public nextTimeTxt BuyTicketPanel_Generate_nextTimeTxt
---@field public allTimeTxt BuyTicketPanel_Generate_allTimeTxt
---@field public completeBox UnityEngine.GameObject
local BuyTicketPanel = class("BuyTicketPanel", require("WndBase"))

function BuyTicketPanel:ctor(data)
end

---@private
function BuyTicketPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("BuyTicketPanel")

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
	self:InitGenerate__22(Root,data)
	self:InitGenerate__23(Root,data)
	self:InitGenerate__24(Root,data)
	self:InitGenerate__25(Root,data)
	self:InitGenerate__26(Root,data)
	self:InitGenerate__27(Root,data)
	self:InitGenerate__28(Root,data)
	self:InitGenerate__29(Root,data)
	self:InitGenerate__30(Root,data)
	self:InitGenerate__31(Root,data)
	self:InitGenerate__32(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function BuyTicketPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function BuyTicketPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("BuyTicketPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function BuyTicketPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/MsgBg/IconBg/TicketIcon
--]]
	local tmp = Root:Find("BoxBg/MsgBg/IconBg/TicketIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ticketIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function BuyTicketPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/MsgBg/NowBg/NowCount
--]]
	local tmp = Root:Find("BoxBg/MsgBg/NowBg/NowCount").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowCount = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/MsgBg/AddBg/AddCount
--]]
	local tmp = Root:Find("BoxBg/MsgBg/AddBg/AddCount").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.addCount = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/ItemList
--]]
	local tmp = Root:Find("BoxBg/ItemList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemList = tmp


end

---@private
function BuyTicketPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/ItemList/ItemBox
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function BuyTicketPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/ItemList/ItemBox/Bg
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.bg = tmp


end

---@private
function BuyTicketPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/ItemList/ItemBox/line
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/line").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.line = tmp


end

---@private
function BuyTicketPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/ItemList/ItemBox/IsSelect
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.isSelect = tmp


end

---@private
function BuyTicketPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/ItemList/ItemBox/CustomBox
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function BuyTicketPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/ItemList/ItemBox/NameTxt
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/ItemList/ItemBox/ItemCountTxt
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/ItemCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.itemCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/ItemList/ItemBox/maxBg
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/maxBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.maxBg = tmp


end

---@private
function BuyTicketPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/ItemList/ItemBox/maxBg/layout/BuyMaxTitleTxt
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/maxBg/layout/BuyMaxTitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.buyMaxTitleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/ItemList/ItemBox/maxBg/layout/BuyMaxTxt
--]]
	local tmp = Root:Find("BoxBg/ItemList/ItemBox/maxBg/layout/BuyMaxTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemBox.buyMaxTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/SetNumView
--]]
	local tmp = Root:Find("BoxBg/SetNumView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BuyTicketPanel:InitGenerate__18(Root, data)
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
function BuyTicketPanel:InitGenerate__19(Root, data)
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
function BuyTicketPanel:InitGenerate__20(Root, data)
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
		UIMgr:SendUiUseMessage("BuyTicketPanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.setNumView.minusBtn)
			end
		end)


end

---@private
function BuyTicketPanel:InitGenerate__21(Root, data)
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
		UIMgr:SendUiUseMessage("BuyTicketPanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.setNumView.plusBtn)
			end
		end)


end

---@private
function BuyTicketPanel:InitGenerate__22(Root, data)
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
		UIMgr:SendUiUseMessage("BuyTicketPanel_maxBtn")
			if self.maxBtn_ScaleButton_onClick then
				self:maxBtn_ScaleButton_onClick(self.setNumView.maxBtn)
			end
		end)


end

---@private
function BuyTicketPanel:InitGenerate__23(Root, data)
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
function BuyTicketPanel:InitGenerate__24(Root, data)
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
function BuyTicketPanel:InitGenerate__25(Root, data)
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
function BuyTicketPanel:InitGenerate__26(Root, data)
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
function BuyTicketPanel:InitGenerate__27(Root, data)
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
		UIMgr:SendUiUseMessage("BuyTicketPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function BuyTicketPanel:InitGenerate__28(Root, data)
--[[
	BoxBg/CacelBtn
--]]
	local tmp = Root:Find("BoxBg/CacelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cacelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BuyTicketPanel_cacelBtn")
			if self.cacelBtn_ScaleButton_onClick then
				self:cacelBtn_ScaleButton_onClick(self.cacelBtn)
			end
		end)


end

---@private
function BuyTicketPanel:InitGenerate__29(Root, data)
--[[
	BoxBg/RecoveryTimeBox
--]]
	local tmp = Root:Find("BoxBg/RecoveryTimeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recoveryTimeBox = tmp


end

---@private
function BuyTicketPanel:InitGenerate__30(Root, data)
--[[
	BoxBg/RecoveryTimeBox/NextTime/NextTimeTxt
--]]
	local tmp = Root:Find("BoxBg/RecoveryTimeBox/NextTime/NextTimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nextTimeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__31(Root, data)
--[[
	BoxBg/RecoveryTimeBox/AllTime/AllTimeTxt
--]]
	local tmp = Root:Find("BoxBg/RecoveryTimeBox/AllTime/AllTimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allTimeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BuyTicketPanel:InitGenerate__32(Root, data)
--[[
	BoxBg/CompleteBox
--]]
	local tmp = Root:Find("BoxBg/CompleteBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.completeBox = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function BuyTicketPanel:SetLocalizedText(Root)

    local locObj_BuyTicketPanel_NowCountTitle = Root:Find("BoxBg/MsgBg/NowBg/NowCountTitle")
    if locObj_BuyTicketPanel_NowCountTitle then
        locObj_BuyTicketPanel_NowCountTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_NowCountTitle
    end

    local locObj_BuyTicketPanel_AddCountTitle = Root:Find("BoxBg/MsgBg/AddBg/AddCountTitle")
    if locObj_BuyTicketPanel_AddCountTitle then
        locObj_BuyTicketPanel_AddCountTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_AddCountTitle
    end

    local locObj_BuyTicketPanel_TitleTxt = Root:Find("BoxBg/ItemListTitle/TitleTxt")
    if locObj_BuyTicketPanel_TitleTxt then
        locObj_BuyTicketPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_TitleTxt
    end

    local locObj_BuyTicketPanel_TitleEngTxt = Root:Find("BoxBg/ItemListTitle/TitleEngTxt")
    if locObj_BuyTicketPanel_TitleEngTxt then
        locObj_BuyTicketPanel_TitleEngTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_TitleEngTxt
    end

    local locObj_BuyTicketPanel_txt = Root:Find("BoxBg/OkBtn/txt")
    if locObj_BuyTicketPanel_txt then
        locObj_BuyTicketPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_txt
    end

    local locObj_BuyTicketPanel_Cn_txt = Root:Find("BoxBg/CacelBtn/txt")
    if locObj_BuyTicketPanel_Cn_txt then
        locObj_BuyTicketPanel_Cn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_Cn_txt
    end

    local locObj_BuyTicketPanel_TextTMP = Root:Find("BoxBg/RecoveryTimeBox/NextTime/Text (TMP)")
    if locObj_BuyTicketPanel_TextTMP then
        locObj_BuyTicketPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_TextTMP
    end

    local locObj_BuyTicketPanel_Ae_TextTMP = Root:Find("BoxBg/RecoveryTimeBox/AllTime/Text (TMP)")
    if locObj_BuyTicketPanel_Ae_TextTMP then
        locObj_BuyTicketPanel_Ae_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_Ae_TextTMP
    end

    local locObj_BuyTicketPanel_CompleteTxt = Root:Find("BoxBg/CompleteBox/CompleteTxt")
    if locObj_BuyTicketPanel_CompleteTxt then
        locObj_BuyTicketPanel_CompleteTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_CompleteTxt
    end

    local locObj_BuyTicketPanel_CompleteEng = Root:Find("BoxBg/CompleteBox/CompleteEng")
    if locObj_BuyTicketPanel_CompleteEng then
        locObj_BuyTicketPanel_CompleteEng.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BuyTicketPanel_CompleteEng
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return BuyTicketPanel