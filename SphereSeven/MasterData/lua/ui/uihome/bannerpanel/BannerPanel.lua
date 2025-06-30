local BannerPanel = {}
local this = BannerPanel
local pfbHomeBoardPanel = "UI/Prefabs/View/UI/HomeBoardPanel.prefab"

local ChangType = {
    None = nil,
    Remove = 2,
    Add = 3,
}

local GiftBagList ={
    [33] ={id= 33,cardId = 1026, IconId = 1,langId =  962,windowName="ToolTipGiftBag",data = {ModeId = 33}},
    [34]= {id= 34,cardId = 1027, IconId = 2 ,langId =  963,windowName="ToolTipGiftBag",data = {ModeId = 34}}
}

local function InitActiveBtnText(self)
    if self.ActiveBtnList then
        for _, v in pairs(self.ActiveBtnList) do
            if v.cardId then
                v.Text.text = LangUtil.GetSysLang(v.str)
                LangUtil.BindText(v.timeText, FontType.All_Numbe)
                if v.data ~= nil then
                    v.timeBg.gameObject:SetActive(true)
                end
            end
        end
    end
end

local function GetActiveBtn(self)
    for _, v in pairs(self.ActiveBtnList) do
        if not v.cardId then
            return v
        end
    end
    return nil
end

local function GetRGBColor(str)
    if string.IsNullOrEmpty(str) then
        return false
    end
    local num = tonumber(str, 16)
    return true, Color.New(((num >> 16)&255) /255, ((num >> 8)&255) /255, (num & 255) /255) 
end

local function SetTxtAnchor(col, TxtAnchor)
    if TxtAnchor == 1 then
        col.Image.transform.anchorMax = Vector2.New(0, 0.5)
        col.Image.transform.anchorMin = Vector2.New(0, 0.5)
        col.Image.transform.pivot = Vector2.New(0, 0.5)
        col.timeText.alignment = 3--TextAnchor.MiddleLeft
    elseif TxtAnchor == 2 then
        col.Image.transform.anchorMax = Vector2.New(1, 0.5)
        col.Image.transform.anchorMin = Vector2.New(1, 0.5)
        col.Image.transform.pivot = Vector2.New(1, 0.5)
        col.timeText.alignment = 5--TextAnchor.MiddleLeft
    else
        col.Image.transform.anchorMax = Vector2.New(0.5, 0.5)
        col.Image.transform.anchorMin = Vector2.New(0.5, 0.5)
        col.Image.transform.pivot = Vector2.New(0.5, 0.5)
        col.timeText.alignment = 4--TextAnchor.MiddleCenter
    end
end

local function SetBannerSprite(col)
    col.Image.gameObject:SetActive(false)
    coroutine.start(function()
        local window = Z_HomeBanner[col.Id]
        if window ~= nil then
            if window.Type == 1 then
                LangUtil.GetSpriteByName("summon_banner_" .. col.Id, function(sprite) col.pageObj:GetComponent("Image").sprite = sprite end)
            elseif window.SpritLang ~= -1 then
                LangUtil.GetSpriteLang(window.SpritLang, function(sprite) col.pageObj:GetComponent("Image").sprite = sprite end)
            end
            
            if col.data and col.data.Start and col.data.End and not string.IsNullOrEmpty(window.Pos) then
                local pos = window.Pos
                if LangType.JA == LangUtil.GetLangType() and not string.IsNullOrEmpty(window.Pos2) then
                    pos = window.Pos2
                end
                pos = string.split(pos,",")
                col.Image.gameObject:SetActive(true)
                LangUtil.BindText(col.timeText).text = UIPublic.GetTimeStr(col.data.Start, col.data.End)
                --SetTxtAnchor(col, window.TxtAnchor)--设置 锚点、中心点  Text Alignment
                --col.Image.transform.anchoredPosition = Vector2.New(pos[1], pos[2])
                -- if window.TxtMaxWidth > 0 then
                --     col.Image.transform.sizeDelta = Vector2.New(window.TxtMaxWidth, col.Image.transform.sizeDelta.y)
                -- end
                col.timeText.fontStyle = window.TxtFontStyle
                col.timeText.fontSize = window.TxtFontSize
                col.timeText.resizeTextMaxSize = window.TxtFontSize

                local isOutLine, effectColor = GetRGBColor(window.TxtOutLine)
                col.timeTextOutLine.enabled = isOutLine
                if isOutLine then col.timeTextOutLine.effectColor = effectColor end
                
                local isTxt, texColor = GetRGBColor(window.TxtColor)
                if isTxt then col.timeText.color = texColor end
            end

        end
    end)
