---@class MsgBoxMiddle_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBoxMiddle_Generate_confirmBtn_txt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public txt MsgBoxMiddle_Generate_confirmBtn_txt

---@class MsgBoxMiddle_Generate_cancelBtn_txt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_cancelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public txt MsgBoxMiddle_Generate_cancelBtn_txt

---@class MsgBoxMiddle_Generate_buyRaffleTicket_tickBg
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBoxMiddle_Generate_buyRaffleTicket_afterTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_buyRaffleTicket_ticketNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_buyRaffleTicket_ticketIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class MsgBoxMiddle_Generate_buyRaffleTicket_middleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_buyRaffleTicket_payNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_buyRaffleTicket_payIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class MsgBoxMiddle_Generate_buyRaffleTicket_andTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_buyRaffleTicket_freeNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_buyRaffleTicket_freeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class MsgBoxMiddle_Generate_buyRaffleTicket_frontTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_buyRaffleTicket
---@field public gameObject UnityEngine.GameObject
---@field public frontTxt MsgBoxMiddle_Generate_buyRaffleTicket_frontTxt
---@field public freeIcon MsgBoxMiddle_Generate_buyRaffleTicket_freeIcon
---@field public freeNum MsgBoxMiddle_Generate_buyRaffleTicket_freeNum
---@field public andTxt MsgBoxMiddle_Generate_buyRaffleTicket_andTxt
---@field public payIcon MsgBoxMiddle_Generate_buyRaffleTicket_payIcon
---@field public payNum MsgBoxMiddle_Generate_buyRaffleTicket_payNum
---@field public middleTxt MsgBoxMiddle_Generate_buyRaffleTicket_middleTxt
---@field public ticketIcon MsgBoxMiddle_Generate_buyRaffleTicket_ticketIcon
---@field public ticketNum MsgBoxMiddle_Generate_buyRaffleTicket_ticketNum
---@field public afterTxt MsgBoxMiddle_Generate_buyRaffleTicket_afterTxt
---@field public tickBg MsgBoxMiddle_Generate_buyRaffleTicket_tickBg
---@field public tick UnityEngine.GameObject

---@class MsgBoxMiddle_Generate_useItemPanel_haveNumTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_useItemPanel_slider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class MsgBoxMiddle_Generate_useItemPanel_minusBtnGray
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBoxMiddle_Generate_useItemPanel_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBoxMiddle_Generate_useItemPanel_plusBtnGray
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBoxMiddle_Generate_useItemPanel_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBoxMiddle_Generate_useItemPanel_useItemCount
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate_useItemPanel
---@field public gameObject UnityEngine.GameObject
---@field public useItemCount MsgBoxMiddle_Generate_useItemPanel_useItemCount
---@field public plusBtn MsgBoxMiddle_Generate_useItemPanel_plusBtn
---@field public plusBtnGray MsgBoxMiddle_Generate_useItemPanel_plusBtnGray
---@field public minusBtn MsgBoxMiddle_Generate_useItemPanel_minusBtn
---@field public minusBtnGray MsgBoxMiddle_Generate_useItemPanel_minusBtnGray
---@field public slider MsgBoxMiddle_Generate_useItemPanel_slider
---@field public haveNumTxt MsgBoxMiddle_Generate_useItemPanel_haveNumTxt

---@class MsgBoxMiddle_Generate_titleImage
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class MsgBoxMiddle_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBoxMiddle_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskImg UnityEngine.GameObject
---@field public titleText MsgBoxMiddle_Generate_titleText
---@field public titleImage MsgBoxMiddle_Generate_titleImage
---@field public useItemPanel MsgBoxMiddle_Generate_useItemPanel
---@field public buyRaffleTicket MsgBoxMiddle_Generate_buyRaffleTicket
---@field public cancelBtn MsgBoxMiddle_Generate_cancelBtn
---@field public confirmBtn MsgBoxMiddle_Generate_confirmBtn
---@field public closeBtn MsgBoxMiddle_Generate_closeBtn
local MsgBoxMiddle = class("MsgBoxMiddle", require("MsgBoxBase"))

function MsgBoxMiddle:ctor(data)
end

---@private
function MsgBoxMiddle:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("MsgBoxMiddle")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function MsgBoxMiddle:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function MsgBoxMiddle:InitGenerate__2(Root, data)
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
function MsgBoxMiddle:InitGenerate__3(Root, data)
--[[
	PanelBg/TitleBg/TitleText
--]]
	local tmp = Root:Find("PanelBg/TitleBg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__4(Root, data)
--[[
	PanelBg/TitleBg/TitleText/TitleImage
--]]
	local tmp = Root:Find("PanelBg/TitleBg/TitleText/TitleImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleImage = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function MsgBoxMiddle:InitGenerate__5(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel = tmp


end

---@private
function MsgBoxMiddle:InitGenerate__6(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel/UseItemCount
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel/UseItemCount").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel.useItemCount = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__7(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel/PlusBtn
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel/PlusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel.plusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBoxMiddle_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.useItemPanel.plusBtn)
			end
		end)


end

---@private
function MsgBoxMiddle:InitGenerate__8(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel/PlusBtnGray
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel/PlusBtnGray").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel.plusBtnGray = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function MsgBoxMiddle:InitGenerate__9(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel/MinusBtn
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel/MinusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel.minusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBoxMiddle_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.useItemPanel.minusBtn)
			end
		end)


