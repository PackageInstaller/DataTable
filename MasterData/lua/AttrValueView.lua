
function SetData(cfg)    
    if(txtValue == nil)then
        txtValue = ComUtil.GetCom(text,"TextMesh");
        if(txtValue == nil)then
            return;
        end
    end

    txtValue.text = cfg.show .. "";

    CSAPI.SetGOActive(icon,cfg.icon ~= nil);
    if(StringUtil:IsEmpty(cfg.icon) == false)then
        ResUtil.IconBuff:LoadSR(icon,cfg.icon);
    end

    --设置翻转
    if(FightClient:IsFlip())then
        FuncUtil:Call(Flip,nil,10);       
    end
end

function Flip()
    CSAPI.SetScale(gameObject,-1,1,1);  
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
end
----#End#----