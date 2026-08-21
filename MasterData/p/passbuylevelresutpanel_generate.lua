---@class PassBuyLevelResutPanel_Generate_nextLevel
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassBuyLevelResutPanel_Generate_prevLevel
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class PassBuyLevelResutPanel_Generate_closeBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class PassBuyLevelResutPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public closeBg PassBuyLevelResutPanel_Generate_closeBg
---@field public prevLevel PassBuyLevelResutPanel_Generate_prevLevel
---@field public nextLevel PassBuyLevelResutPanel_Generate_nextLevel
local PassBuyLevelResutPanel = class("PassBuyLevelResutPanel", require("WndBase"))

function PassBuyLevelResutPanel:ctor(data)
end

---@private
function PassBuyLevelResutPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("PassBuyLevelResutPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function PassBuyLevelResutPanel:InitGenerate__1(Root, data)
--[[
	closeBg
--]]
	local tmp = Root:Find("closeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("PassBuyLevelResutPanel_closeBg")
			if self.closeBg_Button_onClick then
				self:closeBg_Button_onClick(self.closeBg)
			end
		end)


end

---@private
function PassBuyLevelResutPanel:InitGenerate__2(Root, data)
--[[
	prevLevel
--]]
	local tmp = Root:Find("prevLevel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.prevLevel = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function PassBuyLevelResutPanel:InitGenerate__3(Root, data)
--[[
	nextLevel
--]]
	local tmp = Root:Find("nextLevel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nextLevel = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function PassBuyLevelResutPanel:SetLocalizedText(Root)

    local locObj_PassBuyLevelResutPanel_desc = Root:Find("desc")
    if locObj_PassBuyLevelResutPanel_desc then
        locObj_PassBuyLevelResutPanel_desc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.PassBuyLevelResutPanel_desc
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return PassBuyLevelResutPanel