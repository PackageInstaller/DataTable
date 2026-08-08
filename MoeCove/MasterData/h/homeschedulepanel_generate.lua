---@class HomeSchedulePanel_Generate_role3_text7
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role3_text6
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role3_text5
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role3_text4
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role3_text3
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role3_text2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role3_text1
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role3_roleIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomeSchedulePanel_Generate_role3
---@field public gameObject UnityEngine.GameObject
---@field public empty UnityEngine.GameObject
---@field public roleIcon HomeSchedulePanel_Generate_role3_roleIcon
---@field public sel UnityEngine.GameObject
---@field public text1 HomeSchedulePanel_Generate_role3_text1
---@field public text2 HomeSchedulePanel_Generate_role3_text2
---@field public text3 HomeSchedulePanel_Generate_role3_text3
---@field public text4 HomeSchedulePanel_Generate_role3_text4
---@field public text5 HomeSchedulePanel_Generate_role3_text5
---@field public text6 HomeSchedulePanel_Generate_role3_text6
---@field public text7 HomeSchedulePanel_Generate_role3_text7

---@class HomeSchedulePanel_Generate_role2_text7
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role2_text6
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role2_text5
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role2_text4
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role2_text3
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role2_text2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role2_text1
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role2_roleIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomeSchedulePanel_Generate_role2
---@field public gameObject UnityEngine.GameObject
---@field public empty UnityEngine.GameObject
---@field public roleIcon HomeSchedulePanel_Generate_role2_roleIcon
---@field public sel UnityEngine.GameObject
---@field public text1 HomeSchedulePanel_Generate_role2_text1
---@field public text2 HomeSchedulePanel_Generate_role2_text2
---@field public text3 HomeSchedulePanel_Generate_role2_text3
---@field public text4 HomeSchedulePanel_Generate_role2_text4
---@field public text5 HomeSchedulePanel_Generate_role2_text5
---@field public text6 HomeSchedulePanel_Generate_role2_text6
---@field public text7 HomeSchedulePanel_Generate_role2_text7

---@class HomeSchedulePanel_Generate_role1_text7
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role1_text6
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role1_text5
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role1_text4
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role1_text3
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role1_text2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role1_text1
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeSchedulePanel_Generate_role1_roleIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomeSchedulePanel_Generate_role1
---@field public gameObject UnityEngine.GameObject
---@field public empty UnityEngine.GameObject
---@field public roleIcon HomeSchedulePanel_Generate_role1_roleIcon
---@field public sel UnityEngine.GameObject
---@field public text1 HomeSchedulePanel_Generate_role1_text1
---@field public text2 HomeSchedulePanel_Generate_role1_text2
---@field public text3 HomeSchedulePanel_Generate_role1_text3
---@field public text4 HomeSchedulePanel_Generate_role1_text4
---@field public text5 HomeSchedulePanel_Generate_role1_text5
---@field public text6 HomeSchedulePanel_Generate_role1_text6
---@field public text7 HomeSchedulePanel_Generate_role1_text7

---@class HomeSchedulePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class HomeSchedulePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask HomeSchedulePanel_Generate_mask
---@field public role1 HomeSchedulePanel_Generate_role1
---@field public role2 HomeSchedulePanel_Generate_role2
---@field public role3 HomeSchedulePanel_Generate_role3
local HomeSchedulePanel = class("HomeSchedulePanel", require("WndBase"))

function HomeSchedulePanel:ctor(data)
end

