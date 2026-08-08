---@class CustomTips : CustomTips_Generate
---##################### 【CustomTips Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CustomTips Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CustomTips = require "CustomTips_Generate"
local AttributeBox = require("AttributeBox")
local romanNumerals = {"I", "II", "III", "IV", "V"}
function CustomTips:InitLogic(data)

    LuaLogger.ds("CustomTipsMsgPanel  InitLogic data" .. tablex.dump(data))
    self.lockCallBack = nil
end

---@param rewardData {id:integer, type:GE.RewardType, navType:GE.NavigationType?, CanLock:boolean?}
function CustomTips:SetUIData(rewardData)
    local cfg = nil
	if rewardData.type == GE.RewardType.ItemProp then	
		cfg = Config.GetItemInfo(rewardData.id)
	elseif rewardData.type == GE.RewardType.Weapon then
        local weaponData = Me:getWeaponDataById(rewardData.id)
		if weaponData == nil then
        	--预览模式
			rewardData.CanLock = false
			weaponData = {cid = rewardData.id}
		end
        cfg = Config.GetWeaponInfo(weaponData.cid)
	elseif rewardData.type == GE.RewardType.Equipment then
		local equipData = Me:getEquipDataByid(rewardData.id)
        if equipData == nil then
        	--预览模式
			rewardData.CanLock = false
			equipData = {cid = rewardData.id}
		end
        cfg = Config.GetEquipmentInfo(equipData.cid)
	end
	local data =  {
        type = Me:RewardTypeToCustomMsgType(rewardData.type),
        config = cfg,
        Id = rewardData.id,
		CanLock = rewardData.CanLock,
		tipsPassEventState = rewardData.tipsPassEventState,
		navType = rewardData.navType,
		ownerPanelName = rewardData.ownerPanelName,
        lockCallBack = rewardData.lockCallBack,
    }
    if data.CanLock == nil then
       data.CanLock = true 
    end
    self:SetData(data)
end

---@class CustomMsgData
---@field type CustomMsgType          消息类型
---@field config table  配置表
---@field Id integer                     道具|武器|装备ID
---@field lockCallBack function?         锁定回调
---@field CanLock boolean?               是否可以锁定

---@param data CustomMsgData
function CustomTips:SetData(data)

    -- LuaLogger.ds("CustomTipsMsgPanel data" .. tablex.dump(data))
    self.data = data
    self.lockCallBack = data.lockCallBack
    self.closeFunc = data.closeFunc
    self.weaponMode.gameObject:SetActive(data.type == GE.CustomMsgType.Weapon)
    self.lockBtn:SetActive((data.type == GE.CustomMsgType.Weapon or data.type == GE.CustomMsgType.Equip) and data.CanLock)

    self.itemMode.gameObject:SetActive(data.type == GE.CustomMsgType.Item)
    self.itemInfoView.gameObject:SetActive(data.type == GE.CustomMsgType.Item)
    self.equipMode.gameObject:SetActive(data.type == GE.CustomMsgType.Equip)
    self.equipInfoView.gameObject:SetActive(data.type == GE.CustomMsgType.Equip)

    self.weaponMode.gameObject:SetActive(data.type == GE.CustomMsgType.Weapon)
    self.weaponInfoView.gameObject:SetActive(data.type == GE.CustomMsgType.Weapon)
    self.weaponTypeIcon.gameObject:SetActive(data.type == GE.CustomMsgType.Weapon)

    self.middleline:SetActive(data.type ~= GE.CustomMsgType.Item)
    if data.type == GE.CustomMsgType.Weapon then
        self:SetWeaponView(data.config, data.Id)
    elseif data.type == GE.CustomMsgType.Equip then
        self:SetEquipView(data.config, data.Id)
    elseif data.type == GE.CustomMsgType.Item then
        self:SetItemView(data.config, data.Id, data.navType)
    end
    self.ownerPanelName = data.ownerPanelName
end

---设置 mono 对象引用
---@param mono table 父节点对象
function CustomTips:setMono(mono)
    self.mono = mono
end

function CustomTips:FillTemplateContent(...)
    if self.mono == nil then
       return nil 
    end
    return self.mono:FillTemplateContent(...)
end

function CustomTips:LoadSpriteAsync(...)
    if self.mono == nil then
       return nil 
    end
    return self.mono:LoadSpriteAsync(...)
end

