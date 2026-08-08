---@class ActivateCardPanel_Generate_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivateCardPanel_Generate_nameBgImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivateCardPanel_Generate_cardIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivateCardPanel_Generate_r_lineImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivateCardPanel_Generate_l_lineImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivateCardPanel_Generate_frameImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivateCardPanel_Generate_gyImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivateCardPanel_Generate_cardTextureImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivateCardPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ActivateCardPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public mask ActivateCardPanel_Generate_mask
---@field public cardTextureImg ActivateCardPanel_Generate_cardTextureImg
---@field public gyImg ActivateCardPanel_Generate_gyImg
---@field public frameImg ActivateCardPanel_Generate_frameImg
---@field public l_lineImg ActivateCardPanel_Generate_l_lineImg
---@field public r_lineImg ActivateCardPanel_Generate_r_lineImg
---@field public cardIconImg ActivateCardPanel_Generate_cardIconImg
---@field public nameBgImg ActivateCardPanel_Generate_nameBgImg
---@field public nameText ActivateCardPanel_Generate_nameText
local ActivateCardPanel = class("ActivateCardPanel", require("WndBase"))

function ActivateCardPanel:ctor(data)
end

---@private
function ActivateCardPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivateCardPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivateCardPanel:InitGenerate__1(Root, data)
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
		UIMgr:SendUiUseMessage("ActivateCardPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function ActivateCardPanel:InitGenerate__2(Root, data)
--[[
	cardTextureImg
--]]
	local tmp = Root:Find("cardTextureImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cardTextureImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivateCardPanel:InitGenerate__3(Root, data)
--[[
	cardTextureImg/gyImg
--]]
	local tmp = Root:Find("cardTextureImg/gyImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gyImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivateCardPanel:InitGenerate__4(Root, data)
--[[
	cardTextureImg/frameImg
--]]
	local tmp = Root:Find("cardTextureImg/frameImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.frameImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivateCardPanel:InitGenerate__5(Root, data)
--[[
	l_lineImg
--]]
	local tmp = Root:Find("l_lineImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.l_lineImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivateCardPanel:InitGenerate__6(Root, data)
--[[
	r_lineImg
--]]
	local tmp = Root:Find("r_lineImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.r_lineImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivateCardPanel:InitGenerate__7(Root, data)
--[[
	cardIconImg
--]]
	local tmp = Root:Find("cardIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cardIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivateCardPanel:InitGenerate__8(Root, data)
--[[
	nameBgImg
--]]
	local tmp = Root:Find("nameBgImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameBgImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivateCardPanel:InitGenerate__9(Root, data)
--[[
	nameText
--]]
	local tmp = Root:Find("nameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivateCardPanel:SetLocalizedText(Root)

    local locObj_ActivateCardPanel_nameText = Root:Find("nameText")
    if locObj_ActivateCardPanel_nameText then
        locObj_ActivateCardPanel_nameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivateCardPanel_nameText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivateCardPanel