---@class Loader_Generate_image
---@field public gameObject UnityEngine.GameObject
---@field public animator UnityEngine.Animator

---@class Loader_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public image Loader_Generate_image
local Loader = class("Loader", require("LoaderBase"))

function Loader:ctor(data)
end

---@private
function Loader:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("Loader")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function Loader:InitGenerate__1(Root, data)
--[[
	Image
--]]
	local tmp = Root:Find("Image").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.image = tmp

	tmp.animator = tmp:GetComponent(TypeInfo.Animator)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function Loader:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return Loader