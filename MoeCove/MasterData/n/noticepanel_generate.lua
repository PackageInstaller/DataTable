---@class NoticePanel_Generate_webArea
---@field public gameObject UnityEngine.GameObject
---@field public uniWebView UniWebView

---@class NoticePanel_Generate_noticeBox_noticeTitleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NoticePanel_Generate_noticeBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isSelect UnityEngine.GameObject
---@field public noticeTitleTxt NoticePanel_Generate_noticeBox_noticeTitleTxt
---@field public red UnityEngine.GameObject

---@class NoticePanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class NoticePanel_Generate_activityTitleIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NoticePanel_Generate_activityTitleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NoticePanel_Generate_activityBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public isSelect UnityEngine.GameObject
---@field public red UnityEngine.GameObject

---@class NoticePanel_Generate_systemTitleIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NoticePanel_Generate_systemTitleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NoticePanel_Generate_systemBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public isSelect UnityEngine.GameObject
---@field public red UnityEngine.GameObject

---@class NoticePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class NoticePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask NoticePanel_Generate_mask
---@field public systemBtn NoticePanel_Generate_systemBtn
---@field public systemTitleTxt NoticePanel_Generate_systemTitleTxt
---@field public systemTitleIcon NoticePanel_Generate_systemTitleIcon
---@field public activityBtn NoticePanel_Generate_activityBtn
---@field public activityTitleTxt NoticePanel_Generate_activityTitleTxt
---@field public activityTitleIcon NoticePanel_Generate_activityTitleIcon
---@field public closeBtn NoticePanel_Generate_closeBtn
---@field public noticeBoxList UnityEngine.GameObject
---@field public noticeBox NoticePanel_Generate_noticeBox
---@field public webArea NoticePanel_Generate_webArea
local NoticePanel = class("NoticePanel", require("WndBase"))

function NoticePanel:ctor(data)
end

---@private
function NoticePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("NoticePanel")

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
function NoticePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function NoticePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("NoticePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function NoticePanel:InitGenerate__3(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.systemBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("NoticePanel_systemBtn")
			if self.systemBtn_Button_onClick then
				self:systemBtn_Button_onClick(self.systemBtn)
			end
		end)


end

---@private
function NoticePanel:InitGenerate__4(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/IsSelect
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.systemBtn.isSelect = tmp


end

---@private
function NoticePanel:InitGenerate__5(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/SystemTitleTxt
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/SystemTitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.systemTitleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NoticePanel:InitGenerate__6(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/Red
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/Red").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.systemBtn.red = tmp


end

---@private
function NoticePanel:InitGenerate__7(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/SystemTitleIcon
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/SystemBtn/SystemTitleIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.systemTitleIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NoticePanel:InitGenerate__8(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("NoticePanel_activityBtn")
			if self.activityBtn_Button_onClick then
				self:activityBtn_Button_onClick(self.activityBtn)
			end
		end)


end

---@private
function NoticePanel:InitGenerate__9(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/IsSelect
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityBtn.isSelect = tmp


end

---@private
function NoticePanel:InitGenerate__10(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/ActivityTitleTxt
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/ActivityTitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityTitleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NoticePanel:InitGenerate__11(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/Red
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/Red").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityBtn.red = tmp


end

---@private
function NoticePanel:InitGenerate__12(Root, data)
--[[
	BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/ActivityTitleIcon
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/ToggleBg/ToggleBtnGroup/ActivityBtn/ActivityTitleIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityTitleIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NoticePanel:InitGenerate__13(Root, data)
--[[
	BoxBg/NoticeBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/NoticeBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("NoticePanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function NoticePanel:InitGenerate__14(Root, data)
--[[
	BoxBg/ScrollView/Viewport/NoticeBoxList
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/NoticeBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noticeBoxList = tmp


end

---@private
function NoticePanel:InitGenerate__15(Root, data)
--[[
	BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noticeBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function NoticePanel:InitGenerate__16(Root, data)
--[[
	BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox/IsSelect
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noticeBox.isSelect = tmp


end

---@private
function NoticePanel:InitGenerate__17(Root, data)
--[[
	BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox/NoticeTitleTxt
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox/NoticeTitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noticeBox.noticeTitleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NoticePanel:InitGenerate__18(Root, data)
--[[
	BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox/Red
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/NoticeBoxList/NoticeBox/Red").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noticeBox.red = tmp


end

---@private
function NoticePanel:InitGenerate__19(Root, data)
--[[
	BoxBg/ContentBg/WebArea
--]]
	local tmp = Root:Find("BoxBg/ContentBg/WebArea").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.webArea = tmp

	tmp.uniWebView = tmp:GetComponent(TypeInfo.UniWebView)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function NoticePanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return NoticePanel