--设置武器 信息显示
---@param configData WeaponTable
---@param Id integer
function CustomTips:SetWeaponView(configData, Id)
    local serverData = Me:getWeaponDataById(Id)
    if serverData == nil then
       	return
    end
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
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponTypePath, configData.type), function (s)
        self:LoadSpriteFinish(self.weaponTypeIcon, s)
    end)
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
    self.weaponSpecialTitleInfo:SetActive(false)
    self.weaponSkillTxt.gameObject:SetActive(false)
    self:FillTemplateContent(self.attributeBox, self.weaponAttributeList, #configData.entryUnlock, function(index, attributeBox)
        local boxData = {
            boxType = GE.ItemTypeIndex.weapon,
            attrData = needAttrList[index],
            weaponConfig = configData,
            weaponData = serverData,
            boxIndex = index,
        }
        local lua_attributeBox = AttributeBox:new(attributeBox.gameObject)
        lua_attributeBox:InitGenerate()
        lua_attributeBox:setMono(self)
        lua_attributeBox:setAttrBoxData(boxData)
        if needAttrList[index] then
            if needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
                self.weaponSpecialTitleInfo:SetActive(true)
                self.weaponSkillTxt.gameObject:SetActive(true)
                local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                self.weaponSkillTxt.text.text = skillConfig.desKey
            end
        end
    end)
    self:LoadSpriteAsync(string.format(Config.SpritePath.itemRankLine, configData.rare), function (s)
        self:LoadSpriteFinish(self.rankImgBg, s)
    end)
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, configData.icon), function (s)
        self:LoadSpriteFinish(self.itemIcon, s)
    end)
    self.lockBtn.scaleButton.onClick:RemoveAllListeners()
    self.lockBtn.scaleButton.onClick:AddListener(function()
        Me:changeWeaponLockStateReq({weaponId = serverData.id}, function()
            local newData = Me:getWeaponDataById(Id)
            self:setIsLock(newData.isLock)
            if self.lockCallBack ~= nil then
                self.lockCallBack() 
            end
        end)
    end)
end

--设置装备 信息显示
---@param configData EquipmentTable
---@param Id integer
function CustomTips:SetEquipView(configData, Id)
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

    local isNormal = type ~= GE.EquipType.rankUp
    self.titleInfo.gameObject:SetActive(not isNormal)
    self.titleBg.gameObject:SetActive(isNormal)
    self.equipAttributeList.gameObject:SetActive(isNormal)
    self.empty.gameObject:SetActive(isNormal)
    self.specialTitleBg.gameObject:SetActive(isNormal)
    self.equipSkillMsgTxt.gameObject:SetActive(isNormal)
    

    self.nameTxt.text.text = configData.name
    self:LoadSpriteAsync(string.format(Config.SpritePath.itemRankLine, configData.quality), function (s)
        self:LoadSpriteFinish(self.rankImgBg, s)
    end)
    self:LoadSpriteAsync(string.format(Config.SpritePath.EquipIconPath, configData.icon), function (s)
        self:LoadSpriteFinish(self.itemIcon, s)
    end)
    self.lockBtn.scaleButton.onClick:RemoveAllListeners()
    self.lockBtn.scaleButton.onClick:AddListener(function()
        Me:changeEquipLockStateReq({equipId = serverData.id}, function()
            local newData = Me:getEquipDataByid(Id)
            self:setIsLock(newData.isLock)
            if self.lockCallBack ~= nil then
                self.lockCallBack()
            end
        end)
    end)

    self.partName.text.text = configData.dec
    self.equipLevelTxt.text.text = "Lv."..serverData.level
    
    local startList = self.equipStarList
    for i = 1, 6 do
        startList["star_"..i].starOn:SetActive(i <= serverData.star)
    end
    self.equipMsgTxt.gameObject:SetActive(not isNormal)
    if isNormal then
        local str = LocalStrEnum.ActionFailReason_EquipLevelUpTips
        local nowEffectId = Me:getEquipEffectIdByid(serverData.id)
        local nowEffectStage = Me:getEquipEffectStageByid(serverData.id)
        local equipSkill = configData.skill
        local skillConfig = {}
        if nowEffectId == nil and tablex.next(equipSkill) == nil then
            self.nullEffect:SetActive(true)
            self.hasEffect:SetActive(false)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = ""
            self.equipSkillMsgTxt:SetActive(false)
        elseif nowEffectId == nil and tablex.next(equipSkill) ~= nil then
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = string.format(str, configData.unLockSkillLv[1])
            self.equipSkillMsgTxt:SetActive(true)
            local nextEffectId = equipSkill[1] or 0
            skillConfig = Config.GetSkillInfo(nextEffectId)
            local c1 = self.equipSkillMsgTxt.text.color
            self.equipSkillMsgTxt.text.color = Color.New(c1.r, c1.g, c1.b, 0.65)
        else
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            self.effectLevel.text.text = romanNumerals[nowEffectStage].." "..LocalStrEnum.AffectionLevel
            self.effectLevelMsg.text.text = ""
            self.equipSkillMsgTxt:SetActive(true)
            skillConfig = Config.GetSkillInfo(nowEffectId)
            local c2 = self.equipSkillMsgTxt.text.color
            self.equipSkillMsgTxt.text.color = Color.New(c2.r, c2.g, c2.b, 1)
        end
        if skillConfig then
            self.equipSkillMsgTxt.text.text = skillConfig.desKey
        else
            self.equipSkillMsgTxt.text.text = ""
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
        self:FillTemplateContent(self.attributeBox, self.equipAttributeList, tablex.size(temp), function(index, attributeBox)
            local boxData = {
                boxType = GE.ItemTypeIndex.equip,
                attrData = temp[index],
                boxIndex = index,
            }
            ---@type AttributeBox
            local lua_attributeBox = AttributeBox:new(attributeBox.gameObject)
            lua_attributeBox:InitGenerate()
            lua_attributeBox:setMono(self)
            lua_attributeBox:setAttrBoxData(boxData)
        end)
        self.equipMsgTxt.text.text = configData.equipDes
    else
        self.equipMsgTxt.text.text = configData.equipDes
    end
