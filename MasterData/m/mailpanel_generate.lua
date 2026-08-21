---@class MailPanel_Generate_favorToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle
---@field public isOff UnityEngine.GameObject
---@field public isOn UnityEngine.GameObject

---@class MailPanel_Generate_inboxToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle
---@field public isOff UnityEngine.GameObject
---@field public isOn UnityEngine.GameObject

---@class MailPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class MailPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class MailPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class MailPanel_Generate_mailDetail_attachments
---@field public gameObject UnityEngine.GameObject
---@field public attachmentContent UnityEngine.GameObject

---@class MailPanel_Generate_mailDetail_favorBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MailPanel_Generate_mailDetail_cancelFavorBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MailPanel_Generate_mailDetail_isGotBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MailPanel_Generate_mailDetail_claimBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MailPanel_Generate_deteleMailBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MailPanel_Generate_mailDetail_desText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailDetail_sendTimeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailDetail_senderText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailDetail_mailTitleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailDetail
---@field public gameObject UnityEngine.GameObject
---@field public mailTitleText MailPanel_Generate_mailDetail_mailTitleText
---@field public senderText MailPanel_Generate_mailDetail_senderText
---@field public sendTimeText MailPanel_Generate_mailDetail_sendTimeText
---@field public desText MailPanel_Generate_mailDetail_desText
---@field public inboxMailDetail UnityEngine.GameObject
---@field public claimBtn MailPanel_Generate_mailDetail_claimBtn
---@field public isGotBtn MailPanel_Generate_mailDetail_isGotBtn
---@field public favorMailDetail UnityEngine.GameObject
---@field public cancelFavorBtn MailPanel_Generate_mailDetail_cancelFavorBtn
---@field public favorBtn MailPanel_Generate_mailDetail_favorBtn
---@field public isFavor UnityEngine.GameObject
---@field public attachments MailPanel_Generate_mailDetail_attachments

---@class MailPanel_Generate_favorMailPanel
---@field public gameObject UnityEngine.GameObject
---@field public mailContent UnityEngine.GameObject

---@class MailPanel_Generate_markAllAsReadBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MailPanel_Generate_batchClaimBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class MailPanel_Generate_inboxMailPanel
---@field public gameObject UnityEngine.GameObject
---@field public mailContent UnityEngine.GameObject

---@class MailPanel_Generate_topLimitText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailBox_typeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class MailPanel_Generate_mailBox_deadlineText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailBox_senderText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailBox_mailTitleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MailPanel_Generate_mailBox_alphaGroup
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class MailPanel_Generate_mailBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public isOff UnityEngine.GameObject
---@field public isOn UnityEngine.GameObject
---@field public alphaGroup MailPanel_Generate_mailBox_alphaGroup
---@field public mailTitleText MailPanel_Generate_mailBox_mailTitleText
---@field public senderText MailPanel_Generate_mailBox_senderText
---@field public deadlineText MailPanel_Generate_mailBox_deadlineText
---@field public typeIcon MailPanel_Generate_mailBox_typeIcon
---@field public isFavor UnityEngine.GameObject
---@field public redPoint UnityEngine.GameObject

---@class MailPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mailBox MailPanel_Generate_mailBox
---@field public topLimitText MailPanel_Generate_topLimitText
---@field public inboxMailPanel MailPanel_Generate_inboxMailPanel
---@field public batchClaimBtn MailPanel_Generate_batchClaimBtn
---@field public markAllAsReadBtn MailPanel_Generate_markAllAsReadBtn
---@field public favorMailPanel MailPanel_Generate_favorMailPanel
---@field public mailDetail MailPanel_Generate_mailDetail
---@field public deteleMailBtn MailPanel_Generate_deteleMailBtn
---@field public customBox MailPanel_Generate_customBox
---@field public noMails UnityEngine.GameObject
---@field public customBackPanel MailPanel_Generate_customBackPanel
---@field public customMsgPanel MailPanel_Generate_customMsgPanel
---@field public inboxToggle MailPanel_Generate_inboxToggle
---@field public favorToggle MailPanel_Generate_favorToggle
local MailPanel = class("MailPanel", require("WndBase"))

function MailPanel:ctor(data)
end

