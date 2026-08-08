---@class RaffleEditorPanel : RaffleEditorPanel_Generate
---##################### 【RaffleEditorPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RaffleEditorPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RaffleEditorPanel = require "RaffleEditorPanel_Generate"

function RaffleEditorPanel:InitLogic(data)

    self.defaultCount = 10000

    self.nowDoCount = 0

    self.resultDataList = {}

    self.newListByType = {}

    self.resultBoxList = {}
end

function RaffleEditorPanel:InitPanel()
    self.nowPoolText.text.text = self.nowPoolId
    local gachaConfig = Config.GetGachaPoolInfo(self.nowPoolId)
    self.limitIdList = {}
    for _, roleId in pairs(gachaConfig.limit or {}) do
        table.insert(self.limitIdList, roleId)
    end

    self:FillTemplateContent(self.resultBox, self.resultBg, 39, function(index, resultBox)
        resultBox:SetActive(false)
        table.insert(self.resultBoxList, resultBox)
    end)
end

--function RaffleEditorPanel:StartCreating(time)
--
--end

--function RaffleEditorPanel:StartEnter(time)
--
--end

--function RaffleEditorPanel:StartRemoving(time)
--
--end

--function RaffleEditorPanel:StartExit(time)
--
--end

function RaffleEditorPanel:OnOpen(data, initiative)
    self.nowPoolId = data.gachaPoolId
    self:InitPanel()
end

function RaffleEditorPanel:setResultBoxData()
    for _, resultData in pairs(self.resultDataList) do
        if not self.newListByType[resultData.type] then
            self.newListByType[resultData.type] = {}
        end
        if not self.newListByType[resultData.type][resultData.id] then
            self.newListByType[resultData.type][resultData.id] = {}
            self.newListByType[resultData.type][resultData.id].num = 0
        end
        self.newListByType[resultData.type][resultData.id].num = self.newListByType[resultData.type][resultData.id].num + resultData.num
    end

    self.resultDataList = nil

    local showDataList = {}
    --角色
    local limitNum = 0
    local SSRNum = 0
    local SRNum = 0
    for id, data in pairs(self.newListByType[GE.RewardType.Character]) do
        local roleConfig = Config.GetCharacterInfo(id)
        local limitRole = tablex.contains(self.limitIdList, id)
        if limitRole then
            limitNum = limitNum + data.num
        elseif roleConfig.rank == 5 then
            SSRNum = SSRNum + data.num
        elseif roleConfig.rank == 4 then
            SRNum = SRNum + data.num
        end
        table.insert(showDataList, {
            id = id,
            name = roleConfig.name,
            num = data.num,
            rank = roleConfig.rank,
            isLimit = limitRole,
        })
    end
    --道具
    for id, data in pairs(self.newListByType[GE.RewardType.ItemProp] or {}) do
        local itemConfig = Config.GetItemInfo(id)
        table.insert(showDataList, {
            id = id,
            name = itemConfig.itemName,
            num = data.num,
            rank = itemConfig.quality,
        })
    end
    table.sort(showDataList, function (a, b)
        return a.rank > b.rank
    end)
    --LuaLogger.ds(">>>>>showDataList<<<<<", tablex.dump(showDataList))

    for index, rewardData in pairs(showDataList) do
        local resultBox = self.resultBoxList[index]
        resultBox.nameTxt.text.text = rewardData.name
        resultBox.iDTxt.text.text = rewardData.id
        resultBox.numberTxt.text.text = "x"..rewardData.num
        if rewardData.isLimit then
            self:setBoxTextColor(resultBox, "FF0000")
        elseif rewardData.rank == 5 then
            self:setBoxTextColor(resultBox, "D49E35")
        elseif rewardData.rank == 4 then
            self:setBoxTextColor(resultBox, "B02E80")
        end
        resultBox:SetActive(true)
    end

    --总概率
    self.limitPro.text.text = string.format("%.2f", limitNum / self.nowDoCount * 100) .. "%"
    self.sSRPro.text.text = string.format("%.2f", SSRNum / self.nowDoCount * 100) .. "%"
    self.sRPro.text.text = string.format("%.2f", SRNum / self.nowDoCount * 100) .. "%"
    self.nowcount.text.text = self.nowDoCount
end

function RaffleEditorPanel:setBoxTextColor(resultBox, newColor)
    resultBox.nameTxt.text.color = Color.NewFromStr(newColor)
    resultBox.iDTxt.text.color = Color.NewFromStr(newColor)
    resultBox.numberTxt.text.color = Color.NewFromStr(newColor)
end

--function RaffleEditorPanel:OnClose(initiative)
--
--end

--function RaffleEditorPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RaffleEditorPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function RaffleEditorPanel:mask_Button_onClick(mask)
    UIMgr:closeUI(self)
end

--[[
/TestBtn onClick 
--]]
function RaffleEditorPanel:testBtn_ScaleButton_onClick(testBtn)
    Me:testRaffleReq({raffleId = self.nowPoolId, count = self.defaultCount},function(rewardList)
        self.nowDoCount = self.nowDoCount + self.defaultCount
        self.resultDataList = rewardList
        self:setResultBoxData()
    end)
end

--[[
/TimeLineTestBg/TimeLineTestBtn onClick 
--]]
function RaffleEditorPanel:timeLineTestBtn_ScaleButton_onClick(timeLineTestBtn)
    local roleCfg = Config.GetCharacterInfo(self.testTimelineCharId)
    if not roleCfg then
        UICommonUtils.PopToast("角色ID不存在")
        return
    end
    LoadingMgr:SetUIQuickSwitchStart(function()
        UIMgr:closeUI(self)
        RaffleMgr:setRaffleResultList({{id = self.testTimelineCharId, type = GE.RewardType.Character}})
        RaffleMgr:jumpToRaffleScene()
    end)
end

--[[
/TimeLineTestBg/Text5/CharIdInputField onEndEdit 
--]]
function RaffleEditorPanel:charIdInputField_InputField_onEndEdit(charIdInputField,content)
    self.testTimelineCharId = tonumber(content)
end

return RaffleEditorPanel
