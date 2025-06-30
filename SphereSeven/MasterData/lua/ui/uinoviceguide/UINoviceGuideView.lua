

local UINoviceGuideView = BaseClass("UINoviceGuideView",UIBaseView);
local base = UIBaseView;
local this = UINoviceGuideView;
local minX,minY,minW,minH = 0 ,0,0,0
local minX1,minY1,minW1,minH1 = 0 ,0,0,0
local minX2,minY2,minW2,minH2 = 0 ,0,0,0
local isAutoGuide = false
local guideCHG = {type = 1}


function this.Update(self)
    if self.isBattleScene then
        if UIUtil.BattaleActiveWindow() then
            guideCHG.type = 2
        elseif isAutoGuide then
            guideCHG.type = 1
            isAutoGuide = false
            self.rc.gameObject:SetActive(true)
            self:OnGuideCHG(guideCHG.cid, guideCHG.num, guideCHG.isrun)
        end
    end
end

function this.OnCreate(self)
    base.OnCreate(self)
    local rc = self.rc
    self.mask_bt = rc:GetObject("Btn")--:GetComponent(typeof(UIButton))
    self.skip_btn = rc:GetObject("SkipBtn")
    self.mask_bc = rc:GetObject("Btn"):GetComponent(typeof(RectTransform))
    self.mask_cc = rc:GetObject("MaskCC"):GetComponent(typeof(RectTransform))
    self.mask_rc = rc:GetObject("Mask"):GetComponent(typeof(RectTransform))
    self.Text_panel_rc=rc:GetObject("Text_panel"):GetComponent(typeof(RectTransform))
    self.Text_shortPanel=rc:GetObject("Text_shortPanel"):GetComponent(typeof(RectTransform))
    self.PanelText = self.Text_panel_rc:Find("Txtbg/txt"):GetComponent("Text")
    self.ShortText = self.Text_shortPanel:Find("Txtbg/txt"):GetComponent("Text")
    self.PanelText.text=""
    self.ShortText.text =""
    self.TwoText = rc:GetObject("TwoText")
    self.TwoText:SetActive(false)
    self.Ani = rc:GetObject("Ani")
    
    self.Text=rc:GetObject("txt"):GetComponent(typeof(UE_UI.Text))
    self.Text.text=""
    self.Icon=rc:GetObject("Icon"):GetComponent("Image")
    self.Image_bg=rc:GetObject("Image_bg")
    self.Ring1=rc:GetObject("Ring1")
    self.Finger_rc=rc:GetObject("Finger"):GetComponent(typeof(RectTransform))
    self.mask_ho = rc:GetObject("Image")
    self.Battle_Image = rc:GetObject("Battle_Image")
    self.SkipText = rc:GetObject("SkipText"):GetComponent("Text")
    self.bgPosition = self.Image_bg.transform.localPosition
    ButtonListener.Get(self.mask_bt).OnClickHandler = function() self.mask_bt.gameObject:SetActive(false)  self.ctrl.OnClick()  end 
    ButtonListener.Get(self.skip_btn).OnClickHandler = function() self.skip_btn.gameObject:SetActive(false) self.ctrl.OnSkip()  end 
    self.soundPlay = true
end

function this.OnLangCreate (self)
    LangUtil.BindText(self.PanelText,FontType.JA_Dialog)
    LangUtil.BindText(self.ShortText,FontType.JA_Dialog)
    LangUtil.BindText(self.SkipText).text = LangUtil.GetSysLang(960)
    --if LangUtil.GetLangType() == LangType.CN or LangUtil.GetLangType() == LangType.HK then
    --    self.PanelText.lineSpacing = 1
    --    self.PanelText.fontSize = 36
    --    self.ShortText.lineSpacing = 1
    --    self.ShortText.fontSize = 36
    --elseif LangUtil.GetLangType() == LangType.JA then
    --    self.PanelText.lineSpacing = 0.95
    --    self.PanelText.fontSize = 36
    --    self.ShortText.lineSpacing = 0.95
    --    self.ShortText.fontSize = 36
    --end
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.Ani:SetActive(false)
    self.skip_btn.gameObject:SetActive(false)
    self.isBattleScene = Game.Scene:GetComponent("SceneComponent"):IsBattleScene()
    local guide=Game.Scene:GetComponent("GuideComponent")
    local GuideComplete, GuideStep ,run = guide:GetCurrentData()
    if GuideComplete==0 then
        if GuideStep ==6  then
            self:OnGuideCHG(GuideComplete, GuideStep ,run,0)
        elseif GuideStep<3  then
            self.mask_bc.transform.parent.gameObject:SetActive(true)
            self:OnGuideCHG(GuideComplete, GuideStep ,run)
        else
            self.mask_bc.transform.parent.gameObject:SetActive(false)
            self:OnGuideCHG(GuideComplete, GuideStep ,run)
        end
    end
    if GuideComplete~=0 then
        self:OnGuideCHG(guide:GetCurrentData())
    end
    if (GuideComplete == 2 and GuideStep > 2) or(GuideComplete > 2) then
        self.skip_btn.gameObject:SetActive(true)
    end
 
end

--function ICanvasRaycastFilter:IsRaycastLocationValid(self,screenPos,eventCamera)
--    return not RectTransformUtility:RectangleContainsScreenPoint(self.mask_rc, screenPos, eventCamera);
--end

-- 遮罩的点和大小 isFull；1点击框内有效 2点击全屏有效
function this.setMaskPos(self,id,x,y,w,h,isFull)
    if isFull==nil then
        return
    end
    self.mask_ho.gameObject:SetActive(true)
    self.Image_bg.gameObject:SetActive(false)
    local wh=Vector2.New(w,h)
    local v2=Vector2.New(x ,y)
    self.mask_cc.anchoredPosition=v2
    --self.mask_cc.sizeDelta=Vector2.New(w*2.2,h*2.2)
    --self.mask_cc:DOSizeDelta(wh,0)
    self.mask_cc.sizeDelta=wh
    self.mask_cc.gameObject:SetActive(true)
    if isFull==1 then
        self.mask_rc.anchoredPosition=v2
        --self.mask_rc.sizeDelta=Vector2.New(w*2.2,h*2.2)
        --self.mask_rc:DOSizeDelta(wh,0)
        self.mask_rc.sizeDelta = wh 
        self.mask_bc.anchoredPosition=v2
        self.mask_bc.sizeDelta=wh
        
        --self.mask_cc.sizeDelta=Vector2.New(w*2.2,h*2.2)
        self.mask_bc.gameObject:SetActive(true)
        self.mask_rc.gameObject:SetActive(true)
    elseif isFull==2 then
        self.mask_rc.anchoredPosition=v2
        self.mask_rc.sizeDelta = wh
        --self.mask_rc.sizeDelta=Vector2.New(w*2.2,h*2.2)
        --self.mask_rc:DOSizeDelta(wh,0)
        self.mask_bc.anchoredPosition=Vector2.New(0,0)
        self.mask_bc.sizeDelta=Vector2.New(1920 ,1080)
        
        --self.mask_cc.sizeDelta=Vector2.New(w*2.2,h*2.2)
        self.mask_bc.gameObject:SetActive(true)
        self.mask_rc.gameObject:SetActive(true)
    end
    
    --if isFull~=nil and isFull then
        --self.mask_bc.anchoredPosition=Vector2.New(0 ,0)
        --self.mask_bc.sizeDelta=Vector2.New(1920 ,1080)
    --end
end

function  this.setSprite(self,x,y,w,h,sp)
    self.Battle_Image:GetComponent("Image").sprite = DeActiveSprite
    local sprite = self.Battle_Image:GetComponent("Image")
    if type(sp) == "number" then
        LangUtil.GetSpriteLang(sp, function(temImage) sprite.sprite = temImage end)
    else
        coroutine.start(function ()
            local path="UI/Guide/"..sp..".png"
            sprite.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
            --icon.gameObject:SetActive(isshow)
        end)
    end

    local spriteR = self.Battle_Image:GetComponent(typeof(RectTransform))
    
    local wh=Vector2.New(w,h)
    local v2=Vector2.New(x ,y)
    
    spriteR.anchoredPosition=v2
    --spriteR.sizeDelta=Vector2.New(w*2.2,h*2.2)
    spriteR.sizeDelta = wh
    --spriteR:DOSizeDelta(wh,0)
    spriteR.gameObject:SetActive(true)
    
    
    
    
end

-- 无遮罩 或 全遮罩   true：全遮罩  false：无遮罩
function this.setMaskAll(self,isMask)
    if not isMask then
        self.mask_ho.gameObject:SetActive(false)
        self.Image_bg.gameObject:SetActive(true)
    else
        self.mask_ho.gameObject:SetActive(true)
        self.Image_bg.gameObject:SetActive(false)
    end
    self.mask_bc.gameObject:SetActive(true)
    self.mask_rc.anchoredPosition=Vector2.New(0,0)
    self.mask_cc.anchoredPosition=Vector2.New(0,0)
    self.mask_bc.anchoredPosition=Vector2.New(0,0)
    self.mask_rc.sizeDelta=Vector2.New(0,0)
    self.mask_cc.sizeDelta=Vector2.New(2800,2400)
    self.mask_bc.sizeDelta=Vector2.New(1920 ,1080)
end

function this.loadGuideInfo(self,id)
    for k,v in table.pairsByKeys(Z_NoviceGuide) do
        if v.Step== id then
            return v
        end
    end
