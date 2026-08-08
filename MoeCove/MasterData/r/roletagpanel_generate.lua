---@class RoleTagPanel_Generate_tagBox_tagTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleTagPanel_Generate_tagBox_tagSTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleTagPanel_Generate_tagBox_tagBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleTagPanel_Generate_tagBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isNull UnityEngine.GameObject
---@field public tagBg RoleTagPanel_Generate_tagBox_tagBg
---@field public tagSTxt RoleTagPanel_Generate_tagBox_tagSTxt
---@field public tagTxt RoleTagPanel_Generate_tagBox_tagTxt
---@field public isSelect UnityEngine.GameObject

---@class RoleTagPanel_Generate_roleBox_typeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleTagPanel_Generate_roleBox_rankFarmeImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleTagPanel_Generate_roleBox_roleIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleTagPanel_Generate_roleBox_roleName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleTagPanel_Generate_roleBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public isNull UnityEngine.GameObject
---@field public roleMsg UnityEngine.GameObject
---@field public roleName RoleTagPanel_Generate_roleBox_roleName
---@field public roleIconImg RoleTagPanel_Generate_roleBox_roleIconImg
---@field public rankFarmeImg RoleTagPanel_Generate_roleBox_rankFarmeImg
---@field public typeIcon RoleTagPanel_Generate_roleBox_typeIcon

---@class RoleTagPanel_Generate_nextBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RoleTagPanel_Generate_lastBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RoleTagPanel_Generate_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleTagPanel_Generate_tagNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleTagPanel_Generate_influenceIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleTagPanel_Generate_influenceIconShadow
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleTagPanel_Generate_influenceTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleTagPanel_Generate_influenceNameBg
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RoleTagPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RoleTagPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask RoleTagPanel_Generate_mask
---@field public influenceNameBg RoleTagPanel_Generate_influenceNameBg
---@field public influenceTxt RoleTagPanel_Generate_influenceTxt
---@field public influenceIsSelect UnityEngine.GameObject
---@field public influenceIconShadow RoleTagPanel_Generate_influenceIconShadow
---@field public influenceIcon RoleTagPanel_Generate_influenceIcon
---@field public peculiarityContent UnityEngine.GameObject
---@field public dwellingContent UnityEngine.GameObject
---@field public tagNameTxt RoleTagPanel_Generate_tagNameTxt
---@field public msgTxt RoleTagPanel_Generate_msgTxt
---@field public sameRolePanel UnityEngine.GameObject
---@field public sameRoleContent UnityEngine.GameObject
---@field public lastBtn RoleTagPanel_Generate_lastBtn
---@field public nextBtn RoleTagPanel_Generate_nextBtn
---@field public roleBox RoleTagPanel_Generate_roleBox
---@field public tagBox RoleTagPanel_Generate_tagBox
local RoleTagPanel = class("RoleTagPanel", require("WndBase"))

function RoleTagPanel:ctor(data)
end

---@private
function RoleTagPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RoleTagPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function RoleTagPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RoleTagPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("RoleTagPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function RoleTagPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/InfluenceBg/InfluenceNameBg
--]]
	local tmp = Root:Find("BoxBg/InfluenceBg/InfluenceNameBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.influenceNameBg = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleTagPanel_influenceNameBg")
			if self.influenceNameBg_ScaleButton_onClick then
				self:influenceNameBg_ScaleButton_onClick(self.influenceNameBg)
			end
		end)


end

---@private
function RoleTagPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/InfluenceBg/InfluenceNameBg/InfluenceTxt
--]]
	local tmp = Root:Find("BoxBg/InfluenceBg/InfluenceNameBg/InfluenceTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.influenceTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleTagPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/InfluenceBg/InfluenceNameBg/InfluenceIsSelect
--]]
	local tmp = Root:Find("BoxBg/InfluenceBg/InfluenceNameBg/InfluenceIsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.influenceIsSelect = tmp


end

---@private
function RoleTagPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/InfluenceBg/InfluenceIconShadow
--]]
	local tmp = Root:Find("BoxBg/InfluenceBg/InfluenceIconShadow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.influenceIconShadow = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleTagPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/InfluenceBg/InfluenceIcon
--]]
	local tmp = Root:Find("BoxBg/InfluenceBg/InfluenceIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.influenceIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleTagPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/TagBg/PeculiarityList/Scroll View/Viewport/PeculiarityContent
--]]
	local tmp = Root:Find("BoxBg/TagBg/PeculiarityList/Scroll View/Viewport/PeculiarityContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.peculiarityContent = tmp


end

---@private
function RoleTagPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/TagBg/DwellingList/Scroll View/Viewport/DwellingContent
--]]
	local tmp = Root:Find("BoxBg/TagBg/DwellingList/Scroll View/Viewport/DwellingContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dwellingContent = tmp


end

---@private
function RoleTagPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/TagBg/MsgBg/TagNameTxt
--]]
	local tmp = Root:Find("BoxBg/TagBg/MsgBg/TagNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleTagPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/TagBg/MsgBg/Scroll View/Viewport/MsgTxt
--]]
	local tmp = Root:Find("BoxBg/TagBg/MsgBg/Scroll View/Viewport/MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleTagPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/SameRolePanel
--]]
	local tmp = Root:Find("BoxBg/SameRolePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sameRolePanel = tmp


end

---@private
function RoleTagPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/SameRolePanel/Scroll View/Viewport/SameRoleContent
--]]
	local tmp = Root:Find("BoxBg/SameRolePanel/Scroll View/Viewport/SameRoleContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sameRoleContent = tmp


end

---@private
function RoleTagPanel:InitGenerate__14(Root, data)
--[[
	LastBtn
--]]
	local tmp = Root:Find("LastBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lastBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleTagPanel_lastBtn")
			if self.lastBtn_ScaleButton_onClick then
				self:lastBtn_ScaleButton_onClick(self.lastBtn)
			end
		end)


