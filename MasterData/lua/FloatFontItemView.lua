--角色飘字

function Awake()   
    if(text)then
        txtContent = ComUtil.GetCom(text,"Text");   
    end
end

function Set(data)
--    LogError("飘字对象==")
--    LogError(data)
    if(not data)then
        return;
    end
    
    if(not IsNil(data.go))then
        CSAPI.AddUISceneElement(gameObject,data.go);
    end
    if(data.key)then
        local cfg = Cfgs.FloatFont:GetByKey(data.key);
        if(cfg ~= nil and cfg.show)then          
            local valueStr = data.value and ( (data.value > 0 and "+" or "") .. data.value) or "";
            SetContent(cfg.show .. valueStr);

            local iconName = cfg.icon;
            --LogError(iconName);
            if(StringUtil:IsEmpty(iconName))then
                if(data.value)then
                    iconName = data.value > 0 and "up" or "down";
                end
            end

            CSAPI.SetGOActive(icon,iconName ~= nil);
            if(not StringUtil:IsEmpty(iconName))then
                ResUtil.IconBuff:Load(icon,iconName);
            end
        else
            LogError("请移除飘字或添加具体内容：" .. tostring(data.key));
        end
    else
        SetContent(data.content or "");
    end
end

function SetContent(content)
    if(txtContent)then
        txtContent.text = content;
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