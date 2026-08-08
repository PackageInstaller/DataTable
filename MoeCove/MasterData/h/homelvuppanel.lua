---@class HomeLvUpPanel : HomeLvUpPanel_Generate
---##################### 【HomeLvUpPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeLvUpPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeLvUpPanel = require "HomeLvUpPanel_Generate"

function HomeLvUpPanel:InitLogic(data)

 self.msgEventHandler = {
        {GameMsgType.BuildingLevelUpDissolveEffectPlayFinish, self.OnLevelUpPlayFinish},
    }
end

--function HomeLvUpPanel:StartCreating(time)
--
--end

--function HomeLvUpPanel:StartEnter(time)
--
--end

--function HomeLvUpPanel:StartRemoving(time)
--
--end

--function HomeLvUpPanel:StartExit(time)
--
--end

---@class HomeLvUpPanelData
---@field constuctId number 建筑类型ID
---@field homeType HomeFuncType

function HomeLvUpPanel:OnOpen(data, initiative)
    self.constuctId = data.constuctId
    self.homeType = data.homeType
    self.maxLv = Me:getHomeBuildingMaxLevel(self.constuctId)
    if initiative then
        self.main:SetActive(true)
        self.upSec:SetActive(false)
    end
    self:refreshData()
    self:refreshUI()
    GuideMgr:StartGuideTrigger("HomeLvUpPanel")
    self.customMsgPanel:SetActive(false)
    if StoryMgr:getNeedShowHomeLvUpPanel() then
        StoryMgr:setNeedShowHomeLvUpPanel(false)
        self:showUp()
    end
end

function HomeLvUpPanel:refreshData()
    ---@type ConstructionTable
    self.constructCfg = Config.GetConstructionInfo(self.constuctId)
    self.constructData = Me:getConstructionDataById(self.constuctId)
    if not self.constructData then
        LuaLogger.e("constructData is nil")
        return
    end
    if self.constructData.level == 0 then
        self.constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(self.constuctId, 1)
    else
        self.constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(self.constuctId, self.constructData.level)
    end
end

function HomeLvUpPanel:refreshUI()
    --local imgPath = string.format(Config.SpritePath.HomeIcon, self.constuctId)
    --self.titleText.text.text = self.constructCfg.name

    if not self.constructData then
        LuaLogger.e("constructData is nil, please check")
        return
    end
    if self.constructData.level >= self.maxLv then
        self.upContent:SetActive(false)
        self.maxTag:SetActive(true)
        self.oneLvState:SetActive(true)
        self.twoLvState:SetActive(false)

        self.effectDis1:SetActive(false)
        self.effectDis2:SetActive(false)
        self.effectDis3:SetActive(true)
        self.oneLvState.lvText.text.text = self.constructData.level
        self.oneLvState.lvTextShadow.text.text = self.constructData.level
        self.effectDis3.content1.text.text = self.constructLvCfg.describe
        return
    end
    self.maxTag:SetActive(false)
    self.upContent:SetActive(true)

    self.nextConstructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(self.constuctId, self.constructData.level + 1)

    if self.constructData.level == 0 then
        self.oneLvState:SetActive(true)
        self.twoLvState:SetActive(false)

        self.effectDis1:SetActive(true)
        self.effectDis2:SetActive(false)
        self.effectDis3:SetActive(false)
        self.oneLvState.lvText.text.text = self.constructData.level + 1
        self.oneLvState.lvTextShadow.text.text = self.constructData.level + 1
        self.effectDis1.content1.text.text = self.nextConstructLvCfg.describe
    else
        self.oneLvState:SetActive(false)
        self.twoLvState:SetActive(true)

        self.effectDis1:SetActive(false)
        self.effectDis2:SetActive(true)
        self.effectDis3:SetActive(false)
        self.twoLvState.lvText.text.text = self.constructData.level
        self.twoLvState.lvTextShadow.text.text = self.constructData.level
        self.twoLvState.lvText2.text.text = self.constructData.level + 1
        self.twoLvState.lvTextShadow2.text.text = self.constructData.level + 1
        self.effectDis2.content1.text.text = self.constructLvCfg.describe
        self.effectDis2.content2.text.text = self.nextConstructLvCfg.describe
    end
    self:FillTemplateContent(self.customBox, self.propList, tablex.size(self.nextConstructLvCfg.cost), function (index, itemObj)
        local cfg = self.nextConstructLvCfg.cost[index]
        local customBox = itemObj.customBox
        customBox:setMono(self)
        customBox:SetUIData(cfg, {navType = GE.NavigationType.HomeLvUpPanel})
        customBox:updateItemNum(string.format("%s/%s", Me:getItemNumById(cfg[2]), cfg[3]))
        -- local num = Me:getItemNumById(cfg[2])
        -- if cfg[3] > num then
        --     local text = customBox.itemNum.text.text
        --     customBox.itemNum.text.text = string.format("<color=red>%s</color>", text)
        -- end

    end)

    local consumeId = self.nextConstructLvCfg.costResource[2] or 0
    local curNum = Me:getItemNumById(consumeId)
    local needNum = self.nextConstructLvCfg.costResource[3] or 0
    local showRed = curNum < needNum and true or false
    curNum = UICommonUtils.FormatNumber(curNum)
    needNum = UICommonUtils.FormatNumber(needNum)
    if showRed then
        self.resCount.text.text = string.format("<color=red>%s</color>/%s", curNum, needNum)
    else
        self.resCount.text.text = string.format("%s/%s", curNum, needNum)
    end

    local canLvUp = self:CheckCanLvUp()
    self.upBtn.gameObject:SetActive(canLvUp)
    self.upBtn_2.gameObject:SetActive(not canLvUp)

