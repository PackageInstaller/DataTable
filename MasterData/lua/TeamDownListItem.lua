--下拉框按钮

--data:icon,desc,isSelect,index,id
function Init(d)
    this.data=d;
    if this.data then
        CSAPI.SetText(txt_desc,this.data.name);
        CSAPI.SetText(txt_index,tostring(this.data.desc));
        SetSelect(this.data.isSelect);
    else
        LogError("初始化已选择队伍时数据不能为Nil");
    end
end

function SetSelect(isSelect)
    if this.data then
        this.data.isSelect=isSelect;
    end
    if isSelect==nil then
        isSelect=false;
    end
    local color=isSelect and {255,196,50,255} or {255,255,255,122}
    CSAPI.SetTextColor(txt_index,color[1],color[2],color[3],color[4]);
    CSAPI.SetTextColor(txt_desc,color[1],color[2],color[3],color[4]);
    if isSelect then
        CSAPI.LoadImg(img,"UIs/TeamConfirm/btn_02_02.png",false,nil,true);
    else
        CSAPI.LoadImg(img,"UIs/TeamConfirm/btn_02_01.png",false,nil,true);
    end
    -- CSAPI.SetGOActive(selectImg,isSelect);
end

-- function SetLine(isShow) 
--     CSAPI.SetGOActive(img,isShow);
-- end

function SetClickFunc(func)
    this.clickFunc=func;
end

function OnClickSelf()
    if this.clickFunc then
        this.clickFunc(this);
    end
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
txt_index=nil;
txt_desc=nil;
view=nil;
end
----#End#----