end

function this.OnLangTypeChg(self)
    for _, v in pairs(this.PageList) do
        SetBannerSprite(v)
    end

    InitActiveBtnText(self)
end

local function SetBannerAttri(col, window)
    SetBannerSprite(col)

    if not string.IsNullOrEmpty(window.WindowName) then
        UIUtil.AddBtnEvent(col.pageObj, function()

            -- 首页活动banner点击次数埋点
            ChannelManager:GetInstance():OnActivityBtnShow(window)
            
            if window.WindowName == "UIAllShop" then
                --UIManager:GetInstance():OpenWindow(window.WindowName, { typeName = window.typeName })
                UIManager:GetInstance():OpenWindow(UIWindowNames.UIAllShop, {
                    ShopTitleType = col.openParam[1],
                    GeneralShopType = col.openParam[2] -- 非GeneralShop不用填
                })
            elseif window.WindowName == "UIGameEventMain" then
                --UIManager:GetInstance():OpenWindow(window.WindowName, { typeName = window.typeName })
                UIManager:GetInstance():OpenWindow(UIWindowNames.UIGameEventMain, {
                    eventId = col.openParam[1]
                })
            elseif window.WindowName == "UISummon" then
                --UIManager:GetInstance():OpenWindow(window.WindowName, { typeName = window.typeName })
                UIManager:GetInstance():OpenWindow(UIWindowNames.UISummon, {
                    id = col.openParam[1]
                })
            else
                UIManager:GetInstance():OpenWindow(window.WindowName, { typeName = window.typeName })
            end
            

        end)
    end

end

local imageSize = Vector2.New(385, 32)

local function clearBoardPanel(col)
    col.Image.gameObject:SetActive(false)
    --col.Image.transform.sizeDelta = imageSize
    col.timeTextOutLine.effectColor = Color.gray
    col.timeText.color = Color.white
end

local function PageListAddItem(self, Id, data)
    if not table.any(this.PageList, function(v) return v.Id == Id end) then
        local window = Z_HomeBanner[Id]
        if window then
            local col = {}
            col.pageObj = GameObjectPool:GetInstance():CoGetGameObjectAsync(pfbHomeBoardPanel)
            col.pageObj.transform:SetParent(self.PageContent, false)
            col.Image = col.pageObj.transform:Find("Image")
            col.timeText = col.Image:Find("Text"):GetComponent("Text")
            col.timeTextOutLine = col.timeText:GetComponent("Outline")
            col.data = data
            col.Id = window.Id
            col.openParam = window.OpenParam
            clearBoardPanel(col)
            
            table.insert(this.boardPanelPfb, col.pageObj)
            local max = table.count(this.PageList) + 1
            local index = max
            for i, v in ipairs(this.PageList) do
                if col.data.sortWeight < v.data.sortWeight then
                    index = i
                    break
                end
            end
            table.insert(this.PageList, index, col)
            if index ~= max then
                for _, v in ipairs(this.PageList) do
                    v.pageObj.transform:SetAsLastSibling()
                end
            end

            SetBannerAttri(col, window)
            this.isChange = ChangType.Add
        end
    end
end

local function PageListRemoveItem(self, Id)
    for i = table.count(this.PageList), 1, -1 do
        local temp = this.PageList[i]
        if temp.Id == Id then
            table.remove(this.PageList, i)
            temp.pageObj.transform.parent = nil
            CS.UnityEngine.GameObject.Destroy(temp.pageObj)
            this.isChange = ChangType.Remove
            break
        end
    end
