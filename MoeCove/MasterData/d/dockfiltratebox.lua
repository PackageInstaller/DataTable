---@class DockFiltrateBox : DockFiltrateBox_Generate
---##################### 【DockFiltrateBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【DockFiltrateBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local DockFiltrateBox = require "DockFiltrateBox_Generate"

local function copyFiltrateData(src)
    if not src then
        return { TypeList = {0}, RankList = {0}, StarList = {0} }
    end
    local dst = { TypeList = {}, RankList = {}, StarList = {} }
    for _, key in ipairs({ "TypeList", "RankList", "StarList" }) do
        local list = src[key]
        if list then
            for _, v in ipairs(list) do
                table.insert(dst[key], v)
            end
        end
        if #dst[key] == 0 then
            dst[key] = {0}
        end
    end
    return dst
end

---@class DockSaveData
---@field TypeList integer[]
---@field RankList integer[]
---@field StarList integer[]
function DockFiltrateBox:InitLogic(data)
    ---@type DockSaveData
    self.saveData = {
        TypeList = {0},
        RankList = {0},
        StarList = {0},
    }
    self.TypeObjList = {}
    self.RankObjList = {}
    self.StarObjList = {}
end

--function DockFiltrateBox:StartCreating(time)
--
--end

--function DockFiltrateBox:StartEnter(time)
--
--end

--function DockFiltrateBox:StartRemoving(time)
--
--end

--function DockFiltrateBox:StartExit(time)
--
--end

function DockFiltrateBox:OnOpen(data, initiative)
    data = data or {}
    self.saveData = copyFiltrateData(data.filtrateData)
    self.saveBtn:SetActive(data.mode ~= 2)
    self.TypeObjList = {}
    self.RankObjList = {}
    self.StarObjList = {}
    self:SetView()
end

--设置显示初始化
function DockFiltrateBox:SetView()
    self:SetTypeListView()
    self:SetRankListView()
    self:SetStarListView()
end

--生成舰种选项模块
function DockFiltrateBox:SetTypeListView()
    local TypeList = Config.GetAllConfig("CharacterRestraintTable")
    local TypeAllList = {}

    for _, value in pairs(TypeList) do
        if value.isShow == 1 then
            local temp = {
                typeId = value.id,
                name = value.des,
            }
            table.insert(TypeAllList, temp)
        end
    end
    local allData = {
        typeId = 0,
        name = "全部",
    }
    table.insert(TypeAllList, allData)
    table.sort(TypeAllList, function(a, b)
        return a.typeId < b.typeId
    end)
    self:FillTemplateContent(self.typeBox, self.typeListBox.msgList, tablex.size(TypeAllList), function(index, typeBox)
        typeBox:SetActive(true)
        local temp = {
            obj = typeBox,
            data = TypeAllList[index],
        }
        table.insert(self.TypeObjList, temp)
        local nowId = TypeAllList[index].typeId
        typeBox.typeIconOff:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, TypeAllList[index].typeId), typeBox.typeIconOff.image)

        self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, TypeAllList[index].typeId), typeBox.typeIcon.image)

        if self:GetViewBySaveData("TypeList", TypeAllList[index].typeId) then
            typeBox.typeIcon:SetActive(true)
            typeBox.typeIconOff:SetActive(false)
            typeBox.typeName.text.text = "<color=#494949>"..TypeAllList[index].name.."</color>"
        else
            typeBox.typeIcon:SetActive(false)
            typeBox.typeIconOff:SetActive(true)
            typeBox.typeName.text.text = "<color=#A4A4A4>"..TypeAllList[index].name.."</color>"
        end
        typeBox.scaleButton.onClick:RemoveAllListeners()
        typeBox.scaleButton.onClick:AddListener(function()
            local isAllOn, AllKey = self:GetViewBySaveData("TypeList", 0)
            local isNowOn, NowKey = self:GetViewBySaveData("TypeList", nowId)
            if nowId == 0 then
                if not isAllOn then
                    self.saveData["TypeList"] = {0}
                end
            else
                if AllKey then
                    table.remove(self.saveData["TypeList"], AllKey)
                end
                if NowKey then
                    table.remove(self.saveData["TypeList"], NowKey)
                    if tablex.size(self.saveData["TypeList"]) == 0 then
                        self.saveData["TypeList"] = {0}
                    end
                else
                    table.insert(self.saveData["TypeList"], nowId)
                end
            end
            self:ChangeTypeBoxState()
        end)
    end)
end

