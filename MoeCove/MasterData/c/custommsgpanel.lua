---@class CustomMsgPanel : CustomMsgPanel__Generate
---##################### 【CustomMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CustomMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CustomMsgPanel = require "CustomMsgPanel_Generate"

---@class CustomMsgData
---@field type CustomMsgType          消息类型
---@field config table  配置表
---@field Id integer                     道具|武器|装备ID
---@field LockCallBack function?         锁定回调
---@field CanLock boolean?               是否可以锁定
---@field needNum integer?                  需要的数量(跳转后显示)

function CustomMsgPanel:InitLogic(data)
    self.isDraging = false
    self.lockCallBack = nil

     local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
    --canvas.sortingOrder = order
end

function CustomMsgPanel:setMono(mono)
    self.mono = mono
end

---@param data CustomMsgData
function CustomMsgPanel:SetView(data)

    LuaLogger.ds("CustomMsgPanel data", tablex.dump(data))
    self.data = data
    self.lockCallBack = data.LockCallBack
    self:SetMaskListener()
    self.closeFunc = data.closeFunc
    self.equipMode:SetActive(data.type == GE.CustomMsgType.Equip)
    self.weaponMode:SetActive(data.type == GE.CustomMsgType.Weapon)
    self.itemMode:SetActive(data.type == GE.CustomMsgType.Item)
    self.lockBtn:SetActive((data.type == GE.CustomMsgType.Weapon or data.type == GE.CustomMsgType.Equip) and data.CanLock)
    self.spBtn:SetActive(false)
    self.bg.rectTransform.sizeDelta = Vector2.New(532, 906)
    self.middleline:SetActive(data.type ~= GE.CustomMsgType.Item)
    if data.type == GE.CustomMsgType.Weapon then
        self:SetWeaponView(data.config, data.Id)
    elseif data.type == GE.CustomMsgType.Equip then
        self:SetEquipView(data.config, data.Id)
    elseif data.type == GE.CustomMsgType.Item then
        self:SetItemView(data.config, data.Id, data.navType)
    end
    self.space:SetActive(data.type ~= GE.CustomMsgType.Weapon)
end

--设置遮罩监听
function CustomMsgPanel:SetMaskListener()
    local function onPointerClick()
        if not self.isDraging then
            self.gameObject:SetActive(false)
            self:clearCallBack()
        end
    end

    --遮罩点击关闭自身
    self.mask.pointerListener.onPointerClickEvent = onPointerClick
end

--设置武器 信息显示
---@param configData WeaponTable
---@param Id integer
function CustomMsgPanel:SetWeaponView(configData, Id)
    local serverData = Me:getWeaponDataById(Id)
    self.nameTxt.text.text = configData.name
    self:setIsLock(serverData.isLock)
    self.weaponLevelTxt.text.text = "+"..serverData.level
    self.amountNum.text.text = configData.weaponTypeDec
    self.accuracyNum.text.text = serverData.accuracy
    self.qualityNum.text.text = serverData.quality
    self.scoreText.text.text = math.floor((configData.bulletNum * serverData.accuracy * serverData.quality / 1000))
    self:FillTemplateContent(self.weaponLoadBox, self.weaponLoadList, configData.load, function(index, weaponLoadBox)
        weaponLoadBox:SetActive(true)
    end)
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.WeaponTypePath, configData.type), self.weaponTypeIcon.image)
    local needAttrList = {}
    for attrType, attrData in pairs(serverData.attributeValue) do
        local enterList = Config.GetWeaponEntryInfoByGroup(attrType)
        local data = {
            name = enterList[1].name,
            valueType = enterList[1].type,
            value = attrData.value,
            type = enterList[1].attributeId,
            isSpecial = attrData.isSpecial,
        }
        needAttrList[attrData.id] = data
    end
    self.skillPanel:SetActive(false)
    self:FillTemplateContent(self.attributeBox, self.weaponMode.attributeList, #configData.entryUnlock, function(index, attributeBox)
        local boxData = {
            boxType = GE.ItemTypeIndex.weapon,
            attrData = needAttrList[index],
            weaponConfig = configData,
            weaponData = serverData,
            boxIndex = index,
        }
        attributeBox.attributeBox:setMono(self.mono)
        attributeBox.attributeBox:setAttrBoxData(boxData)

        if needAttrList[index] then
            if needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
                self.skillPanel:SetActive(true)
                local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                self.weaponSkillTxt.text.text = skillConfig.desKey
            end
        end
    end)
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.itemRankLine, configData.rare), self.rankImgBg.image)
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, configData.icon), self.itemIcon.image)
    self.lockBtn.scaleButton.onClick:RemoveAllListeners()
    self.lockBtn.scaleButton.onClick:AddListener(function()
        Me:changeWeaponLockStateReq({weaponId = serverData.id}, function()
            if self.lockCallBack ~= nil then
                self.lockCallBack()
                local newData = Me:getWeaponDataById(Id)
                self:setIsLock(newData.isLock)
            end
        end)
    end)
end

