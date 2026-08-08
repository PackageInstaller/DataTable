---@class GameShopPanel_CardMenu_Generate_weekCardPicText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_weekCardPicIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GameShopPanel_CardMenu_Generate_weekCardMenu_buyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GameShopPanel_CardMenu_Generate_weekCardMenu_cardActiveRewardText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_weekCardMenu_privilegeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_weekCardMenu_rewardGroup2
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class GameShopPanel_CardMenu_Generate_weekCardMenu_rewardGroup1
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class GameShopPanel_CardMenu_Generate_weekCardMenu_stateText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_weekCardMenu
---@field public gameObject UnityEngine.GameObject
---@field public state_open UnityEngine.GameObject
---@field public stateText GameShopPanel_CardMenu_Generate_weekCardMenu_stateText
---@field public rewardGroup1 GameShopPanel_CardMenu_Generate_weekCardMenu_rewardGroup1
---@field public rewardGroup2 GameShopPanel_CardMenu_Generate_weekCardMenu_rewardGroup2
---@field public privilegeText GameShopPanel_CardMenu_Generate_weekCardMenu_privilegeText
---@field public cardActiveTimeText UnityEngine.GameObject
---@field public cardActiveRewardText GameShopPanel_CardMenu_Generate_weekCardMenu_cardActiveRewardText
---@field public buyBtn GameShopPanel_CardMenu_Generate_weekCardMenu_buyBtn

---@class GameShopPanel_CardMenu_Generate_monthCardMenu_buyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GameShopPanel_CardMenu_Generate_monthCardMenu_cardActiveRewardText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_monthCardMenu_privilegeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_monthCardMenu_rewardGroup2
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class GameShopPanel_CardMenu_Generate_monthCardMenu_rewardGroup1
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class GameShopPanel_CardMenu_Generate_monthCardMenu_stateText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_monthCardMenu
---@field public gameObject UnityEngine.GameObject
---@field public state_open UnityEngine.GameObject
---@field public stateText GameShopPanel_CardMenu_Generate_monthCardMenu_stateText
---@field public rewardGroup1 GameShopPanel_CardMenu_Generate_monthCardMenu_rewardGroup1
---@field public rewardGroup2 GameShopPanel_CardMenu_Generate_monthCardMenu_rewardGroup2
---@field public privilegeText GameShopPanel_CardMenu_Generate_monthCardMenu_privilegeText
---@field public cardActiveTimeText UnityEngine.GameObject
---@field public cardActiveRewardText GameShopPanel_CardMenu_Generate_monthCardMenu_cardActiveRewardText
---@field public buyBtn GameShopPanel_CardMenu_Generate_monthCardMenu_buyBtn

---@class GameShopPanel_CardMenu_Generate_rewardPrefab_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GameShopPanel_CardMenu_Generate_rewardPrefab_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GameShopPanel_CardMenu_Generate_rewardPrefab
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public iconImg GameShopPanel_CardMenu_Generate_rewardPrefab_iconImg
---@field public numText GameShopPanel_CardMenu_Generate_rewardPrefab_numText

---@class GameShopPanel_CardMenu_Generate_weekToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class GameShopPanel_CardMenu_Generate_monthToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class GameShopPanel_CardMenu_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public monthToggle GameShopPanel_CardMenu_Generate_monthToggle
---@field public weekToggle GameShopPanel_CardMenu_Generate_weekToggle
---@field public rewardPrefab GameShopPanel_CardMenu_Generate_rewardPrefab
---@field public monthCardMenu GameShopPanel_CardMenu_Generate_monthCardMenu
---@field public weekCardMenu GameShopPanel_CardMenu_Generate_weekCardMenu
---@field public weekCardPicIcon GameShopPanel_CardMenu_Generate_weekCardPicIcon
---@field public weekCardPicText GameShopPanel_CardMenu_Generate_weekCardPicText
local GameShopPanel_CardMenu = class("GameShopPanel_CardMenu", require("LuaMonoBehavior"))

function GameShopPanel_CardMenu:ctor(data)
end

