--拼图碎片
local elseData=nil;
local fragment=nil;
local cb=nil;
local clicker=nil;
function Awake()
    clicker=ComUtil.GetCom(gameObject,"Image");
end

function Refresh(_fragment,_elseData)
    fragment=_fragment;
    elseData=_elseData;
    if fragment then
        local pos=fragment:GetPos()
        CSAPI.LoadImg(bg,string.format("UIs/PuzzleActivity/%s.png",fragment:GetImg()),true,nil,true)
        if elseData and elseData.type==ePuzzleType.Type2 then
            CSAPI.SetText(txtNum,LanguageMgr:GetByID(74023,fragment:GetIdx()));
        else
            CSAPI.SetText(txtNum,fragment:GetIdx());
        end
        if pos then
            CSAPI.SetAnchor(bg,pos[1],pos[2]);
            if pos[3] then
                local x2,y2=1,1
                if pos[3]==1 or pos[3]==3 then
                    x2=-1
                end
                if pos[3]==2 or pos[3]==3 then
                    y2=-1
                end
                CSAPI.SetScale(bg,x2,y2,1);
            else
                CSAPI.SetScale(bg,1,1,1);
            end
        else
            CSAPI.SetScale(bg,1,1,1);
        end
        local isFirst=false;
        if elseData and elseData.ls then
            for k, v in ipairs(elseData.ls) do
                if v==fragment:GetIdx() then
                    isFirst=true;
                    break
                end
            end
        end
        if isFirst then
            CSAPI.SetGOActive(twb,fragment:IsRevice());
        else
            CSAPI.SetGOAlpha(bg,fragment:IsRevice() and 0 or 1);
        end
        clicker.raycastTarget=fragment:IsRevice()~=true;
        -- CSAPI.SetGOActive(bg,fragment:IsRevice()~=true);
    end
end

function OnClickItem()
    if cb~=nil then
        cb(fragment);
    end
end

function SetClickCB(_cb)
    cb=_cb;
end