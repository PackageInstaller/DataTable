---@class RaffleRecordPanel : RaffleRecordPanel_Generate
---##################### 【RaffleRecordPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RaffleRecordPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RaffleRecordPanel = require "RaffleRecordPanel_Generate"

function RaffleRecordPanel:InitLogic(data)
    self.singlePageCount = 10

    self.pageIndex = 1

    self.recordCosDataList = {}
end

function RaffleRecordPanel:InitPanel()
    self:setRecordData()
end

--function RaffleRecordPanel:StartCreating(time)
--
--end

--function RaffleRecordPanel:StartEnter(time)
--
--end

--function RaffleRecordPanel:StartRemoving(time)
--
--end

--function RaffleRecordPanel:StartExit(time)
--
--end

function RaffleRecordPanel:OnOpen(data, initiative)
    self:InitPanel()
end

function RaffleRecordPanel:setRecordData()
    local nowCount = 0
    self.newRecordList = {}
    local transRecordList = {}
    local gachaRecordData = RaffleMgr:getRaffleRecordData()
    for _, recordData in ipairs(gachaRecordData or {}) do
        table.insert(transRecordList, recordData)
        nowCount = nowCount + 1
        if nowCount == self.singlePageCount then
            table.insert(self.newRecordList, transRecordList)
            transRecordList = {}
            nowCount = 0
        end
    end
    if #transRecordList > 0 then
        table.insert(self.newRecordList, transRecordList)
    end
    self:setRecordBox()

    local SSRRoleNum = Me.userData.GetSSRNum
    local totalCount = Me.userData.TotalGachaNum
    self.statisticsTxt.text.text = string.format(LocalStrEnum.GachaSsrCount, totalCount, SSRRoleNum)
    if totalCount == 0 then
        self.probabilityTxt.text.text = "0%"
    else
        local probability = string.format("%.2f", SSRRoleNum / totalCount * 100)
        if probability:sub(-3) == ".00" then
            probability = probability:sub(1, -4)
        end
        self.probabilityTxt.text.text = probability.."%"
    end
    self.nowPageTxt.text.text = self.pageIndex
end

function RaffleRecordPanel:setRecordBox()
    local needRecordData = self.newRecordList[self.pageIndex] or {}
    self:FillTemplateContent(self.recordBox, self.recordBoxList, math.min(#needRecordData, self.singlePageCount), function(index, recordBox)
        local needConfig = {}
        local needName = nil
        local recordData = needRecordData[index]
        if recordData.type == GE.RewardType.ItemProp then
            needConfig = Config.GetItemInfo(recordData.id)
            needName = needConfig.itemName
        elseif recordData.type == GE.RewardType.Character then
            needConfig = Config.GetCharacterInfo(recordData.id)
            needName = needConfig.name
        end
        if recordData.type == GE.RewardType.Character and needConfig.rank == GE.HeroRankStar.SSR then
            recordBox.typeTxt.text.color = Color.NewFromStr("FF6E0D")
            recordBox.nameTxt.text.color = Color.NewFromStr("FF6E0D")
            recordBox.timeTxt.text.color = Color.NewFromStr("FF6E0D")
        elseif recordData.type == GE.RewardType.Character and needConfig.rank == GE.HeroRankStar.SR then
            recordBox.typeTxt.text.color = Color.NewFromStr("1B8AE6")
            recordBox.nameTxt.text.color = Color.NewFromStr("1B8AE6")
            recordBox.timeTxt.text.color = Color.NewFromStr("1B8AE6")   
        else
            recordBox.typeTxt.text.color = Color.NewFromStr("333333")
            recordBox.nameTxt.text.color = Color.NewFromStr("333333")
            recordBox.timeTxt.text.color = Color.NewFromStr("333333")
        end
        recordBox.evenNumber:SetActive(index % 2 == 0)
        local gachaConfig = Config.GetGachaPoolInfo(recordData.raffleId)
        recordBox.typeTxt.text.text = gachaConfig.PoolNameTitle
        recordBox.nameTxt.text.text = needName
        recordBox.timeTxt.text.text = luautil.getDateStr(recordData.gachaTime)
    end)
end

function RaffleRecordPanel:changePage(index)
    if not self.newRecordList[self.pageIndex + index] then
        return
    end
    self.pageIndex = self.pageIndex + index
    self:setRecordBox()
    self.nowPageTxt.text.text = self.pageIndex
end

--界面关闭
function RaffleRecordPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function RaffleRecordPanel:OnClose(initiative)
--
--end

--function RaffleRecordPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RaffleRecordPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function RaffleRecordPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/BoxBg/CloseBtn onClick 
--]]
function RaffleRecordPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/BoxBg/PageTurning/LeftPageBtn onClick 
--]]
function RaffleRecordPanel:leftPageBtn_ScaleButton_onClick(leftPageBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:changePage(-1)
end

--[[
/BoxBg/PageTurning/RightPageBtn onClick 
--]]
function RaffleRecordPanel:rightPageBtn_ScaleButton_onClick(rightPageBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:changePage(1)
end

return RaffleRecordPanel