--设置装备 信息显示
---@param configData EquipmentTable
---@param Id integer
function CustomMsgPanel:SetEquipView(configData, Id)
    local serverData = Me:getEquipDataByid(Id)
    local isSp = configData.equipType == GE.EquipType.sp

    if serverData == nil then
        --预览模式
        self.lockBtn:SetActive(false)
        self.spBtn:SetActive(isSp)
        serverData = {
            id = Id,
            level = 1,
            star = configData.basicStar,
            isLock = false,
        }
    else
        if isSp then
            self.spBtn:SetActive(true)
            self.lockBtn:SetActive(false)
            self:setIsLock(false)
        else
            self.spBtn:SetActive(false)
            self:setIsLock(serverData.isLock)
        end
    end
    local type = configData.equipType
    
    self.normalEquip:SetActive(type == GE.EquipType.equip or type == GE.EquipType.sp)
    self.equipItem:SetActive(type == GE.EquipType.rankUp)

    self.nameTxt.text.text = configData.name
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.itemRankLine, configData.quality), self.rankImgBg.image)
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.EquipIconPath, configData.icon), self.itemIcon.image)
    self.lockBtn.scaleButton.onClick:RemoveAllListeners()
    self.spBtn.scaleButton.onClick:RemoveAllListeners()
    self.lockBtn.scaleButton.onClick:AddListener(function()
        Me:changeEquipLockStateReq({equipId = serverData.id}, function()
            if self.lockCallBack ~= nil then
                self.lockCallBack()
                local newData = Me:getEquipDataByid(Id)
                self:setIsLock(newData.isLock)
            end
        end)
    end)
    self.bg.rectTransform.sizeDelta = Vector2.New(532, 906)
    self.equipMode.partName.text.text = configData.dec
    self.equipLevelTxt.text.text = "Lv."..serverData.level
    for i = 1, 6 do
        if i <= serverData.star then
            self.equipStarList["star_"..i].starOn:SetActive(true)
        else
            self.equipStarList["star_"..i].starOn:SetActive(false)
        end
    end
    if type == GE.EquipType.equip or type == GE.EquipType.sp then
        local str = LocalStrEnum.ActionFailReason_EquipLevelUpTips
        local romanNumerals = {"I", "II", "III", "IV", "V"}
        local nowEffectId = Me:getEquipEffectIdByid(serverData.id)
        local nowEffectStage = Me:getEquipEffectStageByid(serverData.id)
        local equipSkill = configData.skill
        local skillConfig = {}
        if nowEffectId == nil and tablex.next(equipSkill) == nil then  --当前效果为空且配置skill也为空，视为没有特殊效果
            self.nullEffect:SetActive(true)
            self.hasEffect:SetActive(false)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = ""
            self.skillMsgTxt:SetActive(false)
        elseif nowEffectId == nil and tablex.next(equipSkill) ~= nil then --当前效果为空但配置skill不为空，视为有特殊效果但未解锁
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = string.format(str, configData.unLockSkillLv[1])
            self.skillMsgTxt:SetActive(true)
            local nextEffectId = equipSkill[1] or 0
            skillConfig = Config.GetSkillInfo(nextEffectId)
            --修改描述透明度意为未生效
            local c1 = self.skillMsgTxt.text.color
            self.skillMsgTxt.text.color = Color.New(c1.r, c1.g, c1.b, 0.65)
        else
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            self.effectLevel.text.text = romanNumerals[nowEffectStage].." "..LocalStrEnum.AffectionLevel
            self.effectLevelMsg.text.text = ""
            self.skillMsgTxt:SetActive(true)
            skillConfig = Config.GetSkillInfo(nowEffectId)
            local c2 = self.skillMsgTxt.text.color
            self.skillMsgTxt.text.color = Color.New(c2.r, c2.g, c2.b, 1)
        end
        if skillConfig then
            self.skillMsgTxt.text.text = skillConfig.desKey
        else
            self.skillMsgTxt.text.text = ""
        end
        local NatureData = Me:getEquipNatureDataById(serverData.id)
        local temp = {}
        if NatureData then
            for _, v in pairs(NatureData) do
                table.insert(temp, v)
            end
        else
            NatureData = Me:getEquipNatureDataByCid(configData.id)
            for _, v in pairs(NatureData) do
                table.insert(temp, v)
            end
        end
        self:FillTemplateContent(self.attributeBox, self.equipMode.attributeList, tablex.size(temp), function(index, attributeBox)
            local boxData = {
                boxType = GE.ItemTypeIndex.equip,
                attrData = temp[index],
                boxIndex = index,
            }
            attributeBox.attributeBox:setMono(self.mono)
            attributeBox.attributeBox:setAttrBoxData(boxData)
        end)
    else
        self.bg.rectTransform.sizeDelta = Vector2.New(532, 540)
        self.equipItem.itemMsgTxt.text.text = configData.dec
    end
end

