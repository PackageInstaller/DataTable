local UIExpeditionView = BaseClass("UIExpeditionView",UIBaseView);
local base = UIBaseView
local this = UIExpeditionView

local RareConfig = {[1] = "R",[2] = "SR",[3] = "SSR",[4] = "UR"}

local RareDoorConfig = {[1] = "door_绿",[2] = "door_蓝",[3] = "door_紫",[4] = "door_橙"}

local RareRoleConfig = {[1] = 5,[2] = 32,[3] = 10,[4] = 33}

local StateBgConfig = {[0] = "time_default",[1] = "time_start",[2] = "time_finish"}

local TaskState = {["WaitGet"] = 0,["InTask"] = 1,["Finish"] = 2}

local sortTab = {1,2,3,4,5,6,7,8,9,10}

local color_1 = Color.New(170/255,210/255,1,1)

local color_2 = Color.New(64/255,238/255,154/255,1)

local function OnSetExpeditationCardInfo(self)
    local tab = self.expeditionComponent:GetSelectCardData()
    self.expeditionComponent:SetExpeditationCardInfo(tab)
end

local function ConvertTimeForm(second)
    if second < 0 then second = 0 end
    local tb = {}
    tb.day = math.floor(second/86400)
    tb.hour = math.fmod(math.floor(second/3600), 24)
    tb.minute = math.fmod(math.floor(second/60), 60)
    tb.second = math.floor(math.fmod(second, 60))
    return tb
end

function this.IsMeetConditions(self,idx,content,data)
    local isCondition1 = true
    local isCondition2 = true
    local isCondition3 = true
    local cards = self.expeditionComponent:GetSelectCardData(idx)
    if not cards then
        return false
    else
        isCondition1 = #cards >= data.Condition1
    end
    for key, value in pairs(cards) do
        if value.Level < data.Condition2 then
            isCondition2 = false
            break
        end
    end

    for key, value in pairs(cards) do
        if Z_Card[value.TemplateId].Rare < data.Condition3 then
            isCondition3 = false
            break
        end
    end
    this.InitConditions(self,content,data,isCondition1,isCondition2,isCondition3)
    return isCondition1 and isCondition2 and isCondition3
end

-- 绿色品质概率为0.42[1-42]，
-- 蓝色色品质概率为0.25[43-67]
-- 紫色品质概率为0.15[68-92]
-- 橙色品质概率为0.08[93-100]
function this.GetRandomRare(self)
    local random = math.random(1,100)
    local rare
    if random >= 1 and random <= 42 then
        rare = 1
    elseif random > 42  and random <= 67 then
        rare = 2
    elseif random > 67  and random <= 92 then
        rare = 3
    else
        rare = 4
    end
    return rare
end

function this.GetAllTaskData(self)
    local tab = self.expeditionComponent:GetExpeditationTaskInfo()
    math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)))
    if type(tab) == "table" and  #tab > 0 then
        return tab
    else
        local tab = {}
        for i = 1, 10 do
            local data = {}
            data.Rare = this.GetRandomRare(self)
            data.StartTime = 0
            data.LeftTime = 0
            data.State = TaskState.WaitGet
            table.insert(tab,data)
        end
        self.expeditionComponent:SetExpeditationTaskInfo(tab)
        return tab
    end
end

function this.OnFresh(self,index)
    if self.taskDatasIds[index].State == 0 then
        self.taskDatasIds[index].Rare = this.GetRandomRare(self)
        self.taskDatasIds[index].StartTime = 0
        self.taskDatasIds[index].LeftTime = 0
        self.taskDatasIds[index].State = TaskState.WaitGet
        self.expeditionComponent:RemoveSelectCardData(index)
        OnSetExpeditationCardInfo(self)
        self.expeditionComponent:SetExpeditationTaskInfo(self.taskDatasIds)
    end
end

function this.FreshTaskData(self,index)
    math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)))
    if index then
        this.OnFresh(self,index)
    else
        for i = #self.taskDatasIds, 1, -1 do
            this.OnFresh(self,i)
        end
    end
    this.OnRefresh(self)
end

function this.ShowDetail(self,tab,item,idx)
    local showType
    local tabIdx = idx + 1
    if not tab[tabIdx] then
        return
    end
    if tab[tabIdx].id <= 8 and tab[tabIdx].id > 0  then
        showType = 6
    elseif tab[tabIdx].id >= 1001 then
        showType = 3
    end
    UIUtil.AddBtnEvent(item,function(go)
        local showData = {tempId = tab[tabIdx].id,Id = tab[tabIdx].id,showType = showType}
        UIUtil.OpenThingsDetailWindow(UIThingsDetail,showData);
    end)