end

local function PageChange(self, data)
    if data.isAddItem then
        PageListAddItem(self, data.Id, data)
    else
        PageListRemoveItem(self, data.Id)
    end
end

local function HomeBIsOpen(Id)
    if not Z_HomeBanner[Id] then return false end

    return Z_HomeBanner[Id].NotOpen ~= 1
end


local function ActiveLogin()
    -- for _, v in pairs(Z_ActivityLogin) do
    --     if v.BannerId > 0 then
    --         local data = {Id = v.BannerId}
    --         data.isAddItem = this.activityDemonComponent:LoginIsOpen(v.Id)
    --         if data.isAddItem then
    --             data.Start = this.activityDemonComponent.LoginTimeSlots[v.Id].Start
    --             data.End = this.activityDemonComponent.LoginTimeSlots[v.Id].End
    --         end
    --         table.insert(this.bannerData, data)
    --     end
    -- end
    
end

local function ActivityReward()
    -- for _, v in pairs(Z_ActivityReward) do
    --     if v.BannerId > 0 then
    --         local data = {Id = v.BannerId}
    --         data.isAddItem = false
    --         if this.activityDemonComponent.RewardTimeSlots[v.Id] and TimeUtil.OSTime() > this.activityDemonComponent.RewardTimeSlots[v.Id].Start
    --                 and TimeUtil.OSTime() < this.activityDemonComponent.RewardTimeSlots[v.Id].End then
    --             data.isAddItem = true
    --         end
    --         if data.isAddItem then
    --             data.Start = this.activityDemonComponent.RewardTimeSlots[v.Id].Start
    --             data.End = this.activityDemonComponent.RewardTimeSlots[v.Id].End
    --         end
    --         table.insert(this.bannerData, data)
    --     end
    -- end
    
end

local function OpenDateTime()
    local summonBan = table.choose(Z_HomeBanner, function(k, v) return v.Type == 3 end)
    local open = {isAddItem = this.diffTime}
    if open.isAddItem then
        open.Start = Game.Scene:GetComponent("SessionComponent").DateTime
        open.End = UIUtil.GetRefreshTime(5)
    end

    for _, v in table.pairsByKeys(summonBan) do
        table.insert(this.bannerData, { Id = v.Id, isAddItem = open.isAddItem, Start = open.Start, End = open.End})
    end
    
end

local function ActivityStarLightRebate(self)
    local starLightRebateComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")
    local data = { Id = 1003 }
    data.isAddItem = starLightRebateComponent:ActiveIsOpen()
    if data.isAddItem then
        data.Start = starLightRebateComponent.StartDate
        data.End = starLightRebateComponent.EndDate
    end
    table.insert(this.bannerData, data)
end

local function CheckVisiableTime(packageInfo)
    local currentTime = TimeUtil.GetServerTime()
    if packageInfo.VisibleStartTime ~= "" then
        if currentTime < TimeUtil.ParseDateTime(packageInfo.VisibleStartTime) then
            return false
        end
    end

    if packageInfo.VisibleEndTime ~= "" then
        if currentTime > TimeUtil.ParseDateTime(packageInfo.VisibleEndTime) then
            return false
        end
    end

    return true
end

local function NormalBanner()--暂无限制
    local summonBan = table.choose(Z_HomeBanner, function(k, v) return v.IsOpen == 1 end)
    for _, v in table.pairsByKeys(summonBan) do
        if CheckVisiableTime(v) then
            local data = { Id = v.Id, isAddItem = true}
            table.insert(this.bannerData, data)
        end
    end
end

local function SummonPickUp()
    -- gh: 2023.11.8 临时屏蔽
    -- 读抽卡表, 判断对应的卡池 是否配在了 banner 里, 如果配上了 就 table.insert

    -- table.walk(Z_SummonType, function(_, z)
    --     if Z_HomeBanner[z.Id] and Z_HomeBanner[z.Id].Type == 1 then--id一致，配日期
    --         local data = {Id = z.Id}
    --         data.isAddItem = this.recruitComponent:SummonIsOpen(z.Id)
    --         if data.isAddItem then
    --             data.Start = this.recruitComponent.SummonTimes[z.Id].Start
    --             data.End = this.recruitComponent.SummonTimes[z.Id].End
    --         end
    --         table.insert(this.bannerData, data)
    --     end
    -- end)
