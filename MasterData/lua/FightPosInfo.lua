--战斗站位信息父物体
local data=nil;
local items={};
local gridPadding=2;
local gridSize={22,22};
local localPos={
    {35.5,24},{35.5,0},{35.5,-24},
    {12,24},{12,0},{12,-24},
    {-12,24},{-12,0},{-12,-24},
    {-35.5,24},{-35.5,0},{-35.5,-24},
}
function Init(list) --list:Character[]
    data=list;
    CreateItems();
end

--设置焦点：设置哪个子物体的point显示
function SetFoucs(cid)
    for k,v in ipairs(items) do
        v.SetPoint(v.data.GetID()==cid)
    end
end

--创建子物体
function CreateItems()
    if data then
        for k,v in ipairs(data) do
            ResUtil:CreateUIGOAsync("FightRoleInfo/FightPosInfoItem",childNode,function(go)
                local item=ComUtil.GetLuaTable(go);
                item.Refresh(v);
                local row,col=v.GetCoord();
                local gridType=FormationUtil.GetFormationType(v.GetCfg().grids);
                item.SetImg(GetImgType(row,col,gridType));
                local size=CountItemSize(gridType);
                item.SetSize(size[1],size[2]);
                local pos=CountItemPos(v.GetGrids(),v.IsEnemy());
                CSAPI.SetAnchor(go,pos[1],pos[2]);
                table.insert(items,item);
            end);
        end
    end
end


function GetImgType(row,col,gridType)
    local type=1;
    local angle={0,0,0};
    local index=(row-1)*3+col;
    if (gridType==FormationType.VThree or gridType==FormationType.Summon)then
        if index==1 or index==10 then
            type=3;
            angle={0,index==1 and 180 or 0,0};
        else
            type=2;
        end
    elseif gridType==FormationType.HThree then
        if index==1 or index==3 or index==4 or index==6 then
            type=1;
            local arr={[1]={0,180,0},[3]={0,0,180},[4]={0,0,0},[6]={180,0,0}};
            angle=arr[index]
        else
            type=2
        end
    elseif gridType==FormationType.Single and index~=1 and index~=3 and index~=10 and index~=12 then
        type=2;
    elseif gridType==FormationType.HDouble and (index==4 or index==5 or index==7 or index==8) then
        type=2;
    elseif gridType==FormationType.VDouble and (index==2 or index==4 or index==5 or index==6) then
        type=2;
    elseif gridType==FormationType.Nine then
        type=3
    elseif gridType==FormationType.VDThree then
        if index<3 or index>6 then
            type=3
        else
            type=2
        end
        if index<3 then
            angle={0,180,0};
        else
            angle={0,0,0};
        end
    else
        type=1;
        if index<6 and col==1 then
            angle={0,180,0};
        elseif index<6 and col>1 then
            angle={0,0,180}
        elseif index>6 and col>1 then
            angle={0,180,180};
        end
    end
    return type,angle;
end

function CountItemSize(type)
    local size={0,0};
	if type == nil or type == FormationType.Single then
		size[1]=gridSize[1];
		size[2]=gridSize[2];
	elseif type == FormationType.HDouble then
		size[1]=gridSize[1]*2+gridPadding;
		size[2]=gridSize[2]
	elseif type == FormationType.VDouble then
		size[1]=gridSize[1]
		size[2]=gridSize[2]*2+gridPadding;
	elseif type == FormationType.Square then
		size[1]=gridSize[1]*2+gridPadding;
		size[2]=gridSize[2]*2+gridPadding;
	elseif type == FormationType.HThree then
		size[1]=gridSize[1]*3+gridPadding*2
		size[2]=gridSize[2];
	elseif type==FormationType.VThree or type==FormationType.Summon then
		size[1]=gridSize[1];
		size[2]=gridSize[2]*3+gridPadding*2
    elseif type==FormationType.Nine then
        size[1]=gridSize[1]*3+gridPadding*2;
		size[2]=gridSize[2]*3+gridPadding*2
    elseif type==FormationType.VDThree then
        size[1]=gridSize[1]*2+gridPadding;
		size[2]=gridSize[2]*3+gridPadding*2
	end
    return size;
end

--计算子物体位置
function CountItemPos(grids,isEnemy)
    local pos={0,0}
    if grids==nil then
        return pos;
    end
    if #grids==1 then
        local index=isEnemy and (4-grids[1][1])*3+grids[1][2] or (grids[1][1]-1)*3+grids[1][2];
        pos=localPos[index];
    else
        --计算两个值的中心点
        local count={0,0}
        local index=1;
        for k,v in ipairs(grids) do
            index=isEnemy and (4-v[1])*3+v[2] or (v[1]-1)*3+v[2];
            count[1]=count[1]+localPos[index][1];
            count[2]=count[2]+localPos[index][2];
        end
        pos[1]=count[1]/#grids;
        pos[2]=count[2]/#grids;
    end
    return pos;
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
childNode=nil;
view=nil;
end
----#End#----