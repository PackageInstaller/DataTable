

local RiskEnterView = BaseClass("RiskEnterView",UIBaseView)
local base = UIBaseView
local this = RiskEnterView
local prefabName = "RiskMapItem"

function this.OnCreate(self)
    base.OnCreate(self);

    require("UI.ToolTip.ToolTipRisk.RiskMap")
    require("UI.ToolTip.ToolTipRisk.RiskCharacter")
    require("UI.ToolTip.ToolTipRisk.RiskSort")
    require("UI.ToolTip.ToolTipRisk.RiskRecord")

    self.ModeId = 1
    self.ChangeMap = self.rc:GetObject("ChangeMap")
    self.cha_root = self.rc:GetObject("ChangeCharacter")
    self.RewardsRecord = self.rc:GetObject("RewardsRecord")
    self.HomeTip = self.rc:GetObject("HomeTip")
    self.HomeClose_but = self.rc:GetObject("HomeClose_but");
    self.ChangeMap_btn = self.rc:GetObject("ChangeMap_btn");
    self.Enter_btn = self.rc:GetObject("Enter_btn");
    self.Help = self.rc:GetObject("Help");
    self.help_but = self.rc:GetObject("help_but");
    self.HelpClose = self.rc:GetObject("HelpClose");
    self.MapParent = self.rc:GetObject("MapParent");
    
    self.risk_component = Game.Scene.Player:GetComponent("RiskComponent")
    --self.ZhuanChang = self.rc:GetObject("ZhuanChang")
    --self.data =  self.risk_component.data
    self.list = {}
    
    UIUtil.AddBtnEvent(self.HomeClose_but, function () UIManager:GetInstance():CloseWindow(UIWindowNames.RiskEnter) end)
    UIUtil.AddBtnEvent(self.help_but, function () self.Help.gameObject:SetActive(true) end)
    UIUtil.AddBtnEvent(self.HelpClose, function () self.Help.gameObject:SetActive(false) end)
    UIUtil.AddBtnEvent(self.Enter_btn, function ()
        --local date  = string.split(TimeUtil.Message," ")
        --date = string.gsub(date[1],"/","-")
        --if self:GetWeekNum(date) == 1 then
        --    self:ChangeScene(self.data.mapId,false,nil) -- 缓存地图
        --end
        if self.MapId == 0  then
            return
        end
        coroutine.start(function ()
            UIManager:GetInstance():GetWindow(UIWindowNames.UIBlack, true).View.zhuanChang.gameObject:SetActive(true)
            --self.ZhuanChang.gameObject:SetActive(true)
            coroutine.waitforseconds(1)
            if  ClientData:GetInstance().UpdateMap ~= self.risk_component:OnDateTime(1).."/"..ClientData:GetInstance().login_server_id  then

                self.risk_component:ChangeScene(self.MapId, false, function ()
                    UIManager:GetInstance():CloseWindow(UIWindowNames.RiskEnter)
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UIRisk)

                end)


            else

                self.risk_component:ChangeScene(self.MapId, true, function ()
                    UIManager:GetInstance():CloseWindow(UIWindowNames.RiskEnter)
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UIRisk)


                end)
            end
        end)
        
        
       
    end)
    UIUtil.AddBtnEvent(self.ChangeMap_btn, function ()
        --self.risk_component.data.mapId = self.MapId
        self.HomeTip.gameObject:SetActive(false)
        self:OnOpenMap()
        self.ChangeMap.gameObject:SetActive(true)
    end)
    
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(2)
    self.scrollView = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")

    self:InitScroll()
    self:OnMapCreate()
    self:OnChaCreate()
    self:OnSortCreate()
    self:OnRecordCreate()
end

