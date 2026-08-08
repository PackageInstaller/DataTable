---@class ImgToast__Generate_image
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class ImgToast__Generate_frame
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class ImgToast__Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public frame ImgToast__Generate_frame
---@field public image ImgToast__Generate_image
local ImgToast = class("ImgToast", require("ToastBase"))

function ImgToast:ctor(data)
end

---@private
function ImgToast:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ImgToast")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)

	self:InitLogic(data)

end

---@private
function ImgToast:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function ImgToast:InitGenerate__2(Root, data)
--[[
	BG/frame
--]]
	local tmp = Root:Find("BG/frame").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.frame = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ImgToast:InitGenerate__3(Root, data)
--[[
	BG/Image
--]]
	local tmp = Root:Find("BG/Image").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.image = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

return ImgToast