end

function this.InitRewards(self,content,data)
    local tab = {}
    for key, value in pairs(loadtable(data)) do
        table.insert(tab,value)
    end
    for idx = 0, content.transform.childCount - 1 do
        local item = content.transform:GetChild(idx).gameObject
        local icon = item.transform:Find("Value").transform:GetComponent("Image")
        local txtCount = item.transform:Find("Amount").transform:GetComponent("Text")
        if tab[idx+1] then
            item:SetActive(true)
            if tab[idx+1].id > 0 then
                UIPublic.InitItemIcon(icon, nil, tab[idx+1].type, tab[idx+1].id)
            else
                icon.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/ItemIcon/Other/1011_1018.png")
            end
            txtCount.text = tab[idx+1].num
        else
            item:SetActive(false)
        end
    end
end

function this.InitConditions(self,content,data,isCondition1,isCondition2,isCondition3)
    for idx = 0, content.transform.childCount - 1 do
        local item = content.transform:GetChild(idx).gameObject
        local itemState = item.transform:Find("Image").transform:GetComponent("Image")
        local txtCount = item.transform:Find("Text").transform:GetComponent("Text")
        if idx == 0 then
            itemState.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/ItemIcon/Other/1011_1018.png")
        end
        if isCondition1 and isCondition2 and isCondition3 then
            txtCount.color = color_2
        else
            txtCount.color = color_1
        end
        if idx == 0 then
            LangUtil.BindText(txtCount).text = string.format(LangUtil.GetSysLang(4100),data.Condition1)
            if isCondition1 then
                itemState.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Expedition/icon达成.png")
            else
                itemState.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Expedition/icon未达成.png")
            end
        elseif idx == 1 then
            LangUtil.BindText(txtCount).text = string.format(LangUtil.GetSysLang(4099),data.Condition2)
            if isCondition2 then
                itemState.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Expedition/icon达成.png")
            else
                itemState.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Expedition/icon未达成.png")
            end
        else
            if data.Condition3 == 0 then
                LangUtil.BindText(txtCount).text = LangUtil.GetSysLang(4102)
            else
                LangUtil.BindText(txtCount).text = string.format(LangUtil.GetSysLang(4101),RareConfig[data.Condition3])
            end
            if isCondition3 then
                itemState.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Expedition/icon达成.png")
            else
                itemState.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Expedition/icon未达成.png")
            end
        end
    end
end

function this.IsCanClick(self,hideContent,index)
    local selectContent = hideContent.transform:Find("BtnSelects").gameObject
    for idx = 0, selectContent.transform.childCount - 1 do
        local btn = selectContent.transform:GetChild(idx).transform:GetComponent("Button")
        btn.enabled = self.taskDatasIds[index].State == TaskState.WaitGet
    end
end

function this.Update(self)
    for key, value in pairs(sortTab) do
        if self.taskDatasIds[value].State == TaskState.InTask then
            local needTime = Z_Expedition[self.taskDatasIds[value].Rare].Duration * 3600
            local tb = ConvertTimeForm(needTime - (TimeUtil.OSTime()-self.taskDatasIds[value].StartTime))
            local timeTxt = LangUtil.BindText(self.model.taskItem[value].transform:Find("StateContent/TxtTime"))
            timeTxt.text = string.format("%02d:%02d:%02d", tb.hour, tb.minute, tb.second)
            timeTxt.transform:GetComponent("Text").fontStyle = 1
        end
    end
end

function this.GetAllSelectCards(self)
    local allCards = {}
    local cardClientData = self.expeditionComponent:GetExpeditationCardInfo()
    for key, value_1 in pairs(cardClientData) do
        for pos, cardInfo in pairs(value_1) do
            for i, v in pairs(self.cards) do
                if cardInfo.Id == i then
                    cardInfo.Star = v.Star
                    cardInfo.Level = v.Level
                    cardInfo.CloseDegree = v.CloseDegree
                end
            end
            table.insert(allCards,cardInfo)
        end
    end
    return allCards
end

