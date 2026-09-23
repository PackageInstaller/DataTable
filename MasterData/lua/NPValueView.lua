function Awake()
    txtValue = ComUtil.GetCom(text,"Text");
end

function SetValue(value)
    --txtValue = txtValue or ComUtil.GetCom(text,"Text");
    if(txtValue)then
        txtValue.text = (value > 0 and "+" or "") .. value ;

        local iconName = value > 0 and "up" or "down";
        --ResUtil.IconBuff:Load(icon,iconName);
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
icon=nil;
text=nil;
view=nil;
end
----#End#----