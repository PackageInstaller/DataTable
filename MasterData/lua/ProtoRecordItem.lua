
function Set(itemData)
    data = itemData;
    local text =  data.title or (data.proto[1] and tostring(data.proto[1])) or "�ޱ���";

    CSAPI.SetText(Text,data.time .. " " .. text);
    if(data.action)then
        CSAPI.SetImgColor(Button, 160, 255, 160,255);
    end    
end
function SetClickCallBack(OnClickItem)
    callBack = OnClickItem;
end

function OnClickItem(data)
    local str = table.tostring(data);
    CSAPI.SetText(Text,str);
end


function OnClick()
    callBack(data);
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
Button=nil;
Text=nil;
view=nil;
end
----#End#----