---@private
function GameShopPanel_CardMenu:InitGenerate(data)

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function GameShopPanel_CardMenu:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function GameShopPanel_CardMenu:InitGenerate__2(Root, data)
--[[
	cardTypeToggleGroup/monthToggle
--]]
	local tmp = Root:Find("cardTypeToggleGroup/monthToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__3(Root, data)
--[[
	cardTypeToggleGroup/weekToggle
--]]
	local tmp = Root:Find("cardTypeToggleGroup/weekToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__4(Root, data)
--[[
	rewardPrefab
--]]
	local tmp = Root:Find("rewardPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardPrefab = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__5(Root, data)
--[[
	rewardPrefab/iconImg
--]]
	local tmp = Root:Find("rewardPrefab/iconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardPrefab.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__6(Root, data)
--[[
	rewardPrefab/numText
--]]
	local tmp = Root:Find("rewardPrefab/numText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardPrefab.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__7(Root, data)
--[[
	monthCardMenu
--]]
	local tmp = Root:Find("monthCardMenu").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu = tmp


end

---@private
function GameShopPanel_CardMenu:InitGenerate__8(Root, data)
--[[
	monthCardMenu/stateInfo/state_open
--]]
	local tmp = Root:Find("monthCardMenu/stateInfo/state_open").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.state_open = tmp


end

---@private
function GameShopPanel_CardMenu:InitGenerate__9(Root, data)
--[[
	monthCardMenu/stateInfo/state_open/stateText
--]]
	local tmp = Root:Find("monthCardMenu/stateInfo/state_open/stateText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.stateText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__10(Root, data)
--[[
	monthCardMenu/rewardGroup1
--]]
	local tmp = Root:Find("monthCardMenu/rewardGroup1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.rewardGroup1 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__11(Root, data)
--[[
	monthCardMenu/rewardGroup2
--]]
	local tmp = Root:Find("monthCardMenu/rewardGroup2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.rewardGroup2 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__12(Root, data)
--[[
	monthCardMenu/privilegeText
--]]
	local tmp = Root:Find("monthCardMenu/privilegeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.privilegeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__13(Root, data)
--[[
	monthCardMenu/cardInfo/cardActiveTimeText
--]]
	local tmp = Root:Find("monthCardMenu/cardInfo/cardActiveTimeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.cardActiveTimeText = tmp


end

---@private
function GameShopPanel_CardMenu:InitGenerate__14(Root, data)
--[[
	monthCardMenu/cardInfo/cardActiveRewardText
--]]
	local tmp = Root:Find("monthCardMenu/cardInfo/cardActiveRewardText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.cardActiveRewardText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__15(Root, data)
--[[
	monthCardMenu/buyBtn
--]]
	local tmp = Root:Find("monthCardMenu/buyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.monthCardMenu.buyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__16(Root, data)
--[[
	weekCardMenu
--]]
	local tmp = Root:Find("weekCardMenu").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu = tmp


end

---@private
function GameShopPanel_CardMenu:InitGenerate__17(Root, data)
--[[
	weekCardMenu/stateInfo/state_open
--]]
	local tmp = Root:Find("weekCardMenu/stateInfo/state_open").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.state_open = tmp


end

---@private
function GameShopPanel_CardMenu:InitGenerate__18(Root, data)
--[[
	weekCardMenu/stateInfo/state_open/stateText
--]]
	local tmp = Root:Find("weekCardMenu/stateInfo/state_open/stateText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.stateText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__19(Root, data)
--[[
	weekCardMenu/rewardGroup1
--]]
	local tmp = Root:Find("weekCardMenu/rewardGroup1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.rewardGroup1 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__20(Root, data)
--[[
	weekCardMenu/rewardGroup2
--]]
	local tmp = Root:Find("weekCardMenu/rewardGroup2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.rewardGroup2 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__21(Root, data)
--[[
	weekCardMenu/privilegeText
--]]
	local tmp = Root:Find("weekCardMenu/privilegeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.privilegeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__22(Root, data)
--[[
	weekCardMenu/cardInfo/cardActiveTimeText
--]]
	local tmp = Root:Find("weekCardMenu/cardInfo/cardActiveTimeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.cardActiveTimeText = tmp


end

---@private
function GameShopPanel_CardMenu:InitGenerate__23(Root, data)
--[[
	weekCardMenu/cardInfo/cardActiveRewardText
--]]
	local tmp = Root:Find("weekCardMenu/cardInfo/cardActiveRewardText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.cardActiveRewardText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__24(Root, data)
--[[
	weekCardMenu/buyBtn
--]]
	local tmp = Root:Find("weekCardMenu/buyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardMenu.buyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__25(Root, data)
--[[
	weekCardMenu/buyBtn/weekCardPicIcon
--]]
	local tmp = Root:Find("weekCardMenu/buyBtn/weekCardPicIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardPicIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GameShopPanel_CardMenu:InitGenerate__26(Root, data)
--[[
	weekCardMenu/buyBtn/weekCardPicText
--]]
	local tmp = Root:Find("weekCardMenu/buyBtn/weekCardPicText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weekCardPicText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function GameShopPanel_CardMenu:SetLocalizedText(Root)

    local locObj_GameShopPanel_TextTMP = Root:Find("cardTypeToggleGroup/monthToggle/Text (TMP)")
    if locObj_GameShopPanel_TextTMP then
        locObj_GameShopPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_TextTMP
    end

    local locObj_GameShopPanel_we_TextTMP = Root:Find("cardTypeToggleGroup/weekToggle/Text (TMP)")
    if locObj_GameShopPanel_we_TextTMP then
        locObj_GameShopPanel_we_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_we_TextTMP
    end

    local locObj_GameShopPanel_cardActiveTimeText = Root:Find("monthCardMenu/cardInfo/cardActiveTimeText")
    if locObj_GameShopPanel_cardActiveTimeText then
        locObj_GameShopPanel_cardActiveTimeText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_cardActiveTimeText
    end

    local locObj_GameShopPanel_bn_TextTMP = Root:Find("monthCardMenu/buyBtn/Text (TMP)")
    if locObj_GameShopPanel_bn_TextTMP then
        locObj_GameShopPanel_bn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_bn_TextTMP
    end

    local locObj_GameShopPanel_co_cardActiveTimeText = Root:Find("weekCardMenu/cardInfo/cardActiveTimeText")
    if locObj_GameShopPanel_co_cardActiveTimeText then
        locObj_GameShopPanel_co_cardActiveTimeText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_co_cardActiveTimeText
    end

    local locObj_GameShopPanel_wu_bn_TextTMP = Root:Find("weekCardMenu/buyBtn/Text (TMP)")
    if locObj_GameShopPanel_wu_bn_TextTMP then
        locObj_GameShopPanel_wu_bn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GameShopPanel_wu_bn_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return GameShopPanel_CardMenu