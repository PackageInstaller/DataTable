---@class GmPanel_Generate_homelandStoryTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GmPanel_Generate_homelandStoryBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GmPanel_Generate_enterLevelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GmPanel_Generate_hStoryIDField
---@field public gameObject UnityEngine.GameObject
---@field public tMP_InputField TMPro.TMP_InputField

---@class GmPanel_Generate_levelField
---@field public gameObject UnityEngine.GameObject
---@field public tMP_InputField TMPro.TMP_InputField

---@class GmPanel_Generate_inputField
---@field public gameObject UnityEngine.GameObject
---@field public tMP_InputField TMPro.TMP_InputField

---@class GmPanel_Generate_btStart
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GmPanel_Generate_gMDetailItem_gmTex
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GmPanel_Generate_gMDetailItem
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public gmTex GmPanel_Generate_gMDetailItem_gmTex

---@class GmPanel_Generate_gMBox_mailTitleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GmPanel_Generate_gMBox_alphaGroup
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class GmPanel_Generate_gMBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isOff UnityEngine.GameObject
---@field public isOn UnityEngine.GameObject
---@field public alphaGroup GmPanel_Generate_gMBox_alphaGroup
---@field public mailTitleText GmPanel_Generate_gMBox_mailTitleText

---@class GmPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class GmPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mailDetail UnityEngine.GameObject
---@field public customBackPanel GmPanel_Generate_customBackPanel
---@field public typeList UnityEngine.GameObject
---@field public gMBox GmPanel_Generate_gMBox
---@field public strList UnityEngine.GameObject
---@field public gMDetailItem GmPanel_Generate_gMDetailItem
---@field public btStart GmPanel_Generate_btStart
---@field public inputField GmPanel_Generate_inputField
---@field public levelField GmPanel_Generate_levelField
---@field public hStoryIDField GmPanel_Generate_hStoryIDField
---@field public enterLevelBtn GmPanel_Generate_enterLevelBtn
---@field public homelandStoryBtn GmPanel_Generate_homelandStoryBtn
---@field public homelandStoryTxt GmPanel_Generate_homelandStoryTxt
local GmPanel = class("GmPanel", require("WndBase"))

function GmPanel:ctor(data)
end

---@private
function GmPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("GmPanel")

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
function GmPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function GmPanel:InitGenerate__2(Root, data)
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
function GmPanel:InitGenerate__3(Root, data)
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
function GmPanel:InitGenerate__4(Root, data)
--[[
	List/Viewport/TypeList
--]]
	local tmp = Root:Find("List/Viewport/TypeList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeList = tmp


end

---@private
function GmPanel:InitGenerate__5(Root, data)
--[[
	List/Viewport/TypeList/GMBox
--]]
	local tmp = Root:Find("List/Viewport/TypeList/GMBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function GmPanel:InitGenerate__6(Root, data)
--[[
	List/Viewport/TypeList/GMBox/IsOff
--]]
	local tmp = Root:Find("List/Viewport/TypeList/GMBox/IsOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMBox.isOff = tmp


end

---@private
function GmPanel:InitGenerate__7(Root, data)
--[[
	List/Viewport/TypeList/GMBox/IsOn
--]]
	local tmp = Root:Find("List/Viewport/TypeList/GMBox/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMBox.isOn = tmp


end

---@private
function GmPanel:InitGenerate__8(Root, data)
--[[
	List/Viewport/TypeList/GMBox/AlphaGroup
--]]
	local tmp = Root:Find("List/Viewport/TypeList/GMBox/AlphaGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMBox.alphaGroup = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function GmPanel:InitGenerate__9(Root, data)
--[[
	List/Viewport/TypeList/GMBox/AlphaGroup/MailTitleText
--]]
	local tmp = Root:Find("List/Viewport/TypeList/GMBox/AlphaGroup/MailTitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMBox.mailTitleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GmPanel:InitGenerate__10(Root, data)
--[[
	List2/Viewport/StrList
--]]
	local tmp = Root:Find("List2/Viewport/StrList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.strList = tmp


end

---@private
function GmPanel:InitGenerate__11(Root, data)
--[[
	List2/Viewport/StrList/GMDetailItem
--]]
	local tmp = Root:Find("List2/Viewport/StrList/GMDetailItem").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMDetailItem = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function GmPanel:InitGenerate__12(Root, data)
--[[
	List2/Viewport/StrList/GMDetailItem/GmTex
--]]
	local tmp = Root:Find("List2/Viewport/StrList/GMDetailItem/GmTex").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMDetailItem.gmTex = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GmPanel:InitGenerate__13(Root, data)
--[[
	BtStart
--]]
	local tmp = Root:Find("BtStart").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btStart = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GmPanel_btStart")
			if self.btStart_ScaleButton_onClick then
				self:btStart_ScaleButton_onClick(self.btStart)
			end
		end)


end

---@private
function GmPanel:InitGenerate__14(Root, data)
--[[
	InputField
--]]
	local tmp = Root:Find("InputField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inputField = tmp

	tmp.tMP_InputField = tmp:GetComponent(TypeInfo.TMP_InputField)


end

---@private
function GmPanel:InitGenerate__15(Root, data)
--[[
	LevelField
--]]
	local tmp = Root:Find("LevelField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelField = tmp

	tmp.tMP_InputField = tmp:GetComponent(TypeInfo.TMP_InputField)


end

---@private
function GmPanel:InitGenerate__16(Root, data)
--[[
	HStoryIDField
--]]
	local tmp = Root:Find("HStoryIDField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.hStoryIDField = tmp

	tmp.tMP_InputField = tmp:GetComponent(TypeInfo.TMP_InputField)


end

---@private
function GmPanel:InitGenerate__17(Root, data)
--[[
	EnterLevelBtn
--]]
	local tmp = Root:Find("EnterLevelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enterLevelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GmPanel_enterLevelBtn")
			if self.enterLevelBtn_ScaleButton_onClick then
				self:enterLevelBtn_ScaleButton_onClick(self.enterLevelBtn)
			end
		end)


end

---@private
function GmPanel:InitGenerate__18(Root, data)
--[[
	HomelandStoryBtn
--]]
	local tmp = Root:Find("HomelandStoryBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.homelandStoryBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GmPanel_homelandStoryBtn")
			if self.homelandStoryBtn_ScaleButton_onClick then
				self:homelandStoryBtn_ScaleButton_onClick(self.homelandStoryBtn)
			end
		end)


end

---@private
function GmPanel:InitGenerate__19(Root, data)
--[[
	HomelandStoryBtn/HomelandStoryTxt
--]]
	local tmp = Root:Find("HomelandStoryBtn/HomelandStoryTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.homelandStoryTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function GmPanel:SetLocalizedText(Root)

    local locObj_GmPanel_Text = Root:Find("InputField/Text Area/Text")
    if locObj_GmPanel_Text then
        locObj_GmPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GmPanel_Text
    end

    local locObj_GmPanel_Text = Root:Find("LevelField/Text Area/Text")
    if locObj_GmPanel_Text then
        locObj_GmPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GmPanel_Text
    end

    local locObj_GmPanel_Text = Root:Find("HStoryIDField/Text Area/Text")
    if locObj_GmPanel_Text then
        locObj_GmPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GmPanel_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return GmPanel