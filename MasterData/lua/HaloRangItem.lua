local cfg=nil;
local angleKey={["1-1"]=1,["1-3"]=1,["3-1"]=1,["3-3"]=1}
function Refresh(coordPos,card)
    if coordPos then
        --显示各个
        local pos=card and FormationUtil.GetPlaceHolderInfo(card:GetGrids()) or nil;
        local infos=GetHaloRange(coordPos,pos)
        SetGridsStyle(infos);
    end
end

function SetGridsStyle(tab)
    if tab then
        for x=1,3 do
            for y=1,3 do
                local key=x.."-"..y;
                local v=tab[key]
                if v and this[v.key] then
                    if angleKey[v.key]~=nil then
                        ResUtil.HaloRange:Load(this[v.key],"img9_03_04",false);
                    else
                        ResUtil.HaloRange:Load(this[v.key],"img9_03_05",false);
                    end
                    local color=v.type==3 and "ffc146" or "ffffff";
                    CSAPI.SetImgColorByCode(this[v.key],color);
                else
                    if angleKey[key]~=nil then
                        ResUtil.HaloRange:Load(this[key],"img9_03_01",false);
                    elseif x==2 and y==2 then
                        ResUtil.HaloRange:Load(this[key],"img9_03_03",false);
                    else
                        ResUtil.HaloRange:Load(this[key],"img9_03_02",false);
                    end
                    CSAPI.SetImgColorByCode(this[key],"ffffff");
                end
            end
        end
    end
    
end

--返回当前光环的占位信息
function GetHaloRange(coordinate,posCoord)
	local posInfo={};
    if coordinate then
        for i=2,#coordinate do
            --取得受光环影响的相对位置
            local row=coordinate[i][1];
            local col=coordinate[i][2];
            local key=row.."-"..col;
            if row>0 and col>0 and row<=3 and col<=3 then
                posInfo[key]={key=key,type=3};
            end
        end
        local node=coordinate[1];
        if posCoord then
            for k, v in ipairs(posCoord) do
                local r = v[1] + node[1] - 1;
                local c = v[2] + node[2] - 1;
                posInfo[r.."-"..c]={key=r.."-"..c,type=2};
            end
        else
            posInfo[node[1].."-"..node[2]]={key=node[1].."-"..node[2],type=2};
        end
    end
	return posInfo;
end