---@class SkillMsgPanel : SkillMsgPanel_Generate
---##################### 【SkillMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillMsgPanel = require "SkillMsgPanel_Generate"

function SkillMsgPanel:InitLogic(data)
    self.uiModeType = {
        ["normal"] = 1, --普通模式
        ["hankBook"] = 2, --图鉴模式
        ["character"] = 3, --角色模式
    }
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.mono = self
end

---设置 mono 对象引用
---@param mono table 父节点对象
function SkillMsgPanel:setMono(mono)
    self.mono = mono
end

---统一通过 mono 加载图片资源
---@param path string
---@param callBack function
function SkillMsgPanel:loadSprite(path, callBack)
    if self.mono and self.mono.LoadSpriteAsync then
        self.mono:LoadSpriteAsync(path, callBack)
        return
    end
    self:LoadSpriteAsync(path, callBack)
end

---@class SkillMsgPanelData
---@field skillId integer 技能ID
---@field roleCid integer? 角色CID
---@field index integer? 技能索引
---@field uiMode string? 界面模式，normal:普通模式，hankBook:图鉴模式

---@param data SkillMsgPanelData
---@param noChange boolean?  是否不允许更换技能
function SkillMsgPanel:setSkillMsgView(data, noChange)
    LuaLogger.ds("data",tablex.dump(data))
    self.skillId = data.skillId
    local skillConfig = Config.GetSkillInfo(data.skillId)
    self.countTxt.text.text = skillConfig.usageNum.."/"..skillConfig.usageNum
    self.skillNameTxt.text.text = skillConfig.nameKey
    self.skillMsgTxt.text.text = skillConfig.desKey
    self:loadSprite(string.format(Config.SpritePath.SkillrePlacBg, skillConfig.skillType), function (s)
        self.skillrePlaceBox.image.sprite = s
    end)
    self.skillrePlaceBox.skillrePlaceTxt.text.text = skillConfig.skillTypeName
    local isActiveLikeSkill = skillConfig.skillType == GE.SkillType.Active
        or skillConfig.skillType == GE.SkillType.Preparatory
        or skillConfig.skillType == GE.SkillType.PreparatoryRole
    self.changeBtn:SetActive(skillConfig.skillType ~= GE.SkillType.Talent and not noChange)
    self.rangeBg:SetActive(isActiveLikeSkill)
    self.countBg:SetActive(isActiveLikeSkill and skillConfig.usageNum > 0)
    self.hasLine:SetActive(isActiveLikeSkill)
    if not isActiveLikeSkill then
        self.skillMsgBg.rectTransform.sizeDelta = Vector2.New(self.skillMsgBg.rectTransform.sizeDelta.x, 735)
    else
        self.skillMsgBg.rectTransform.sizeDelta = Vector2.New(self.skillMsgBg.rectTransform.sizeDelta.x, 900)
    end
    self.preCdTxt.text.text = skillConfig.preCdKey
    self.skillRangeTxt.text.text = skillConfig.rangeDes
    self.skillTypeBox_1.typeTxt.text.text = skillConfig.rangeTypeDes
    self.skillTypeBox_2.typeTxt.text.text = skillConfig.skillTypeDes
    self:loadSprite(string.format(Config.SpritePath.SkillTypeBg, skillConfig.backColorType), function (s)
        self.skillTypeBox_2.image.sprite = s
    end)
    self:loadSprite(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), function (s)
        self.iconImg.image.sprite = s
        self.iconImg:SetActive(true)
    end)
    self.isAnim:SetActive(skillConfig.skillTimeline ~= nil and skillConfig.skillTimeline ~= "")

    self.changeBtn.scaleButton.onClick:RemoveAllListeners()
    self.changeBtn.scaleButton.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self:closeSkillMask()
        UIMgr:popUICover("SkillChangePanel", data)
    end)

    --范围格子显示
    local showConfig = Config.GetSkillRangeShowInfo(skillConfig.rangeShow)
    if showConfig then
        local lengthNum = #showConfig.DefaultParam / showConfig.WidthNum
        local newScale = math.floor(120 / math.max(showConfig.WidthNum, lengthNum)) - 2
        self.skillRangeList.gridLayoutGroup.cellSize = Vector2.New(newScale, newScale)
        self.skillRangeList.gridLayoutGroup.constraintCount = showConfig.WidthNum
        self:FillTemplateContent(self.rangebox, self.skillRangeList, #showConfig.DefaultParam, function (index,rangebox)
            rangebox.rangeIcon1:SetActive(false)
            rangebox.rangeIcon2:SetActive(false)
            rangebox.rangeIcon3:SetActive(false)
            rangebox.rangeIcon4:SetActive(false)
            if showConfig.DefaultParam[index] ~= 0 then
                rangebox["rangeIcon"..showConfig.DefaultParam[index]]:SetActive(true)
            end
        end)
    end

    if data.uiMode == self.uiModeType.hankBook then
        self.hasLine:SetActive(false)
        self.changeBtn:SetActive(false)
    elseif data.uiMode == self.uiModeType.character then
        self.hasLine:SetActive(false)
        self.changeBtn:SetActive(false)
    end
end

--唤醒界面显示
---@param data SkillMsgPanelData
---@param noChange boolean?  是否不允许更换
---@param callBack function?
function SkillMsgPanel:showSkillMsg(data, noChange, callBack)
    self:setSkillMsgView(data, noChange)
    self.mask.pointerListener.onPointerClickEvent = function ()
        if (not self.isDraging) then
            if callBack then
                callBack()
            end
            self:closeSkillMask()
        end
    end
    local dragListener = self.mask.dragListener
    dragListener.onBeginDragEvent = function (v2)
        self:_onStartDrag()
    end
    dragListener.onEndDragEvent = function (v2)
        self:_onStopDrag()
    end
    self.mask:SetActive(true)
    self.gameObject:SetActive(true)
end

function SkillMsgPanel:_onStartDrag()
    self.isDraging = true
end
function SkillMsgPanel:_onStopDrag()
    self.isDraging = false
end

function SkillMsgPanel:closeSkillMask()
    self.mask:SetActive(false)
    self.gameObject:SetActive(false)
end

--function SkillMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/SkillMsgBg/EquipBtn onClick 
--]]
function SkillMsgPanel:equipBtn_ScaleButton_onClick(equipBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgBg/ChangeBtn onClick 
--]]
function SkillMsgPanel:changeBtn_ScaleButton_onClick(changeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgBg/UnEquipBtn onClick 
--]]
function SkillMsgPanel:unEquipBtn_ScaleButton_onClick(unEquipBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgBg/SkillMsgList onClick 
--]]
function SkillMsgPanel:skillMsgList_Button_onClick(skillMsgList)
    self:play2DSound(self.btnSoundPath)
    local data = {
        skillId = self.skillId,
        target = self.skillMsgBg
    }
    UIMgr:popUICover("SkillInfoListPanel", data)
end

return SkillMsgPanel
