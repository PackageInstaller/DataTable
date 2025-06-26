
local UIPlayerInceptionInfoView = BaseClass("UIPlayerInceptionInfoView",UIBaseView);
local base = UIBaseView;
local this = UIPlayerInceptionInfoView;

local INIT_CHARACTERS = Z_Misc["INIT_CHARACTERS"].Value

function this.OnCreate(self)
    base.OnCreate(self)
    local rc = self.rc
    local guide=Game.Scene:GetComponent("GuideComponent")
    guide.GuideRun=true
    self.run=1
    self.step=0
    self.stepmin = 0
    self.ChoseId=0
    self.pic_rt=rc:GetObject("pic"):GetComponent(typeof(RectTransform))
    self.pic_im=rc:GetObject("pic"):GetComponent("Image")
    self.name_bt = rc:GetObject("name_bt")--:GetComponent(typeof(UIButton))
    self.minTxt = rc:GetObject("minTxt")
    self.maxTxt=rc:GetObject("maxTxt")
    self.minTxt_bg= rc:GetObject("minTxt_bg")
    self.maxTxt_bg= rc:GetObject("maxTxt_bg")
    self.input=rc:GetObject("InputField"):GetComponent(typeof(UE_UI.InputField))
    self.blink = rc:GetObject("Blink")
    --self.maxTxt.text=""
    self.Tip=rc:GetObject("Tip")
    self.tip_txt=rc:GetObject("tip_txt"):GetComponent(typeof(UE_UI.Text))
    self.tipSure_bt=rc:GetObject("tipSure_bt")
    self.tipCancel_bt=rc:GetObject("tipCancel_bt")
    self.chosePanel=rc:GetObject("chosePanel")
    self.player1=rc:GetObject("player1")
    self.player2=rc:GetObject("player2")
    self.bt=rc:GetObject("bt")
    self.Ring1=rc:GetObject("Ring1")
    self.player1_Raw=rc:GetObject("player1_Raw")
    self.player2_Raw=rc:GetObject("player2_Raw")
    self.bt.gameObject:SetActive(false)
    self.transition = rc:GetObject("Transition"):GetComponent("Image");
    self.transition.color = Color.New(0,0,0,0);
    self.transition.gameObject:SetActive(false)
    self.blink:SetActive(false)
    ButtonListener.Get(self.name_bt).OnClickHandler = function ()
        if  self.step==2 then
            self:ON_Click()
        else 
            self:Guide_4_0(self)
        end
    end
    ButtonListener.Get(self.bt).OnClickHandler = function () self:ON_Click() end
    ButtonListener.Get(self.player1).OnClickHandler = function () 
        self.chooseIndex = 1
        self.cardId= tonumber(INIT_CHARACTERS[1])
        self.otherCardId = tonumber(INIT_CHARACTERS[2])
        if self.ChoseId==0 then
            self:ON_Click()
        else
            self:ON_Click()
        end
    end
    ButtonListener.Get(self.player2).OnClickHandler = function ()
        self.chooseIndex = 2
        self.cardId=tonumber(INIT_CHARACTERS[2])
        self.otherCardId= tonumber(INIT_CHARACTERS[1])
        if self.ChoseId==0 then
            self:ON_Click()
        else
            self:ON_Click() 
        end
    end
    --ButtonListener.Get(self.tipCancel_bt).OnClickHandler = function () self.Tip.gameObject:SetActive(false) end
    --self:setPicPos(-6,-22,848.5,1035.9,"1028_HaSiTa.png")
    self:OnInit(self)
    --Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "HandBook")
end

function this.OnLangCreate (self)
    LangUtil.BindText(self.input.transform:Find("Placeholder"))
    LangUtil.BindText(self.input.transform:Find("Text"))
    LangUtil.BindText(self.input.transform:Find("name_bt/Text"))
    LangUtil.BindText(self.Tip.transform:Find("tit/Text"))
    LangUtil.BindText(self.tip_txt)
    LangUtil.BindText(self.tipSure_bt.transform:Find("Text"))
    LangUtil.BindText(self.tipCancel_bt.transform:Find("Text"))
end

