local grid=nil;
local delayTime = 3; -- 显示时间
local timer = 0; -- 计时器
local canCount = false; -- 是否开始计时
local animator=nil;
function Awake()
    animator=ComUtil.GetCom(node,"Animator");
end

function Refresh(goodsInfo)
    if goodsInfo then
        local str=StringUtil:GetShortNumStr(goodsInfo:GetCount());
        if grid then
            grid.Refresh(goodsInfo);
            grid.SetCount()
            CSAPI.SetGOActive(countObj,true)
            CSAPI.SetText(txt_count,str)
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",gridNode,function(go)
                grid=ComUtil.GetLuaTable(go)
                grid.Refresh(goodsInfo);
                grid.SetCount()
                CSAPI.SetGOActive(countObj,true)
                CSAPI.SetText(txt_count,str)
            end)
        end
        CSAPI.SetText(txtTips,LanguageMgr:GetTips(79002,str));
    end
    canCount=true;
end

function ResetTime()
    timer = 0
end

function Update()
    if canCount then
        timer = timer + Time.fixedDeltaTime;
        if timer >= delayTime then
            Close();
        end
    end
end

function Close()
    if not IsNil(animator) then
        animator:Play("RevExpTips_entry",-1,0);
    end
    timer = 0;
    canCount = false;
    FuncUtil:Call(function ()
        if not IsNil(gameObject) then
            CSAPI.SetGOActive(gameObject, false);
            CSAPI.RemoveGO(gameObject,0);
        end
    end,nil,120)
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    txt_count = nil;
    countObj = nil;
    gridNode = nil;
    txtTips = nil;
    view = nil;
    canCount=false;
    animator=nil;
end