---@class HomeRoleBox : HomeRoleBox_Generate
---##################### 【HomeRoleBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeRoleBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%

local HomeRoleBox = require "HomeRoleBox_Generate"

function HomeRoleBox:InitLogic(data)
end




function HomeRoleBox:setMono(mono)
    self.mono = mono
end

---@class HomeRoleBoxData
---@field roleId integer
---@field showTitle boolean 是否显示title
---@field pos integer 角色放置位置
---@field isLock boolean 是否锁定
---@field sel boolean 是否选中

---@param data HomeRoleBoxData
function HomeRoleBox:refreshUI(data)
    if data.isLock then
        self.lockState:SetActive(true)
        self.emptySeat:SetActive(false)
        self.bg:SetActive(false)
        return
    end
    self.lockState:SetActive(false)

    if data.clickCallback then
        self.clickCallback = data.clickCallback
    end
    if data.sel then
        self.sel:SetActive(true)
    else
        self.sel:SetActive(false)
    end
    if not data.roleId or data.roleId == 0 then
        --当前位置没有角色
        self.emptySeat:SetActive(true)
        self.bg:SetActive(false)
        return
    end
    self.emptySeat:SetActive(false)
    if data.showTitle then
        self.titleBg:SetActive(true)
        self.titleName.text.text = LocalStrEnum["ConstructionJobName_1000" .. data.pos]
    else
        self.titleBg:SetActive(false)
    end

    
    local roleData = Me:getPlayerHero(data.roleId)

    local roleConfig = Config.GetCharacterInfo(data.roleId)
    if not roleData or not roleConfig then
        LuaLogger.e("HomeRoleBox:refreshUI roleData or roleConfig is nil, roleId:".. data.roleId)
        self.emptySeat:SetActive(true)
        self.bg:SetActive(false)
        return
    end
    self.bg:SetActive(true)
    self.roleName.text.text = roleConfig.name

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

    local iconPath = string.format(Config.SpritePath.BannerRolePath, resourceFolder, skinConfig.driverKey)
    -- ResMgr:LoadSpriteAsync(iconPath, self.headIcon.gameObject, function(_sprite)
    --     self.headIcon.image.sprite = _sprite
    -- end)

    self.mono:LoadSpriteAsync(iconPath, self.headIcon.image)
end

--function HomeRoleBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/Root onClick 
--]]
function HomeRoleBox:scaleButton_ScaleButton_onClick(scaleButton)
    if self.clickCallback then
        self.clickCallback()
    end
end

return HomeRoleBox
