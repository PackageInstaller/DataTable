---@class TrialPanel_Generate_btnNode_sel_nameTex
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TrialPanel_Generate_btnNode_sel
---@field public gameObject UnityEngine.GameObject
---@field public nameTex TrialPanel_Generate_btnNode_sel_nameTex

---@class TrialPanel_Generate_btnNode_nameTex
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TrialPanel_Generate_btnNode
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public nameTex TrialPanel_Generate_btnNode_nameTex
---@field public sel TrialPanel_Generate_btnNode_sel

---@class TrialPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class TrialPanel_Generate_reward2
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class TrialPanel_Generate_reward1
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class TrialPanel_Generate_raffleBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class TrialPanel_Generate_box2_btnRoot
---@field public gameObject UnityEngine.GameObject
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup

---@class TrialPanel_Generate_skinUseBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public sel UnityEngine.GameObject

---@class TrialPanel_Generate_box2
---@field public gameObject UnityEngine.GameObject
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup
---@field public btnRoot TrialPanel_Generate_box2_btnRoot

---@class TrialPanel_Generate_box1_btnRoot
---@field public gameObject UnityEngine.GameObject
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup

---@class TrialPanel_Generate_roleUseBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public sel UnityEngine.GameObject

---@class TrialPanel_Generate_box1
---@field public gameObject UnityEngine.GameObject
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup
---@field public btnRoot TrialPanel_Generate_box1_btnRoot

---@class TrialPanel_Generate_content
---@field public gameObject UnityEngine.GameObject
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup

---@class TrialPanel_Generate_trialBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class TrialPanel_Generate_specialInfo_rareIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class TrialPanel_Generate_specialInfo_roleInfoBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class TrialPanel_Generate_specialInfo_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TrialPanel_Generate_specialInfo_nameTypeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TrialPanel_Generate_specialInfo_roleTypeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class TrialPanel_Generate_specialInfo_roleInfoBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class TrialPanel_Generate_specialInfo_showCharacterBreak_spineRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class TrialPanel_Generate_specialInfo_showCharacterBreak_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class TrialPanel_Generate_specialInfo_showCharacterBreak
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg TrialPanel_Generate_specialInfo_showCharacterBreak_skinImg
---@field public spineRoot TrialPanel_Generate_specialInfo_showCharacterBreak_spineRoot

---@class TrialPanel_Generate_specialInfo_showCharacter_spineRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class TrialPanel_Generate_specialInfo_showCharacter_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class TrialPanel_Generate_specialInfo_showCharacter
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg TrialPanel_Generate_specialInfo_showCharacter_skinImg
---@field public spineRoot TrialPanel_Generate_specialInfo_showCharacter_spineRoot

---@class TrialPanel_Generate_specialInfo
---@field public gameObject UnityEngine.GameObject
---@field public showCharacter TrialPanel_Generate_specialInfo_showCharacter
---@field public showCharacterBreak TrialPanel_Generate_specialInfo_showCharacterBreak
---@field public roleInfoBg TrialPanel_Generate_specialInfo_roleInfoBg
---@field public roleTypeIcon TrialPanel_Generate_specialInfo_roleTypeIcon
---@field public nameTypeTxt TrialPanel_Generate_specialInfo_nameTypeTxt
---@field public nameTxt TrialPanel_Generate_specialInfo_nameTxt
---@field public roleInfoBtn TrialPanel_Generate_specialInfo_roleInfoBtn
---@field public rareIcon TrialPanel_Generate_specialInfo_rareIcon

---@class TrialPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public officeBg UnityEngine.GameObject
---@field public specialInfo TrialPanel_Generate_specialInfo
---@field public trialBtn TrialPanel_Generate_trialBtn
---@field public content TrialPanel_Generate_content
---@field public box1 TrialPanel_Generate_box1
---@field public roleUseBtn TrialPanel_Generate_roleUseBtn
---@field public box2 TrialPanel_Generate_box2
---@field public skinUseBtn TrialPanel_Generate_skinUseBtn
---@field public raffleBtn TrialPanel_Generate_raffleBtn
---@field public reward1 TrialPanel_Generate_reward1
---@field public reward2 TrialPanel_Generate_reward2
---@field public customBackPanel TrialPanel_Generate_customBackPanel
---@field public btnNode TrialPanel_Generate_btnNode
local TrialPanel = class("TrialPanel", require("WndBase"))

function TrialPanel:ctor(data)
end