end

---@private
function MsgBoxMiddle:InitGenerate__10(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel/MinusBtnGray
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel/MinusBtnGray").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel.minusBtnGray = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function MsgBoxMiddle:InitGenerate__11(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel/Slider
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel/Slider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel.slider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.slider_Slider_onValueChanged then
				self:slider_Slider_onValueChanged(self.useItemPanel.slider,value)
			end
		end)


end

---@private
function MsgBoxMiddle:InitGenerate__12(Root, data)
--[[
	PanelBg/TypeContent/UseItemPanel/HaveBoxBg/HaveNumTxt
--]]
	local tmp = Root:Find("PanelBg/TypeContent/UseItemPanel/HaveBoxBg/HaveNumTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.useItemPanel.haveNumTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__13(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket = tmp


end

---@private
function MsgBoxMiddle:InitGenerate__14(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/FrontTxt
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/FrontTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.frontTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__15(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/FreeIcon
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/FreeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.freeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function MsgBoxMiddle:InitGenerate__16(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/FreeNum
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/FreeNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.freeNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__17(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/AndTxt
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/AndTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.andTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__18(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/PayIcon
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/PayIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.payIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function MsgBoxMiddle:InitGenerate__19(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/PayNum
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupUp/PayNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.payNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__20(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/MiddleTxt
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/MiddleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.middleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__21(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/TicketIcon
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/TicketIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.ticketIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function MsgBoxMiddle:InitGenerate__22(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/TicketNum
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/TicketNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.ticketNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__23(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/AfterTxt
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/TextGroupDown/AfterTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.afterTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__24(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/SkipTips/TickBg
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/SkipTips/TickBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.tickBg = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBoxMiddle_tickBg")
			if self.tickBg_ScaleButton_onClick then
				self:tickBg_ScaleButton_onClick(self.buyRaffleTicket.tickBg)
			end
		end)


end

---@private
function MsgBoxMiddle:InitGenerate__25(Root, data)
--[[
	PanelBg/TypeContent/BuyRaffleTicket/SkipTips/TickBg/Tick
--]]
	local tmp = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/SkipTips/TickBg/Tick").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyRaffleTicket.tick = tmp


end

---@private
function MsgBoxMiddle:InitGenerate__26(Root, data)
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
		UIMgr:SendUiUseMessage("MsgBoxMiddle_cancelBtn")
			if self.cancelBtn_ScaleButton_onClick then
				self:cancelBtn_ScaleButton_onClick(self.cancelBtn)
			end
		end)


end

---@private
function MsgBoxMiddle:InitGenerate__27(Root, data)
--[[
	PanelBg/BtnsGroup/CancelBtn/txt
--]]
	local tmp = Root:Find("PanelBg/BtnsGroup/CancelBtn/txt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn.txt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__28(Root, data)
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
		UIMgr:SendUiUseMessage("MsgBoxMiddle_confirmBtn")
			if self.confirmBtn_ScaleButton_onClick then
				self:confirmBtn_ScaleButton_onClick(self.confirmBtn)
			end
		end)


end

---@private
function MsgBoxMiddle:InitGenerate__29(Root, data)
--[[
	PanelBg/BtnsGroup/ConfirmBtn/txt
--]]
	local tmp = Root:Find("PanelBg/BtnsGroup/ConfirmBtn/txt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn.txt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBoxMiddle:InitGenerate__30(Root, data)
--[[
	PanelBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBoxMiddle_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function MsgBoxMiddle:SetLocalizedText(Root)

    local locObj_MsgBoxMiddle_TitleTxt = Root:Find("PanelBg/TypeContent/UseItemPanel/TitleTxt")
    if locObj_MsgBoxMiddle_TitleTxt then
        locObj_MsgBoxMiddle_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBoxMiddle_TitleTxt
    end

    local locObj_MsgBoxMiddle_Bt_SkipTips = Root:Find("PanelBg/TypeContent/BuyRaffleTicket/SkipTips")
    if locObj_MsgBoxMiddle_Bt_SkipTips then
        locObj_MsgBoxMiddle_Bt_SkipTips.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBoxMiddle_Bt_SkipTips
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return MsgBoxMiddle