---@private
function MailPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("MailPanel")

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
	self:InitGenerate__40(Root,data)
	self:InitGenerate__41(Root,data)
	self:InitGenerate__42(Root,data)
	self:InitGenerate__43(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function MailPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function MailPanel:InitGenerate__2(Root, data)
--[[
	BoxBg/MailBox
--]]
	local tmp = Root:Find("BoxBg/MailBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MailPanel_mailBox")
			if self.mailBox_ScaleButton_onClick then
				self:mailBox_ScaleButton_onClick(self.mailBox)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MailPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/MailBox/IsOff
--]]
	local tmp = Root:Find("BoxBg/MailBox/IsOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.isOff = tmp


end

---@private
function MailPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/MailBox/IsOn
--]]
	local tmp = Root:Find("BoxBg/MailBox/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.isOn = tmp


end

---@private
function MailPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/MailBox/AlphaGroup
--]]
	local tmp = Root:Find("BoxBg/MailBox/AlphaGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.alphaGroup = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MailPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/MailBox/AlphaGroup/MailTitleText
--]]
	local tmp = Root:Find("BoxBg/MailBox/AlphaGroup/MailTitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.mailTitleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/MailBox/AlphaGroup/SenderText
--]]
	local tmp = Root:Find("BoxBg/MailBox/AlphaGroup/SenderText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.senderText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/MailBox/AlphaGroup/DeadlineText
--]]
	local tmp = Root:Find("BoxBg/MailBox/AlphaGroup/DeadlineText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.deadlineText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/MailBox/AlphaGroup/TypeIcon
--]]
	local tmp = Root:Find("BoxBg/MailBox/AlphaGroup/TypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.typeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function MailPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/MailBox/IsFavor
--]]
	local tmp = Root:Find("BoxBg/MailBox/IsFavor").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.isFavor = tmp


end

