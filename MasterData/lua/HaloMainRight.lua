-- 光环强化、装配界面
local tabs = {};
local curTabIdx = 1;
local tabDatas = {100015,100017}
local eventMgr = nil;
local childs = { "InitStrength","InitAttrNode"}

local strengthView=nil;
local equipView=nil;
local attrView=nil;
local data = nil;

function Awake()
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
end

-- _d:cardData
function SetData(_d)
    data = _d;
    Refresh();
end

function Refresh()
    InitTabs();
    for k, v in ipairs(childs) do
        if k == curTabIdx then
            this[v](true);
        else
            this[v](false);
        end
    end
end

function InitTabs()
    ItemUtil.AddItems("Halo/HaloTab", tabs, tabDatas, tabNode, OnClickTab, 1, {
        curIdx = curTabIdx,
        maxNum = #tabDatas
    })
end

function OnClickTab(tab)
    if tab.GetIndex() ~= curTabIdx then
        curTabIdx = tab.GetIndex();
        Refresh();
    end
end

function InitStrength(isShow)
    if isShow then
        if strengthView then
            strengthView.Show(data);
        else
            ResUtil:CreateUIGOAsync("Halo/HaloStrengthMain",strengthNode,function(go)
                strengthView=ComUtil.GetLuaTable(go)
                strengthView.Show(data);
            end);
        end
    elseif isShow~=true and strengthView~=nil then
        strengthView.Hide();
    end
end

function InitAttrNode(isShow)
    if isShow then
        if attrView then
            attrView.Show(data);
        else
            ResUtil:CreateUIGOAsync("Halo/HaloAttrInfo",attrNode,function(go)
                attrView=ComUtil.GetLuaTable(go)
                attrView.Show(data);
            end);
        end
    elseif isShow~=true and attrView~=nil then
        attrView.Hide();
    end
end