---@class GameShopPanel_HeroSkinMenu_Generate_skinMaskImg
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class GameShopPanel_HeroSkinMenu_Generate_skinPrefab_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GameShopPanel_HeroSkinMenu_Generate_skinPrefab_content
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public scaleButton ScaleButton

---@class GameShopPanel_HeroSkinMenu_Generate_skinPrefab
---@field public gameObject UnityEngine.GameObject
---@field public content GameShopPanel_HeroSkinMenu_Generate_skinPrefab_content
---@field public selectImage UnityEngine.GameObject
---@field public iconImg GameShopPanel_HeroSkinMenu_Generate_skinPrefab_iconImg
---@field public ownInfo UnityEngine.GameObject
---@field public unopenInfo UnityEngine.GameObject
---@field public tagInfo UnityEngine.GameObject
---@field public discountInfo UnityEngine.GameObject
---@field public timeLimitInfo UnityEngine.GameObject

---@class GameShopPanel_HeroSkinMenu_Generate_skinScrollRect
---@field public gameObject UnityEngine.GameObject
---@field public scrollRect UnityEngine.UI.ScrollRect
---@field public loopListView2 SuperScrollView.LoopListView2

---@class GameShopPanel_HeroSkinMenu_Generate_picText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_HeroSkinMenu_Generate_discountText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_HeroSkinMenu_Generate_picImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GameShopPanel_HeroSkinMenu_Generate_buyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GameShopPanel_HeroSkinMenu_Generate_filterBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GameShopPanel_HeroSkinMenu_Generate_limitTimeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_HeroSkinMenu_Generate_tagPrefab_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_HeroSkinMenu_Generate_tagPrefab
---@field public gameObject UnityEngine.GameObject
---@field public nameText GameShopPanel_HeroSkinMenu_Generate_tagPrefab_nameText

---@class GameShopPanel_HeroSkinMenu_Generate_skinNameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_HeroSkinMenu_Generate_heroNameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_HeroSkinMenu_Generate_infoBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GameShopPanel_HeroSkinMenu_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public spineRoot UnityEngine.GameObject
---@field public infoBtn GameShopPanel_HeroSkinMenu_Generate_infoBtn
---@field public skinInfo UnityEngine.GameObject
---@field public heroNameText GameShopPanel_HeroSkinMenu_Generate_heroNameText
---@field public skinNameText GameShopPanel_HeroSkinMenu_Generate_skinNameText
---@field public tagGroup UnityEngine.GameObject
---@field public tagPrefab GameShopPanel_HeroSkinMenu_Generate_tagPrefab
---@field public limitTimeBg UnityEngine.GameObject
---@field public limitTimeText GameShopPanel_HeroSkinMenu_Generate_limitTimeText
---@field public filterBtn GameShopPanel_HeroSkinMenu_Generate_filterBtn
---@field public buyBtn GameShopPanel_HeroSkinMenu_Generate_buyBtn
---@field public picImg GameShopPanel_HeroSkinMenu_Generate_picImg
---@field public discountText GameShopPanel_HeroSkinMenu_Generate_discountText
---@field public picText GameShopPanel_HeroSkinMenu_Generate_picText
---@field public skinScrollRect GameShopPanel_HeroSkinMenu_Generate_skinScrollRect
---@field public skinPrefab GameShopPanel_HeroSkinMenu_Generate_skinPrefab
---@field public emptyInfo UnityEngine.GameObject
---@field public skinMaskImg GameShopPanel_HeroSkinMenu_Generate_skinMaskImg
local GameShopPanel_HeroSkinMenu = class("GameShopPanel_HeroSkinMenu", require("LuaMonoBehavior"))

function GameShopPanel_HeroSkinMenu:ctor(data)
end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate(data)

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
function GameShopPanel_HeroSkinMenu:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__2(Root, data)
--[[
	spineRoot
--]]
	local tmp = Root:Find("spineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.spineRoot = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__3(Root, data)
--[[
	infoBtn
--]]
	local tmp = Root:Find("infoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.infoBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GameShopPanel_HeroSkinMenu_infoBtn")
			if self.infoBtn_ScaleButton_onClick then
				self:infoBtn_ScaleButton_onClick(self.infoBtn)
			end
		end)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__4(Root, data)
