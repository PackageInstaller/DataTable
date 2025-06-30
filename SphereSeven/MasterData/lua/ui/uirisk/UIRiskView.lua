local UIRiskView = BaseClass("UIRiskView", UIBaseView);
local base = UIBaseView
local this = UIRiskView

function this.MapItemInit(self)
    local Map = self.MapBG.transform:Find("Map")
    ListChildPool:GetInstance():ClearContent(Map.transform)
    local riskMap = "RiskMap"..self.MapId
    coroutine.start(function ()
        ListChildPool:GetInstance():GetChild(riskMap,Map,function (object)
            local GridPos = object.transform:Find("GridPos")
            local spine =  object.transform:Find("Spine")
            local BG1 =  object.transform:Find("BG1")
            self.portalRoot = object.transform:Find("Effects")
            spine:GetComponent("Canvas").sortingLayerName = SortingLayerNames.UI
            BG1:GetComponent("Canvas").sortingLayerName = SortingLayerNames.UI
            for i = 0, GridPos.transform.childCount -1 do
                local item = GridPos.transform:GetChild(i).transform:Find("ItemIcon"):GetComponent("Image")
                local reward ={}
                if table.count(self.data.rewardInfoList) >= i+1 then
                    reward =  self.data.rewardInfoList[i+1]
                else
                    reward.RewardTypeInfo = "Unknown"
                end
                local IsShow = 0
                if reward.RewardTypeInfo == "StarSand" then
                    IsShow = 1
                    -- UIUtil.SetSprite(item,AtlasConfig.Currency,Z_Currency[4].CurrencyIcon,true)

                elseif reward.RewardTypeInfo == "GoldCoin" then
                    IsShow = 1

                    -- UIUtil.SetSprite(item,AtlasConfig.Currency,Z_Currency[1].CurrencyIcon,true)
                elseif reward.RewardTypeInfo == "Item" then
                    IsShow = 1
                    local zItem = Z_Item[reward.TemplateId]
                    UIUtil.SetSprite(item,AtlasConfig.Item,GetItemIcon(zItem),true)
                elseif reward.RewardTypeInfo == "MagicCrystal" then
                    IsShow = 1
                    -- UIUtil.SetSprite(item,AtlasConfig.Currency,Z_Currency[5].CurrencyIcon,true)
                elseif reward.RewardTypeInfo ==  "StarStone" then
                    IsShow = 1
                    -- UIUtil.SetSprite(item,AtlasConfig.Currency,Z_Currency[3].CurrencyIcon,true)
                elseif reward.RewardTypeInfo ==  "Unknown" then
                    GridPos.transform:GetChild(i).gameObject:SetActive(false)
                    IsShow = 0
                end
                local iteminfo = {Id = i, itemTF = GridPos.transform:GetChild(i).gameObject , IsShow = IsShow  }
                table.insert(self.RiskItem,iteminfo)
            end
            self:LoadInfo()
        end)
    end)
    
end


