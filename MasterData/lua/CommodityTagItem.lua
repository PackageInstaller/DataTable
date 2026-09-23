local animator=nil;
function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator");
end

function OnDestroy()
    animator=nil
end

function Refresh(_d,_elseData)
    if _d then
        CSAPI.LoadImg(gameObject,"UIs/ShopComm/".._d.img..".png",true,nil,true);
        CSAPI.LoadImg(tagIcon,"UIs/ShopComm/".._d.icon2..".png",true,nil,true);
        CSAPI.SetImgColorByCode(gameObject,_d.color);
        CSAPI.SetText(txtTag,_d.tips);
        if _elseData then
            ShopCommFunc.PlayAnimation(animator,"entry",0,10,function()
                ShopCommFunc.PlayAnimation(animator,"entry",0)
            end);
        else
            ShopCommFunc.PlayAnimation(animator,"default",0);
        end
    end
end