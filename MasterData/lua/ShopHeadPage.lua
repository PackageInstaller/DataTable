local data=nil;
local tabs={};
local scroll=nil;
local totalWidth=1478; --默认宽度
local maxNum=5;--默认最大数量
local animator=nil;
local eventMgr=nil;
local currID=nil;

function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator");
    scroll=ComUtil.GetCom(sv,"ScrollRect");
end

function OnDisable()
    if scroll then
        scroll.normalizedPosition=UnityEngine.Vector2(0,1);
    end
end

function OnDestroy()
    animator=nil;
    data=nil;
    gameObject=nil;
    tabs={};
    scroll=nil;
end

--_data:ShopPageData _isPos:是否定位到sid的位置
function Refresh(_data,sID,_isPos,_isTween)
    data=_data;
    --获取二级界面
    if data~=nil then
        local size=CSAPI.GetRealRTSize(node1);
        totalWidth=size[0];
        if totalWidth>0 then --计算最大显示数量
            maxNum=math.floor(totalWidth/298)
        end
        local tabList=data:GetTopTabs(true);
        local num=tabList~=nil and  #tabList or 0
        CSAPI.SetGOActive(node1,num>1);
        CSAPI.SetGOActive(node2,num==0);
        if num>1 then
            --加载二级菜单,不超过五个需要计算物体宽度
            local width=CountWidth(num);
            currID=sID==nil and tabList[1].id or sID;
            ItemUtil.AddItems("Shop/ShopHeadTabItem",tabs,tabList,Content,nil,1,{width=width,sID=currID,pageID=data:GetID(),len=num},function()
                scroll.enabled=num>maxNum;
                if _isPos~=true then
                    do return end
                end
                if num>maxNum then --定位位置
                    FuncUtil:Call(function() --不延迟拿不到正确位置
                        local sizeW=CSAPI.GetRealRTSize(Content)[0]
                        local posW=0;
                        local index=1;
                        for i, v in ipairs(tabs) do
                            if v.cfg.id==currID then
                                posW=i==1 and 0 or CSAPI.GetAnchor(v.gameObject);
                                index=i;
                                break;
                            end
                        end
                        if index>maxNum then
                            CSAPI.SetAnchor(Content,(posW-totalWidth+width/2)*-1);
                        else
                            scroll.normalizedPosition=UnityEngine.Vector2(0,1);
                        end
                    end,nil,10)
                else
                    scroll.normalizedPosition=UnityEngine.Vector2(0,1);
                end
                isJump=false;
            end);
        else
            CSAPI.SetText(txtTitle,LanguageMgr:GetByID(data:GetNameID()));
        end
    end
end

function CountWidth(num)
    if num > maxNum then
        return 298;
    else
        return math.floor(totalWidth/num);
    end
end