-- 移动
local function Move(self,info)
    -- 路点寻路 self.playerPos
    self.playerPos = self.risk_component.data.playerPos
    
    if self.playerPos ~= 0 then
        coroutine.start(function ()
            if self.playerPos - self.risk_component.DiceNum + 1 > Z_CatRiskMap[self.MapId].CellCount - 1 then
                self.playerPos = info.CurrentStep
                self.risk_component.data.playerPos = info.CurrentStep
            end 
            
        local itemInfo = table.first(self.RiskItem,function (a) return a.Id == self.playerPos - self.risk_component.DiceNum + 1 end)
        local id = self.MapId*1000 + self.playerPos - self.risk_component.DiceNum + 1
        self.MapBG.transform:DOLocalMove(Vector2.New(Z_CatRisk[id].MapPos[1],Z_CatRisk[id].MapPos[2]),1)
        if self.CurrentItemTF ~= nil and itemInfo.IsShow == 1  then
           -- self.CurrentItemTF:SetActive(true)
        end
        if itemInfo ~= nil then
            self.CurrentItemTF = itemInfo.itemTF
            --itemInfo.itemTF.gameObject:SetActive(false)
            --self.Play.transform:SetParent (itemInfo.itemTF.transform.parent)
            local  iteminfoPos = itemInfo.itemTF:GetComponent(typeof(RectTransform)).anchoredPosition
            --self.Play.anchoredPosition = Vector2.New(iteminfoPos.x -17 ,iteminfoPos.y + 50 )
            local SpineName =  (self.risk_component.data.playerId < 1001 and {"zou"} or {"zolu"} )[1]
            self.SkeletonGraphic.AnimationState:SetAnimation(0,SpineName, true)
            self.Play.transform:DOLocalMove(Vector2.New(iteminfoPos.x -17 ,iteminfoPos.y + 50 ),1)
            self.Play.transform:DOScale(1,0)
            coroutine.waitforseconds(1)
            if self.risk_component.DiceNum > 1 then
                self.risk_component.DiceNum =  self.risk_component.DiceNum -1
                self.DiceNumText.text = self.risk_component.DiceNum
                Move(self,info)
            else
                self.SkeletonGraphic.AnimationState:SetAnimation(0, "daiji", true)
                self.DiceNum.gameObject:SetActive(false)
                if info ~=nil and  self.playerPos ~= info.CurrentStep then
                    local indraftPortals = Z_CatRisk[self.MapId*1000 + self.playerPos].Portals
                    local outPortals = Z_CatRisk[self.MapId*1000 + info.CurrentStep].Portals
                    self:PlayPortal(indraftPortals,1)
                    coroutine.waitforseconds(4)
                    self.risk_component.data.playerPos = info.CurrentStep
                    Move(self,nil)
                    coroutine.waitforseconds(1)
                    self:PlayPortal(outPortals,2)
                    coroutine.waitforseconds(4)
                    self:GetRewardTip(info.RewardInfoList)
                else
                    if info ~= nil then
                        self:GetRewardTip(info.RewardInfoList)
                    end
                end
                
            end
            
        end
        end)
       
    else
        local  zCatRisk = Z_CatRisk[self.MapId*1000]
        local StartGrid = self.MapBG.transform:Find("Map/RiskMap"..self.MapId .."(Clone)/GridPos/0")
        self.MapBG.transform:DOLocalMove(Vector2.New(zCatRisk.MapPos[1],zCatRisk.MapPos[2]),1)
        local  iteminfoPos = StartGrid:GetComponent(typeof(RectTransform)).anchoredPosition
        self.Play.anchoredPosition = Vector2.New(iteminfoPos.x-17,iteminfoPos.y+ 50)
        self.Play.transform:DOScale(1,0)
    end
    
   
end

