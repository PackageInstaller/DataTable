---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/1 16:21
---

local UIEquipHandBookView = BaseClass("UIEquipHandBookView",UIBaseView)
local base = UIBaseView;
local this = UIEquipHandBookView;

local pfbName = "EquipItemNew_HandBook"
local color1 = Color.New(131/255,146/255,164/255)

--- 传入id
local function OnSort(self,a,b)
    local aEquip = Z_Equip[a]
    local bEquip = Z_Equip[b]
    -- if aEquip.Star ~= bEquip.Star then
    --     return aEquip.Star < bEquip.Star
    -- end
    return  a < b
end

local function DoScreen(self)
    local list = {}
    if self.screenMode ~= 0 then
        local zEquipIdList = table.choose(self.zEquipIdList[self.zEquipListId],function(k,v) return Z_Equip[v].Part == self.screenMode  end)
        for k,v in table.pairsByKeys(zEquipIdList) do
            table.insert(list,v)
        end
        if self.zEquipListId == 1  then
            table.sort(list,function (a,b) return OnSort(self,a,b)  end)
        end
        
        self.vs_list = list
        if table.count(self.vs_list) <=0  then
            self.vs_scroll:RefreshData(self.vs_list)
            self.hint:SetActive(true)
        else
            self.hint:SetActive(false)
            self.vs_scroll:RefreshData(self.vs_list)
        end
    else
        for k,v in table.pairsByKeys(self.zEquipIdList[self.zEquipListId]) do
            table.insert(list,v)
        end
        if self.zEquipListId == 1  then
            table.sort(list,function (a,b) return OnSort(self,a,b)  end)
        end
        self.hint:SetActive(false)
        self.vs_list = list
        self.vs_scroll:RefreshData(self.vs_list)
    end
    self.vs_scroll:MoveTop()
end

local function InitEquipItem(self,zEquip)
    local transform = self.objectList[zEquip.Part][zEquip.Id].transform
    local avatar = transform:Find("Avatar"):GetComponent("Image")
    local starRoot = transform:Find("Avatar/Star")
    local nameTxt = transform:Find("NameImage/Name/Value"):GetComponent("Text")
    
    UIUtil.ScrollText(nameTxt)
    
    local mask = transform:Find("Mask").gameObject
    local frame = transform:Find("Frame"):GetComponent("Image")
    local hint = transform:Find("Hint").gameObject
    hint:SetActive(false)

    if self.recordComponent:CheckIsOn(RecordType.Equip, zEquip.Id) then
        mask:SetActive(false)
        transform:GetComponent("Button").enabled = true
    else
        mask:SetActive(true)
        transform:GetComponent("Button").enabled = false
    end

   
    for i = 0,starRoot.childCount - 1 do
        local child = starRoot:GetChild(i).gameObject
        if zEquip.Exclusive == 0 then
            child:SetActive(zEquip.Star >= i + 1)
        else
            child:SetActive(i +1 <= 1)
        end
    end
    LangUtil.BindText(nameTxt).text = zEquip.Name
    --transform.gameObject:SetActive(zEquip.Part == self.screenMode or self.screenMode == 0)
    UIPublic.InitEquipBg(zEquip,frame)
    UIUtil.SetSprite(avatar,AtlasConfig.Equip,zEquip.EquipIcon)
end

local function InitContent(self,content,go, cid)

    UIPublic.InitEquipItemNew(
        go.transform,
    {
            Id = cid,
            TemplateId = cid,
            Level = nil,
            Lock = nil,
        },
        true,
        true
    )

    local rc = go:GetComponent("ReferenceCollector")
    local mask = rc:GetObject("Mask")
    local nameMask = rc:GetObject("NameMask")
    local propertyMask = rc:GetObject("PropertyMask")
    local propertyRoot = rc:GetObject("PropertyRoot")
    local avatar = rc:GetObject("Avatar")
    local starBg = rc:GetObject("StarBg")
    UIUtil.AddBtnEvent(go, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIEquipProp,{TemplateId = cid })
    end)

    if Game.Scene.Player:GetComponent("RecordComponent"):CheckIsOn(RecordType.Equip, cid) then
        mask:SetActive(false)
        nameMask:SetActive(false)
        propertyMask:SetActive(false)
        go:GetComponent("Button").enabled = true
    else
        mask:SetActive(true)
        nameMask:SetActive(true)
        propertyMask:SetActive(true)
        go:GetComponent("Button").enabled = false
    end
    UIPublic.InitEncyclopediaDetail(propertyRoot.transform, cid, RecordType.Equip, 0 )
end

local function OnKindButton(self,id)
    self.zEquipListId = id
    local zEquipIdList = self.zEquipIdList[id]
    local idList ={}
    for k,v in table.pairsByKeys(zEquipIdList) do
        table.insert(idList,v)
    end
    if id == 1  then
        table.sort(idList,function (a,b) return OnSort(self,a,b)  end)
    end

    for k,v in pairs(self.btns) do
        v.transform:Find("Active").gameObject:SetActive(id ==k)
        v.transform:GetComponent("Button").enabled  = (not (id ==k))
    end

    self.vs_list=table.choose(idList, function (k, v) return Z_Equip[v].Part == self.screenMode or self.screenMode == 0 end)
   
    self.vs_scroll:RefreshData(self.vs_list)

    self.vs_scroll:MoveTop()
end

local function OnScreenButton(self,id)
    self.screenMode = id - 1
    DoScreen(self)
    for k,v in pairs(self.screens) do
        v.transform:Find("Active").gameObject:SetActive(k == id)
        ---@type UnityEngine.UI.Text
        local text = v.transform:Find("Mask/Text"):GetComponent("Text")
        text.color = (id == k and {Color.white} or {color1})[1]
        text.fontSize = (id == k and {40} or {36})[1]
        v.transform:GetComponent("Button").enabled  = (not (id ==k))
    end
