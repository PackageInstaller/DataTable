---@class SceneRoot_Generate_scenePanel
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public dragListener DragListener

---@class SceneRoot_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public scenePanel SceneRoot_Generate_scenePanel
---@field public mapRoot UnityEngine.GameObject
---@field public itemRoot UnityEngine.GameObject
---@field public dreamRoot UnityEngine.GameObject
---@field public animRoot UnityEngine.GameObject
local SceneRoot = class("SceneRoot", require("WndBase"))

function SceneRoot:ctor(data)
end

---@private
function SceneRoot:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SceneRoot")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SceneRoot:InitGenerate__1(Root, data)
--[[
	ScenePanel
--]]
	local tmp = Root:Find("ScenePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scenePanel = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.dragListener = tmp:GetComponent(TypeInfo.DragListener)


end

---@private
function SceneRoot:InitGenerate__2(Root, data)
--[[
	ScenePanel/MapRoot
--]]
	local tmp = Root:Find("ScenePanel/MapRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mapRoot = tmp


end

---@private
function SceneRoot:InitGenerate__3(Root, data)
--[[
	ScenePanel/ItemRoot
--]]
	local tmp = Root:Find("ScenePanel/ItemRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemRoot = tmp


end

---@private
function SceneRoot:InitGenerate__4(Root, data)
--[[
	ScenePanel/DreamRoot
--]]
	local tmp = Root:Find("ScenePanel/DreamRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dreamRoot = tmp


end

---@private
function SceneRoot:InitGenerate__5(Root, data)
--[[
	ScenePanel/AnimRoot
--]]
	local tmp = Root:Find("ScenePanel/AnimRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.animRoot = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SceneRoot:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SceneRoot