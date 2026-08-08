---@class BgClickClose_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
local BgClickClose = class("BgClickClose", require("LuaMonoBehavior"))

function BgClickClose:ctor(data)
end

---@private
function BgClickClose:InitGenerate(data)

	local Root = self.transform 
	local tmp


	self:SetLocalizedText(Root)


	self:InitLogic(data)

end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function BgClickClose:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return BgClickClose