-- 1、优先推荐最高等级的“未上阵角色”
-- 2、同等级下优先推荐高稀有度角色
function this.OnSortCard(self,tab)
    table.sort(tab, function(a, b)
        if a.Level > b.Level then
            return a.Level > b.Level
        elseif a.Level == b.Level  then
            a.rare = Z_Card[a.TemplateId].Rare
            b.rare = Z_Card[b.TemplateId].Rare
            if a.rare > b.rare then
                return a.rare > b.rare
            elseif a.rare == b.rare  then
                return a.Id > b.Id
            end
        end
    end)
end

function this.InitCardListData(self)
    self.list = {}
    -- 战队卡牌 移除
    for k,v in table.pairsByKeys(self.cards) do
        if UIData.GetCardTeamNo(v.Id) == nil  then
            table.insert(self.list,v)
        end
    end
    -- 当前item，已选定不清除
    local key = self.expeditionComponent:GetSelectItem()
    local currKeyData = self.expeditionComponent:GetSelectCardData(key)
    local alreadlySelectCards = this.GetAllSelectCards(self)
    if #currKeyData > 0 and #alreadlySelectCards > 0 then
        for key, value in pairs(currKeyData) do
            for i = #alreadlySelectCards, 1, -1 do
                if alreadlySelectCards[i].Id == value.Id then
                    table.remove(alreadlySelectCards,i)
                end
            end
        end
    end
    -- 非当前item 有已经选定的移除
    if #alreadlySelectCards > 0 then
        for key, value in pairs(alreadlySelectCards) do
            for i = #self.list, 1, -1 do
                if self.list[i].Id == value.Id then
                    table.remove(self.list,i)
                end
            end
        end
    end
    this.OnSortCard(self, self.list)
end

local function OnStartSelectData(self,cardInfo)
    local currData = {}
    currData.TemplateId = cardInfo.TemplateId
    currData.Star = cardInfo.Star
    currData.Level = cardInfo.Level
    currData.Id = cardInfo.Id
    currData.CloseDegree = cardInfo.CloseDegree
    local keyItem = self.expeditionComponent:GetSelectItem()
    self.expeditionComponent:SetSelectCardData(keyItem,currData)
end

local function OnFinishSelectData(self)
    OnSetExpeditationCardInfo(self)
    this.OnRefreshHideUI(self)
end

function this.ShowToast(self,index,selectContent)
    for i = 1, 4 do
        this.HideSelect(self,selectContent,i)
    end
    self.expeditionComponent:RemoveSelectCardData(index)
    OnSetExpeditationCardInfo(self)
    UIUtil.ToolTipFourth(LangUtil.GetSysLang(4105))
end

function this.HideSelect(self,selectContent,i)
    local tnf = selectContent.transform:GetChild(i-1)
    local icon = tnf:Find("Icon/Value"):GetComponent("Image")
    local frame = tnf:Find("Frame"):GetComponent("Image")
    frame.gameObject:SetActive(false)
    local spriteRes = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Public/touming.png")
    local frameRes = AtlasManager:GetInstance():CoLoadImageAsync("UI/Image/Competition/frame-default.png")
    icon.transform:GetComponent("Image").sprite = spriteRes
    frame.transform:GetComponent("Image").sprite = frameRes
    local starRoot = tnf:Find("Star")
    starRoot.gameObject:SetActive(false)
    local lvFrame = tnf:Find("Level")
    lvFrame.gameObject:SetActive(false)
end

function this.OnTransTaskState(self,index,transState)
    self.taskDatasIds[index].State = transState
    self.expeditionComponent:SetExpeditationTaskInfo(self.taskDatasIds)
    this.OnRefresh(self)
end