end
-- 设置 对话框位置 和 对话，icon是否显示
function this.setTxtAll(self,id,x,y)
    local guide=Game.Scene:GetComponent("GuideComponent")
    local SStep= table.first(guide.GuideList,function (v) return v.Id==2  end)
    local text =nil
    local icon =nil
    --self.Text_panel_rc.gameObject:SetActive(true)
    local info = self:loadGuideInfo(id)
    if info.Type==1 then
        if not IsNull(self.Text_shortPanel) then
            self.Text_shortPanel.gameObject:SetActive(false)
        end
        self.Text_panel_rc.gameObject:SetActive(true)
        text = self.PanelText
        
        --text=self.Text_panel_rc:Find("Txtbg/txt"):GetComponent("Text")
        icon=self.Text_panel_rc:Find("Iconbg/Icon"):GetComponent("Image")
        self.Text_panel_rc.anchoredPosition = Vector2.New(info.Position[1], info.Position[2])
        
        
    elseif info.Type==2 then
        if x == nil then x = 0 end
        if y == nil then y = 0 end

        self.Text_panel_rc.gameObject:SetActive(false)
        self.Text_shortPanel.gameObject:SetActive(true)
        text = self.ShortText
        --text=self.Text_shortPanel:Find("Txtbg/txt"):GetComponent("Text")
        icon=self.Text_shortPanel:Find("Iconbg/Icon"):GetComponent("Image")
        self.Text_shortPanel.anchoredPosition = Vector2.New(x+info.Position[1], y+info.Position[2])
    end
    if text == nil then
        Logger.LogError("no text: " .. id)
        return
    end
    text.transform.gameObject:SetActive(true)
    text.text = LangUtil.GetLang(Z_NoviceGuide,info.Id,"Desc")
    if string.find(text.text,"ExName") ~=nil and SStep~=nil then
        text.text = string.gsub(text.text,"ExName",Z_Card[SStep.Step].Name)
        
    end
    
    --UIUtil.SetSprite(self.Icon, AtlasConfig.Guide, info.Icon .. ".png", true)
    local path="UI/Guide/"..info.Icon..".png"
    coroutine.start(function ()
        icon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
        --icon.gameObject:SetActive(isshow)
    end)
end

function this.setTxtAllMin(self,id)
    local text =nil
    local icon =nil
    local info = self:loadGuideInfo(id)
    if string.IsNullOrEmpty(info.Desc) then
        self:hideTxtAll()
        return
    end
    if info.MaskAll == 1  then
        self:setMaskAll(true)
        self:hideFinger()
    end
    if info.Type==1 then
        self.Text_shortPanel.gameObject:SetActive(false)
        self.Text_panel_rc.gameObject:SetActive(true)
        text = self.PanelText
        icon=self.Text_panel_rc:Find("Iconbg/Icon"):GetComponent("Image")
        self.Text_panel_rc.gameObject:SetActive(true)
        --self.Text_panel_rc.anchoredPosition = Vector2.New(info.Position[1], info.Position[2])
    elseif info.Type==2 then
        self.Text_shortPanel.gameObject:SetActive(true)
        self.Text_panel_rc.gameObject:SetActive(false)
        text = self.ShortText
        icon=self.Text_shortPanel:Find("Iconbg/Icon"):GetComponent("Image")
        self.Text_shortPanel.gameObject:SetActive(true)
    end
    text.text = LangUtil.GetLang(Z_NoviceGuide,info.Id,"Desc")
    if info.Id == 11011 or info.Id == 3109 or info.Id == 11014 then
        local path="UI/Guide/"..info.Icon..".png"
        coroutine.start(function ()
            icon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
        end) 
    end
    
    
end

function this.hideTxtAll(self)
    self.Text_panel_rc.gameObject:SetActive(false)
    self.Text_shortPanel.gameObject:SetActive(false)
    self.TwoText:SetActive(false)
end
function this.Hide(self)
    self.mask_rc.gameObject:SetActive(false)
    self.mask_bc.gameObject:SetActive(false)
    self.mask_cc.gameObject:SetActive(false)
    --self.mask_ho.gameObject:SetActive(false)
    self.Image_bg.gameObject:SetActive(false)
    self.Battle_Image.gameObject:SetActive(false)
    self.TwoText:SetActive(false)
    self.Battle_Image:GetComponent("Image").sprite = DeActiveSprite
end
function this.Show(self)
    --self.mask_rc.gameObject:SetActive(true)
    --self.mask_cc.gameObject:SetActive(true)
    --self.mask_bc.gameObject:SetActive(true)
end

function this.setFinger(self,id,x,y,w,h)
    local info = self:loadGuideInfo(id).Rect
    self.Finger_rc.gameObject:SetActive(true)
    local pos=Vector2.New(x ,y)
    self.Finger_rc.anchoredPosition=pos
    UIPublic.PlayEffect(self.Ring1)
    --pos.y=pos.y+20
    self.Finger_rc:DOAnchorPos(pos, 0.8,true):SetLoops(-1)
end

function this.setMagetskClick(self,RectTransform)
    self.mask_bc.gameObject:SetActive(false)
    self.mask_ho:SetTarget(RectTransform)
end

function this.hideFinger(self)
   self.Finger_rc.gameObject:SetActive(false)
   self.Finger_rc:DOKill()
end
function this.OnRefresh(self)

end
--当状态变化
function this.OnGuideCHG(self,cid,num,isrun)
    if not isrun then return end
    if guideCHG.type ~= 1 then 
        isAutoGuide = true
        guideCHG = {type = 2, cid=cid,num=num,isrun =isrun}
        self.rc.gameObject:SetActive(false)
        return 
    end
   
    guideCHG = {type = 1}
    local guide=Game.Scene:GetComponent("GuideComponent")
    local a=self["guide_"..cid.."_"..num]
    self:hideTxtAll()
    self:hideFinger()
    self:Hide()
    --self.mask_bt.gameObject:SetActive(true)
    guide.minStep = 0
    if a==nil then
        guide:EndGuide()
        
        return
    end
    a(self)
    --if cid > 2 then
    --    return
    --end
    
    --coroutine.start(function()
    --    a(self)
    --    if cid <= 4 then
    --        local guideSkip = table.first(Z_NoviceGuideSkip, function(a)
    --            return a.GuideCompleteId == cid and (num >= a.Skip[1] and num < a.Skip[2])
    --        end)
    --        if guideSkip  then
    --            if table.first(guideSkip.NoSkip,function (b) return b == num end ) then
    --                self.skip_btn.gameObject:SetActive(false)
    --            else
    --                self.skip_btn.gameObject:SetActive(true)
    --            end
    --        else
    --            self.skip_btn.gameObject:SetActive(false)
    --        end
    --    end
    --end)
   
end

--步骤内状态变化
function this.OnGuideCHGMin(self,cid,num,isrun,minStep,isFinger)
    if not isrun then return  end
    --local guide=Game.Scene:GetComponent("GuideComponent")
    --local a=self["guide_"..cid.."_"..num.."_"..minStep]
    --self:hideTxtAll()
    --self:hideFinger()
    --self:Hide()
    --if a==nil then
    --    guide:EndGuide()
    --    return
    --end
    --a(self)
    print("!!!!!!!!!!!!!!!!!!!!!!!!".. cid .. num ..minStep )
    self:GuideMinStep(cid,num,minStep,isFinger)
end

function this.GuideMinStep(self,cid,num,minStep,isFinger)
    local id=cid.."_"..num.."_"..minStep
    if isFinger == 6 or isFinger == 10 then
        if isFinger == 6 then
            coroutine.start(function()
                local window = UIManager:GetInstance():GetWindow(UIWindowNames.UISevenStar)
                local view = window.View
                local tf = view.transform:Find("Left/Bg/Scroll View/Viewport/BtnCtrl")
                tf:DOLocalMoveY(608, 1)
                coroutine.waitforseconds(1)
                self:setTxtAllMin(id)
                self.mask_bt.gameObject:SetActive(true)
            end)
        end
        if isFinger == 10 then
            coroutine.start(function()
                self.Text_panel_rc.gameObject:SetActive(false)
                self.Text_shortPanel.gameObject:SetActive(false)
                coroutine.waitforseconds(2)
                self:setTxtAllMin(id)
                self.mask_bt.gameObject:SetActive(true)
            end)
        end
    else
        self:setTxtAllMin(id)
        self.mask_bt.gameObject:SetActive(true)
    end
    if cid == 1 and num == 14 and minStep == 1  then
        self.Ani:SetActive(true)
    end
    if cid == 1 and num == 14 and minStep == 5  then
        self.Ani:SetActive(false)
    end
    
    if isFinger ~= 0 then
        if isFinger == 1 then -- 提示手
            local wh=Vector2.New(minW,minH)
            local v2=Vector2.New(minX ,minY)
            self.mask_bc.anchoredPosition=v2
            self.mask_bc.sizeDelta=wh
            self.mask_bc.gameObject:SetActive(true)
            self:setFinger("0_15",minX,minY,minW,minH)
        end
        if isFinger == 2 then -- 显示指引框
            self:setMaskPos("0_15",minX,minY,minW,minH,2)
        end
        if isFinger == 3 then -- 显示指引框和手
            self:setMaskPos("0_15",minX,minY,minW,minH,1)
            self:setFinger("0_15",minX,minY,minW,minH)
            self.Battle_Image.gameObject:SetActive(false)
            self.Battle_Image:GetComponent("Image").sprite = DeActiveSprite
        end
        if isFinger == 4 then
            self:setMaskPos("0_15",minX1,minY1,minW1,minH1,2)
            self:hideFinger()
        end
        if isFinger == 5 then
            self:setMaskPos("0_15",minX2,minY2,minW2,minH2,2)
        end
        if isFinger == 7 then --弹出图片
            self:setSprite(0,80,300,300,"3014")
        end
        if isFinger == 8 then --关闭图片
            self.Battle_Image.gameObject:SetActive(false)
            self.Battle_Image:GetComponent("Image").sprite = DeActiveSprite
        end
        if isFinger == 9 then -- 战魂
            self:setSprite(minX,minY,354,430, 304) -- ignoreCN
        end
        if isFinger == 11 then -- 关闭手
            self:hideFinger()
        end
        if isFinger == 12 then -- 关闭指引框
            self:setMaskAll(true)
        end
    end
    
end

function this.OnScenechg(self)
    self.isBattleScene = Game.Scene:GetComponent("SceneComponent"):IsBattleScene()
    guideCHG.type = 1
    if isAutoGuide then
        isAutoGuide = false
        self.rc.gameObject:SetActive(true)
        self:OnGuideCHG(guideCHG.cid, guideCHG.num, guideCHG.isrun)
    end
end

function this.OnDisable(self)
    base.OnDisable(self);
    self.isBattleScene = nil
    guideCHG = {type = 1}
end
--
function this.OnDestroy(self)
    base.OnDestroy(self);
end
--
function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_Guide_CHG,self.OnGuideCHG)
    self:AddUIListener(UIMessageNames.ON_Guide_Click,self.ON_Guide_Click)
    self:AddUIListener(UIMessageNames.ON_Guide_CHG_MIN,self.OnGuideCHGMin)
    self:AddUIListener(UIMessageNames.ON_SCENE_CHG, self.OnScenechg)
end
--
function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_Guide_CHG)
    self:RemoveUIListener(UIMessageNames.ON_Guide_Click)
    self:RemoveUIListener(UIMessageNames.ON_Guide_CHG_MIN)
    self:RemoveUIListener(UIMessageNames.ON_SCENE_CHG)
