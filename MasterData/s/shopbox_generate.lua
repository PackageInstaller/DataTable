---@class ShopBox_Generate_buyBtn_txt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShopBox_Generate_buyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public txt ShopBox_Generate_buyBtn_txt

---@class ShopBox_Generate_priceTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShopBox_Generate_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ShopBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public double UnityEngine.GameObject
---@field public icon ShopBox_Generate_icon
---@field public priceTxt ShopBox_Generate_priceTxt
---@field public buyBtn ShopBox_Generate_buyBtn
local ShopBox = class("ShopBox", require("CommonBase"))

function ShopBox:ctor(data)
end

---@private
function ShopBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ShopBox")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ShopBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function ShopBox:InitGenerate__2(Root, data)
--[[
	bg/double
--]]
	local tmp = Root:Find("bg/double").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.double = tmp


end

---@private
function ShopBox:InitGenerate__3(Root, data)
--[[
	bg/icon
--]]
	local tmp = Root:Find("bg/icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ShopBox:InitGenerate__4(Root, data)
--[[
	bg/bg/priceTxt
--]]
	local tmp = Root:Find("bg/bg/priceTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.priceTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShopBox:InitGenerate__5(Root, data)
--[[
	bg/BuyBtn
--]]
	local tmp = Root:Find("bg/BuyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ShopBox_buyBtn")
			if self.buyBtn_ScaleButton_onClick then
				self:buyBtn_ScaleButton_onClick(self.buyBtn)
			end
		end)


end

---@private
function ShopBox:InitGenerate__6(Root, data)
--[[
	bg/BuyBtn/txt
--]]
	local tmp = Root:Find("bg/BuyBtn/txt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buyBtn.txt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ShopBox:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ShopBox