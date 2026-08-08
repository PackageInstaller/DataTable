---@class CombatIntelligenctPanel_Generate_userGuidePanel
---@field public gameObject UnityEngine.GameObject
---@field public userGuidePanel UserGuidePanel

---@class CombatIntelligenctPanel_Generate_battleDetails
---@field public gameObject UnityEngine.GameObject
---@field public combatIntelligenctPanel_BattleDetails CombatIntelligenctPanel_BattleDetails

---@class CombatIntelligenctPanel_Generate_infoPrefab_lockText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CombatIntelligenctPanel_Generate_infoPrefab_timeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CombatIntelligenctPanel_Generate_infoPrefab_difficultText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CombatIntelligenctPanel_Generate_infoPrefab_difficultImage
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CombatIntelligenctPanel_Generate_infoPrefab_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CombatIntelligenctPanel_Generate_infoPrefab_iconImage
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CombatIntelligenctPanel_Generate_infoPrefab_bgImage
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CombatIntelligenctPanel_Generate_infoPrefab_content
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CombatIntelligenctPanel_Generate_infoPrefab
---@field public gameObject UnityEngine.GameObject
---@field public content CombatIntelligenctPanel_Generate_infoPrefab_content
---@field public bgImage CombatIntelligenctPanel_Generate_infoPrefab_bgImage
---@field public iconImage CombatIntelligenctPanel_Generate_infoPrefab_iconImage
---@field public nameText CombatIntelligenctPanel_Generate_infoPrefab_nameText
---@field public difficultImage CombatIntelligenctPanel_Generate_infoPrefab_difficultImage
---@field public difficultText CombatIntelligenctPanel_Generate_infoPrefab_difficultText
---@field public timeView UnityEngine.GameObject
---@field public timeText CombatIntelligenctPanel_Generate_infoPrefab_timeText
---@field public lockView UnityEngine.GameObject
---@field public lockText CombatIntelligenctPanel_Generate_infoPrefab_lockText

---@class CombatIntelligenctPanel_Generate_contentScrollRect
---@field public gameObject UnityEngine.GameObject
---@field public scrollRect UnityEngine.UI.ScrollRect
---@field public loopListView2 SuperScrollView.LoopListView2

---@class CombatIntelligenctPanel_Generate_contentView
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CombatIntelligenctPanel_Generate_menuToggleView
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CombatIntelligenctPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class CombatIntelligenctPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public customBackPanel CombatIntelligenctPanel_Generate_customBackPanel
---@field public menuToggleView CombatIntelligenctPanel_Generate_menuToggleView
---@field public contentView CombatIntelligenctPanel_Generate_contentView
---@field public contentScrollRect CombatIntelligenctPanel_Generate_contentScrollRect
---@field public infoPrefab CombatIntelligenctPanel_Generate_infoPrefab
---@field public emptyView UnityEngine.GameObject
---@field public battleDetails CombatIntelligenctPanel_Generate_battleDetails
---@field public userGuidePanel CombatIntelligenctPanel_Generate_userGuidePanel
local CombatIntelligenctPanel = class("CombatIntelligenctPanel", require("WndBase"))

function CombatIntelligenctPanel:ctor(data)
end

---@private
function CombatIntelligenctPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CombatIntelligenctPanel")

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
function CombatIntelligenctPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function CombatIntelligenctPanel:InitGenerate__2(Root, data)
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
function CombatIntelligenctPanel:InitGenerate__3(Root, data)
--[[
	menuToggleView
--]]
	local tmp = Root:Find("menuToggleView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.menuToggleView = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CombatIntelligenctPanel:InitGenerate__4(Root, data)
--[[
	contentView
--]]
	local tmp = Root:Find("contentView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.contentView = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CombatIntelligenctPanel:InitGenerate__5(Root, data)
--[[
	contentView/contentScrollRect
--]]
	local tmp = Root:Find("contentView/contentScrollRect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.contentScrollRect = tmp

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)

	tmp.loopListView2 = tmp:GetComponent(TypeInfo.LoopListView2)


end

---@private
function CombatIntelligenctPanel:InitGenerate__6(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab = tmp


end

---@private
function CombatIntelligenctPanel:InitGenerate__7(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.content = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function CombatIntelligenctPanel:InitGenerate__8(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/bgImage
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/bgImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.bgImage = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CombatIntelligenctPanel:InitGenerate__9(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/iconImage
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/iconImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.iconImage = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CombatIntelligenctPanel:InitGenerate__10(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/nameText
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/nameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CombatIntelligenctPanel:InitGenerate__11(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/difficultImage
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/difficultImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.difficultImage = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CombatIntelligenctPanel:InitGenerate__12(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/difficultImage/difficultText
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/difficultImage/difficultText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.difficultText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CombatIntelligenctPanel:InitGenerate__13(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/timeView
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/timeView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.timeView = tmp


end

---@private
function CombatIntelligenctPanel:InitGenerate__14(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/timeView/timeText
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/timeView/timeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.timeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CombatIntelligenctPanel:InitGenerate__15(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/lockView
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/lockView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.lockView = tmp


end

---@private
function CombatIntelligenctPanel:InitGenerate__16(Root, data)
--[[
	contentView/contentScrollRect/Viewport/Content/infoPrefab/content/lockView/lockText
--]]
	local tmp = Root:Find("contentView/contentScrollRect/Viewport/Content/infoPrefab/content/lockView/lockText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoPrefab.lockText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CombatIntelligenctPanel:InitGenerate__17(Root, data)
--[[
	contentView/emptyView
--]]
	local tmp = Root:Find("contentView/emptyView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.emptyView = tmp


end

---@private
function CombatIntelligenctPanel:InitGenerate__18(Root, data)
--[[
	battleDetails
--]]
	local tmp = Root:Find("battleDetails").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.battleDetails = tmp

	tmp.combatIntelligenctPanel_BattleDetails = tmp:AddComponentLua("CombatIntelligenctPanel_BattleDetails", data)


end

---@private
function CombatIntelligenctPanel:InitGenerate__19(Root, data)
--[[
	UserGuidePanel
--]]
	local tmp = Root:Find("UserGuidePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.userGuidePanel = tmp

	tmp.userGuidePanel = tmp:AddComponentLua("UserGuidePanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function CombatIntelligenctPanel:SetLocalizedText(Root)

    local locObj_CombatIntelligenctPanel_togLable = Root:Find("menuToggleView/togType_1/togLable")
    if locObj_CombatIntelligenctPanel_togLable then
        locObj_CombatIntelligenctPanel_togLable.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CombatIntelligenctPanel_togLable
    end

    local locObj_CombatIntelligenctPanel_t3_togLable = Root:Find("menuToggleView/togType_2/togLable")
    if locObj_CombatIntelligenctPanel_t3_togLable then
        locObj_CombatIntelligenctPanel_t3_togLable.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CombatIntelligenctPanel_t3_togLable
    end

    local locObj_CombatIntelligenctPanel_TextTMP = Root:Find("contentView/emptyView/Text (TMP)")
    if locObj_CombatIntelligenctPanel_TextTMP then
        locObj_CombatIntelligenctPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CombatIntelligenctPanel_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return CombatIntelligenctPanel