function this.GetRewardTip(self,info)
    for i = 1, 2 do
        self.TipGet.transform:Find("itemRoot/ItemBg"..i).gameObject:SetActive(false)
        self.TipGetEffect.transform:Find("TipGetEffect"..i).gameObject:SetActive(false)
    end
    local IsShow = false
    for k,v in table.pairsByKeys(info)  do
        local tipItemBg =  self.TipGet.transform:Find("itemRoot/ItemBg"..k):GetComponent("Image")
        local tipItemIcon =  tipItemBg.transform:Find("ItemIcon"):GetComponent("Image")
        local name = LangUtil.BindText(tipItemBg.transform:Find("name"))
        local num = LangUtil.BindText(tipItemBg.transform:Find("Num"),FontType.All_Number)
        local tipEffect = self.TipGetEffect.transform:Find("TipGetEffect"..k):GetComponent("Image")
        IsShow = false
        tipItemBg.gameObject:SetActive(true)
        tipEffect.gameObject:SetActive(true)
        if v.RewardTypeInfo == "StarSand" then
            IsShow = true
            name.text = Z_Currency[4].Name
            -- UIUtil.SetSprite(tipItemIcon,AtlasConfig.Currency,Z_Currency[4].CurrencyIcon,true)
            -- UIUtil.SetSprite(tipEffect,AtlasConfig.Currency,Z_Currency[4].CurrencyIcon,true)
            UIUtil.SetSprite(tipItemBg,AtlasConfig.ItemBg,Z_Currency[4].IconBg..".png",true)
            
        elseif v.RewardTypeInfo == "GoldCoin" then
            IsShow = true
            name.text = Z_Currency[1].Name
            -- UIUtil.SetSprite(tipItemIcon,AtlasConfig.Currency,Z_Currency[1].CurrencyIcon,true)
            -- UIUtil.SetSprite(tipEffect,AtlasConfig.Currency,Z_Currency[1].CurrencyIcon,true)
            UIUtil.SetSprite(tipItemBg,AtlasConfig.ItemBg,Z_Currency[1].IconBg..".png",true)
        elseif v.RewardTypeInfo == "Item" then
            IsShow = true
            local zItem = Z_Item[v.TemplateId]
            name.text =  zItem.Name
            UIUtil.SetSprite(tipItemIcon,AtlasConfig.Item,GetItemIcon(zItem),true)
            UIUtil.SetSprite(tipEffect,AtlasConfig.Item,GetItemIcon(zItem),true)
            UIUtil.SetSprite(tipItemBg,AtlasConfig.ItemBg,zItem.IconBg..".png",true)
        elseif v.RewardTypeInfo == "MagicCrystal" then
            IsShow = true
            name.text =Z_Currency[5].Name
            -- UIUtil.SetSprite(tipItemIcon,AtlasConfig.Currency,Z_Currency[5].CurrencyIcon,true)
            -- UIUtil.SetSprite(tipEffect,AtlasConfig.Currency,Z_Currency[5].CurrencyIcon,true)
            UIUtil.SetSprite(tipItemBg,AtlasConfig.ItemBg,Z_Currency[5].IconBg..".png",true)
        elseif v.RewardTypeInfo ==  "StarStone" then
            IsShow = true
            name.text =Z_Currency[3].Name
            -- UIUtil.SetSprite(tipItemIcon,AtlasConfig.Currency,Z_Currency[3].CurrencyIcon,true)
            -- UIUtil.SetSprite(tipEffect,AtlasConfig.Currency,Z_Currency[3].CurrencyIcon,true)
            UIUtil.SetSprite(tipItemBg,AtlasConfig.ItemBg,Z_Currency[3].IconBg..".png",true)
        elseif v.RewardTypeInfo ==  "Unknown" then
            IsShow = false
        end
        tipEffect.transform:Find("Text"):GetComponent("Text").text = v.Num
        num.text =  "X" .. v.Num
    end
    if IsShow then
        self.TipGet.gameObject:SetActive(true)
        self.Tip.gameObject:SetActive(true)
    else
        self.TipGet.gameObject:SetActive(false)
        self.Tip.gameObject:SetActive(false)
    end
    self.throw_btn.gameObject:GetComponent("Button").enabled = true
   
end

function this.LoadInfo(self)
    
    self.MapBG.transform:DOScale(0.27,0)
    self:EffectScale(0)
    self.MapBG.transform:DOLocalMove(Vector2.New(0,0),0)
    self.Play.gameObject:SetActive(false)
    local view = UIManager:GetInstance():GetWindow(UIWindowNames.UIBlack, true).View
    coroutine.start(function ()
        coroutine.waitforseconds(1)
        self.StartEffects.gameObject:SetActive(false)
        view.zhuanChang.gameObject:SetActive(false)
        view.zhuanChang1.gameObject:SetActive(true)
        coroutine.waitforseconds(3)
        view.zhuanChang1.gameObject:SetActive(false)
        
        self.MapBG.transform:DOScale(1,0)
        self:EffectScale(1)
        Move(self,nil)
        coroutine.waitforseconds(2)
        self.MapBG.gameObject:SetActive(true)
        self.Play.gameObject:SetActive(true)
        self.Play.transform:Find("QiDian").gameObject:SetActive(true)
        -- 加载开场特效
        coroutine.waitforseconds(3)
        self.Play.transform:Find("QiDian").gameObject:SetActive(false)
        self.ReadyGo.gameObject:SetActive(true)
        self.topCanvas.gameObject:SetActive(true)
        coroutine.waitforseconds(2)
        self.ReadyGo.gameObject:SetActive(false)
    end)