end
--把一个世界ui转成屏幕坐标
function this.GetWorldToScreenRect(self,canvas,targetTf)
    local screenPoint = canvas.worldCamera:WorldToScreenPoint(targetTf.position)
    local rc=targetTf:GetComponent(typeof(RectTransform))
    local size=rc.sizeDelta
    screenPoint=CSUtil.GetCanvasPosition(canvas, screenPoint)
    return screenPoint.x ,screenPoint.y ,size.x,size.y
end


-- ------------------------
-- ------------------------
-- ------------------------
-- ------------------------
function this.guide_0_0(self)------
    self:setMaskAll(false)
    coroutine.start(function ()
        local window = UIManager:GetInstance():GetWindow(UIWindowNames.UIPlayerInceptionInfo)
        if window ~= nil then
            window.View.transition:DOFade(0,0.1)
            window.View.ctrl:CloseBut()
        end
        coroutine.waitforseconds(0.5)
        self.Image_bg.transform:Find("Image"):GetComponent("Image"):DOFade(1,1)
        self.Image_bg.transform:Find("Image (1)"):GetComponent("Image"):DOFade(1,1)
        coroutine.waitforseconds(1)
        
        self.Image_bg.transform:DOShakePosition(1,70,10,90);
        coroutine.waitforseconds(1.5)
        self:setTxtAll("0_0",true)
        local Aud = ResourcesManager:GetInstance():CoLoadAsync("Sound/Story/127_WMZJSX.mp3",typeof(AudioClip))
        if self.soundPlay then
            Game.Scene:GetComponent("SoundComponent"):Play(Aud)
        else
            Game.Scene:GetComponent("SoundComponent"):MainStop()
            coroutine.yield()
        end
        coroutine.waitforseconds(1)
        if self.soundPlay then
            Game.Scene:GetComponent("SoundComponent"):Play(Aud)
        else
            Game.Scene:GetComponent("SoundComponent"):MainStop()
            coroutine.yield()
        end
        self.Image_bg.transform.localPosition = self.bgPosition
    end)
end
function this.guide_0_1(self)
    self.Image_bg.transform.localPosition = self.bgPosition
    self:setMaskAll(false)
    self:setTxtAll("0_1",true)
end
function this.guide_0_2(self)
    
    self:setMaskAll(false)
    self:setTxtAll("0_2",true)
    self.mask_ho.gameObject:SetActive(false)
end
function this.guide_0_3(self)
    self:setMaskAll(false)
    self.soundPlay = false
    Game.Scene:GetComponent("SoundComponent"):MainStop()
    --self.ctrl:HideWindow()
    local guide=Game.Scene:GetComponent("GuideComponent")
    guide:SwitchBattleScene()
    
    --coroutine.start(function()
    --    coroutine.waitforseconds(3)
    --    self.mask_bc.transform.parent.gameObject:SetActive(false)
    --end)
    
end
function this.guide_0_4(self)
    self:setTxtAll("0_4",true)
    self:setMaskAll(true)
end
function this.guide_0_5(self)
    --local rc=new RectTransform(171 ,-301,938,173)
    self:setMaskAll(true)
    self:setTxtAll("0_5",true)
end

function this.guide_0_6(self)
    self:setTxtAll("0_6",true)
    self:setMaskAll(true)
end
function this.guide_0_7(self)
    self.mask_bt.gameObject:SetActive(false)
    local  battleComp = Game.Scene:GetComponent("BattleComponent")
    if  battleComp ~= nil and battleComp.CurActUnit~=nil  then
        if battleComp.CurActUnit.IsPlayer then
            self:setTxtAll("0_7",true)
            self:setMaskPos("0_7",465,35,730,630,2)
        end
    end