--生成稀有度选项模块
function DockFiltrateBox:SetRankListView()
    local RankAllList = {
        {typeId = 0, name = "全 部"}, {typeId = 5, name = "SSR"}, {typeId = 4, name = "SR"}, {typeId = 3, name = "R"}, 
    }
    self:FillTemplateContent(self.modeBtn, self.rankListBox.msgList, tablex.size(RankAllList), function(index, modeBtn)
        modeBtn:SetActive(true)
        local temp = {
            obj = modeBtn,
            data = RankAllList[index],
        }
        table.insert(self.RankObjList, temp)
        local nowId = RankAllList[index].typeId
        if nowId == 0 then
            modeBtn.modeNameTxt.text.text = RankAllList[index].name
            modeBtn.selectNameTxt.text.text = RankAllList[index].name
        else
            modeBtn.modeNameTxt.text.text = ""
            modeBtn.isSelect.rankMode:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.RankTypeIconPath, nowId), modeBtn.isSelect.rankIcon.image)
            modeBtn.rankMode:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.RankTypeIconPath, nowId), modeBtn.rankIcon.image)
        end
        if self:GetViewBySaveData("RankList", nowId) then
            modeBtn.isSelect:SetActive(true)
        else
            modeBtn.isSelect:SetActive(false)
        end
        modeBtn.scaleButton.onClick:RemoveAllListeners()
        modeBtn.scaleButton.onClick:AddListener(function()
            local isAllOn, AllKey = self:GetViewBySaveData("RankList", 0)
            local isNowOn, NowKey = self:GetViewBySaveData("RankList", nowId)
            if nowId == 0 then
                if not isAllOn then
                    self.saveData["RankList"] = {0}
                end
            else
                if AllKey then
                    table.remove(self.saveData["RankList"], AllKey)
                end
                if NowKey then
                    table.remove(self.saveData["RankList"], NowKey)
                    if tablex.size(self.saveData["RankList"]) == 0 then
                        self.saveData["RankList"] = {0}
                    end
                else
                    table.insert(self.saveData["RankList"], nowId)
                end
            end
            self:ChangeRankBoxState()
        end)
    end)
end

--生成星级选项模块
function DockFiltrateBox:SetStarListView()
    local StarAllList = {
        {typeId = 0, name = "全 部"}, {typeId = 6, name = LocalStrEnum.TabName_103, icon = "VI"}, 
        {typeId = 5, name = LocalStrEnum.TabName_103, icon = "V"}, {typeId = 4, name = LocalStrEnum.TabName_103, icon = "IV"}, 
        {typeId = 3, name = LocalStrEnum.TabName_103, icon = "III"}, {typeId = 2, name = LocalStrEnum.TabName_103, icon = "II"}, 
    }
    self:FillTemplateContent(self.modeBtn, self.starListBox.msgList, tablex.size(StarAllList), function(index, modeBtn)
        modeBtn:SetActive(true)
        local temp = {
            obj = modeBtn,
            data = StarAllList[index],
        }
        table.insert(self.StarObjList, temp)
        local nowId = StarAllList[index].typeId
        modeBtn.isSelect.starMode:SetActive(true)
        modeBtn.starMode:SetActive(true)
        modeBtn.starTxt.text.text = StarAllList[index].name
        modeBtn.isSelect.starTxt.text.text = StarAllList[index].name
        modeBtn.starMsgTxt.text.text = StarAllList[index].icon
        modeBtn.isSelect.starMsgTxt.text.text = StarAllList[index].icon

        if StarAllList[index].icon == nil then
            modeBtn.isSelect.starMode:SetActive(false)
            modeBtn.starMode:SetActive(false)
            modeBtn.modeNameTxt.text.text = StarAllList[index].name
            modeBtn.selectNameTxt.text.text = StarAllList[index].name
        end

        modeBtn.selectNameTxt:SetActive(true)
        if self:GetViewBySaveData("StarList", nowId) then
            modeBtn.isSelect:SetActive(true)
        else
            modeBtn.isSelect:SetActive(false)
        end
        modeBtn.scaleButton.onClick:RemoveAllListeners()
        modeBtn.scaleButton.onClick:AddListener(function()
            local isAllOn, AllKey = self:GetViewBySaveData("StarList", 0)
            local isNowOn, NowKey = self:GetViewBySaveData("StarList", nowId)
            if nowId == 0 then
                if not isAllOn then
                    self.saveData["StarList"] = {0}
                end
            else
                if AllKey then
                    table.remove(self.saveData["StarList"], AllKey)
                end
                if NowKey then
                    table.remove(self.saveData["StarList"], NowKey)
                    if tablex.size(self.saveData["StarList"]) == 0 then
                        self.saveData["StarList"] = {0}
                    end
                else
                    table.insert(self.saveData["StarList"], nowId)
                end
            end
            self:ChangeStarBoxState()
        end)
    end)
end

--更改星级格子显示
function DockFiltrateBox:ChangeStarBoxState()
    for key, value in pairs(self.StarObjList) do
        if self:GetViewBySaveData("StarList", value.data.typeId) then
            value.obj.isSelect:SetActive(true)
        else
            value.obj.isSelect:SetActive(false)
        end
    end
end

--更改稀有度格子显示
function DockFiltrateBox:ChangeRankBoxState()
    for key, value in pairs(self.RankObjList) do
        if self:GetViewBySaveData("RankList", value.data.typeId) then
            value.obj.isSelect:SetActive(true)
        else
            value.obj.isSelect:SetActive(false)
        end
    end
