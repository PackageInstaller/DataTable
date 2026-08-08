---@class MainPanel_SceneMarkViwe_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public markPrefab UnityEngine.GameObject
local MainPanel_SceneMarkViwe = class("MainPanel_SceneMarkViwe", require("LuaMonoBehavior"))

function MainPanel_SceneMarkViwe:ctor(data)
end

---@private
function MainPanel_SceneMarkViwe:InitGenerate(data)

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function MainPanel_SceneMarkViwe:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function MainPanel_SceneMarkViwe:InitGenerate__2(Root, data)
--[[
	markPrefab
--]]
	local tmp = Root:Find("markPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.markPrefab = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function MainPanel_SceneMarkViwe:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return MainPanel_SceneMarkViwe