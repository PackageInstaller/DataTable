--变身界面

function Awake()
    
end

function Set(targetData,callBack)    
    data = targetData;
    clickCallBack = callBack;
  
    local go,goodsItem=ResUtil:CreateGridItem(goodsNode.transform);
    local characterGoodsData = CharacterGoodsData(data);   
    goodsItem.Refresh(characterGoodsData);
    goodsItem.SetClickCB(OnClick);
    goodsItem.SetCount();
    goodsItem.SetName();    
end

function OnClick()
    if(clickCallBack)then
        clickCallBack(data);
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
goodsNode=nil;
view=nil;
end
----#End#----