function this.ShowCardsUIData(self,index,selectContent)
    local allCardInfo =  self.expeditionComponent:GetSelectCardData(index)
    this.OnSortCard(self,allCardInfo)
    local func = function(transform, cardInfo)
        local zCard = Z_Card[cardInfo.TemplateId]
        local starRoot = transform:Find("Star")
        local icon = transform:Find("Icon/Value"):GetComponent("Image")
        local frame = transform:Find("Frame"):GetComponent("Image")
        local lvTxt = transform:Find("Level/Value"):GetComponent("Text")
        for i = 0,starRoot.childCount - 1 do
            starRoot:GetChild(i).gameObject:SetActive((i + 1 ) <= cardInfo.Star)
        end
        icon.color.a = 1
        lvTxt.text=  "LV "..cardInfo.Level
        UIUtil.SetCardSprite(icon,zCard.Id,cardInfo.SkinId,CardPictureType.Little,true)
        UIUtil.SetSprite(frame,AtlasConfig.CardLittleFrame,UIPublic.RareNames[zCard.Rare]..".png",true)
    end
    for key, value in pairs(allCardInfo) do
        local tnf = selectContent.transform:GetChild(key - 1)
        if tnf == nil then return end
        tnf.gameObject:SetActive(true)
        local starRoot = tnf:Find("Star")
        starRoot.gameObject:SetActive(true)
        local lvFrame = tnf:Find("Level")
        lvFrame.gameObject:SetActive(true)
        local frame = tnf:Find("Frame")
        frame.gameObject:SetActive(true)
        for idx = 0, starRoot.childCount - 1 do
            starRoot:GetChild(idx).gameObject:SetActive(false)
        end
        func(tnf, allCardInfo[key])
    end

    if #allCardInfo < 4 then
        for i = 4, #allCardInfo + 1, -1 do
            this.HideSelect(self,selectContent,i)
        end
    end
end

function this.changeSkin(self,skeletonGraphic,palyerId)
    skeletonGraphic.AnimationState:ClearTracks();
    coroutine.start(function ()
        local riskCardSpine = Z_RiskCardSpine[palyerId]
        local path="UI/SpineAnimations/xiaoren/".. riskCardSpine.DataAsset .. ".asset"
        local pathMat="UI/SpineAnimations/xiaoren/".. riskCardSpine.Material .. ".mat"
       skeletonGraphic.skeletonDataAsset = ResourcesManager:GetInstance():CoLoadAsync(path,typeof(CS.Spine.Unity.SkeletonDataAsset))
       skeletonGraphic.material = ResourcesManager:GetInstance():CoLoadAsync(pathMat,typeof(Material))
       skeletonGraphic.initialSkinName= riskCardSpine.SkinName
       skeletonGraphic:Initialize(true)
    end)
end

function this.InitItems(self,index,item,hideContent)
    local taskData = Z_Expedition[self.taskDatasIds[index].Rare]
    local currState = self.taskDatasIds[index].State
    local door = item.transform:Find("SprTaskType").gameObject
    local txtTittle = item.transform:Find("TxtTittle").gameObject
    local stateContent = item.transform:Find("StateContent").gameObject
    local txtTaskName = item.transform:Find("TxtTaskName").gameObject
    local txtTime = item.transform:Find("StateContent/TxtTime").gameObject
    local txtTaskReward = item.transform:Find("TxtTaskReward").gameObject
    local taskReward = item.transform:Find("TaskReward").gameObject
    local finish = item.transform:Find("Finish").gameObject
    local txtFinish = finish.transform:Find("Text").gameObject
    local txtState = item.transform:Find("StateContent/StateBg/Text").transform:GetComponent("Outline")
    local selectContent = item.transform:Find("Selects").gameObject
    local bgHide = item.transform:Find("BgHide").gameObject
    local inTask = item.transform:Find("InTask").gameObject
    local staticImage = door.transform:Find("StaticImage").transform:GetComponent("Image")
    staticImage.gameObject:SetActive(currState == TaskState.WaitGet)
    local skeletonGraphic = door.transform:Find("Spine").transform:GetComponent("SkeletonGraphic")
    skeletonGraphic.gameObject:SetActive(currState ~= TaskState.WaitGet)
    local finishFlash = item.transform:Find("FinishFlash").gameObject
    LangUtil.BindText(txtTittle).text =  string.format(LangUtil.GetSysLang(4094),taskData.RecommendLv)
    LangUtil.BindText(txtTaskName).text = LangUtil.GetSysLang(4112 + self.taskDatasIds[index].Rare)
    door.transform:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync( string.format("UI/Image/Expedition/%s.png",RareDoorConfig[self.taskDatasIds[index].Rare]))
    stateContent.transform:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync( string.format("UI/Image/Expedition/%s.png",StateBgConfig[currState]))
    if currState == TaskState.WaitGet then
        finishFlash:SetActive(false)
        inTask:SetActive(false)
        LangUtil.BindText(txtState.gameObject).text = LangUtil.GetSysLang(4095)
        txtState.enabled = false
        LangUtil.BindText(selectContent).text = ""
        LangUtil.BindText(txtTime).text = string.format("%02d:00:00",taskData.Duration)
        local palyerInfo = Z_RiskCardSpine[RareRoleConfig[self.taskDatasIds[index].Rare]]
        staticImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync( string.format("UI/Risk/CardQ/%s.png",palyerInfo.SkinId))
        for i = 1, 4 do
            this.HideSelect(self,selectContent,i)
        end
    elseif currState == TaskState.InTask then
        finishFlash:SetActive(false)
        inTask:SetActive(true)
        LangUtil.BindText(txtState.gameObject).text = LangUtil.GetSysLang(4127)
        txtState.enabled = true
        txtState.effectColor = Color.New(24/255,126/255,77/255,128/255)
        LangUtil.BindText(selectContent).text = LangUtil.GetSysLang(4129)
        this.ShowCardsUIData(self,index,selectContent)
        this.changeSkin(self,skeletonGraphic,RareRoleConfig[self.taskDatasIds[index].Rare])
    else
        finishFlash:SetActive(true)
        finishFlash.transform:GetComponent("Image"):DOFade(0,1):SetLoops(-1,LoopType.Yoyo)
        inTask:SetActive(true)
        hideContent:SetActive(true)
        LangUtil.BindText(txtState.gameObject).text = LangUtil.GetSysLang(4111)
        txtState.enabled = true
        txtState.effectColor = Color.New(153/255,97/255,38/255,128/255)
        LangUtil.BindText(selectContent).text = LangUtil.GetSysLang(4129)
        LangUtil.BindText(txtTime).text = string.format("%02d:00:00",0)
        this.ShowCardsUIData(self,index,selectContent)
        this.changeSkin(self,skeletonGraphic, RareRoleConfig[self.taskDatasIds[index].Rare])
    end
    LangUtil.BindText(txtTaskReward)
    LangUtil.BindText(txtFinish)
    finish:SetActive(currState == TaskState.Finish)
    this.InitRewards(self,taskReward,taskData.Rewards)
    UIUtil.AddBtnEvent(item,function(go)
        local active = hideContent.activeSelf
        hideContent:SetActive(not active)
        bgHide:SetActive(not active)
    end)
    item.transform:GetComponent("Button").enabled =  (currState ~= TaskState.Finish)
    txtTime.transform:GetComponent("Text").fontStyle = 1