end

---@private
function RoleTagPanel:InitGenerate__15(Root, data)
--[[
	NextBtn
--]]
	local tmp = Root:Find("NextBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nextBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleTagPanel_nextBtn")
			if self.nextBtn_ScaleButton_onClick then
				self:nextBtn_ScaleButton_onClick(self.nextBtn)
			end
		end)


end

---@private
function RoleTagPanel:InitGenerate__16(Root, data)
--[[
	RoleBox
--]]
	local tmp = Root:Find("RoleBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function RoleTagPanel:InitGenerate__17(Root, data)
--[[
	RoleBox/IsNull
--]]
	local tmp = Root:Find("RoleBox/IsNull").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.isNull = tmp


end

---@private
function RoleTagPanel:InitGenerate__18(Root, data)
--[[
	RoleBox/RoleMsg
--]]
	local tmp = Root:Find("RoleBox/RoleMsg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.roleMsg = tmp


end

---@private
function RoleTagPanel:InitGenerate__19(Root, data)
--[[
	RoleBox/RoleMsg/RoleName
--]]
	local tmp = Root:Find("RoleBox/RoleMsg/RoleName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.roleName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleTagPanel:InitGenerate__20(Root, data)
--[[
	RoleBox/RoleMsg/RoleIconImg
--]]
	local tmp = Root:Find("RoleBox/RoleMsg/RoleIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.roleIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleTagPanel:InitGenerate__21(Root, data)
--[[
	RoleBox/RoleMsg/RankFarmeImg
--]]
	local tmp = Root:Find("RoleBox/RoleMsg/RankFarmeImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.rankFarmeImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleTagPanel:InitGenerate__22(Root, data)
--[[
	RoleBox/RoleMsg/TypeIcon
--]]
	local tmp = Root:Find("RoleBox/RoleMsg/TypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.typeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleTagPanel:InitGenerate__23(Root, data)
--[[
	TagBox
--]]
	local tmp = Root:Find("TagBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleTagPanel_tagBox")
			if self.tagBox_ScaleButton_onClick then
				self:tagBox_ScaleButton_onClick(self.tagBox)
			end
		end)


end

---@private
function RoleTagPanel:InitGenerate__24(Root, data)
--[[
	TagBox/IsNull
--]]
	local tmp = Root:Find("TagBox/IsNull").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox.isNull = tmp


end

---@private
function RoleTagPanel:InitGenerate__25(Root, data)
--[[
	TagBox/TagBg
--]]
	local tmp = Root:Find("TagBox/TagBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox.tagBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleTagPanel:InitGenerate__26(Root, data)
--[[
	TagBox/TagBg/TagSTxt
--]]
	local tmp = Root:Find("TagBox/TagBg/TagSTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox.tagSTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleTagPanel:InitGenerate__27(Root, data)
--[[
	TagBox/TagBg/TagTxt
--]]
	local tmp = Root:Find("TagBox/TagBg/TagTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox.tagTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleTagPanel:InitGenerate__28(Root, data)
--[[
	TagBox/IsSelect
--]]
	local tmp = Root:Find("TagBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox.isSelect = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RoleTagPanel:SetLocalizedText(Root)

    local locObj_RoleTagPanel_TitleEngTxt = Root:Find("BoxBg/TagBg/ModeTitle/TitleEngTxt")
    if locObj_RoleTagPanel_TitleEngTxt then
        locObj_RoleTagPanel_TitleEngTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_TitleEngTxt
    end

    local locObj_RoleTagPanel_TitleTxt = Root:Find("BoxBg/TagBg/ModeTitle/TitleTxt")
    if locObj_RoleTagPanel_TitleTxt then
        locObj_RoleTagPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_TitleTxt
    end

    local locObj_RoleTagPanel_De_TitleEngTxt = Root:Find("BoxBg/TagBg/DwellingTitle/TitleEngTxt")
    if locObj_RoleTagPanel_De_TitleEngTxt then
        locObj_RoleTagPanel_De_TitleEngTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_De_TitleEngTxt
    end

    local locObj_RoleTagPanel_De_TitleTxt = Root:Find("BoxBg/TagBg/DwellingTitle/TitleTxt")
    if locObj_RoleTagPanel_De_TitleTxt then
        locObj_RoleTagPanel_De_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_De_TitleTxt
    end

    local locObj_RoleTagPanel_txt = Root:Find("BoxBg/TagBg/MsgBg/msgBg/txt")
    if locObj_RoleTagPanel_txt then
        locObj_RoleTagPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_txt
    end

    local locObj_RoleTagPanel_TextTMP = Root:Find("BoxBg/SameRolePanel/bg/Text (TMP)")
    if locObj_RoleTagPanel_TextTMP then
        locObj_RoleTagPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_TextTMP
    end

    local locObj_RoleTagPanel_Ln_TextTMP = Root:Find("LastBtn/Text (TMP)")
    if locObj_RoleTagPanel_Ln_TextTMP then
        locObj_RoleTagPanel_Ln_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_Ln_TextTMP
    end

    local locObj_RoleTagPanel_Nn_TextTMP = Root:Find("NextBtn/Text (TMP)")
    if locObj_RoleTagPanel_Nn_TextTMP then
        locObj_RoleTagPanel_Nn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleTagPanel_Nn_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RoleTagPanel