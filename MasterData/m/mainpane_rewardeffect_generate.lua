---@class MainPane_RewardEffect_Generate_effectParent
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class MainPane_RewardEffect_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public effectParent MainPane_RewardEffect_Generate_effectParent
---@field public effectPrefab UnityEngine.GameObject
local MainPane_RewardEffect = class("MainPane_RewardEffect", require("LuaMonoBehavior"))

function MainPane_RewardEffect:ctor(data)
end

---@private
function MainPane_RewardEffect:InitGenerate(data)

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function MainPane_RewardEffect:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function MainPane_RewardEffect:InitGenerate__2(Root, data)
--[[
	effectParent
--]]
	local tmp = Root:Find("effectParent").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectParent = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function MainPane_RewardEffect:InitGenerate__3(Root, data)
--[[
	effectParent/effectPrefab
--]]
	local tmp = Root:Find("effectParent/effectPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectPrefab = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function MainPane_RewardEffect:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return MainPane_RewardEffect