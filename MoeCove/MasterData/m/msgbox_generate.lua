---@class MsgBox_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBox_Generate_confirmBtn_txt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public txt MsgBox_Generate_confirmBtn_txt

---@class MsgBox_Generate_cancelBtn_txt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate_cancelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public txt MsgBox_Generate_cancelBtn_txt

---@class MsgBox_Generate_dispatchPanel
---@field public gameObject UnityEngine.GameObject
---@field public t1 UnityEngine.GameObject
---@field public t2 UnityEngine.GameObject

---@class MsgBox_Generate_agreementPanel_policy
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBox_Generate_agreementPanel_userpotocol
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBox_Generate_agreementPanel
---@field public gameObject UnityEngine.GameObject
---@field public userpotocol MsgBox_Generate_agreementPanel_userpotocol
---@field public policy MsgBox_Generate_agreementPanel_policy

---@class MsgBox_Generate_selectPayPanel_wxpayBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public checkBack UnityEngine.GameObject
---@field public isOn UnityEngine.GameObject

---@class MsgBox_Generate_selectPayPanel_alipayBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public checkBack UnityEngine.GameObject
---@field public isOn UnityEngine.GameObject

---@class MsgBox_Generate_selectPayPanel
---@field public gameObject UnityEngine.GameObject
---@field public alipayBtn MsgBox_Generate_selectPayPanel_alipayBtn
---@field public wxpayBtn MsgBox_Generate_selectPayPanel_wxpayBtn

---@class MsgBox_Generate_giftTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate_noTipsBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isOn UnityEngine.GameObject

---@class MsgBox_Generate_signField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class MsgBox_Generate_codeField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class MsgBox_Generate_resetNameBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MsgBox_Generate_nameField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class MsgBox_Generate_buyCountMsgText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate_buyText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate_msgText_emoji
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate_msgText
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate_titleImage
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class MsgBox_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MsgBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animOverCallBack AnimOverCallBack
---@field public animation UnityEngine.Animation
---@field public mask UnityEngine.GameObject
---@field public titleText MsgBox_Generate_titleText
---@field public titleImage MsgBox_Generate_titleImage
---@field public msgText MsgBox_Generate_msgText
---@field public msgText_emoji MsgBox_Generate_msgText_emoji
---@field public buyPanel UnityEngine.GameObject
---@field public buyText MsgBox_Generate_buyText
---@field public buyCountMsgText MsgBox_Generate_buyCountMsgText
---@field public changeNamePanel UnityEngine.GameObject
---@field public nameField MsgBox_Generate_nameField
---@field public illegalTipsBg UnityEngine.GameObject
---@field public resetNameBtn MsgBox_Generate_resetNameBtn
---@field public codePanel UnityEngine.GameObject
---@field public codeField MsgBox_Generate_codeField
---@field public changeSignPanel UnityEngine.GameObject
---@field public signField MsgBox_Generate_signField
---@field public giftPanel UnityEngine.GameObject
---@field public noTipsBtn MsgBox_Generate_noTipsBtn
---@field public giftTxt MsgBox_Generate_giftTxt
---@field public selectPayPanel MsgBox_Generate_selectPayPanel
---@field public agreementPanel MsgBox_Generate_agreementPanel
---@field public dispatchPanel MsgBox_Generate_dispatchPanel
---@field public cancelBtn MsgBox_Generate_cancelBtn
---@field public confirmBtn MsgBox_Generate_confirmBtn
---@field public closeBtn MsgBox_Generate_closeBtn
local MsgBox = class("MsgBox", require("MsgBoxBase"))

function MsgBox:ctor(data)
end

---@private
function MsgBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("MsgBox")

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
	self:InitGenerate__33(Root,data)
	self:InitGenerate__34(Root,data)
	self:InitGenerate__35(Root,data)
	self:InitGenerate__36(Root,data)
	self:InitGenerate__37(Root,data)
	self:InitGenerate__38(Root,data)
	self:InitGenerate__39(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function MsgBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)

	self.animation = Root:GetComponent(TypeInfo.Animation)


end

---@private
function MsgBox:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp


end