--设置道具 信息显示
---@param configData ItemTable  道具配置表
---@param Id integer  道具服务器数据 可能为空
---@param navType GE.NavigationType  导航类型
function CustomMsgPanel:SetItemView(configData, Id, navType)
    local itemCount = Me:getItemCountById(Id)
    if configData.numShowType == GE.ItemNumShowType.OverflowWithK then
        if itemCount >= 100000 then
            local kCount = math.floor(itemCount / 1000)
            local hCount = math.floor((itemCount % 1000) / 100)
            itemCount = string.format("%dk", kCount)
            if hCount > 0 then
                itemCount = string.format("%s.%d k", itemCount, hCount)
            end
        end
    end
    self.countTxt.text.text = itemCount

    self.nameTxt.text.text = configData.itemName
    self.itemMsgTxt.text.text = configData.describe
    -- self.itemTypeTxt.text.text = configData.type
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.itemRankLine, configData.quality), self.rankImgBg.image)
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, configData.icon), self.itemIcon.image)
    --获取途径
    local showWay = false
    local showNeedNum = 0
    local wayList = {}
    if navType then
        local info = Config.GetFunctionTabInfo(navType)
        if info then
            if info.IsJump == 1 then
                local config = Config.GetItemInfo(Id)
                if config and tablex.size(config.turnTo) > 0 then
                    wayList = config.turnTo
                    showWay = true
                end
            end
            if info.IsShowLackTip and info.IsShowLackTip == 1 and self.data.needNum then
                showNeedNum = self.data.needNum
            end
        end
    end
    if showWay then
        self.bg.rectTransform.sizeDelta = Vector2.New(532, 906)
        self:FillTemplateContent(self.getActiveBox, self.channeList, tablex.size(wayList), function (index, itemObj)
            local skipInfo = Config.SkipFuncInfo(wayList[index])
            if skipInfo then
                itemObj.channelTxt.text.text = skipInfo.desc
                local canUseSkip, showBtn = UICommonUtils.CanUseSkipJudge(skipInfo.id, false)
                itemObj.scaleButton.onClick:RemoveAllListeners()
                itemObj.goBtn:SetActive(showBtn)
                if canUseSkip == false then
                    itemObj.channelboxBg:SetActive(false)
                    itemObj.isLock:SetActive(true)
                else
                    itemObj.channelboxBg:SetActive(true)
                    itemObj.isLock:SetActive(false)
                end
                itemObj.scaleButton.onClick:AddListener(function()
                    if canUseSkip == false then
                        UICommonUtils.CanUseSkipJudge(skipInfo.id, true)
                        return
                    end
                    if showBtn == false then
                        return
                    end
                    if self.beforeTruntoFunc then
                        self.beforeTruntoFunc()
                    end
                    local curWnd = nil
                    if skipInfo.isClose == 1 then
                        curWnd = UIMgr:getCurWndName()
                    end
                    UICommonUtils.CommonTurnTo(skipInfo.id, curWnd, function()
                        if showNeedNum > 0 then
                            UIMgr:popUICover("LackItemTipsPanel", {
                                itemId = Id,
                                needNum = showNeedNum,
                            })
                        end
                    end, {
                        needNum = showNeedNum,
                        targetId = Id,
                    })
                end)
            else
                itemObj.gameObject:SetActive(false)
            end
        end)
    else
        self.bg.rectTransform.sizeDelta = Vector2.New(532, 590)
    end
    self.getTitleBox:SetActive(showWay)
    self.channeView:SetActive(showWay)
end

--设置跳转前的回调
---@param func function 回调函数
function CustomMsgPanel:SetBeforeTruntoFunc(func)
    self.beforeTruntoFunc = func
end

--设置锁定显示
---@param state boolean 是否锁定
function CustomMsgPanel:setIsLock(state)
    self.isLock:SetActive(state)
end

--设置是否需要点击穿透
function CustomMsgPanel:SetPassEventState(pass)
    if self.mask and self.mask.pointerListener then
        self.mask.pointerListener.passEvent = pass
    end
end

function CustomMsgPanel:SetCanvasAndOrder(order)
    local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
    canvas.sortingOrder = order
end

function CustomMsgPanel:_onStartDrag()
    self.isDraging = true
end
function CustomMsgPanel:_onStopDrag()
    self.isDraging = false
end

function CustomMsgPanel:clearCallBack()
    self.lockCallBack = nil
end

--function CustomMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/bg/MsgPanel/LockBtn onClick 
--]]
function CustomMsgPanel:lockBtn_ScaleButton_onClick(lockBtn)

end

--[[
/bg/GetActiveBox/ChannelboxBg/Image onClick 
--]]
function CustomMsgPanel:image_ScaleButton_onClick(image)

end

--[[
/bg/GetActiveBox/Gobtn onClick 
--]]
function CustomMsgPanel:gobtn_ScaleButton_onClick(gobtn)

end

--[[
/bg/GetActiveBox/GoBtn onClick 
--]]
function CustomMsgPanel:goBtn_ScaleButton_onClick(goBtn)

end

--[[
/bg/GetActiveBox onClick 
--]]
function CustomMsgPanel:getActiveBox_ScaleButton_onClick(getActiveBox)

end

--[[
/bg/MsgPanel/SpBtn onClick 
--]]
function CustomMsgPanel:spBtn_ScaleButton_onClick(spBtn)
    -- TODO: sp专属装备永久锁定按钮点击逻辑
end

return CustomMsgPanel
