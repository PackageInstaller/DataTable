---@class ServerListUI_Generate_lastServer
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text
---@field public button UnityEngine.UI.Button

---@class ServerListUI_Generate_servername
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text
---@field public button UnityEngine.UI.Button

---@class ServerListUI_Generate_title
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class ServerListUI_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public panel UnityEngine.GameObject
---@field public title ServerListUI_Generate_title
---@field public serverList UnityEngine.GameObject
---@field public servername ServerListUI_Generate_servername
---@field public lastServer ServerListUI_Generate_lastServer
local ServerListUI = class("ServerListUI", require("WndBase"))

function ServerListUI:ctor(data)
end

---@private
function ServerListUI:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ServerListUI")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ServerListUI:InitGenerate__1(Root, data)
--[[
	clickToClose
--]]
	local tmp = Root:Find("clickToClose").gameObject

	tmp:AddComponentLua("BgClickClose", data)


end

---@private
function ServerListUI:InitGenerate__2(Root, data)
--[[
	Panel
--]]
	local tmp = Root:Find("Panel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.panel = tmp


end

---@private
function ServerListUI:InitGenerate__3(Root, data)
--[[
	Panel/title
--]]
	local tmp = Root:Find("Panel/title").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.title = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function ServerListUI:InitGenerate__4(Root, data)
--[[
	Panel/Scroll View/Viewport/serverList
--]]
	local tmp = Root:Find("Panel/Scroll View/Viewport/serverList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.serverList = tmp


end

---@private
function ServerListUI:InitGenerate__5(Root, data)
--[[
	Panel/Scroll View/Viewport/serverList/servername
--]]
	local tmp = Root:Find("Panel/Scroll View/Viewport/serverList/servername").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.servername = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function ServerListUI:InitGenerate__6(Root, data)
--[[
	Panel/RecentPart/lastServer
--]]
	local tmp = Root:Find("Panel/RecentPart/lastServer").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lastServer = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ServerListUI_lastServer")
			if self.lastServer_Button_onClick then
				self:lastServer_Button_onClick(self.lastServer)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ServerListUI:SetLocalizedText(Root)

    local locObj_ServerListUI_Text = Root:Find("Panel/Zone/Text")
    if locObj_ServerListUI_Text then
        locObj_ServerListUI_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_Text
    end

    local locObj_ServerListUI_Label = Root:Find("Panel/Zone/ZoneList/Label")
    if locObj_ServerListUI_Label then
        locObj_ServerListUI_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_Label
    end

    local locObj_ServerListUI_ItemLabel = Root:Find("Panel/Zone/ZoneList/Template/Viewport/Content/Item/Item Label")
    if locObj_ServerListUI_ItemLabel then
        locObj_ServerListUI_ItemLabel.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_ItemLabel
    end

    local locObj_ServerListUI_OK_Text = Root:Find("Panel/OK/Text")
    if locObj_ServerListUI_OK_Text then
        locObj_ServerListUI_OK_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_OK_Text
    end

    local locObj_ServerListUI_reward1 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (1)")
    if locObj_ServerListUI_reward1 then
        locObj_ServerListUI_reward1.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward1
    end

    local locObj_ServerListUI_reward2 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (2)")
    if locObj_ServerListUI_reward2 then
        locObj_ServerListUI_reward2.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward2
    end

    local locObj_ServerListUI_reward3 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (3)")
    if locObj_ServerListUI_reward3 then
        locObj_ServerListUI_reward3.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward3
    end

    local locObj_ServerListUI_reward4 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (4)")
    if locObj_ServerListUI_reward4 then
        locObj_ServerListUI_reward4.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward4
    end

    local locObj_ServerListUI_reward5 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (5)")
    if locObj_ServerListUI_reward5 then
        locObj_ServerListUI_reward5.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward5
    end

    local locObj_ServerListUI_reward6 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (6)")
    if locObj_ServerListUI_reward6 then
        locObj_ServerListUI_reward6.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward6
    end

    local locObj_ServerListUI_reward7 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (7)")
    if locObj_ServerListUI_reward7 then
        locObj_ServerListUI_reward7.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward7
    end

    local locObj_ServerListUI_reward8 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (8)")
    if locObj_ServerListUI_reward8 then
        locObj_ServerListUI_reward8.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward8
    end

    local locObj_ServerListUI_reward9 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (9)")
    if locObj_ServerListUI_reward9 then
        locObj_ServerListUI_reward9.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward9
    end

    local locObj_ServerListUI_reward10 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (10)")
    if locObj_ServerListUI_reward10 then
        locObj_ServerListUI_reward10.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward10
    end

    local locObj_ServerListUI_reward11 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (11)")
    if locObj_ServerListUI_reward11 then
        locObj_ServerListUI_reward11.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward11
    end

    local locObj_ServerListUI_reward12 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (12)")
    if locObj_ServerListUI_reward12 then
        locObj_ServerListUI_reward12.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward12
    end

    local locObj_ServerListUI_reward13 = Root:Find("Panel/Scroll View/Viewport/serverList/reward (13)")
    if locObj_ServerListUI_reward13 then
        locObj_ServerListUI_reward13.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ServerListUI_reward13
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ServerListUI