---@class EquipDelFastPanel : EquipDelFastPanel_Generate
---##################### 【EquipDelFastPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipDelFastPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipDelFastPanel = require "EquipDelFastPanel_Generate"

function EquipDelFastPanel:InitLogic(data)
    self.systemId = 3
    self.modeBtnList = {}
    self.NowOpenMode = {}
    self.data = {}
end

--function EquipDelFastPanel:StartCreating(time)
--
--end

--function EquipDelFastPanel:StartEnter(time)
--
--end

--function EquipDelFastPanel:StartRemoving(time)
--
--end

--function EquipDelFastPanel:StartExit(time)
--
--end

function EquipDelFastPanel:OnOpen(data, initiative)
    if initiative then
        self.data = data
        self:SetView()
    end
end

function EquipDelFastPanel:SetView()
    local FilterData = Config.GetFilterInfoBySystem(self.systemId)
    self.modeBtnList = {}
    local temp = {}
    for k,v in pairs(FilterData) do
        if temp[v.type] == nil then
            temp[v.type] = {}
        end
        local msg = {
            type = v.type,
            data = v,
        }
        table.insert(temp[v.type], msg)
    end
    self:FillTemplateContent(self.modeBox, self.modeAllList, tablex.size(temp), function(index, modeBox)
        modeBox:SetActive(true)
        modeBox.selectModeTxt.text.text = LocalStrEnum["filterTypeName"..self.systemId.."_"..temp[index][1].type]
        self:FillTemplateContent(self.modeBtn, modeBox.modeList, tablex.size(temp[index]), function(key, modeBtn)
            modeBtn:SetActive(true)
            table.insert(self.modeBtnList, modeBtn)
            modeBtn.modeNameTxt.text.text = temp[index][key].data.buttonName
            modeBtn.selectNameTxt.text.text = temp[index][key].data.buttonName
            modeBtn.isSelect:SetActive(false)
            modeBtn.scaleButton.onClick:RemoveAllListeners()
            modeBtn.scaleButton.onClick:AddListener(function()
                if self.NowOpenMode[temp[index][key].data.id] then
                    self.NowOpenMode[temp[index][key].data.id] = nil
                    modeBtn.isSelect:SetActive(false)
                else
                    self.NowOpenMode[temp[index][key].data.id] = temp[index][key].data.id
                    modeBtn.isSelect:SetActive(true)
                end
            end)

            for _, value in pairs(self.data) do
                if value == temp[index][key].data.id then
                    self.NowOpenMode[temp[index][key].data.id] = temp[index][key].data.id
                    modeBtn.isSelect:SetActive(true)
                else
                    self.NowOpenMode[temp[index][key].data.id] = nil
                    modeBtn.isSelect:SetActive(false)
                end
            end
        end)
    end)
end

function EquipDelFastPanel:SetData()
    local EquipDelPanel = UIMgr:getUIData("EquipDelPanel")
    if EquipDelPanel then
        EquipDelPanel.ui:SelectFilter(self.NowOpenMode)
    end
end

--function EquipDelFastPanel:OnClose(initiative)
--
--end

--function EquipDelFastPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipDelFastPanel:OnRefresh(data)
--
--end

--[[
/mask onClick 
--]]
function EquipDelFastPanel:mask_Button_onClick(mask)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/Art/TitleBg/CloseBtn onClick 
--]]
function EquipDelFastPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

--[[
/ModeBtn onClick 
--]]
function EquipDelFastPanel:modeBtn_ScaleButton_onClick(modeBtn)

end

--[[
/OkBtn onClick 
--]]
function EquipDelFastPanel:okBtn_ScaleButton_onClick(okBtn)
    self:SetData()
    UIMgr:closeUI(self)
end

--[[
/AllClearBtn onClick 
--]]
function EquipDelFastPanel:allClearBtn_ScaleButton_onClick(allClearBtn)
    for k,v in pairs(self.modeBtnList) do
        v.isSelect:SetActive(false)
    end
    self.NowOpenMode = {}
end

return EquipDelFastPanel