end
function this.guide_0_8(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.SpeedBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("0_8")
    self:setMaskPos("0_8",x,y,w,h,2)
end
function this.guide_0_9(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.BodyBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("0_9",x,y)
    self:setMaskPos("0_9",x,y,w,h,2)
end

function this.guide_0_10(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.StateBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("0_10",x,y)
    self:setMaskPos("0_10",x,y,w,h,2)
end

function this.guide_0_11(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.AutoBg.transform
    local tf1=uic.AutoBg.transform:Find("1")
    local tf2=uic.AutoBg.transform:Find("2")
    local tf3=uic.AutoBg.transform:Find("3")
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    local x1,y1,w1,h1=self:GetWorldToScreenRect(canvas,tf1)
    local x2,y2,w2,h2=self:GetWorldToScreenRect(canvas,tf2)
    local x3,y3,w3,h3=self:GetWorldToScreenRect(canvas,tf3)
    self:setTxtAll("0_11",x,y)
    self:setMaskPos("0_11",x1,y1,w1,h1,2)
    minX1,minY1,minW1,minH1 = x2,y2,w2,h2
    minX2,minY2,minW2,minH2 = x3,y3,w3,h3
end

function this.guide_0_12(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.SkillBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("0_12",x,y)
    self:setMaskPos("0_12",x,y,w,h,2)
end
function this.guide_0_13(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.SkillBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("0_13",x,y)
    self:setMaskPos("0_13",x,y,w,h,2)
end
function this.guide_0_14(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.SkillBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("0_14",x,y)
    self:setMaskPos("0_14",x,y,w,h,2)
end

function this.guide_0_15(self)--选择技能
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.generalAtkRoot.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setTxtAll("0_15",x,y)
    self:setMaskPos("0_15",x,y,w,h,2)
    --self:setFinger("0_15",x,y,w,h)
end

function this.guide_0_16(self)--选择攻击目标
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.SkillTarget.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("0_16",x,y,w,h,1)
    self:setFinger("0_16",x,y,w,h)
    -- self:setMaskPos("0_16",-198,130,150,260,1)
    -- self:setFinger("0_16",-198,130,150,260)
end

function this.guide_0_17(self)
    self:setMaskAll(true)
    self:setTxtAll("0_17")
end
function this.guide_0_18(self)
    self:setMaskAll(true)
    self:setTxtAll("0_18")
end
function this.guide_0_19(self)
    self:setMaskAll(true)
    self:setTxtAll("0_19")
end
function this.guide_0_20(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.skill1Root.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setTxtAll("0_20",x,y)
    self:setMaskPos("0_20",x,y,w,h,2)
    --self:setFinger("0_20",x,y,w,h)
end
function this.guide_0_21(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.generalAtkRoot.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setTxtAll("0_21",x,y)
    self:setMaskAll(true)
    --self:setMaskPos("0_21",x,y,w,h,1)
    --self:setFinger("0_21",x,y,w,h)
end
function this.guide_0_22(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.skill3Root.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    local tf1=uic.BodyMPBg.transform
    local x1,y1,w1,h1=self:GetWorldToScreenRect(canvas,tf1)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("0_22",x1,y1,w1,h1,2)
    self:setTxtAll("0_22",x,y)
    --self:setFinger("0_22",x,y,w,h)
end
function this.guide_0_23(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.skill2Root.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("0_23",x,y,w,h,1)
    self:setTxtAll("0_23",x,y)
    self:setFinger("0_23",x,y,w,h)
end
function this.guide_0_24(self)
    self:setMaskAll(true)
    self:setTxtAll("0_24")
end


-- ---------------------------
-- -----------------------------
-- ----------------------------
-- ----------------------------
function this.guide_1_0(self)----------1_0召唤引导
    self:setMaskAll(true)
    self:setTxtAll("1_0")
end
function this.guide_1_1(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
    local view =window.View
    local tf=view.drawCard_btn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setMaskPos("1_1",x,y,w,h,2)
    self:setMaskAll(true)
    self:setTxtAll("1_1",x,y)
    --self:setFinger("1_1",x,y,w,h)
end
function this.guide_1_2(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
    local view =window.View
    local tf=view.drawCard_btn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskAll(true)
    minX,minY,minW,minH = x,y,w,h
    --self:setMaskPos("1_2",x,y,w,h,1)
    self:setTxtAll("1_2",x,y)
    --self:setFinger("1_2",x,y,w,h)
end
function this.guide_1_3(self) -- 没有调用
    self.mask_ho.gameObject:SetActive(true)
    coroutine.start(function()
        coroutine.waitforseconds(2)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
        local view =window.View
        local tf=view.right_btn.transform
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskPos("1_3",x,y,w,h,2)
        self:setTxtAll("1_3",x,y)
        --self:setFinger("1_3",x,y,w,h)
    end)
end
function this.guide_1_4(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.recruitOneButton) then
            self.timer:Stop()
            local view =window.View
            local tf=view.recruitOneButton.transform
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskAll(true)
            minX,minY,minW,minH = x,y,w,h
            --self:setMaskPos("1_4",x,y,w,h,1)
           
            self:setTxtAll("1_4",x,y)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_1_5(self)
    self:setMaskAll(true)
    self:setTxtAll("1_5")
end

function this.guide_1_6(self)
    self:setMaskAll(true)
    self:setTxtAll("1_6")
end
function this.guide_1_7(self)
    self:setMaskAll(true)
    self:setSprite(0,80,1229,790,306)
    self.Battle_Image.gameObject:SetActive(true)
    self:setTxtAll("1_7")
end
function this.guide_1_8(self)
    self.mask_ho.gameObject:SetActive(true)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummonStage2)
    local view =window.View
    local tf=view.backBtn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("1_8",x,y,w,h,1)
    --self:setTxtAll("1_8",x,y)
    self:setFinger("1_8",x,y,w,h)
    
end
function this.guide_1_9(self)
    self.mask_ho.gameObject:SetActive(true)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
    local view =window.View
    local tf=view.recruitOneButton
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    --self:setMaskPos("1_9",x,y,w,h,1)
    self:setTxtAll("1_9",x,y)
    --self:setFinger("1_9",x,y,w,h)
end
function this.guide_1_10(self)
    self.mask_ho.gameObject:SetActive(true)
    coroutine.start(function()
        coroutine.waitforseconds(2)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
        local view =window.View
        local tf=view.starStone.transform.parent
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskAll(true)
        minX,minY,minW,minH = x-172,y,w+343,h
        --self:setMaskPos("1_10",x-172,y,w+343,h,2)
        self:setTxtAll("1_10",x-172,y)
        --self:setFinger("1_10",x-172,y,w+343,h)
        --self.skip_btn.gameObject:SetActive(true)
    end)
end
function this.guide_1_11(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
    local view =window.View
    local tf=view.starStone.transform.parent
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setMaskPos("1_11",x-172,y,w+343,h,2)
    self:setTxtAll("1_11",x-172,y)
    --self:setFinger("1_11",x-172,y,w+343,h)
end
function this.guide_1_12(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
    local view =window.View
    local tf=view.paidBtns[1].transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskAll(true)
    minX,minY,minW,minH = x,y,w,h
    --self:setMaskPos("1_12",x,y,w,h,1)
    
    self:setTxtAll("1_12",x,y)
    
    --self:setFinger("1_12",x,y,w,h)
end
function this.guide_1_13(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UIReward)
    local view =window.View
    local tf=view.content.transform:Find("RewardItem(Clone)").transform
    local tf1=view.closeBtn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    
    minX,minY,minW,minH = self:GetWorldToScreenRect(canvas,tf1)

    local window2 = UIManager:GetInstance():GetWindow(UIWindowNames.UISummonStage2)
    local view2 =window2.View
    local tf2=view2.activityStone.transform
    minX1,minY1,minW1,minH1 = self:GetWorldToScreenRect(canvas,tf2)
    self:setMaskPos("1_13",x,y,w,h,2)
    --self:setMaskAll(true)
    self:setTxtAll("1_13")
end
function this.guide_1_14(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummonStage2)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.backBtn) then
            self.timer:Stop()
            --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardList)
            local view =window.View
            local tf=view.backBtn.transform
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskAll(true)
            minX,minY,minW,minH = x,y,w,h
            --self:setMaskPos("1_14",x,y,w,h,1)
           
            self:setTxtAll("1_14",x,y)
           

        end
    end

    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
    
    
end
function this.guide_1_15(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISummon)
    local view =window.View
    local tf=view.rc:GetObject("ReturnButton").transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("1_15",x,y,w,h,1)
    --self:setTxtAll("1_15",x,y)
    self:setFinger("1_15",x,y,w,h)
end

function this.guide_2_0(self)
    self:setMaskAll(true)
    self:setTxtAll("2_0")
end

function this.guide_2_1(self)
    self:hideTxtAll()
    self:Hide()
    self.mask_bt:SetActive(false)
    local data = {title=LangUtil.GetSysLang(2044),Reward={{10001,10002,10003,10004,10005,10006,10007},
                                     {10008,10009,10010,10011,10012,10013,10014,},
                                     {10015,10016,10017,10018,10019,10020},
                                     {10021,10022,10023,10024,10025},
                                     {10026,10027,10028,10029,10030}}}
    UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipFive,data)
    self.mask_ho.gameObject:SetActive(false)
end

function this.guide_2_2(self)
    self:setMaskAll(true)
    self:setTxtAll("2_2")
end
function this.guide_2_3(self)
    coroutine.start(function()
        self:setMaskAll(true)
        self.mask_bc.gameObject:SetActive(false)
        coroutine.waitforseconds(1)
        self:setTxtAll("2_3")
        self.mask_bc.gameObject:SetActive(true)
    end)
    
end

function this.guide_2_4(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.format_btn) then
            self.timer:Stop()
            local view =window.View
            local tf=view.format_btn.transform.parent
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskAll(true)
            minX,minY,minW,minH = x,y,w,h
            --self:setMaskPos("2_4",x,y,w,h,1)
            self:setTxtAll("2_4",x,y)
            --self:setFinger("2_4",x,y,w,h)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_2_5(self)
    coroutine.start(function()
        self:setMaskAll(true)
        self.mask_bc.gameObject:SetActive(false)
        coroutine.waitforseconds(1.5)
        self:setTxtAll("2_5")
        self.mask_bc.gameObject:SetActive(true)
    end)
end

function this.guide_2_6(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardList)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.leftBtnCtrl) then
            self.timer:Stop()
            --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardList)
            local view =window.View
            local tf=view.leftBtnCtrl.transform
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskPos("2_6",x,y,w,h,2)
            self:setTxtAll("2_6",x,y)
            
        end
    end
   
        self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
        -- 启动定时器
        self.timer:Start()
end

function this.guide_2_7(self)
    self:setMaskAll(true)
    self:setTxtAll("2_7")
end

function this.guide_2_8(self)
    local guide=Game.Scene:GetComponent("GuideComponent")
    local SStep= table.first(guide.GuideList,function (v) return v.Id==2  end)
    local card_list = Game.Scene.Player:GetComponent("CardComponent").Cards
    local card = nil 
    if SStep ~= nil then
        card = table.first(card_list,function (v) return v.TemplateId==SStep.Step  end)
    else
        card = table.first(card_list,function (v) return v.TemplateId==1003  end)
    end
    
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardList)
        if window~=nil and not IsNull( window.View.transform) and table.count(window.View.card_object_list) > 0 then
            self.timer:Stop()
            local view =window.View
            if card~=nil then
                local tf=view.card_object_list[card.Id].transform:Find("CardInfo/Frame")
                local canvas = window.Layer.unity_canvas
                local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
                self:setMaskAll(true)
                minX,minY,minW,minH = x,y,w,h
                
                self:setTxtAll("2_8",x,y)
                
                
                self.timer:Stop()
               
            else --老帐号
                --local tf=view.content.transform.GetChild(0):Find("CardInfo/Avatar")
                --local canvas = window.Layer.unity_canvas
                --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
                --self:setMaskPos("2_8",x,y,w,h,1)
                --self:setTxtAll("2_8",x,y)
                --self:setFinger("2_8",x,y,w,h)
                self:setMaskAll(true)
                
                self:setTxtAll("2_8")
                
               
            end

        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_2_9(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.visit_panel) then
            self.timer:Stop()
            local view =window.View
            local tf=view.visit_panel.transform:Find("NoviceGuid")
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskAll(true)
            minX,minY,minW,minH = x,y,w,h
            --self:setMaskPos("2_9",x,y,w,h,2)
            self:setTxtAll("2_9",x,y)
            
        end 
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_2_10(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.visit_panel.transform:Find("Bottm/SetSupportButton")--援助
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_10",x,y,w,h,2)
    self:setTxtAll("2_10",x,y)
end

function this.guide_2_11(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.visit_panel.transform:Find("Bottm/SetMainButton")--助手
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_11",x,y,w,h,2)
    self:setTxtAll("2_11",x,y)
end

function this.guide_2_12(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.visit_panel.transform:Find("Bottm/SetRoomButton")--正宫
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_12",x,y,w,h,2)
    self:setTxtAll("2_12",x,y)
end

function this.guide_2_13(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.cardInfo.transform:Find("RareFrame")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_13",x,y,w,h,2)
    self:setTxtAll("2_13",x,y)
end

function this.guide_2_14(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.cardOp.transform:Find("Lock/Image")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_14",x,y,w,h,2)
    self:setTxtAll("2_14",x,y)
end

function this.guide_2_15(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.cardOp.transform:Find("Skin")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_15",x,y,w,h,2)
    self:setTxtAll("2_15",x,y)
end

function this.guide_2_16(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.cardOp.transform:Find("Lock")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_16",x,y,w,h,2)
    self:setTxtAll("2_16",x,y)
end

function this.guide_2_17(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.cardOp.transform:Find("HandBook")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_17",x,y,w,h,2)
    self:setTxtAll("2_17",x,y)
end

function this.guide_2_18(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.btnCtrl.transform:GetChild(1)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_18",x,y,w,h,2)
    minX,minY,minW,minH = x,y,w,h
    self:setTxtAll("2_18",x,y)
    --self:setFinger("2_18",x,y,w,h)
end

function this.guide_2_19(self)
   local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("Bot/ChgItemCtrl")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_19",x,y,w,h,2)
    self:setTxtAll("2_19",x,y)
end

function this.guide_2_20(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("Top/LeveInfo")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_20",x,y,w,h,2)
    self:setTxtAll("2_20",x,y)
end

function this.guide_2_21(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("Bot/ChgItemCtrl/1 (2)")
    local tf1=view.level_up_panel.transform:Find("Bot/ChgItemCtrl")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    local x1,y1,w1,h1=self:GetWorldToScreenRect(canvas,tf1)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("2_21",x1,y1,w1,h1,2)
    self:setTxtAll("2_21",x,y)
    --self:setFinger("2_21",x,y,w,h)
end

function this.guide_2_22(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("Bot/NumCtrl/MaxButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("2_22",x,y,w,h,2)
    self:setTxtAll("2_22",x,y)
    --self:setFinger("2_22",x,y,w,h)
end

function this.guide_2_23(self)

    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("IntensButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("2_23",x,y,w,h,2)
    self:setTxtAll("2_23",x,y)
    --self:setFinger("2_23",x,y,w,h)
end

function this.guide_2_24(self)
    --coroutine.start(function() 
        --coroutine.waitforseconds(1)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
        local view =window.View
        local tf=view.level_up_panel.transform:Find("Bot/ChgItemCtrl/1 (1)")
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskPos("2_24",x,y,w,h,1)
        self:setTxtAll("2_24",x,y)
        self:setFinger("2_24",x,y,w,h)
    --end)
end

function this.guide_2_25(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("Bot/NumCtrl/MaxButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_25",x,y,w,h,1)
    self:setTxtAll("2_25",x,y)
    self:setFinger("2_25",x,y,w,h)
end

function this.guide_2_26(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("IntensButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_26",x,y,w,h,1)
    self:setTxtAll("2_26",x,y)
    self:setFinger("2_26",x,y,w,h)
end

function this.guide_2_27(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("Bot/ChgItemCtrl/1 (2)")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_27",x,y,w,h,1)
    self:setTxtAll("2_27",x,y)
    self:setFinger("2_27",x,y,w,h)
end

function this.guide_2_28(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("Bot/NumCtrl/MaxButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_28",x,y,w,h,1)
    self:setTxtAll("2_28",x,y)
    self:setFinger("2_28",x,y,w,h)
end

function this.guide_2_29(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.level_up_panel.transform:Find("IntensButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_29",x,y,w,h,1)
    self:setTxtAll("2_29",x,y)
    self:setFinger("2_29",x,y,w,h)
end

--进化
function this.guide_2_30(self)
    self.mask_ho.gameObject:SetActive(true)
    --coroutine.start(function()
        --coroutine.waitforseconds(1)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
        local view =window.View
        local tf=view.btnCtrl.transform:GetChild(2)
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskAll(true)
        minX,minY,minW,minH = x,y,w,h
        self:setTxtAll("2_30",x,y)
   -- end)
    
end

function this.guide_2_31(self)
    self.mask_ho.gameObject:SetActive(true)
    --coroutine.start(function()
        --coroutine.waitforseconds(1)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
        local view =window.View
        local tf=view.evolve_panel.transform:Find("Bot/Title")
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskPos("2_31",x,y-142,w+120,h+282,2)
        self:setTxtAll("2_31",x,y-142)
        --self:setFinger("2_31",x,y,w,h)
    --end)
end

function this.guide_2_32(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.evolve_panel.transform:Find("Bot/Title")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_32",x,y-142,w+120,h+282,2)
    self:setTxtAll("2_32",x,y-142)
end

function this.guide_2_33(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.evolve_panel.transform:Find("IntensButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("2_33",x,y,w,h,2)
    self:setTxtAll("2_33",x,y)
    --self:setFinger("2_33",x,y,w,h)
end

function this.guide_2_34(self)
    self.mask_ho.gameObject:SetActive(true)
    --coroutine.start(function() 
        --coroutine.waitforseconds(3)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
        local view =window.View
        local tf=view.evolve_panel.transform:Find("IntensButton")
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskAll(true)
        minX,minY,minW,minH = x,y,w,h
        self:setTxtAll("2_34",x,y)
    --end)
    
end

function this.guide_2_35(self)
    coroutine.start(function()
        self:setMaskAll(true)
        self.mask_bc.gameObject:SetActive(false)
        coroutine.waitforseconds(1)
        self:setTxtAll("2_35",0,0)
        self.mask_bc.gameObject:SetActive(true)
    end)
end

function this.guide_2_36(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.evolve_panel.transform:Find("Bot/Title")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskAll(true)
    --elf:setMaskPos("2_36",x,y-142,w+120,h+282,2)
    self:setTxtAll("2_36",x,y-142)
end

function this.guide_2_37(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.evolve_panel.transform:Find("Bot/MatterRoot/MatterList/1 (2)")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_37",x,y,w,h,2)
    self:setTxtAll("2_37",x,y)
end

--玉珠
function this.guide_2_38(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
        local view =window.View
        local tf=view.btnCtrl.transform:GetChild(3)
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        minX,minY,minW,minH = x,y,w,h
        self:setMaskPos("2_38",x,y,w,h,2)
        self:setTxtAll("2_38",x,y)
end

function this.guide_2_39(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.jade_pear_panel) then
            self.timer:Stop()
            local view =window.View
            local tf=view.jade_pear_panel.transform:Find("Middle/b1")
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskPos("2_39",x,y,w,h,2)
            self:setTxtAll("2_39",x,y)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_2_40(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.cardInfo.transform:Find("SubProp")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_40",x,y,w,h,2)
    self:setTxtAll("2_40",x,y)
    --self:setFinger("2_40",x,y,w,h)
end

function this.guide_2_41(self)--点击激活玉珠
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.jade_pear_panel.transform:Find("IntensButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("2_41",x,y,w,h,2)
    self:setTxtAll("2_41",x,y)
end

function this.guide_2_42(self)
    coroutine.start(function()
        coroutine.waitforseconds(1)
        self:setMaskAll(true)
        self:setTxtAll("2_42",0,0)
    end)
end

function this.guide_2_43(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.btnCtrl.transform:GetChild(5)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("2_43",x,y,w,h,2)
    self:setTxtAll("2_43",x,y)
end

function this.guide_2_44(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.limit_break_panel.transform:Find("Top/LevelBg")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_44",x,y,w,h,2)
    self:setTxtAll("2_44",x,y)
    --self:setFinger("2_44",x,y,w,h)
end

function this.guide_2_45(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.limit_break_panel.transform:Find("Bot/MatterRoot/1")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_45",x+240,y,w,h,2)
    self:setTxtAll("2_45",x+240,y)
    --self:setFinger("2_45",x,y,w,h)
end

function this.guide_2_46(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.limit_break_panel.transform:Find("Bot/MatterRoot/3")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_46",x,y,w,h,2)
    self:setTxtAll("2_46",x,y)
end
--亲密度
function this.guide_2_47(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.btnCtrl.transform:GetChild(6)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("2_47",x,y,w,h,2)
    self:setTxtAll("2_47",x,y)
end

function this.guide_2_48(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.friendly_panel.transform:Find("Right/Bg/Bot/Scroll View")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_48",x,y,w,h,2)
    self:setTxtAll("2_48",x,y)
    --self:setFinger("2_47",x,y,w,h)
end

function this.guide_2_49(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.friendly_panel.transform:Find("Right/Bg/Top/HertSlider")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_49",x+229,y,w+509,h+20,2)
    self:setTxtAll("2_49",x+229,y)
    --self:setFinger("2_43",x,y,w,h)
end

function this.guide_2_50(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.friendly_panel.transform:Find("Left/GetMarriedButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_50",x,y,w,h,2)
    self:setTxtAll("2_50",x,y)
    --self:setFinger("2_44",x,y,w,h)
end

function this.guide_2_51(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.friendly_panel.transform:Find("Left/SetRoomButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_51",x,y,w,h,2)
    self:setTxtAll("2_51",x,y)
    --self:setFinger("2_45",x,y,w,h)
end

--分解
function this.guide_2_52(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.btnCtrl.transform:GetChild(7)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("2_52",x,y,w,h,2)
    minX,minY,minW,minH = x,y,w,h
    self:setTxtAll("2_52",x,y)
end

function this.guide_2_53(self)
    self:setMaskAll(true)
    self:setTxtAll("2_53")
end

function this.guide_2_54(self)
    self:setMaskAll(true)
    self:setTxtAll("2_54")
end

function this.guide_2_55(self)
    self:setMaskAll(true)
    self:setTxtAll("2_55")
end

function this.guide_2_56(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardIntens)
    local view =window.View
    local tf=view.rc:GetObject("ReturnButton").transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    
    self:setMaskPos("2_56",x,y,w,h,2)
    self:setTxtAll("2_56",x,y)
   
end
function this.guide_2_57(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UICardList)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.rc:GetObject("BackButton")) then
            self.timer:Stop()
            local view =window.View
            local tf=view.rc:GetObject("BackButton").transform
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            
            self:setMaskPos("2_57",x,y,w,h,1)
            --self:setTxtAll("2_57",x,y)
            self:setFinger("2_57",x,y,w,h) 
            

            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
    
end

function this.guide_3_0(self)--编成
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
    local view =window.View
    local tf=view.team_btn.transform.parent
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskPos("3_0",x,y,w,h,2)
    self:setTxtAll("3_0",x,y)
end

function this.guide_3_1(self)
    self:setMaskAll(true)
    self:setTxtAll("3_1")
end

function this.guide_3_2(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.nineBox) then
            self.timer:Stop()
            local view =window.View
            local tf=view.nineBox.transform
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskPos("3_2",x,y+91,1424,700,2)
            self:setTxtAll("3_2",x,y+61)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_3_3(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
    local view =window.View
    local tf=view.nineBox.transform:GetChild(0):Find("AddButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("3_3",x,y,w,h,2)
    self:setTxtAll("3_3",x,y)
    --self:setFinger("3_0",x,y,w,h)
end

function this.guide_3_4(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
    local view =window.View
    local tf=view.nineBox.transform:GetChild(2):Find("AddButton")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("3_4",x,y+100,w+160,h+220,2)
    self:setTxtAll("3_4")
end

function this.guide_3_5(self)
    self:setMaskAll(true)
    self:setTxtAll("3_5")
end

function this.guide_3_6(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
    local view =window.View
    local tf=view.btnRoot
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("3_6",x,y,w,h,2)
    self:setTxtAll("3_6",x,y)
    --self:setFinger("3_0",x,y,w,h)
end

function this.guide_3_7(self)
    self:setMaskAll(true)
    self:setTxtAll("3_7")
end

function this.guide_3_8(self)
    self:setMaskAll(true)
    self:setTxtAll("3_8")
end



function this.guide_3_9(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
    local view =window.View
    local tf=view.btnRoot
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("3_9",x,y,w,h,2)
    self:setTxtAll("3_9",x,y)
end

function this.guide_3_10(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
    local view =window.View
    local tf=view.arrayIntens.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("3_10",x,y,w,h,2)
    self:setTxtAll("3_10",x,y)
end

function this.guide_3_11(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
    local view =window.View
    local tf=view.intensInfo.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("3_11",x,y-40,w,h+90,2)
    self:setTxtAll("3_11",x,y-40)
end

function this.guide_3_12(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
    local view =window.View
    local tf=view.confirm_Btn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("3_12",x,y,w,h,2)
    self:setTxtAll("3_12",x,y)
end

function this.guide_3_13(self)
    self:setMaskAll(true)
    self:setTxtAll("3_13")
    
end
 
function this.guide_4_0(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
    local view =window.View
    local tf=view.launchAtk_Image.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskAll(true)
    minX,minY,minW,minH = x,y,w,h
    self:setTxtAll("4_0",x,y)
end

function this.guide_4_1(self)
    self:setMaskAll(true)
    self:setTxtAll("4_1")
end

function this.guide_4_2(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
    local view =window.View
    local tf=view.Story
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("4_2",x,y,w,h,2)
    self:setTxtAll("4_2",x,y)
    --self:setFinger("4_2",x,y,w,h)
end

function this.guide_4_3(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
    local view =window.View
    local tf=view.EmperorWay
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("4_3",x,y,w,h,2)
    self:setTxtAll("4_3",x,y)
    --self:setFinger("4_2",x,y,w,h)
end

function this.guide_4_4(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
    local view =window.View
    local tf=view.SevenStar
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("4_4",x,y,w,h,2)
    self:setTxtAll("4_4",x,y)
    --self:setFinger("4_2",x,y,w,h)
end

function this.guide_4_5(self)
    self.mask_ho.gameObject:SetActive(true)
    --coroutine.start(function()
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
        local view =window.View
    --    view.btnCtrl:DOAnchorPos3D(Vector3.New(-1544.84,7.3773,0),1)
    --    coroutine.waitforseconds(2)
        local tf=view.Abysm    
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskPos("4_5",x,y,w,h,2)
        self:setTxtAll("4_5",x,y)
        --self:setFinger("4_2",x,y,w,h)
    --end)
    
end

function this.guide_4_6(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
    local view =window.View
    local tf=view.Abyss
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("4_6",x,y,w,h,2)
    self:setTxtAll("4_6",x,y)
    --self:setFinger("4_2",x,y,w,h)
end

function this.guide_4_7(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
    local view =window.View
    local tf=view.FourEmperor
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("4_7",x,y,w,h,2)
    self:setTxtAll("4_7",x,y)
    --self:setFinger("4_2",x,y,w,h)
end

function this.guide_4_8(self)
    self.mask_ho.gameObject:SetActive(true)
    --coroutine.start(function()
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
        local view =window.View
        --view.btnCtrl:DOAnchorPos3D(Vector3.New(0,7.3773,0),1)
        --coroutine.waitforseconds(2)
        local tf=view.Activity
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskPos("4_8",x,y,w,h,2)
        self:setTxtAll("4_8",x,y)
        --self:setFinger("4_2",x,y,w,h)
    --end)
    
end

function this.guide_4_9(self)
    self.mask_ho.gameObject:SetActive(true)
    --coroutine.start(function()
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode)
    local view =window.View
    --view.btnCtrl:DOAnchorPos3D(Vector3.New(0,7.3773,0),1)
    --coroutine.waitforseconds(2)
    local tf=view.Story
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("4_9",x,y,w,h,1)
    --self:setTxtAll("4_9",x,y)
    self:setFinger("4_9",x,y,w,h)
    --end)
    
end

function this.guide_5_0(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIStoryChapter)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.storyContent) and  not IsNull(window.View.storyContent.transform) and window.View.storyContent.transform.childCount>2then
            self.timer:Stop()
            local view =window.View
            local tf=view.storyContent:GetChild(0):Find("Frame")
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskAll(true)
            minX,minY,minW,minH = x,y,w,h
            self:setTxtAll("5_0",x,y)
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_5_1(self)
   
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UILaunchAtk)
        
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.content) and not IsNull(window.View.content.transform)  and window.View.content.transform.childCount>0  then
            self.timer:Stop()
            local view =window.View
            
            
            coroutine.start(function()
                self:setMaskAll(true)
                self.mask_bc.gameObject:SetActive(false)
                coroutine.waitforseconds(2)
                local tf=view.content.transform:GetChild(0):GetChild(0)
                local tf1=view.content.transform:GetChild(0):GetChild(1)
                local canvas = window.Layer.unity_canvas
                local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
                local x1,y1,w1,h1=self:GetWorldToScreenRect(canvas,tf1)
                minX,minY,minW,minH = x,y,w,h
                minX1,minY1,minW1,minH1 = x1,y1,w1,h1
                self:setTxtAll("5_1")
                self.mask_bc.gameObject:SetActive(true)
            end)
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_5_2(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UILaunchAtk)
        if window~=nil and not IsNull(window.View.transform) and not IsNull( window.View.content) and  not IsNull( window.View.content.transform) and window.View.content.transform.childCount>0  then
            self.timer:Stop()
            local view =window.View
            local tf=view.content.transform:GetChild(0):GetChild(0)
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskPos("5_2",x,y,w,h,2)
            self:setTxtAll("5_2",x,y)
            --self:setFinger("5_0",x,y,w,h)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_5_3(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UILaunchAtk)
    local view =window.View
    local tf=view.content.transform:GetChild(0):GetChild(1)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("5_3",x,y,w,h,2)
    self:setTxtAll("5_3",x,y)
    --self:setFinger("5_0",x,y,w,h)
end

function this.guide_5_4(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UILaunchAtk)
    local view =window.View
    local tf=view.diffCtrl
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskPos("5_4",x,y,w,h,2)
    self:setTxtAll("5_4",x,y)
    --self:setFinger("5_0",x,y,w,h)
end

function this.guide_5_5(self)
    
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UILaunchAtk)
        if window~=nil and not IsNull(window.View.transform) and not IsNull( window.View.content) and  not IsNull( window.View.content.transform) and window.View.content.transform.childCount>0  then
            self.timer:Stop()
            local view =window.View
            local tf=view.content.transform:GetChild(0):GetChild(0)
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            minX,minY,minW,minH = x,y,w,h
            self:setMaskAll(true)
            self:setTxtAll("5_5")
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end


function this.guide_5_6(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.ToolTipFirst)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.confirm_btn) then
            self.timer:Stop()
            local view =window.View
            local tf=view.confirm_btn
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            --minX,minY,minW,minH = x,y,w,h
            self:setMaskAll(true)
            --self:setTxtAll("5_6")
            self:setFinger("5_0",x,y,w,h)
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end
function this.guide_6_0(self)
    self:setMaskAll(true)
    self:setTxtAll("6_0",0,0)
end

function this.guide_6_1(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UILordMode)
    local view = window.View
    local tf = view.rc:GetObject("Road").transform
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("6_1", x, y, w, h, 2)
    self:setTxtAll("6_1", x, y)
end

function this.guide_6_2(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UILordMode)
    local view = window.View
    local tf = view.rc:GetObject("Tower").transform
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("6_2", x, y, w, h, 2)
    self:setTxtAll("6_2", x, y)
end

function this.guide_6_3(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UILordMode)
    local view = window.View
    local tf = view.rc:GetObject("Tower").transform
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("6_3", x, y, w, h, 2)
    self:setTxtAll("6_3", x, y)
end

function this.guide_7_0(self)
    
    self:setMaskAll(true)
    self:setTxtAll("7_0")
    --self.mask_ho.gameObject:SetActive(true)
    --self.timeUpdate=function(self)
    --    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UISevenStar)
    --    if window~=nil and window.View~=nil and window.View.rc:GetObject("DiffCtrl").transform ~=nil then
    --        self.timer:Stop()
    --        local view =window.View
    --        local tf=view.rc:GetObject("DiffCtrl").transform
    --        local canvas = window.Layer.unity_canvas
    --        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --        self:setMaskPos("7_0",x,y,w,h,2)
    --        self:setTxtAll("7_0",x,y)
    --        --self:setFinger("5_0",x,y,w,h)
    --       
    --    end
    --end
    --self.timer = TimerManager:GetInstance():GetTimer(1, self.timeUpdate , self)
    ---- 启动定时器
    --self.timer:Start()
end

function this.guide_7_1(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UISevenStar)
    local view = window.View
    local tf = view.transform:Find("Left/Bg")
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("7_1", x, y, w, h, 2)
    self:setTxtAll("7_1", x, y)
end

function this.guide_7_2(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UISevenStar)
    local view = window.View
    local tf = view.transform:Find("Left/Bg")
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("7_2", x, y, w, h, 2)
    self:setTxtAll("7_2", x, y)
end

function this.guide_8_0(self)
    self:setMaskAll(true)
    self:setTxtAll("8_0")
end

function this.guide_8_2(self)
    self:setMaskAll(true)
    self:setTxtAll("8_2")
end

function this.guide_8_3(self)
    self:setMaskAll(true)
    self:setTxtAll("8_3")
end

function this.guide_9_0(self)
    self:setMaskAll(true)
    self:setTxtAll("9_0")
end

function this.guide_9_1(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UIChallenge)
    local view = window.View
    local tf = view.rc:GetObject("Main").transform:Find("1")
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("9_1", x, y, w, h, 2)
    self:setTxtAll("9_1", x, y)
end

function this.guide_9_2(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UIChallenge)
    local view = window.View
    local tf = view.rc:GetObject("Main").transform:Find("2")
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("9_2", x, y, w, h, 2)
    self:setTxtAll("9_2", x, y)
end

function this.guide_9_3(self)
    local window = UIManager:GetInstance():GetWindow(UIWindowNames.UIChallenge)
    local view = window.View
    local tf = view.rc:GetObject("Main").transform:Find("3")
    local canvas = window.Layer.unity_canvas
    local x, y, w, h = self:GetWorldToScreenRect(canvas, tf)
    self:setMaskPos("9_3", x, y, w, h, 2)
    self:setTxtAll("9_3", x, y)
end

function this.guide_10_0(self)--信条技能
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UILordRoad)
    if window ==nil then--在重新进入游戏不主动进入信条引导
        --local window1 =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
        --local view =window1.View
        --local tf=view.team_btn.transform.parent
        --local canvas = window1.Layer.unity_canvas
        --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        --self:setMaskPos("10_0",x,y,w,h,1)
        --self:setTxtAll("10_0",x,y)
        --self:setFinger("10_0",x,y,w,h)
        local guide=Game.Scene:GetComponent("GuideComponent")
        guide:EndGuide()
    else
        self.mask_ho.gameObject:SetActive(true)
        self.timeUpdate=function(self)
            if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.rc:GetObject("Format"))  then
                self.timer:Stop()
                local view = window.View
                local tf = view.rc:GetObject("Format").transform
                local canvas = window.Layer.unity_canvas
                local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
                coroutine.start(function()
                    self:setMaskAll(true)
                    minX,minY,minW,minH = x,y,w,h
                    self.mask_bc.gameObject:SetActive(false)
                    coroutine.waitforseconds(1)
                    self:setTxtAll("10_0",x,y)
                    self.mask_bc.gameObject:SetActive(true)
                end)
            end
        end
        self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
        -- 启动定时器
        self.timer:Start()
    end
    
end

function this.guide_10_1(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFormatNew)
        if window~=nil and not IsNull(window.View.transform) and not IsNull(window.View.dogmaBtn) then
            self.timer:Stop()
            local view =window.View
            local tf=view.dogmaBtn.transform
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            minX,minY,minW,minH = x,y,w,h
            self:setMaskPos("10_1",x,y,w,h,2)
            self:setTxtAll("10_1",x,y)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_10_2(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIDogma)
        
        if window~=nil and not IsNull(window.View) and not IsNull(window.View.transform) and  not IsNull(window.View.transform:Find("Bg/Left/Bg3")) and not IsNull(window.View.transform:Find("Bg/Right/Bg3"))  then
            local view = window.View
            self.timer:Stop()
            local tf=view.transform:Find("Bg/Left/Bg3")
            local tf1=view.transform:Find("Bg/Right/Bg3")
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf1)
            local x1,y1,w1,h1=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskPos("10_2",x,y,w,h,2)
            self:setTxtAll("10_2")
            minX,minY,minW,minH = x1,y1,w1,h1

        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_10_3(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIDogma)
        local view =window.View
        if window~=nil and not IsNull(view.transform)  and not IsNull(view.rc:GetObject("PointNum"))  then
            self.timer:Stop()
            local tf=view.rc:GetObject("PointNum").transform
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskPos("10_3",x,y,w,h,2)
            self:setTxtAll("10_3",x,y)
            --self:setFinger("10_5",x,y,w,h)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_10_4(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIDogma)
        local view =window.View
        
        if window~=nil and not IsNull(view.transform)  and not IsNull(view.holdContent) and view.holdContent.transform.childCount>0  then
            self.timer:Stop()
            local tf=view.holdContent.transform:GetChild(0):Find("Button")
            for i = 0, view.holdContent.transform.childCount-1 do
                if view.holdContent.transform:GetChild(i).gameObject.activeSelf then
                    tf=view.holdContent.transform:GetChild(i):Find("Button")
                    self.UIDogmaGo4=view.holdContent.transform:GetChild(i)
                    break
                end
            end
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setMaskPos("10_4",x,y,w,h,2)
        self:setTxtAll("10_4",x,y)
        minX,minY,minW,minH = x,y,w,h
        --self:setFinger("10_4",x,y,w,h)
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
    
end

function this.guide_10_5(self)
    self.mask_ho.gameObject:SetActive(true)
    self.timeUpdate=function(self)
        local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIDogma)
        local view =window.View
        
        if window~=nil and not IsNull(view.transform)  and not IsNull(view.equipContent) and view.equipContent.transform.childCount>0 then
            self.timer:Stop()
            local tf=view.equipContent.transform:GetChild(0):Find("Button")
            for i = 0, view.equipContent.transform.childCount-1 do
                if view.equipContent.transform:GetChild(i).gameObject.activeSelf then
                    tf=view.equipContent.transform:GetChild(i):Find("Button")
                    break
                end
            end
            local canvas = window.Layer.unity_canvas
            local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
            self:setMaskPos("10_5",x,y,w,h,2)
            self:setTxtAll("10_5",x,y)
            --self:setFinger("10_5",x,y,w,h)
            
        end
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()
end

function this.guide_10_6(self)
    self:setMaskAll(true)
    self:setSprite(0,80,1344,756,305)
    self.Battle_Image.gameObject:SetActive(true)
    self:setTxtAll("10_6")
end

function this.guide_10_7(self)
    self:setMaskAll(true)
    --self:setSprite(0,80,870,340,"1")
    self.Battle_Image.gameObject:SetActive(true)
    self:setTxtAll("10_7")
end

function this.guide_10_8(self)
    self:setMaskAll(true)
    --self:setSprite(0,80,870,340,"1")
    self.Battle_Image.gameObject:SetActive(true)
    self:setTxtAll("10_8")
end

function this.guide_10_9(self)
    self:setMaskAll(true)
    self:setTxtAll("10_9")
end



function this.guide_11_0(self)
    self:setMaskAll(true)
    self:setTxtAll("11_0")
end

function this.guide_11_1(self)
    self:setMaskAll(true)
    self:setTxtAll("11_1")
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    --local tf=uic.BattleArrayBg.transform
    --local canvas = uic.BattleToolCanvas
    --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setTxtAll("11_1",x,y)
    ----self:setMaskAll(true)
    --self:setMaskPos("11_1",x,y,w,h,2)
    Game.Scene:GetComponent("BattleComponent").FriendGroup.Energy=120
    uic:UpdateBaEnergyBar()
end

function this.guide_11_2(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.BattleArrayBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --if LangUtil.GetLangType() == LangType.JA then
    --    self.TwoText:SetActive(true)
    --end
    self:setTxtAll("11_2",x,y)
    --self:setMaskAll(true)
    self:setMaskPos("11_2",x,y,w,h,2)
    minX,minY,minW,minH = x,y,w,h
end

function this.guide_11_3(self)
    local uic=Game.Scene:GetComponent("BattleUIComponent")
    local tf=uic.BattleArrayBg.transform
    local canvas = uic.BattleToolCanvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    
    self:setMaskAll(true)
    self:setTxtAll("11_3",x,y)
    minX,minY,minW,minH = x,y,w,h
end

function this.guide_11_4(self)
    --self:setMaskAll(true)
    --self:setTxtAll("11_4")
end

function this.guide_11_5(self)
    self:setMaskAll(true)
    self:setTxtAll("11_5")
end

function this.guide_11_6(self)
    self:setMaskAll(true)
    self:setTxtAll("11_6")
end

function this.guide_11_7(self)
    self:setMaskAll(true)
    self:setTxtAll("11_7")
end

function this.guide_11_8(self)
    self:setMaskAll(true)
    self:setTxtAll("11_8")
end

function this.guide_12_0(self)
    self:setMaskAll(true)
    self:setTxtAll("12_0")
end

function this.guide_12_1(self)
    self:setMaskAll(true)
    self:setTxtAll("12_1")
end

function this.guide_12_2(self)
    self:setMaskAll(true)
    self:setTxtAll("12_2")
end

function this.guide_12_3(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFightSoulIntens)
    local view =window.View
    local tf=view.rc:GetObject("ButtonRoot").transform.transform:GetChild(0)
    local tf1=view.rc:GetObject("ButtonRoot").transform.transform:GetChild(1)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    local x1,y1,w1,h1=self:GetWorldToScreenRect(canvas,tf1)
    self:setTxtAll("12_3",x,y)
    self:setMaskPos("12_3",x,y,w,h,2)
    minX,minY,minW,minH = x1,y1,w1,h1
    --self:setFinger("12_3",x,y,w,h)
end

function this.guide_12_4(self)
    self:setMaskAll(true)
    self:setTxtAll("12_4")
end

function this.guide_12_5(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFightSoulIntens)
    local view =window.View
    local tf=view.rc:GetObject("PanelRoot").transform:Find("ChangePanel/FightSoulRoot")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("12_5",x,y)
    self:setMaskPos("12_5",x,y,w,h,2)
    --self:setFinger("12_5",x,y,w,h)
end

function this.guide_12_6(self)
    self:setMaskAll(true)
    self:setTxtAll("12_6")
    --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFightSoulIntens)
    --local view =window.View
    --local tf=view.rc:GetObject("PanelRoot").transform:Find("ChangePanel/CardInfo/CardItemNew/CardInfo/Avatar")
    --local canvas = window.Layer.unity_canvas
    --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setTxtAll("12_6",x,y)
    --self:setMaskPos("12_6",x,y,w+40,h+100,2)
end

function this.guide_12_7(self)
    self:setMaskAll(true)
    self:setTxtAll("12_7")
end

function this.guide_12_8(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFightSoulIntens)
    local view =window.View
    local tf=view.rc:GetObject("ButtonRoot").transform.transform:GetChild(2)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskAll(true)
    self:setTxtAll("12_8")
    minX,minY,minW,minH = x,y,w,h
end

function this.guide_12_9(self)
    
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFightSoulIntens)
    local view =window.View
    local tf=view.fs_mainFightSoul
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setTxtAll("12_9",x,y)
    --self:setMaskPos("12_9",x,y,w,h,1)
    --self:setFinger("12_3",x,y,w,h)
    self:setSprite(x,y,922,270,303) -- ignoreCN
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    self:setTxtAll("12_9")
end

function this.guide_12_10(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFightSoulIntens)
    local view =window.View
    local tf=view.rc:GetObject("ButtonRoot").transform.transform:GetChild(3)
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    self:setTxtAll("12_10")
end

function this.guide_12_11(self)
    --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIFightSoulIntens)
    --local view =window.View
    --local tf=view.rc:GetObject("ButtonRoot").transform.transform:GetChild(3)
    --local canvas = window.Layer.unity_canvas
    --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --
    --self:setTxtAll("12_11",x,y)
    --self:setMaskPos("12_11",x,y,w,h,1)
    ----self:setFinger("12_3",x,y,w,h)
    self:setMaskAll(true)
    self:setTxtAll("12_11")
end

function this.guide_13_0(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    coroutine.start(function()
        self:setMaskAll(true)
        self.mask_bc.gameObject:SetActive(false)
        coroutine.waitforseconds(2)
        local view =window.View
        local tf=view.open_visit_btn.transform
        local canvas = window.Layer.unity_canvas
        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
        self:setTxtAll("13_0",x,y)
        self:setMaskPos("13_0",x,y,w,h,2)
        self.mask_bc.gameObject:SetActive(true)
    end)
    
    
    --self:setFinger("12_3",x,y,w,h)
end

function this.guide_13_1(self)
    self:setMaskAll(true)
    self:setTxtAll("13_1")
end

function this.guide_13_2(self)
    self:setSprite(0,80,1009,715,298)
    self:setMaskAll(true)
    self:setTxtAll("13_2")
end

function this.guide_13_3(self)
    self:setSprite(0,80,1009,715,299)
    self:setMaskAll(true)
    self:setTxtAll("13_3")
end

function this.guide_13_4(self)
    self:setSprite(0,80,1009,715,300)
    self:setMaskAll(true)
    self:setTxtAll("13_4")
end

function this.guide_13_5(self)
    self:setSprite(0,80,300,300,"专属装备") -- ignoreCN
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    local view =window.View
    local tf=view.open_change_btn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    self:setTxtAll("13_5")
end



function this.guide_13_6(self)
    --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    --local view =window.View
    --local tf=view.open_change_btn.transform
    --local canvas = window.Layer.unity_canvas
    --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskAll(true)
    self:setTxtAll("13_6")
    --self:setTxtAll("13_6",x,y)
    --self:setMaskPos("13_6",x,y,w,h,1)
    --self:setFinger("13_6",x,y,w,h)
end
function this.guide_13_7(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    local view =window.View
    local tf=view.change_panel.transform:Find("CardInfo/CardItemNew/CardInfo/Frame")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("13_7",x,y)
    self:setMaskPos("13_7",x,y,w+1200,h+250,2)
    --self:setFinger("13_6",x,y,w,h)
end

function this.guide_13_8(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    local view =window.View
    local tf=view.open_recast_btn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    self:setTxtAll("13_8")
end


function this.guide_13_9(self)
    --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    --local view =window.View
    --local tf=view.open_recast_btn.transform
    --local canvas = window.Layer.unity_canvas
    --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setTxtAll("13_9",x,y)
    --self:setMaskPos("13_9",x,y,w,h,1)
    --self:setFinger("13_9",x,y,w,h)
    self:setMaskAll(true)
    self:setTxtAll("13_9")
end

function this.guide_13_10(self)
    self:setSprite(0,80,870,340,"1")
    self:setMaskAll(true)
    self:setTxtAll("13_10")
end

function this.guide_13_11(self)
    self:setSprite(0,80,1150,340,"2")
    self:setMaskAll(true)
    self:setTxtAll("13_11")
end

function this.guide_13_12(self)
    self:setSprite(0,80,1430,340,"3")
    self:setMaskAll(true)
    self:setTxtAll("13_12")
end

function this.guide_13_13(self)
    self:setSprite(0,80,1700,340,"4")
    self:setMaskAll(true)
    self:setTxtAll("13_13")
end

function this.guide_13_14(self)
    self:setSprite(0,80,870,340,"5")
    self:setMaskAll(true)
    self:setTxtAll("13_14")
end

function this.guide_13_15(self)
    --self:setSprite(0,80,870,340,"5")
    self:setMaskAll(true)
    self:setTxtAll("13_15")
end

function this.guide_13_16(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    local view =window.View
    local tf=view.rc_formulaBtn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("13_16",x,y)
    self:setMaskPos("13_16",x,y,w,h,2)
    --self:setFinger("13_9",x,y,w,h)
end

function this.guide_13_17(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    local view =window.View
    local tf=view.open_resolve_btn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    self:setTxtAll("13_17")
end


function this.guide_13_18(self)
    --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    --local view =window.View
    --local tf=view.open_resolve_btn.transform
    --local canvas = window.Layer.unity_canvas
    --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setTxtAll("13_18",x,y)
    --self:setMaskPos("13_18",x,y,w,h,1)
    --self:setFinger("13_18",x,y,w,h)
    self:setMaskAll(true)
    self:setTxtAll("13_18")
end

function this.guide_13_19(self)
    self:setMaskAll(true)
    self:setTxtAll("13_19")
    --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIEquipIntens)
    --local view =window.View
    --local tf=view.resolve_panel.transform:Find("Image")
    --local canvas = window.Layer.unity_canvas
    --local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --self:setTxtAll("13_19",x,y)
    --self:setMaskPos("13_19",x,y,w,h,2)
    --self:setFinger("13_19",x,y,w,h)
end

function this.guide_14_0(self)
    self:setMaskAll(true)
    self:setTxtAll("14_0")
    --self.mask_ho.gameObject:SetActive(true)
    --self.timeUpdate=function(self)
    --    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleArrayIntens)
    --    local view =window.View
    --    if window~=nil and view ~=nil  and view.activeInfoRoot ~=nil then
    --        self.timer:Stop()
    --        local tf=view.activeInfoRoot.transform
    --        local canvas = window.Layer.unity_canvas
    --        local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    --        self:setMaskPos("14_0",x,y,w,h,2)
    --        self:setTxtAll("14_0",x,y)
    --        --self:setFinger("10_5",x,y,w,h)
    --        
    --    end
    --end
    --self.timer = TimerManager:GetInstance():GetTimer(1, self.timeUpdate , self)
    ---- 启动定时器
    --self.timer:Start()
end

function this.guide_14_1(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleArrayIntens)
    local view =window.View
    local tf=view.activeInfoBtn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("14_1",x,y)
    self:setMaskPos("14_1",x,y,w,h,2)
    --self:setFinger("12_3",x,y,w,h)
end

function this.guide_14_2(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleArrayIntens)
    local view =window.View
    local tf=view.skillInfoRoot.transform.parent:Find("Dw")
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("14_2",x,y)
    self:setMaskPos("14_2",x,y,w,h,2)
    --self:setFinger("12_3",x,y,w,h)
end

function this.guide_14_3(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleArrayIntens)
    local view =window.View
    local tf=view.activeBtn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("14_3",x,y)
    self:setMaskPos("14_3",x,y,w,h,2)
end

function this.guide_15_0(self)
    self:setMaskAll(true)
    self:setTxtAll("15_0")
end

function this.guide_15_1(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIRoom)
    local view =window.View
    local tf=view.restBtn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("15_1",x,y)
    self:setMaskPos("15_1",x,y,w,h,2)
    --self:setFinger("12_3",x,y,w,h)
end

function this.guide_15_2(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIRoom)
    local view =window.View
    local tf=view.restBtn.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setMaskAll(true)
    self:setTxtAll("15_2",x,y)
end

function this.guide_15_3(self)
    self:setMaskAll(true)
    self:setTxtAll("15_3")
end

function this.guide_15_4(self)
    self:setMaskAll(true)
    self:setTxtAll("15_4")
end

function this.guide_16_0(self)
    self:setMaskAll(true)
    self:setTxtAll("16_0")
end

function this.guide_16_1(self)
    self:setSprite(0,80,1374,786,302)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIProp)
    local view =window.View
    local tf=view.btnList[2].transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    self:setTxtAll("16_1")
end

function this.guide_16_2(self)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIProp)
    local view =window.View
    local tf=view.usePanel.transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    self:setTxtAll("16_2",x,y)
    self:setMaskPos("16_2",x,y,w,h,2)
end

function this.guide_16_3(self)
    self:setSprite(0,80,1374,786,301)
    local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIProp)
    local view =window.View
    local tf=view.btnList[3].transform
    local canvas = window.Layer.unity_canvas
    local x,y,w,h=self:GetWorldToScreenRect(canvas,tf)
    minX,minY,minW,minH = x,y,w,h
    self:setMaskAll(true)
    self:setTxtAll("16_3")
end

function this.guide_16_4(self)
    self:setMaskAll(true)
    self:setTxtAll("16_4")
end

function this.guide_16_5(self)
    self:setMaskAll(true)
    self:setTxtAll("16_5")
end


function this.BattleGuideClick(self,cid,num,minStep)
    local battle=Game.Scene:GetComponent("BattleUIComponent")
    local battleCom=Game.Scene:GetComponent("BattleComponent")
    local guide=Game.Scene:GetComponent("GuideComponent")
    --if LangUtil.GetLangType() == LangType.JA then
        if  num==7 and minStep == 6 then
            if battleCom~=nil then
                battleCom.nex=false
            end
        end
        if  num==19 and minStep == 2 then
            self:hideFinger()
            self:Hide()
            self:hideTxtAll()
            self.mask_ho.gameObject:SetActive(false)
            if battleCom~=nil then
                battleCom.nex=false
                battleCom:SetBattleSpeed(guide.BattleSpeed)
            end

        elseif num==15 and minStep == 2 then
            battle:ChooseAtk()
            local id = self:FindId(cid,num,minStep)
            guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
        elseif num==16  then
            battle:ChooseEnemyUnit(5)
            self:hideFinger()
            self:Hide()
            self:hideTxtAll()
            self.mask_ho.gameObject:SetActive(false)
            --self:guide_0_16()
            --DataManager:GetInstance():Broadcast(DataMessageNames.ON_Guide_CHG)
        elseif num==20 and minStep == 2 then
            battle:ChooseAtk(1)
            self:hideFinger()
            self:Hide()
            self:hideTxtAll()
            self.mask_ho.gameObject:SetActive(false)
            if battleCom~=nil then
                battleCom.nex=false
            end
        elseif num==21 and minStep == 3 then
            battle:ChooseAtk()
            self:hideFinger()
            self:Hide()
            self:hideTxtAll()
            self.mask_ho.gameObject:SetActive(false)
            if battleCom~=nil then
                battleCom.nex=false
            end
        elseif num==22 and minStep == 5 then
            battle:ChooseAtk(3)
            self:hideFinger()
            self:Hide()
            self:hideTxtAll()
            self.mask_ho.gameObject:SetActive(false)
            if battleCom~=nil then
                battleCom.nex=false
            end
        elseif num==23 and minStep == 4 then
            battle:ChooseAtk(2)
            self:hideFinger()
            self:Hide()
            self:hideTxtAll()
            self.mask_ho.gameObject:SetActive(false)
            if battleCom~=nil then
                battleCom.nex=false
            end
        elseif num==24 and minStep == 1 then
            self.mask_bc.transform.parent.gameObject:SetActive(false)
            if battleCom~=nil then
                battleCom.nex=false
            end
        else
            local id = self:FindId(cid,num,minStep)
            guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
        end
    --end
    
end

---------收到引导点击事件
function this.ON_Guide_Click(self,cid,num,isrun,minStep)
    if not isrun then return  end
    
    local guide=Game.Scene:GetComponent("GuideComponent")
    local sendId = (cid+1)*1000+1
    local stepId = self:FindId(cid,num,minStep)
    local save = Z_NoviceGuide[stepId].save
    local type = 0
    if save ~= 0 and Z_NoviceGuide[stepId].notAutoSave ~= 1 then
        -- local SStep= table.first(guide.GuideList,function (v) return v.Id==sendId  end)
        -- if SStep~=nil then
        --     type= save - SStep["Step"]
        -- else
        --     type = save
        -- end
        type = save
        local reqData1 = {Type = type,Id=sendId}
        guide:ChooseDate(reqData1)
    end
    self.mask_bt.gameObject:SetActive(false)
    local battle=Game.Scene:GetComponent("BattleUIComponent")
    local battleCom=Game.Scene:GetComponent("BattleComponent")
    local guide=Game.Scene:GetComponent("GuideComponent")
    if cid==0 then
        self:BattleGuideClick(cid,num,minStep)
    elseif cid==2 then
        if  num==0 and minStep==2  then
            self.mask_bt:SetActive(false)
            coroutine.start(function() Game.Scene:GetComponent("GuideComponent"):GuideReward() end)
        else
            local id = self:FindId(cid,num,minStep)
            guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
            
        end
    elseif cid==4 and num == 9 then
        local id = self:FindId(cid,num,minStep)
        guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIStoryChapter)
    elseif cid == 10 and num == 4  then
        if  minStep== 1 then
            local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIDogma)
            local view =window.View
            local info = {["data"]=10001,["go"]=self.UIDogmaGo4}
            view:OnClickEquipButton(info)
            local id = self:FindId(cid,num,minStep)
            guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
        else
            local id = self:FindId(cid,num,minStep)
            guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
        end
    elseif cid == 11 and num == 2  then
        
        if  minStep==4 then
                   
        else
            local id = self:FindId(cid,num,minStep)
            guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
            
        end
    else
        local id = self:FindId(cid,num,minStep)
        guide:OnClickOpenView(Z_NoviceGuide[id].OpenCode)
    end

end

function this.FindId(self,cid,num,minStep)
    local str = ""
    if minStep ~= 0 then
        str = cid.."_"..num.."_"..minStep
    else
        str = cid.."_"..num
    end
    local step = table.first(Z_NoviceGuide,function(v) return v.Step==str  end)
    return step.Id
end 

---------
return this;
