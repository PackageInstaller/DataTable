--绑定阶段奖励预览界面
local layout=nil;
local curDatas=nil
function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Collaboration/CollaborationPreviewItem",LayoutCallBack,true);
end

function OnOpen()
    Refresh();
end

function Refresh()
    curDatas={};
    local currActivity=CollaborationMgr:GetCurrInfo();
    if currActivity==nil then
        do return end
    end
    local cfg=currActivity:GetStageCfg();
    if cfg==nil then
        LogError("CfgRegressionBindStage无法找到对应配置！id="..tostring(currActivity:GetID()));
        do return end;
    end
    for k,v in ipairs(cfg.infos) do
        table.insert(curDatas,v);
    end
    table.sort(curDatas,function(a,b)
        if a.index==b.index then
            return a.nCount<b.nCount
        else
            return a.index<b.index 
        end
    end);
    layout:IEShowList(#curDatas);
end

function LayoutCallBack(index)
    local data=curDatas[index];
    local item=layout:GetItemLua(index);
    if item then
        item.Refresh(data)
    end
end

function OnClickOK()
    if IsNil(gameObject) or IsNil(view) then
        do return end
    end
    view:Close();
end