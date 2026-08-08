---@class ItemMsgPanel : ItemMsgPanel_Generate
---##################### 【ItemMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ItemMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ItemMsgPanel = require "ItemMsgPanel_Generate"

function ItemMsgPanel:InitLogic(data)
    self.nowMode = 1        --当前模式
    self.modeList = {
        "item", "equip","weapon"
    }
    self.itemData = nil
end

--function ItemMsgPanel:StartCreating(time)
--
--end

--function ItemMsgPanel:StartEnter(time)
--
--end

--function ItemMsgPanel:StartRemoving(time)
--
--end

--function ItemMsgPanel:StartExit(time)
--
--end

function ItemMsgPanel:OnOpen(data, initiative)
    self.itemData = data.data
    self.nowMode = data.mode
    --LuaLogger.ds("测试道具：", tablex.dump(self.itemData))
    self:SetView()
end

--设置显示
function ItemMsgPanel:SetView()
    self.equipBtnList:SetActive(self.modeList[self.nowMode] == "equip")
    if self.modeList[self.nowMode] == "item" then
        local itemConfig = Config.GetItemInfo(self.itemData.id)
        local num = 0
        -- 货币
        -- if itemConfig.type == GE.ItemPropType.Currency then
            num = Me:getItemNumById(self.itemData.id) or 0
        -- else
        --     num = Me:getItemById(self.itemData.id).num
        -- end
        self:LoadSpriteAwait(string.format(Config.SpritePath.ItemRankFarme2, itemConfig.quality), function(s)
            self.itemBox.rangeImg.image.sprite = s
        end)
        self:LoadSpriteAwait(string.format(Config.SpritePath.ItemRankFarme, itemConfig.quality), function(s)
            self.itemBox.rankBg.image.sprite = s
        end)
        self.itemNameTxt.text.text = itemConfig.itemName
        self.itemTypeTxt.text.text = LocalStrEnum["ItemType_"..itemConfig.type]
        self.hasCountTxt.text.text = "拥有数量:".. num
        self.itemMsgTxt.text.text = itemConfig.describe
        self.itemMode:SetActive(true)
        if itemConfig.dropid and next(itemConfig.dropid) then
            self:FillTemplateContent(self.getWayBox, self.content, #itemConfig.dropid, function(index, getWayBox)
                getWayBox:SetActive(true)
                getWayBox.titleTxt.text.text = "方式"..index
                getWayBox.goWayBtn.scaleButton.onClick:RemoveAllListeners()
                getWayBox.goWayBtn.scaleButton.onClick:AddListener(function()
                    --TODO: 这里加具体跳转逻辑
                    LuaLogger.ds("跳转途径", itemConfig.dropid[index])
                end)
            end)
        end
    elseif self.modeList[self.nowMode] == "equip" then
        --装备显示
        --LuaLogger.ds("测试道具：", tablex.dump(self.itemData))
        self.equipData = Me:getEquipDataByid(self.itemData.id)
        local equipConfig = Config.GetEquipmentInfo(self.equipData.cid)
        self.equipMode:SetActive(true)
        self.itemTypeTxt.text.text = equipConfig.equipType
        self.itemNameTxt.text.text = equipConfig.name
        self:LoadSpriteAwait(string.format(Config.SpritePath.ItemRankFarme2, equipConfig.quality), function(s)
            self.itemBox.rangeImg.image.sprite = s
        end)
        self:LoadSpriteAwait(string.format(Config.SpritePath.ItemRankFarme, equipConfig.quality), function(s)
            self.itemBox.rankBg.image.sprite = s
        end)

        local skillConfig = Config.GetSkillInfo(equipConfig.skill[self.equipData.star])

        if skillConfig then
            self.skillTxt.text.text = skillConfig.nameKey
            self.skillLevelTxt.text.text = "第<color=#1688E6>"..self.equipData.star.."</color>阶"
            self.skillMsgTxt.text.text = skillConfig.desKey
        end

        local NatureData = Me:getEquipNatureDataById(self.equipData.id)
        local temp = {}
        for key, value in pairs(NatureData) do
            table.insert(temp, value)
        end
        self.starBtn:SetActive(equipConfig.equipType ~= GE.EquipType.rankUp)
        self.levelBtn:SetActive(equipConfig.equipType ~= GE.EquipType.rankUp)
        self.delBtn:SetActive(equipConfig.equipType ~= GE.EquipType.rankUp)
        self:FillTemplateContent(self.attributeBox, self.attributeList, tablex.size(temp), function(index, attributeBox)
            attributeBox:SetActive(temp[index].value ~= 0)
            attributeBox.msgTIpsTxt.text.text = LocalStrEnum["NatureType_"..temp[index].type]
            attributeBox.msgNumTxt.text.text = temp[index].value
        end)
    elseif self.modeList[self.nowMode] == "weapon" then
        --TODO各种Icon显示
        --显示武器
        local weaponData = Me:getWeaponDataById(self.itemData.id)
        local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
        self.weaponNameText.text.text = weaponConfig.name
        self.weaponLevel.text.text = "+"..weaponData.level
        self:FillTemplateContent(self.weaponLoadBox, self.weaponLoadList, weaponConfig.load, function(index, weaponLoadBox)
            weaponLoadBox:SetActive(true)
        end)

        self.weaponIsLock:SetActive(weaponData.isLock)
        self.amountNum.text.text = weaponConfig.amount
        self.accuracyNum.text.text = weaponData.accuracy
        self.qualityNum.text.text = weaponData.quality
        self.scoreText.text.text = "???"--TODO等公式

        local needAttrList = {}
        for attrType, attrData in pairs(weaponData.attributeValue) do
            local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
            local data = {
                name = entryList[1].name,
                valueType = entryList[1].type,
                value = attrData.value,
            }
            needAttrList[attrData.id] = data
        end
        self:FillTemplateContent(self.weaponPanelBg.attributeBox, self.weaponPanelBg.attributeList, #weaponConfig.entryUnlock, function(index, attributeBox)
            if needAttrList[index] then
                attributeBox.attrTxt.text.text = needAttrList[index].name
                if needAttrList[index].valueType == GE.WeaponEntryAttrType.integer then--数值
                    attributeBox.msgNumTxt.text.text = needAttrList[index].value
                elseif needAttrList[index].valueType == GE.WeaponEntryAttrType.percentage then--百分比
                    attributeBox.msgNumTxt.text.text = needAttrList[index].value.."%"
                end
            else
                attributeBox.unlockText.text.text = string.format("-强化+%s时解锁-", weaponConfig.entryUnlock[index])
            end
    
            attributeBox.showAttr:SetActive(needAttrList[index] and true or false)
            attributeBox.lockedAttr:SetActive(not needAttrList[index] and true or false)
        end)
    end
    self.panelBg:SetActive(self.modeList[self.nowMode] ~= "weapon")
    self.weaponPanelBg:SetActive(self.modeList[self.nowMode] == "weapon")