end

function HomeLvUpPanel:showUp()
    --如果在家园剧情中则不播放，剧情播放完成后会主动调用showUp方法
    LuaLogger.ds("播放升级 特效:" .. tostring(StoryMgr:getIsHomeLandStory()))
    if StoryMgr:getIsHomeLandStory() then
        return
    end

    self.mask.gameObject:SetActive(true)
    self.constructData = Me:getConstructionDataById(self.constuctId)
    local lvCfg = Config.GetConstructionLevelInfoByTypeLevel(self.constuctId, self.constructData.level)  



    self.upSec.lv1.text.text = self.constructData.level - 1
    self.upSec.lv2.text.text = self.constructData.level
    local produceRoom = false
    ---@type ConstructionLevelTable
    local cfg = self.constructLvCfg
    if cfg ~= nil and cfg.effect ~= nil and tablex.findSingle(cfg.effect, function(a)
        return a ~= nil and a[1] == 1
    end) ~= nil then
        produceRoom = true
    end
    if produceRoom then
        self.upSec.desc:SetActive(false)
        self.upSec.resouce:SetActive(true)
        local itemId, baseNum = 0, 0
        local baseEfficiency = Me:getHomeOutputBaseEfficiency(self.constuctId,self.constructData.level - 1)
        if baseEfficiency[1] then
            itemId = baseEfficiency[1][2]
            local itemCfg = Config.GetItemInfo(itemId)
            if not itemCfg then
                LuaLogger.e("itemCfg is nil, itemId:"..itemId)
            else
                self.upSec.resouce.name1.text.text = itemCfg.itemName
            end
            baseNum = baseEfficiency[1][3]
            self.upSec.resouce.num1.text.text = baseNum .."/h"
        end
        local baseEfficiency = Me:getHomeOutputBaseEfficiency(self.constuctId,self.constructData.level)
        if baseEfficiency[1] then
            itemId = baseEfficiency[1][2]
            local itemCfg = Config.GetItemInfo(itemId)
            if not itemCfg then
                LuaLogger.e("itemCfg is nil, itemId:"..itemId)
            else
                self.upSec.resouce.name2.text.text = itemCfg.itemName
            end
            baseNum = baseEfficiency[1][3]
            self.upSec.resouce.num2.text.text = baseNum .."/h"
        end
        if self.constructData.level == 0 then
            self.upSec.resouce.num1.text.text = 0 .."/h"
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..itemId), function (s)
            self.upSec.resouce.icon1.image.sprite = s
            self.upSec.resouce.icon2.image.sprite = s
        end)
    else
        self.upSec.desc:SetActive(true)
        self.upSec.resouce:SetActive(false)
        self.upSec.desc.text.text = lvCfg.describe
    end
    
    for i = 1, 4 do
        self["img"..i].canvas.sortingLayerName = "UI"
        self["img"..i].canvas.sortingOrder = 10
    end

    self.main:SetActive(false)
    self.upSec:SetActive(true)

    local btnSoundPath = string.format(Config.AudioPath.SE, "gacha_new")
    self:play2DSound(btnSoundPath)