---@private
function TrialPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("TrialPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function TrialPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function TrialPanel:InitGenerate__2(Root, data)
--[[
	OfficeBg
--]]
	local tmp = Root:Find("OfficeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.officeBg = tmp


end

---@private
function TrialPanel:InitGenerate__3(Root, data)
--[[
	SpecialInfo
--]]
	local tmp = Root:Find("SpecialInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo = tmp


end

---@private
function TrialPanel:InitGenerate__4(Root, data)
--[[
	SpecialInfo/ShowCharacter
--]]
	local tmp = Root:Find("SpecialInfo/ShowCharacter").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.showCharacter = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TrialPanel:InitGenerate__5(Root, data)
--[[
	SpecialInfo/ShowCharacter/SkinImg
--]]
	local tmp = Root:Find("SpecialInfo/ShowCharacter/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.showCharacter.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function TrialPanel:InitGenerate__6(Root, data)
--[[
	SpecialInfo/ShowCharacter/SpineRoot
--]]
	local tmp = Root:Find("SpecialInfo/ShowCharacter/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.showCharacter.spineRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function TrialPanel:InitGenerate__7(Root, data)
--[[
	SpecialInfo/ShowCharacterBreak
--]]
	local tmp = Root:Find("SpecialInfo/ShowCharacterBreak").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.showCharacterBreak = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TrialPanel:InitGenerate__8(Root, data)
--[[
	SpecialInfo/ShowCharacterBreak/SkinImg
--]]
	local tmp = Root:Find("SpecialInfo/ShowCharacterBreak/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.showCharacterBreak.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function TrialPanel:InitGenerate__9(Root, data)
--[[
	SpecialInfo/ShowCharacterBreak/SpineRoot
--]]
	local tmp = Root:Find("SpecialInfo/ShowCharacterBreak/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.showCharacterBreak.spineRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function TrialPanel:InitGenerate__10(Root, data)
--[[
	SpecialInfo/RoleInfoBg
--]]
	local tmp = Root:Find("SpecialInfo/RoleInfoBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.roleInfoBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TrialPanel:InitGenerate__11(Root, data)
--[[
	SpecialInfo/RoleInfoBg/RoleTypeIcon
--]]
	local tmp = Root:Find("SpecialInfo/RoleInfoBg/RoleTypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.roleTypeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function TrialPanel:InitGenerate__12(Root, data)
--[[
	SpecialInfo/RoleInfoBg/NameTypeTxt
--]]
	local tmp = Root:Find("SpecialInfo/RoleInfoBg/NameTypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.nameTypeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TrialPanel:InitGenerate__13(Root, data)
--[[
	SpecialInfo/RoleInfoBg/NameTxt
--]]
	local tmp = Root:Find("SpecialInfo/RoleInfoBg/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TrialPanel:InitGenerate__14(Root, data)
--[[
	SpecialInfo/RoleInfoBg/NameTxt/RoleInfoBtn
--]]
	local tmp = Root:Find("SpecialInfo/RoleInfoBg/NameTxt/RoleInfoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.roleInfoBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TrialPanel_roleInfoBtn")
			if self.roleInfoBtn_ScaleButton_onClick then
				self:roleInfoBtn_ScaleButton_onClick(self.specialInfo.roleInfoBtn)
			end
		end)


end

---@private
function TrialPanel:InitGenerate__15(Root, data)
--[[
	SpecialInfo/RoleInfoBg/RareIcon
--]]
	local tmp = Root:Find("SpecialInfo/RoleInfoBg/RareIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.specialInfo.rareIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function TrialPanel:InitGenerate__16(Root, data)
--[[
	AdjustRoot/TrialBtn
--]]
	local tmp = Root:Find("AdjustRoot/TrialBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.trialBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TrialPanel_trialBtn")
			if self.trialBtn_ScaleButton_onClick then
				self:trialBtn_ScaleButton_onClick(self.trialBtn)
			end
		end)


end

---@private
function TrialPanel:InitGenerate__17(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function TrialPanel:InitGenerate__18(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box1 = tmp

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function TrialPanel:InitGenerate__19(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/RoleUseBtn
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/RoleUseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleUseBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TrialPanel_roleUseBtn")
			if self.roleUseBtn_ScaleButton_onClick then
				self:roleUseBtn_ScaleButton_onClick(self.roleUseBtn)
			end
		end)


end

---@private
function TrialPanel:InitGenerate__20(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/RoleUseBtn/Sel
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/RoleUseBtn/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleUseBtn.sel = tmp


end

---@private
function TrialPanel:InitGenerate__21(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/BtnRoot
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/BtnRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box1.btnRoot = tmp

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function TrialPanel:InitGenerate__22(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box2 = tmp

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function TrialPanel:InitGenerate__23(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/SkinUseBtn
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/SkinUseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinUseBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TrialPanel_skinUseBtn")
			if self.skinUseBtn_ScaleButton_onClick then
				self:skinUseBtn_ScaleButton_onClick(self.skinUseBtn)
			end
		end)


end

---@private
function TrialPanel:InitGenerate__24(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/SkinUseBtn/Sel
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/SkinUseBtn/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinUseBtn.sel = tmp


end

---@private
function TrialPanel:InitGenerate__25(Root, data)
--[[
	AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/BtnRoot
--]]
	local tmp = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/BtnRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.box2.btnRoot = tmp

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function TrialPanel:InitGenerate__26(Root, data)
--[[
	AdjustRoot/RaffleBtn
--]]
	local tmp = Root:Find("AdjustRoot/RaffleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.raffleBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TrialPanel_raffleBtn")
			if self.raffleBtn_ScaleButton_onClick then
				self:raffleBtn_ScaleButton_onClick(self.raffleBtn)
			end
		end)


end

---@private
function TrialPanel:InitGenerate__27(Root, data)
--[[
	AdjustRoot/RewardInfo/Root/Reward1
--]]
	local tmp = Root:Find("AdjustRoot/RewardInfo/Root/Reward1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.reward1 = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function TrialPanel:InitGenerate__28(Root, data)
--[[
	AdjustRoot/RewardInfo/Root/Reward2
--]]
	local tmp = Root:Find("AdjustRoot/RewardInfo/Root/Reward2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.reward2 = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function TrialPanel:InitGenerate__29(Root, data)
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
function TrialPanel:InitGenerate__30(Root, data)
--[[
	BtnNode
--]]
	local tmp = Root:Find("BtnNode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btnNode = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TrialPanel_btnNode")
			if self.btnNode_ScaleButton_onClick then
				self:btnNode_ScaleButton_onClick(self.btnNode)
			end
		end)


end

---@private
function TrialPanel:InitGenerate__31(Root, data)
--[[
	BtnNode/NameTex
--]]
	local tmp = Root:Find("BtnNode/NameTex").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btnNode.nameTex = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TrialPanel:InitGenerate__32(Root, data)
--[[
	BtnNode/Sel
--]]
	local tmp = Root:Find("BtnNode/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btnNode.sel = tmp


end

---@private
function TrialPanel:InitGenerate__33(Root, data)
--[[
	BtnNode/Sel/NameTex
--]]
	local tmp = Root:Find("BtnNode/Sel/NameTex").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btnNode.sel.nameTex = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function TrialPanel:SetLocalizedText(Root)

    local locObj_TrialPanel_Text = Root:Find("AdjustRoot/TrialBtn/Text")
    if locObj_TrialPanel_Text then
        locObj_TrialPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TrialPanel_Text
    end

    local locObj_TrialPanel_NameTex = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/RoleUseBtn/NameTex")
    if locObj_TrialPanel_NameTex then
        locObj_TrialPanel_NameTex.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TrialPanel_NameTex
    end

    local locObj_TrialPanel_Sl_NameTex = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/RoleUseBtn/Sel/NameTex")
    if locObj_TrialPanel_Sl_NameTex then
        locObj_TrialPanel_Sl_NameTex.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TrialPanel_Sl_NameTex
    end

    local locObj_TrialPanel_Sn_NameTex = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/SkinUseBtn/NameTex")
    if locObj_TrialPanel_Sn_NameTex then
        locObj_TrialPanel_Sn_NameTex.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TrialPanel_Sn_NameTex
    end

    local locObj_TrialPanel_Sn_Sl_NameTex = Root:Find("AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/SkinUseBtn/Sel/NameTex")
    if locObj_TrialPanel_Sn_Sl_NameTex then
        locObj_TrialPanel_Sn_Sl_NameTex.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TrialPanel_Sn_Sl_NameTex
    end

    local locObj_TrialPanel_Rn_Text = Root:Find("AdjustRoot/RaffleBtn/Text")
    if locObj_TrialPanel_Rn_Text then
        locObj_TrialPanel_Rn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TrialPanel_Rn_Text
    end

    local locObj_TrialPanel_Ro_Text = Root:Find("AdjustRoot/RewardInfo/Text")
    if locObj_TrialPanel_Ro_Text then
        locObj_TrialPanel_Ro_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.TrialPanel_Ro_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return TrialPanel