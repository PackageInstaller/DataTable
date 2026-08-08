---@class LackItemTipsPanel : LackItemTipsPanel_Generate
---##################### 【LackItemTipsPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LackItemTipsPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LackItemTipsPanel = require "LackItemTipsPanel_Generate"
local sel = require("client.Main.Assets.Content.Lua.UI.Common.TechTreeNode_Generate").sel

function LackItemTipsPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.CustomBackPanelMainClick, self.hide},
        {GameMsgType.CustomBackPanelBackClick, self.hide},
        {GameMsgType.ItemMapNtf, self.refreshUI},
    }
end

--function LackItemTipsPanel:StartCreating(time)
--
--end

--function LackItemTipsPanel:StartEnter(time)
--
--end

--function LackItemTipsPanel:StartRemoving(time)
--
--end

--function LackItemTipsPanel:StartExit(time)
--
--end

function LackItemTipsPanel:OnOpen(data, initiative)
    self.boxBg:SetActive(false)
    self.itemId = data.itemId
    self.needNum = data.needNum
    self.itemCfg = Config.GetItemInfo(self.itemId)
    local isHide = false
    if not self.itemCfg then
        isHide = true
    end
    local uiData = UIMgr:getUIData("GiftUsePanel")
    if uiData and not uiData.bClose and not uiData.isHide then
        isHide = true
    end
    uiData = UIMgr:getUIData("HomelandShopPanel")
    if uiData and not uiData.bClose and not uiData.isHide then
        isHide = true
    end
    if isHide then
        self:hide()
        return
    end
    self.boxBg:SetActive(true)
    --self.nameText.text.text = self.itemCfg.itemName
    --self.nameText.marqueeText:SetFullText(self.itemCfg.itemName)
    self.textMask.marqueeText:SetFullText(self.itemCfg.itemName)
    self.customBox.customBox:setMono(self)
    self.customBox.customBox:SetUIData({
        id = self.itemId,
        type = GE.RewardType.ItemProp,
    })
    self:refreshUI()
end

function LackItemTipsPanel:refreshUI()
    self.curNum = Me:getItemNumById(self.itemId)
    if self.curNum < self.needNum then
        self.lackNumText:SetActive(true)
        self.fullText:SetActive(false)
        self.lackNumText.text.text = self.needNum - self.curNum
    else
        self.customBox.customBox:setMono(self)
        self.customBox.customBox:SetUIData({
            id = self.itemId,
            type = GE.RewardType.ItemProp,
        }, {
            isGet = true,
        })
        self.lackNumText:SetActive(false)
        self.fullText:SetActive(true)
    end
end

function LackItemTipsPanel:hide()
    UIMgr:closeSpecificUI(self)
end

--function LackItemTipsPanel:OnClose(initiative)
--
--end

--function LackItemTipsPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function LackItemTipsPanel:OnRefresh(data)
--
--end

return LackItemTipsPanel