end

function this.InitHideItems(self,index,item,hideContent,isShowToast)
    local taskData = Z_Expedition[self.taskDatasIds[index].Rare]
    local currState = self.taskDatasIds[index].State
    local txtTaskCondition = hideContent.transform:Find("TxtTaskCondition").gameObject
    local txtSelectRole = hideContent.transform:Find("TxtSelectRole").gameObject
    local conditions = hideContent.transform:Find("Conditions").gameObject
    local selectContent = hideContent.transform:Find("BtnSelects").gameObject
    local btnRecommend = hideContent.transform:Find("BtnRecommend").gameObject
    local txtBtnRecommend = btnRecommend.transform:Find("Text").gameObject
    local btnGo = hideContent.transform:Find("BtnGo").gameObject
    btnGo:SetActive(currState == TaskState.WaitGet)
    local txtbtnGo = btnGo.transform:Find("Text").gameObject
    LangUtil.BindText(txtTaskCondition).text =  LangUtil.GetSysLang(4098)
    LangUtil.BindText(txtSelectRole).text =  LangUtil.GetSysLang(4126)
    LangUtil.BindText(txtBtnRecommend).text = LangUtil.GetSysLang(4103)
    local btnRecall = hideContent.transform:Find("BtnRecall").gameObject
    btnRecall:SetActive(currState == TaskState.InTask)
    local txtBtnRecall = btnRecall.transform:Find("Text").gameObject
    local btnAcceleration = hideContent.transform:Find("BtnAcceleration").gameObject
    btnAcceleration:SetActive(currState == TaskState.InTask)
    local txtBtnAcceleration = btnAcceleration.transform:Find("Text").gameObject
    local btnFinish = hideContent.transform:Find("BtnFinish").gameObject
    btnFinish:SetActive(currState == TaskState.Finish)
    local txtBtnFinish = btnFinish.transform:Find("Text").gameObject
    LangUtil.BindText(txtBtnRecall).text = LangUtil.GetSysLang(4108)
    LangUtil.BindText(txtBtnAcceleration).text = LangUtil.GetSysLang(4107)
    LangUtil.BindText(txtBtnFinish).text = LangUtil.GetSysLang(4128)
    this.InitConditions(self,conditions,taskData,false,false,false)
    UIUtil.AddBtnEvent(btnRecommend,function(go)
        self.expeditionComponent:SetSelectItem(index)
        this.InitCardListData(self)
        self.expeditionComponent:RemoveSelectCardData(index)
        for key, value in pairs(self.list) do
            if #self.list >= 4 then
                if key <= 4 then
                    OnStartSelectData(self,value)
                end
            else
                OnStartSelectData(self,value)
            end
        end
        OnFinishSelectData(self)
    end)
    if currState == TaskState.WaitGet then
        this.ChangBtnState(self,btnRecommend,nil,true, Color.white,Color.white, Color.New(31/255,79/255,155/255,1))
    else
        this.ChangBtnState(self,btnRecommend,self.mat,false, Color.New(1,1,1,0.5),Color.New(1,1,1,0.5), Color.New(56/255,61/255,64/255,1))
    end
    UIUtil.AddBtnEvent(btnRecall,function(go)
        local function func()
            coroutine.start(function ()
                -- local data = {}
                -- data.taskId = index
                -- data.taskData = allCardInfo
                -- local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                --         OuterOpcode.Name2Code.ETModel_C2PM_ParticipatorList, data)
                -- if info and info.Error == ErrorCode.ERR_Success then
                --     this.OnTransTaskState(self,index,TaskState.WaitGet)
                -- end
            end)
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIExpeditionTip,{type = 3,func = func});
    end)

    UIUtil.AddBtnEvent(btnAcceleration,function(go)
        local str = item.transform:Find("StateContent/TxtTime").transform:GetComponent("Text").text
        local tab = string.split(str,":")
        local leftHour = tonumber(tab[1])
        if tonumber(tab[2]) > 0 then
            leftHour = leftHour + 1
        end
        local function func()
            coroutine.start(function ()
                -- local data = {}
                -- data.taskId = index
                -- data.taskData = allCardInfo
                -- local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                --         OuterOpcode.Name2Code.ETModel_C2PM_ParticipatorList, data)
                -- if info and info.Error == ErrorCode.ERR_Success then
                --     this.OnTransTaskState(self,index,TaskState.Finish)
                -- end
            end)
            this.OnTransTaskState(self,index,TaskState.Finish)
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIExpeditionTip,{type = 2,func = func,leftHour = leftHour});
    end)

    UIUtil.AddBtnEvent(btnFinish,function(go)
        -- coroutine.start(function ()
        --     local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
        --             OuterOpcode.Name2Code.ETModel_C2PM_ParticipatorList, {taskId = index})
        --     if info and info.Error == ErrorCode.ERR_Success then
        --         -- 发放奖励 TODO
        --         this.OnTransTaskState(self,index,TaskState.WaitGet)
        --         this.FreshTaskData(self,index)
        --     end
        -- end)
    end)

    for pos = 1,selectContent.transform.childCount do
        local item = selectContent.transform:GetChild(pos-1).gameObject
        UIUtil.AddBtnEvent(item,function(go)
            self.expeditionComponent:SetSelectItem(index)
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIExpeditionSelectCard);
        end)
    end

    local allCardInfo =  self.expeditionComponent:GetSelectCardData(index)
    if #allCardInfo > 0 then
        this.OnSortCard(self,allCardInfo)
        if this.IsMeetConditions(self,index,conditions,taskData) then
            LangUtil.BindText(txtbtnGo).text = LangUtil.GetSysLang(4112)
            this.ChangBtnState(self,btnGo,nil,true, Color.white,Color.white,Color.New(153/255,97/255,38/255,1))
            UIUtil.AddBtnEvent(btnGo,function(go)
                if self.expeditionComponent.canGetCount == 0 then
                    UIUtil.ToolTipFourth("HaHa,别搞了，队伍满了BRO！")
                    return
                end
                self.taskDatasIds[index].StartTime = TimeUtil.OSTime()
                self.expeditionComponent:SetExpeditationTaskInfo(self.taskDatasIds)
                -- coroutine.start(function ()
                --     local data = {}
                --     data.taskId = index
                --     data.taskData = allCardInfo
                --     local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                --             OuterOpcode.Name2Code.ETModel_C2PM_ParticipatorList, data)
                --     if info and info.Error == ErrorCode.ERR_Success then
                --         this.OnTransTaskState(self,index,TaskState.InTask)
                --     end
                -- end)
                this.OnTransTaskState(self,index,TaskState.InTask)
            end)
        else
            LangUtil.BindText(txtbtnGo).text = LangUtil.GetSysLang(4105)
            this.ChangBtnState(self,btnGo,self.mat,false, Color.New(1,1,1,0.5),Color.gray, Color.New(56/255,61/255,64/255,1))
            -- if isShowToast then
            --     this.ShowToast(self,index,selectContent)
            -- end
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(4105))
        end
        this.ShowCardsUIData(self,index,selectContent)
    else
        LangUtil.BindText(txtbtnGo).text = LangUtil.GetSysLang(4125)
        this.ChangBtnState(self,btnGo,self.mat,false, Color.New(1,1,1,0.5),Color.gray, Color.New(56/255,61/255,64/255,1))
        for i = 1,selectContent.transform.childCount do
            this.HideSelect(self,selectContent,i)
        end
    end
    this.IsCanClick(self,hideContent,index)