function this.OnInit(self)
    local guide=Game.Scene:GetComponent("GuideComponent")--攻击教程
    if table.length(guide.GuideList)>0 then
        local GuideSept = table.first(guide.GuideList,function (v) return v.Id == 1  end)
        if GuideSept ~=nil and GuideSept["Step"] < 4 then
            self.bt.gameObject:SetActive(true)
            self:SceneBlink(2)
            self.step=0
        elseif GuideSept ~=nil and GuideSept["Step"] >= 4 then
            self:Guide_4_0(self)
            self.minTxt_bg.gameObject:SetActive(false)
            self.step=4
        else
            self.bt.gameObject:SetActive(true)
            self.step=0
        end
    else
        self:SceneBlink(2)
        self.bt.gameObject:SetActive(true)
        self.step=0
    end
    
end

--local function OnChooseCardChg(self)
--    if self.step==7 and self.run==1 then
--        self:ON_Click()
--    end
--end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
    --Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "HandBook")
end
function this.OnRefresh(self)
    self.input.text = ""
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    --self:AddUIListener(UIMessageNames.ON_SUMMON_INFO_CHG,OnChooseCardChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
    if self.timer ~= nil then
        self.timer:Stop()
    end
    if self.model.callBack ~= nil then
        self.model.callBack()
    end
    --Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Home")
end

function this.OnDestroy(self)
    base.OnDestroy(self);
    self.run=0
end
function this.setTxt(self,T,str)
    if T==1 then
        self.maxTxt_bg.gameObject:SetActive(false)
        self.minTxt_bg.gameObject:SetActive(true)
        LangUtil.BindText(self.minTxt.transform:Find("minTxt")).text = LangUtil.GetLang(Z_NoviceGuide,str,"Desc")
    elseif T==2 then
        self.maxTxt_bg.gameObject:SetActive(true)
        self.minTxt_bg.gameObject:SetActive(false)
        LangUtil.BindText(self.maxTxt.transform:Find("maxTxt")).text = LangUtil.GetLang(Z_NoviceGuide,str,"Desc")
    end
end

function this.setPicPos(self,x,y,w,h,name)
    self.pic_rt.gameObject:SetActive(true)
    --UIUtil.SetCardSprite(self.pic_im,Card_id,skin,path,true)
    local path="UI/Guide/"..name
    coroutine.start(function ()
        self.pic_im.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
        --UIUtil.SetSprite(self.pic_im,path,name,true)
        local v= Vector2.New(x,y)
        local wh=Vector2.New(w,h)
        self.pic_rt.anchoredPosition=v
        self.pic_rt.sizeDelta=wh 
    end)
    
end

function this.setTip(self,str,func)
    self.Tip.gameObject:SetActive(true)
    self.tip_txt.text=str
    ButtonListener.Get(self.tipSure_bt).OnClickHandler = function ()  self.ChoseId=0 func() end ;
    ButtonListener.Get(self.tipCancel_bt).OnClickHandler = function () self.ChoseId=1 self.Tip.gameObject:SetActive(false)  self.step = self.step-1 end
end

function this.OnClickConfirmButton(self)
    local str = self.input.text
    --self.input.text = ""
    if string.IsNullOrEmpty(str) then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(559))
        self.step = self.step-1
        return
    end

    if string.utf8len(str) > 8 then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(560))
        self.step = self.step-1
        return
    end
    -- local tbResults = LibStringSearch:IsContains(str)
    -- if tbResults then
    --     UIUtil.ToolTipFourth(LangUtil.GetSysLang(866))
    --     self.step = self.step-1
    --     return
    -- end

    PublicRequest.SendRequest(
        PROTOCOL.ChangeNameReq,
        {name = str},
        function(response, errorCode)
            if errorCode ~= 0 and errorCode ~= nil then
                -- 改名失败 返回前一步
                UIUtil.ToolTipFourth(LangUtil.GetServerError(info.Error))
                self.step = self.step-1
                self:Guide_2_0()
            else
                -- 改名成功 进入下一步
                Game.Scene.Player:ChangeName(response.name)
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_NAME_CHANGED)
                self:ON_Click()
            end
        end
    )
end

function this.Guide_0_1(self)
    self.bt.gameObject:SetActive(true)
    self:setTxt(1,2)
end

