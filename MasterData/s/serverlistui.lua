---@class ServerListUI : ServerListUI_Generate
---##################### 【ServerListUI Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ServerListUI Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ServerListUI = require "ServerListUI_Generate"

-- function ServerListUI:InitLogic()
-- 	local zoneListDropDown

-- 	local zoneList = GameObject.Find("ZoneList")
-- 	if zoneList then
--     	zoneListDropDown = zoneList:GetComponent(typeof(UnityEngine.UI.Dropdown))
--     end

--     if zoneListDropDown then
--     	zoneListDropDown:ClearOptions()
--     end

--     local OkBtn = GameObject.Find("OK")
--     if OkBtn then
-- 	   local button = OkBtn:GetComponent(typeof(UnityEngine.UI.Button))
--         local func = function ()
--             local index = zoneListDropDown.value + 1
--             local selectZone = self.zones[index]
--             if selectZone then
--                 self:loginZone(selectZone.id, function(success)
--                     print("loginZone", success)
--                     if success then
--                         StateMgr:ChangeToState(GameFlowState.SelectUserState)
--                         -- 在SelectUserPanel的OnOpen里请求过了
--                         -- GameNetHandler:SendWaitMessage("user.UserInfoReq", {}, function (data)
--                         --     LuaLogger.d(tablex.dump(data))
--                         --     -- StateMgr:ChangeToState(GameFlowState.GameState)
--                         -- end)
--                     end
--                 end)
--             end
--         end
--         button.onClick:AddListener(func)

--         if GlobalInfo.DirectLogin then
--             DLuaTimer:DoAfter(0.1, func)
--         end
--     end

--     LoginNetHandler:reqZoneList(function(zones)
--     	self.zones = {}
--     	for k,v in pairs(zones) do
--     		table.insert(self.zones, {id = v.id, name = v.name})
--     	end
--     	local zones = System.Collections.Generic.List_string.New()
--     	for k,v in pairs(self.zones) do
--     		zones:Add(v.name)
--     	end
--     	if zoneListDropDown then
--     		zoneListDropDown:AddOptions(zones)
--     	end
--     end)
-- end

function ServerListUI:InitLogic()
end

--function ServerListUI:StartCreating(time)
--
--end

--function ServerListUI:StartEnter(time)
--
--end

--function ServerListUI:StartRemoving(time)
--
--end

--function ServerListUI:StartExit(time)
--
--end

function ServerListUI:OnOpen(data, initiative)
	if not initiative then
		return
	end

	local zones = GlobalInfo.zones
	local zoneNum = zones and #zones or 0
	
	self:FillTemplateContent(self.servername, self.serverList, zoneNum, function (idx, go)
		local zone = zones[idx]
		go.text.text = zone.name
		UICommonUtils.ResetButtonListener(self, go.button, function ()
			GlobalInfo.CurrZone = zone
			self:Close()

			-- if GlobalInfo.DevPanel then
			    LoginNetHandler:LoginZoneFlow(zone)
			-- end
		end)
	end)
	
    local lastZone = SDKMgr:getLastLoginZone()
    local lastServerName = lastZone and lastZone.name or ""
	self.lastServer.text.text = string.format(LocalStrEnum.UI_ServerList_LastLoginStr, lastServerName)
	
	if not zones then
		return
	end
end

--function ServerListUI:OnClose(initiative)
--
--end

--function ServerListUI:OnDestroy()
--
--end

--function ServerListUI:OnRefresh(data)
--
--end

--[[
/Panel/RecentPart/lastServer onClick 
--]]
function ServerListUI:lastServer_Button_onClick(lastServer)
	self:Close()
end

return ServerListUI
