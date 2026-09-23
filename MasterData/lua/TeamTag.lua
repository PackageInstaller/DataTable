local teamData=nil;
local index=0;
function Init(_index)
    index=_index;
    ResUtil.TeamIcon:Load(img,tostring(index),true);
end

function SetSelect(isSelect)
    local scale=isSelect and 0.7 or 0.4;
    CSAPI.SetScale(img,scale,scale,scale);
    CSAPI.SetRectSize(gameObject,scale*180,scale*154);
    if isSelect then
        CSAPI.SetImgColor(img,255,255,255,255);
        CSAPI.SetAnchor(img,(index-1)*-5,20,0);
    else
        CSAPI.SetImgColor(img,255,255,255,122);
        CSAPI.SetAnchor(img,(index-1)*-5,0,0);
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
img=nil;
view=nil;
end
----#End#----