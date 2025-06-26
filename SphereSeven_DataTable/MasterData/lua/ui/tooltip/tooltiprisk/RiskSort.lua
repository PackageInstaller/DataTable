local this = require 'UI.ToolTip.ToolTipRisk.RiskEnterView'

function this.OnSortCreate(self)
    --self.chaRc =  self.cha_root.transform:GetComponent("ReferenceCollector")
    self.Sort =  self.chaRc:GetObject("Sort")
    self.SortClose_But =  self.chaRc:GetObject("SortClose_But")
    self.ScreenType =  self.chaRc:GetObject("ScreenType").transform
    self.RecordOrder =  self.chaRc:GetObject("RecordOrder").transform
    self.SortConfirm_But =  self.chaRc:GetObject("SortConfirm_But")
    self.SortCancel_But =  self.chaRc:GetObject("SortCancel_But")
    self.Rare =  self.chaRc:GetObject("Rare")
    self.CardType =  self.chaRc:GetObject("CardType")
    self.MainProp =  self.chaRc:GetObject("MainProp")
    self.SubProp =  self.chaRc:GetObject("SubProp")
    self.AtkType =  self.chaRc:GetObject("AtkType")
    self.toggle_Tab = {}
    self.sort_BtnTab = {}
    for i = 1,self.ScreenType.childCount - 1 do
        local toggleParent = self.ScreenType:GetChild(i).transform
        self.toggle_Tab[i] = {}
        for j = 0,toggleParent.childCount -1 do
            local toggle = toggleParent:GetChild(j).gameObject
            self.toggle_Tab[i][j+1] = toggle;
            UIUtil.AddBtnEvent(toggle,function(go)
                self:OnClickToggle(i,j+1)
            end)
        end
    end

    for i = 0,self.RecordOrder.childCount - 1 do
        local btn = self.RecordOrder:GetChild(i).gameObject;
        self.sort_BtnTab[i + 1] = btn
        UIUtil.AddBtnEvent(btn,function(v) self:OnClickSortBtn(i+1) end)
    end
    UIUtil.AddBtnEvent(self.SortClose_But,function(v) self:OnCloseSort() end)
    UIUtil.AddBtnEvent(self.SortCancel_But,function(v) self:OnCloseSort() end)
    UIUtil.AddBtnEvent(self.SortConfirm_But,function(v)
        self.screenTypes = self.cloneScreenTypes
        self.recordOrder = self.cloneRecordOrder
        self:InitCardListData()
        self:OnCloseSort()
    end)
end

function this.OnSortLang(self)
    LangUtil.BindText(self.chaRc:GetObject("SortTitle")).text = LangUtil.GetSysLang(187)
    LangUtil.BindText(self.chaRc:GetObject("ScreenTitleText")).text = LangUtil.GetSysLang(163)
    LangUtil.BindText(self.chaRc:GetObject("OrderTitleText")).text = LangUtil.GetSysLang(164)
    LangUtil.BindText(self.SortConfirm_But.transform:Find("Text")).text = LangUtil.GetSysLang(145)
    LangUtil.BindText(self.SortCancel_But.transform:Find("Text")).text = LangUtil.GetSysLang(146)

    for i = 0, 2 do
        LangUtil.BindText(self.RecordOrder.transform:GetChild(i):Find("default/Text")).text = LangUtil.GetSysLang(166+i)
        LangUtil.BindText(self.RecordOrder.transform:GetChild(i):Find("select/Text")).text = LangUtil.GetSysLang(166+i)
        --self.RecordOrder.transform:GetChild(i):Find("select").gameObject:SetActive(false)
    end
    local rare = {"R","SR","SSR","UR"}

    for i = 0, 3 do
        LangUtil.BindText(self.Rare.transform:GetChild(i):Find("default/Text")).text = rare[i+1]
        LangUtil.BindText(self.Rare.transform:GetChild(i):Find("select/Text")).text = rare[i+1]
        --self.Rare.transform:GetChild(i):Find("select").gameObject:SetActive(false)
    end

    for i = 0, 4 do
        LangUtil.BindText( self.CardType.transform:GetChild(i):Find("default/Text")).text = LangUtil.GetSysLang(158+i)
        LangUtil.BindText( self.CardType.transform:GetChild(i):Find("select/Text")).text = LangUtil.GetSysLang(158+i)
        self.CardType.transform:GetChild(i):Find("select").gameObject:SetActive(false)
    end

    for i = 0, 1 do
        LangUtil.BindText( self.MainProp.transform:GetChild(i):Find("default/Text")).text = LangUtil.GetSysLang(175+i)
        LangUtil.BindText( self.MainProp.transform:GetChild(i):Find("select/Text")).text = LangUtil.GetSysLang(175+i)
        --self.MainProp.transform:GetChild(i):Find("select").gameObject:SetActive(false)
        
    end

    for i = 0, 7 do
        LangUtil.BindText( self.SubProp.transform:GetChild(i):Find("default/Text")).text = LangUtil.GetSysLang(177+i)
        LangUtil.BindText( self.SubProp.transform:GetChild(i):Find("select/Text")).text = LangUtil.GetSysLang(177+i)
        --self.SubProp.transform:GetChild(i):Find("select").gameObject:SetActive(false)
    end

    for i = 0, 1 do
        LangUtil.BindText( self.AtkType.transform:GetChild(i):Find("default/Text")).text = LangUtil.GetSysLang(185+i)
        LangUtil.BindText( self.AtkType.transform:GetChild(i):Find("select/Text")).text = LangUtil.GetSysLang(185+i)
        --self.AtkType.transform:GetChild(i):Find("select").gameObject:SetActive(false)
    end
