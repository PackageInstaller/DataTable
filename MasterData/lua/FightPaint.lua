
--设置立绘

-- function SetImg(imgName)
--     if(imgName)then
--         CSAPI.SetGOActive(img,true);
--         ResUtil.ImgCharacter:Load(img,imgName);
--     else
--         CSAPI.SetGOActive(img,false);
--     end
-- end


function SetImg(id)
    if(id)then
        CSAPI.SetGOActive(img,true);
        CSAPI.SetScale(img,0,0,0);
        RoleTool.LoadImg(img,id,LoadImgType.Main,OnLoadComplete); --todo 位置可能不对
    else
        CSAPI.SetGOActive(img,false);
    end
end

function OnLoadComplete()
    CSAPI.SetScale(img,1,1,1);
end

function SetShowState(state)
    if(not state)then
        SetImg(nil);
    end
    CSAPI.SetGOActive(gameObject,state);    
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
end
----#End#----