end


function this.OnCreate(self)
    base.OnCreate(self)
    self.RiskItem = {}
    self.CurrentItemTF = nil
    self.MapBG = self.rc:GetObject("MapBG"):GetComponent(typeof(RectTransform))
    self.map_btn = self.rc:GetObject("MapButton")
    self.character_btn = self.rc:GetObject("CharacterButton")
     self.GetButton_btn =  self.rc:GetObject("GetButton")
    self.throw_btn = self.rc:GetObject("CurrentDice")
    self.back_btn = self.rc:GetObject("BackButton")
    self.ChangeDice = self.rc:GetObject("ChangeDice")
    self.DiceCount = self.rc:GetObject("DiceCount")
    self.date = self.rc:GetObject("Date")
    self.TipGet = self.rc:GetObject("TipGet")
    self.TipMsg = self.rc:GetObject("TipMsg")
    self.TipDiceChange = self.rc:GetObject("TipDiceChange")
    self.EventBg = self.rc:GetObject("EventBg")
    self.Tip = self.rc:GetObject("Tip")
    self.StartEffects = self.rc:GetObject("StartEffects")
    self.Effects = self.rc:GetObject("Effects")
    self.SkeletonGraphic = self.rc:GetObject("SkeletonGraphic"):GetComponent("SkeletonGraphic")
    
    self.topCanvas = self.rc:GetObject("Top")
    self.DiceMode = 0
    self.Play = self.rc:GetObject("Play"):GetComponent(typeof(RectTransform))
    self.DiceNum = self.Play.transform:Find("DiceNum")
    
    self.ReadyGo = self.rc:GetObject("ReadyGo")
    self.slotMachine = self.rc:GetObject("slotMachine")
    self.TipGetEffect =  self.rc:GetObject("TipGetEffect")
    self.DiceAni4 = self.rc:GetObject("Dice4")
    self.DiceAni12 = self.rc:GetObject("Dice12")
    self.DiceIcon = self.rc:GetObject("DiceIcon"):GetComponent("Image")
    
    self.test1 = self.rc:GetObject("1")
    self.test2 = self.rc:GetObject("2")
    
    UIUtil.AddBtnEvent(self.map_btn, function ()
        UIManager:GetInstance():OpenWindow(UIWindowNames.RiskEnter,{Mode = 2})
    end)
    UIUtil.AddBtnEvent(self.character_btn, function ()
        UIManager:GetInstance():OpenWindow(UIWindowNames.RiskEnter,{Mode = 3})
    end)
    UIUtil.AddBtnEvent(self.GetButton_btn, function ()
        UIManager:GetInstance():OpenWindow(UIWindowNames.RiskEnter,{Mode = 4})
    end)
    UIUtil.AddBtnEvent(self.throw_btn, function () self:OnDice() end)
    UIUtil.AddBtnEvent(self.back_btn, function () self.risk_component:Close() end)
    UIUtil.AddBtnEvent(self.ChangeDice, function ()  self:OnChangeDice() self:OnTipDiceChange() end)
    UIUtil.AddBtnEvent(self.EventBg, function () self:TipClose()  end)
    UIUtil.AddBtnEvent(self.TipGet.transform:Find("GetEvent"), function ()
        coroutine.start(function ()
            self.TipGetEffect.transform:DOLocalMove(Vector2.New(0,0),0)
            self.TipGetEffect.gameObject:SetActive(true)
            self:TipClose()
            local canvas = UIManager:GetInstance():GetWindow(UIWindowNames.UIRisk).Layer.unity_canvas
            local x,y,w,h = self:GetWorldToScreenRect(canvas,self.GetButton_btn.transform)
            self.TipGetEffect.transform:DOLocalMove(Vector2.New(x-w,y-h),2)
            coroutine.waitforseconds(1.8)
            self.TipGetEffect.gameObject:SetActive(false)
            self.GetButton_btn.transform:Find("Jiangli2").gameObject:SetActive(true)
            coroutine.waitforseconds(1.5)
            self.GetButton_btn.transform:Find("Jiangli2").gameObject:SetActive(false)
        end)
    end)
    local spineN = 1
    local spine = {"daiji","jinchang","kaixin","linqilai","luoxia","zhengzha","zou"}
    UIUtil.AddBtnEvent(self.test1, function ()
        spineN=spineN+1
        if spineN >7 then
            spineN = 1
        end
        self:palySpine(spine[spineN])
    end)
    
    self:OnChangeDice()
