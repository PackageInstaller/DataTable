
function Awake()
    coms = ComUtil.GetComsInChildren(gameObject,"ActionSRSize");
    if(coms)then
        for i=0,coms.Length-1 do
            local com = coms[i];
            srScaleComs = srScaleComs or {};
            table.insert(srScaleComs,com);
        end
    end
end

function Set(character)
    if(character)then
        local x,y,z = character.GetPos();
        CSAPI.SetPos(gameObject,x,y,z);

        local placeHolderInfo = character.GetPlaceHolderInfo();
        local targetScaleX = 1;
        local targetScaleY = 1;

        local xMin,xMax,yMin,yMax;
        if(placeHolderInfo)then
            for _,info in ipairs(placeHolderInfo)do
                if(xMin)then
                    xMin = (xMin > info[1]) and info[1] or xMin;
                    xMax = (xMax < info[1]) and info[1] or xMax;
                    yMin = (yMin > info[2]) and info[2] or yMin;
                    yMax = (yMax < info[2]) and info[2] or yMax;
                else
                    xMin = info[1];
                    xMax = info[1];
                    yMin = info[2];
                    yMax = info[2];
                end
            end
            targetScaleX = math.max((xMax - xMin + 1),1);
            targetScaleY = math.max((yMax - yMin + 1),1);

        end

        --CSAPI.SetScale(goScale,targetScale,targetScale,targetScale);
        SetScale(targetScaleX,targetScaleY);

        CSAPI.SetGOActive(goScale,false);
        CSAPI.SetGOActive(goScale,true);
    else
        CSAPI.RemoveGO(gameObject);
    end
end

function SetScale(x,y)
    CSAPI.SetScale(ScaleNode,x,y,1);

    if(srScaleComs)then
        for _,com in ipairs(srScaleComs)do
            com:SetScale(x,y);
        end
    end
end

function SetGrid(gridData)
    CSAPI.SetPos(gameObject,gridData.x,0,gridData.y);
    SetScale(1,1);
end

function OnRecycle()
    SetScale(1,1);
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
goScale=nil;
goAction=nil;
end
----#End#----