end

--设置道具 信息显示
---@param configData ItemTable  道具配置表
---@param Id integer  道具服务器数据 可能为空
---@param navType GE.NavigationType  导航类型
function CustomTips:SetItemView(configData, Id, navType)
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
    self.itemCountText.text.text = tostring(itemCount)

    self.nameTxt.text.text = configData.itemName
    self.itemMsgTxt.text.text = configData.describe
    self:LoadSpriteAsync(string.format(Config.SpritePath.itemRankLine, configData.quality), function (s)
        self:LoadSpriteFinish(self.rankImgBg, s)
    end)
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, configData.icon), function (s)
        self:LoadSpriteFinish(self.itemIcon, s)
    end)
    --获取途径
    local showWay = false
    local showNeedNum = 0
    local wayList = {}
    if navType then
        local info = Config.GetFunctionTabInfo(navType)
        if info then
            if info.IsJump == 1 or (info.ResourcesIsJump == 1 and self.data.isResources == true) then
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
        self:FillTemplateContent(self.getActiveBox, self.getActiveInfo, tablex.size(wayList), function (index, itemObj)
            ---@type CustomTipsMsgPanel_Generate_getActiveBox
            local itemObj = itemObj
            local skipInfo = Config.SkipFuncInfo(wayList[index])

            itemObj.gameObject:SetActive(skipInfo ~= nil)
            if skipInfo == nil then
               return 
            end
      
            itemObj.channelTxt.text.text = skipInfo.desc
            local canUseSkip, showBtn = UICommonUtils.CanUseSkipJudge(skipInfo.id, false)
            itemObj.scaleButton.onClick:RemoveAllListeners()
            itemObj.goBtn:SetActive(showBtn)
            if canUseSkip == false then
                itemObj.isLock:SetActive(true)
            else
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
                if self.mono and self.mono.uiConfig and self.mono.uiConfig.id == "CustomTipsMsgPanel" then
                    UIMgr:closeSpecificUI(self.mono)
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
        end)
    end
    if showWay then
        self.itemMsgTxt.text.text = configData.describe .. "\n\n"
    end
    self.getTitleBox:SetActive(showWay)
    self.getActiveInfo:SetActive(showWay)
end

--设置跳转前的回调
---@param func function 回调函数
function CustomTips:SetBeforeTruntoFunc(func)
    self.beforeTruntoFunc = func
end

--设置锁定显示
---@param state boolean 是否锁定
function CustomTips:setIsLock(state)
    self.isLock:SetActive(state)
end

function CustomTips:clearCallBack()
    self.lockCallBack = nil
end

function CustomTips:OnDestroy()
    self.destroyed = true
end

function CustomTips:OnClose()
end

---@param table {image: UnityEngine.UI.Image, gameObject:UnityEngine.GameObject}
---@param sprite UnityEngine.Sprite
function CustomTips:LoadSpriteFinish(table, sprite)
    if self.destroyed then
        LuaLogger.es("tips 已经被删除")
        return
    end
    if table == nil then
        LuaLogger.es("table == nil")
        return 
    end
    if IsNull(table.image) then
        LuaLogger.es("image == null")
        return
    end
    if IsNull(table.gameObject) then
       return 
    end
    if IsNull(sprite) then
        LuaLogger.es("sprite == null  name:" .. table.gameObject.name)
        return
    end
    table.image.sprite = sprite
end

--[[
/lockBtn onClick 
--]]
function CustomTips:lockBtn_ScaleButton_onClick(lockBtn)

end

return CustomTips
