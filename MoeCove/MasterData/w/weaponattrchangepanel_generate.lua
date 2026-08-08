---@class WeaponAttrChangePanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeaponAttrChangePanel_Generate_skillbox_skillDescText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeaponAttrChangePanel_Generate_skillbox_skillNameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeaponAttrChangePanel_Generate_skillbox
---@field public gameObject UnityEngine.GameObject
---@field public newAttr UnityEngine.GameObject
---@field public skillNameText WeaponAttrChangePanel_Generate_skillbox_skillNameText
---@field public skillDescText WeaponAttrChangePanel_Generate_skillbox_skillDescText

---@class WeaponAttrChangePanel_Generate_attrbox_newValue
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeaponAttrChangePanel_Generate_attrbox_oldValue
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeaponAttrChangePanel_Generate_attrbox_attrTypeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeaponAttrChangePanel_Generate_attrbox_attrIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class WeaponAttrChangePanel_Generate_attrbox
---@field public gameObject UnityEngine.GameObject
---@field public attrIcon WeaponAttrChangePanel_Generate_attrbox_attrIcon
---@field public attrTypeText WeaponAttrChangePanel_Generate_attrbox_attrTypeText
---@field public oldValue WeaponAttrChangePanel_Generate_attrbox_oldValue
---@field public arrowIcon UnityEngine.GameObject
---@field public newValue WeaponAttrChangePanel_Generate_attrbox_newValue
---@field public newAttr UnityEngine.GameObject

---@class WeaponAttrChangePanel_Generate_newLevelText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeaponAttrChangePanel_Generate_oldLevelText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeaponAttrChangePanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class WeaponAttrChangePanel_Generate_lockBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class WeaponAttrChangePanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class WeaponAttrChangePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg WeaponAttrChangePanel_Generate_bg
---@field public lockBtn WeaponAttrChangePanel_Generate_lockBtn
---@field public locked UnityEngine.GameObject
---@field public customBox WeaponAttrChangePanel_Generate_customBox
---@field public oldLevelText WeaponAttrChangePanel_Generate_oldLevelText
---@field public newLevelText WeaponAttrChangePanel_Generate_newLevelText
---@field public attrList UnityEngine.GameObject
---@field public attrbox WeaponAttrChangePanel_Generate_attrbox
---@field public skillbox WeaponAttrChangePanel_Generate_skillbox
---@field public okBtn WeaponAttrChangePanel_Generate_okBtn
local WeaponAttrChangePanel = class("WeaponAttrChangePanel", require("WndBase"))

function WeaponAttrChangePanel:ctor(data)
end

---@private
function WeaponAttrChangePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeaponAttrChangePanel")

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
function WeaponAttrChangePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function WeaponAttrChangePanel:InitGenerate__2(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeaponAttrChangePanel_bg")
			if self.bg_Button_onClick then
				self:bg_Button_onClick(self.bg)
			end
		end)


end

---@private
function WeaponAttrChangePanel:InitGenerate__3(Root, data)
--[[
	ImgBg/Mask/EquipBg/LockBg/LockBtn
--]]
	local tmp = Root:Find("ImgBg/Mask/EquipBg/LockBg/LockBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lockBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeaponAttrChangePanel_lockBtn")
			if self.lockBtn_ScaleButton_onClick then
				self:lockBtn_ScaleButton_onClick(self.lockBtn)
			end
		end)


end

---@private
function WeaponAttrChangePanel:InitGenerate__4(Root, data)
--[[
	ImgBg/Mask/EquipBg/LockBg/LockBtn/Locked
--]]
	local tmp = Root:Find("ImgBg/Mask/EquipBg/LockBg/LockBtn/Locked").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.locked = tmp


end

