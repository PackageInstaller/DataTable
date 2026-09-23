local data=nil;
local grids={};

function Refresh(_data,_total)
    data=_data
    if data then
        if _total then
            local num=data.proba/_total*100;
            local dotNum=decimal_places(num);
            if dotNum>2 and num%1~=0 then
                local str=string.format("%.2f",num);
                if str:sub(-1) == "0" then
                    str = str:sub(1, -2) -- 去掉最后一位
                end
                CSAPI.SetText(txtPercent,str.."%");
            elseif num%1>0 then
                CSAPI.SetText(txtPercent,num.."%");
            else
                CSAPI.SetText(txtPercent,math.floor(num).."%");
            end
        else
            CSAPI.SetText(txtPercent,"");
        end
        local p=string.format("UIs/LuckyGacha/%s.png",ItemPoolGoodsGradeImg[data.grade]);
        CSAPI.LoadImg(title,p,true,nil,true);
        if data.list and #data.list>0 then
            local lID=data.list[1]:GetLanguageID();
            if lID then
                CSAPI.SetText(txtDesc,LanguageMgr:GetByID(lID));
            else
                CSAPI.SetText(txtDesc,"");
            end
        end
    end
    ItemUtil.AddItems("LuckyGacha/LuckyGachaRewardGrid", grids, data and data.list or {}, node)
end

function decimal_places(n)
    if type(n) ~= "number" then return 0 end
    local s = tostring(n)
    local _, dot_pos = s:find("%.")
    if dot_pos then
        return #s - dot_pos
    else
        return 0
    end
end

