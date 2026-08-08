---@class SkillInfoListPanel_Generate_skill4_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill4_skillName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill4
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public skillName SkillInfoListPanel_Generate_skill4_skillName
---@field public desc SkillInfoListPanel_Generate_skill4_desc

---@class SkillInfoListPanel_Generate_skill3_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill3_skillName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill3
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public skillName SkillInfoListPanel_Generate_skill3_skillName
---@field public desc SkillInfoListPanel_Generate_skill3_desc

---@class SkillInfoListPanel_Generate_skill2_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill2_skillName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill2
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public skillName SkillInfoListPanel_Generate_skill2_skillName
---@field public desc SkillInfoListPanel_Generate_skill2_desc

---@class SkillInfoListPanel_Generate_skill1_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill1_skillName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillInfoListPanel_Generate_skill1
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public skillName SkillInfoListPanel_Generate_skill1_skillName
---@field public desc SkillInfoListPanel_Generate_skill1_desc

---@class SkillInfoListPanel_Generate_main
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup

---@class SkillInfoListPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SkillInfoListPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask SkillInfoListPanel_Generate_mask
---@field public main SkillInfoListPanel_Generate_main
---@field public skill1 SkillInfoListPanel_Generate_skill1
---@field public skill2 SkillInfoListPanel_Generate_skill2
---@field public skill3 SkillInfoListPanel_Generate_skill3
---@field public skill4 SkillInfoListPanel_Generate_skill4
local SkillInfoListPanel = class("SkillInfoListPanel", require("WndBase"))

function SkillInfoListPanel:ctor(data)
end

---@private
function SkillInfoListPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SkillInfoListPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SkillInfoListPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SkillInfoListPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("SkillInfoListPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function SkillInfoListPanel:InitGenerate__3(Root, data)
--[[
	Mask/Main
--]]
	local tmp = Root:Find("Mask/Main").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.main = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function SkillInfoListPanel:InitGenerate__4(Root, data)
--[[
	Mask/Main/Skill1
--]]
	local tmp = Root:Find("Mask/Main/Skill1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill1 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkillInfoListPanel:InitGenerate__5(Root, data)
--[[
	Mask/Main/Skill1/SkillName
--]]
	local tmp = Root:Find("Mask/Main/Skill1/SkillName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill1.skillName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillInfoListPanel:InitGenerate__6(Root, data)
--[[
	Mask/Main/Skill1/Desc
--]]
	local tmp = Root:Find("Mask/Main/Skill1/Desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill1.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillInfoListPanel:InitGenerate__7(Root, data)
--[[
	Mask/Main/Skill2
--]]
	local tmp = Root:Find("Mask/Main/Skill2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill2 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkillInfoListPanel:InitGenerate__8(Root, data)
--[[
	Mask/Main/Skill2/SkillName
--]]
	local tmp = Root:Find("Mask/Main/Skill2/SkillName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill2.skillName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillInfoListPanel:InitGenerate__9(Root, data)
--[[
	Mask/Main/Skill2/Desc
--]]
	local tmp = Root:Find("Mask/Main/Skill2/Desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill2.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillInfoListPanel:InitGenerate__10(Root, data)
--[[
	Mask/Main/Skill3
--]]
	local tmp = Root:Find("Mask/Main/Skill3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill3 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkillInfoListPanel:InitGenerate__11(Root, data)
--[[
	Mask/Main/Skill3/SkillName
--]]
	local tmp = Root:Find("Mask/Main/Skill3/SkillName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill3.skillName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillInfoListPanel:InitGenerate__12(Root, data)
--[[
	Mask/Main/Skill3/Desc
--]]
	local tmp = Root:Find("Mask/Main/Skill3/Desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill3.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillInfoListPanel:InitGenerate__13(Root, data)
--[[
	Mask/Main/Skill4
--]]
	local tmp = Root:Find("Mask/Main/Skill4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill4 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkillInfoListPanel:InitGenerate__14(Root, data)
--[[
	Mask/Main/Skill4/SkillName
--]]
	local tmp = Root:Find("Mask/Main/Skill4/SkillName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill4.skillName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillInfoListPanel:InitGenerate__15(Root, data)
--[[
	Mask/Main/Skill4/Desc
--]]
	local tmp = Root:Find("Mask/Main/Skill4/Desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill4.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SkillInfoListPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SkillInfoListPanel