end

--更改舰种格子显示
function DockFiltrateBox:ChangeTypeBoxState()
    for key, value in pairs(self.TypeObjList) do
        if self:GetViewBySaveData("TypeList", value.data.typeId) then
            value.obj.typeIcon:SetActive(true)
            value.obj.typeIconOff:SetActive(false)
            value.obj.typeName.text.text = "<color=#494949>"..value.data.name.."</color>"
        else
            value.obj.typeIcon:SetActive(false)
            value.obj.typeIconOff:SetActive(true)
            value.obj.typeName.text.text = "<color=#A4A4A4>"..value.data.name.."</color>"
        end
    end
end

--根据类型查找对应节点是否开启
function DockFiltrateBox:GetViewBySaveData(typeName, id)
    for key, value in pairs(self.saveData[typeName]) do
        if value == id then
            return true, key
        end
    end
    return false
end

--根据类型修改对应存档
function DockFiltrateBox:ChangePlayerPrefs(typeName, id)
    for _, value in pairs(self.saveData[typeName]) do
        if value == id then
            return
        end
    end

    table.insert(self.saveData[typeName], id)

end

function DockFiltrateBox:OnClose(initiative)
    local a = 0
end

--function DockFiltrateBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function DockFiltrateBox:OnRefresh(data)
--
--end

--[[
/PanelBg/Art/TitleBg/CloseBtn onClick 
--]]
function DockFiltrateBox:closeBtn_ScaleButton_onClick(closeBtn)
    self:playCloseAnim()
end

--[[
/PanelBg/ResetBtn onClick 
--]]
function DockFiltrateBox:resetBtn_ScaleButton_onClick(resetBtn)
    self.saveData = {
        TypeList = {0},
        RankList = {0},
        StarList = {0},
    }
    self:ChangeStarBoxState()
    self:ChangeRankBoxState()
    self:ChangeTypeBoxState()
end

--[[
/PanelBg/ConfirmBtn onClick 
--]]
function DockFiltrateBox:confirmBtn_ScaleButton_onClick(confirmBtn)
    local DockRolePanel = UIMgr:getUIData("DockRolePanel")
    if DockRolePanel then
        DockRolePanel.ui:SetView(self.saveData, true)
    end
    local PosterPanel = UIMgr:getUIData("PosterPanel")
    if PosterPanel then
        PosterPanel.ui:SetView(self.saveData, true)
    end
    local HomeWalkPanel = UIMgr:getUIData("HomeWalkPanel")
    if HomeWalkPanel then
        HomeWalkPanel.ui:SetView(self.saveData, true)
    end

    local HomePatrolPanel = UIMgr:getUIData("HomePatrolPanel")
    if HomePatrolPanel then
        HomePatrolPanel.ui:SetView(self.saveData, true)
    end


    self:playCloseAnim()
end

--[[
/PanelBg/SaveBtn onClick 
--]]
function DockFiltrateBox:saveBtn_ScaleButton_onClick(saveBtn)
    local str = tostring(tablex.dump(self.saveData))
    LuaLogger.ds("saveData", str)
    PlayerPrefs.SetString("DockFiltrateData", str)
    PlayerPrefs.Save()
    UICommonUtils.PopToast("保存成功！")
end

--[[
/Custom/ModeBtn onClick 
--]]
function DockFiltrateBox:modeBtn_ScaleButton_onClick(modeBtn)

end

--[[
/maskImg onClick 
--]]
function DockFiltrateBox:mask_Button_onClick(maskImg)
    self:playCloseAnim()
end

--[[
/Custom/TypeBox onClick 
--]]
function DockFiltrateBox:typeBox_ScaleButton_onClick(typeBox)

end

--[[
/PanelBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn onClick 
--]]
function DockFiltrateBox:typeListBtn_Button_onClick(typeListBtn)
    self.typeListBox.msgList:SetActive(not self.typeListBox.msgList.activeSelf)
    self.typeListBox.offIcon:SetActive(self.typeListBox.msgList.activeSelf)
    self.typeListBox.openIcon:SetActive(not self.typeListBox.msgList.activeSelf)
end

--[[
/PanelBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn onClick 
--]]
function DockFiltrateBox:rankListBtn_Button_onClick(rankListBtn)
    self.rankListBox.msgList:SetActive(not self.rankListBox.msgList.activeSelf)
    self.rankListBox.offIcon:SetActive(self.rankListBox.msgList.activeSelf)
    self.rankListBox.openIcon:SetActive(not self.rankListBox.msgList.activeSelf)
end

--[[
/PanelBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn onClick 
--]]
function DockFiltrateBox:starListBtn_Button_onClick(starListBtn)
    self.starListBox.msgList:SetActive(not self.starListBox.msgList.activeSelf)
    self.starListBox.offIcon:SetActive(self.starListBox.msgList.activeSelf)
    self.starListBox.openIcon:SetActive(not self.starListBox.msgList.activeSelf)
end

function DockFiltrateBox:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return DockFiltrateBox