---@private
function MailPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/MailBox/RedPoint
--]]
	local tmp = Root:Find("BoxBg/MailBox/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailBox.redPoint = tmp


end

---@private
function MailPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/topLimitContent/topLimitText
--]]
	local tmp = Root:Find("BoxBg/topLimitContent/topLimitText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.topLimitText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/InboxMailPanel
--]]
	local tmp = Root:Find("BoxBg/InboxMailPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inboxMailPanel = tmp


end

---@private
function MailPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/InboxMailPanel/BatchClaimBtn
--]]
	local tmp = Root:Find("BoxBg/InboxMailPanel/BatchClaimBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.batchClaimBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MailPanel_batchClaimBtn")
			if self.batchClaimBtn_ScaleButton_onClick then
				self:batchClaimBtn_ScaleButton_onClick(self.batchClaimBtn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/InboxMailPanel/MarkAllAsReadBtn
--]]
	local tmp = Root:Find("BoxBg/InboxMailPanel/MarkAllAsReadBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.markAllAsReadBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MailPanel_markAllAsReadBtn")
			if self.markAllAsReadBtn_ScaleButton_onClick then
				self:markAllAsReadBtn_ScaleButton_onClick(self.markAllAsReadBtn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/InboxMailPanel/MailScrollView/Viewport/MailContent
--]]
	local tmp = Root:Find("BoxBg/InboxMailPanel/MailScrollView/Viewport/MailContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inboxMailPanel.mailContent = tmp


end

---@private
function MailPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/FavorMailPanel
--]]
	local tmp = Root:Find("BoxBg/FavorMailPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.favorMailPanel = tmp


end

---@private
function MailPanel:InitGenerate__18(Root, data)
--[[
	BoxBg/FavorMailPanel/MailScrollView/Viewport/MailContent
--]]
	local tmp = Root:Find("BoxBg/FavorMailPanel/MailScrollView/Viewport/MailContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.favorMailPanel.mailContent = tmp


end

---@private
function MailPanel:InitGenerate__19(Root, data)
--[[
	BoxBg/MailDetail
--]]
	local tmp = Root:Find("BoxBg/MailDetail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail = tmp


end

---@private
function MailPanel:InitGenerate__20(Root, data)
--[[
	BoxBg/MailDetail/MailTitleText
--]]
	local tmp = Root:Find("BoxBg/MailDetail/MailTitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.mailTitleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__21(Root, data)
--[[
	BoxBg/MailDetail/SenderTitle/SenderText
--]]
	local tmp = Root:Find("BoxBg/MailDetail/SenderTitle/SenderText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.senderText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__22(Root, data)
--[[
	BoxBg/MailDetail/SendTimeText
--]]
	local tmp = Root:Find("BoxBg/MailDetail/SendTimeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.sendTimeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__23(Root, data)
--[[
	BoxBg/MailDetail/ScrollView/Viewport/ContentText/DesText
--]]
	local tmp = Root:Find("BoxBg/MailDetail/ScrollView/Viewport/ContentText/DesText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.desText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MailPanel:InitGenerate__24(Root, data)
--[[
	BoxBg/MailDetail/InboxMailDetail
--]]
	local tmp = Root:Find("BoxBg/MailDetail/InboxMailDetail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.inboxMailDetail = tmp


end

---@private
function MailPanel:InitGenerate__25(Root, data)
--[[
	BoxBg/MailDetail/InboxMailDetail/DeteleMailBtn
--]]
	local tmp = Root:Find("BoxBg/MailDetail/InboxMailDetail/DeteleMailBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.deteleMailBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MailPanel_deteleMailBtn")
			if self.deteleMailBtn_ScaleButton_onClick then
				self:deteleMailBtn_ScaleButton_onClick(self.deteleMailBtn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__26(Root, data)
--[[
	BoxBg/MailDetail/InboxMailDetail/ClaimBtn
--]]
	local tmp = Root:Find("BoxBg/MailDetail/InboxMailDetail/ClaimBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.claimBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MailPanel_claimBtn")
			if self.claimBtn_ScaleButton_onClick then
				self:claimBtn_ScaleButton_onClick(self.mailDetail.claimBtn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__27(Root, data)
--[[
	BoxBg/MailDetail/InboxMailDetail/IsGotBtn
--]]
	local tmp = Root:Find("BoxBg/MailDetail/InboxMailDetail/IsGotBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.isGotBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function MailPanel:InitGenerate__28(Root, data)
--[[
	BoxBg/MailDetail/FavorMailDetail
--]]
	local tmp = Root:Find("BoxBg/MailDetail/FavorMailDetail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.favorMailDetail = tmp


end

---@private
function MailPanel:InitGenerate__29(Root, data)
--[[
	BoxBg/MailDetail/FavorMailDetail/CancelFavorBtn
--]]
	local tmp = Root:Find("BoxBg/MailDetail/FavorMailDetail/CancelFavorBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.cancelFavorBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MailPanel_cancelFavorBtn")
			if self.cancelFavorBtn_ScaleButton_onClick then
				self:cancelFavorBtn_ScaleButton_onClick(self.mailDetail.cancelFavorBtn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__30(Root, data)
--[[
	BoxBg/MailDetail/FavorBtn
--]]
	local tmp = Root:Find("BoxBg/MailDetail/FavorBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.favorBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("MailPanel_favorBtn")
			if self.favorBtn_ScaleButton_onClick then
				self:favorBtn_ScaleButton_onClick(self.mailDetail.favorBtn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__31(Root, data)
--[[
	BoxBg/MailDetail/IsFavor
--]]
	local tmp = Root:Find("BoxBg/MailDetail/IsFavor").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.isFavor = tmp


end

---@private
function MailPanel:InitGenerate__32(Root, data)
--[[
	BoxBg/MailDetail/Attachments
--]]
	local tmp = Root:Find("BoxBg/MailDetail/Attachments").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.attachments = tmp


end

---@private
function MailPanel:InitGenerate__33(Root, data)
--[[
	BoxBg/MailDetail/Attachments/CustomBox
--]]
	local tmp = Root:Find("BoxBg/MailDetail/Attachments/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function MailPanel:InitGenerate__34(Root, data)
--[[
	BoxBg/MailDetail/Attachments/AttachmentScrollView/Viewport/AttachmentContent
--]]
	local tmp = Root:Find("BoxBg/MailDetail/Attachments/AttachmentScrollView/Viewport/AttachmentContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mailDetail.attachments.attachmentContent = tmp


end

---@private
function MailPanel:InitGenerate__35(Root, data)
--[[
	BoxBg/NoMails
--]]
	local tmp = Root:Find("BoxBg/NoMails").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noMails = tmp


end

---@private
function MailPanel:InitGenerate__36(Root, data)
--[[
	CustomBackPanel
--]]
	local tmp = Root:Find("CustomBackPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBackPanel = tmp

	tmp.customBackPanel = tmp:AddComponentLua("CustomBackPanel", data)


end

---@private
function MailPanel:InitGenerate__37(Root, data)
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
function MailPanel:InitGenerate__38(Root, data)
--[[
	MailToggleGroup/InboxToggle
--]]
	local tmp = Root:Find("MailToggleGroup/InboxToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inboxToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.inboxToggle_Toggle_onValueChanged then
				self:inboxToggle_Toggle_onValueChanged(self.inboxToggle,isOn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__39(Root, data)
--[[
	MailToggleGroup/InboxToggle/IsOff
--]]
	local tmp = Root:Find("MailToggleGroup/InboxToggle/IsOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inboxToggle.isOff = tmp


end

---@private
function MailPanel:InitGenerate__40(Root, data)
--[[
	MailToggleGroup/InboxToggle/IsOn
--]]
	local tmp = Root:Find("MailToggleGroup/InboxToggle/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inboxToggle.isOn = tmp


end

---@private
function MailPanel:InitGenerate__41(Root, data)
--[[
	MailToggleGroup/FavorToggle
--]]
	local tmp = Root:Find("MailToggleGroup/FavorToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.favorToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.favorToggle_Toggle_onValueChanged then
				self:favorToggle_Toggle_onValueChanged(self.favorToggle,isOn)
			end
		end)


end

---@private
function MailPanel:InitGenerate__42(Root, data)
--[[
	MailToggleGroup/FavorToggle/IsOff
--]]
	local tmp = Root:Find("MailToggleGroup/FavorToggle/IsOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.favorToggle.isOff = tmp


end

---@private
function MailPanel:InitGenerate__43(Root, data)
--[[
	MailToggleGroup/FavorToggle/IsOn
--]]
	local tmp = Root:Find("MailToggleGroup/FavorToggle/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.favorToggle.isOn = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function MailPanel:SetLocalizedText(Root)

    local locObj_MailPanel_txt = Root:Find("BoxBg/InboxMailPanel/BatchClaimBtn/txt")
    if locObj_MailPanel_txt then
        locObj_MailPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_txt
    end

    local locObj_MailPanel_Mn_txt = Root:Find("BoxBg/InboxMailPanel/MarkAllAsReadBtn/txt")
    if locObj_MailPanel_Mn_txt then
        locObj_MailPanel_Mn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Mn_txt
    end

    local locObj_MailPanel_SenderTitle = Root:Find("BoxBg/MailDetail/SenderTitle")
    if locObj_MailPanel_SenderTitle then
        locObj_MailPanel_SenderTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_SenderTitle
    end

    local locObj_MailPanel_Dn_txt = Root:Find("BoxBg/MailDetail/InboxMailDetail/DeteleMailBtn/txt")
    if locObj_MailPanel_Dn_txt then
        locObj_MailPanel_Dn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Dn_txt
    end

    local locObj_MailPanel_Cn_txt = Root:Find("BoxBg/MailDetail/InboxMailDetail/ClaimBtn/txt")
    if locObj_MailPanel_Cn_txt then
        locObj_MailPanel_Cn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Cn_txt
    end

    local locObj_MailPanel_Il_In_txt = Root:Find("BoxBg/MailDetail/InboxMailDetail/IsGotBtn/txt")
    if locObj_MailPanel_Il_In_txt then
        locObj_MailPanel_Il_In_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Il_In_txt
    end

    local locObj_MailPanel_Fl_Cn_txt = Root:Find("BoxBg/MailDetail/FavorMailDetail/CancelFavorBtn/txt")
    if locObj_MailPanel_Fl_Cn_txt then
        locObj_MailPanel_Fl_Cn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Fl_Cn_txt
    end

    local locObj_MailPanel_AttachmentsTipText = Root:Find("BoxBg/MailDetail/FavorMailDetail/TipBg/AttachmentsTipText")
    if locObj_MailPanel_AttachmentsTipText then
        locObj_MailPanel_AttachmentsTipText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_AttachmentsTipText
    end

    local locObj_MailPanel_TextTMP = Root:Find("BoxBg/MailDetail/FavorBtn/Text (TMP)")
    if locObj_MailPanel_TextTMP then
        locObj_MailPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_TextTMP
    end

    local locObj_MailPanel_Ir_TextTMP = Root:Find("BoxBg/MailDetail/IsFavor/Text (TMP)")
    if locObj_MailPanel_Ir_TextTMP then
        locObj_MailPanel_Ir_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Ir_TextTMP
    end

    local locObj_MailPanel_Text = Root:Find("BoxBg/MailDetail/Attachments/Text")
    if locObj_MailPanel_Text then
        locObj_MailPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Text
    end

    local locObj_MailPanel_NoMailTips = Root:Find("BoxBg/NoMails/NoMailTips")
    if locObj_MailPanel_NoMailTips then
        locObj_MailPanel_NoMailTips.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_NoMailTips
    end

    local locObj_MailPanel_Ie_TextTMP = Root:Find("MailToggleGroup/InboxToggle/Text (TMP)")
    if locObj_MailPanel_Ie_TextTMP then
        locObj_MailPanel_Ie_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Ie_TextTMP
    end

    local locObj_MailPanel_Fe_TextTMP = Root:Find("MailToggleGroup/FavorToggle/Text (TMP)")
    if locObj_MailPanel_Fe_TextTMP then
        locObj_MailPanel_Fe_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.MailPanel_Fe_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return MailPanel