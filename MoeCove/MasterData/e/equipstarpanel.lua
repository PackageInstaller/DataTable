---@class EquipStarPanel : EquipStarPanel_Generate
---##################### 【EquipStarPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipStarPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipStarPanel = require "EquipStarPanel_Generate"

function EquipStarPanel:InitLogic(data)
    self.data = {}  --{lastStar = 1, newStar = 2, LastLevelLimit = 3, newLevelLimit = 4, LastRankLimit = 5, newRankLimit = 6, equipCid = 123}
    self.equipBox.customBox:setMono(self)
end

--function EquipStarPanel:StartCreating(time)
--
--end

--function EquipStarPanel:StartEnter(time)
--
--end

--function EquipStarPanel:StartRemoving(time)
--
--end

--function EquipStarPanel:StartExit(time)
--
--end

function EquipStarPanel:OnOpen(data, initiative)
    if initiative then
        self.data = data
        self:SetView()
    end
end

function EquipStarPanel:SetView()
    local str = "等级上限  Lv.  "
    local str2 = "效果上限   "
    local romanNumerals = {"I", "II", "III", "IV", "V"}
    for i = 1, self.data.lastStar do
       self.nowStar.starList["star_" .. i].starOn:SetActive(true)
    end
    for i = 1, self.data.newStar do
       self.newStar.starList["star_" .. i].starOn:SetActive(true)
    end
    self.lastLevelLimitTxt.text.text = str..self.data.lastLevelLimit
    self.newLevelLimitTxt.text.text = str..self.data.newLevelLimit
    self.lastRankLimitTxt.text.text = str2..romanNumerals[self.data.LastRankLimit]
    self.newRankLimitTxt.text.text = str2..romanNumerals[self.data.newRankLimit]

    local customData = {
        id          = self.data.equipCid,
        itemType    = GE.ItemTypeIndex.equip,
        scale       = 1,
        star        = self.data.equipStar,
        itemNum     = "Lv."..self.data.equipLevel,
        isLock      = self.data.equipIsLock,
        disableClick = true,
    }
    self.equipBox.customBox:refreshUI(customData)

end

--function EquipStarPanel:OnClose(initiative)
--
--end

--function EquipStarPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipStarPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function EquipStarPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.mask.button.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.mask.button.interactable = true
        UIMgr:closeUI(self)
    end)
end

return EquipStarPanel