function this.Guide_1_0(self)
    self.bt.gameObject:SetActive(true)
    self:setTxt(1,3)
end

function this.Guide_2_0(self)
    self.minTxt_bg.gameObject:SetActive(false)
    self.bt.gameObject:SetActive(false)
    self:setPicPos(36,-194.6,822.7,1374.8,"1000.png")
    self.input.gameObject:SetActive(true)
end

function this.Guide_3_0(self)
    
    local str= string.gsub(LangUtil.GetSysLang(561),"X",self.input.text)--"确定玩家名称为<color=#fff2aa>"..self.input.text.."</color>吗？一旦确认玩家名称后需要在商店购买并消耗<color=#7ae8ff>【回溯沙漏】</color>才能更改名称"
    if not string.IsNullOrEmpty(self.input.text) then
        self:setTip(str,function () self:OnClickConfirmButton()  self.Tip.gameObject:SetActive(false) end)
    else
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(559))
        self.step = self.step-1
    end
    
end

function this.Guide_4_0(self)
    self.input.gameObject:SetActive(false)
    self.bt.gameObject:SetActive(true)
    self.pic_rt.gameObject:SetActive(false)
    --self.chosePanel.gameObject:SetActive(true)
    self.maxTxt_bg.gameObject:SetActive(true)
    self:setTxt(2,6)
end

function this.Guide_5_0(self)
    self.bt.gameObject:SetActive(false)
    coroutine.start(function ()
        self.transition.gameObject:SetActive(true)
        self.transition:DOFade(1,0.5)
        self.transition.raycastTarget = true
        --self.pic_rt.gameObject:SetActive(false)
        coroutine.waitforseconds(0.5)
        self.chosePanel.gameObject:SetActive(true)
        self.transition.raycastTarget = false
        self.transition:DOFade(0,0.5)
        self.maxTxt_bg.gameObject:SetActive(true)
        UIPublic.PlayEffect(self.Ring1)
        self.timeUpdate(self)
        self.timer = TimerManager:GetInstance():GetTimer(4, self.timeUpdate , self)
        -- 启动定时器
        self.timer:Start()
        self:setTxt(2,7)
    end)
    --self.maxTxt_bg.gameObject:SetActive(true)
    --UIPublic.PlayEffect(self.Ring1)
    --self.timeUpdate(self)
    --self.timer = TimerManager:GetInstance():GetTimer(4, self.timeUpdate , self)
    ---- 启动定时器
    --self.timer:Start()
    --self:setTxt(2,6)
    --self.maxTxt.text="对你来说最重要的<color=#fff2aa>【超越者】</color>，与你一起历经过千难万险的那个她，你也应该还记得是谁吧?"
end

function this.timeUpdate(self)
    coroutine.start(function()
        if not IsNull(self.player1_Raw.gameObject) and  not IsNull(self.player2_Raw.gameObject) then
            self.player1_Raw.gameObject:SetActive(true)
            self.player2_Raw.gameObject:SetActive(false)
        end
        coroutine.waitforseconds(2)
        if not IsNull(self.player1_Raw.gameObject) and  not IsNull(self.player2_Raw.gameObject) then
            self.player1_Raw.gameObject:SetActive(false)
            self.player2_Raw.gameObject:SetActive(true)
        end
        coroutine.waitforseconds(2)
    end)
end

function this.Guide_6_0(self)
    self.maxTxt_bg.gameObject:SetActive(false)
    local str = string.gsub(LangUtil.GetSysLang(562),"X",Z_Card[self.cardId].Name)--"确定选择<color=#7ae8ff>【"..XXX.."】</color>为起始角色吗？"
    str = string.gsub(str,"Y",Z_Card[self.otherCardId].Name)
    -- local card = table.first(Game.Scene.Player:GetComponent("CardComponent").Cards,function(v) return  v.TemplateId == self.cardId  end);
    -- if card==nil  then
    --     --local price={need_paid=0,need_free=0,need_StarLightGem=0}
    --     local id={TemplateId=self.cardId,SummonResTypeInfo=0,Star = 0}
    --     --local idList = {id,id,id,id,id,id,id,id,id,id,id}
    --     --card = table.first(Game.Scene.Player:GetComponent("CardComponent").Cards,function(v) return  v.TemplateId == self.cardId  end);
    -- end
    self:setTip(str,function () 
        self.ctrl:SendChooseCard(self.chooseIndex,
            function() self:ON_Click() end,
            function () self.step = self.step-1 end,
            function() self:ON_Click() self:ON_Click() end
        )
        self.Tip.gameObject:SetActive(false)
    end)
