--道具池预览界面
local layout=nil;
local curDatas=nil;
function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/ItemPool/ItemPoolRewardBigGrid",LayoutCallBack,true,1)
end

function OnOpen()
    if data then
        CSAPI.SetText(txtDesc,LanguageMgr:GetByID(60106,data:GetRound()));
        curDatas=data:GetInfos(data:GetRound());
        layout:IEShowList(#curDatas)
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local grid=layout:GetItemLua(index);
    grid.Refresh(_data,true);
end

function OnClickOpen()
    view:Close();
end