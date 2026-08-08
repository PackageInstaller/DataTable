---@class SkinGoodsFiltrateBox : SkinGoodsFiltrateBox_Generate
---##################### 【SkinGoodsFiltrateBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkinGoodsFiltrateBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkinGoodsFiltrateBox = require "SkinGoodsFiltrateBox_Generate"

---@class GroupObj:UIObj
local GroupObj = class("SkinGoodsFiltrateBox_GroupObj", UIObj)

function GroupObj:Initialize()
    UIObj.Initialize(self)

    ---@type SkinGoodsFiltrateBox_Generate_itemObj[]
    self.itemObjs = {}
    ---@type SkinGoodsFiltrateBox_Generate_typeListBox
    local peer = self
    peer.tagBtn.button.onClick:AddListener(BindCallback_NoParams(self, self.OnTagBtnClick))

    ---@type SkinGoodsFiltrateBox
    self.ui = self.ui
end

---@param data FiltrateGroupData
function GroupObj:SetData(data)
    self.data = data
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
        return
    end
    ---@type SkinGoodsFiltrateBox_Generate_typeListBox
    local peer = self
    for i = 1, #data.items do
        local itemObj = self.itemObjs[i]
        if itemObj == nil then
            local obj = self.ui.itemObj.gameObject
            itemObj = EngineUtil.Instantiate(obj, peer.itemList.rectTransform)
            itemObj:SetActive(true)
            EngineUtil.FillPeer(self.ui.itemObj, itemObj)
            table.insert(self.itemObjs, itemObj)
        end
        itemObj.toggle.onValueChanged:AddListener(BindCallback(self, self.OnItemToggleValueChange, i))
        local itemData = data.items[i]
        itemObj.nameText.text.text = itemData.itemName
        if not string.isNullOrEmpty(itemData.itemIcon) then
            itemObj.iconImg.gameObject:SetActive(true)
            self.ui:LoadSpriteAsync(itemData.itemIcon, itemObj.iconImg.image)
        else
            itemObj.iconImg.gameObject:SetActive(false)
        end
        if data.selectType == FiltrateSelectType.SingalSelect then
            itemObj.toggle.group = peer.toggleGroup
        else
            itemObj.toggle.group = nil
        end
    end

    for i = 1, #self.itemObjs do
        local itemObj = self.itemObjs[i]
        if i > #data.items then
            itemObj:SetActive(false)
            goto continue
        end
        itemObj:SetActive(true)
        local isOn = data.items[i].isSelect == true
        itemObj.toggle.isOn = isOn
        ::continue::
    end
    peer.tagName.text.text = data.tagName
    self:OnTagBtnClick(true)
end

function GroupObj:OnTagBtnClick(isActive)
    ---@type SkinGoodsFiltrateBox_Generate_typeListBox
    local peer = self
    if isActive == nil then
        isActive = not peer.itemList.gameObject.activeSelf
    end
    peer.itemList.gameObject:SetActive(isActive)
    peer.offIcon:SetActive(isActive)
    peer.onIcon:SetActive(not isActive)
    --TODO 刷新layout
end

function GroupObj:OnItemToggleValueChange(index, isOn)

    if self.isBreakEvent then
       return 
    end
    if self.data.selectType ~= FiltrateSelectType.AllMultiSelect then
       return 
    end

    local isAllFalse = true
    for i = 1,  #self.itemObjs do
        local itemObj = self.itemObjs[i]
        if itemObj.toggle.isOn then
            isAllFalse = false
            break 
        end
    end
    if isAllFalse then
        local itemObj = self.itemObjs[1]
        itemObj.toggle.isOn = true
        return
    end

    if not isOn then
       return 
    end
    
    if index == 1 then      --全部按钮
        for i = 2,  #self.itemObjs do
            local itemObj = self.itemObjs[i]
            itemObj.toggle.isOn = false
        end
    else
        local itemObj = self.itemObjs[1]
        itemObj.toggle.isOn = false
    end
end