end

function this.Guide_7_0(self)
    
end

function this.Guide_8_0(self)
    --coroutine.start(function() 
    --    coroutine.waitforseconds(3)
        self.chosePanel.gameObject:SetActive(false)
        self.bt.gameObject:SetActive(true)
        local a=self.cardId .."_1.png"
        self:setPicPos(36,-194.6,822.7,1374.8,a)
        self.pic_rt.gameObject:SetActive(true)
        self.maxTxt_bg.gameObject:SetActive(true)
        self:setTxt(2,10)
    --end)
    
    --self.maxTxt.text="没错，是他，无论发生什么都坚持和你永远在一起的【超越者】。\n"
end

function this.Guide_8_1(self)
    self.bt.gameObject:SetActive(true)
    self:setTxt(2,11)
end

 function this.nextStep(self,OpenCode)
    local guide=Game.Scene:GetComponent("GuideComponent")--攻击教程l
    local str = string.split(OpenCode,'_')
    self.step = tonumber(str[1]) 
    self.stepmin = tonumber(str[2])
     local a=self["Guide_"..OpenCode]
    a(self)
    local SStep= table.first(guide.GuideList,function (v) return v.Id==1  end)
    local stepId = "17_"..self.step.."_"..self.stepmin
    local step = table.first(Z_NoviceGuide,function(v) return v.Step==stepId  end)
    if step.save ~= 0 and step.notAutoSave ~= 1 then
        guide:ChooseDate({
            Id = 1,
            Type = step.save
        })
    end
    -- if SStep ~= nil then
    --     local type= self.step - SStep["Step"]
    --     if type > 0 then
    --         local reqData = {Type = type,Id=1}
    --         guide:ChooseDate(reqData)
    --     end
    -- else
    --     local reqData = {Type = 1,Id=1}
    --     guide:ChooseDate(reqData)
    -- end
end

function this.ON_Click(self)
    local guide=Game.Scene:GetComponent("GuideComponent")--攻击教程
    local str = "17_"..self.step.."_"..self.stepmin
    local step = table.first(Z_NoviceGuide,function(v) return v.Step==str  end)
    if self.step<=8 and not string.IsNullOrEmpty(step.OpenCode) then
        local OpenCode = step.OpenCode
        self:nextStep(OpenCode)
    else
        guide.GuideRun = false
        self.run=0
        self.timer:Stop()
        guide:CheckStart(0, 0)
        --guide:CurGuide(0)
        self.transition:DOFade(1,0.1)
        self.transition.raycastTarget = true
        --self.ctrl:CloseBut()
        self.bt.gameObject:SetActive(false)
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_UI_2TRANSIT)
    end
    
end



function this.SceneBlink(self, times)
    self.blink:SetActive(true)
    times = times or 1
    local img = self.blink:GetComponent("Image")
    coroutine.start(function ()
        local val = 0.6
        for index = 1, tonumber(times) - 1 do
            for i = 1, 19 do
                val = val - 0.03
                img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
                coroutine.waitforframes(1)
            end
            for i = 1, 19 do
                val = val + 0.03
                img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
                coroutine.waitforframes(1)
            end
            coroutine.waitforseconds(0.3)
        end

        for i = 1, 19 do
            val = val - 0.03
            img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
            coroutine.waitforframes(1)
        end
        for i = 1, 40 do
            val = val + 0.03
            if val > 0.6 then
                img.material:SetVector("_Param", Vector4.New(0.5 + val * 0.03, val, 1, 1))
            else
                img.material:SetVector("_Param", Vector4.New(0.5, val, 1, 1))
            end
            coroutine.waitforframes(1)
        end
        self.blink:SetActive(false)
        --coroutine.waitforframes(1)
        self:setTxt(1,1)
        self:setPicPos(-6,-22,848.5,1035.9,"1028_HaSiTa.png")
        
    end)
end

return this