end

local function SummonMust(self)
    -- gh: 2023.11.8 临时屏蔽
    -- 读banner 表, 判断对应限定卡池是否开启了, 如果开启了 就table.insert

    -- local summonBan = table.choose(Z_HomeBanner, function(k, v) return v.Type == 2 end)
    -- for _, v in table.pairsByKeys(summonBan) do
    --     local data = { Id = v.Id }
    --     data.isAddItem = this.recruitComponent:SummonIsOpen(v.UseId)
    --     if data.isAddItem then
    --         data.Start = this.recruitComponent.SummonTimes[v.UseId].Start
    --         data.End = this.recruitComponent.SummonTimes[v.UseId].End
    --     end
    --     table.insert(this.bannerData, data)
    -- end

end

local function ActivityStory(self)--包括 Banner和活动按钮 ActiveBtn1、ActiveBtn2
    local isBattleEx = false
    -- for _, v in table.pairsByKeys(Z_ActivityStory) do
    --     local isAddItem = false
    --     if this.activityDemonComponent:ActiveIsOpen(v.Id) then
    --         local btnInfo = GetActiveBtn(self)
    --         if btnInfo then
    --             btnInfo.str = v.BtnStrs[1]--EX关卡
    --             btnInfo.cardId = v.BtnCardIds[1]
    --             btnInfo.iconId = v.BtnIconIds[1]
    --             btnInfo.windowName = v.WindowName[1]
    --             this.ActiveBtnInfo.cardId = v.ComCardId
    --             this.ActiveBtnInfo.iconId = v.ComIconId
    --         end
    --         isAddItem = true
    --         isBattleEx = true
    --     end
    --     if this.activityDemonComponent:ActiveIsOpen(v.Id, 1) then
    --         local btnInfo = GetActiveBtn(self)
    --         if btnInfo then
    --             btnInfo.str = v.BtnStrs[2]--交換
    --             btnInfo.cardId = v.BtnCardIds[2]
    --             btnInfo.iconId = v.BtnIconIds[2]
    --             btnInfo.windowName = v.WindowName[2]
    --             this.ActiveBtnInfo.cardId = v.ComCardId
    --             this.ActiveBtnInfo.iconId = v.ComIconId
    --         end
    --         --isAddItem = true
    --     end
    --     if v.BannerId > 0 then
    --         local data = { Id = v.BannerId, isAddItem = isAddItem }
    --         if data.isAddItem then
    --             data.Start = this.activityDemonComponent.TimeSlots[v.Id].Start
    --             data.End = this.activityDemonComponent.TimeSlots[v.Id].End
    --         end
    --         table.insert(this.bannerData, data)
    --     end
    -- end
    -- if not isBattleEx then
    --     ClientData:GetInstance():SetCurBattleDemoDifficulty(1)
    -- end

    -- if table.count(this.activityDemonComponent.ActivityGifts) > 0 then
    --     for k, v in pairs(GiftBagList) do
    --         if this.activityDemonComponent.ActivityGifts[v.id] ~= nil and this.activityDemonComponent.ActivityGifts[v.id].State == 0 and this.activityDemonComponent.ActivityGifts[v.id].LimitDate > TimeUtil.OSTime() then
    --             local btnInfo = GetActiveBtn(self)
    --             if btnInfo then
    --                 btnInfo.str = v.langId--交換
    --                 btnInfo.id = v.id
    --                 btnInfo.cardId = v.cardId
    --                 btnInfo.iconId = v.IconId
    --                 btnInfo.windowName = v.windowName
    --                 btnInfo.data = v.data
    --             end
    --         end
    --     end
    -- end


end