function this.InitScroll(self)
    self.scroll:Clear()
    self.MapId = 1
    self.scroll:ScrollInit(self.list, self.scrollView, prefabName, function (arg)
        local tf = arg.go.transform
        local data = arg.data
        if data.Id == 0 then
            tf:Find("Bg").gameObject:SetActive(false)
            tf:Find("MapLock").gameObject:SetActive(true)
            return
        end
        tf:Find("Bg").gameObject:SetActive(true)
        tf:Find("MapLock").gameObject:SetActive(false)
        LangUtil.BindText( tf:Find("Bg/Title")).text = data.Name
        LangUtil.BindText( tf:Find("Bg/RewardHint")).text = LangUtil.GetSysLang(1107)
        --UIUtil.AddBtnEvent(tf:Find("Bg"), function ()self.MapId = data.Id  end)
        local MapIcon = tf:Find("Bg/MapIcon"):GetComponent("Image")
        local rewards = tf:Find("Bg/MapIcon/Rewards")
        local MapSelect = tf:Find("Bg/MapSelect")
        local New = tf:Find("Bg/New")
        
        MapSelect.gameObject:SetActive(self.MapId == data.Id  and self.data.mapId == 0  )
        UIUtil.AddBtnEvent(tf:Find("Bg"), function () self.MapId = data.Id   self.scroll:RefreshData(self.list) end)
        New.gameObject:SetActive(data.IsNew == 1)
        coroutine.start(function ()
            local path="UI/Risk/MapIcon/"..data.Id..".png"
            MapIcon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
        end)
        local reward = loadtable(data.Rewards)
        for k,v in table.pairsByKeys(reward) do
            local itemBg = rewards.transform:GetChild(k-1):Find("Bg/ItemBg"):GetComponent("Image")
            local itemIcon = rewards.transform:GetChild(k-1):Find("Bg/ItemIcon"):GetComponent("Image")
            if v.type == 1 then
                local Icon = string.split(v.Icon,"/")
                if Icon[1]=="Other" then
                    UIUtil.SetSprite(itemBg,AtlasConfig.ItemBg,"3.png",true)
                    UIUtil.SetSprite(itemIcon,AtlasConfig.Item,v.Icon,true)
                else
                    local item = Z_Item[tonumber(Icon[2])]
                    UIUtil.SetSprite(itemBg,AtlasConfig.ItemBg,item.IconBg..".png",true)
                    UIUtil.SetSprite(itemIcon,AtlasConfig.Item,GetItemIcon(item),true)
                end
            else
                -- UIUtil.SetSprite(itemIcon,AtlasConfig.Currency,Z_Currency[v.Icon].CurrencyIcon,true)
                -- UIUtil.SetSprite(itemBg,AtlasConfig.ItemBg,Z_Currency[v.Icon].IconBg..".png",true)
            end
            
        end
        
    end)
    
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("homeTitle")).text = LangUtil.GetSysLang(1101)
    LangUtil.BindText(self.rc:GetObject("homeHintText")).text = LangUtil.GetSysLang(1102)
    LangUtil.BindText(self.ChangeMap_btn.transform:Find("Text")).text = LangUtil.GetSysLang(1108)
    LangUtil.BindText(self.rc:GetObject("NumHintText")).text = LangUtil.GetSysLang(1103)
    self.NumHintValue = LangUtil.BindText(self.rc:GetObject("NumHintValue"))
    LangUtil.BindText(self.rc:GetObject("DateHintText")).text = LangUtil.GetSysLang(1104)
    self.DateHintValue = LangUtil.BindText(self.rc:GetObject("DateHintValue"))
    LangUtil.BindText(self.rc:GetObject("helpText")).text = LangUtil.GetSysLang(1105)
    LangUtil.BindText(self.rc:GetObject("HelpDesc")).text = LangUtil.GetSysLang(1109)
    self:OnMapLang()
    self:OnChaLang()
    self:OnSortLang()
    self:OnRecordLang()
end

function this.OnEnable(self)
    base.OnEnable(self);
    self.ChangeMap:SetActive(false)
    self.cha_root:SetActive(false)
    self.HomeTip.gameObject:SetActive(false)
    self.RewardsRecord.gameObject:SetActive(false)
    --self.ZhuanChang.gameObject:SetActive(false)
    self:OnRefresh();
end