end

--function ItemMsgPanel:OnClose(initiative)
--
--end

--function ItemMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ItemMsgPanel:OnRefresh(data)
--
--end

--[[
/ImgBg onClick 
--]]
function ItemMsgPanel:imgBg_Button_onClick(imgBg)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/GetWayBtn onClick 
--]]
function ItemMsgPanel:getWayBtn_ScaleButton_onClick(getWayBtn)
    self.getWayPanel:SetActive(not self.getWayPanel.activeSelf)
end

--[[
/GetWayBox/GoWayBtn onClick 
--]]
function ItemMsgPanel:goWayBtn_ScaleButton_onClick(goWayBtn)

end

--[[
/PanelBg/EquipBtnList/DelBtn onClick 
--]]
function ItemMsgPanel:delBtn_ScaleButton_onClick(delBtn)
    -- UIMgr:popUI("EquipIntensifyPanel", {data = self.itemData, mode = 3})
    UIMgr:popUI("EquipDelPanel", {})
    UIMgr:closeUI(self)
end

--[[
/PanelBg/EquipBtnList/StarBtn onClick 
--]]
function ItemMsgPanel:starBtn_ScaleButton_onClick(starBtn)
    UIMgr:popUI("EquipIntensifyPanel", {data = self.itemData, mode = 2})
    UIMgr:closeUI(self)
end

--[[
/PanelBg/EquipBtnList/LevelBtn onClick 
--]]
function ItemMsgPanel:levelBtn_ScaleButton_onClick(levelBtn)
    UIMgr:popUI("EquipIntensifyPanel", {data = self.itemData, mode = 1})
    UIMgr:closeUI(self)
end

--[[
/PanelBg/EquipBtnList/LockBtn onClick 
--]]
function ItemMsgPanel:lockBtn_ScaleButton_onClick(lockBtn)
    local data = {
        equipId = self.itemData.id
    }
    Me:changeEquipLockStateReq(data, function()
        GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
        self:SetView()
    end)
end

--[[
/PanelBg/ItemBox onClick 
--]]
function ItemMsgPanel:itemBox_ScaleButton_onClick(itemBox)

end

--[[
/PanelBg/ItemMode/UseBtn onClick 
--]]
function ItemMsgPanel:useBtn_ScaleButton_onClick(useBtn)

end

--[[
/WeaponPanelBg/WeaponDelBtn onClick 
--]]
function ItemMsgPanel:weaponDelBtn_ScaleButton_onClick(weaponDelBtn)
    UIMgr:popUI("EquipDelPanel", {openType = GE.RewardType.Weapon})
    UIMgr:closeUI(self)
end

--[[
/WeaponPanelBg/WeaponLevelBtn onClick 
--]]
function ItemMsgPanel:weaponLevelBtn_ScaleButton_onClick(weaponLevelBtn)
    UIMgr:popUI("WeaponLevelUpPanel",{weaponId = self.itemData.id})
    UIMgr:closeUI(self)
end

--[[
/WeaponPanelBg/WeaponLockBtn onClick 
--]]
function ItemMsgPanel:weaponLockBtn_ScaleButton_onClick(weaponLockBtn)
    Me:changeWeaponLockStateReq({weaponId = self.itemData.id}, function()
        GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
        self:SetView()
    end)
end

return ItemMsgPanel