local function ChangeSortWeight()
    if TimeUtil.OSTime() < UIUtil.GetRefreshTime(10, {day = 7}) then
        Z_HomeBanner[1024].SortWeight = 50
    else
        Z_HomeBanner[1024].SortWeight = 200
    end 

end

local function InitActiveBtn(self)
    for _, v in pairs(self.ActiveBtnList) do
        if v.cardId then
            coroutine.start(function()
                UIPublic.InitItemIcon(self.ActiveBtn:Find("ActivityMask/Image"):GetComponent("Image"), nil, GoodsKind.Card, 1045, { iconId = 2 })
                UIPublic.InitItemIcon(v.image, nil, GoodsKind.Card, v.cardId, { iconId = v.iconId })
                UIUtil.AddBtnEvent(v.btn, function() 
                    UIManager:GetInstance():OpenWindow(v.windowName, v.data)
                    
                    --首页活动icon点击次数
                    ChannelManager:GetInstance():OnActivityBtnClick(LangUtil.GetSysLang(v.str))
                end)
                v.btn.gameObject:SetActive(true)
            end)
        else
            v.btn.gameObject:SetActive(false)
        end
    end
    -- gh: 这个接口不用了, 做banner的时候再换成新的
    -- UIPublic.InitItemIcon(self.ActiveBtn:Find("ActivityMask/Image"):GetComponent("Image"), nil,
    --         GoodsKind.Card, this.ActiveBtnInfo.cardId, { iconId = this.ActiveBtnInfo.iconId })

    InitActiveBtnText(self)
end

local func = { SummonPickUp, SummonMust, OpenDateTime, ActiveLogin, NormalBanner, ActivityStory, ActivityStarLightRebate, ActivityReward}

function this.InitPanel(self)
    --ChangeSortWeight()
    this.diffTime = UIUtil.GetDiffTime(5) > 3
    for _, v in pairs(self.ActiveBtnList) do
        v.cardId = nil--是否有活动
        v.id = nil
        v.data = nil
        v.timeText.text = ""
        v.timeBg:SetActive(false)
    end
    this.ActiveBtnInfo = { cardId = 1003, iconId = 1 }--ActiveBtn
    this.pageIndex = -1

    this.bannerData = {}
    for _, f in pairs(func) do
        f(self)
    end
    table.removeall(this.bannerData,function(v) return Z_HomeBanner[v.Id] == nil end)
    table.walksort(this.bannerData, 
            function(v1, v2)
                if this.bannerData[v1].isAddItem == this.bannerData[v2].isAddItem then
                    return Z_HomeBanner[this.bannerData[v1].Id].SortWeight < Z_HomeBanner[this.bannerData[v2].Id].SortWeight
                end
                return not this.bannerData[v1].isAddItem end,
            function(_, z)
                if Z_HomeBanner[z.Id] and HomeBIsOpen(z.Id) then
                    z.sortWeight = Z_HomeBanner[z.Id].SortWeight
                    PageChange(self, z)
                end
            end)

    --InitActiveBtn(self)
    return this.isChange
end

function this.OnCreate(self)
    this.activityDemonComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    this.taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
    this.recruitComponent = Game.Scene.Player:GetComponent("RecruitComponent")

    this.boardPanelPfb = {}
    this.PageList = {}
    this.isChange = ChangType.None
end


function this.OnPageChanged(self, index)
    if this.pageIndex ~= index and this.PageList[index] then
        this.pageIndex = index
        ChannelManager:GetInstance():OnBannerBtnShow(Z_HomeBanner[this.PageList[index].Id])
    end
    
end


function this.OnDestroy()
    if this.boardPanelPfb then
        for i = 1, table.count(this.boardPanelPfb) do
            if not IsNull(this.boardPanelPfb[i]) then
                GameObjectPool:GetInstance():RecycleGameObject(pfbHomeBoardPanel, this.boardPanelPfb[i])
            end
        end
        this.boardPanelPfb = nil
        this.PageList = nil
    end
    this.bannerData = nil
    this.pageIndex = nil
end

return this