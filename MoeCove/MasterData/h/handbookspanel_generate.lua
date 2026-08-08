---@class HandBooksPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class HandBooksPanel_Generate_storyBooksBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isLock UnityEngine.GameObject
---@field public isOpen UnityEngine.GameObject

---@class HandBooksPanel_Generate_equipBooksBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isLock UnityEngine.GameObject
---@field public isOpen UnityEngine.GameObject

---@class HandBooksPanel_Generate_weaponBooksBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isLock UnityEngine.GameObject
---@field public isOpen UnityEngine.GameObject

---@class HandBooksPanel_Generate_heroBooksBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isOpen UnityEngine.GameObject
---@field public isLock UnityEngine.GameObject

---@class HandBooksPanel_Generate_booksList
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class HandBooksPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public booksList HandBooksPanel_Generate_booksList
---@field public heroBooksBox HandBooksPanel_Generate_heroBooksBox
---@field public weaponBooksBox HandBooksPanel_Generate_weaponBooksBox
---@field public equipBooksBox HandBooksPanel_Generate_equipBooksBox
---@field public storyBooksBox HandBooksPanel_Generate_storyBooksBox
---@field public customBackPanel HandBooksPanel_Generate_customBackPanel
local HandBooksPanel = class("HandBooksPanel", require("WndBase"))

function HandBooksPanel:ctor(data)
end

---@private
function HandBooksPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HandBooksPanel")

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
function HandBooksPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function HandBooksPanel:InitGenerate__2(Root, data)
--[[
	bg/BooksList
--]]
	local tmp = Root:Find("bg/BooksList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.booksList = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function HandBooksPanel:InitGenerate__3(Root, data)
--[[
	bg/BooksList/Viewport/Content/HeroBooksBox
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/HeroBooksBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.heroBooksBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HandBooksPanel_heroBooksBox")
			if self.heroBooksBox_ScaleButton_onClick then
				self:heroBooksBox_ScaleButton_onClick(self.heroBooksBox)
			end
		end)


end

---@private
function HandBooksPanel:InitGenerate__4(Root, data)
--[[
	bg/BooksList/Viewport/Content/HeroBooksBox/IsOpen
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/HeroBooksBox/IsOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.heroBooksBox.isOpen = tmp


end

---@private
function HandBooksPanel:InitGenerate__5(Root, data)
--[[
	bg/BooksList/Viewport/Content/HeroBooksBox/IsLock
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/HeroBooksBox/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.heroBooksBox.isLock = tmp


end

---@private
function HandBooksPanel:InitGenerate__6(Root, data)
--[[
	bg/BooksList/Viewport/Content/WeaponBooksBox
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/WeaponBooksBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponBooksBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HandBooksPanel_weaponBooksBox")
			if self.weaponBooksBox_ScaleButton_onClick then
				self:weaponBooksBox_ScaleButton_onClick(self.weaponBooksBox)
			end
		end)


end

---@private
function HandBooksPanel:InitGenerate__7(Root, data)
--[[
	bg/BooksList/Viewport/Content/WeaponBooksBox/IsLock
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/WeaponBooksBox/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponBooksBox.isLock = tmp


end

---@private
function HandBooksPanel:InitGenerate__8(Root, data)
--[[
	bg/BooksList/Viewport/Content/WeaponBooksBox/IsOpen
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/WeaponBooksBox/IsOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponBooksBox.isOpen = tmp


end

---@private
function HandBooksPanel:InitGenerate__9(Root, data)
--[[
	bg/BooksList/Viewport/Content/EquipBooksBox
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/EquipBooksBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.equipBooksBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HandBooksPanel_equipBooksBox")
			if self.equipBooksBox_ScaleButton_onClick then
				self:equipBooksBox_ScaleButton_onClick(self.equipBooksBox)
			end
		end)


end

---@private
function HandBooksPanel:InitGenerate__10(Root, data)
--[[
	bg/BooksList/Viewport/Content/EquipBooksBox/IsLock
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/EquipBooksBox/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.equipBooksBox.isLock = tmp


end

---@private
function HandBooksPanel:InitGenerate__11(Root, data)
--[[
	bg/BooksList/Viewport/Content/EquipBooksBox/IsOpen
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/EquipBooksBox/IsOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.equipBooksBox.isOpen = tmp


end

---@private
function HandBooksPanel:InitGenerate__12(Root, data)
--[[
	bg/BooksList/Viewport/Content/StoryBooksBox
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/StoryBooksBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBooksBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HandBooksPanel_storyBooksBox")
			if self.storyBooksBox_ScaleButton_onClick then
				self:storyBooksBox_ScaleButton_onClick(self.storyBooksBox)
			end
		end)


end

---@private
function HandBooksPanel:InitGenerate__13(Root, data)
--[[
	bg/BooksList/Viewport/Content/StoryBooksBox/IsLock
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/StoryBooksBox/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBooksBox.isLock = tmp


end

---@private
function HandBooksPanel:InitGenerate__14(Root, data)
--[[
	bg/BooksList/Viewport/Content/StoryBooksBox/IsOpen
--]]
	local tmp = Root:Find("bg/BooksList/Viewport/Content/StoryBooksBox/IsOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBooksBox.isOpen = tmp


end

---@private
function HandBooksPanel:InitGenerate__15(Root, data)
--[[
	bg/CustomBackPanel
--]]
	local tmp = Root:Find("bg/CustomBackPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBackPanel = tmp

	tmp.customBackPanel = tmp:AddComponentLua("CustomBackPanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HandBooksPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HandBooksPanel