---@private
function MsgBox:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleBg/TitleText
--]]
	local tmp = Root:Find("BoxBg/TitleBg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__4(Root, data)
--[[
	BoxBg/TitleBg/TitleText/TitleImage
--]]
	local tmp = Root:Find("BoxBg/TitleBg/TitleText/TitleImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleImage = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function MsgBox:InitGenerate__5(Root, data)
--[[
	BoxBg/TypeContent/MsgText
--]]
	local tmp = Root:Find("BoxBg/TypeContent/MsgText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgText = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__6(Root, data)
--[[
	BoxBg/TypeContent/MsgText_emoji
--]]
	local tmp = Root:Find("BoxBg/TypeContent/MsgText_emoji").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgText_emoji = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__7(Root, data)
--[[
	BoxBg/TypeContent/BuyPanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/BuyPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyPanel = tmp


end

---@private
function MsgBox:InitGenerate__8(Root, data)
--[[
	BoxBg/TypeContent/BuyPanel/BuySomePanel/BuyText
--]]
	local tmp = Root:Find("BoxBg/TypeContent/BuyPanel/BuySomePanel/BuyText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__9(Root, data)
--[[
	BoxBg/TypeContent/BuyPanel/BuyCountMsgText
--]]
	local tmp = Root:Find("BoxBg/TypeContent/BuyPanel/BuyCountMsgText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyCountMsgText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__10(Root, data)
--[[
	BoxBg/TypeContent/ChangeNamePanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/ChangeNamePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeNamePanel = tmp


end

---@private
function MsgBox:InitGenerate__11(Root, data)
--[[
	BoxBg/TypeContent/ChangeNamePanel/NameField
--]]
	local tmp = Root:Find("BoxBg/TypeContent/ChangeNamePanel/NameField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.nameField_InputField_onEndEdit then
				self:nameField_InputField_onEndEdit(self.nameField,content)
			end
		end)


end

---@private
function MsgBox:InitGenerate__12(Root, data)
--[[
	BoxBg/TypeContent/ChangeNamePanel/IllegalTipsBg
--]]
	local tmp = Root:Find("BoxBg/TypeContent/ChangeNamePanel/IllegalTipsBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.illegalTipsBg = tmp


end

---@private
function MsgBox:InitGenerate__13(Root, data)
--[[
	BoxBg/TypeContent/ChangeNamePanel/ResetNameBtn
--]]
	local tmp = Root:Find("BoxBg/TypeContent/ChangeNamePanel/ResetNameBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetNameBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_resetNameBtn")
			if self.resetNameBtn_ScaleButton_onClick then
				self:resetNameBtn_ScaleButton_onClick(self.resetNameBtn)
			end
		end)


end

---@private
function MsgBox:InitGenerate__14(Root, data)
--[[
	BoxBg/TypeContent/CodePanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/CodePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.codePanel = tmp


end

---@private
function MsgBox:InitGenerate__15(Root, data)
--[[
	BoxBg/TypeContent/CodePanel/CodeField
--]]
	local tmp = Root:Find("BoxBg/TypeContent/CodePanel/CodeField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.codeField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.codeField_InputField_onEndEdit then
				self:codeField_InputField_onEndEdit(self.codeField,content)
			end
		end)


end

---@private
function MsgBox:InitGenerate__16(Root, data)
--[[
	BoxBg/TypeContent/ChangeSignPanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/ChangeSignPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeSignPanel = tmp


end

---@private
function MsgBox:InitGenerate__17(Root, data)
--[[
	BoxBg/TypeContent/ChangeSignPanel/SignField
--]]
	local tmp = Root:Find("BoxBg/TypeContent/ChangeSignPanel/SignField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.signField_InputField_onEndEdit then
				self:signField_InputField_onEndEdit(self.signField,content)
			end
		end)


end

---@private
function MsgBox:InitGenerate__18(Root, data)
--[[
	BoxBg/TypeContent/GiftPanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/GiftPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftPanel = tmp


end

---@private
function MsgBox:InitGenerate__19(Root, data)
--[[
	BoxBg/TypeContent/GiftPanel/NoTipsBtn
--]]
	local tmp = Root:Find("BoxBg/TypeContent/GiftPanel/NoTipsBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noTipsBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_noTipsBtn")
			if self.noTipsBtn_ScaleButton_onClick then
				self:noTipsBtn_ScaleButton_onClick(self.noTipsBtn)
			end
		end)


end

---@private
function MsgBox:InitGenerate__20(Root, data)
--[[
	BoxBg/TypeContent/GiftPanel/NoTipsBtn/IsOn
--]]
	local tmp = Root:Find("BoxBg/TypeContent/GiftPanel/NoTipsBtn/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noTipsBtn.isOn = tmp


end

---@private
function MsgBox:InitGenerate__21(Root, data)
--[[
	BoxBg/TypeContent/GiftPanel/GiftTxt
--]]
	local tmp = Root:Find("BoxBg/TypeContent/GiftPanel/GiftTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__22(Root, data)
--[[
	BoxBg/TypeContent/SelectPayPanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/SelectPayPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectPayPanel = tmp


end

---@private
function MsgBox:InitGenerate__23(Root, data)
--[[
	BoxBg/TypeContent/SelectPayPanel/alipayBtn
--]]
	local tmp = Root:Find("BoxBg/TypeContent/SelectPayPanel/alipayBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectPayPanel.alipayBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_alipayBtn")
			if self.alipayBtn_ScaleButton_onClick then
				self:alipayBtn_ScaleButton_onClick(self.selectPayPanel.alipayBtn)
			end
		end)


end

---@private
function MsgBox:InitGenerate__24(Root, data)
--[[
	BoxBg/TypeContent/SelectPayPanel/alipayBtn/checkBack
--]]
	local tmp = Root:Find("BoxBg/TypeContent/SelectPayPanel/alipayBtn/checkBack").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectPayPanel.alipayBtn.checkBack = tmp


end

---@private
function MsgBox:InitGenerate__25(Root, data)
--[[
	BoxBg/TypeContent/SelectPayPanel/alipayBtn/checkBack/IsOn
--]]
	local tmp = Root:Find("BoxBg/TypeContent/SelectPayPanel/alipayBtn/checkBack/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectPayPanel.alipayBtn.isOn = tmp


end

---@private
function MsgBox:InitGenerate__26(Root, data)
--[[
	BoxBg/TypeContent/SelectPayPanel/wxpayBtn
--]]
	local tmp = Root:Find("BoxBg/TypeContent/SelectPayPanel/wxpayBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectPayPanel.wxpayBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_wxpayBtn")
			if self.wxpayBtn_ScaleButton_onClick then
				self:wxpayBtn_ScaleButton_onClick(self.selectPayPanel.wxpayBtn)
			end
		end)


end

---@private
function MsgBox:InitGenerate__27(Root, data)
--[[
	BoxBg/TypeContent/SelectPayPanel/wxpayBtn/checkBack
--]]
	local tmp = Root:Find("BoxBg/TypeContent/SelectPayPanel/wxpayBtn/checkBack").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectPayPanel.wxpayBtn.checkBack = tmp


end

---@private
function MsgBox:InitGenerate__28(Root, data)
--[[
	BoxBg/TypeContent/SelectPayPanel/wxpayBtn/checkBack/IsOn
--]]
	local tmp = Root:Find("BoxBg/TypeContent/SelectPayPanel/wxpayBtn/checkBack/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectPayPanel.wxpayBtn.isOn = tmp


end

---@private
function MsgBox:InitGenerate__29(Root, data)
--[[
	BoxBg/TypeContent/AgreementPanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/AgreementPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.agreementPanel = tmp


end

---@private
function MsgBox:InitGenerate__30(Root, data)
--[[
	BoxBg/TypeContent/AgreementPanel/desc2/userpotocol
--]]
	local tmp = Root:Find("BoxBg/TypeContent/AgreementPanel/desc2/userpotocol").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.agreementPanel.userpotocol = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_userpotocol")
			if self.userpotocol_ScaleButton_onClick then
				self:userpotocol_ScaleButton_onClick(self.agreementPanel.userpotocol)
			end
		end)


end

---@private
function MsgBox:InitGenerate__31(Root, data)
--[[
	BoxBg/TypeContent/AgreementPanel/desc2/policy
--]]
	local tmp = Root:Find("BoxBg/TypeContent/AgreementPanel/desc2/policy").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.agreementPanel.policy = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_policy")
			if self.policy_ScaleButton_onClick then
				self:policy_ScaleButton_onClick(self.agreementPanel.policy)
			end
		end)


end

---@private
function MsgBox:InitGenerate__32(Root, data)
--[[
	BoxBg/TypeContent/DispatchPanel
--]]
	local tmp = Root:Find("BoxBg/TypeContent/DispatchPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dispatchPanel = tmp


end

---@private
function MsgBox:InitGenerate__33(Root, data)
--[[
	BoxBg/TypeContent/DispatchPanel/T1
--]]
	local tmp = Root:Find("BoxBg/TypeContent/DispatchPanel/T1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dispatchPanel.t1 = tmp


end

---@private
function MsgBox:InitGenerate__34(Root, data)
--[[
	BoxBg/TypeContent/DispatchPanel/T2
--]]
	local tmp = Root:Find("BoxBg/TypeContent/DispatchPanel/T2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dispatchPanel.t2 = tmp


end

---@private
function MsgBox:InitGenerate__35(Root, data)
--[[
	BoxBg/BtnsGroup/CancelBtn
--]]
	local tmp = Root:Find("BoxBg/BtnsGroup/CancelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_cancelBtn")
			if self.cancelBtn_ScaleButton_onClick then
				self:cancelBtn_ScaleButton_onClick(self.cancelBtn)
			end
		end)


end

---@private
function MsgBox:InitGenerate__36(Root, data)
--[[
	BoxBg/BtnsGroup/CancelBtn/txt
--]]
	local tmp = Root:Find("BoxBg/BtnsGroup/CancelBtn/txt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancelBtn.txt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__37(Root, data)
--[[
	BoxBg/BtnsGroup/ConfirmBtn
--]]
	local tmp = Root:Find("BoxBg/BtnsGroup/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MsgBox_confirmBtn")
			if self.confirmBtn_ScaleButton_onClick then
				self:confirmBtn_ScaleButton_onClick(self.confirmBtn)
			end
		end)


end

---@private
function MsgBox:InitGenerate__38(Root, data)
--[[
	BoxBg/BtnsGroup/ConfirmBtn/txt
--]]
	local tmp = Root:Find("BoxBg/BtnsGroup/ConfirmBtn/txt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn.txt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MsgBox:InitGenerate__39(Root, data)
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
		UIMgr:SendUiUseMessage("MsgBox_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function MsgBox:SetLocalizedText(Root)

    local locObj_MsgBox_Placeholder = Root:Find("BoxBg/TypeContent/ChangeNamePanel/NameField/Placeholder")
    if locObj_MsgBox_Placeholder then
        locObj_MsgBox_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.MsgBox_Placeholder
    end

    local locObj_MsgBox_IllegalText = Root:Find("BoxBg/TypeContent/ChangeNamePanel/IllegalTipsBg/IllegalText")
    if locObj_MsgBox_IllegalText then
        locObj_MsgBox_IllegalText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_IllegalText
    end

    local locObj_MsgBox_Cd_Placeholder = Root:Find("BoxBg/TypeContent/CodePanel/CodeField/Placeholder")
    if locObj_MsgBox_Cd_Placeholder then
        locObj_MsgBox_Cd_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.MsgBox_Cd_Placeholder
    end

    local locObj_MsgBox_Placeholder1 = Root:Find("BoxBg/TypeContent/ChangeSignPanel/SignField/Placeholder_1")
    if locObj_MsgBox_Placeholder1 then
        locObj_MsgBox_Placeholder1.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.MsgBox_Placeholder1
    end

    local locObj_MsgBox_txt = Root:Find("BoxBg/TypeContent/GiftPanel/NoTipsBtn/txt")
    if locObj_MsgBox_txt then
        locObj_MsgBox_txt.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.MsgBox_txt
    end

    local locObj_MsgBox_ay_txt = Root:Find("BoxBg/TypeContent/SelectPayPanel/alipayBtn/txt")
    if locObj_MsgBox_ay_txt then
        locObj_MsgBox_ay_txt.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.MsgBox_ay_txt
    end

    local locObj_MsgBox_wy_txt = Root:Find("BoxBg/TypeContent/SelectPayPanel/wxpayBtn/txt")
    if locObj_MsgBox_wy_txt then
        locObj_MsgBox_wy_txt.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.MsgBox_wy_txt
    end

    local locObj_MsgBox_desc = Root:Find("BoxBg/TypeContent/AgreementPanel/desc")
    if locObj_MsgBox_desc then
        locObj_MsgBox_desc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_desc
    end

    local locObj_MsgBox_agree = Root:Find("BoxBg/TypeContent/AgreementPanel/desc2/agree")
    if locObj_MsgBox_agree then
        locObj_MsgBox_agree.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_agree
    end

    local locObj_MsgBox_userpotocol = Root:Find("BoxBg/TypeContent/AgreementPanel/desc2/userpotocol")
    if locObj_MsgBox_userpotocol then
        locObj_MsgBox_userpotocol.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_userpotocol
    end

    local locObj_MsgBox_and = Root:Find("BoxBg/TypeContent/AgreementPanel/desc2/and")
    if locObj_MsgBox_and then
        locObj_MsgBox_and.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_and
    end

    local locObj_MsgBox_policy = Root:Find("BoxBg/TypeContent/AgreementPanel/desc2/policy")
    if locObj_MsgBox_policy then
        locObj_MsgBox_policy.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_policy
    end

    local locObj_MsgBox_Desc = Root:Find("BoxBg/TypeContent/DispatchPanel/Desc")
    if locObj_MsgBox_Desc then
        locObj_MsgBox_Desc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_Desc
    end

    local locObj_MsgBox_DispatchText1 = Root:Find("BoxBg/TypeContent/DispatchPanel/T1/DispatchText1")
    if locObj_MsgBox_DispatchText1 then
        locObj_MsgBox_DispatchText1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_DispatchText1
    end

    local locObj_MsgBox_DispatchText2 = Root:Find("BoxBg/TypeContent/DispatchPanel/T2/DispatchText2")
    if locObj_MsgBox_DispatchText2 then
        locObj_MsgBox_DispatchText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MsgBox_DispatchText2
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return MsgBox