---@class WeaponAttrChangePanel : WeaponAttrChangePanel_Generate
---##################### 【WeaponAttrChangePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeaponAttrChangePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeaponAttrChangePanel = require "WeaponAttrChangePanel_Generate"

function WeaponAttrChangePanel:InitLogic(data)
    --武器升级前数据
    self.oldWeaponData = {}
    --武器升级后数据
    self.newWeaponData = {}
    --属性变化格子列表
    self.attrBoxObjList = {}
    self.customBox.customBox:setMono(self)
end

function WeaponAttrChangePanel:InitPanel()
    self:showAttrChangeData()
end

--function WeaponAttrChangePanel:StartCreating(time)
--
--end

--function WeaponAttrChangePanel:StartEnter(time)
--
--end

--function WeaponAttrChangePanel:StartRemoving(time)
--
--end

--function WeaponAttrChangePanel:StartExit(time)
--
--end

function WeaponAttrChangePanel:OnOpen(data, initiative)
    self.oldWeaponData = data and data.oldData
    self.newWeaponData = data and data.newData
    self:InitPanel()
end

function WeaponAttrChangePanel:showAttrChangeData()
    self.locked:SetActive(self.newWeaponData.isLock)
    self.oldLevelText.text.text = "+"..self.oldWeaponData.level
    self.newLevelText.text.text = "+"..self.newWeaponData.level

    local oldAttrList = {}
    for attrType, attrData in pairs(self.oldWeaponData.attributeValue) do
        local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
        local data = {
            name = entryList[1].name,
            valueType = entryList[1].type,
            value = attrData.value,
        }
        oldAttrList[attrData.id] = data
    end
    local newAttrList = {}
    for attrType, attrData in pairs(self.newWeaponData.attributeValue) do
        local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
        local data = {
            name = entryList[1].name,
            valueType = entryList[1].type,
            value = attrData.value,
            type = entryList[1].attributeId,
            isSpecial = attrData.isSpecial,
        }
        newAttrList[attrData.id] = data
    end
    self.skillbox:SetActive(false)
    self:FillTemplateContent(self.attrbox, self.attrList, #newAttrList, function(index, attributeBox)
        attributeBox.attrTypeText.text.text = newAttrList[index].name
        attributeBox.newAttr:SetActive(not oldAttrList[index])
        local showOldValue = oldAttrList[index] and true or false
        local isNewValue = (oldAttrList[index] and oldAttrList[index].value ~= newAttrList[index].value) and true or false
        isNewValue = isNewValue or not oldAttrList[index]
        attributeBox.oldValue:SetActive(showOldValue)
        attributeBox.arrowIcon:SetActive(showOldValue)

        --判断词条显示状态
        if newAttrList[index].valueType == GE.WeaponEntryAttrType.integer then--数值
            attributeBox.oldValue.text.text = oldAttrList[index] and oldAttrList[index].value or 0
            attributeBox.newValue.text.text = newAttrList[index].value
        elseif newAttrList[index].valueType == GE.WeaponEntryAttrType.percentage then--百分比
            attributeBox.oldValue.text.text = (oldAttrList[index] and oldAttrList[index].value or 0).."%"
            attributeBox.newValue.text.text = newAttrList[index].value.."%"
        elseif newAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
            attributeBox:SetActive(false)
            self.skillbox:SetActive(true)
            local skillConfig = Config.GetSkillInfo(newAttrList[index].value)
            self.skillbox.skillDescText.text.text = skillConfig.desKey
        end
        attributeBox.newValue.text.color = (newAttrList[index].isSpecial and Color.NewFromStr("FF8019"))
         or (isNewValue and Color.NewFromStr("1B8AE6")) or Color.NewFromStr("494949")
        self:LoadSpriteAsync(string.format(Config.SpritePath.AttributeIcon, newAttrList[index].type), function(s)
            if s then
                attributeBox.attrIcon.image.sprite = s
            end
        end)
    end)

    --武器稀有度框及图片
    local weaponConfig = Config.GetWeaponInfo(self.newWeaponData.cid)

    local customData = {
        id = self.newWeaponData.cid,
        itemType = GE.ItemTypeIndex.weapon,
        ownerPanelName = self.uiConfig.id,
    }
    self.customBox.customBox:refreshUI(customData)
end

function WeaponAttrChangePanel:refreshLockState()
    local weaponData = Me:getWeaponDataById(self.newWeaponData.id)
    self.locked:SetActive(weaponData.isLock)
end

--function WeaponAttrChangePanel:OnClose(initiative)
--
--end

--function WeaponAttrChangePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeaponAttrChangePanel:OnRefresh(data)
--
--end

--[[
/Bg onClick 
--]]
function WeaponAttrChangePanel:bg_Button_onClick(bg)
    self.animator:SetTrigger("out")
    self.bg.button.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.bg.button.interactable = true
        UIMgr:closeUI(self)
    end)
end

--[[
/InfoBg/LockBtn onClick 
--]]
function WeaponAttrChangePanel:lockBtn_ScaleButton_onClick(lockBtn)
    Me:changeWeaponLockStateReq({weaponId = self.newWeaponData.id}, function()
        self:refreshLockState()
    end)
end

--[[
/ImgBg/OkBtn onClick 
--]]
function WeaponAttrChangePanel:okBtn_ScaleButton_onClick(okBtn)
    self.animator:SetTrigger("out")
    self.okBtn.scaleButton.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.okBtn.scaleButton.interactable = true
        UIMgr:closeUI(self)
    end)
end

return WeaponAttrChangePanel