---@private
function HomeSchedulePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HomeSchedulePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function HomeSchedulePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function HomeSchedulePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("HomeSchedulePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function HomeSchedulePanel:InitGenerate__3(Root, data)
--[[
	BoxBg/Role1
--]]
	local tmp = Root:Find("BoxBg/Role1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1 = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__4(Root, data)
--[[
	BoxBg/Role1/Empty
--]]
	local tmp = Root:Find("BoxBg/Role1/Empty").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.empty = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__5(Root, data)
--[[
	BoxBg/Role1/HeadIconMask/RoleIcon
--]]
	local tmp = Root:Find("BoxBg/Role1/HeadIconMask/RoleIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.roleIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomeSchedulePanel:InitGenerate__6(Root, data)
--[[
	BoxBg/Role1/Sel
--]]
	local tmp = Root:Find("BoxBg/Role1/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.sel = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__7(Root, data)
--[[
	BoxBg/Role1/Text1
--]]
	local tmp = Root:Find("BoxBg/Role1/Text1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.text1 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__8(Root, data)
--[[
	BoxBg/Role1/Text2
--]]
	local tmp = Root:Find("BoxBg/Role1/Text2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.text2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__9(Root, data)
--[[
	BoxBg/Role1/Text3
--]]
	local tmp = Root:Find("BoxBg/Role1/Text3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.text3 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__10(Root, data)
--[[
	BoxBg/Role1/Text4
--]]
	local tmp = Root:Find("BoxBg/Role1/Text4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.text4 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__11(Root, data)
--[[
	BoxBg/Role1/Text5
--]]
	local tmp = Root:Find("BoxBg/Role1/Text5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.text5 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__12(Root, data)
--[[
	BoxBg/Role1/Text6
--]]
	local tmp = Root:Find("BoxBg/Role1/Text6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.text6 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__13(Root, data)
--[[
	BoxBg/Role1/Text7
--]]
	local tmp = Root:Find("BoxBg/Role1/Text7").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.text7 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__14(Root, data)
--[[
	BoxBg/Role2
--]]
	local tmp = Root:Find("BoxBg/Role2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2 = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__15(Root, data)
--[[
	BoxBg/Role2/Empty
--]]
	local tmp = Root:Find("BoxBg/Role2/Empty").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.empty = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__16(Root, data)
--[[
	BoxBg/Role2/HeadIconMask/RoleIcon
--]]
	local tmp = Root:Find("BoxBg/Role2/HeadIconMask/RoleIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.roleIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomeSchedulePanel:InitGenerate__17(Root, data)
--[[
	BoxBg/Role2/Sel
--]]
	local tmp = Root:Find("BoxBg/Role2/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.sel = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__18(Root, data)
--[[
	BoxBg/Role2/Text1
--]]
	local tmp = Root:Find("BoxBg/Role2/Text1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.text1 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__19(Root, data)
--[[
	BoxBg/Role2/Text2
--]]
	local tmp = Root:Find("BoxBg/Role2/Text2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.text2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__20(Root, data)
--[[
	BoxBg/Role2/Text3
--]]
	local tmp = Root:Find("BoxBg/Role2/Text3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.text3 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__21(Root, data)
--[[
	BoxBg/Role2/Text4
--]]
	local tmp = Root:Find("BoxBg/Role2/Text4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.text4 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__22(Root, data)
--[[
	BoxBg/Role2/Text5
--]]
	local tmp = Root:Find("BoxBg/Role2/Text5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.text5 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__23(Root, data)
--[[
	BoxBg/Role2/Text6
--]]
	local tmp = Root:Find("BoxBg/Role2/Text6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.text6 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__24(Root, data)
--[[
	BoxBg/Role2/Text7
--]]
	local tmp = Root:Find("BoxBg/Role2/Text7").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.text7 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__25(Root, data)
--[[
	BoxBg/Role3
--]]
	local tmp = Root:Find("BoxBg/Role3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3 = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__26(Root, data)
--[[
	BoxBg/Role3/Empty
--]]
	local tmp = Root:Find("BoxBg/Role3/Empty").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.empty = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__27(Root, data)
--[[
	BoxBg/Role3/HeadIconMask/RoleIcon
--]]
	local tmp = Root:Find("BoxBg/Role3/HeadIconMask/RoleIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.roleIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomeSchedulePanel:InitGenerate__28(Root, data)
--[[
	BoxBg/Role3/Sel
--]]
	local tmp = Root:Find("BoxBg/Role3/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.sel = tmp


end

---@private
function HomeSchedulePanel:InitGenerate__29(Root, data)
--[[
	BoxBg/Role3/Text1
--]]
	local tmp = Root:Find("BoxBg/Role3/Text1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.text1 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__30(Root, data)
--[[
	BoxBg/Role3/Text2
--]]
	local tmp = Root:Find("BoxBg/Role3/Text2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.text2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__31(Root, data)
--[[
	BoxBg/Role3/Text3
--]]
	local tmp = Root:Find("BoxBg/Role3/Text3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.text3 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__32(Root, data)
--[[
	BoxBg/Role3/Text4
--]]
	local tmp = Root:Find("BoxBg/Role3/Text4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.text4 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__33(Root, data)
--[[
	BoxBg/Role3/Text5
--]]
	local tmp = Root:Find("BoxBg/Role3/Text5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.text5 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__34(Root, data)
--[[
	BoxBg/Role3/Text6
--]]
	local tmp = Root:Find("BoxBg/Role3/Text6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.text6 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeSchedulePanel:InitGenerate__35(Root, data)
--[[
	BoxBg/Role3/Text7
--]]
	local tmp = Root:Find("BoxBg/Role3/Text7").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.text7 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HomeSchedulePanel:SetLocalizedText(Root)

    local locObj_HomeSchedulePanel_TextTMP = Root:Find("BoxBg/Top/Text (TMP)")
    if locObj_HomeSchedulePanel_TextTMP then
        locObj_HomeSchedulePanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP
    end

    local locObj_HomeSchedulePanel_TextTMP1 = Root:Find("BoxBg/Top/Text (TMP) (1)")
    if locObj_HomeSchedulePanel_TextTMP1 then
        locObj_HomeSchedulePanel_TextTMP1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP1
    end

    local locObj_HomeSchedulePanel_TextTMP2 = Root:Find("BoxBg/Top/Text (TMP) (2)")
    if locObj_HomeSchedulePanel_TextTMP2 then
        locObj_HomeSchedulePanel_TextTMP2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP2
    end

    local locObj_HomeSchedulePanel_TextTMP3 = Root:Find("BoxBg/Top/Text (TMP) (3)")
    if locObj_HomeSchedulePanel_TextTMP3 then
        locObj_HomeSchedulePanel_TextTMP3.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP3
    end

    local locObj_HomeSchedulePanel_TextTMP4 = Root:Find("BoxBg/Top/Text (TMP) (4)")
    if locObj_HomeSchedulePanel_TextTMP4 then
        locObj_HomeSchedulePanel_TextTMP4.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP4
    end

    local locObj_HomeSchedulePanel_TextTMP5 = Root:Find("BoxBg/Top/Text (TMP) (5)")
    if locObj_HomeSchedulePanel_TextTMP5 then
        locObj_HomeSchedulePanel_TextTMP5.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP5
    end

    local locObj_HomeSchedulePanel_TextTMP6 = Root:Find("BoxBg/Top/Text (TMP) (6)")
    if locObj_HomeSchedulePanel_TextTMP6 then
        locObj_HomeSchedulePanel_TextTMP6.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP6
    end

    local locObj_HomeSchedulePanel_TextTMP7 = Root:Find("BoxBg/Top/Text (TMP) (7)")
    if locObj_HomeSchedulePanel_TextTMP7 then
        locObj_HomeSchedulePanel_TextTMP7.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_TextTMP7
    end

    local locObj_HomeSchedulePanel_Empty = Root:Find("BoxBg/Role1/Empty")
    if locObj_HomeSchedulePanel_Empty then
        locObj_HomeSchedulePanel_Empty.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_Empty
    end

    local locObj_HomeSchedulePanel_R2_Empty = Root:Find("BoxBg/Role2/Empty")
    if locObj_HomeSchedulePanel_R2_Empty then
        locObj_HomeSchedulePanel_R2_Empty.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_R2_Empty
    end

    local locObj_HomeSchedulePanel_R3_Empty = Root:Find("BoxBg/Role3/Empty")
    if locObj_HomeSchedulePanel_R3_Empty then
        locObj_HomeSchedulePanel_R3_Empty.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeSchedulePanel_R3_Empty
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HomeSchedulePanel