local this = require 'UI.ToolTip.ToolTipRisk.RiskEnterView'
local RecordItem = "RecordItem"
local RecordTitleItem = "RecordTitleItem"

function this.OnRecordCreate(self)
    self.recordRc =  self.RewardsRecord.transform:GetComponent("ReferenceCollector")
    self.RecordClose_but = self.recordRc:GetObject("RecordClose_but")
    self.More_but = self.recordRc:GetObject("More_but")
    self.PlayIcon = self.recordRc:GetObject("PlayIcon"):GetComponent("Image")
    self.FreeStarStone = self.recordRc:GetObject("FreeStarStone")
    self.PaidStarStone  = self.recordRc:GetObject("PaidStarStone ")
    self.GoldCoin = self.recordRc:GetObject("GoldCoin")
    self.recordScroll =  self.recordRc:GetObject("ScrollView")
    self.recordContent = self.recordRc:GetObject("Content")
    self.recordHint = self.recordRc:GetObject("Hint")
    
    self.MorePanel = self.recordRc:GetObject("MorePanel")
    self.MoreContent = self.recordRc:GetObject("moreContent")
    self.MorePanelTitle = self.recordRc:GetObject("MorePanelTitle")
    self.MorePanelClose_but = self.recordRc:GetObject("MorePanelClose_but")
    
    -- UIUtil.SetSprite(self.FreeStarStone.transform:Find("Image"):GetComponent("Image"),AtlasConfig.Currency,Z_Currency[3].CurrencyIcon)
    -- UIUtil.SetSprite(self.PaidStarStone.transform:Find("Image"):GetComponent("Image"),AtlasConfig.Currency,Z_Currency[2].CurrencyIcon)
    -- UIUtil.SetSprite(self.GoldCoin.transform:Find("Image"):GetComponent("Image"),AtlasConfig.Currency,Z_Currency[1].CurrencyIcon)

    UIUtil.AddBtnEvent(self.RecordClose_but, function () self:OnRecordClose() end)
    UIUtil.AddBtnEvent(self.More_but, function () self.MorePanel.gameObject:SetActive(true) end)
    UIUtil.AddBtnEvent(self.MorePanelClose_but, function () self.MorePanel.gameObject:SetActive(false) end)
   -- UIUtil.ScrollText(nameTxt)
end

function this.OnRecordLang(self)
    LangUtil.BindText(self.recordRc:GetObject("RecordTitle")).text = LangUtil.GetSysLang(1124)
    self.nameText = LangUtil.BindText(self.recordRc:GetObject("PlayNameText"))
    self.FreeStarStoneText = LangUtil.BindText(self.FreeStarStone.transform:Find("Text"),FontType.All_Number)
    self.PaidStarStoneText = LangUtil.BindText(self.PaidStarStone.transform:Find("Text"),FontType.All_Number)
    self.GoldCoinText = LangUtil.BindText(self.GoldCoin.transform:Find("Text"),FontType.All_Number)
    LangUtil.BindText(self.More_but.transform:Find("Text")).text = LangUtil.GetSysLang(1126)
    LangUtil.BindText(self.recordHint.transform:Find("Text")).text = LangUtil.GetSysLang(1127)
    LangUtil.BindText(self.recordRc:GetObject("BottomText")).text = LangUtil.GetSysLang(1125)
    LangUtil.BindText(self.MorePanelTitle).text = LangUtil.GetSysLang(1135)
    
end

function this.OnRecordOpen(self)
   
    self.recordHint.gameObject:SetActive(true)
    local player = Game.Scene.Player
    self.nameText.text = player.Nickname
    self.FreeStarStoneText.text = UIUtil.ScientificCount(player.FreeStarStone)
    self.PaidStarStoneText.text = UIUtil.ScientificCount(player.PaidStarStone)
    self.GoldCoinText.text =  UIUtil.ScientificCount(player.GoldCoin)
    UIUtil.SetPlayerIcon(self.PlayIcon , player.Avatar)
    --self.recordList = { {date = "2022-4-7" , reward = {{id=1023,num = 10},{id=1024,num = 5},{id=1002,num = 30},{id=1001,num = 30},{id=1032,num = 30},{id=1025,num = 30},{id=1041,num = 30}}},{date = "2022-4-6" , reward = {{id=1023,num = 10},{id=1024,num = 5},{id=1002,num = 30}}},{date = "2022-4-5" , reward = {{id=1023,num = 10},{id=1024,num = 5},{id=1002,num = 30}}}}
    coroutine.start(function ()
        self.risk_component:RewardsRecord( function(infoList)
            --self.risk_component:ShowScene()
            self.recordList = infoList
            self:InitRecord()
            self.RewardsRecord.gameObject:SetActive(true)
        end)
    end)
   
