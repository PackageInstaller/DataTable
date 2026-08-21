---@class RoleHeadBox : RoleHeadBox_Generate
---##################### 【RoleHeadBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RoleHeadBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RoleHeadBox = require "RoleHeadBox_Generate"

function RoleHeadBox:InitLogic(data)

end

---@class RoleHeadBoxData
---@field roleId integer
---@field showTag boolean 是否显示词条
---@field tagData SignalTable? 词条数据
---@field isSel boolean?
---@field isGray boolean?
---@field clickFunc function
---@field isDeployed boolean
---@field isPure boolean?
---@field showEnergy boolean?  体力显示
---@field existSingnalUp boolean? 是否存在特性提升
---@field showBattlePoint boolean? 战斗力显示
---@field isAdvantageousRole boolean? 是否为优势角色
---@field roleImgScale number? 角色头像缩放

---@param data RoleHeadBoxData
function RoleHeadBox:refreshUI(data)
    self.data = data
    local roleData = Me:getPlayerHero(data.roleId)
    if not roleData then
        return
    end
    local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
    local roleConfig = Config.GetCharacterInfo(data.roleId)
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
    self.mono:LoadSpriteAsync(iconPath, self.roleImg.image)
    local farmePath = string.format(Config.SpritePath.RankFrameSmall, roleConfig.rank)
    self.mono:LoadSpriteAsync(farmePath, self.frameImg.image)
    local starPath = string.format(Config.SpritePath.StarLevelImg, roleData.star)
    self.mono:LoadSpriteAsync(starPath, self.starImg.image)
    local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
    self.mono:LoadSpriteAsync(typeIconPath, self.shipTypeIcon.image)
    self.levelText.text.text = roleData.level
    if data.showTag then
        if data.tagData then
            self.noTag:SetActive(false)
            self.tagBg:SetActive(true)
            self.tagTxt.text.text = data.tagData.SignalName
            self.mono:LoadSpriteAsync(string.format(Config.SpritePath.RolePeculiarity, data.tagData.type), self.tagBg.image)
            self.tagBg.scaleButton.onClick:RemoveAllListeners()
            self.tagBg.scaleButton.onClick:AddListener(function()
                GameMsgMgr:sendEvent(GameMsgType.RoleBoxClickTag, data.tagData)
            end)
        else
            self.noTag:SetActive(true)
            self.tagBg:SetActive(false)
        end
    else
        self.noTag:SetActive(false)
        self.tagBg:SetActive(false)
    end

    self.deployedMark.gameObject:SetActive(data.isDeployed)

    
    self:updateEnergy(data.showEnergy, roleData.energy)
    local battlePointNum = roleData.allDmg
    if data.battlePointMul then
        self.starBg:SetActive(false)
        battlePointNum = math.floor(battlePointNum * data.battlePointMul)
        if data.battlePointMul == 1 then
            self.addLab:SetActive(false)
        elseif data.battlePointMul > 1 then
            self.addLab:SetActive(true)
        end
    else
        self.starBg:SetActive(true)
        self.addLab:SetActive(false)
    end
    self:updateBattlePoint(data.showBattlePoint, battlePointNum)

    if data.isPure then
        self.frameImg.gameObject:SetActive(false)
        self.levelBg.gameObject:SetActive(false)
        self.starBg.gameObject:SetActive(false)
        self.shipTypeIcon.gameObject:SetActive(false)
        self.levelText.gameObject:SetActive(false)
        self.levelTitle.gameObject:SetActive(false)
    end
    if data.roleImgScale then
        self.roleImg.image.rectTransform.localScale = Vector3.New(data.roleImgScale, data.roleImgScale, 1)
    else
        self.roleImg.image.rectTransform.localScale = Vector3.one
    end

    self.advantageousRoot.gameObject:SetActive(data.isAdvantageousRole == true)

    self:updateSel()
    self:updateIsGray()
    self:addClick()
end

function RoleHeadBox:setMono(mono)
    self.mono = mono
end

function RoleHeadBox:updateEnergy(showEnergy, energy)
    if not showEnergy then
        self.energy:SetActive(false)
        return
    end
    self.energy:SetActive(true)
    local index, color = Me:getDispatchEnergyIndexAndColor(energy)
    self.energy.num.text.text = energy
    self.energy.num.text.color = Color.NewFromStr(color)
    for i = 1, 3 do
        if i == index then
            self.energy["hp"..i].gameObject:SetActive(true)
        else
            self.energy["hp"..i].gameObject:SetActive(false)
        end
    end
    if self.data.existSingnalUp then
        self.energy.up:SetActive(true)
        self.battlePoint.highLight:SetActive(true)
        self.battlePoint.num.text.color = Color.NewFromStr("FFFFFF")
    else
        self.energy.up:SetActive(false)
        self.battlePoint.highLight:SetActive(false)
        self.battlePoint.num.text.color = Color.NewFromStr("143952")
    end

    --TODO 体力显示
end

function RoleHeadBox:updateBattlePoint(showBattlePoint, num)
    if not showBattlePoint then
        self.battlePoint:SetActive(false)
        return
    end
    self.battlePoint:SetActive(true)
    self.battlePoint.num.text.text = num or 0
    if self.data.isGray then
        self.battlePoint.mask:SetActive(true)
    else
        self.battlePoint.mask:SetActive(false)
    end
end

function RoleHeadBox:updateSel()
    if self.data.isSel then
        self.selImg:SetActive(true)
    else
        self.selImg:SetActive(false)
    end
end

function RoleHeadBox:updateIsGray()
    if self.data.isGray then
        self.grayMask:SetActive(true)
    else
        self.grayMask:SetActive(false)
    end
end

function RoleHeadBox:addClick()
    self.roleMask.scaleButton.onClick:RemoveAllListeners()
    if not self.data.clickFunc then
        return
    end
    self.roleMask.scaleButton.onClick:AddListener(self.data.clickFunc)
end

function RoleHeadBox:OnDestroy()
    self.roleMask.scaleButton.onClick:RemoveAllListeners()
    self.super:OnDestroy(self)
end

--[[
/RoleMask onClick 
--]]
function RoleHeadBox:roleMask_ScaleButton_onClick(roleMask)

end

--[[
/TagBg onClick 
--]]
function RoleHeadBox:tagBg_ScaleButton_onClick(tagBg)
    
end

return RoleHeadBox