end



function this.OnLangCreate(self)
    local screenCtrl = self.langRc:GetObject("ScreenCtrl").transform
    local btnCtrl = self.langRc:GetObject("BtnCtrl").transform
    local progress = self.langRc:GetObject("Progress").transform
    local hold = self.langRc:GetObject("Hold").transform
    local backText = self.langRc:GetObject("BackText").transform

    local ids = { 473,475 }
    for i =0,btnCtrl.childCount - 1 do
        local id = ids[i+1]
        if id~= 0 then
            local root = btnCtrl:GetChild(i)
            local rootImg = root:GetComponent("Image")
            LangUtil.GetSpriteLang(id,function(sprite)
                rootImg.sprite = sprite
            end)
            local activeImg = root:Find("Active/Image"):GetComponent("Image")
            LangUtil.GetSpriteLang(id+1,function(sprite)
                activeImg.sprite = sprite
            end)
        end
    end
    for i=0,screenCtrl.childCount - 1 do
        local child = screenCtrl:GetChild(i)
        local txt = child:Find("Mask/Text")
        if i == 0 then
            LangUtil.BindText(txt).text = LangUtil.GetSysLang(157)
        else
            LangUtil.BindText(txt).text = LangUtil.GetSysLang(243 + i-1)
        end
       -- UIUtil.ScrollText(txt:GetComponent("Text"))
    end
    --LangUtil.BindText(btnCtrl:Find("1/Text")).text = LangUtil.GetSysLang(286)
    --LangUtil.BindText(btnCtrl:Find("1/Active/Text")).text = LangUtil.GetSysLang(286)
    --LangUtil.BindText(btnCtrl:Find("2/Text")).text = LangUtil.GetSysLang(287)
    --LangUtil.BindText(btnCtrl:Find("2/Active/Text")).text = LangUtil.GetSysLang(287)
    LangUtil.BindText(progress:Find("Value"),FontType.All_Number)
    LangUtil.BindText(progress:Find("Text")).text = LangUtil.GetSysLang(275)
    LangUtil.BindText(hold:Find("Value"),FontType.All_Number)
    LangUtil.BindText(hold:Find("Text")).text = LangUtil.GetSysLang(731)
    LangUtil.BindText(self.langRc:GetObject("OnPropertyText")).text =  LangUtil.GetSysLang(1278)


end

local function InitHint(self)
    -- self.EquipHint = Game.Scene:GetComponent("HintComponent").Handbook:GetChild("Equip")
    -- for i =1,#self.btns do
    --     local cardNode = self.EquipHint:GetChild(tostring(i))
    --     cardNode:AddObject(self.btns[i].transform:Find("Hint").gameObject,"EquipHandBookView")
    -- end
end

function this.OnCreate(self)
    base.OnCreate(self);
    local backBtn = self.rc:GetObject("BackButton")
    UIPublic.SetBackButton(
        backBtn,
        UIWindowNames.UIEquipHandBook,
        422
    )

    local btnCtrl = self.rc:GetObject("BtnCtrl").transform
    local screenCtrl = self.rc:GetObject("ScreenCtrl").transform
    self.hint = self.rc:GetObject("Hint")
    self.progressTxt = self.rc:GetObject("Progress").transform:Find("Value"):GetComponent("Text")
    self.holdTxt = self.rc:GetObject("Hold").transform:Find("Value"):GetComponent("Text")
    
    self.vs_list = {}
    self.vs_scroll = VerticalScroll.New()
    self.vs_scroll:SetUpdateCount(8)
    self.vs_scrollView = self.rc:GetObject("ScrollRect"):GetComponent("ScrollRect")

    self.btns = {}
    self.screens = {}

    for i = 0,btnCtrl.childCount -1 do
        local child = btnCtrl:GetChild(i).gameObject
        self.btns[i+1] = child
        UIUtil.AddBtnEvent(child,function()OnKindButton(self,i+1)  end)
    end

    for i = 0,screenCtrl.childCount -1 do
        local child = screenCtrl:GetChild(i).gameObject
        self.screens[i+1] = child
        UIUtil.AddBtnEvent(child,function()OnScreenButton(self,i+1)  end)
    end

    InitHint(self)

    self.vs_scroll:Clear()
    self.vs_scroll:ScrollInit(self.vs_list, self.vs_scrollView, pfbName, function (arg)
        local content = self.vs_scrollView.transform:Find("Viewport/Content")
        InitContent(self,content,arg.go,arg.data)
    end)

    UIUtil.AddBtnEvent(self.rc:GetObject("OnProperty"),function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIHandBookProperty)
    end)
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh()
end

function this.OnRefresh(self)
    self.objectList = {}
    self.screenMode = 0
    self.recordComponent = Game.Scene.Player:GetComponent("RecordComponent")

    local holdCount, maxCount = self.recordComponent:GetRecordCount(RecordType.Equip)
    
    self.holdTxt.text = holdCount.."/"..maxCount
    self.progressTxt.text = math.modf(holdCount/maxCount*100).."%"
    
    
    self.zEquipIdList = self.model.equipIdList
    self.zEquipListId = 1
    OnScreenButton(self,1)
    OnKindButton(self,1)
end
 
function this.OnAddListener(self)
    base.OnAddListener(self);
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
    self.objectList = {}
end

function this.OnDestroy(self)
    base.OnDestroy(self);
    self.vs_scroll:Dispose()
end

return this;