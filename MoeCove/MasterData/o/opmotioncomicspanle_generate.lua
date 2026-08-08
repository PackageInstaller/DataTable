---@class OPMotionComicsPanle_Generate_clickBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class OPMotionComicsPanle_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public clickBtn OPMotionComicsPanle_Generate_clickBtn
local OPMotionComicsPanle = class("OPMotionComicsPanle", require("WndBase"))

function OPMotionComicsPanle:ctor(data)
end

---@private
function OPMotionComicsPanle:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("OPMotionComicsPanle")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function OPMotionComicsPanle:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function OPMotionComicsPanle:InitGenerate__2(Root, data)
--[[
	ClickBtn
--]]
	local tmp = Root:Find("ClickBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.clickBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("OPMotionComicsPanle_clickBtn")
			if self.clickBtn_Button_onClick then
				self:clickBtn_Button_onClick(self.clickBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function OPMotionComicsPanle:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return OPMotionComicsPanle