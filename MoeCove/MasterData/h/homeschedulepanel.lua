---@class HomeSchedulePanel : HomeSchedulePanel_Generate
---##################### 【HomeSchedulePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeSchedulePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeSchedulePanel = require "HomeSchedulePanel_Generate"

function HomeSchedulePanel:InitLogic(data)

end

--function HomeSchedulePanel:StartCreating(time)
--
--end

--function HomeSchedulePanel:StartEnter(time)
--
--end

--function HomeSchedulePanel:StartRemoving(time)
--
--end

--function HomeSchedulePanel:StartExit(time)
--
--end

function HomeSchedulePanel:OnOpen(data, initiative)
    self.constuctId = data.constuctId
    self:refreshUI()
end

function HomeSchedulePanel:refreshUI()
    local workScheduleCfg = Config.GetConfigInfo("homework3")
    self.disposeRoleList = Me:getDisposeRole(self.constuctId)
    for i = 1, 3 do
        local roleId = self.disposeRoleList[i]
        local obj = self["role"..i]
        if roleId and roleId ~= 0 then
            obj.empty:SetActive(false)
            obj.roleIcon:SetActive(true)
            local roleData = Me:getPlayerHero(roleId)
            if not roleData then
                return
            end
            local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
            local function is_numeric(str)
                return tonumber(str) ~= nil
            end
            local resourceFolder = nil
            if is_numeric(skinConfig.resourceFolder) then
                resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
            else
                resourceFolder = skinConfig.resourceFolder
            end
        
            local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
            self:LoadSpriteAsync(iconPath, obj.roleIcon.image)
        else
            obj.empty:SetActive(true)
            obj.roleIcon:SetActive(false)
        end
        local index = CoveManager.instance()._roleMgr:getRoleScheduleIndex()
        for j = 1, 7 do
            local schedule = workScheduleCfg[index]
            local value = schedule[i]
            if value == 1 then
                obj["text"..j].text.text = LocalStrEnum.VarietyDescribe_100086
            elseif value == 2 then
                obj["text"..j].text.text = LocalStrEnum.VarietyDescribe_100087
            elseif value == 0 then
                obj["text"..j].text.text = LocalStrEnum.VarietyDescribe_100088
            end
            index = index + 1
            if index > 3 then
                index = 1
            end
        end
        if i == CoveManager.instance()._roleMgr:getHomeCurWorkPos() then
            obj.sel:SetActive(true)
            obj["text1"].text.color = Color.NewFromStr("FFFFFF")
        else
            obj.sel:SetActive(false)
        end
    end
end

--function HomeSchedulePanel:OnClose(initiative)
--
--end

--function HomeSchedulePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomeSchedulePanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function HomeSchedulePanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

function HomeSchedulePanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return HomeSchedulePanel
