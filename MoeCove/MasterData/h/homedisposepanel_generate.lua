---@class HomeDisposePanel_Generate_tagDesc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeDisposePanel_Generate_tagTitle
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeDisposePanel_Generate_tagInfo
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public button UnityEngine.UI.Button

---@class HomeDisposePanel_Generate_sureBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomeDisposePanel_Generate_resetBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomeDisposePanel_Generate_roleHeadBox
---@field public gameObject UnityEngine.GameObject
---@field public roleHeadBox RoleHeadBox

---@class HomeDisposePanel_Generate_roleIconList
---@field public gameObject UnityEngine.GameObject
---@field public loopListView2 SuperScrollView.LoopListView2

---@class HomeDisposePanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomeDisposePanel_Generate_disposeRole4
---@field public gameObject UnityEngine.GameObject
---@field public homeDisposeRoleBox HomeDisposeRoleBox

---@class HomeDisposePanel_Generate_disposeRole3
---@field public gameObject UnityEngine.GameObject
---@field public homeDisposeRoleBox HomeDisposeRoleBox

---@class HomeDisposePanel_Generate_disposeRole2
---@field public gameObject UnityEngine.GameObject
---@field public homeDisposeRoleBox HomeDisposeRoleBox

---@class HomeDisposePanel_Generate_disposeRole1
---@field public gameObject UnityEngine.GameObject
---@field public homeDisposeRoleBox HomeDisposeRoleBox

---@class HomeDisposePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class HomeDisposePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask HomeDisposePanel_Generate_mask
---@field public disposeRole1 HomeDisposePanel_Generate_disposeRole1
---@field public disposeRole2 HomeDisposePanel_Generate_disposeRole2
---@field public disposeRole3 HomeDisposePanel_Generate_disposeRole3
---@field public disposeRole4 HomeDisposePanel_Generate_disposeRole4
---@field public closeBtn HomeDisposePanel_Generate_closeBtn
---@field public roleIconList HomeDisposePanel_Generate_roleIconList
---@field public roleHeadBox HomeDisposePanel_Generate_roleHeadBox
---@field public resetBtn HomeDisposePanel_Generate_resetBtn
---@field public sureBtn HomeDisposePanel_Generate_sureBtn
---@field public tagInfo HomeDisposePanel_Generate_tagInfo
---@field public tagTitle HomeDisposePanel_Generate_tagTitle
---@field public tagDesc HomeDisposePanel_Generate_tagDesc
local HomeDisposePanel = class("HomeDisposePanel", require("WndBase"))

function HomeDisposePanel:ctor(data)
end

---@private
function HomeDisposePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HomeDisposePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function HomeDisposePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function HomeDisposePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("HomeDisposePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function HomeDisposePanel:InitGenerate__3(Root, data)
--[[
	RoleList/DisposeRole1
--]]
	local tmp = Root:Find("RoleList/DisposeRole1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disposeRole1 = tmp

	tmp.homeDisposeRoleBox = tmp:AddComponentLua("HomeDisposeRoleBox", data)


end

---@private
function HomeDisposePanel:InitGenerate__4(Root, data)
--[[
	RoleList/DisposeRole2
--]]
	local tmp = Root:Find("RoleList/DisposeRole2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disposeRole2 = tmp

	tmp.homeDisposeRoleBox = tmp:AddComponentLua("HomeDisposeRoleBox", data)


end

---@private
function HomeDisposePanel:InitGenerate__5(Root, data)
--[[
	RoleList/DisposeRole3
--]]
	local tmp = Root:Find("RoleList/DisposeRole3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disposeRole3 = tmp

	tmp.homeDisposeRoleBox = tmp:AddComponentLua("HomeDisposeRoleBox", data)


end

---@private
function HomeDisposePanel:InitGenerate__6(Root, data)
--[[
	RoleList/DisposeRole4
--]]
	local tmp = Root:Find("RoleList/DisposeRole4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disposeRole4 = tmp

	tmp.homeDisposeRoleBox = tmp:AddComponentLua("HomeDisposeRoleBox", data)


end

---@private
function HomeDisposePanel:InitGenerate__7(Root, data)
--[[
	CloseBtn
--]]
	local tmp = Root:Find("CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeDisposePanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function HomeDisposePanel:InitGenerate__8(Root, data)
--[[
	RoleIconList
--]]
	local tmp = Root:Find("RoleIconList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleIconList = tmp

	tmp.loopListView2 = tmp:GetComponent(TypeInfo.LoopListView2)


end

---@private
function HomeDisposePanel:InitGenerate__9(Root, data)
--[[
	RoleIconList/Viewport/Content/RoleHeadBox
--]]
	local tmp = Root:Find("RoleIconList/Viewport/Content/RoleHeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleHeadBox = tmp

	tmp.roleHeadBox = tmp:AddComponentLua("RoleHeadBox", data)


end

---@private
function HomeDisposePanel:InitGenerate__10(Root, data)
--[[
	ResetBtn
--]]
	local tmp = Root:Find("ResetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeDisposePanel_resetBtn")
			if self.resetBtn_ScaleButton_onClick then
				self:resetBtn_ScaleButton_onClick(self.resetBtn)
			end
		end)


end

---@private
function HomeDisposePanel:InitGenerate__11(Root, data)
--[[
	SureBtn
--]]
	local tmp = Root:Find("SureBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sureBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeDisposePanel_sureBtn")
			if self.sureBtn_ScaleButton_onClick then
				self:sureBtn_ScaleButton_onClick(self.sureBtn)
			end
		end)


end

---@private
function HomeDisposePanel:InitGenerate__12(Root, data)
--[[
	TagInfo
--]]
	local tmp = Root:Find("TagInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagInfo = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeDisposePanel_tagInfo")
			if self.tagInfo_Button_onClick then
				self:tagInfo_Button_onClick(self.tagInfo)
			end
		end)


end

---@private
function HomeDisposePanel:InitGenerate__13(Root, data)
--[[
	TagInfo/Bg/TagTitle
--]]
	local tmp = Root:Find("TagInfo/Bg/TagTitle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagTitle = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeDisposePanel:InitGenerate__14(Root, data)
--[[
	TagInfo/Bg/TagDesc
--]]
	local tmp = Root:Find("TagInfo/Bg/TagDesc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagDesc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HomeDisposePanel:SetLocalizedText(Root)

    local locObj_HomeDisposePanel_TextTMP = Root:Find("MainBg/Title/Text (TMP)")
    if locObj_HomeDisposePanel_TextTMP then
        locObj_HomeDisposePanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeDisposePanel_TextTMP
    end

    local locObj_HomeDisposePanel_Rn_TextTMP = Root:Find("ResetBtn/Text (TMP)")
    if locObj_HomeDisposePanel_Rn_TextTMP then
        locObj_HomeDisposePanel_Rn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeDisposePanel_Rn_TextTMP
    end

    local locObj_HomeDisposePanel_Sn_TextTMP = Root:Find("SureBtn/Text (TMP)")
    if locObj_HomeDisposePanel_Sn_TextTMP then
        locObj_HomeDisposePanel_Sn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeDisposePanel_Sn_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HomeDisposePanel