end

function this.ChangBtnState(self,btn,mat,isEnabled,colorImg,colorTxt,colorOutline)
    btn.transform:GetComponent("Image").material = mat
    btn.transform:GetComponent("Button").enabled = isEnabled
    btn.transform:GetComponent("Image").color = colorImg
    btn.transform:Find("Text").transform:GetComponent("Text").color = colorTxt
    btn.transform:Find("Text").transform:GetComponent("Outline").effectColor = colorOutline
end

-- 客户端存储数据并更新
function this.UpdataClientCards(self)
    local cardClientData = self.expeditionComponent:GetExpeditationCardInfo()
    for key, value in pairs(cardClientData) do
        for key_1, cardInfo in pairs(value) do
            for i, v in pairs(self.cards) do
                if cardInfo.Id == i then
                    cardInfo.Star = v.Star
                    cardInfo.Level = v.Level
                    cardInfo.CloseDegree = v.CloseDegree
                end
            end
            self.expeditionComponent:SetSelectCardData(key,cardInfo)
        end
    end
end

function this.ResetIntaskCards(self)
    for key, value in pairs(sortTab) do
        if self.taskDatasIds[value].State == TaskState.WaitGet then
            self.expeditionComponent:RemoveSelectCardData(value)
            OnSetExpeditationCardInfo(self)
        end
        self.model.taskItemHide[value]:SetActive(false)
    end
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.mat = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/UI-GreyDefault.mat", typeof(Material))
    self.cards = Game.Scene.Player:GetComponent("CardComponent").Cards
    self.expeditionComponent = Game.Scene.Player:GetComponent("ExpeditionComponent")
    self.taskDatasIds = this.GetAllTaskData(self)

    self.returnButton = self.rc:GetObject("ReturnButton")
    self.textTittle = self.rc:GetObject("TextTittle")
    self.textFreshLeftCount = self.rc:GetObject("TextFreshLeftCount")
    self.freshButton = self.rc:GetObject("FreshButton")
    self.freshButtonText = self.rc:GetObject("FreshButtonText")
    self.content = self.rc:GetObject("Content")
    self.takeButtonText = self.rc:GetObject("TakeButtonText")
    self.explainButton = self.rc:GetObject("ExplainButton")
    self.explainContent = self.rc:GetObject("ExplainContent")
    self.rewardButton = self.rc:GetObject("RewardButton")
    self.rewardContent = self.rc:GetObject("RewardContent")
    for key, value in pairs(sortTab) do
        local item = self.content.transform:Find(string.format("item (%s)",value-1)).gameObject
        local itemHide = self.content.transform:Find(string.format("hideItem (%s)",value-1)).gameObject
        table.insert(self.model.taskItem,item);
        table.insert(self.model.taskItemHide,itemHide);
    end
    this.UpdataClientCards(self)
    this.InitCardListData(self)
    this.ResetIntaskCards(self)
    UIUtil.AddBtnEvent(self.returnButton,function(go)
        this.ResetIntaskCards(self)
        self.ctrl:CloseSelf();
    end)
    UIUtil.AddBtnEvent(self.freshButton,function(go)
        local function func()
            -- coroutine.start(function ()
            --     local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            --             OuterOpcode.Name2Code.ETModel_C2PM_ParticipatorList, {})
            --     if info and info.Error == ErrorCode.ERR_Success then
            --         this.FreshTaskData(self)
            --     end
            -- end)
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIExpeditionTip,{type = 1,func = func});
    end)
    UIUtil.AddBtnEvent(self.explainButton,function(go)
        self.explainContent:SetActive(not self.explainContent.activeSelf)
    end)
    UIUtil.AddBtnEvent(self.rewardButton,function(go)
        self.rewardContent:SetActive(not self.rewardContent.activeSelf)
    end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.textTittle).text = LangUtil.GetSysLang(4091)
    LangUtil.BindText(self.explainContent.transform:Find("Text")).text = LangUtil.GetSysLang(4091)
    LangUtil.BindText(self.rewardButton.transform:Find("Text")).text = LangUtil.GetSysLang(4130)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

