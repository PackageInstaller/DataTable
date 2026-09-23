--战术选择面板
local currID=nil;--当前选中的ID
local oldID=nil;
local closeFunc=nil;--关闭事件
local layout=nil;
local teamData=nil;
local selectElement=nil;--记录第一次选中的物体的父节点
function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/Team/TacticsItem",LayoutCallBack,true)
end

function OnOpen()
    -- UIUtil:ShowAction(rootNode,function()
    --     if data then
    --         teamData=data.teamData;
    --         closeFunc=data.closeFunc;
    --         InitView();
    --     end
    -- end, UIUtil.active2);
    CSAPI.ApplyAction(gameObject, "Fade_In_200");
    if data then
        teamData=data.teamData;
        closeFunc=data.closeFunc;
        InitView();
    end
end

function Close()
    local tacticData=TacticsMgr:GetDataByID(g_DefaultAbilityId);
    if currID==nil and tacticData and tacticData:IsUnLock() then --有已解锁战术但未选择时
        Tips.ShowTips(LanguageMgr:GetTips(26104));
        currID=g_DefaultAbilityId;
    end
    if closeFunc and currID~=oldID then
        closeFunc(currID);
        closeFunc=nil;
    end
    CSAPI.ApplyAction(gameObject, "Fade_Out_100",function()
        view:Close();
    end)
    -- CSAPI.SetGOActive(gameObject,false);
    -- UIUtil:HideAction(rootNode,function()
    --     view:Close();
    -- end, UIUtil.active4);
end

--初始化面板
function InitView()
    --遍历玩家技能组表，显示所有技能信息
    if teamData then
        currID=teamData:GetSkillGroupID();
        oldID=teamData:GetSkillGroupID();
    end
    currData=TacticsMgr:GetData();
    --排序
    SortTacticsData(currData);
    layout:IEShowList(#currData);
end

function OnClickCancel()
    currID=oldID
    Close();
end

--关闭面板
function OnClickBack()
    Close()
end

--使用的技能组变更
function OnUseChange(item)
    local currItem=layout:GetItemLua(currIndex);
    if item.isLock==false then
        if currIndex==item.GetIndex() then
            item.SetBtnState(false);
            currID=nil;
            currIndex=nil;
            return
        else
            currID=item.data:GetCfgID();
            item.SetBtnState(true);
            currIndex=item.GetIndex();
        end
    else
        return
    end
    if currItem then
        currItem.SetBtnState(false);
    end
end

--排序 使用中>已开启>等级高>ID
function SortTacticsData(data)
    if data then
        table.sort(data,function(a,b)
            if currID and (currID==a:GetCfgID() or currID==b:GetCfgID()) then
                return currID==a:GetCfgID();
            else
                if a:IsUnLock() and b:IsUnLock() then
                    if a:GetLv()==b:GetLv() then
                        return a:GetCfgID()>b:GetCfgID();
                    else
                        return a:GetLv()>b:GetLv();
                    end
                else
                    return a:IsUnLock()==true;
                end
            end
        end);
    end
end

function LayoutCallBack(index)
	local _data = currData[index]
    local isSelect=false;
    local isLock=true;
    if currID==_data:GetCfgID() then
        isSelect=true;
        currIndex=index;
    end
    local item=layout:GetItemLua(index);
	item.Refresh(_data,{isSelect=isSelect});
    item.SetClickCB(OnUseChange);
    item.SetIndex(index);
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
btn_back=nil;
txt_back=nil;
txt_backTips=nil;
btn_ok=nil;
txt_ok=nil;
txt_okTips=nil;
vsv=nil;
view=nil;
end
----#End#----