end



function this.OnOpenSort(self)
    self.cloneScreenTypes = table.clone(self.screenTypes)
    self.cloneRecordOrder = table.clone(self.recordOrder)
    self:InitButtons()
    self.Sort.gameObject:SetActive(true)
end



local function SetActive(btn,bool)
    local transform = btn.transform
    transform:GetChild(1).gameObject:SetActive(bool)
end

local function IsActive(btn)
    local transform = btn.transform
    return transform:GetChild(1).gameObject.activeInHierarchy
end
 
function this.InitButtons(self)
    self:OnClickSortBtn(self.cloneRecordOrder.kind)
    for k,v in table.pairsByKeys(self.toggle_Tab[1]) do
        SetActive(v,k == self.screenTypes.rare )
    end

    for k,v in table.pairsByKeys(self.toggle_Tab[2]) do
        SetActive(v,k == self.screenTypes.abiliType )
    end

    for k,v in table.pairsByKeys(self.toggle_Tab[3]) do
        SetActive(v,k == self.screenTypes.mainProp )
    end

    for k,v in table.pairsByKeys(self.toggle_Tab[4]) do
        SetActive(v,k == self.screenTypes.subProp )
    end

    for k,v in table.pairsByKeys(self.toggle_Tab[5]) do
        SetActive(v,k == self.screenTypes.atkType )
    end
end

function this.OnClickSortBtn(self,id)
    self.cloneRecordOrder.kind = id
    for k,v in pairs(self.sort_BtnTab) do
        SetActive(v,k == id)
    end
end

function this.OnClickToggle(self,key,id)
    if IsActive(self.toggle_Tab[key][id])  then
        if key == 1 then
            self.cloneScreenTypes.rare = 0
        elseif key == 2 then
            self.cloneScreenTypes.abiliType = 0
        elseif key == 3 then
            self.cloneScreenTypes.mainProp = 0
        elseif key == 4 then
            self.cloneScreenTypes.subProp = 0
        elseif key == 5 then
            self.cloneScreenTypes.atkType = 0
        end
        SetActive(self.toggle_Tab[key][id],false)
        return
    end

    for k,v in pairs(self.toggle_Tab[key]) do
        if key == 1 then
            self.cloneScreenTypes.rare = id
        elseif key == 2 then
            self.cloneScreenTypes.abiliType = id
        elseif key == 3 then
            self.cloneScreenTypes.mainProp = id
        elseif key == 4 then
            self.cloneScreenTypes.subProp = id
        elseif key == 5 then
            self.cloneScreenTypes.atkType = id
        end

        SetActive(v,id == k)
    end
end

function this.OnCloseSort(self)
    self.Sort.gameObject:SetActive(false)
end

return this