---@class SkillChangePanel : SkillChangePanel_Generate
---##################### 【SkillChangePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillChangePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillChangePanel = require "SkillChangePanel_Generate"

function SkillChangePanel:InitLogic(data)
    self.skillObjList = {}                      --普通技能格子列表
    self.equipSkillObjList = {}                 --装备技能格子列表

    self.nowSelectEqiupBoxIndex = nil           --当前选择的已装备技能格子
    self.nowSelectIndex = nil                   --当前选择的普通技能格子
    self.nowData = nil
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function SkillChangePanel:StartCreating(time)
--
--end

--function SkillChangePanel:StartEnter(time)
--
--end

--function SkillChangePanel:StartRemoving(time)
--
--end

--function SkillChangePanel:StartExit(time)
--
--end

function SkillChangePanel:OnOpen(data, initiative)
    if data then
        self.roleData = Me:getPlayerHero(data.roleCid)
        self.nowSelectEqiupBoxIndex = data.index
        self.nowSelectIndex = nil
        self.nowData = nil
        -- 面板复用时先清空详情，避免残留上一角色的技能内容
        self.skillMsgPanel:SetActive(false)
        self:RefreshSkillObjList()
        self:RefreshEquipSkillObjList()
        self:SetView()
    end
end

function SkillChangePanel:SetView()
    local skillList = Me:getHeroSkillList(self.roleData.id)
    self.nowEquipList = tablex.clone(self.roleData.EquippedSkillList)
    self.nowSelectIndex = nil
    self.nowData = nil
    DLuaUtil.ClearChildren(self.equipSkillList.transform)
    self:FillTemplateContent(self.skillBox, self.equipSkillList, tablex.size(self.nowEquipList), function(index, skillBox)
        skillBox:SetActive(true)
        local temp = {
            obj = skillBox,
            data = self.nowEquipList[index],
            index = index,
        }
        table.insert(self.equipSkillObjList, temp)
        skillBox.transform.localScale = Vector3.New(0.9, 0.9, 1)
        local skillData = self.nowEquipList[index]
        local skillConfig = Config.GetSkillInfo(skillData)
        
        skillBox.isOn:SetActive(skillData ~= 0)
        skillBox.passivity:SetActive(skillConfig and skillConfig.skillType == GE.SkillType.Passive or false)
        
        if skillConfig then
            skillBox.iconImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), skillBox.iconImg.image)
        else
            skillBox.iconImg:SetActive(false)
        end
        
        skillBox.btn.scaleButton.onClick:RemoveAllListeners()
        skillBox.btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.nowSelectEqiupBoxIndex = index
            self.nowSelectIndex = nil
            self:selectBoxById(temp.data)
        end)
    end)
    DLuaUtil.ClearChildren(self.content.transform)
    self:FillTemplateContent(self.skillBox, self.content, tablex.size(skillList), function(index, skillBox)
        skillBox:SetActive(true)
        local skillData = skillList[index]
        local isEquipped = Me:getEquippedSkillIndex(self.roleData.id, skillData) ~= nil
        local skillConfig = Config.GetSkillInfo(skillData)
        skillBox.transform.localScale = Vector3.New(0.9, 0.9, 1)
        local temp = {
            obj = skillBox,
            data = skillData,
            index = index,
            isEquip = isEquipped,
        }
        table.insert(self.skillObjList, temp)

        skillBox.passivity:SetActive(skillConfig.skillType == GE.SkillType.Passive)
        skillBox.isOn:SetActive(true)
        skillBox.isEquip:SetActive(isEquipped)

        skillBox.iconImg:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), skillBox.iconImg.image)

        skillBox.btn.scaleButton.onClick:RemoveAllListeners()
        skillBox.btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.nowSelectEqiupBoxIndex = nil
            self.nowSelectIndex = index
            self:selectBoxById(temp.data)
        end)
    end)

    if self.nowSelectEqiupBoxIndex ~= nil then
        self:selectBoxById(self.nowEquipList[self.nowSelectEqiupBoxIndex])
    else
        self:SetMsgView()
    end
end

--根据id选择已装备和未装备的技能格子
---@param id? integer 技能id
function SkillChangePanel:selectBoxById(id)
    self.nowSelectEqiupBoxIndex = nil
    self.nowSelectIndex = nil
    self.nowData = nil
    for k, v in pairs(self.skillObjList) do
        if v.data == id then
            self.nowSelectIndex = v.index
            break
        end
    end

    for k, v in pairs(self.equipSkillObjList) do
        if v.data == id then
            self.nowSelectEqiupBoxIndex = v.index
            break
        end
    end

    self:SetMsgView()
end