---返回选中的筛选条件
---@return integer[]
function GroupObj:GetSelectItem()
    local tab = {}
    for i = 1, #self.data.items do
        local itemObj = self.itemObjs[i]
        if itemObj.toggle.isOn then
            table.insert(tab, i)
        end
    end
    return tab
end
function GroupObj:ResetItemVal()
    self.isBreakEvent = true
    for i = 1, #self.data.items do
        local itemObj = self.itemObjs[i]
        local isDefault = self.data.items[i].isDefault
        itemObj.toggle.isOn = isDefault == true
    end
    self.isBreakEvent = nil
end

---@class FiltrateItemData
---@field itemName string
---@field itemIcon string?
---@field val integer|string|nil 对应值
---@field isDefault boolean? 是否默认值
---@field isSelect boolean? 是否选中 默认false

---@class FiltrateGroupData
---@field tagName string
---@field selectType FiltrateSelectType  1:多选(默认) 2:单选 3:第一个按钮是全部
---@field items FiltrateItemData[]

---@class FiltrateData
---@field groups FiltrateGroupData[]
---@field callback fun(tar:integer[][])

function SkinGoodsFiltrateBox:InitLogic(data)
    ---@type FiltrateData
    self.data = nil

    ---@type GroupObj[]
    self.groupObjs = {}
    self.itemObj.gameObject:SetActive(false)
    self.typeListBox.gameObject:SetActive(false)
end

--function SkinGoodsFiltrateBox:StartCreating(time)
--
--end

--function SkinGoodsFiltrateBox:StartEnter(time)
--
--end

--function SkinGoodsFiltrateBox:StartRemoving(time)
--
--end

--function SkinGoodsFiltrateBox:StartExit(time)
--
--end

---@param data FiltrateData
function SkinGoodsFiltrateBox:OnOpen(data, initiative)

    self.data = data
    for i = 1, #data.groups do
        local groupObj = self.groupObjs[i]
        if groupObj == nil then
            local obj = self.typeListBox.gameObject
            obj = EngineUtil.Instantiate(obj, self.fitrateContent.rectTransform)
            groupObj = GroupObj:Create(obj, self, self.typeListBox)
            table.insert(self.groupObjs, groupObj)
        end
        groupObj:SetData(data.groups[i])
    end

    for i = #data.groups + 1, #self.groupObjs do
        local groupObj = self.groupObjs[i]
        groupObj:SetData(nil)
    end
end

--function SkinGoodsFiltrateBox:OnClose(initiative)
--
--end

--function SkinGoodsFiltrateBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkinGoodsFiltrateBox:OnRefresh(data)
--
--end

--[[
/maskImg onClick 
--]]
function SkinGoodsFiltrateBox:maskImg_Button_onClick(maskImg)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/titleInfo/closeBtn onClick 
--]]
function SkinGoodsFiltrateBox:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/ScrollRect/typeListBox/tagBtn onClick 
--]]
function SkinGoodsFiltrateBox:tagBtn_Button_onClick(tagBtn)

end

--[[
/content/confirmBtn onClick 
--]]
function SkinGoodsFiltrateBox:confirmBtn_ScaleButton_onClick(confirmBtn)
    local a = {}
    for i = 1, #self.groupObjs do
        local tab = self.groupObjs[i]:GetSelectItem()
        table.insert(a, tab)
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.data.callback ~= nil then
       self.data.callback(a) 
    end
    self:playCloseAnim()
end

--[[
/content/cancleBtn onClick 
--]]
function SkinGoodsFiltrateBox:cancleBtn_ScaleButton_onClick(cancleBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/ScrollRect/itemObj onValueChanged 
--]]
function SkinGoodsFiltrateBox:itemObj_Toggle_onValueChanged(itemObj,isOn)

end

--[[
/content/resetBtn onClick 
--]]
function SkinGoodsFiltrateBox:resetBtn_ScaleButton_onClick(resetBtn)
    for i = 1, #self.groupObjs do
        self.groupObjs[i]:ResetItemVal()
    end
end

function SkinGoodsFiltrateBox:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--[[
/Mask onClick 
--]]
function SkinGoodsFiltrateBox:mask_Button_onClick(mask)

end

return SkinGoodsFiltrateBox