end

--把一个世界ui转成屏幕坐标
function this.GetWorldToScreenRect(self,canvas,targetTf)
    local screenPoint = canvas.worldCamera:WorldToScreenPoint(targetTf.position)
    local rc=targetTf:GetComponent(typeof(RectTransform))
    local size=rc.sizeDelta
    screenPoint=CSUtil.GetCanvasPosition(canvas, screenPoint)
    return screenPoint.x ,screenPoint.y ,size.x,size.y
end
function this.palySpine(self,playName)
    local Map = self.MapBG.transform:Find("Map")
    local sk = Map:Find("RiskMap1(Clone)/Spine/mao1"):GetComponent("SkeletonGraphic")
    local sk1 = Map:Find("RiskMap1(Clone)/Spine/mao1 (1)"):GetComponent("SkeletonGraphic")
    coroutine.start(function()
        local state = sk.AnimationState:SetAnimation(0, playName, true)
        local state1 = sk1.AnimationState:SetAnimation(0, playName, true)
    end)
    
end

function this.PlayPortal(self,id,mode)
    coroutine.start(function ()
        local men = self.portalRoot.transform:Find("Men"..id)
        local playPos = self.Play:GetComponent(typeof(RectTransform)).anchoredPosition
        local pos 
        if mode == 1 then -- 进
            local indraft = men.transform:Find("indraft").gameObject
            indraft:SetActive(true)
            self.Play.transform:DOScale(0.5,2)
            if id < 3 then
                pos = Vector2.New(playPos.x+70,playPos.y-70)
            else
                pos = Vector2.New(playPos.x,playPos.y-70)
            end

            self.Play.transform:DOLocalMove(pos,2)
            coroutine.waitforseconds(2)
            self.Play.gameObject:SetActive(false)
            coroutine.waitforseconds(2)
            indraft:SetActive(false)
        else
            local out = men.transform:Find("out").gameObject
            out:SetActive(true)
            if id < 3 then
                pos = Vector2.New(playPos.x+70,playPos.y-70)
            else
                pos = Vector2.New(playPos.x,playPos.y-70)
            end
            self.Play.transform:DOScale(0.5,0)
            self.Play.transform:DOLocalMove(pos,0)
            coroutine.waitforseconds(3)
            self.Play.transform:DOScale(1,2)
            self.Play.transform:DOLocalMove(Vector2.New(playPos.x,playPos.y),2)
            self.Play.gameObject:SetActive(true)
            coroutine.waitforseconds(1)
            out:SetActive(false)
        end
    end)
end

function this.TipClose(self)
    self.TipDiceChange.gameObject:SetActive(false)
    self.TipMsg.gameObject:SetActive(false)
    self.TipGet.gameObject:SetActive(false)
    self.Tip.gameObject:SetActive(false)
end