--设置详情显示
function SkillChangePanel:SetMsgView()
    self.nowData = nil
    for _, value in pairs(self.skillObjList) do
        value.obj.isSelect:SetActive(self.nowSelectIndex == value.index)
        if self.nowSelectIndex == value.index then
            self.nowData = value.data
        end
    end

    for _, value in pairs(self.equipSkillObjList) do
        value.obj.isSelect:SetActive(self.nowSelectEqiupBoxIndex == value.index)
        if self.nowSelectEqiupBoxIndex == value.index then
            self.nowData = value.data
        end
    end
    if self.nowData ~= 0 and self.nowData ~= nil then
        self.skillMsgPanel:SetActive(true)
        local skillConfig = Config.GetSkillInfo(self.nowData)
        self.skillMsgPanel.countTxt.text.text = skillConfig.usageNum.."/"..skillConfig.usageNum
        self.skillMsgPanel.skillNameTxt.text.text = skillConfig.nameKey
        self.skillMsgPanel.skillMsgTxt.text.text = skillConfig.desKey
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillrePlacBg, skillConfig.skillType), self.skillMsgPanel.skillrePlaceBox.image)
        self.skillMsgPanel.skillrePlaceBox.skillrePlaceTxt.text.text = skillConfig.skillTypeName
        self.skillMsgPanel.changeBtn:SetActive(false)
        self.skillMsgPanel.rangeBg:SetActive(skillConfig.skillType == GE.SkillType.Active)
        self.skillMsgPanel.countBg:SetActive(skillConfig.skillType == GE.SkillType.Active and skillConfig.usageNum > 0)

        if skillConfig.skillType ~= GE.SkillType.Active then
            self.skillMsgPanel.skillMsgBg.rectTransform.sizeDelta = Vector2.New(self.skillMsgPanel.skillMsgBg.rectTransform.sizeDelta.x, 735)
        else
            self.skillMsgPanel.skillMsgBg.rectTransform.sizeDelta = Vector2.New(self.skillMsgPanel.skillMsgBg.rectTransform.sizeDelta.x, 900)
        end
        self.skillMsgPanel.preCdTxt.text.text = skillConfig.preCdKey
        self.skillMsgPanel.skillRangeTxt.text.text = skillConfig.rangeDes
        self.skillMsgPanel.skillTypeBox_1.typeTxt.text.text = skillConfig.rangeTypeDes
        self.skillMsgPanel.skillTypeBox_2.typeTxt.text.text = skillConfig.skillTypeDes
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillTypeBg, skillConfig.backColorType), self.skillMsgPanel.skillTypeBox_2.image)
        self.skillMsgPanel.iconImg:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self.skillMsgPanel.iconImg.image)
        self.skillMsgPanel.isAnim:SetActive(skillConfig.skillTimeline ~= nil and skillConfig.skillTimeline ~= "")

        self.skillMsgPanel.unEquipBtn:SetActive(self:getEquippedSkillIndex(self.nowData) ~= nil)
        self.skillMsgPanel.equipBtn:SetActive(self:getEquippedSkillIndex(self.nowData) == nil)

        --范围格子显示
        local showConfig = Config.GetSkillRangeShowInfo(skillConfig.rangeShow)
        if showConfig then
            local lengthNum = #showConfig.DefaultParam / showConfig.WidthNum
            local newScale = math.floor(120 / math.max(showConfig.WidthNum, lengthNum)) - 2
            self.skillMsgPanel.skillRangeList.gridLayoutGroup.cellSize = Vector2.New(newScale, newScale)
            self.skillMsgPanel.skillRangeList.gridLayoutGroup.constraintCount = showConfig.WidthNum
            self:FillTemplateContent(self.rangebox, self.skillMsgPanel.skillRangeList, #showConfig.DefaultParam, function (index,rangebox)
                rangebox.rangeIcon1:SetActive(false)
                rangebox.rangeIcon2:SetActive(false)
                rangebox.rangeIcon3:SetActive(false)
                rangebox.rangeIcon4:SetActive(false)
                if showConfig.DefaultParam[index] ~= 0 then
                    rangebox["rangeIcon"..showConfig.DefaultParam[index]]:SetActive(true)
                end
            end)
        end
    else
        self.skillMsgPanel:SetActive(false)
    end
end

--获取技能装备位置
function SkillChangePanel:getEquippedSkillIndex(skillid)
    for key, value in pairs(self.nowEquipList) do
        if skillid == value then
            return key
        end
    end
    return nil
end

--更新列表显示
function SkillChangePanel:UpdateListView()
    local skillList = Me:getHeroSkillList(self.roleData.id)
    --更新显示
    for _, v in pairs(self.equipSkillObjList) do
        if v.data ~= 0 then
            local skillData = Config.GetSkillInfo(v.data)
            v.obj.passivity:SetActive(skillData.skillType == GE.SkillType.Passive)
            v.obj.isOn:SetActive(true)
            v.obj.iconImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillData.icon), v.obj.iconImg.image)
        else
            v.obj.passivity:SetActive(false)
            v.obj.isOn:SetActive(false)
        end
    end
    for k, v in pairs(self.skillObjList) do
        v.obj.isEquip:SetActive(v.isEquip)
    end
    self:selectBoxById(skillList[self.nowSelectIndex])
end

--刷新技能格子列表
function SkillChangePanel:RefreshSkillObjList()
    if self.skillObjList and next(self.skillObjList) then
        for _, v in pairs(self.skillObjList) do
            GameObject.Destroy(v.obj)
        end
    end
    self.skillObjList = {}
