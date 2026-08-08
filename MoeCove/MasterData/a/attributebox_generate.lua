---@class AttributeBox_Generate_unlockText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AttributeBox_Generate_effect
---@field public gameObject UnityEngine.GameObject
---@field public animation UnityEngine.Animation
---@field public animOverCallBack AnimOverCallBack

---@class AttributeBox_Generate_changeValueTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AttributeBox_Generate_msgNumTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AttributeBox_Generate_attrTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AttributeBox_Generate_attrIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class AttributeBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public showAttr UnityEngine.GameObject
---@field public attrIcon AttributeBox_Generate_attrIcon
---@field public attrTxt AttributeBox_Generate_attrTxt
---@field public msgNumTxt AttributeBox_Generate_msgNumTxt
---@field public icon UnityEngine.GameObject
---@field public upIcon UnityEngine.GameObject
---@field public downIcon UnityEngine.GameObject
---@field public changeIcon UnityEngine.GameObject
---@field public changeValueTxt AttributeBox_Generate_changeValueTxt
---@field public effect AttributeBox_Generate_effect
---@field public lockedAttr UnityEngine.GameObject
---@field public unlockText AttributeBox_Generate_unlockText
local AttributeBox = class("AttributeBox", require("CommonBase"))

function AttributeBox:ctor(data)
end

---@private
function AttributeBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AttributeBox")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function AttributeBox:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function AttributeBox:InitGenerate__2(Root, data)
--[[
	ShowAttr
--]]
	local tmp = Root:Find("ShowAttr").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showAttr = tmp


end

---@private
function AttributeBox:InitGenerate__3(Root, data)
--[[
	ShowAttr/AttrIcon
--]]
	local tmp = Root:Find("ShowAttr/AttrIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function AttributeBox:InitGenerate__4(Root, data)
--[[
	ShowAttr/AttrTxt
--]]
	local tmp = Root:Find("ShowAttr/AttrTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attrTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AttributeBox:InitGenerate__5(Root, data)
--[[
	ShowAttr/ValueList/MsgNumTxt
--]]
	local tmp = Root:Find("ShowAttr/ValueList/MsgNumTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgNumTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AttributeBox:InitGenerate__6(Root, data)
--[[
	ShowAttr/ValueList/icon
--]]
	local tmp = Root:Find("ShowAttr/ValueList/icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.icon = tmp


end

---@private
function AttributeBox:InitGenerate__7(Root, data)
--[[
	ShowAttr/ValueList/icon/UpIcon
--]]
	local tmp = Root:Find("ShowAttr/ValueList/icon/UpIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.upIcon = tmp


end

---@private
function AttributeBox:InitGenerate__8(Root, data)
--[[
	ShowAttr/ValueList/icon/DownIcon
--]]
	local tmp = Root:Find("ShowAttr/ValueList/icon/DownIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.downIcon = tmp


end

---@private
function AttributeBox:InitGenerate__9(Root, data)
--[[
	ShowAttr/ValueList/changeIcon
--]]
	local tmp = Root:Find("ShowAttr/ValueList/changeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeIcon = tmp


end

---@private
function AttributeBox:InitGenerate__10(Root, data)
--[[
	ShowAttr/ValueList/ChangeValueTxt
--]]
	local tmp = Root:Find("ShowAttr/ValueList/ChangeValueTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeValueTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AttributeBox:InitGenerate__11(Root, data)
--[[
	Effect
--]]
	local tmp = Root:Find("Effect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect = tmp

	tmp.animation = tmp:GetComponent(TypeInfo.Animation)

	tmp.animOverCallBack = tmp:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function AttributeBox:InitGenerate__12(Root, data)
--[[
	LockedAttr
--]]
	local tmp = Root:Find("LockedAttr").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lockedAttr = tmp


end

---@private
function AttributeBox:InitGenerate__13(Root, data)
--[[
	LockedAttr/UnlockText
--]]
	local tmp = Root:Find("LockedAttr/UnlockText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.unlockText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function AttributeBox:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return AttributeBox