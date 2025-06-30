local this = require 'UI.ToolTip.ToolTipRisk.RiskEnterView'
local prefabName = "RiskMapItem"
local prefabNamePoint = "RiskMapPointItem"

function this.OnMapCreate(self)
    
    self.langRc = self.ChangeMap.transform:GetComponent("ReferenceCollector")
    --self.ChangeMap = self.rc:GetObject("ChangeMap")
    self.ChangeClose_but = self.langRc:GetObject("ChangeClose_but")
    self.confirmChange_but = self.langRc:GetObject("confirmChange_but")
    self.point = self.langRc:GetObject("point")

    self.Left_but = self.langRc:GetObject("Left_but")
    self.Right_but = self.langRc:GetObject("Right_but")
    self.Content0 = self.langRc:GetObject("Content0")
    self.Content1 = self.langRc:GetObject("Content1")

    self.Dialog = self.langRc:GetObject("Dialog")
    self.DialogClose_btn = self.langRc:GetObject("DialogClose_btn")
    self.DialogUnChange_btn = self.langRc:GetObject("DialogUnChange_btn")
    self.DialogChange_btn = self.langRc:GetObject("DialogChange_btn")
    
    
    UIUtil.AddBtnEvent(self.map_back_btn, function ()
        self.risk_component:ShowScene()
        self:OnCloseMap()
    end)
    UIUtil.AddBtnEvent(self.Left_but, function () self:OnMapLastPage() end)
    UIUtil.AddBtnEvent(self.Right_but, function () self:OnMapNextPage() end)
    UIUtil.AddBtnEvent(self.confirmChange_but, function () self.Dialog.gameObject:SetActive(true)   end)
    UIUtil.AddBtnEvent(self.ChangeClose_but, function () self:OnCloseMap() end)
    UIUtil.AddBtnEvent(self.DialogClose_btn, function () self.Dialog.gameObject:SetActive(false)   end)
    UIUtil.AddBtnEvent(self.DialogUnChange_btn, function () self.Dialog.gameObject:SetActive(false)   end)
    UIUtil.AddBtnEvent(self.DialogChange_btn, function () self.Dialog.gameObject:SetActive(false)  self:OnChangeMap()  end)
end

function this.OnMapLang(self)
    
    LangUtil.BindText(self.langRc:GetObject("ChangeTitle")).text = LangUtil.GetSysLang(1110)
    LangUtil.BindText(self.langRc:GetObject("DialogTitle")).text = LangUtil.GetSysLang(9)
    LangUtil.BindText(self.DialogChange_btn.transform:Find("Text")).text = LangUtil.GetSysLang(1111)
    LangUtil.BindText(self.DialogUnChange_btn.transform:Find("Text")).text = LangUtil.GetSysLang(1115)
    LangUtil.BindText(self.langRc:GetObject("DialogMeg")).text = LangUtil.GetSysLang(1114)
    self.hintText = LangUtil.BindText(self.langRc:GetObject("changehintText"))
end

function this.InitMapScroll(self,page,Pos)
    self.currentMapList = {}
    local contentId =  page % 2
    local a = self["Content" .. contentId]
    local Content = a:GetComponent(typeof(RectTransform))
    Content.anchoredPosition = Vector2.New(Pos, 0)
    for i = 0, 2 do
        local tf  =   a.transform:GetChild(i) 
        local data = Z_CatRiskMap[(page-1)*3 + i + 1]
        
        
        self.currentMapList[i+1]=tf
        if data == nil then
            tf:Find("Bg").gameObject:SetActive(false)
            tf:Find("MapLock").gameObject:SetActive(true)
        else
            --if data.Id == 0 then
            --    tf:Find("Bg").gameObject:SetActive(false)
            --    tf:Find("MapLock").gameObject:SetActive(true)
            --    return
            --end
            tf:Find("Bg").gameObject:SetActive(true)
            tf:Find("MapLock").gameObject:SetActive(false)
            LangUtil.BindText( tf:Find("Bg/Title")).text = data.Name
            LangUtil.BindText( tf:Find("Bg/RewardHint")).text = LangUtil.GetSysLang(1107)
            --UIUtil.AddBtnEvent(tf:Find("Bg"), function ()self.MapId = data.Id  end)
            local MapIcon = tf:Find("Bg/MapIcon"):GetComponent("Image")
            local rewards = tf:Find("Bg/MapIcon/Rewards")
            local MapSelect = tf:Find("Bg/MapSelect")
            local New = tf:Find("Bg/New")

            MapSelect.gameObject:SetActive(self.selectMapId == data.Id )
            UIUtil.AddBtnEvent(tf:Find("Bg"), function () self.selectMapId = data.Id  self:chooseMap(i+1) end)
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
        end
    end
    if Pos ~= nil then
        --if Pos > 0 then
        if contentId == 1 then
            self.Content0.transform:GetComponent(typeof(RectTransform)):DOLocalMove(Vector2.New(-Pos,0),0)
            Content.transform:DOLocalMove(Vector2.New(0,0),0)
        else
            self.Content1.transform:GetComponent(typeof(RectTransform)):DOLocalMove(Vector2.New(-Pos,0),0)
            Content.transform:DOLocalMove(Vector2.New(0,0),0)
        end
    end
    self:ReferencePiont()
    