function this.OnLangCreate(self)
    self.date = LangUtil.BindText(self.rc:GetObject("Date"))
    self.DiceNumText = LangUtil.BindText(self.DiceNum.transform:Find("Text") , FontType.All_Number )
    LangUtil.GetSpriteLang(307,function(sprite)
        self.map_btn:GetComponent("Image").sprite = sprite
    end)
    LangUtil.GetSpriteLang(308,function(sprite)
        self.character_btn:GetComponent("Image").sprite = sprite
    end)
    LangUtil.GetSpriteLang(309,function(sprite)
        self.GetButton_btn:GetComponent("Image").sprite = sprite
    end)
    LangUtil.BindText(self.TipDiceChange.transform:Find("1/Text")).text =  LangUtil.GetSysLang(1118)
    LangUtil.BindText(self.TipDiceChange.transform:Find("2/Text")).text =  LangUtil.GetSysLang(1119)
    LangUtil.BindText(self.TipMsg.transform:Find("Text")).text =  LangUtil.GetSysLang(1117)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.risk_component = Game.Scene.Player:GetComponent("RiskComponent")
    
    
    self.topCanvas:GetComponent("Canvas").sortingLayerName = SortingLayerNames.UI
    self.Tip:GetComponent("Canvas").sortingLayerName = SortingLayerNames.UI
    self.Play:GetComponent("Canvas").sortingLayerName = SortingLayerNames.UI
    self.Effects:GetComponent("Canvas").sortingLayerName = SortingLayerNames.UI
    self:OnRefresh()
end

function this.OnRefresh(self)
    self.RiskItem = {}
    self:TipClose()
    self.topCanvas.gameObject:SetActive(false)
    self.CurrentItemTF = nil
    self.StartEffects.gameObject:SetActive(true)
    self.MapId = self.risk_component.data.mapId;
    self.data = self.risk_component.data
    self.playerPos =  self.risk_component.data.playerPos
    self.Effects.gameObject:SetActive(true)
    self:changeSkin()
    self:MapItemInit()
    
end

function this.changeSkin(self)
    --local playSkin = self.Play.transform:Find("Spine/SkeletonGraphic"):GetComponent("SkeletonGraphic")
    --local MainCard = table.first(Game.Scene.Player:GetComponent("CardComponent").Cards,function (v) return v.Id == Game.Scene.Player.MainUICardId  end)
    self.SkeletonGraphic.AnimationState:ClearTracks();
    coroutine.start(function ()
        local palyerId = (self.risk_component.data.playerId == 0 and {1} or {self.risk_component.data.playerId} )[1] ..  (self.risk_component.data.skin == 0 and {"_1"} or {"_4"})[1]
        local riskCardSpine = table.first(Z_RiskCardSpine,function (v) return v.SkinId == palyerId end) 
        local path="UI/SpineAnimations/xiaoren/".. riskCardSpine.DataAsset .. ".asset"
        local pathMat="UI/SpineAnimations/xiaoren/".. riskCardSpine.Material .. ".mat"
        --playSkin.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
        self.SkeletonGraphic.skeletonDataAsset = ResourcesManager:GetInstance():CoLoadAsync(path,typeof(CS.Spine.Unity.SkeletonDataAsset))
        self.SkeletonGraphic.material = ResourcesManager:GetInstance():CoLoadAsync(pathMat,typeof(Material))
        self.SkeletonGraphic.initialSkinName= riskCardSpine.SkinName
        self.SkeletonGraphic:Initialize(true)
    end)
end

function this.OnDice(self)
    
    if self.playerPos > table.count(self.RiskItem) then
        self.playerPos = table.count(self.RiskItem)
    end
    if self.data.remainTime <= 0 then
        self.TipMsg.gameObject:SetActive(true)
        self.Tip.gameObject:SetActive(true)
    else
        coroutine.start(function ()
            self.throw_btn.gameObject:GetComponent("Button").enabled = false
            self.risk_component:Play(self.DiceMode,function (info)
                local path 
                if info ~= nil then
                    if self.DiceMode == 0 then
                        self.DiceAni4.gameObject:SetActive(true)
                        --self.DiceAni:GetComponent("Animator"):SetInteger("Dice",4)
                        path = "UI/Risk/Other/4_"
                    else
                        self.DiceAni12.gameObject:SetActive(true)
                        --self.DiceAni:GetComponent("Animator"):SetInteger("Dice",12)
                        path = "UI/Risk/Other/12_"
                    end
                    self.DiceIcon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path..self.risk_component.DiceNum..".png");
                    coroutine.waitforseconds(1)
                    self.DiceAni4.gameObject:SetActive(false)
                    self.DiceAni12.gameObject:SetActive(false)
                    self.DiceIcon.gameObject:SetActive(true)
                    coroutine.waitforseconds(0.5)
                    self.DiceIcon.gameObject:SetActive(false)
                    self.DiceNum.gameObject:SetActive(true)
                    self.DiceNumText.text = self.risk_component.DiceNum
                end
                coroutine.waitforseconds(1)
                Move(self,info)
            end)
           
        end)
        
    end
    
