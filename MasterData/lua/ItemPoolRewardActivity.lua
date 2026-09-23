--道具池奖励描述界面
local items={};
local leftPanel=nil;
local leftInfos={};
curIndex1, curIndex2 = 1, 1;
function Awake()
    Top=UIUtil:AddTop2("ItemPoolRewardActivity",gameObject, OnClickReturn,OnClickHomeFunc)
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{60115, "ItemPool/img_03_02"}}
    leftPanel.Init(this, leftDatas)
end

--data:ItemPoolInfo
function OnOpen()
    leftPanel.Anim()
    if data then
        local descIds=data:GetDescInfo();
        CSAPI.SetText(txtTitle,LanguageMgr:GetByID(descIds[1]));
        CSAPI.SetText(txtDesc,LanguageMgr:GetByID(descIds[2]));
        --创建子物体
        -- local list=data:GetFullInfos();
        local list2=data:GetRewardInfos();
        ItemUtil.AddItems("ItemPool/ItemPoolRewardItem", items, list2, Content,nil,1,false);
    end
end

function OnClickClose()
    -- view:Close();
end

function OnClickReturn()
    view:Close();
end