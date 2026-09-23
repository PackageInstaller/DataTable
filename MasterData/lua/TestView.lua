function Awake()
   viewCommon = oo.class(ViewCommonBase);
   viewCommon:Init(this);
   DoInAction();
end

function DoInAction()
    viewCommon:InPart(1,300);
    viewCommon:InPart(2,100);
    viewCommon:InPart(3,500);
end


function DoOutAction()
    viewCommon:OutPart(1,300);
    viewCommon:OutPart(2,500);
    viewCommon:OutPart(3,0);
end


function Update() 

    if(CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.A))then     
        DoInAction();
    end
     if(CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.S))then     
        DoOutAction();
    end
end


function OnClickBack()
    if(isClose)then
        return;
    end
    isClose = true;
    DoOutAction();

    viewCommon:Close(1000);
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
in1=nil;
inNode1=nil;
part1=nil;
out1=nil;
outNode1=nil;
in2=nil;
inNode2=nil;
part2=nil;
out2=nil;
outNode2=nil;
in3=nil;
inNode3=nil;
part3=nil;
out3=nil;
outNode3=nil;
back=nil;
view=nil;
end
----#End#----