function this.OnRefresh(self)
    self.data =  self.risk_component.data
    self.MapId =  self.data.mapId
    self.ModeId = self.model.data.Mode
    self.list={}
    if self.MapId == 0 then
        for k,v in table.pairsByKeys(Z_CatRiskMap) do
            table.insert(self.list,v)
        end
        if table.count(self.list)<2 then
            --table.insert(self.list,{Id = 0})
            self.list[100000] = {Id = 0}
        end
    else
        table.insert(self.list,Z_CatRiskMap[self.MapId])
    end
    if self.ModeId == 1 then
        self.NumHintValue.text = self.data.remainTime .. "/" ..self.risk_component.maxTimes
        self.ChangeMap_btn.gameObject:SetActive(self.MapId ~= 0)
        if(self.MapId == 0) then
            self.scroll:RefreshData(self.list)
            
            --self:InitScroll()
        else
            ListChildPool:GetInstance():ClearContent(self.MapParent)
            coroutine.start(function ()
                ListChildPool:GetInstance():GetChild(prefabName,self.MapParent,function(gameObject)
                    local tf = gameObject.transform
                    local data = Z_CatRiskMap[self.MapId]
                    tf:Find("Bg").gameObject:SetActive(true)
                    tf:Find("MapLock").gameObject:SetActive(false)
                    LangUtil.BindText( tf:Find("Bg/Title")).text = data.Name
                    LangUtil.BindText( tf:Find("Bg/RewardHint")).text = LangUtil.GetSysLang(1107)
                    --UIUtil.AddBtnEvent(tf:Find("Bg"), function ()self.MapId = data.Id  end)
                    local MapIcon = tf:Find("Bg/MapIcon"):GetComponent("Image")
                    local rewards = tf:Find("Bg/MapIcon/Rewards")
                    local MapSelect = tf:Find("Bg/MapSelect")
                    local New = tf:Find("Bg/New")

                    MapSelect.gameObject:SetActive(false  )
                    --UIUtil.AddBtnEvent(tf:Find("Bg"), function () self.MapId = data.Id   self.scroll:RefreshData(self.list) end)
                    New.gameObject:SetActive(false)
                    --coroutine.start(function ()
                        local path="UI/Risk/MapIcon/"..data.Id..".png"
                        MapIcon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
                    --end)
                    local reward = loadtable(Z_CatRiskMap[self.MapId].Rewards)
                    for k,v in table.pairsByKeys(reward) do
                        local itemBg = rewards.transform:GetChild(k-1):Find("Bg/ItemBg"):GetComponent("Image")
                        local itemIcon = rewards.transform:GetChild(k-1):Find("Bg/ItemIcon"):GetComponent("Image")
                        if v.type == 1 then
                            local Icon = string.split(v.Icon,"/")
                            if Icon[1]=="Other" then
                                UIUtil.SetSprite(itemBg,AtlasConfig.ItemBg,"3.png",true)
                                UIUtil.SetSprite(itemIcon,AtlasConfig.Item,v.Icon,true)
                            else
                                local item = Z_Item[tonumber(Icon[2])]
                                UIUtil.SetSprite(itemBg,AtlasConfig.ItemBg,item.IconBg..".png",true)
                                UIUtil.SetSprite(itemIcon,AtlasConfig.Item,GetItemIcon(item),true)
                            end
                        else
                            -- UIUtil.SetSprite(itemIcon,AtlasConfig.Currency,Z_Currency[v.Icon].CurrencyIcon,true)
                            -- UIUtil.SetSprite(itemBg,AtlasConfig.ItemBg,Z_Currency[v.Icon].IconBg..".png",true)
                        end

                    end
                end)
            end)
            
        end
        self.scrollView.gameObject:SetActive(self.MapId == 0)
        self.MapParent.gameObject:SetActive(self.MapId ~= 0)
        self:RefreshTime(self.data.remainTime, self.data.endDate)
        self.HomeTip.gameObject:SetActive(true)
    end
    if self.ModeId == 2 then
        self:OnOpenMap()
    end
    if self.ModeId == 3 then
        self:OnOpenCharacter()
    end
    if self.ModeId == 4 then
        self:OnRecordOpen()
    end
end

-- 更新骰子次数
function this.RefreshTime(self, remainTime, time)
    if self.risk_component == nil  then
        return
    end
    self.NumHintValue.text = self.risk_component.data.remainTime .. "/" ..self.risk_component.maxTimes
    if self.risk_component.data.remainTime >= self.risk_component.maxTimes then
        self.DateHintValue.text = string.format("%02d:%02d:%02d", 0,0, 0)
    else
        local tb = self.risk_component.ConvertTimeForm(time)
        self.DateHintValue.text = string.format("%02d:%02d:%02d", tb.hour,tb.minute, tb.second)
    end
end

function this.OnDisable(self)
    base.OnDisable(self)
    self:OnChaDisable()
end

function this.OnDestroy(self)
    base.OnDestroy(self);
    self.scroll:Dispose()
    self:OnChaDestroy()
end

return this