function this.SortToFront(self)
    local tempTab = sortTab
    local selectCards = self.expeditionComponent:GetSelectCardData()
    for i = #tempTab, 1, -1 do
        local value = tempTab[i]
        if self.taskDatasIds[i].State == TaskState.Finish then
            table.insert(sortTab,1,sortTab[value])
            table.remove(sortTab,value+1)
            table.insert(self.taskDatasIds,1,self.taskDatasIds[value])
            table.remove(self.taskDatasIds,value+1)
            table.insert(selectCards,1,selectCards[value])
            table.remove(selectCards,value+1)
        end
    end
end

function this.InitUI(self)
    for key, value in pairs(sortTab) do
        this.InitItems(self,value,self.model.taskItem[value],self.model.taskItemHide[value])
        this.InitHideItems(self,value,self.model.taskItem[value],self.model.taskItemHide[value],false)
    end
end

function this.InitTotalRewardData(self)
    local txtCoin = self.rewardContent.transform:Find("Coin/Text").transform:GetComponent("Text")
    local txtTimeTicket = self.rewardContent.transform:Find("TimeTicket/Text").transform:GetComponent("Text")
    local txtStarStone = self.rewardContent.transform:Find("StarStone/Text").transform:GetComponent("Text")
    local txtStarSand = self.rewardContent.transform:Find("StarSand/Text").transform:GetComponent("Text")
    local txtPearl = self.rewardContent.transform:Find("Pearl/Text").transform:GetComponent("Text")
    local txtCrystal = self.rewardContent.transform:Find("Crystal/Text").transform:GetComponent("Text")
    LangUtil.BindText(txtCoin.gameObject).text = 8848
    txtCoin.fontStyle = 1
    LangUtil.BindText(txtTimeTicket.gameObject).text = 8848
    txtTimeTicket.fontStyle = 1
    LangUtil.BindText(txtStarStone.gameObject).text = 8848
    txtStarStone.fontStyle = 1
    LangUtil.BindText(txtStarSand.gameObject).text = 8848
    txtStarSand.fontStyle = 1
    LangUtil.BindText(txtPearl.gameObject).text = 8848
    txtPearl.fontStyle = 1
    LangUtil.BindText(txtCrystal.gameObject).text = 8848
    txtCrystal.fontStyle = 1