end

--function HomeLvUpPanel:OnClose(initiative)
--
--end

--function HomeLvUpPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomeLvUpPanel:OnRefresh(data)
--
--end

--[[
/Main/UpContent/UpBtn onClick 
--]]

---@return boolean, string?
function HomeLvUpPanel:CheckCanLvUp()

    --检测道具数量
    local consumeId = self.nextConstructLvCfg.costResource[2]
    local curNum = Me:getItemNumById(consumeId)
    local needNum = self.nextConstructLvCfg.costResource[3]
    if curNum < needNum then
        local itemCfg = Config.GetItemInfo(consumeId)
        return false,  string.format(LocalStrEnum.merchandiseBuyTip_1, itemCfg.itemName)
    end

    --检测是否可以升级
    if not Me:canOpenFunctionByCfg(self.nextConstructLvCfg.restrain) then
        return false, self.nextConstructLvCfg.restraindes
    end

    for k, v in pairs(self.nextConstructLvCfg.cost) do
        local cfg = v
        local id =  cfg[2]
        local itemNum = cfg[3]
      
        local num = Me:getItemNumById(id)
        if num < itemNum then
            local itemCfg = Config.GetItemInfo(id)
            return false, string.format(LocalStrEnum.merchandiseBuyTip_1, itemCfg.itemName)
        end
    end
    return true
end

function HomeLvUpPanel:upBtn_ScaleButton_onClick(upBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    
    local canLvUp, tips = self:CheckCanLvUp()
    if not canLvUp then
        UICommonUtils.PopToast(tips)
        return
    end
    self.main:SetActive(false)
    self.mask.gameObject:SetActive(false)
    Me:HomeLvUpReq({
        constructionId = self.constuctId
    }, function (data)
        if data.ret == 0 then
            GameMsgMgr:sendEvent(GameMsgType.BulidingLvChange, self.constuctId)
            GameMsgMgr:sendEvent(GameMsgType.RefreshHomeFuncPanel)

            --self:showUp()
        end
    end)
end

--[[
/Bg onClick 
--]]
function HomeLvUpPanel:mask_Button_onClick(bg)
    self:playCloseAnim()
    GuideMgr:StartGuideTrigger("HomeFuncPanel")
end

--[[
/Main/Bg/CloseBtn onClick 
--]]
function HomeLvUpPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:playCloseAnim()
end

--[[
/UpSec onClick 
--]]
function HomeLvUpPanel:upSec_Button_onClick(upSec)

end

--[[
/UpMsgView onClick 
--]]
function HomeLvUpPanel:upMsgView_Button_onClick(upMsgView)

end

--[[
/UpMsgView/SkillBg/SkillBox/Btn onClick 
--]]
function HomeLvUpPanel:btn_ScaleButton_onClick(btn)

end

--[[
/Main/UpContent/UpBtn_2 onClick 
--]]
function HomeLvUpPanel:upBtn_2_ScaleButton_onClick(upBtn_2)
    self:upBtn_ScaleButton_onClick(upBtn_2)
end

function HomeLvUpPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end


function HomeLvUpPanel:OnLevelUpPlayFinish(buildId)
    if self.constuctId ~= buildId then
       return 
    end
    self:showUp()
end

return HomeLvUpPanel