end

function this.InitRecord(self)
    for  k,v in table.pairsByKeys(self.recordList) do
        if table.count(v)>0 then
            self.recordHint.gameObject:SetActive(false) 
        end 
    end
    
    
    ListChildPool:GetInstance():ClearContent(self.recordContent)
    ListChildPool:GetInstance():ClearContent(self.MoreContent)
    coroutine.start(function ()
        --local date = string.split(TimeUtil.Message," ")
        --local date1 = string.split(date,"/")
        --date1 = date1[3] .."-" .. date1[2] .. date1[1]
        --local week =  self.risk_component:GetWeekNum(date)
        
        for  k,v in table.pairsByKeys(self.recordList) do
            ListChildPool:GetInstance():GetChild(RecordTitleItem,self.recordContent,function (go)

                if table.count(v)<= 0 then
                    go.gameObject:SetActive(false)
                    return ;
                end
                LangUtil.BindText(go.transform:Find("titleBg/Text")).text = LangUtil.GetSysLang(1128 + k -1) .. "  " .. self.risk_component:OnDateTime(k)
                local RecordRoot =   go.transform:Find("RewardRoot")
                ListChildPool:GetInstance():ClearContent(RecordRoot)
                self:PollRecordItem(k, v, RecordRoot)
                self:PollRecordItem(k,v,self.MoreContent)
                end)
                
        end
        LayoutRebuilder.ForceRebuildLayoutImmediate(self.recordContent:GetComponent("RectTransform"))
        LayoutRebuilder.ForceRebuildLayoutImmediate(self.MoreContent:GetComponent("RectTransform"))
    end)
end

function this.PollRecordItem(self,k,v,Content)
  
    for  a,b in table.pairsByKeys(v) do
        ListChildPool:GetInstance():GetChild(RecordItem,Content,function (go1)
            local Icon = go1.transform:Find("IconMask/Icon"):GetComponent("Image")
            local IconBg = go1.transform:Find("IconMask/IconBg"):GetComponent("Image")
            local num = go1.transform:Find("num")
            if b.RewardTypeInfo == "StarSand" then
                -- UIUtil.SetSprite(Icon,AtlasConfig.Currency,Z_Currency[4].CurrencyIcon,true)
                -- UIUtil.SetSprite(IconBg,AtlasConfig.ItemBg,Z_Currency[4].IconBg..".png",true)
            elseif b.RewardTypeInfo == "GoldCoin" then


                -- UIUtil.SetSprite(Icon,AtlasConfig.Currency,Z_Currency[1].CurrencyIcon,true)
                -- UIUtil.SetSprite(IconBg,AtlasConfig.ItemBg,Z_Currency[1].IconBg..".png",true)

            elseif b.RewardTypeInfo == "Item" then

                local zItem = Z_Item[b.TemplateId]
                UIUtil.SetSprite(Icon,AtlasConfig.Item,GetItemIcon(zItem),true)
                UIUtil.SetSprite(IconBg,AtlasConfig.ItemBg,zItem.IconBg..".png",true)
            elseif b.RewardTypeInfo == "MagicCrystal" then

                -- UIUtil.SetSprite(Icon,AtlasConfig.Currency,Z_Currency[5].CurrencyIcon,true)
                -- UIUtil.SetSprite(IconBg,AtlasConfig.ItemBg,Z_Currency[5].IconBg..".png",true)
            elseif b.RewardTypeInfo ==  "StarStone" then

                -- UIUtil.SetSprite(Icon,AtlasConfig.Currency,Z_Currency[3].CurrencyIcon,true)
                -- UIUtil.SetSprite(IconBg,AtlasConfig.ItemBg,Z_Currency[3].IconBg..".png",true)
            end

            LangUtil.BindText(num,FontType.All_Number).text =  b.Num
        end)
    end
    
end



function this.OnMorePanel(self)
    
end

function this.OnRecordClose(self)
    self.RewardsRecord.gameObject:SetActive(false)
    UIManager:GetInstance():CloseWindow(UIWindowNames.RiskEnter)
     
end

return this