---@private
function WeaponAttrChangePanel:InitGenerate__5(Root, data)
--[[
	ImgBg/Mask/EquipBg/CustomBox
--]]
	local tmp = Root:Find("ImgBg/Mask/EquipBg/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function WeaponAttrChangePanel:InitGenerate__6(Root, data)
--[[
	ImgBg/Mask/LevelBg/OldLevelText
--]]
	local tmp = Root:Find("ImgBg/Mask/LevelBg/OldLevelText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.oldLevelText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeaponAttrChangePanel:InitGenerate__7(Root, data)
--[[
	ImgBg/Mask/LevelBg/NewLevelText
--]]
	local tmp = Root:Find("ImgBg/Mask/LevelBg/NewLevelText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newLevelText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeaponAttrChangePanel:InitGenerate__8(Root, data)
--[[
	ImgBg/Mask/AttrList
--]]
	local tmp = Root:Find("ImgBg/Mask/AttrList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrList = tmp


end

---@private
function WeaponAttrChangePanel:InitGenerate__9(Root, data)
--[[
	ImgBg/Mask/Attrbox
--]]
	local tmp = Root:Find("ImgBg/Mask/Attrbox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrbox = tmp


end

---@private
function WeaponAttrChangePanel:InitGenerate__10(Root, data)
--[[
	ImgBg/Mask/Attrbox/AttrIcon
--]]
	local tmp = Root:Find("ImgBg/Mask/Attrbox/AttrIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrbox.attrIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function WeaponAttrChangePanel:InitGenerate__11(Root, data)
--[[
	ImgBg/Mask/Attrbox/AttrTypeText
--]]
	local tmp = Root:Find("ImgBg/Mask/Attrbox/AttrTypeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrbox.attrTypeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeaponAttrChangePanel:InitGenerate__12(Root, data)
--[[
	ImgBg/Mask/Attrbox/OldValue
--]]
	local tmp = Root:Find("ImgBg/Mask/Attrbox/OldValue").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrbox.oldValue = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeaponAttrChangePanel:InitGenerate__13(Root, data)
--[[
	ImgBg/Mask/Attrbox/ArrowIcon
--]]
	local tmp = Root:Find("ImgBg/Mask/Attrbox/ArrowIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrbox.arrowIcon = tmp


end

---@private
function WeaponAttrChangePanel:InitGenerate__14(Root, data)
--[[
	ImgBg/Mask/Attrbox/NewValue
--]]
	local tmp = Root:Find("ImgBg/Mask/Attrbox/NewValue").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrbox.newValue = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeaponAttrChangePanel:InitGenerate__15(Root, data)
--[[
	ImgBg/Mask/Attrbox/NewAttr
--]]
	local tmp = Root:Find("ImgBg/Mask/Attrbox/NewAttr").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrbox.newAttr = tmp


end

---@private
function WeaponAttrChangePanel:InitGenerate__16(Root, data)
--[[
	ImgBg/Mask/Skillbox
--]]
	local tmp = Root:Find("ImgBg/Mask/Skillbox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillbox = tmp


end

---@private
function WeaponAttrChangePanel:InitGenerate__17(Root, data)
--[[
	ImgBg/Mask/Skillbox/NewAttr
--]]
	local tmp = Root:Find("ImgBg/Mask/Skillbox/NewAttr").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillbox.newAttr = tmp


end

---@private
function WeaponAttrChangePanel:InitGenerate__18(Root, data)
--[[
	ImgBg/Mask/Skillbox/SkillTitle/SkillNameText
--]]
	local tmp = Root:Find("ImgBg/Mask/Skillbox/SkillTitle/SkillNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillbox.skillNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeaponAttrChangePanel:InitGenerate__19(Root, data)
--[[
	ImgBg/Mask/Skillbox/SkillTitle/SkillDescText
--]]
	local tmp = Root:Find("ImgBg/Mask/Skillbox/SkillTitle/SkillDescText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillbox.skillDescText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeaponAttrChangePanel:InitGenerate__20(Root, data)
--[[
	ImgBg/Mask/OkBtn
--]]
	local tmp = Root:Find("ImgBg/Mask/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("WeaponAttrChangePanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function WeaponAttrChangePanel:SetLocalizedText(Root)

    local locObj_WeaponAttrChangePanel_TextTMP = Root:Find("ImgBg/Mask/OkBtn/Text (TMP)")
    if locObj_WeaponAttrChangePanel_TextTMP then
        locObj_WeaponAttrChangePanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.WeaponAttrChangePanel_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeaponAttrChangePanel