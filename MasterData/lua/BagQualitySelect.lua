local btns={}
local bs={}
local qualitys=nil;
function OnOpen()
    btns={g1,g2,g3,g4,g5};
    bs={b1,b2,b3,b4,b5}
    for k,v in ipairs(btns) do
        SetBtn(k,false);
    end
    if data then
        qualitys=data;
        for k,v in ipairs(qualitys) do
            local go=btns[v];
            SetBtn(v,true);
        end
    end
end

function SetBtn(k,isSelect)
    CSAPI.SetGOActive(bs[k],isSelect);
    local color=isSelect and {255,196,38,255} or {255,255,255,255}
    CSAPI.SetTextColor(btns[k],color[1],color[2],color[3],color[4],true);
end

function OnClickQuality(go)
    for k,v in ipairs(btns) do
        local isSelect=go==v;
        local key=nil;
        if qualitys then
            for i,val in ipairs(qualitys) do
                if k==val and go~=v then
                    isSelect=true;
                    break;
                elseif k==val and go==v then
                    isSelect=false;
                    key=i;
                    break;
                end
            end
        end
        SetBtn(k,isSelect);
        if go==v then
            qualitys=qualitys or {};
            if isSelect then
                table.insert(qualitys,k);
            else
                table.remove(qualitys,key);
            end
        end
    end
end

function OnClickSure()
    EventMgr.Dispatch(EventType.Bag_SellQuality_Change,qualitys);
    view:Close();
end

function OnClickMask()
    view:Close();
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
rootNode=nil;
g1=nil;
b1=nil;
g2=nil;
b2=nil;
g3=nil;
b3=nil;
g4=nil;
b4=nil;
g5=nil;
b5=nil;
Text=nil;
Text=nil;
view=nil;
end
----#End#----