end

function this.OnRefresh(self)
    LangUtil.BindText(self.textFreshLeftCount).text = string.format("%s/10",self.expeditionComponent.leftCount)
    LangUtil.BindText(self.takeButtonText).text = string.format(LangUtil.GetSysLang(4092),self.expeditionComponent.canGetCount,3)
    if self.expeditionComponent.leftCount == 0 then
        LangUtil.BindText(self.freshButtonText).text = LangUtil.GetSysLang(4096)
        self.freshButton.transform:GetComponent("Image").material = self.mat
        self.freshButton.transform:GetComponent("Button").enabled = false
    else
        LangUtil.BindText(self.freshButtonText).text = LangUtil.GetSysLang(326)
        self.freshButton.transform:GetComponent("Image").material = nil
        self.freshButton.transform:GetComponent("Button").enabled = true
    end

    -- 完成任务放前面,数据排序
    this.SortToFront(self)

    -- 初始化界面
    this.InitUI(self)

    -- 初始全部奖励界面
    this.InitTotalRewardData(self)
end

function this.OnRefreshHideUI(self)
    local itemKey = self.expeditionComponent:GetSelectItem()
    local item = self.model.taskItem[itemKey]
    local hideContent = self.model.taskItemHide[itemKey]
    this.InitHideItems(self,itemKey,item,hideContent,true)
end

function this.OnExpSelectCard(self)
    this.OnRefreshHideUI(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_EXP_SELECTCARD, this.OnExpSelectCard)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_EXP_SELECTCARD)
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

