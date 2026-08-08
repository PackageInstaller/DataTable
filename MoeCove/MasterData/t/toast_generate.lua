---@class Toast_Generate_text
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text UnityEngine.UI.Text

---@class Toast_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public text Toast_Generate_text
local Toast = class("Toast", require("ToastBase"))

function Toast:ctor(data)
end

---@private
function Toast:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("Toast")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function Toast:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function Toast:InitGenerate__2(Root, data)
--[[
	BG/Text
--]]
	local tmp = Root:Find("BG/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.text = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function Toast:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return Toast