end

function this.chooseMap(self,Id)
    for i = 1, 3 do
        self.currentMapList[i].transform:Find("Bg/MapSelect").gameObject:SetActive(i == Id)
    end
    
end


function this.Point(self)
    ListChildPool:GetInstance():ClearContent(self.point)
    coroutine.start(function ()
        for i = 1, self.CountPage do
            ListChildPool:GetInstance():GetChild(prefabNamePoint,self.point ,function(gameObject)
                gameObject.transform:Find("Light").gameObject:SetActive(self.currentPage == i)
            end)
        end
    end)
   
end



function this.OnOpenMap(self)
    self.selectMapId = self.data.mapId
    self.Maplist =  Z_CatRiskMap
    --if table.count(self.Maplist)<2 then
    --    --table.insert(self.list,{Id = 0})
    --    --self.Maplist[100000] = {Id = 0}
    --    --self.Maplist[100001] = {Id = 0}
    --end
    self.Dialog.gameObject:SetActive(false)
    self.currentPage = 1
    local count = table.count(self.Maplist)
    self.CountPage = math.ceil(count / 3)
    self:InitMapScroll( self.currentPage)
    self:Point()
    self.ChangeMap:SetActive(true)
    local outline = self.confirmChange_but.transform:Find("Text"):GetComponent("Outline")
    local txt = self.confirmChange_but.transform:Find("Text"):GetComponent("Text")
    if self.data.remainMapTime ~= 0  then
        UIPublic.InitButton(self.confirmChange_but,true,1,LangUtil.GetSysLang(1111))
        outline.effectColor = Color.New(149/255,93/255,28/255,1)
        txt.color =  Color.New(1,1,1,1)
        self.hintText.text = LangUtil.GetSysLang(1112)..":"..self.data.remainMapTime
    else
        UIPublic.InitButton(self.confirmChange_but,false,1,LangUtil.GetSysLang(1111))
        outline.effectColor = Color.New(153/255,153/255,153/255,1)
        txt.color =  Color.New(227/255,227/255,227/255,0.5)
        self.hintText.text = LangUtil.GetSysLang(1113)
    end
end

function this.RefreshMapTime(self)

end

function this.OnMapLastPage(self)
    if self.currentPage<=1 then
        self.currentPage = 1
    else
        self.currentPage = self.currentPage-1
        self:InitMapScroll(self.currentPage,-1393)
    end
end

function this.OnMapNextPage(self)
    if self.currentPage>=self.CountPage then
        self.currentPage = self.CountPage
    else
        self.currentPage = self.currentPage + 1
        self:InitMapScroll(self.currentPage,1393)
    end
end

function this.ReferencePiont(self)
    for i = 0, self.point.transform.childCount-1 do
        self.point.transform:GetChild(i).transform:Find("Light").gameObject:SetActive(self.currentPage == i+1)
    end
    if self.currentPage>=self.CountPage  then
        UIPublic.InitButton(self.Right_but,false,1)
        self.Right_but:GetComponent("Image"):DOFade(0.5,0)
    else
        UIPublic.InitButton(self.Right_but,true,1)
        self.Right_but:GetComponent("Image"):DOFade(1,0)
    end
    if self.currentPage<=1 then
        UIPublic.InitButton(self.Left_but,false,1)
        self.Left_but:GetComponent("Image"):DOFade(0.5,0)
    else
        UIPublic.InitButton(self.Left_but,true,1)
        self.Left_but:GetComponent("Image"):DOFade(1,0)
    end
end

function this.OnChangeMap(self)

    --self.data.mapId = self.selectMapId
    
    coroutine.start(function ()
        self.risk_component:ChangeScene(self.selectMapId, true,function ()
            --self.risk_component:ShowScene()
            if self.ModeId == 1 then
                self:OnRefresh()
            else
                local wnd = UIManager:GetInstance():GetWindow(UIWindowNames.UIRisk)
                if wnd ~= nil and wnd.Active then
                    wnd.View:OnRefresh()
                end
            end
            self:OnCloseMap()



        end)
    
    end)
   
end

function this.OnCloseMap(self)
    if self.ModeId == 1 then
        self.HomeTip.gameObject:SetActive(true)
    else
        UIManager:GetInstance():CloseWindow(UIWindowNames.RiskEnter)
    end
    self.ChangeMap:SetActive(false)
end

return this