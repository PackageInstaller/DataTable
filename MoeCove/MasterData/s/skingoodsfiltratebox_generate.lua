---@class SkinGoodsFiltrateBox_Generate_resetBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkinGoodsFiltrateBox_Generate_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkinGoodsFiltrateBox_Generate_fitrateContent
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public contentSizeFitter UnityEngine.UI.ContentSizeFitter

---@class SkinGoodsFiltrateBox_Generate_typeListBox_itemList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class SkinGoodsFiltrateBox_Generate_typeListBox_tagName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkinGoodsFiltrateBox_Generate_typeListBox_tagBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SkinGoodsFiltrateBox_Generate_typeListBox
---@field public gameObject UnityEngine.GameObject
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup
---@field public toggleGroup UnityEngine.UI.ToggleGroup
---@field public tagBtn SkinGoodsFiltrateBox_Generate_typeListBox_tagBtn
---@field public tagName SkinGoodsFiltrateBox_Generate_typeListBox_tagName
---@field public offIcon UnityEngine.GameObject
---@field public onIcon UnityEngine.GameObject
---@field public itemList SkinGoodsFiltrateBox_Generate_typeListBox_itemList

---@class SkinGoodsFiltrateBox_Generate_itemObj_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkinGoodsFiltrateBox_Generate_itemObj_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SkinGoodsFiltrateBox_Generate_itemObj
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle
---@field public isSelect UnityEngine.GameObject
---@field public iconImg SkinGoodsFiltrateBox_Generate_itemObj_iconImg
---@field public nameText SkinGoodsFiltrateBox_Generate_itemObj_nameText

---@class SkinGoodsFiltrateBox_Generate_scrollRect
---@field public gameObject UnityEngine.GameObject
---@field public scrollRect UnityEngine.UI.ScrollRect

---@class SkinGoodsFiltrateBox_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkinGoodsFiltrateBox_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SkinGoodsFiltrateBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask SkinGoodsFiltrateBox_Generate_mask
---@field public closeBtn SkinGoodsFiltrateBox_Generate_closeBtn
---@field public scrollRect SkinGoodsFiltrateBox_Generate_scrollRect
---@field public itemObj SkinGoodsFiltrateBox_Generate_itemObj
---@field public typeListBox SkinGoodsFiltrateBox_Generate_typeListBox
---@field public fitrateContent SkinGoodsFiltrateBox_Generate_fitrateContent
---@field public confirmBtn SkinGoodsFiltrateBox_Generate_confirmBtn
---@field public resetBtn SkinGoodsFiltrateBox_Generate_resetBtn
local SkinGoodsFiltrateBox = class("SkinGoodsFiltrateBox", require("WndBase"))

function SkinGoodsFiltrateBox:ctor(data)
end

---@private
function SkinGoodsFiltrateBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SkinGoodsFiltrateBox")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SkinGoodsFiltrateBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("SkinGoodsFiltrateBox_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__3(Root, data)
--[[
	BoxBg/titleInfo/closeBtn
--]]
	local tmp = Root:Find("BoxBg/titleInfo/closeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkinGoodsFiltrateBox_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__4(Root, data)
--[[
	BoxBg/ScrollRect
--]]
	local tmp = Root:Find("BoxBg/ScrollRect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scrollRect = tmp

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__5(Root, data)
--[[
	BoxBg/ScrollRect/itemObj
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/itemObj").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemObj = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__6(Root, data)
--[[
	BoxBg/ScrollRect/itemObj/IsSelect
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/itemObj/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemObj.isSelect = tmp


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__7(Root, data)
--[[
	BoxBg/ScrollRect/itemObj/root/iconImg
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/itemObj/root/iconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemObj.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__8(Root, data)
--[[
	BoxBg/ScrollRect/itemObj/root/nameText
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/itemObj/root/nameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemObj.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__9(Root, data)
--[[
	BoxBg/ScrollRect/typeListBox
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/typeListBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox = tmp

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)

	tmp.toggleGroup = tmp:GetComponent(TypeInfo.ToggleGroup)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__10(Root, data)
--[[
	BoxBg/ScrollRect/typeListBox/tagBtn
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/typeListBox/tagBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.tagBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkinGoodsFiltrateBox_tagBtn")
			if self.tagBtn_Button_onClick then
				self:tagBtn_Button_onClick(self.typeListBox.tagBtn)
			end
		end)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__11(Root, data)
--[[
	BoxBg/ScrollRect/typeListBox/tagBtn/tagName
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/typeListBox/tagBtn/tagName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.tagName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__12(Root, data)
--[[
	BoxBg/ScrollRect/typeListBox/tagBtn/offIcon
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/typeListBox/tagBtn/offIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.offIcon = tmp


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__13(Root, data)
--[[
	BoxBg/ScrollRect/typeListBox/tagBtn/onIcon
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/typeListBox/tagBtn/onIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.onIcon = tmp


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__14(Root, data)
--[[
	BoxBg/ScrollRect/typeListBox/itemList
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/typeListBox/itemList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.itemList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__15(Root, data)
--[[
	BoxBg/ScrollRect/Viewport/fitrateContent
--]]
	local tmp = Root:Find("BoxBg/ScrollRect/Viewport/fitrateContent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.fitrateContent = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.contentSizeFitter = tmp:GetComponent(TypeInfo.ContentSizeFitter)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__16(Root, data)
--[[
	BoxBg/confirmBtn
--]]
	local tmp = Root:Find("BoxBg/confirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkinGoodsFiltrateBox_confirmBtn")
			if self.confirmBtn_ScaleButton_onClick then
				self:confirmBtn_ScaleButton_onClick(self.confirmBtn)
			end
		end)


end

---@private
function SkinGoodsFiltrateBox:InitGenerate__17(Root, data)
--[[
	BoxBg/resetBtn
--]]
	local tmp = Root:Find("BoxBg/resetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkinGoodsFiltrateBox_resetBtn")
			if self.resetBtn_ScaleButton_onClick then
				self:resetBtn_ScaleButton_onClick(self.resetBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SkinGoodsFiltrateBox:SetLocalizedText(Root)

    local locObj_SkinGoodsFiltrateBox_titleNameText = Root:Find("BoxBg/titleInfo/titleNameText")
    if locObj_SkinGoodsFiltrateBox_titleNameText then
        locObj_SkinGoodsFiltrateBox_titleNameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkinGoodsFiltrateBox_titleNameText
    end

    local locObj_SkinGoodsFiltrateBox_txt = Root:Find("BoxBg/confirmBtn/txt")
    if locObj_SkinGoodsFiltrateBox_txt then
        locObj_SkinGoodsFiltrateBox_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkinGoodsFiltrateBox_txt
    end

    local locObj_SkinGoodsFiltrateBox_rn_txt = Root:Find("BoxBg/resetBtn/txt")
    if locObj_SkinGoodsFiltrateBox_rn_txt then
        locObj_SkinGoodsFiltrateBox_rn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkinGoodsFiltrateBox_rn_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SkinGoodsFiltrateBox