end


-- 切换骰子
function this.OnChangeDice(self)
    if self.DiceMode == 0  then
        self.ChangeDice.transform:GetChild(0).gameObject:SetActive(true)
        self.ChangeDice.transform:GetChild(1).gameObject:SetActive(false)
        self.throw_btn.transform:GetChild(0).gameObject:SetActive(false)
        self.throw_btn.transform:GetChild(1).gameObject:SetActive(true)
        self.DiceMode = 1
    else
        
        self.ChangeDice.transform:GetChild(1).gameObject:SetActive(true)
        self.ChangeDice.transform:GetChild(0).gameObject:SetActive(false)
        self.throw_btn.transform:GetChild(1).gameObject:SetActive(false)
        self.throw_btn.transform:GetChild(0).gameObject:SetActive(true)
        self.DiceMode = 0
    end
    
end

function this.OnTipDiceChange(self)
    self.TipDiceChange.transform:Find(1).gameObject:SetActive(self.DiceMode == 0)
    self.TipDiceChange.transform:Find(2).gameObject:SetActive(self.DiceMode == 1)
    self.TipDiceChange.gameObject:SetActive(true)
    self.Tip.gameObject:SetActive(true)
end

function this.EffectScale(self,num)
    local changeList = {}
    table.insert(changeList,self.portalRoot.transform:Find("Men1/ChuanSongMen1_1"))
    table.insert(changeList,self.portalRoot.transform:Find("Men2/ChuanSongMen2_1"))
    table.insert(changeList,self.portalRoot.transform:Find("Men3/ChuanSongMen3_1"))
    table.insert(changeList,self.portalRoot.transform:Find("Men4/ChuanSongMen4_1"))
    table.insert(changeList,self.portalRoot.transform:Find("DiTu_LongQuan"))
    table.insert(changeList,self.portalRoot.transform:Find("DiTu_ChiTang"))
    table.insert(changeList,self.portalRoot.transform:Find("DiTu_PenQuan"))
    for k,v in table.pairsByKeys(changeList) do
        table.csenu(v:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem)),function (go)
            local scale = go.transform.localScale.x
            if  num == 0 then
                go.transform:DOScale(scale * 0.27,0)
            else
                go.transform:DOScale(scale/0.27 ,0)
            end
        end)
    end
end

-- 更新骰子次数
function this.RefreshTime(self, remainTime, time)
    if self.risk_component == nil  then
        return
    end
    if self.risk_component.data.remainTime >= self.risk_component.maxTimes then
        self.date.text = LangUtil.GetSysLang(1116) .. ": " .. string.format("%02d:%02d:%02d", 0,0, 0)
    else
        local tb = self.risk_component.ConvertTimeForm(time)
        self.date.text = LangUtil.GetSysLang(1116) .. ": " .. string.format("%02d:%02d:%02d", tb.hour,tb.minute, tb.second)
    end
    local count = self.risk_component.data.remainTime + 311
    LangUtil.GetSpriteLang(count,function(sprite)
        self.DiceCount:GetComponent("Image").sprite = sprite
    end)
end

function this.OnDisable(self)
    base.OnDisable(self)
    self.ReadyGo.gameObject:SetActive(false)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this

