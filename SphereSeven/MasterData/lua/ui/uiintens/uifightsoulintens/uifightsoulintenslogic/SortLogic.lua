---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/8/8 15:31
---

local SortLogic = {};
local this = SortLogic;

local function SortFightSoulObject(self)
    for k,v in table.pairsByKeys(self.sort_Tab) do
        v.Obj.transform:SetAsLastSibling();
    end
end


local function ScreenWithStar(self)
    for k,v in pairs(self.toggle_Tab[1]) do
        if v.isOn == false then
            local tab = table.choose(self.sort_Tab,function(a,b)
                local fightSoul = self.fightSouls[b.Id]
                return fightSoul.Star == k;
            end)
            for _,g in pairs(tab) do
                g.Obj:SetActive(v.isOn);
            end
        end
    end
end

local function ScreenWithKind(self)
    for k,v in table.pairsByKeys(self.toggle_Tab[2]) do
        if k == 6 then break end;
        if v.isOn == false then
            local tab = table.choose(self.sort_Tab,function(a,b)
                local zFightSoul = Z_FightSoul[self.fightSouls[b.Id].TemplateId]
                return zFightSoul.Rare == k;
            end)
            for _,g in pairs(tab) do
                g.Obj:SetActive(v.isOn);
            end
        end
    end
    
    if self.toggle_Tab[2][6].isOn == false then --已装备
        local tab = table.choose(self.sort_Tab,function(a,b)
            local fight_soul = self.fightSouls[b.Id]
            return UIPublic.GetFightSoulHolder(fight_soul) ~= nil
        end)
        for _,g in pairs(tab) do g.Obj:SetActive(false); end
    elseif self.toggle_Tab[2][7].isOn == false then --未装备
        local tab = table.choose(self.sort_Tab,function(a,b)
            local fight_soul = self.fightSouls[b.Id]
            return UIPublic.GetFightSoulHolder(fight_soul) == nil
        end)
        for _,g in pairs(tab) do g.Obj:SetActive(false); end
    end
end


local function SortWithRare(self)
    table.sort(self.sort_Tab,function(a,b)
        local Rare1 = Z_FightSoul[self.fightSouls[a.Id].TemplateId].Rare
        local Rare2 = Z_FightSoul[self.fightSouls[b.Id].TemplateId].Rare
        return Rare1 > Rare2;
    end)
end

local function SortWithStar(self)
    table.sort(self.sort_Tab,function(a,b)
        local Star1 = self.fightSouls[a.Id].Star
        local Star2 = self.fightSouls[b.Id].Star
        return Star1 > Star2;
    end)
end

local function SortWithDefault(self)
    local tmpTab = {};
    local count = 0;
    for k,v in table.pairsByKeys(self.fightSouls) do
        count = count + 1;
        local t = {};
        t.index = count
        tmpTab[k] = t;
    end

    table.sort(self.sort_Tab,function(a,b)
        return tmpTab[a.Id].index < tmpTab[b.Id].index
    end)
end

function this.OnToggleValueChg(self,toggle)
    print("--点击toggle")
    if toggle ~= nil then toggle.isOn = not toggle.isOn; end
    self.sort_Tab = {};
    for k,v in pairs(self.object_tab) do
        local t = {};
        t.Id = k;
        t.Obj = v;
        table.insert(self.sort_Tab,t);

        if self.panel_id == 4   then
            if table.first(self.resolve_data.fight_list,function(a) return a.Id == k end) == nil then
                v:SetActive(true)
            end
        else
            v:SetActive(true)
        end
    end

    ScreenWithStar(self)
    ScreenWithKind(self)
end

function this.OnClickSortBtn(self,id)
    for k,v in pairs(self.sort_BtnTab) do
        v:GetComponent("Image").color = (k == id and {Color.New(1,1,0)} or {Color.New(1,1,1)})[1]
    end

    self.sort_Tab = {};
    for k,v in pairs(self.object_tab) do
        local t = {};
        t.Id = k;
        t.Obj = v;
        table.insert(self.sort_Tab,t);
    end

    self.sort_BtnFuncTab[id](self);
    SortFightSoulObject(self);
end


function this.OnRefresh(self)
    for k,v in pairs(self.toggle_Tab) do
        for _,a in pairs(v) do
            a.isOn = true;
        end
    end

    for k,v in pairs(self.sort_BtnTab) do
        v:GetComponent("Image").color = Color.New(1,1,1);
    end
end

function this.OnCreate(self)
    self.sort_Panel = self.rc:GetObject("SortPanel");
    self.sort_BtnCtrl = self.sort_Panel.transform:Find("UseArea/BtnCtrl");
    self.sort_ToggleCtrl = self.sort_Panel.transform:Find("UseArea/ToggleArea");
    self.sort_Bg = self.sort_Panel.transform:Find("Bg").gameObject;
    self.sort_BtnTab = {};
    self.toggle_Tab = {};
    self.sort_BtnFuncTab = {SortWithRare,SortWithStar,SortWithDefault};
    for i = 0,self.sort_ToggleCtrl.childCount - 1 do
        local toggleParent = self.sort_ToggleCtrl:GetChild(i);
        self.toggle_Tab[i+1] = {};
        for j = 1,toggleParent.childCount -1 do
            local toggle = toggleParent:GetChild(j):GetComponent("Toggle");
            self.toggle_Tab[i+1][j] = toggle;
            EventTriggerListener.Get(toggle.transform:Find("Background").gameObject).onLuaClick = function(v) this.OnToggleValueChg(self,toggle) end
        end
    end

    for i = 0,self.sort_BtnCtrl.childCount - 1 do
        local btn = self.sort_BtnCtrl:GetChild(i).gameObject;
        self.sort_BtnTab[i + 1] = btn
        ButtonListener.Get(btn).OnClickHandler = function(v) this.OnClickSortBtn(self,i+1) end
        UIUtil.AddBtnSound(btn);
    end

    EventTriggerListener.Get(self.sort_Bg).onLuaClick = function(v) self.sort_Panel:SetActive(false)  end

end

function this.OnDestroy(self)
    self.vs_scroll:Dispose()
end

return this;