--[[
	skinInfo
--]]
	local tmp = Root:Find("skinInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinInfo = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__5(Root, data)
--[[
	skinInfo/heroNameBg/heroNameText
--]]
	local tmp = Root:Find("skinInfo/heroNameBg/heroNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.heroNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__6(Root, data)
--[[
	skinInfo/skinNameBg/skinNameText
--]]
	local tmp = Root:Find("skinInfo/skinNameBg/skinNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__7(Root, data)
--[[
	skinInfo/tagGroup
--]]
	local tmp = Root:Find("skinInfo/tagGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagGroup = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__8(Root, data)
--[[
	skinInfo/tagGroup/tagPrefab
--]]
	local tmp = Root:Find("skinInfo/tagGroup/tagPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagPrefab = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__9(Root, data)
--[[
	skinInfo/tagGroup/tagPrefab/nameText
--]]
	local tmp = Root:Find("skinInfo/tagGroup/tagPrefab/nameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagPrefab.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__10(Root, data)
--[[
	skinInfo/limitTimeBg
--]]
	local tmp = Root:Find("skinInfo/limitTimeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.limitTimeBg = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__11(Root, data)
--[[
	skinInfo/limitTimeBg/limitTimeText
--]]
	local tmp = Root:Find("skinInfo/limitTimeBg/limitTimeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.limitTimeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__12(Root, data)
--[[
	filterBtn
--]]
	local tmp = Root:Find("filterBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.filterBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GameShopPanel_HeroSkinMenu_filterBtn")
			if self.filterBtn_ScaleButton_onClick then
				self:filterBtn_ScaleButton_onClick(self.filterBtn)
			end
		end)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__13(Root, data)
--[[
	buyBtn
--]]
	local tmp = Root:Find("buyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GameShopPanel_HeroSkinMenu_buyBtn")
			if self.buyBtn_ScaleButton_onClick then
				self:buyBtn_ScaleButton_onClick(self.buyBtn)
			end
		end)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__14(Root, data)
--[[
	buyBtn/layout/picImg
--]]
	local tmp = Root:Find("buyBtn/layout/picImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.picImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__15(Root, data)
--[[
	buyBtn/layout/discountText
--]]
	local tmp = Root:Find("buyBtn/layout/discountText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.discountText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__16(Root, data)
--[[
	buyBtn/layout/picText
--]]
	local tmp = Root:Find("buyBtn/layout/picText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.picText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__17(Root, data)
--[[
	skinScrollRect
--]]
	local tmp = Root:Find("skinScrollRect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinScrollRect = tmp

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)

	tmp.loopListView2 = tmp:GetComponent(TypeInfo.LoopListView2)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__18(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__19(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.content = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__20(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content/selectImage
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/selectImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.selectImage = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__21(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content/iconMask/iconImg
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/iconMask/iconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__22(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content/ownInfo
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/ownInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.ownInfo = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__23(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content/unopenInfo
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/unopenInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.unopenInfo = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__24(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.tagInfo = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__25(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo/discountInfo
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo/discountInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.discountInfo = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__26(Root, data)
--[[
	skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo/timeLimitInfo
--]]
	local tmp = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo/timeLimitInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinPrefab.timeLimitInfo = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__27(Root, data)
--[[
	emptyInfo
--]]
	local tmp = Root:Find("emptyInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.emptyInfo = tmp


end

---@private
function GameShopPanel_HeroSkinMenu:InitGenerate__28(Root, data)
--[[
	skinMaskImg
--]]
	local tmp = Root:Find("skinMaskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinMaskImg = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function GameShopPanel_HeroSkinMenu:SetLocalizedText(Root)

    local locObj_GameShopPanel_in_TextTMP = Root:Find("infoBtn/Text (TMP)")
    if locObj_GameShopPanel_in_TextTMP then
        locObj_GameShopPanel_in_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_in_TextTMP
    end

    local locObj_GameShopPanel_Text1 = Root:Find("filterBtn/Text (1)")
    if locObj_GameShopPanel_Text1 then
        locObj_GameShopPanel_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_Text1
    end

    local locObj_GameShopPanel_oo_Text1 = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/ownInfo/Text (1)")
    if locObj_GameShopPanel_oo_Text1 then
        locObj_GameShopPanel_oo_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_oo_Text1
    end

    local locObj_GameShopPanel_bm_Text1 = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/unopenInfo/bottom/Text (1)")
    if locObj_GameShopPanel_bm_Text1 then
        locObj_GameShopPanel_bm_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_bm_Text1
    end

    local locObj_GameShopPanel_do_Text1 = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo/discountInfo/Text (1)")
    if locObj_GameShopPanel_do_Text1 then
        locObj_GameShopPanel_do_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_do_Text1
    end

    local locObj_GameShopPanel_to_Text1 = Root:Find("skinScrollRect/Viewport/Content/skinPrefab/content/tagInfo/timeLimitInfo/Text (1)")
    if locObj_GameShopPanel_to_Text1 then
        locObj_GameShopPanel_to_Text1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_to_Text1
    end

    local locObj_GameShopPanel_eo_TextTMP = Root:Find("emptyInfo/Text (TMP)")
    if locObj_GameShopPanel_eo_TextTMP then
        locObj_GameShopPanel_eo_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_eo_TextTMP
    end

    local locObj_GameShopPanel_TextTMP1 = Root:Find("emptyInfo/Image (1)/Text (TMP) (1)")
    if locObj_GameShopPanel_TextTMP1 then
        locObj_GameShopPanel_TextTMP1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_TextTMP1
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return GameShopPanel_HeroSkinMenu