---@class RaffleMsgPanel_Generate_msgViewBox
---@field public gameObject UnityEngine.GameObject
---@field public line UnityEngine.GameObject

---@class RaffleMsgPanel_Generate_gachaMsgBox_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleMsgPanel_Generate_gachaMsgBox_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleMsgPanel_Generate_gachaMsgBox_typeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RaffleMsgPanel_Generate_gachaMsgBox_rankFarmeImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RaffleMsgPanel_Generate_gachaMsgBox_roleIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RaffleMsgPanel_Generate_gachaMsgBox
---@field public gameObject UnityEngine.GameObject
---@field public roleBox UnityEngine.GameObject
---@field public roleIconImg RaffleMsgPanel_Generate_gachaMsgBox_roleIconImg
---@field public rankFarmeImg RaffleMsgPanel_Generate_gachaMsgBox_rankFarmeImg
---@field public typeIcon RaffleMsgPanel_Generate_gachaMsgBox_typeIcon
---@field public nameTxt RaffleMsgPanel_Generate_gachaMsgBox_nameTxt
---@field public msgTxt RaffleMsgPanel_Generate_gachaMsgBox_msgTxt

---@class RaffleMsgPanel_Generate_rankIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RaffleMsgPanel_Generate_rankMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleMsgPanel_Generate_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleMsgPanel_Generate_rulesTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI
---@field public line UnityEngine.GameObject

---@class RaffleMsgPanel_Generate_rulesBox_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleMsgPanel_Generate_rulesBox
---@field public gameObject UnityEngine.GameObject
---@field public titleTxt RaffleMsgPanel_Generate_rulesBox_titleTxt

---@class RaffleMsgPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RaffleMsgPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleMsgPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RaffleMsgPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask RaffleMsgPanel_Generate_mask
---@field public titleText RaffleMsgPanel_Generate_titleText
---@field public closeBtn RaffleMsgPanel_Generate_closeBtn
---@field public listView UnityEngine.GameObject
---@field public teachList UnityEngine.GameObject
---@field public rulesBox RaffleMsgPanel_Generate_rulesBox
---@field public rulesTxt RaffleMsgPanel_Generate_rulesTxt
---@field public msgTxt RaffleMsgPanel_Generate_msgTxt
---@field public rankMsgTxt RaffleMsgPanel_Generate_rankMsgTxt
---@field public rankIconImg RaffleMsgPanel_Generate_rankIconImg
---@field public gachaMsgBox RaffleMsgPanel_Generate_gachaMsgBox
---@field public cube UnityEngine.GameObject
---@field public msgViewBox RaffleMsgPanel_Generate_msgViewBox
local RaffleMsgPanel = class("RaffleMsgPanel", require("WndBase"))

function RaffleMsgPanel:ctor(data)
end

---@private
function RaffleMsgPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RaffleMsgPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function RaffleMsgPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RaffleMsgPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("RaffleMsgPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function RaffleMsgPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleSideBg/Titlebg/TitleText
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleMsgPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/TitleSideBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleMsgPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function RaffleMsgPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/ListView
--]]
	local tmp = Root:Find("BoxBg/ListView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.listView = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/ListView/Scroll View/Viewport/TeachList
--]]
	local tmp = Root:Find("BoxBg/ListView/Scroll View/Viewport/TeachList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachList = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__7(Root, data)
--[[
	Custom/RulesBox
--]]
	local tmp = Root:Find("Custom/RulesBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rulesBox = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__8(Root, data)
--[[
	Custom/RulesBox/TxtTitleBg/TitleTxt
--]]
	local tmp = Root:Find("Custom/RulesBox/TxtTitleBg/TitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rulesBox.titleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleMsgPanel:InitGenerate__9(Root, data)
--[[
	Custom/RulesTxt
--]]
	local tmp = Root:Find("Custom/RulesTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rulesTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleMsgPanel:InitGenerate__10(Root, data)
--[[
	Custom/RulesTxt/Line
--]]
	local tmp = Root:Find("Custom/RulesTxt/Line").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rulesTxt.line = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__11(Root, data)
--[[
	Custom/MsgTxt
--]]
	local tmp = Root:Find("Custom/MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleMsgPanel:InitGenerate__12(Root, data)
--[[
	Custom/RankMsgTxt
--]]
	local tmp = Root:Find("Custom/RankMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleMsgPanel:InitGenerate__13(Root, data)
--[[
	Custom/RankMsgTxt/RankIconImg
--]]
	local tmp = Root:Find("Custom/RankMsgTxt/RankIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RaffleMsgPanel:InitGenerate__14(Root, data)
--[[
	Custom/GachaMsgBox
--]]
	local tmp = Root:Find("Custom/GachaMsgBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__15(Root, data)
--[[
	Custom/GachaMsgBox/RoleBox
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/RoleBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.roleBox = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__16(Root, data)
--[[
	Custom/GachaMsgBox/RoleBox/RoleIconImg
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/RoleBox/RoleIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.roleIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RaffleMsgPanel:InitGenerate__17(Root, data)
--[[
	Custom/GachaMsgBox/RoleBox/RankFarmeImg
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/RoleBox/RankFarmeImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.rankFarmeImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RaffleMsgPanel:InitGenerate__18(Root, data)
--[[
	Custom/GachaMsgBox/RoleBox/TypeIcon
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/RoleBox/TypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.typeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RaffleMsgPanel:InitGenerate__19(Root, data)
--[[
	Custom/GachaMsgBox/NameTxt
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleMsgPanel:InitGenerate__20(Root, data)
--[[
	Custom/GachaMsgBox/MsgTxt
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleMsgPanel:InitGenerate__21(Root, data)
--[[
	Custom/Cube
--]]
	local tmp = Root:Find("Custom/Cube").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cube = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__22(Root, data)
--[[
	Custom/MsgViewBox
--]]
	local tmp = Root:Find("Custom/MsgViewBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgViewBox = tmp


end

---@private
function RaffleMsgPanel:InitGenerate__23(Root, data)
--[[
	Custom/MsgViewBox/Line
--]]
	local tmp = Root:Find("Custom/MsgViewBox/Line").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgViewBox.line = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RaffleMsgPanel:SetLocalizedText(Root)

    local locObj_RaffleMsgPanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_RaffleMsgPanel_TitleText2 then
        locObj_RaffleMsgPanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleMsgPanel_TitleText2
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RaffleMsgPanel