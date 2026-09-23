--角色飘字

function Awake()   
    txtContent = ComUtil.GetCom(text,"Text");  
    if(textSize)then 
        txtSizeContent = ComUtil.GetCom(textSize,"Text");  
    end 
end

function Set(data)    
    SetValue(data.value,data.color);
    --SetGoodHit(data.goodHit);
    CSAPI.AddUISceneElement(gameObject,data.go);

end


function SetValue(value,color)
    local str = tostring(value);
    --color = "FF6719";
    --color = "F753FF";
    if(color)then
        str = string.format("<color=#%s>%s</color>",color,str);
    end

    if(txtSizeContent)then
        txtSizeContent.text = tostring(value);
    end
    txtContent.text = str;
end

function SetGoodHit(isGoodHit)
--    if(goodHit ~= nil)then
--        CSAPI.SetGOActive(goodHit,isGoodHit);
--    end
end