end

--刷新已装备技能格子列表
function SkillChangePanel:RefreshEquipSkillObjList()
    if self.equipSkillObjList and next(self.equipSkillObjList) then
        for _, v in pairs(self.equipSkillObjList) do
            GameObject.Destroy(v.obj)
        end
    end
    self.equipSkillObjList = {}
end

--function SkillChangePanel:OnClose(initiative)
--
--end

--function SkillChangePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkillChangePanel:OnRefresh(data)
--
--end

--[[
/ImgBg onClick 
--]]
function SkillChangePanel:imgBg_Button_onClick(imgBg)
    self:play2DSound(self.btnSoundPath)
    local temp = {
        roleId = self.roleData.id,
        skillList = self.nowEquipList
    }

    Me:equipRoleSkillReq(temp, function()
        UIMgr:closeUI(self)
        
        local FormationPanel = UIMgr:GetUI("FormationPanel")
        if FormationPanel then
            FormationPanel:RefreshSkillView()
        end
        GameMsgMgr:sendEvent(GameMsgType.HeroSkillChange)
    end)
end

--[[
/SkillListBg/AllUnEquipBtn onClick 
--]]
function SkillChangePanel:allUnEquipBtn_ScaleButton_onClick(allUnEquipBtn)
    self:play2DSound(self.btnSoundPath)
    for k, v in pairs(self.nowEquipList) do
        self.nowEquipList[k] = 0
        self.equipSkillObjList[k].data = 0
        for key, value in pairs(self.skillObjList) do
            self.skillObjList[key].isEquip = false
        end
    end
    self:UpdateListView()
end

--[[
/SkillListBg/OkBtn onClick 
--]]
function SkillChangePanel:okBtn_ScaleButton_onClick(okBtn)
    self:play2DSound(self.btnSoundPath)
    local temp = {
        roleId = self.roleData.id,
        skillList = self.nowEquipList
    }
    Me:equipRoleSkillReq(temp, function()
        UICommonUtils.PopToast("更换成功")
        UIMgr:closeUI(self)
        
        ---@type FormationPanel
        local FormationPanel = UIMgr:GetUI("FormationPanel")
        if FormationPanel then
            FormationPanel:RefreshSkillView()
        end

        GameMsgMgr:sendEvent(GameMsgType.HeroSkillChange)
    end)
end

--[[
/MsgBg/EquipBtn onClick 
--]]
function SkillChangePanel:equipBtn_ScaleButton_onClick(equipBtn)
    self:play2DSound(self.btnSoundPath)
    local isMax = true

    for k, v in pairs(self.nowEquipList) do
        if v == self.nowData then
            return
        end
        if v == 0 then
            isMax = false
            self.nowEquipList[k] = self.nowData
            self.equipSkillObjList[k].data = self.nowData
            for key, value in pairs(self.skillObjList) do
                if value.data == self.nowData then
                    self.skillObjList[key].isEquip = true
                end
            end
            break
        end
        
    end

    if isMax then
        UICommonUtils.PopToast("携带的技能已达上限")
        return
    end

    self:UpdateListView()
end

--[[
/MsgBg/UnEquipBtn onClick 
--]]
function SkillChangePanel:unEquipBtn_ScaleButton_onClick(unEquipBtn)
    self:play2DSound(self.btnSoundPath)
    for k, v in pairs(self.nowEquipList) do
        if v == self.nowData then
            self.nowEquipList[k] = 0
            self.equipSkillObjList[k].data = 0
            for key, value in pairs(self.skillObjList) do
                if value.data == v then
                    self.skillObjList[key].isEquip = false
                end
            end
            break
        end
    end
    self:UpdateListView()
end

--[[
/SkillBox/Btn onClick 
--]]
function SkillChangePanel:btn_ScaleButton_onClick(btn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgBg/ChangeBtn onClick 
--]]
function SkillChangePanel:changeBtn_ScaleButton_onClick(changeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgPanel/SkillMsgBg/SkillMsgList onClick 
--]]
function SkillChangePanel:skillMsgList_ScaleButton_onClick(skillMsgList)
    self:play2DSound(self.btnSoundPath)
    local data = {
        skillId = self.nowData,
        target = self.skillMsgPanel.skillMsgBg,
    }
    UIMgr:popUICover("SkillInfoListPanel", data)
end

--[[
/Mask onClick 
--]]
function SkillChangePanel:mask_Button_onClick(mask)
    LuaLogger.ds("SkillChangePanel:mask_Button_onClick")
    self:play2DSound(self.btnSoundPath)
    local temp = {
        roleId = self.roleData.id,
        skillList = self.nowEquipList
    }

    Me:equipRoleSkillReq(temp, function()
        UIMgr:closeUI(self)
        
        local FormationPanel = UIMgr:GetUI("FormationPanel")
        if FormationPanel then
            FormationPanel:RefreshSkillView()
        end
        GameMsgMgr:sendEvent(GameMsgType.HeroSkillChange)
    end)
end

return SkillChangePanel
