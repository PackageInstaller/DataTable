local UIActivityPopView = BaseClass("UIActivityPopView",UIBaseView);
local base = UIBaseView
local this = UIActivityPopView


function this.OnCreate(self)
    base.OnCreate(self);
    self.ReturnButton = self.rc:GetObject("ReturnButton")
    LangUtil.GetSpriteLang(206, function(sprite)
        self.rc:GetObject("imagetitle"):GetComponent("Image").sprite = sprite
    end)
    
    local ItemPanel = self.rc:GetObject("ItemPanel")
    self.items={}
    for i = 0, ItemPanel.transform.childCount - 1 do
        table.insert(self.items, ItemPanel.transform:GetChild(i).gameObject);
    end
    for i, v in pairs(self.items) do
        self:InitReward(v,Z_DailyReward[i])
    end
    UIUtil.AddBtnEvent(self.ReturnButton,function(go)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIActivityPop);
    end)

    self.ShowItem = self.rc:GetObject("ShowItem")
    self.ShowItem:SetActive(false)
    self.Bg = self.rc:GetObject("Bg").transform
    local subEventBg = self.ShowItem.transform:Find("EventBg").gameObject
    EventTriggerListener.Get(subEventBg).onLuaClick = function() self.ShowItem:SetActive(false) end
    
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

function this.OnLangCreate(self)
    for _, v in pairs(self.items) do
        LangUtil.BindText(v.transform:Find("NumTxt"))
    end
    self.desc = LangUtil.BindText(self.rc:GetObject("Desc"))
end

function this.OnRefresh(self)
    if Game.Scene.Player.NewToday == 0 then
        self:SendReq()
    end
    for i, v in pairs(self.items) do
        if i <= Game.Scene.Player. NewNum then
            v.transform:Find("get").gameObject:SetActive(true)
            if i == Game.Scene.Player. NewNum then
                v.transform:Find("get/Image").gameObject:SetActive(true)
            else
                v.transform:Find("get/Image").gameObject:SetActive(false)
            end
            v.transform:Find("get").gameObject:SetActive(true)
        else
            v.transform:Find("get").gameObject:SetActive(false)
            v.transform:Find("get/Image").gameObject:SetActive(false)
        end
    end
end
function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
    local monthCardComponent = Game.Scene.Player:GetComponent("MonthCardComponent");
    local story = Game.Scene.Player:GetComponent("StoryComponent").StoryChapters
    ---@type GameEventComponent
    local activityCom = Game.Scene.Player:GetComponent("GameEventComponent")
    local storyChapter = table.first(story,function (a) return a.LevelType == LevelType.LevelTypeStory  end)
    local AwardDay = monthCardComponent.AwardDay;
    local day = monthCardComponent.CurDay
    local SevenAwardDay =  monthCardComponent.SevenAwardDay
    local SevenCurDay = monthCardComponent.SevenCurDay
    local ThreeAwardDay =  monthCardComponent.ThreeAwardDay
    local ThreeCurDay = monthCardComponent.ThreeCurDay
    if day > AwardDay or SevenCurDay > SevenAwardDay or ThreeCurDay > ThreeAwardDay then
        coroutine.start(function()
            coroutine.waitforseconds(1.5)
            if Game.Scene:GetComponent("SceneComponent"):GetCurrentScene() ~= SceneConfig.HomeScene.Name then
                return
            end
            monthCardComponent:OpenMonthlyCardUI()--购买月卡
        end)
    else
        --UIManager:GetInstance():GetWindow(UIWindowNames.UIHome).View.eventImg:SetActive(false)
        coroutine.start(function()
            coroutine.waitforseconds(1.5)
            if Game.Scene:GetComponent("SceneComponent"):GetCurrentScene() ~= SceneConfig.HomeScene.Name then
                return
            end
            local GuideComplete, GuideStep ,run = Game.Scene:GetComponent("GuideComponent"):GetCurrentData()
            if run == false and UIManager:GetInstance():GetLastBgWindowName() == UIWindowNames.UIHome then
                --local faceId = Game.Scene:GetComponent("SoundComponent"):PlayFirstLoginSound()
                local home = UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
                if home ~= nil and home.View ~= nil then
                    home.View.uiDrawing:CoPlay(SoundType.Main)
                end
            end
            coroutine.waitforseconds(0.5)
            UIManager:GetInstance():GetWindow(UIWindowNames.UIHome).View.eventImg:SetActive(false)
            if storyChapter ~= nil then
                if storyChapter.CompletedSections[1].CompletedId >= 103 and table.first(activityCom.ActivityGifts, function(a) return a.Id == 33 end) == nil then
                    UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipGiftBag, { ModeId = 33 })
                elseif storyChapter.CompletedSections[1].CompletedId >= 110 and table.first(activityCom.ActivityGifts, function(a) return a.Id == 34 end) == nil then
                    UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipGiftBag, { ModeId = 34 })
                end
            end
        end)
    end
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

local function OnItem(self, info, basePos)
    local root = self.ShowItem.transform:Find("Item")

    local avatar = root:Find("Icon/Avatar"):GetComponent("Image")
    local starBg = root:Find("Icon/StarBg").gameObject
    local nameTxt = LangUtil.BindText(root:Find("Size/Name"))
    local kindTxt = LangUtil.BindText(root:Find("Kind"))
    
    coroutine.start(function()
        nameTxt.text = info.name
        kindTxt.text = info.typeName
        self.desc.text = info.desc
        UIUtil.ScrollText(nameTxt)

        UIPublic.InitItemIcon(avatar,nil, info.kind, info.id)
        starBg:SetActive(false)
        if info.kind == 7 then--装备
            UIPublic.InitEquipBg(Z_Equip[info.id], starBg:GetComponent("Image"))
            starBg:SetActive(true)
        end

        UIPublic.SetPanelPosition(root, self.Bg.transform, basePos)
        self.ShowItem:SetActive(true)
    end)
end

 function this.InitReward(self,Item,rewardInfo)
     --local bg = transform:Find("Image"):GetComponent("Image")
     local icon = Item.transform:Find("Image"):GetComponent("Image")
     local numTxt = Item.transform:Find("NumTxt"):GetComponent("Text")
     numTxt.text = rewardInfo.Amount
     local itemInfo = UIPublic.GetRewardData(rewardInfo.RewardKind, rewardInfo.RewardId)

     UIUtil.AddBtnEvent(Item.gameObject,function()
         OnItem(self, itemInfo, Item.transform.position)
     end)
     UIPublic.InitItemIcon(icon,nil, itemInfo.kind, itemInfo.id)
    
end


function this.SendReq(self)
    if Game.Scene.Player.NewToday == 1 then return end
    coroutine.start(function()
        local rr= coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
                OuterOpcode.Name2Code.ETModel_C2M_DailyReward, {})
        -- if rr.Error == ErrorCode.ERR_Success then
        --     Game.Scene.Player. NewNum = rr.Num
        --     Game.Scene.Player.NewToday = 1
        --     UIUtil.UpdateRewardInfoList({rr.RewardInfo},true)
        --     self:OnRefresh()
        -- else
        --     UIUtil.ToolTipFourth(LangUtil.GetServerError(rr.Error))
        -- end
        
    end)
end

return this;